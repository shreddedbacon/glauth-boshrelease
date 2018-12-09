# GLAuth BOSH Release
A release that sets up GLAuth for simple directory services testing and integration

Find out about GLAuth [here](https://github.com/glauth/glauth)

As the configuration for all users and groups is stored as code, you can scale this out to multiple servers easily behind a loadbalancer.

Adding users is relatively painless, just add a new block to the users operations file, same for groups.

Perfect for setting up a quick LDAP service for testing applications that use it.

## Deploy GLAuth
### With TLS
Deploy GLAuth with TLS enabled on the LDAP and API
```
bosh -d glauth deploy manifests/glauth.yml \
  -o manifests/operations/authconfig-with-tls.yml \
  -o manifests/operations/users.yml \
  -o manifests/operations/groups.yml
```
### Without TLS
If you like to live dangerously, go without.
```
bosh -d glauth deploy manifests/glauth.yml \
  -o manifests/operations/authconfig.yml \
  -o manifests/operations/users.yml \
  -o manifests/operations/groups.yml
```

## Usage
### Auth config
See `manifests/operations/authconfig.yml` for setting up the frontend(LDAP/DS), backend(config or LDAP), and the API service

### Add or remove users
See `manifests/operations/users.yml` for the format of users, use [GLAuth sample-simple.cfg](https://github.com/glauth/glauth/blob/master/sample-simple.cfg) for options

### Add or remove groups
See `manifests/operations/groups.yml` for the format of users, use [GLAuth sample-simple.cfg](https://github.com/glauth/glauth/blob/master/sample-simple.cfg) for options


## Test LDAP
If you role with the operations contained within this repository, you can run the following to see if you get a result
```
#ignore certificate warning
LDAPTLS_REQCERT=never ldapsearch -LLL -H ldaps://<ip-or-hostname>:636 \
  -D cn=user1,ou=superheros,dc=glauth,dc=com \
  -w dogood -x \
  -b dc=glauth,dc=com \
  -s sub "(&(memberOf=cn=superheros,ou=groups,dc=glauth,dc=com))"
```
