Return-Path: <linux-rdma+bounces-7385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D0A26BE6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 07:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D183A7BC8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2F200B89;
	Tue,  4 Feb 2025 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTvTh1+h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990C25A626;
	Tue,  4 Feb 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649375; cv=none; b=GcsEArWkKQg9+A8RcfhmfYCevraHZp9ZMniLH9gRCLiRiaalO4XbgkDfmJES8yfvmGG1W+/yg9o02MVB/vectzhFpnU3VZrcpPlyU+quHRtV+blEFhlfpNdReUi2v1C2zjg04dtrCFvA1l9x8/fjyomD4+vh0yxc58IYbfrAjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649375; c=relaxed/simple;
	bh=Xv7yRxda8mvX0Xb6hAMlYFE629tMjcSXGJ5Ls/bRo9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltzqEMydhExpAM1KUQ/wZ2l2O+Jg9yq9f8m6CKRe6bW1wj91iLzzEim0GbvJOmg74xVuat1u/PfXO0EdBKm02lTKofugkLdCvXljeiEn6AmAZwkDva/pyUi3YeJZmz6WNP97m7hdBGf62G1M26/XImmXfzioqubdZMQrokXpHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTvTh1+h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738649373; x=1770185373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xv7yRxda8mvX0Xb6hAMlYFE629tMjcSXGJ5Ls/bRo9Q=;
  b=DTvTh1+h7BBZFFPfJhbF4IYoXaPo/KIPPVs3CiTQVlfGP4aYZ5o4LzL2
   8tm5584/PwVFpgLlVzh20juhemhk3evoPQy+ztgaho5n2nL9+Jsx+ycXA
   pH+jEiDI2FFaYJc31e+ACZ54HO5xe8xswH0fgx212V/B2/Cgg9aClXqD2
   xxN9YXwjyKNbKmGz9IZmS+YxiYQMkzUHoJmawFzzkqPZB15DmWtH5q7rs
   UhwLkvOW0rXHW5cq+rSsX8rhFm3YiF8IHwT9bCQ+Px4iSaVGkJUhg1giz
   /cSDZR048a66FZvETfmK0qqgmMC6MtKpVq29msUBi8Fxe22XWLhJLTsOZ
   Q==;
X-CSE-ConnectionGUID: dPMV1AOlT9qA4/l7KXhB4Q==
X-CSE-MsgGUID: U68RCC06Qb6qLPWsW2jtxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="43084796"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="43084796"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:09:32 -0800
X-CSE-ConnectionGUID: BvI8MDn1Sy2jP23F+Hn1OQ==
X-CSE-MsgGUID: 2Gy12VTJRSqG4If49Rr6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110385750"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:09:27 -0800
Date: Tue, 4 Feb 2025 07:06:00 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
	David.Laight@aculab.com, pmenzel@molgen.mpg.de, mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min parameter
Message-ID: <Z6GuSJCshbWlkiLu@mev-dev.igk.intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
 <20250203210940.328608-3-anthony.l.nguyen@intel.com>
 <20250203214808.129b75e5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203214808.129b75e5@pumpkin>

