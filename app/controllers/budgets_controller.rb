class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy summary]
  before_action :authenticate_user!, only: [:new, :create, :index, :edit, :update, :destroy]

  # GET /budgets or /budgets.json
  def index
    if current_user.try(:admin?)
        redirect_to rails_admin_path
    end
    
    
    @budgets_recap = []
    @budgets = current_user.budgets.all
    @budgets.each do |budget|
      @budget_recap = {}
      amount = 0
      budget.expenses.each_with_index do |bud, i|
        if bud.amount.to_i == bud.amount
          amount += bud.amount
        end
        @budget_recap['used'] = amount
      end
      @budget_recap['start_date'] = budget.start_date
      @budget_recap['end_date'] = budget.end_date
      @budget_recap['amount'] = budget.amount
      @budget_recap['id'] = budget.id
      @budget_recap['remain'] = budget.amount - amount
      @budgets_recap += [@budget_recap]
    end

   
  end

  def show

    if params[:is_resume].present?
      dic_needs_with_amount = {}
      @summary = {}
      @summary_ = {}
      puts "les needs sont: #{@budget.needs.distinct.pluck(:name, :amount)}, bbb, #{@budget.expenses.to_json}"
      needs_with_amount = @budget.needs.distinct.pluck(:name, :amount)

      needs_with_amount.each do |need|
        dic_needs_with_amount[need[0]] = need[1]
      end

      @budget.expenses.each_with_index do |expense, i|
        #puts " voici budget de expense: #{expense.amount} "
        #puts "voici expense.need avant #{ @summary}, #{ @summary[expense.need]} et voici "
        if @summary.has_key?(expense.need)

         # puts "voici expense.need #{ @summary}, #{ @summary[expense.need]} et voici #{@summary[expense.need]["used"]}"

          used = @summary[expense.need]["used"] 
          used += expense.amount
          @summary[expense.need]["used"] = used
        else
          puts " voici budget de expense: #{dic_needs_with_amount} "
          @summary[expense.need] = {"used" => 0, "give" => dic_needs_with_amount[expense.need], "remain" => 0}
          @summary[expense.need]["used"] = expense.amount
          #@summary[expense.need]["give"] = dic_needs_with_amount[expense.need] 
          #@summary[expense.need]["remain"] = dic_needs_with_amount[expense.need]
        end
      end 
      puts " ####### mon dico #{@summary} "  
      @summary.each do |need, val|
        puts "voici need #{need} et voici sa valeur #{val["used"]}"  
      end  
      #raise 
    end
  end

  def new
    @budget = Budget.new
    5.times{@budget.needs.build}
      
  end

  def edit
    @budget.needs.build
  end

  def create
    @budget = current_user.budgets.build(budget_params)

    respond_to do |format|
     # puts "debut: #{params[:start_date]}, fin: #{params[:end_date]}"
      #raise
      if @budget.save
        format.html { redirect_to @budget, notice: "Votre Budget a été créé avec succès." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: "Budget a été mis à jour avec succès." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: "Le bdget a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private
    def set_budget
      @budget = Budget.find(params[:id])
    end

    def budget_params
      params.require(:budget)
            .permit(:start_date, :end_date, :amount, :name,
                    needs_attributes: [:id, :amount, :name, :priority, :status]
      )
    end
end
