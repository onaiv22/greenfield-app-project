#!/usr/bin/env python
import json
import boto3
import os
import requests
selectedEnvironment = ""

def get_environment():
    input_variable = "dev"
    selectedEnvironment = ""
    if input_variable == "dev":
        selectedEnvironment = "goal-dev"
    elif input_variable == "test":
        selectedEnvironment = "goal-dev"
    elif input_variable == "uat":
        selectedEnvironment = "goal-dev"
    elif input_variable == "staging":
        selectedEnvironment = "goal-prod"
    elif input_variable == "prod":
        selectedEnvironment = "goal-prod"
    else:
        print("Selected environment doesnt exist")
    return (selectedEnvironment)

# create varaible in octopus for alb name. the get_loadbalancerArn queries the aws account and gets a list of
# albs and then retrieves the loadBalancerArn of the alb created in octopus
def get_loadbalancerArn(loadbalancers_list):
    reference_value = input("please enter the ALB name: ") #"adr-dt-shr-alb-if-webconsoles-0" 
    for lb in loadbalancers_list['LoadBalancers']:
        exists = reference_value in lb['LoadBalancerName']
        if exists:
            loadbalancerArn = lb['LoadBalancerArn']
    return loadbalancerArn

#the get_listenerArn uses  the loadbalancerArn from above to retrieve the listenerArn 
def get_listenerArn(listeners):
    loadbalancerArn = ""
    for lsn in listeners['Listeners']:
        exists = loadbalancerArn in lsn['LoadBalancerArn']
        if exists:
            listenerArn = lsn['ListenerArn']
    return listenerArn

def get_rulearn(rules):
    ref_value = input("please enter the host_header name: ") #"www-d0.goalgrouptest.com"
    for rule in rules['Rules']:
        for condition in rule['Conditions']:
            exists = ref_value in condition['Values']
            if exists:
                ruleArn = rule['RuleArn']
                return (ruleArn, ref_value)

def get_targetgrouparn(targetGroups):
    target_reference_value = input("please enter the targetGroupName name: ") #"adr-d0-ltg-wfe-p80-0"
    targetGroupArn = [x for x in targetGroups if x["TargetGroupName"] == target_reference_value][0]['TargetGroupArn'] 
    return targetGroupArn

def switch_on_maintenance_page():
    selectedEnvironment = get_environment()
    session = boto3.session.Session(profile_name=selectedEnvironment)
    client = session.client('elbv2')
    loadbalancers_list = client.describe_load_balancers()
    loadbalancerArn = get_loadbalancerArn(loadbalancers_list)
    listeners = client.describe_listeners(LoadBalancerArn=loadbalancerArn)
    for lsn in listeners['Listeners']:
        exists = loadbalancerArn in lsn['LoadBalancerArn']
        if exists:
            listenerArn = lsn['ListenerArn']
    rules = client.describe_rules(ListenerArn=listenerArn) 
    ruleArn, ref_value = get_rulearn(rules)
    targetGroups = client.describe_target_groups()['TargetGroups']
    targetGroupArn = get_targetgrouparn(targetGroups)
    response = client.modify_rule(RuleArn=ruleArn, Conditions=[{'Field': 'host-header', 'Values': [ ref_value, ], }, ], Actions=[
        {"Type": "redirect", "RedirectConfig": {"Protocol": "HTTPS", "Port": "443", "Host": "maintenance.np-goalgroup.com", "Path": "/", "StatusCode": "HTTP_302"}}])

def switch_off_maintenance_page():
    selectedEnvironment = get_environment()
    session = boto3.session.Session(profile_name=selectedEnvironment)
    client = session.client('elbv2')
    ref_value = "www-d0.goalgrouptest.com" 
    loadbalancers_list = client.describe_load_balancers()
    loadbalancerArn = get_loadbalancerArn(loadbalancers_list)
    listeners = client.describe_listeners(LoadBalancerArn=loadbalancerArn)
    for lsn in listeners['Listeners']:
        exists = loadbalancerArn in lsn['LoadBalancerArn']
        if exists:
            listenerArn = lsn['ListenerArn']
    rules = client.describe_rules(ListenerArn=listenerArn) 
    ruleArn, ref_value = get_rulearn(rules)
    tagrgetGroupList = client.describe_target_groups()['TargetGroups']
    targetGroupArn = get_targetgrouparn(tagrgetGroupList)    
    response = client.modify_rule(RuleArn=ruleArn, Conditions=[{'Field': 'host-header', 'Values': [ ref_value, ], }, ], Actions=[{"Type": "forward", "TargetGroupArn" : targetGroupArn}])
    print("Maintenance page successfully Turned off")

def maintenance_switch():    #this curls the endpoint and based on the response header it calls a switch.
    reference_value = "www-d0.goalgrouptest.com" #get_octopusvariable("Reference.Value") #"www-d0.goalgrouptest.com"
    schema = "https://"
    url = schema + reference_value
    page_request = requests.get(url, allow_redirects=False)
    get_header = page_request.headers['Location']
    if "maintenance" not in get_header:
        switch_on_maintenance_page()
    else:
       switch_off_maintenance_page()          



call = maintenance_switch()




