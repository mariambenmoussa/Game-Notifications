# Game-Notifications
Game Day Notification solution utilizing AWS serverless services.  

This project is about building, using terraform, an alert system that sends real-time NBA game day score notifications to subscribed users via SMS/Email.   
## Project Overview
This project leverages multiple AWS services: 
- Amazon SNS
- AWS Lambda (Python) 
- AWS Eventbridge 
- AWS IAM
NBA API is used to provide users with up-to-date game information (sportsdata.io API) 

## Features 
1) Fetching real-time NBA data using the API.  
2) Sending human readalbe score update to subscribers via SMS/Email using Amazon SNS.  
3) Scheduling automation for regular updates using Amazon EventBride. 

## Architecture 

![alt text](image.png)


## Deployment instructions

For security reasons and to protect sensitive data, some variables used on terraform are initiated in the CLI command (email@ for the SNS subscription, aws account ID, NBA API key)  
Run the following commands:  

```
git clone https://github.com/mariambenmoussa/Game-Notifications.git
cd Game-Notifications/terraform/  
terraform init  
terraform plan -var "myemail=your_email_address" -var "awsaccountid=your_aws_account_id" -var "NBA_API_KEY=your_nba_api_key"  
terraform apply -var "myemail=your_email_address" -var "awsaccountid=your_aws_account_id" -var "NBA_API_KEY=your_nba_api_key"  
```