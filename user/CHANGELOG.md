## 0.7.0 / 2017-02-20

### Improvements

* Support providing an `ssh_keypair` attribute` to the `user_account` LWRP; this allows you to deploy the user's key using Chef ([@chr4][])
* Remove cases where we were cloning resources to remove the relevant deprecation warnings ([@chasebolt][])

## 0.6.0 / 2016-11-19

### Improvements

* changes to remove Chef 13 deprecation warnings by [@jeunito][]:
  * use `node['platform']` instead of `platform`
  * use `manage_home` and `non_unqiue` `attributes for the `user` LWRP instead of the `supports` Hash

## 0.5.1 / 2016-11-04

### Bug Fixes

* Fix incorrect `source_url` value in the `metadata.rb`  file

## 0.5.0 / 2016-11-04

### Bug Fixes

* Fix an error in the LWRP when a --why-run invocation is invoked before the user has been created (PR #89 by [@theckman][])

### Improvements

* Add a groups resource to the LWRP to allow the user to be added to additional groups upon creation (PR #96 by [@acqant][])
* Add issues_url and source_url to the metadata file
* Fix tests and dependencies to work with Ruby 2.1.4 (version shipped with Chef 12.1.0)


## 0.3.0 - 0.4.2 (Proper Release Hiatus)
While there were version bumps of the `metadata.rb` file during this period, there were
no official releases. The changes weren't clearly documented. We should go back and fill
in the information about the changes in this period.

## 0.3.0 / 2012-07-24

### Improvements

* Rename data_bag attribute to data_bag_name which works with bag_config cookbook. ([@fnichol][])


## 0.2.15 / 2012-07-24

### Improvements

* Add :user_array_node_attr attribute which can override the location of the users' array in your node's attribute hash. ([@fnichol][])


## 0.2.14 / 2012-07-24

### Improvements

* Pull request [#11][], Issue [#10][]: Groups management (not only gid). ([@smaftoul][])


## 0.2.12 / 2012-05-01

### Bug fixes

* user_account LWRP now notifies when updated (FC017). ([@fnichol][])
* Add plaform equivalents in default attrs (FC024). ([@fnichol][])

### Improvements

* Add unit testing for user_account resource. ([@fnichol][])
* Add unit testing for attributes. ([@fnichol][])
* Add TravisCI to run test suite and Foodcritic linter. ([@fnichol][])
* Reorganize README with section links. ([@fnichol][])
* Pull request [#7][]: Fix semantic issues in README. ([@nathenharvey][])


## 0.2.10 / 2012-01-20

### Bug fixes

* Pull request [#6][]: Fix ordering of user deletion in :remove action. ([@nessche][])

### Improvements

* Issue [#4][]: Support Ruby 1.8.6 (no #end_with?). ([@fnichol][])
* Issue [#3][]: Mention dependency on ruby-shadow if managing password. ([@fnichol][])
* Issue [#5][]: Clarify iteration through node['users'] in recipe[user::data_bag]. ([@fnichol][])


## 0.2.8 / 2012-01-20

### Improvements

* Handle user names with periods in them. ([@fnichol][])


## 0.2.6 / 2011-10-18

### Improvements

* Data bag item attribute `username` can override `id` for users with illegal data bag characters. ([@fnichol])


## 0.2.4 / 2011-09-19

### Bug fixes

* Fix data bag missing error message. ([@fnichol][])


## 0.2.2 / 2011-09-14

### Bug fixes

* Issue [#2][]: user_account resource should accept String or Integer for uid attribute. ([@fnichol][])
* Add home and shell defaults for SuSE. ([@fnichol][])

### Improvements

* Add installation instructions to README. ([@fnichol][])
* Add fallback default `home_root` attribute value of "/home". ([@fnichol][])


## 0.2.0 / 2011-08-12

The initial release.

<!--- The following link definition list is generated by PimpMyChangelog --->
[#2]: https://github.com/fnichol/chef-user/issues/2
[#3]: https://github.com/fnichol/chef-user/issues/3
[#4]: https://github.com/fnichol/chef-user/issues/4
[#5]: https://github.com/fnichol/chef-user/issues/5
[#6]: https://github.com/fnichol/chef-user/issues/6
[#7]: https://github.com/fnichol/chef-user/issues/7
[#10]: https://github.com/fnichol/chef-user/issues/10
[#11]: https://github.com/fnichol/chef-user/issues/11
[@fnichol]: https://github.com/fnichol
[@nathenharvey]: https://github.com/nathenharvey
[@nessche]: https://github.com/nessche
[@smaftoul]: https://github.com/smaftoul
