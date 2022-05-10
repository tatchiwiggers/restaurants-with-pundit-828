class RestaurantPolicy < ApplicationPolicy
  # NOTE: Be explicit about which records you allow access to!
  class Scope < Scope
    # this is for the index
    def resolve
      # Restaurant.all
      # scope.where(user: user)
      scope.all
    end
  end

# não há def novo aqui, mas
# RestaurantPolicy < ApplicationPolicy
# e dentro do ApplicationPolicy existe
# um def new que chama um método create
# que retorna false - é por isso que o
# usuário não tem permissão para criar um restaurante

# mas antes de mudar isso temos que pensar em:
# quais usuários têm permissão para criar um novo restaurante
# TODOS - então meu método retornará true.

  def new?
    true
  end

  # lambra da logica do OOP - primeira coisa que ele vai fazer é vir aqui e procurar o
  # método novo, se não encontrar, ele vai entrar no application policy e vai executar
  # o codigo que está lá. O que está aqui dentro vai substiruir o novo método dentro do APP POLICY.
  # mas porque há um novo método aqui, ele não entra no application policy
  # mas quando chega aqui, que é onde ele passa primeiro, ele encontra nosso metodo e ele roda daqui.

  # depois de criar o metodo, precisamos adiciionar a autorizaçao no controller

  # PRECISAMOS DE NEW? NÃO MAIS
  def create?
  # novamente vamos pensar em quem tem permissão para criar um restaurante
    true
  end

    # isso nos levará para a página show - permitir no controller
  def show?
    # novamente vamos pensar em quem tem permissão para criar um restaurante
    true
  end

  # se o usuário for o dono do restaurante deve ser verdade
  # senão deve ser falso
  # não consigo usar current_user dentro do pundit
  # existem apenas dois auxiliares que podemos usar que são definidos
  # política de aplicativos de dentro para fora que são
  # @user = user -> isso se referirá ao usuário atual
  # @record = record -> @restaurant (arg passed to authorize)

  # def edit?
  #   if user == record.user
  #     true
  #   else
  #     false
  #   end
  # end

  # NÃO PRECISAMOS edit? NÃO MAIS
  def update?
    owner_admin?
    # user == record.user || user.admin
  end

  # novamente vamos pensar em quem tem permissão para criar um restaurante
  def destroy?
    owner_admin?
    # user == record.user || user.admin
  end

  # eu gostaria de ter certeza de que o administrador do meu aplicativo
  # pode executar qualquer ação - precisamos alterar atualização e destruir
  private

  def owner_admin?
    user == record.user || user.admin
  end
end


