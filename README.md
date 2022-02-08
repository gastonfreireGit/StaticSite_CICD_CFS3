![image](https://user-images.githubusercontent.com/97241135/153005531-facb2c14-ec04-4241-a8da-6134e090205c.png)



<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a>About The Project</a>
    </li>
    <li>
      <a>Getting Started</a>
      <ul>
        <li><a>Prerequisites</a></li>
      </ul>
    </li>
    <li><a>IaC Implementation</a></li>
    <li><a>Static Site Implementation</a></li>
    <li><a>After Implementation</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

With this new implementation, it will be possible to make the change or update of the Static Site automatically when the development team does it in the GitHub repository and impacted in the S3 bucket.

Thus, in this way, optimize go to market times, freeing up teams to focus on generating value and
not wasting time performing manual tasks

![Web App Reference Architecture](https://user-images.githubusercontent.com/97241135/153011208-df2ce5df-44af-4800-b583-182c8c61bc78.png)


<!-- Prerequisites -->
## Prerequisites

Required Libraries:
* [AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) with Secret key configured
* [GitHub client](https://git-scm.com/downloads)
* [Terraform](https://www.terraform.io/downloads)

Required AWS configuration:
* AWS S3 Bucket Backend
* Origin Access Identity
* GitHub Connection 


### AWS S3 Bucket Backend:

This bucket is necesary to store the status of the infrastructure deployed using Terraform (terraform.tfstate). In case you need to lock the satus of this file to work with a team, we need to implement a DynamoDB to lock it.

To create this bucket follow these steps:

→ In Aws Console > search S3 > in left section select Buckets > Create Bucket > Specify the Name > click on “Create Bucket”
→ In each environment  in terraform file (Dev, Test and Prod) place the name of the bucket in the value of "bucket“ in main.tf file, line 3.


### Origin Access Identity
To restrict access to content that you serve from Amazon S3 buckets we need to create an OAI, to do this follow these steps:

→ In Aws Console > search CloudFront service > in left panel click on Origin Access Identity > click on “Create origin access identity” > Enter a name > click on “Create”
→ Copy the ID column value (e.g.: E26RWMOJBFTRWY) and past it into “id” value in “modules > cf-modules > cloudfront.tf” line 3 in terraform file.

### GitHub Connection 
To connect to GitHub we will need a connection before implement IaC, to do this follow these steps:

→ In Aws Console > search CodePipeline service > in left panel click on Connections, under Settings section > click on “Create connection” > Select GitHub > enter Connection Name > click on “Connect to GitHub > click on “Install a New app” > log in to GitHub > click on “Connect”
→ Copy ARN column value in folder Modules > cp-module > codepipeline.tf > ConnectionArn value, line 25 in terraform file.


<!-- IaC Implementation -->
## Infrastructure as Code (IaC) Implementation

Once you have the prerequisites installed, in terminal console, run these commands:

1. Clone the repo
   ```
   Git clone https://github.com/gastonfreire3XM/StaticSite_CICD_CFS3
   ```
2. In “iac-code”  branch you will see this folder structure: 

![image](https://user-images.githubusercontent.com/97241135/153013221-f945fa61-d2c9-4fb6-9d42-8992ba26de16.png)

If you need to implement one of these environment **Dev, Test or Production,** you need to position yourself in one of these folders, for this example, we will use *“dev”*. 

In terminal console exec this commands:

1. 
   ```
   cd .\environments\dev
   ```
2. 
   ```
   terraform init
   ```
3. 
    ```
    terraform plan
    ```
 4. 
    ```
    terraform apply -auto-approve   
 *In case you need to destroy the Infrastructure:*


 ```
terraform destroy
 ```


  <!-- Static Site Implementation -->
## Static Site Implementation


As an output value after “terraform apply” command, you will see the CloudFront URL to access to the Static Site (e.g.: https://d3oe147kj.cloudfront.net/ ).

To change the Static Site page, follow one of these steps:

### Using GitHub terminal:

You will see three different branches, **Main** (Production), **static-site-test** (test) and **static-site-dev** (dev). For this example, we will use “static-site-dev” branch, here you can modify the *index.html* file and then in terminal console: 
  
```sh
Git add index.html
Git commit –m ‘a comment here’
Git push
   ```
It will be triggered by AWS CodePipeline and it’ll update the site for Dev environment

### Using GitHub Web:

Login to:
```
https://github.com/gastonfreire3XM/StaticSite_CICD_CFS3
   ```  
You will see three different branches, **Main** (Production), **static-site-test** (test) and **static-site-dev** (dev).

![image](https://user-images.githubusercontent.com/97241135/153016454-297288d4-25f5-4efc-8ec3-97d7ca7385c6.png)

For this example, we will use **“static-site-dev”** branch. Select the branch and then you can change and push it there the *index.html* file selecting “Edit this file” button ![image](https://user-images.githubusercontent.com/97241135/153016593-cc20a0e1-93ef-4782-8149-a7d140258399.png)



<!-- After Implementation -->
## After Implementation

To verify the status of the implementation you can go to AWS Console and check the status of the following services:

- _AWS CodePipeline_

- _AWS S3_

- _AWS CloudFront_

______________________________________________________________________________________________________________
**AWS CodePipeline:**
![image](https://user-images.githubusercontent.com/97241135/153017988-ef479dc3-3f48-404e-827f-61a3d79ad044.png)

**AWS S3:**
![image](https://user-images.githubusercontent.com/97241135/153018031-ebfbeb4f-e872-4b0d-aa11-f4feba9e3e3a.png)

**AWS CloudFront:**
![image](https://user-images.githubusercontent.com/97241135/153018069-937bcc4c-92de-4f8b-a394-4d23a6305fd3.png)
