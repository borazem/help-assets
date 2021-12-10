example AD structure

```
OU: My Domain Users
	user: cda
	user: ocp-sa
	OU: Admins
		user: admin1
		user: admin2
		user: admin3
		group: ocp-nested   (member: admin3)
		group: ocp-admins  (member: admin1, later added admin2, ocp-nested)
	OU: Users
		user: user1
		user: user2
		user: user3  (disabled)
		group: opc-users  (member: user1)
![image](https://user-images.githubusercontent.com/32193129/145583883-49c04507-2d2b-468b-ab64-ae53b1083fbd.png)
```

Configuration of OAuth could be:

```
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
    - ldap:
        attributes:
          email:
            - mail
          id:
            - userPrincipalName
          name:
            - userPrincipalName
          preferredUsername:
            - sAMAccountName
        bindDN: ocp-sa
        bindPassword:
          name: ldap-bind-password-qwfj8
        insecure: true
        url: >-
          ldap://w2019.ad.benoibm.com:389/DC=ad,DC=benoibm,DC=com?sAMAccountName?sub?(&(objectClass=user)(|(memberOf:1.2.840.113556.1.4.1941:=CN=ocp-users,OU=Users,OU=My
          Domain
          Users,DC=ad,DC=benoibm,DC=com)(memberOf:1.2.840.113556.1.4.1941:=CN=ocp-admins,OU=Admins,OU=My
          Domain Users,DC=ad,DC=benoibm,DC=com)))
      mappingMethod: claim
      name: ActiveDirectory
      type: LDAP
```



the configuration of group synchronization could further be like the one shown below.
create the file ldap-sync.yaml and paste the content to the file

```
kind: LDAPSyncConfig
apiVersion: v1
url: ldap://w2019.ad.benoibm.com:389
bindDN: "cn=ocp-sa,ou=My Domain Users,dc=ad,dc=benoibm,dc=com"
bindPassword: ICPassw0rd# 
insecure: true 
groupUIDNameMapping:
  "cn=ocp-admins,ou=Admins,ou=My Domain Users,dc=ad,dc=benoibm,dc=com": openshift-admins
  "cn=ocp-users,ou=Users,ou=My Domain Users,dc=ad,dc=benoibm,dc=com": openshift-users
augmentedActiveDirectory:
    groupsQuery:
        derefAliases: never
        pageSize: 0
    groupUIDAttribute: dn 
    groupNameAttributes: [ cn ] 
    usersQuery:
        baseDN: "ou=My Domain Users,dc=ad,dc=benoibm,dc=com"
        scope: sub
        derefAliases: never
        filter: (objectclass=person)
        pageSize: 0
    userNameAttributes: [ sAMAccountName ] 
    groupMembershipAttributes: [ "memberOf:1.2.840.113556.1.4.1941:" ]
```


