# azure_dsvm_tf

I created this to deploy resources in my personal account for studying for the
Microsoft Azure DP-200 certification. The requirement that finally drove me to
create this was the need for things on Windows, like the Cosmos DB Data Migration
Tool. That tool will not run on Mac.

There is the Bulk Extractor tool that will run in a JVM, but I had some issues
with it and began to grow frustrated with the effort expended tangentially to
my goal of studying for the DP-200. I am hoping this terraform deployment will
help in the long run though it required a good bit of front work. It was a good
bit of work on the front end though.

There's a bit of a chicken and egg thing going on. First the storage account
needs to be created and then the remote state can be deployed. The home IPs
must be put in manually, then created as a secret and added in code.

The steps for use:
1. Modify variable names in the <environment-name>main.tf files.
2. Before the first apply, change the backend.tf filename to backend.tf.bak.
3. Perform a terraform apply with only permanent_infra in use in
dsvm_networking_main.tf. Be sure to supply your IP address manually in the key
 vault and storage account firewalls. Supply valid names for variables.
4. With the SA and Key Vault in place, change backend.tf.bak back to backend.tf.
5. Perform a terraform init to copy the local state to the remote.
6. Provide VM variable values in dsvm_networking_main.tf.
7. perform terraform init and then apply.

Note - I was not able to use the az login for terraform with the version pinned.
I had used it previously. I am currently adding environment variables until I
find a better way.

The key vault module will be need to be applied before other modules that need it.

My intent is to leave key vault in place, and tear down the VNet infra and VM
when not in use.

Future infra or services may or may not need the VNet, they will be added in
personal_infra and modules, integrated with VNet if required, with no vnet
otherwise.

The tenant_id, object_ids pulled from az cli with the following:
```
data "azurerm_client_config" "current" {}
  ```

### Key vault
The key vault gets created with the terraform service principal having access
only. I manually added an account for access and manually turned on the private
endpoints firewall setting. Subsequent applies did not remove the access or
change the firewall settings. If it did I would remove the key vault from this
deployment and create it by hand and call it as data.
