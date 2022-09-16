## BigQuery Demo

### Prerequisite Application

In order to reuse this project you need to install the below listed.

- gcloud sdk [https://cloud.google.com/sdk/docs/install]
- terraform [https://www.terraform.io/downloads]
- python [https://packaging.python.org/en/latest/tutorials/installing-packages/]
- jq [https://formulae.brew.sh/formula/jq]
- cut

### Solutions

This the solution of the Take Home Challenge. The challenge is composed of 2 parts.

    - Design Challenge
    - Coding Challenge

For the solution of the Design Challenge please refer to the pdf file named *Astrafy Design Challenge.pdf*. And for the solution of the Coding Challenge please follow the below steps post cloning the repo.

#### Coding Challenge Solution

Before creating a GCP project using terraform, you need to have some information ready beforehand. Make sure you have all the below mentioned information listed below.

    - GCP Console credentials
    - Billing Account

#### Authentication using gcloud

1. Please use the below cmd to authenticate your GCP account in the terminal. Once you have completed the authentication, terraform fetches the credentials from the cache.

    ```bash
    gcloud auth application-default login
    ```

2. Once you have authenticated your account, please proceed to fetch billing Account of your GCP account thet you need to provide during ```terraform apply```. You can fetch the billing account by running the below command in your terminal.

    ```gcloud beta billing accounts list --filter=open=true  --format=json | jq '[.[]][0].name' -r | cut -d'/' -f2```              

    If you have multiple billing accounts, you might needed to change the second part of the command ```jq '[.[]][0].name' -r```. Keep note of the billing account.

3. Now change the directory to terraform folder using command ```cd terraform``` and use the below command to create the Google project.

    ```terraform apply```

    This will create a GCP project named `Astrafy Demo` with your GCP account and 2 API's enabled for the BigQuery to run scheduled queries.

4. During terraform apply, please provide the billing account which will be linked to the gcp account named ```Astrafy Demo```.

5. Once the project is created, now run the sql queries mentioned in the *Queries.sql* in the BigQuery query editor. After the queries are successfully executed you should see 2 tables created by name `astrafydemo.bitcoincash.staging` and `astrafydemo.bitcoincash.datamart`.

6. Now you can run the *Astrafy_plot.ipynb* file in google colab and you should see the plot of number of transaction vs date plot once you executed all the code cells.
