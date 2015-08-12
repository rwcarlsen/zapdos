/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/
#ifndef INTERPOLATETD_H_
#define INTERPOLATETD_H_

#include "Material.h"
#include "ProvideMobility.h"
#include "LinearInterpolation.h"

class InterpolateTD;

template<>
InputParameters validParams<InterpolateTD>();

class InterpolateTD : public Material
{
public:
  InterpolateTD(const InputParameters & parameters);

protected:
  virtual void computeQpProperties();

  LinearInterpolation _mobility_interpolation;
  LinearInterpolation _diffusivity_interpolation;
  LinearInterpolation _alpha_interpolation;
  LinearInterpolation _eta_interpolation;

  MaterialProperty<Real>  & _muem;
  MaterialProperty<Real>  & _diffem;
  MaterialProperty<Real>  & _muip;
  MaterialProperty<Real>  & _diffip;
  MaterialProperty<Real>  & _rate_coeff_ion;
  MaterialProperty<Real>  & _Eiz;
  MaterialProperty<Real>  & _Ar;
  MaterialProperty<Real> &  _muel;
  MaterialProperty<Real> &  _diffel;
  MaterialProperty<Real> &  _rate_coeff_elastic;
  MaterialProperty<Real> &  _mem;
  MaterialProperty<Real> &  _mip;
  MaterialProperty<Real> &  _se_coeff;
  MaterialProperty<Real> & _ElectronTotalFluxMag;
  MaterialProperty<Real> & _ElectronTotalFluxMagSizeForm;
  MaterialProperty<Real> & _ElectronTotalFlux;
  MaterialProperty<Real> & _ElectronAdvectiveFlux;
  MaterialProperty<Real> & _ElectronDiffusiveFlux;
  MaterialProperty<Real> & _IonTotalFlux;
  MaterialProperty<Real> & _IonAdvectiveFlux;
  MaterialProperty<Real> & _IonDiffusiveFlux;
  MaterialProperty<Real> & _EField;
  MaterialProperty<Real> & _Source_term;
  MaterialProperty<Real> & _Source_term_coeff;
  MaterialProperty<Real> & _e;
  MaterialProperty<Real> & _eps;
  MaterialProperty<Real> &  _Tem_lfa;
  MaterialProperty<Real> &  _Tip_lfa;
  MaterialProperty<Real> &  _k_boltz;
  MaterialProperty<Real> &  _vthermal_em;
  MaterialProperty<Real> &  _vthermal_ip;

  const ProvideMobility & _data;

  VariableGradient & _grad_potential;
  VariableValue & _em;
  VariableValue & _ip;
  VariableGradient & _grad_em;
  VariableGradient & _grad_ip;
};

#endif //INTERPOLATETD_H
