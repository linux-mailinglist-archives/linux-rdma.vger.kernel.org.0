Return-Path: <linux-rdma+bounces-12411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90040B0EB18
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 08:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A0D1C81F87
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 06:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC8271461;
	Wed, 23 Jul 2025 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSW1SDAs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED5254858;
	Wed, 23 Jul 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253885; cv=none; b=M7556MUihlNshsLOeQVycih+4pP4mVWfQ2oovlrHrAyYOVqemWmmdPJgvRZTvTaZ/4JTlhJMFt+kyvCgNi/8E7M/wb6dglboWNlvjlAMPmd3ij4RmN6rhUiJBshbr0dnWxaJvR3/oXxEP6ArOZTlCHjuOG6mVmkQ9Rd9M2ZHpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253885; c=relaxed/simple;
	bh=Qsrasya+2ybsj2TZXgu9y4ibchgm6z4CBLeQyvfptW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVLLAZOrLItgxClSSVno7eOvhdda2bDwP+0a5+8LnNnSp61pKiw+P4osikSefBOmNPEoK+QK8tlq5V9xtH7Jv+e3sUW7R+tnvIY9MmaTYVMF5gCAXgO6zwHABmOwMkupdxvFJu/RkX2csO+VQvoiL+a7u/mWUVC/we/eiURGHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSW1SDAs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253883; x=1784789883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qsrasya+2ybsj2TZXgu9y4ibchgm6z4CBLeQyvfptW4=;
  b=WSW1SDAszTVwpwFhzByUKa8vtfnpEY0c7pW9xf+XZvJ0Kp4mPnkbTJYi
   PH+EuO+zER3HjuEjIyjhF109nWC/6tYRJ4uqp+lSnGLdfl7K0Dh6S6UeD
   n50RswJGCdIB8IytutKK25gZETSvqRWHhyum4KBVc5jaQ0uHoPdz1cYJ1
   gVChmd+q1T/pDOC2X7OaEkPV9s9t8xNXrmL7nnW5ZAtLcPDxLDcLocjuN
   yfqnIwDYRGh50dhAg2BBE9pQWU3iQrx6lw6RxJ12uJPnA9tSlrw4Y7fo5
   iwhAfzzNbmhuzTN8ASJ0b4UkD/9EpNl+qI/qi+2CC3s8U7zVrAWFz0xZL
   w==;
X-CSE-ConnectionGUID: L73xExu/QCefW/dSrWzoqg==
X-CSE-MsgGUID: lnmsm25+TSyVCj46gpCN8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54744021"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="54744021"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:58:03 -0700
X-CSE-ConnectionGUID: 9c4LMBvcRHer7sabxucwQA==
X-CSE-MsgGUID: WxHsKZNgQ/GjWfuFbXZW0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164999041"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:58:00 -0700
Date: Wed, 23 Jul 2025 08:56:49 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net-next V2 2/2] net/mlx5e: Expose TIS via devlink tx
 reporter diagnose
Message-ID: <aICHsQPoI+gO3eTQ@mev-dev.igk.intel.com>
References: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
 <1753194228-333722-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753194228-333722-3-git-send-email-tariqt@nvidia.com>

On Tue, Jul 22, 2025 at 05:23:48PM +0300, Tariq Toukan wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> Underneath "TIS Config" tag expose TIS diagnostic information.
> Expose the tisn of each TC under each lag port.
> 
> $ sudo devlink health diagnose auxiliary/mlx5_core.eth.2/131072 reporter tx
> ......
>   TIS Config:
>       lag port: 0 tc: 0 tisn: 0
>       lag port: 1 tc: 0 tisn: 8
> ......
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Aya Levin <ayal@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en/reporter_tx.c       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> index bd96988e102c..85d5cb39b107 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> @@ -311,6 +311,30 @@ mlx5e_tx_reporter_diagnose_common_config(struct devlink_health_reporter *reporte
>  	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
>  }
>  
> +static void
> +mlx5e_tx_reporter_diagnose_tis_config(struct devlink_health_reporter *reporter,
> +				      struct devlink_fmsg *fmsg)
> +{
> +	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
> +	u8 num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> +	u32 tc, i, tisn;
> +
> +	devlink_fmsg_arr_pair_nest_start(fmsg, "TIS Config");
> +	for (i = 0; i < mlx5e_get_num_lag_ports(priv->mdev); i++) {
> +		for (tc = 0; tc < num_tc; tc++) {

nit: tisn can be defined in this for, not outside.

> +			tisn = mlx5e_profile_get_tisn(priv->mdev, priv,
> +						      priv->profile, i, tc);
> +
> +			devlink_fmsg_obj_nest_start(fmsg);
> +			devlink_fmsg_u32_pair_put(fmsg, "lag port", i);
> +			devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
> +			devlink_fmsg_u32_pair_put(fmsg, "tisn", tisn);
> +			devlink_fmsg_obj_nest_end(fmsg);
> +		}
> +	}
> +	devlink_fmsg_arr_pair_nest_end(fmsg);
> +}
> +
>  static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
>  				      struct devlink_fmsg *fmsg,
>  				      struct netlink_ext_ack *extack)
> @@ -326,6 +350,7 @@ static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
>  		goto unlock;
>  
>  	mlx5e_tx_reporter_diagnose_common_config(reporter, fmsg);
> +	mlx5e_tx_reporter_diagnose_tis_config(reporter, fmsg);
>  	devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
>  	for (i = 0; i < priv->channels.num; i++) {

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

