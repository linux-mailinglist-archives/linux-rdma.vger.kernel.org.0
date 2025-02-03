Return-Path: <linux-rdma+bounces-7382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB422A26604
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647A81885575
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533A1FF612;
	Mon,  3 Feb 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMJfb89w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD978F54;
	Mon,  3 Feb 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619294; cv=none; b=drLTB0qzJh57uZ9Rz7VRCW8rVbgYwyfpCGurYV2yuz9tawqKnMN4FS2OgMQNr1cOXaxtBngQsL3s5vR6Av7KlGEXxVlkJsHPSe00z3lox7Nnsy8sZJUyk3bjX+t6GyhlLxLlqTi/fSdXfAPBp2ejlR2/BOIs0dfhT5s4ADseR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619294; c=relaxed/simple;
	bh=w9CauL2F5NPwUbg+HrxTr1mH7OE6t/6iTX8Lw2NR8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUPuG09RJeYhTBb6F7j7ErXGkZeVB6jGKku/OWTg1w4GmMNxMruBXTscSMvS+lW+4TOmAMHjVzlCLWYIwEs1WYAMiNU6M+UjyWjCoWlP1VkBlFFXbw1qD5eIq5osg0L70tkZG3fWJNl+aKR7F+m213F1DeIllwFQCy71h0VGk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMJfb89w; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385df53e559so3579567f8f.3;
        Mon, 03 Feb 2025 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738619290; x=1739224090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asyngx0cG9NWRA/6QyKofVaTYo6OZmtsgDrOX+UPq1Y=;
        b=kMJfb89wdjttNsfUeYwxGKVx6M6Vt7OlUOSSWoeWc9ShDdiAdUy0Cx4z/dc8I10JH0
         sD+HycINcS1GVUf3bv7OPWJaocBLdamHwW16+e/HjSbipaCLQVgAC7pOj5fAvFhmZ+8M
         A2sXQZ3HTSAhDqbln0hQeFOSflPI+fPRa1MkhNawjM0E1QUhVtBETvHgaZnLqi0L8zkH
         cRdeh0Sz++1Q8eGCOAZkZDwjWfu19dt6KlGKnd24simNREXWmQEFbXC2aWBEdanp98HP
         oh7fpC2F+bKqXn7pvshA4kfIxWotMGxh/NstDyEU1byp7aqaPsqmNSOCdI4mifJfWv6z
         1weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619290; x=1739224090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asyngx0cG9NWRA/6QyKofVaTYo6OZmtsgDrOX+UPq1Y=;
        b=nt5pmBNXE2jD5acMNX7vmhQQtbt1mSXsyXcfcOaCqmay/qr2WR/x7uOge6Dsz0ohwl
         sPUbqFfR4RsZJO40udUQgV3ZPqmaUhX/GMrXpQlCIn0Ul9Of9b40ZbSdJE/ZOOHfNvDP
         eZvciabTT5ewC/EBPhFR2P5/8/JHczXBQWtJr/kaj5ZTMLOtNnwdnSVsg7jnis2PwHpj
         4tDaabXBhNofu2Vh8XkNUNTQ0nML+9ksA4mjViy945yYYZhuGwvFIhGQZGaHTgYYF/Pv
         GnGonvCJyE0lK5QjNt1pPYOCAy6DFBZzyUD+QJS5DE7ZlzpWOfjtC67SH0XwwFHBajmS
         P06Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXrbKLjry1c2uhHcXCVBEWU1vuR2qC6ccxjn45//ZapNCe4FY1CxcTVJsfHP8H4KNWxBuLMR+G@vger.kernel.org, AJvYcCW9rW+Mv/0HzzXGRIEPv4jLSvRN9e2NvVQrppEidP28jhDn5vIJ3RKWJnREnpM7hHdYOuRa6ZWdeE8=@vger.kernel.org, AJvYcCWuMTz9dCodnKMRJkV4lvHMjEBMckvOUez3eeI+sypnrv3ZuRkcS3/U1YozZj80uiJVwAbZDiGWwtGMyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3glSJ2eKm5rqWymFo6492dt2GIw32K+Y2nJyxuXHjQLuz5SK
	UQp4maoqjptviF7pSyKEGm7CmSud9CulVC70EqTTbNTtgF/mm5K2aCvdUQ==
