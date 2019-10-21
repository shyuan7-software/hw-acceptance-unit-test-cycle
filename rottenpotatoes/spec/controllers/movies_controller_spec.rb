require 'rails_helper'


describe MoviesController do
    
    before :each do
       @movie_argus = {:title => '1', :director => 'Shaohua Yuan', :rating => '1', :description => '1', :release_date => '2019-10-20'}
    end  
    
    describe 'create movie' do
        let(:new_movie) { instance_double(Movie, @movie_argus) } 
        it 'creates a movie' do
            expect(Movie).to receive(:create!).with(@movie_argus).and_return(new_movie)
            post :create, {:movie => @movie_argus}
        end
    end
    
    describe 'edit movie' do
        let(:current_movie) { instance_double(Movie, :id => 1, :title => '2', :director => '2', :rating => '2', :description => '2', :release_date => '2009-10-20') }
        it 'edit a movie' do
            allow(Movie).to receive(:find).with('1').and_return(current_movie)
            expect(current_movie).to receive(:update_attributes!).with(@movie_argus)
            put :update, {:id => 1, :movie => @movie_argus}
        end
    end
    
    describe 'destroy movie' do
        let(:current_movie) { instance_double(Movie, :id => 1, :title => '2', :director => '2', :rating => '2', :description => '2', :release_date => '2009-10-20') }
        it 'destroy a movie' do
            allow(Movie).to receive(:find).with('1').and_return(current_movie)
            expect(current_movie).to receive(:destroy)
            delete :destroy, {:id => 1}
        end
    end
    
    describe 'show index' do
        it 'sort by title' do
            get :index, {:sort => 'title'}
            expect(assigns(:title_header)).to eq 'hilite'
        end   
        it 'sort by release_date' do
            get :index, {:sort => 'release_date'}
            expect(assigns(:date_header)).to eq 'hilite'
        end  
    end
    
    describe 'show movie' do
        let(:current_movie) { instance_double(Movie, :id => 1, :title => '2', :director => '2', :rating => '2', :description => '2', :release_date => '2009-10-20') }
        it 'find a movie' do
            expect(Movie).to receive(:find).with('1').and_return(current_movie)
            get :show, {:id => 1}
        end   
    end
    
    describe 'find same director movies' do
        context "When movie has a director" do
            let(:current_movie) { instance_double(Movie, :id => 1, :title => '2', :director => 'Shaohua Yuan', :rating => '2', :description => '2', :release_date => '2009-10-20') }
            it "should find movies with same director" do
            expect(Movie).to receive(:find).with('1').and_return(current_movie)
            expect(current_movie).to receive(:director).and_return('Shaohua Yuan')
            expect(Movie).to receive(:find_with_same_director).with('Shaohua Yuan')
            get :find_same_director, :id => 1
            expect(response).to render_template(:find_same_director)
            end
        end
        context "When movie has no director" do
            let(:current_movie_no_dir) { instance_double(Movie, :id => 2, :title => '2', :rating => '2', :description => '2', :release_date => '2009-10-20') }
            it "should redirect to home page" do
                expect(Movie).to receive(:find).with('2').and_return(current_movie_no_dir)
                expect(current_movie_no_dir).to receive(:director).and_return(nil)
                get :find_same_director, :id => 2
                expect(response).to redirect_to(movies_path)
            end
        end
    end
    
end