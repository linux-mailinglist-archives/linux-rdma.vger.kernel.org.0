Return-Path: <linux-rdma+bounces-12177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DBB05223
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98C71AA754D
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 06:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E34263F36;
	Tue, 15 Jul 2025 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzRKpzk+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216623BCF7;
	Tue, 15 Jul 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562039; cv=none; b=uID7oms6JiZ6lQ5fq/64q5RReGDA5IEGHBo+RxjLAwfV210spRviMCqIzVgae83aPxim4OnH9Vp87F4D22m9xejlTyMV71Jf5MikssBSoTPrgncYVtLuwCS6nob94q3Y4CwIpmOgmy3dVnfNOBwe5ZzAh1aOySxU98TjsQjy73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562039; c=relaxed/simple;
	bh=CcEr+yxzjUP7rrvl1n/6Ya71JSibRPTajrQn80BBuio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD36MJkYNhgqn7xXYx29hdlbIQTNVgO6lIpUP/GBIAmaf468Lod2Ig5AvpMHVjRVXZJuE/MiV3Lzkz1Mcaq9eY5vK7jl5xesVaP1KeZK2KKMVBq2WwTD9U7M4qHVzGLGVvES+LeB8ScK8+flbBwMdCQiSDQTjs1MgrCppZI9TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzRKpzk+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752562038; x=1784098038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CcEr+yxzjUP7rrvl1n/6Ya71JSibRPTajrQn80BBuio=;
  b=MzRKpzk+hGjJoMPymBYLKIPkf0NbHI2sKYYRczpFV7N9YEcuvAtZt6vd
   sFHWbGlFPOoyjSOER7ZYQ+9FXPH2nZMIDk0b8KPIxD4LUr4E0BIwbIb5u
   GvLHejg2ryWhiguonn4pAR9Xkq7Djyn+lARlDWjgCoLX83BtKtUqjQWjl
   Tkp5CzcPEWyON9SqFnO3pzjnQBJhoxGFkoZIJD117vx1rsmj3ntbPyxmL
   FKoAAVTz7yaXH91W7CrO/JNwvUujZKk8vEZURLUBthOSoU873W8eu40F8
   ud+ruD4wTlkZx1oBbjmQzVvB4p0aWcK9CsmwfEt5p9KuigeTx5lqZyLQP
   w==;
X-CSE-ConnectionGUID: cO8vUQQVQ3eTXUfPNISf0A==
X-CSE-MsgGUID: vtmbnHHCStqXYUT+9xhXsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54641610"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54641610"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:47:15 -0700
X-CSE-ConnectionGUID: uKHbWTDLR3WAvdXNGLfsPQ==
X-CSE-MsgGUID: oGB91pAPQhayXPnaXyzTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156551176"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:47:11 -0700
Date: Tue, 15 Jul 2025 08:46:06 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lama Kayal <lkayal@nvidia.com>
Subject: Re: [PATCH net-next 1/6] net/mlx5: HWS, Enable IPSec hardware
 offload in legacy mode
Message-ID: <aHX5Lu6Ef4/gLwDS@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-2-git-send-email-tariqt@nvidia.com>
 <aHSm7SHg1xTMNE0F@mev-dev.igk.intel.com>
 <d03d6fd7-b86e-4c1f-92ef-ffc26339bf97@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03d6fd7-b86e-4c1f-92ef-ffc26339bf97@nvidia.com>

On Mon, Jul 14, 2025 at 11:04:54PM +0800, Jianbo Liu wrote:
> 
> 
> On 7/14/2025 2:43 PM, Michal Swiatkowski wrote:
> > On Mon, Jul 14, 2025 at 08:39:40AM +0300, Tariq Toukan wrote:
> > > From: Lama Kayal <lkayal@nvidia.com>
> > > 
> > > IPSec hardware offload in legacy mode should not be affected by the
> > > steering mode, hence it should also work properly with hmfs mode.
> > 
> > What about dmfs mode? I am not sure, if you didn't remove it because it
> > is still needed or just forgot about removing it.
> > 
> 
> It is still needed.
> We support packet offload for all steering modes in legacy, and only dmfs in
> switchdev. This is the logic we added before:
> 
>             dmfs    smfs
> legacy       Y       Y
> switchdev    Y       N
> 
> Now we support hmfs. It is the same as smfs. So the table becomes:
>             dmfs    smfs   hmfs
> legacy       Y       Y      Y
> switchdev    Y       N      N
> 
> Instead of adding "mdev->priv.steering->mode ==
> MLX5_FLOW_STEERING_MODE_HMFS", We removed "mdev->priv.steering->mode ==
> MLX5_FLOW_STEERING_MODE_SMFS", and the code is simpler and clean.
> 

Ok, got it, thanks.

> 
> > In case it is ok as it is:
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > 
> 
> Yes, it's ok. Thanks for the review.
> 
> Jianbo
> 
> > Thanks
> > 
> > > 
> > > Remove steering mode validation when calculating the cap for packet
> > > offload, this will also enable the missing cap MLX5_IPSEC_CAP_PRIO
> > > needed for crypto offload.
> > > 
> > > Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> > > Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >   .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> > > index 820debf3fbbf..ef7322d381af 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> > > @@ -42,8 +42,7 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
> > >   	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload) &&
> > >   	    (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS ||
> > > -	     (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS &&
> > > -	     is_mdev_legacy_mode(mdev)))) {
> > > +	     is_mdev_legacy_mode(mdev))) {
> > >   		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
> > >   					      reformat_add_esp_trasport) &&
> > >   		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
> > > -- 
> > > 2.40.1
> > > 
> > 
> 

