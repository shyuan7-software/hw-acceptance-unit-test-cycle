require 'rails_helper'


describe Movie do
  describe 'finding movies with same director' do
    context "it should find movies by the same director" do
      let(:current_movie) { instance_double(Movie, :id => 1, :title => '2', :director => 'Shaohua Yuan', :rating => '2', :description => '2', :release_date => '2009-10-20') }
        it 'searches the db through Movie model for movies with director' do
          expect(Movie).to receive(:where).with(director: current_movie.director).and_return(current_movie)
          Movie.find_with_same_director(current_movie.director)
      end 
    end
    
    context "it should not find movies by different directors" do
      let(:current_movie) { instance_double(Movie, :id => 1, :title => '2', :director => 'Shaohua Yuan', :rating => '2', :description => '2', :release_date => '2009-10-20') }
      let(:current_movie_diff_dir) { instance_double(Movie, :id => 2, :title => '2', :director => 'Not Shaohua Yuan', :rating => '2', :description => '2', :release_date => '2009-10-20') }
        it 'searches the db through Movie model for movies with director' do
          expect(Movie.find_with_same_director(current_movie.director)).not_to include(current_movie_diff_dir)
          Movie.find_with_same_director(current_movie.director)
      end 
    end
    
  end
end