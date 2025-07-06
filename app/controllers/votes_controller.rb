require 'json'

class VotesController
  def vote(params, request, user)
    body = JSON.parse(request.body.read) rescue {}
    review_id = body['review_id']
    type = body['type'] # 'like' o 'dislike'
    email = user['email']

    return [400, { error: 'review_id y type requeridos' }.to_json] unless review_id && type

    vote = VOTES.find(review_id: review_id).first

    if vote.nil?
      VOTES.insert_one({
        review_id: review_id,
        likes: type == 'like' ? [email] : [],
        dislikes: type == 'dislike' ? [email] : []
      })
    else
      update = {}
      if type == 'like'
        update = {
          '$addToSet' => { likes: email },
          '$pull' => { dislikes: email }
        }
      elsif type == 'dislike'
        update = {
          '$addToSet' => { dislikes: email },
          '$pull' => { likes: email }
        }
      end
      VOTES.update_one({ review_id: review_id }, update)
    end

    [200, { message: "Voto registrado con éxito" }.to_json]
  end
end
