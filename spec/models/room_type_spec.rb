require "rails_helper"

RSpec.describe RoomType, type: :model do
  let(:room_type) {FactoryBot.create :room_type}
  context "validations" do
    it {expect(room_type).to be_valid}
  end

  context "associations" do
    it {expect(room_type).to have_many(:rooms).dependent(:destroy)}
    it "is expected to have many attached images" do
      3.times do |m|
        room_type.images.attach(
          io: File.open(Rails.root.join(Settings.src.assets_path + Settings.seed.room_types.image[m])),
          filename: Settings.seed.room_types.image[m])
      end
      expect(room_type.images.attached?).to be true
    end
  end

  context "#most_available" do
    it "should be sorted by number of rooms desc" do
      most_available_room_type = RoomType.most_available
      sort_room_type = most_available_room_type.sort_by{|r| -r.rooms.size}
      expect(most_available_room_type).to eq sort_room_type 
    end
  end
end
