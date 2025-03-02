import json
import boto3
import os

def lambda_handler(event, context):
    try:
        # Extract the API key from query parameters
        query_params = event.get('queryStringParameters', {}) or {}
        api_key_from_query = query_params.get('apikey') or query_params.get('api_key')
        
        if not api_key_from_query:
            return generate_policy('user', 'Deny', event['methodArn'])
        
        # Validate the API key using AWS API Gateway service
        apigateway = boto3.client('apigateway')
        
        try:
            # This will throw an exception if the key doesn't exist
            apigateway.get_api_key(
                apiKey=api_key_from_query,
                includeValue=False
            )
            
            # If we get here, the key is valid
            return generate_policy('user', 'Allow', event['methodArn'])
        except Exception as e:
            print(f'Invalid API Key: {str(e)}')
            return generate_policy('user', 'Deny', event['methodArn'])
            
    except Exception as e:
        print(f'Error: {str(e)}')
        return generate_policy('user', 'Deny', event['methodArn'])

def generate_policy(principal_id, effect, resource):
    auth_response = {
        'principalId': principal_id
    }
    
    if effect and resource:
        policy_document = {
            'Version': '2012-10-17',
            'Statement': [
                {
                    'Action': 'execute-api:Invoke',
                    'Effect': effect,
                    'Resource': resource
                }
            ]
        }
        auth_response['policyDocument'] = policy_document
    
    return auth_response