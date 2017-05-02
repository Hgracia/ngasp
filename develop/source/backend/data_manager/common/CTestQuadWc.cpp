/*
 * mstatspop, Statistical Analysis using Multiple Populations for Genomic Data.
 * Copyright (c) 2009-2017, Sebastián Ramos Onsins,
 * Centre for Research in Agricultural Genomics (CRAG).
 * All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version
 * 2.1 as published by the Free Software Foundation.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License version 2.1 for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License version 2.1 along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */
/**
 *  \brief     CTestQuadWc.cpp
 *  \details
 *  \author    Joan Jené
 *  \version   1.0
 *  \date      Apr 14, 2015
 *  \pre
 *  \bug
 *  \warning
 */

#include "CTestQuadWc.h"

#include <cstddef>

CTestQuadWc::CTestQuadWc(int num_sam) {
  nsam  = num_sam;
  n     = 0;
  theta = 0;
  l     = 0;
  gamma = 0;
  w     = new double[num_sam];
  w2    = new double*[num_sam];

  for(int i=0; i<num_sam; i++) {
    w2[i] = new double[num_sam];
  }
}

CTestQuadWc::~CTestQuadWc() {

  if(w!=NULL) {
    delete[] w;
    w=NULL;
  }

  if(w2!=NULL) {
    for(int i=0; i<nsam; i++) {
      delete[] w2[i];
      w2[i] = NULL;
    }
    delete[] w2;
    w2=NULL;
  }
}

