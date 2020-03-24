Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EBE19054D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 06:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCXFpl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 01:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgCXFpl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 01:45:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E0CF20724;
        Tue, 24 Mar 2020 05:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585028739;
        bh=xj2pWB4myeiQ7rwX+tVxdH2fe0hVD/tUnC5WVoc3Jxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5PE+CZNNcClyGch1HnhUIQr0Ep4FmyrBVivTO2Il8zLlu0H1T2ta2FrP9bsHSsrI
         khX0WuHEtTweSMqVXLr8ZzO4Kb5m6Muqwykd+OObarySbaEEQ98u3qtc24mRjSKkns
         l+7+SU8cP5yjRskcFBWltxhO1p9i6eYBWyzweEag=
Date:   Tue, 24 Mar 2020 07:45:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com,
        Mike Marciniszyn <mike.marcinisyzn@intel.com>,
        linux-rdma@vger.kernel.org,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v2 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200324054536.GR650439@unreal>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
 <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 23, 2020 at 07:15:12PM -0400, Dennis Dalessandro wrote:
> From: Kaike Wan <kaike.wan@intel.com>
>
> Currently the ipoib UD mtu is restricted to 4K bytes. Remove this
> limitation so that the IPOIB module can potentially use an MTU (in UD
> mode) that is bounded by the MTU of the underlying device. A field is
> added to the ib_port_attr structure to indicate the maximum physical
> MTU the underlying device supports.
>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Reviewed-by: Mike Marciniszyn <mike.marcinisyzn@intel.com>
> Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/qp.c                |   18 +-----
>  drivers/infiniband/hw/hfi1/verbs.c             |    2 +
>  drivers/infiniband/ulp/ipoib/ipoib_main.c      |    2 -
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   11 ++-
>  include/rdma/ib_verbs.h                        |   77 ++++++++++++++++++++++++
>  include/rdma/opa_port_info.h                   |   10 ---
>  6 files changed, 88 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
> index f8e733a..0c2ae9f 100644
> --- a/drivers/infiniband/hw/hfi1/qp.c
> +++ b/drivers/infiniband/hw/hfi1/qp.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright(c) 2015 - 2019 Intel Corporation.
> + * Copyright(c) 2015 - 2020 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
>   * redistributing this file, you may do so under either license.
> @@ -186,15 +186,6 @@ static void flush_iowait(struct rvt_qp *qp)
>  	write_sequnlock_irqrestore(lock, flags);
>  }
>
> -static inline int opa_mtu_enum_to_int(int mtu)
> -{
> -	switch (mtu) {
> -	case OPA_MTU_8192:  return 8192;
> -	case OPA_MTU_10240: return 10240;
> -	default:            return -1;
> -	}
> -}
> -
>  /**
>   * This function is what we would push to the core layer if we wanted to be a
>   * "first class citizen".  Instead we hide this here and rely on Verbs ULPs
> @@ -202,15 +193,10 @@ static inline int opa_mtu_enum_to_int(int mtu)
>   */
>  static inline int verbs_mtu_enum_to_int(struct ib_device *dev, enum ib_mtu mtu)
>  {
> -	int val;
> -
>  	/* Constraining 10KB packets to 8KB packets */
>  	if (mtu == (enum ib_mtu)OPA_MTU_10240)
>  		mtu = OPA_MTU_8192;
> -	val = opa_mtu_enum_to_int((int)mtu);
> -	if (val > 0)
> -		return val;
> -	return ib_mtu_enum_to_int(mtu);
> +	return opa_mtu_enum_to_int((enum opa_mtu)mtu);
>  }
>
>  int hfi1_check_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index c61b291..19d5d00 100644
> --- a/drivers/infiniband/hw/hfi1/verbs.c
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -1439,6 +1439,8 @@ static int query_port(struct rvt_dev_info *rdi, u8 port_num,
>  				      4096 : hfi1_max_mtu), IB_MTU_4096);
>  	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
>  		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
> +	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> +				ib_mtu_enum_to_int(props->max_mtu);
>
>  	return 0;
>  }
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index 81b8227..c8018e0 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1858,7 +1858,7 @@ static int ipoib_parent_init(struct net_device *ndev)
>  			priv->port);
>  		return result;
>  	}
> -	priv->max_ib_mtu = ib_mtu_enum_to_int(attr.max_mtu);
> +	priv->max_ib_mtu = rdma_mtu_from_attr(priv->ca, priv->port, &attr);
>
>  	result = ib_query_pkey(priv->ca, priv->port, 0, &priv->pkey);
>  	if (result) {
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> index b9e9562..7166ee9b 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -218,6 +218,7 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>  	struct rdma_ah_attr av;
>  	int ret;
>  	int set_qkey = 0;
> +	int mtu;
>
>  	mcast->mcmember = *mcmember;
>
> @@ -240,13 +241,11 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>  		priv->broadcast->mcmember.flow_label = mcmember->flow_label;
>  		priv->broadcast->mcmember.hop_limit = mcmember->hop_limit;
>  		/* assume if the admin and the mcast are the same both can be changed */
> +		mtu = rdma_mtu_enum_to_int(priv->ca,  priv->port,
> +					   priv->broadcast->mcmember.mtu);
>  		if (priv->mcast_mtu == priv->admin_mtu)
> -			priv->admin_mtu =
> -			priv->mcast_mtu =
> -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> -		else
> -			priv->mcast_mtu =
> -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> +			priv->admin_mtu = IPOIB_UD_MTU(mtu);
> +		priv->mcast_mtu = IPOIB_UD_MTU(mtu);
>
>  		priv->qkey = be32_to_cpu(priv->broadcast->mcmember.qkey);
>  		spin_unlock_irq(&priv->lock);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index babfdb0..da8d0d6 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -462,6 +462,11 @@ enum ib_mtu {
>  	IB_MTU_4096 = 5
>  };
>
> +enum opa_mtu {
> +	OPA_MTU_8192 = 6,
> +	OPA_MTU_10240 = 7
> +};
> +
>  static inline int ib_mtu_enum_to_int(enum ib_mtu mtu)
>  {
>  	switch (mtu) {
> @@ -488,6 +493,28 @@ static inline enum ib_mtu ib_mtu_int_to_enum(int mtu)
>  		return IB_MTU_256;
>  }
>
> +static inline int opa_mtu_enum_to_int(enum opa_mtu mtu)
> +{
> +	switch (mtu) {
> +	case OPA_MTU_8192:
> +		return 8192;
> +	case OPA_MTU_10240:
> +		return 10240;
> +	default:
> +		return(ib_mtu_enum_to_int((enum ib_mtu)mtu));
> +	}
> +}
> +
> +static inline enum opa_mtu opa_mtu_int_to_enum(int mtu)
> +{
> +	if (mtu >= 10240)
> +		return OPA_MTU_10240;
> +	else if (mtu >= 8192)
> +		return OPA_MTU_8192;
> +	else
> +		return ((enum opa_mtu)ib_mtu_int_to_enum(mtu));
> +}

Is it possible to include opa_port_info.h in the ib_verbs.h and leave all
those functions there?

Thanks
