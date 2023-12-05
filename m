Return-Path: <linux-rdma+bounces-263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804FE80498C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 06:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4D41C20D5B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0EDD305;
	Tue,  5 Dec 2023 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h8O0shcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61448AA
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 21:56:47 -0800 (PST)
Message-ID: <39b6a032-e530-4b33-99dc-3d3378504e15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701755805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mok1BI4Wr4bmpEu/GFEKbmozMADWd9oIcthV1DRZP1Q=;
	b=h8O0shcrBZDn/SDCwR/sz6+jVxjiqScrgtAw03OLNKFKTSJwAepFBOUVflfCo2kyYEs61U
	/3F2vJSFbWyRTJMQt/gojN2EM8NKlGpnENjVYOpv+iHDg8b2CebM4258GOeF3tvjxdXn1v
	bWM2kqUphUNr5nLZ9gbtxsNUTX2tmBY=
Date: Tue, 5 Dec 2023 13:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 4/7] RDMA/rxe: Let rxe_lookup_mcg use
 rcu_read_lock
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
 <20231205002613.10219-2-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205002613.10219-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add  David S. Miller and  David Ahern.

They are the maintainers in netdev and very familiar with mcast.

Zhu Yanjun

在 2023/12/5 8:26, Bob Pearson 写道:
> Change locking of read side operations of the mcast group
> red-black tree to use rcu read locking. This will allow changing
> the mcast lock in the next patch to be a mutex without
> breaking rxe_recv.c which runs in an atomic state. It is also a
> better implementation than the current use of a spin-lock per
> rdma device since receiving mcast packets will be much more
> common than registering/deregistering mcast groups.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mcast.c | 59 +++++++++------------------
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
>   2 files changed, 21 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 54735d07cee5..44948f9cb02b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -151,13 +151,18 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
>   		tmp = rb_entry(node, struct rxe_mcg, node);
>   
>   		cmp = memcmp(&tmp->mgid, &mcg->mgid, sizeof(mcg->mgid));
> -		if (cmp > 0)
> +		if (cmp > 0) {
>   			link = &(*link)->rb_left;
> -		else
> +		} else if (cmp < 0) {
>   			link = &(*link)->rb_right;
> +		} else {
> +			/* we must delete the old mcg before adding one */
> +			WARN_ON_ONCE(1);
> +			return;
> +		}
>   	}
>   
> -	rb_link_node(&mcg->node, node, link);
> +	rb_link_node_rcu(&mcg->node, node, link);
>   	rb_insert_color(&mcg->node, tree);
>   }
>   
> @@ -172,15 +177,11 @@ static void __rxe_remove_mcg(struct rxe_mcg *mcg)
>   	rb_erase(&mcg->node, &mcg->rxe->mcg_tree);
>   }
>   
> -/**
> - * __rxe_lookup_mcg - lookup mcg in rxe->mcg_tree while holding lock
> - * @rxe: rxe device object
> - * @mgid: multicast IP address
> - *
> - * Context: caller must hold rxe->mcg_lock
> - * Returns: mcg on success and takes a ref to mcg else NULL
> +/*
> + * Lookup mgid in the multicast group red-black tree and try to
> + * get a ref on it. Return mcg on success else NULL.
>    */
> -static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
> +struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
>   					union ib_gid *mgid)
>   {
>   	struct rb_root *tree = &rxe->mcg_tree;
> @@ -188,7 +189,8 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
>   	struct rb_node *node;
>   	int cmp;
>   
> -	node = tree->rb_node;
> +	rcu_read_lock();
> +	node = rcu_dereference_raw(tree->rb_node);
>   
>   	while (node) {
>   		mcg = rb_entry(node, struct rxe_mcg, node);
> @@ -196,35 +198,14 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
>   		cmp = memcmp(&mcg->mgid, mgid, sizeof(*mgid));
>   
>   		if (cmp > 0)
> -			node = node->rb_left;
> +			node = rcu_dereference_raw(node->rb_left);
>   		else if (cmp < 0)
> -			node = node->rb_right;
> +			node = rcu_dereference_raw(node->rb_right);
>   		else
>   			break;
>   	}
> -
> -	if (node) {
> -		kref_get(&mcg->ref_cnt);
> -		return mcg;
> -	}
> -
> -	return NULL;
> -}
> -
> -/**
> - * rxe_lookup_mcg - lookup up mcg in red-back tree
> - * @rxe: rxe device object
> - * @mgid: multicast IP address
> - *
> - * Returns: mcg if found else NULL
> - */
> -struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> -{
> -	struct rxe_mcg *mcg;
> -
> -	spin_lock_bh(&rxe->mcg_lock);
> -	mcg = __rxe_lookup_mcg(rxe, mgid);
> -	spin_unlock_bh(&rxe->mcg_lock);
> +	mcg = (node && kref_get_unless_zero(&mcg->ref_cnt)) ? mcg : NULL;
> +	rcu_read_unlock();
>   
>   	return mcg;
>   }
> @@ -292,7 +273,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>   
>   	spin_lock_bh(&rxe->mcg_lock);
>   	/* re-check to see if someone else just added it */
> -	tmp = __rxe_lookup_mcg(rxe, mgid);
> +	tmp = rxe_lookup_mcg(rxe, mgid);
>   	if (tmp) {
>   		spin_unlock_bh(&rxe->mcg_lock);
>   		atomic_dec(&rxe->mcg_num);
> @@ -322,7 +303,7 @@ void rxe_cleanup_mcg(struct kref *kref)
>   {
>   	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
>   
> -	kfree(mcg);
> +	kfree_rcu(mcg, rcu);
>   }
>   
>   /**
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 7be9e6232dd9..8058e5039322 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -345,6 +345,7 @@ struct rxe_mw {
>   
>   struct rxe_mcg {
>   	struct rb_node		node;
> +	struct rcu_head		rcu;
>   	struct kref		ref_cnt;
>   	struct rxe_dev		*rxe;
>   	struct list_head	qp_list;

