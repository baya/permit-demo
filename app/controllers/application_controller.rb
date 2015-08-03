class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # 可以在 view 里使用 :current_user 和 :permit? 方法
  helper_method :current_user, :permit?

  # 为了简单起见，我们没有实现一个完整的注册登录功能
  # 通过在 params 里传递 user name 来识别当前用户
  # 比如: http://localhost:3000/posts/new?current_user=user0
  def current_user
    @current_user ||= User.find_by(name: params[:current_user])
  end

  # 将 current_user 的 permit 缓存起来
  def current_permit
    @current_permit ||= Permit.new(current_user || User.new)
  end

  # 判断当前登录用户是否具有名字为 name 的权限
  def permit?(name, *args)
    current_permit.can?(name, *args)
  end


  # fence 是篱笆的意思，我们可以通过篱笆保护我们的代码不被不认可的用户访问
  # 如果代码里有多个 render 或者 redirect_to 我们需要使用
  # fence(name, *args) {...} 的形式
  def fence(name, *args, &block)
    if !permit?(name, *args)
      render status: 403, json: {code: 403, msg: 'forbidden'}.to_json
    else
      block.call if block_given?
    end
  end

end
