require 'rails_helper'

describe 'HabituationAPI' do
  it '全てのポストを取得する' do
    FactoryBot.create_list(:habituation, 10)

    get '/api/v1/habituations'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 正しい数のデータが返されたか確認する。
    expect(json['data'].length).to eq(10)
  end

  it '特定のhabituationを取得する' do
    habituation = create(:habituation, title: 'test-title')

    get "/api/v1/habituations/#{habituation.id}"
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 要求した特定のポストのみ取得した事を確認する
    expect(json['data']['title']).to eq(habituation.title)
  end

  it '新しいhabituationを作成する' do
    valid_params = { title: 'title', slack_notification: 'https://xxxxxxx'}

    #データが作成されている事を確認
    expect { post '/api/v1/habituations', params: { habituation: valid_params } }.to change(Habituation, :count).by(+1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end

  it 'habituationの編集を行う' do
    habituation = create(:habituation, title: 'old-title', slack_notification: 'https://xxxxxxx')

    put "/api/v1/habituations/#{habituation.id}", params: { habituation: {title: 'new-title' , slack_notification: 'https://yyyyyyy'}  }
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    #データが更新されている事を確認
    expect(json['data']['title']).to eq('new-title')
    expect(json['data']['slack_notification']).to eq('https://yyyyyyy')
  end

  it 'habituationを削除する' do
    habituation = create(:habituation)

    #データが削除されている事を確認
    expect { delete "/api/v1/habituations/#{habituation.id}" }.to change(Habituation, :count).by(-1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end
end