X-Gm-Gg: ASbGnctzr2NEbYii69FJZ4bXbaSfBQ2hEImwOOZaP01uJKIwBN8XSaDuIMC28o/FArB
	PuYBp5NijB0LlFE3vBZnlzsNeA8mCNFcNT6s1U7p5kigld/gl2WHwN/MWhnl/sQOFK96Hfg4kXZ
	H2Igl/lLXq+Fiy7SZvpuZWXwD6bzH9JC5O1Ermd/G3dOl8JzJiu/r8vkOv7i+hngKSrelu97pca
	50N+U640o0vJWPNHclMmiv/AO7Xac9HywSuTc4l6L3N9UeYFNeX4IIthdzrTz2izHp32NjxgTtC
	0QPAnYK9z5upff2Fa05nUynh8s5diOkRIQJrF38sD0sBiJ1gc3aKjw==
X-Google-Smtp-Source: AGHT+IE/uY/DUBHDjQQYg88j+rIzh1CFWkcfkfxNC7MPvX7J8p2bNn6V8r2sMoGUXcQR3Eeeus2+nA==
X-Received: by 2002:a5d:59a3:0:b0:38c:5d42:152a with SMTP id ffacd0b85a97d-38c5d42185bmr16389991f8f.35.1738619289890;
        Mon, 03 Feb 2025 13:48:09 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81a39sm200477345e9.35.2025.02.03.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:48:09 -0800 (PST)
Date: Mon, 3 Feb 2025 21:48:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 pio.raczynski@gmail.com, konrad.knitter@intel.com, marcin.szycik@intel.com,
 nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Laight@ACULAB.COM,
 pmenzel@molgen.mpg.de, mschmidt@redhat.com, tatyana.e.nikolova@intel.com,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min
 parameter
Message-ID: <20250203214808.129b75e5@pumpkin>
In-Reply-To: <20250203210940.328608-3-anthony.l.nguyen@intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
	<20250203210940.328608-3-anthony.l.nguyen@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 13:09:31 -0800
Tony Nguyen <anthony.l.nguyen@intel.com> wrote:

> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> range.
> 
> Add notes about this parameters into ice devlink documentation.
> 
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  Documentation/networking/devlink/ice.rst      | 11 +++
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 88 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
>  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
>  4 files changed, 113 insertions(+)
> 
> diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
> index e3972d03cea0..792e9f8c846a 100644
> --- a/Documentation/networking/devlink/ice.rst
> +++ b/Documentation/networking/devlink/ice.rst
> @@ -69,6 +69,17 @@ Parameters
>  
>         To verify that value has been set:
>         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
> +   * - ``msix_vec_per_pf_max``
> +     - driverinit
> +     - Set the max MSI-X that can be used by the PF, rest can be utilized for
> +       SRIOV. The range is from min value set in msix_vec_per_pf_min to
> +       2k/number of ports.
> +   * - ``msix_vec_per_pf_min``
> +     - driverinit
> +     - Set the min MSI-X that will be used by the PF. This value inform how many
> +       MSI-X will be allocated statically. The range is from 2 to value set
> +       in msix_vec_per_pf_max.
> +
>  .. list-table:: Driver specific parameters implemented
>      :widths: 5 5 90
>  
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index d116e2b10bce..c53baecf8a90 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1202,6 +1202,25 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
>  	return status;
>  }
>  
> +static void ice_set_min_max_msix(struct ice_pf *pf)
> +{
> +	struct devlink *devlink = priv_to_devlink(pf);
> +	union devlink_param_value val;
> +	int err;
> +
> +	err = devl_param_driverinit_value_get(devlink,
> +					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> +					      &val);
> +	if (!err)
> +		pf->msix.min = val.vu32;
> +
> +	err = devl_param_driverinit_value_get(devlink,
> +					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> +					      &val);
> +	if (!err)
> +		pf->msix.max = val.vu32;
> +}
> +
>  /**
>   * ice_devlink_reinit_up - do reinit of the given PF
>   * @pf: pointer to the PF struct
> @@ -1217,6 +1236,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
>  		return err;
>  	}
>  
> +	/* load MSI-X values */
> +	ice_set_min_max_msix(pf);
> +
>  	err = ice_init_dev(pf);
>  	if (err)
>  		goto unroll_hw_init;
> @@ -1530,6 +1552,37 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>  	return 0;
>  }
>  
> +static int
> +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> +				 union devlink_param_value val,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct ice_pf *pf = devlink_priv(devlink);
> +
> +	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> +	    val.vu32 < pf->msix.min) {
> +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> +				 union devlink_param_value val,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct ice_pf *pf = devlink_priv(devlink);
> +
> +	if (val.vu32 < ICE_MIN_MSIX || val.vu32 > pf->msix.max) {
> +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Don't those checks make it difficult to set the min and max together?
I think you need to create the new min/max pair and check they are
valid together.
Which probably requires one parameter with two values.

	David

> +
>  enum ice_param_id {
>  	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>  	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> @@ -1547,6 +1600,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
>  			      ice_devlink_enable_iw_validate),
>  };
>  
> +static const struct devlink_param ice_dvl_msix_params[] = {
> +	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
> +			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> +			      NULL, NULL, ice_devlink_msix_max_pf_validate),
> +	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
> +			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> +			      NULL, NULL, ice_devlink_msix_min_pf_validate),
> +};
> +
>  static const struct devlink_param ice_dvl_sched_params[] = {
>  	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>  			     "tx_scheduling_layers",
> @@ -1648,6 +1710,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
>  int ice_devlink_register_params(struct ice_pf *pf)
>  {
>  	struct devlink *devlink = priv_to_devlink(pf);
> +	union devlink_param_value value;
>  	struct ice_hw *hw = &pf->hw;
>  	int status;
>  
> @@ -1656,10 +1719,33 @@ int ice_devlink_register_params(struct ice_pf *pf)
>  	if (status)
>  		return status;
>  
> +	status = devl_params_register(devlink, ice_dvl_msix_params,
> +				      ARRAY_SIZE(ice_dvl_msix_params));
> +	if (status)
> +		goto unregister_rdma_params;
> +
>  	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>  		status = devl_params_register(devlink, ice_dvl_sched_params,
>  					      ARRAY_SIZE(ice_dvl_sched_params));
> +	if (status)
> +		goto unregister_msix_params;
> +
> +	value.vu32 = pf->msix.max;
> +	devl_param_driverinit_value_set(devlink,
> +					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> +					value);
> +	value.vu32 = pf->msix.min;
> +	devl_param_driverinit_value_set(devlink,
> +					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> +					value);
> +	return 0;
>  
> +unregister_msix_params:
> +	devl_params_unregister(devlink, ice_dvl_msix_params,
> +			       ARRAY_SIZE(ice_dvl_msix_params));
> +unregister_rdma_params:
> +	devl_params_unregister(devlink, ice_dvl_rdma_params,
> +			       ARRAY_SIZE(ice_dvl_rdma_params));
>  	return status;
>  }
>  
> @@ -1670,6 +1756,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
>  
>  	devl_params_unregister(devlink, ice_dvl_rdma_params,
>  			       ARRAY_SIZE(ice_dvl_rdma_params));
> +	devl_params_unregister(devlink, ice_dvl_msix_params,
> +			       ARRAY_SIZE(ice_dvl_msix_params));
>  
>  	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>  		devl_params_unregister(devlink, ice_dvl_sched_params,
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 71e05d30f0fd..d041b04ff324 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -542,6 +542,12 @@ struct ice_agg_node {
>  	u8 valid;
>  };
>  
> +struct ice_pf_msix {
> +	u32 cur;
> +	u32 min;
> +	u32 max;
> +};
> +
>  struct ice_pf {
>  	struct pci_dev *pdev;
>  	struct ice_adapter *adapter;
> @@ -612,6 +618,7 @@ struct ice_pf {
>  	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
>  	u16 max_pf_txqs;	/* Total Tx queues PF wide */
>  	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
> +	struct ice_pf_msix msix;
>  	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
>  	u16 num_lan_tx;		/* num LAN Tx queues setup */
>  	u16 num_lan_rx;		/* num LAN Rx queues setup */
> diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> index ad82ff7d1995..0659b96b9b8c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> @@ -254,6 +254,13 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
>  	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
>  	int vectors, max_vectors;
>  
> +	/* load default PF MSI-X range */
> +	if (!pf->msix.min)
> +		pf->msix.min = ICE_MIN_MSIX;
> +
> +	if (!pf->msix.max)
> +		pf->msix.max = total_vectors / 2;
> +
>  	vectors = ice_ena_msix_range(pf);
>  
>  	if (vectors < 0)


