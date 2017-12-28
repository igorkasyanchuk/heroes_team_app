FactoryBot.create(:user, email: 'admin1@admin.com', password: '1qaz2wsx', role: 'admin')
FactoryBot.create(:user, email: 'admin2@admin.com', password: '1qaz2wsx', role: 'admin')
FactoryBot.create(:user, email: 'admin3@admin.com', password: '1qaz2wsx', role: 'admin')

FactoryBot.create_list(:user, 5, tenant_id: 1)
FactoryBot.create_list(:user, 5, tenant_id: 2)
FactoryBot.create_list(:user, 5, tenant_id: 3)



user = User.first

FactoryBot.create(:company, name:  'Example Company',
                            domain: 'example.org',
                            user: user)

FactoryBot.create(:company, name:  'SoftServe,Inc.',
                            domain: 'softserve.ua',
                            user: user)

FactoryBot.create(:company, name:  'Alphabet Inc.',
                            domain: 'abc.xyz',
                            user: user)

company = Company.first

FactoryBot.create_list(:page, 20, company: company)


