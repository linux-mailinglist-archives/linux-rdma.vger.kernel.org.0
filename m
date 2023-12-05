Return-Path: <linux-rdma+bounces-260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E606804979
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 06:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F001F21480
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 05:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D6D296;
	Tue,  5 Dec 2023 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKOKX7k6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C368113
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 21:52:17 -0800 (PST)
Message-ID: <c0365975-4ad2-4c51-968c-f303cdb5273f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701755535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IfMPAVzr6ZYa90Amtba9aOfo0GDdgvs6qJomVW7M64=;
	b=wKOKX7k6IqVrcHxZ9YV5xFUhOfeqCDmNoh6l6lTX2P4O62fJGQfMUzyn945ZSh4LkPVgep
	Wv6573KBfxc0sRxGUU8UuMBrNoREDOYNWAp63Jxwee/y0/CfKQT3THeKgxNuZubx2Jvju9
	TZ3H/+h2kMv1G6j2RcO1Y6E5p8teBwg=
Date: Tue, 5 Dec 2023 13:52:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 1/7] RDMA/rxe: Cleanup rxe_ah/av_chk_attr
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, dsahern@kernel.org,
 "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231205002322.10143-1-rpearsonhpe@gmail.com>
 <20231205002322.10143-2-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205002322.10143-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add  David S. Miller and  David Ahern.

They are the maintainers in netdev and very familiar with mcast.

Zhu Yanjun

在 2023/12/5 8:23, Bob Pearson 写道:
> Replace rxe_ah_chk_attr() and rxe_av_chk_attr() by a single
> routine rxe_chk_ah_attr().
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_av.c    | 43 ++++-----------------------
>   drivers/infiniband/sw/rxe/rxe_loc.h   |  3 +-
>   drivers/infiniband/sw/rxe/rxe_qp.c    |  4 +--
>   drivers/infiniband/sw/rxe/rxe_verbs.c |  5 ++--
>   4 files changed, 12 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index 889d7adbd455..4ac17b8def28 100644
> --- a/drivers/infiniband/sw/rxe/rxe_av.c
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -14,45 +14,24 @@ void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
>   	memcpy(av->dmac, attr->roce.dmac, ETH_ALEN);
>   }
>   
> -static int chk_attr(void *obj, struct rdma_ah_attr *attr, bool obj_is_ah)
> +int rxe_chk_ah_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr)
>   {
>   	const struct ib_global_route *grh = rdma_ah_read_grh(attr);
> -	struct rxe_port *port;
> -	struct rxe_dev *rxe;
> -	struct rxe_qp *qp;
> -	struct rxe_ah *ah;
> +	struct rxe_port *port = &rxe->port;
>   	int type;
>   
> -	if (obj_is_ah) {
> -		ah = obj;
> -		rxe = to_rdev(ah->ibah.device);
> -	} else {
> -		qp = obj;
> -		rxe = to_rdev(qp->ibqp.device);
> -	}
> -
> -	port = &rxe->port;
> -
>   	if (rdma_ah_get_ah_flags(attr) & IB_AH_GRH) {
>   		if (grh->sgid_index > port->attr.gid_tbl_len) {
> -			if (obj_is_ah)
> -				rxe_dbg_ah(ah, "invalid sgid index = %d\n",
> -						grh->sgid_index);
> -			else
> -				rxe_dbg_qp(qp, "invalid sgid index = %d\n",
> -						grh->sgid_index);
> +			rxe_dbg_dev(rxe, "invalid sgid index = %d\n",
> +					grh->sgid_index);
>   			return -EINVAL;
>   		}
>   
>   		type = rdma_gid_attr_network_type(grh->sgid_attr);
>   		if (type < RDMA_NETWORK_IPV4 ||
>   		    type > RDMA_NETWORK_IPV6) {
> -			if (obj_is_ah)
> -				rxe_dbg_ah(ah, "invalid network type for rdma_rxe = %d\n",
> -						type);
> -			else
> -				rxe_dbg_qp(qp, "invalid network type for rdma_rxe = %d\n",
> -						type);
> +			rxe_dbg_dev(rxe, "invalid network type for rdma_rxe = %d\n",
> +					type);
>   			return -EINVAL;
>   		}
>   	}
> @@ -60,16 +39,6 @@ static int chk_attr(void *obj, struct rdma_ah_attr *attr, bool obj_is_ah)
>   	return 0;
>   }
>   
> -int rxe_av_chk_attr(struct rxe_qp *qp, struct rdma_ah_attr *attr)
> -{
> -	return chk_attr(qp, attr, false);
> -}
> -
> -int rxe_ah_chk_attr(struct rxe_ah *ah, struct rdma_ah_attr *attr)
> -{
> -	return chk_attr(ah, attr, true);
> -}
> -
>   void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
>   		     struct rdma_ah_attr *attr)
>   {
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 4d2a8ef52c85..3d2504a0ae56 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -9,8 +9,7 @@
>   
>   /* rxe_av.c */
>   void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av);
> -int rxe_av_chk_attr(struct rxe_qp *qp, struct rdma_ah_attr *attr);
> -int rxe_ah_chk_attr(struct rxe_ah *ah, struct rdma_ah_attr *attr);
> +int rxe_chk_ah_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr);
>   void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
>   		     struct rdma_ah_attr *attr);
>   void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 28e379c108bc..c28005db032d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -456,11 +456,11 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
>   			goto err1;
>   	}
>   
> -	if (mask & IB_QP_AV && rxe_av_chk_attr(qp, &attr->ah_attr))
> +	if (mask & IB_QP_AV && rxe_chk_ah_attr(rxe, &attr->ah_attr))
>   		goto err1;
>   
>   	if (mask & IB_QP_ALT_PATH) {
> -		if (rxe_av_chk_attr(qp, &attr->alt_ah_attr))
> +		if (rxe_chk_ah_attr(rxe, &attr->alt_ah_attr))
>   			goto err1;
>   		if (!rdma_is_port_valid(&rxe->ib_dev, attr->alt_port_num))  {
>   			rxe_dbg_qp(qp, "invalid alt port %d\n", attr->alt_port_num);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 48f86839d36a..6706d540f1f6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -286,7 +286,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>   	/* create index > 0 */
>   	ah->ah_num = ah->elem.index;
>   
> -	err = rxe_ah_chk_attr(ah, init_attr->ah_attr);
> +	err = rxe_chk_ah_attr(rxe, init_attr->ah_attr);
>   	if (err) {
>   		rxe_dbg_ah(ah, "bad attr");
>   		goto err_cleanup;
> @@ -322,10 +322,11 @@ static int rxe_create_ah(struct ib_ah *ibah,
>   
>   static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
>   {
> +	struct rxe_dev *rxe = to_rdev(ibah->device);
>   	struct rxe_ah *ah = to_rah(ibah);
>   	int err;
>   
> -	err = rxe_ah_chk_attr(ah, attr);
> +	err = rxe_chk_ah_attr(rxe, attr);
>   	if (err) {
>   		rxe_dbg_ah(ah, "bad attr");
>   		goto err_out;

