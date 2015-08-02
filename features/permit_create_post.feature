# language: zh-CN
功能: permit create post

  背景:
    假设我是:
    | name  |
    | user0 |

  场景: 有 create post 的权限，创建 post 成功
    假设我有"create_post"权限
    当我创建 post
    那么创建 post 成功
    
