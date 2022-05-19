# angular-dotnet-example
Example Angular app with dotnet as a backend to be deployed in a container to Red Hat OpenShift.

## Requirements
- Install Docker Desktop

## Deploying the Angular app to OpenShift

1. Open up a terminal and go to the **angular-dotnet-example** folder
2. Build the Docker image with the tag pointed to your private Github package repo
```
docker build -t ghcr.io/<github-account>/angular-dotnet-ubi8-50:latest .
```
3. Push the image to your private GitHub package repo:
```
docker push ghcr.io/<github-account>/angular-dotnet-ubi8-50
```
NOTE: by default, this image will be **private**.
4.  For OpenShift to acces the image, you will need to create a Github personal access token .  
    a. Go to your GitHub Profile settings, and select **Developer Settings**
    b. Select Personal Access Token and press **Generate New Access Token**
    c. Give description name like "For Package Management"
    d. Give the token **Write:packages** and **Delete:packages** privileges
    e. Click **Generate Token**
        NOTE: will generate a key, you will need this in a later step in Openshift.
5. In a new browser window, log into OpenShift
6. Under the Developer menu, click the **+Add** menu. Verify that you are under the correct **Project** before going to the next step.
7. Click the **Container images** button/panel.
8. Select the **Image name from external registy** and populate the path from step 3: "ghcr.io/<github-account>/angular-dotnet-ubi8-50"
9. If the status under the "Verified" proceed to step 11.
10. If Redhat cannot access the registry, you will need to create a secret.  In the prompt, put Github account name, in the password put the Generated token in step 4e.
11. Application should be set to "angular-dotnet-example". Change **Name** to "angular-dotnet-ubi8-50"
12. Change the **Icon** to Angular
13. Set **Port** to 5000
14. Keep all the default settings and click **Create**

The pod should come up and the Angular example should be accessible very soon.