On Mon, Feb 03, 2025 at 09:48:08PM +0000, David Laight wrote:
> On Mon,  3 Feb 2025 13:09:31 -0800
> Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> 
> > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > 
> > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> > range.
> > 
> > Add notes about this parameters into ice devlink documentation.
> > 
> > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  Documentation/networking/devlink/ice.rst      | 11 +++
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 88 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
> >  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
> >  4 files changed, 113 insertions(+)
> > 
> > diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
> > index e3972d03cea0..792e9f8c846a 100644
> > --- a/Documentation/networking/devlink/ice.rst
> > +++ b/Documentation/networking/devlink/ice.rst
> > @@ -69,6 +69,17 @@ Parameters
> >  
> >         To verify that value has been set:
> >         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
> > +   * - ``msix_vec_per_pf_max``
> > +     - driverinit
> > +     - Set the max MSI-X that can be used by the PF, rest can be utilized for
> > +       SRIOV. The range is from min value set in msix_vec_per_pf_min to
> > +       2k/number of ports.
> > +   * - ``msix_vec_per_pf_min``
> > +     - driverinit
> > +     - Set the min MSI-X that will be used by the PF. This value inform how many
> > +       MSI-X will be allocated statically. The range is from 2 to value set
> > +       in msix_vec_per_pf_max.
> > +
> >  .. list-table:: Driver specific parameters implemented
> >      :widths: 5 5 90
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index d116e2b10bce..c53baecf8a90 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1202,6 +1202,25 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
> >  	return status;
> >  }
> >  
> > +static void ice_set_min_max_msix(struct ice_pf *pf)
> > +{
> > +	struct devlink *devlink = priv_to_devlink(pf);
> > +	union devlink_param_value val;
> > +	int err;
> > +
> > +	err = devl_param_driverinit_value_get(devlink,
> > +					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> > +					      &val);
> > +	if (!err)
> > +		pf->msix.min = val.vu32;
> > +
> > +	err = devl_param_driverinit_value_get(devlink,
> > +					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> > +					      &val);
> > +	if (!err)
> > +		pf->msix.max = val.vu32;
> > +}
> > +
> >  /**
> >   * ice_devlink_reinit_up - do reinit of the given PF
> >   * @pf: pointer to the PF struct
> > @@ -1217,6 +1236,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
> >  		return err;
> >  	}
> >  
> > +	/* load MSI-X values */
> > +	ice_set_min_max_msix(pf);
> > +
> >  	err = ice_init_dev(pf);
> >  	if (err)
> >  		goto unroll_hw_init;
> > @@ -1530,6 +1552,37 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
> >  	return 0;
> >  }
> >  
> > +static int
> > +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> > +				 union devlink_param_value val,
> > +				 struct netlink_ext_ack *extack)
> > +{
> > +	struct ice_pf *pf = devlink_priv(devlink);
> > +
> > +	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> > +	    val.vu32 < pf->msix.min) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> > +				 union devlink_param_value val,
> > +				 struct netlink_ext_ack *extack)
> > +{
> > +	struct ice_pf *pf = devlink_priv(devlink);
> > +
> > +	if (val.vu32 < ICE_MIN_MSIX || val.vu32 > pf->msix.max) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Don't those checks make it difficult to set the min and max together?
> I think you need to create the new min/max pair and check they are
> valid together.
> Which probably requires one parameter with two values.
> 

I wanted to reuse exsisting parameter. The other user of it is bnxt
driver. In it there is a separate check for min "max" and max "max".
It is also problematic, because min can be set to value greater than
max (here it can happen when setting together to specific values).
I can do a follow up to this series and change this parameter as you
suggested. What do you think?

Thanks,
Michal

> 	David
> 
> > +
> >  enum ice_param_id {
> >  	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> >  	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> > @@ -1547,6 +1600,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
> >  			      ice_devlink_enable_iw_validate),
> >  };
> >  
> > +static const struct devlink_param ice_dvl_msix_params[] = {
> > +	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
> > +			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> > +			      NULL, NULL, ice_devlink_msix_max_pf_validate),
> > +	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
> > +			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> > +			      NULL, NULL, ice_devlink_msix_min_pf_validate),
> > +};
> > +
> >  static const struct devlink_param ice_dvl_sched_params[] = {
> >  	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> >  			     "tx_scheduling_layers",
> > @@ -1648,6 +1710,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
> >  int ice_devlink_register_params(struct ice_pf *pf)
> >  {
> >  	struct devlink *devlink = priv_to_devlink(pf);
> > +	union devlink_param_value value;
> >  	struct ice_hw *hw = &pf->hw;
> >  	int status;
> >  
> > @@ -1656,10 +1719,33 @@ int ice_devlink_register_params(struct ice_pf *pf)
> >  	if (status)
> >  		return status;
> >  
> > +	status = devl_params_register(devlink, ice_dvl_msix_params,
> > +				      ARRAY_SIZE(ice_dvl_msix_params));
> > +	if (status)
> > +		goto unregister_rdma_params;
> > +
> >  	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> >  		status = devl_params_register(devlink, ice_dvl_sched_params,
> >  					      ARRAY_SIZE(ice_dvl_sched_params));
> > +	if (status)
> > +		goto unregister_msix_params;
> > +
> > +	value.vu32 = pf->msix.max;
> > +	devl_param_driverinit_value_set(devlink,
> > +					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> > +					value);
> > +	value.vu32 = pf->msix.min;
> > +	devl_param_driverinit_value_set(devlink,
> > +					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> > +					value);
> > +	return 0;
> >  
> > +unregister_msix_params:
> > +	devl_params_unregister(devlink, ice_dvl_msix_params,
> > +			       ARRAY_SIZE(ice_dvl_msix_params));
> > +unregister_rdma_params:
> > +	devl_params_unregister(devlink, ice_dvl_rdma_params,
> > +			       ARRAY_SIZE(ice_dvl_rdma_params));
> >  	return status;
> >  }
> >  
> > @@ -1670,6 +1756,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
> >  
> >  	devl_params_unregister(devlink, ice_dvl_rdma_params,
> >  			       ARRAY_SIZE(ice_dvl_rdma_params));
> > +	devl_params_unregister(devlink, ice_dvl_msix_params,
> > +			       ARRAY_SIZE(ice_dvl_msix_params));
> >  
> >  	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> >  		devl_params_unregister(devlink, ice_dvl_sched_params,
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 71e05d30f0fd..d041b04ff324 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -542,6 +542,12 @@ struct ice_agg_node {
> >  	u8 valid;
> >  };
> >  
> > +struct ice_pf_msix {
> > +	u32 cur;
> > +	u32 min;
> > +	u32 max;
> > +};
> > +
> >  struct ice_pf {
> >  	struct pci_dev *pdev;
> >  	struct ice_adapter *adapter;
> > @@ -612,6 +618,7 @@ struct ice_pf {
> >  	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
> >  	u16 max_pf_txqs;	/* Total Tx queues PF wide */
> >  	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
> > +	struct ice_pf_msix msix;
> >  	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
> >  	u16 num_lan_tx;		/* num LAN Tx queues setup */
> >  	u16 num_lan_rx;		/* num LAN Rx queues setup */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> > index ad82ff7d1995..0659b96b9b8c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> > @@ -254,6 +254,13 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
> >  	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
> >  	int vectors, max_vectors;
> >  
> > +	/* load default PF MSI-X range */
> > +	if (!pf->msix.min)
> > +		pf->msix.min = ICE_MIN_MSIX;
> > +
> > +	if (!pf->msix.max)
> > +		pf->msix.max = total_vectors / 2;
> > +
> >  	vectors = ice_ena_msix_range(pf);
> >  
> >  	if (vectors < 0)
> 

