class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :min_booking_two_days
  validate :max_booking_seven_days

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def min_booking_two_days
    return if end_date.blank? || start_date.blank?

    if (end_date - start_date).to_i < 2
      errors.add(:end_date, "booking must be at least for two days")
    end
  end

  def max_booking_seven_days
    return if end_date.blank? || start_date.blank?

    if (end_date - start_date).to_i > 7
    errors.add(:end_date, "booking cannot be more than seven days")
    end
  end



end
