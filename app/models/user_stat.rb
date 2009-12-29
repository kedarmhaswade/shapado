class UserStat
  include MongoMapper::Document

  key :_id, String
  key :user_id, String
  belongs_to :user

  timestamps!

  def visited_on(time)
    self.collection.update({:_id => self._id,
                            visits_key(time) => {:$ne => time.mday}},
                           {:$push => {visits_key(time) => time.mday}},
                           :upsert => true)
  end

  private
  def visits_key(time)
    "visits_#{time.year}.#{time.month}"
  end
end