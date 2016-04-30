module DashboardController
  def dashboard
    @posts = Post.count
    @comments = Comment.count
    render 'admin/dashboard'
  end
end
