class MachineSnacksController < ApplicationController
  def create 
    MachineSnack.create(snack_id: params[:snack_id], machine_id: params[:machine_id])
    redirect_to machine_path(params[:machine_id])
  end

  def destroy 
    @machine_snack = MachineSnack.find_by(snack_id: params[:id], machine_id: params[:machine_id])
    @machine_snack.destroy 
    redirect_to machine_path(params[:machine_id])
  end
end
