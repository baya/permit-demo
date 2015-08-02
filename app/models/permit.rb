class Permit < BasicObject

  def self.permission_mapper
    # 默认情况下如果实例能够响应与权限同名的方法，就表示用户拥有此权限
    default_m = ::Hash.new(->{true})

    # 有些权限需要增加特定的参数和逻辑
    custome_m = {
      edit_post: ->(post){ post.user_id == @user.id}
    }

    default_m.merge(custome_m)
  end

  def initialize(user)
    # 权限的实际拥有者
    @user = user
    
    # 没有使用常量去存储权限映射，是为了防止权限映射在程序员不知情的情况下被修改
    @permission_mapper = ::Permit.permission_mapper

    # 用于存储和权限同名方法的容器
    @permission_mod = ::Module.new

    load_permissions
  end

  def can?(name, *args)
    __send__(name, *args)
  end

  private

  # 继承于 BasicObject 的 Permit 没有 extend 方法，我们需要自己实现 extend 方法
  def extend(mod)
    mod.__send__(:extend_object, self)
  end

  def load_permissions

    # 从数据库加载权限纪录, 并把权限纪录定义成方法
    @user.permissions.each {|p|
      k = p.name.to_sym
      v = @permission_mapper[k]
      @permission_mod.send(:define_method, k, &v)
    }

    # 为本实例扩展和权限同名的方法，不会影响到 Permit 的其他实例
    extend @permission_mod
  end

  # 用户没有某个权限，调用与此权限同名的方法时，会返回 false，表示此权限不可访问
  def method_missing(permission_name, *args)
    false
  end

end
