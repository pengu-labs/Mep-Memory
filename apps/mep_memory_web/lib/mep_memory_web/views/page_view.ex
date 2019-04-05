defmodule MepMemoryWeb.PageView do
  use MepMemoryWeb, :view

  def mep_image_url(id) do
    "http://www.europarl.europa.eu/mepphoto/#{id}.jpg"
  end

  def mep_twitter_follower(mep) do
    case MepMemory.twitter_contact(mep) do
      nil -> 0
      contact -> contact.followers
    end
  end

  def mep_twitter_likes(mep) do
    case MepMemory.twitter_contact(mep) do
      nil -> 0
      contact -> contact.likes
    end
  end
end
