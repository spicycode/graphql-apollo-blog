include ActionView::Helpers::TextHelper

PostType = GraphQL::ObjectType.define do
  name 'Post'
  description 'A single post entry returns a post'

  # Expose fields associated with Post model
  field :id, !types.ID, 'The id of the post'
  field :title, types.String, 'The title of this post'
  field :body, types.String, 'The body of this post'
  field :created_at, types.String, 'The time at which this post was created'
  field :user, UserType, 'Owner of this post'
  field :comments, types[CommentType], 'The comments of this post'

  field :comments_count, types.Int, 'The comments of this post'

  field :excerpt do
    type types.String
    resolve -> (obj, args, ctx) {
      truncate(obj.body, length: 250)
    }
  end

  field :url do
    type types.String
    resolve -> (obj, args, ctx) {
      Rails.application.routes.url_helpers.post_path(obj)
    }
  end
end
