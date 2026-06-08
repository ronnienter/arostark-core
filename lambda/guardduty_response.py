import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    logger.info(f"GuardDuty finding received: {json.dumps(event)}")
    
    finding = event.get("detail", {})
    severity = finding.get("severity", 0)
    finding_type = finding.get("type", "Unknown")
    account_id = finding.get("accountId", "Unknown")
    region = finding.get("region", "Unknown")
    
    message = f"""
    SECURITY ALERT - Arostark-Core
    
    Finding Type: {finding_type}
    Severity: {severity}
    Account: {account_id}
    Region: {region}
    
    Immediate review required.
    """
    
    if severity >= 7:
        sns = boto3.client("sns")
        sns.publish(
            TopicArn=f"arn:aws:sns:{region}:{account_id}:arostark-core-security-alerts",
            Subject="HIGH SEVERITY - GuardDuty Alert",
            Message=message
        )
        logger.info("High severity alert sent via SNS")
    
    return {"statusCode": 200, "body": "Finding processed"}