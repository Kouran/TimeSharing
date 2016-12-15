json.array!(@ads) do |ad|
  json.extract! ad, :id, :title, :category, :description, :zone, :expected_hours, :deadline, :request, :closed, :applicant_user, :fullfiller_user
  json.url ad_url(ad, format: :json)
end
