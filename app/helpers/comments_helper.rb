module CommentsHelper
    def comment_params
        return params.require(:comment).permit(:author_name, :body);
    end
end
