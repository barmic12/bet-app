require 'rails_helper'

RSpec.describe MatchesController, type: :controller do

  describe "GET #index" do
    context 'when normal user' do
      login_user
      it 'has 200 status' do
        get :index
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when admin user' do
      login_admin
      it 'has 200 status' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    context 'when normal user' do
      login_user
      it 'has 200 status' do
        create(:match)
        get :show, id: 1
        expect(response).to render_template(:show)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when admin user' do
      login_admin
      it 'has 200 status' do
        create(:match)
        get :show, id: 1
        expect(response).to render_template(:show)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #edit" do
    let(:match) do
      create(:match)
    end
    context 'when normal user' do
      login_user
      it 'has 403 status' do
        get :edit, id: match.id
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to match(/Access forbidden!.*/)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when admin user' do
      login_admin
      it 'has 200 status' do
        get :edit, id: match.id
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    context 'when normal user' do
      login_user
      it 'has 403 status' do

      end
    end

    context 'when admin user' do
      login_admin
      let(:match) do
        create(:match)
      end
      let(:update_correct_attrs) do
        { match: { host: 'France', guest: 'Poland', date: '2018-07-22 15:00:00' } }
      end
      let(:update_incorrect_attrs) do
        { match: { host: 'France', guest: 'Poland', date: '2018-07-22 15:00:00' } }
      end

      it 'has 204 status' do
        put :update, params: { id: match.id, match: {host: 'France', guest: 'Poland', date: '2018-07-22 15:00:00'} }
        expect(match.host).to eq('France')
        expect(match.guest).to eq('Poland')
        expect(match.date).to eq('2018-07-22 15:00:00')
      end

      it 'should re-render edit on failed update' do
        put :update, params: { id: match.id, match: {host: 'France', date: nil } }
        expect(flash[:danger]).to match(/Match was not updated.*/)
        expect(response).to render_template(:edit)
      end

      it 'has 403 status if update host/guest/date when match is ended' do

      end
    end
  end

  describe "POST #create" do
    let(:correct_attrs) do
      { match: { host: 'Poland', guest: 'Germany', date: '2018-07-21 16:00:00' } }
    end
    let(:incorrect_attrs) do
      { match: { host: 'Poland', guest: 'Germany' } }
    end
    context 'when normal user' do
      login_user
      it 'has 403 status' do
        expect {
          post :create, params: correct_attrs
        }.to change { Match.count }.by(0)
        expect(flash[:danger]).to match(/Access forbidden!.*/)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when admin user' do
      login_admin
      it 'creates a new match with correct params' do
        expect {
          post :create, params: correct_attrs
        }.to change { Match.count }.to(1)
        expect(response).to redirect_to(matches_path)
        expect(flash[:danger]).to match(/Match was created.*/)
        expect(response).to have_http_status(:success)
      end

      it 'not creates a new match with incorrect params' do
        expect {
          post :create, params: incorrect_attrs
        }.to change { Match.count }.by(0)
        expect(response).to render_template(:new)
        expect(flash[:danger]).to match(/Match was not created.*/)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
