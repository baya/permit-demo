# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{name: 'user0'},
                     {name: 'user1'},
                     {name: 'admin0'},
                     {name: 'admin1'}
                    ])


permissions = Permission.create([{name: 'login_admin'},
                                 {name: 'create_post'},
                                 {name: 'edit_post'},
                                 {name: 'crud_users'},
                                 {name: 'crud_posts'}
                                ])
