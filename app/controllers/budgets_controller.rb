class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]
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
      if @budget.save
        format.html { redirect_to @budget, notice: "Budget was successfully created." }
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
        format.html { redirect_to @budget, notice: "Budget was successfully updated." }
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
      format.html { redirect_to budgets_url, notice: "Budget was successfully destroyed." }
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
