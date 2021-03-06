require_relative '../../test_helper'

describe CineworldUk::Screening do
  describe '#new film_name, cinema_name, date, time, variant' do
    it 'stores film_name, cinema_name & when (in UTC)' do
      screening = CineworldUk::Screening.new 'Iron Man 3', "Duke's At Komedia", Time.parse('2013-09-12 11:00')
      screening.film_name.must_equal 'Iron Man 3'
      screening.cinema_name.must_equal "Duke's At Komedia"
      screening.when.must_equal Time.utc(2013, 9, 12, 10, 0)
      screening.booking_url.must_equal nil
      screening.variant.must_equal nil
    end

    it 'stores variant if passed' do
      screening = CineworldUk::Screening.new 'Iron Man 3', "Duke's At Komedia", Time.utc(2013, 9, 12, 11, 0), 'http://link.com', '2d'
      screening.film_name.must_equal 'Iron Man 3'
      screening.cinema_name.must_equal "Duke's At Komedia"
      screening.when.must_equal Time.utc(2013, 9, 12, 11, 0)
      screening.booking_url.must_equal 'http://link.com'
      screening.variant.must_equal '2d'
    end
  end

  describe '#date' do
    subject { CineworldUk::Screening.new('Iron Man 3', "Duke's At Komedia", Time.utc(2013, 9, 12, 11, 0)).date }
    it 'should return date of showing' do
      subject.must_be_instance_of(Date)
      subject.must_equal Date.new(2013, 9, 12)
    end
  end

  describe '#varient (DEPRECATED)' do
    subject { screening.varient }
    let(:screening) { CineworldUk::Screening.new 'Iron Man 3', "Duke's At Komedia", Time.utc(2013, 9, 12, 11, 0), 'http://link.com', '2d' }

    it 'should return variant' do
      subject.must_equal '2d'
    end
  end
end
