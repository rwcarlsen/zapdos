[GlobalParams]
  # potential_units = kV
  potential_units = V
[]

[Mesh]
  type = FileMesh
  file = 'untitled.msh'
  boundary_id = '12 13 14 15'
  boundary_name = 'cathode anode walls axis'
  # type = GeneratedMesh
  # nx = 2
  # xmax = 1.1
  # # ny = 2
  # # ymax = 1.1
  # dim = 1
  # boundary_id = '0 1'
  # boundary_name = 'anode cathode'
[]

[Problem]
  type = FEProblem
  coord_type = RZ
  # rz_coord_axis = X
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  # type = Steady
  type = Transient
  dt = 0.1
  dtmin = 1e-4
  end_time = 3
  solve_type = PJFNK
  petsc_options = '-snes_converged_reason -snes_linesearch_monitor'
  # nl_rel_tol = 1e-4
  # petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount -ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'lu NONZERO 1.e-10 preonly 1e-3'
  # petsc_options = '-snes_test_display'
  # petsc_options_iname = '-snes_type'
  # petsc_options_value = 'test'
[]

[Outputs]
  print_perf_log = true
  print_linear_residuals = false
  [./out]
    type = Exodus
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

[Kernels]
  [./diff_v]
    type = Diffusion
    variable = v
  [../]
  [./adv_u]
    type = EFieldAdvection
    variable = u
    potential = v
    position_units = 1
  [../]
  [./diff_u]
    type = CoeffDiffusion
    variable = u
    position_units = 1
  [../]
  [./src_u]
    type = UnitySource
    variable = u
  [../]
  [./time_u]
    type = ElectronTimeDerivative
    variable = u
  [../]
[]

[Variables]
  [./u]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./v]
    # order = SECOND
    # family = LAGRANGE
  [../]
[]

[BCs]
  # [./cathode]
  #   type = DirichletBC
  #   boundary = cathode
  #   variable = v
  #   value = 1
  # [../]
  [./cathode]
    type = CircuitDirichletPotential
    surface_potential = -1
    current = cathode_flux
    boundary = cathode
    variable = v
    surface = cathode
  [../]
  # [./anode]
  #   type = CircuitDirichletPotential
  #   surface_potential = 1
  #   surface = anode
  #   current = anode_flux
  #   boundary = anode
  #   variable = v
  # [../]
  [./anode]
    type = DirichletBC
    value = 0
    boundary = anode
    variable = v
  [../]
  [./species_diff]
    type = HagelaarIonDiffusionBC
    variable = u
    r = 0
    position_units = 1
    user_velocity = 1
    boundary = 'cathode anode walls'
  [../]
  [./species_adv]
    type = HagelaarIonAdvectionBC
    variable = u
    r = 0
    position_units = 1
    potential = v
    boundary = 'cathode anode walls'
  [../]
  # [./axis]
  #   type = NeumannBC
  #   variable = v
  #   value = 0
  #   boundary = 'cathode anode walls axis'
  # [../]
[]

[AuxVariables]
  [./u_lin]
    order = FIRST
    family = MONOMIAL
  [../]

  [./r_field]
    order = FIRST
    family = MONOMIAL
  [../]

  [./z_field]
    order = FIRST
    family = MONOMIAL
  [../]

  [./phi_field]
    order = FIRST
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./u_lin]
    type = Density
    variable = u_lin
    density_log = u
    convert_moles = false
  [../]
  [./r_field]
    type = Efield
    variable = r_field
    potential = v
    position_units = 1
    component = 0
  [../]
  [./z_field]
    type = Efield
    variable = z_field
    potential = v
    position_units = 1
    component = 1
  [../]
  [./phi_field]
    type = Efield
    variable = phi_field
    potential = v
    position_units = 1
    component = 2
  [../]
[]

[Materials]
  [./test]
    type = Gas
    interp_trans_coeffs = true
    interp_elastic_coeff = true
    ramp_trans_coeffs = false
    block = 11
  [../]
  # [./test]
  #   type = JacMat
  #   interp_trans_coeffs = true
  #   interp_elastic_coeff = true
  #   ramp_trans_coeffs = false
  #   block = 0
  #   potential_units = V
  # [../]
[]

[Postprocessors]
  [./anode_flux]
    type = SideTotFluxIntegral
    execute_on = timestep_end
    boundary = anode
    mobility = muu
    variable = u
    potential = v
    r = 0
    position_units = 1
    user_velocity = 1
  [../]
  [./cathode_flux]
    type = SideTotFluxIntegral
    execute_on = timestep_end
    boundary = cathode
    mobility = muu
    potential = v
    variable = u
    r = 0
    position_units = 1
    user_velocity = 1
  [../]
[]

# [ICs]
#   [./em_ic]
#     type = ConstantIC
#     variable = v
#     value = -1
#   [../]
#   # [./emliq_ic]
#   #   type = RandomIC
#   #   variable = v
#   # [../]
# []