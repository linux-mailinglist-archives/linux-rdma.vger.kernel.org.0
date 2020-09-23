Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5889E274FB4
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 06:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIWEF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 00:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIWEF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 00:05:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6CC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 21:05:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q12so6122771plr.12
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zQhEz8wpSwi0PL9hONLMTNozibBobtSzn8ipmkCNt1M=;
        b=U+CV9KTBrW5isHSigK8NzM54bS8ZDZmz3ydWeRmTZo3w4VIN6aKPeCZiXWYP6BQNlA
         uIufK5WHaR486LiPDR1mcutt4hNDgsMCTwJSqmLJNx21STHUOpv4nKZL9BOkBZQlbFQt
         aWqVQhhnSwqoHUN25ohx0OXTceT7WqSkYIWq+sbETQZHqEvMwkfVL/q/gdWwTOYisroF
         3Rt6CXkxCZ0cnuwN0rvhKFe9zTaZwNxscbe9sl+dBkUBw1cZdpIVttWqNmsOE9KjeLui
         QmbCDWm8+1em7ZK6OeZn7TQW5hJHBglSx4VLqHun+AtmLVw46egKAG//ZQYWSoRIdM1c
         Q5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zQhEz8wpSwi0PL9hONLMTNozibBobtSzn8ipmkCNt1M=;
        b=ffnHvvqJEDQQlHOvNghQmCb0mbK464+Mdf6M+ap+zyi+Tbuembz5+0FH0JJhdorpat
         T2vUaT9VvKJYxVt28vopdef/8Oa1RIyvemc0rlqIBxS30N1x0LImLvNKXZfmu6d0Ozag
         w9sFqgWBBudaHNrOBM6PL+cwIrH11K/yrIeZFd6h8bUKuCwVxjXn7YyEktEEvzeBWYqQ
         27VBi1SdLv1lDCflad/OugvP2q8gOhrukgbzatm4dpp0tcQWEKlRM1sC48pcvrPyX6Qf
         qJpRGnSF324p+XFLgF0Cwt3871NFZXQ2m0NpAapAtPOVYW3mJpjX/0LTryaj0v/Mqr+w
         QKeg==
X-Gm-Message-State: AOAM533FGji2BrBUm1ma6Q2o6W9RBpjsrtGccjvlS14KwCZwQvigtslN
        BngExf4cdlDE6CMgLf7enM8=
X-Google-Smtp-Source: ABdhPJzzxMIUpLADoboG9rvPQOxcluAoF0Mpj/uoHIIA5Ipk9vuoB9NcvwxXLBxGIBvPAvUCvj7DUA==
X-Received: by 2002:a17:902:aa91:b029:d1:f8be:ac74 with SMTP id d17-20020a170902aa91b02900d1f8beac74mr7664261plr.39.1600833925705;
        Tue, 22 Sep 2020 21:05:25 -0700 (PDT)
Received: from [10.75.201.17] ([129.126.144.50])
        by smtp.gmail.com with ESMTPSA id h31sm14310693pgh.71.2020.09.22.21.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 21:05:25 -0700 (PDT)
Subject: Re: [PATCH for-next v6 04/12] rdma_rxe: Add alloc_mw and dealloc_mw
 verbs
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
 <20200921200356.8627-5-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <dc472bbf-95ea-0a14-47f5-54964e4046db@gmail.com>
Date:   Wed, 23 Sep 2020 12:05:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921200356.8627-5-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/2020 4:03 AM, Bob Pearson wrote:
>   - Add a new file focused on memory windows, rxe_mw.c.
>   - Add alloc_mw and dealloc_mw verbs and added them to
>     the list of supported user space verbs.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>   drivers/infiniband/sw/rxe/Makefile    |  1 +
>   drivers/infiniband/sw/rxe/rxe_loc.h   |  8 +++
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 77 ++++++++++-----------
>   drivers/infiniband/sw/rxe/rxe_mw.c    | 98 +++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_pool.c  | 33 +++++----
>   drivers/infiniband/sw/rxe/rxe_pool.h  |  2 +-
>   drivers/infiniband/sw/rxe/rxe_req.c   | 24 +++----
>   drivers/infiniband/sw/rxe/rxe_resp.c  |  4 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 52 +++++++++-----
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  8 +++
>   include/uapi/rdma/rdma_user_rxe.h     | 10 +++
>   11 files changed, 232 insertions(+), 85 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
>
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 66af72dca759..1e24673e9318 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -15,6 +15,7 @@ rdma_rxe-y := \
>   	rxe_qp.o \
>   	rxe_cq.o \
>   	rxe_mr.o \
> +	rxe_mw.o \
>   	rxe_opcode.o \
>   	rxe_mmap.o \
>   	rxe_icrc.o \
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 9ec6bff6863f..65f2e4a94956 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -109,6 +109,14 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
>   
>   int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>   
> +/* rxe_mw.c */
> +struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
> +			   struct ib_udata *udata);
> +
> +int rxe_dealloc_mw(struct ib_mw *ibmw);
> +
> +void rxe_mw_cleanup(struct rxe_pool_entry *arg);
> +
>   /* rxe_net.c */
>   void rxe_loopback(struct sk_buff *skb);
>   int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 368012904879..4c53badfa4e9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -7,21 +7,18 @@
>   #include "rxe.h"
>   #include "rxe_loc.h"
>   
> -/*
> - * lfsr (linear feedback shift register) with period 255
> +/* choose a unique non zero random number for lkey
> + * use high order bit to indicate MR vs MW
>    */
> -static u8 rxe_get_key(void)
> +static void rxe_set_mr_lkey(struct rxe_mr *mr)
>   {
> -	static u32 key = 1;
> -
> -	key = key << 1;
> -
> -	key |= (0 != (key & 0x100)) ^ (0 != (key & 0x10))
> -		^ (0 != (key & 0x80)) ^ (0 != (key & 0x40));
> -
> -	key &= 0xff;
> -
> -	return key;
> +	u32 lkey;
> +again:
> +	get_random_bytes(&lkey, sizeof(lkey));
> +	lkey &= ~IS_MW;
> +	if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
> +		return;
> +	goto again;
>   }
>   
>   int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
> @@ -49,36 +46,19 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>   
>   static void rxe_mr_init(int access, struct rxe_mr *mr)
>   {
> -	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
> -	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
> -
> -	if (mr->pelem.pool->type == RXE_TYPE_MR) {
> -		mr->ibmr.lkey		= lkey;
> -		mr->ibmr.rkey		= rkey;
> -	}
> -
> -	mr->lkey		= lkey;
> -	mr->rkey		= rkey;
> +	rxe_add_index(mr);
> +	rxe_set_mr_lkey(mr);
> +	if (access & IB_ACCESS_REMOTE)
> +		mr->ibmr.rkey = mr->ibmr.lkey;
> +
> +	/* TODO should not have two copies of lkey and rkey in mr */
> +	mr->lkey		= mr->ibmr.lkey;
> +	mr->rkey		= mr->ibmr.rkey;
>   	mr->state		= RXE_MEM_STATE_INVALID;
>   	mr->type		= RXE_MR_TYPE_NONE;
>   	mr->map_shift		= ilog2(RXE_BUF_PER_MAP);
>   }
>   
> -void rxe_mr_cleanup(struct rxe_pool_entry *arg)
> -{
> -	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
> -	int i;
> -
> -	ib_umem_release(mr->umem);
> -
> -	if (mr->map) {
> -		for (i = 0; i < mr->num_map; i++)
> -			kfree(mr->map[i]);
> -
> -		kfree(mr->map);
> -	}
> -}
> -
>   static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>   {
>   	int i;
> @@ -541,9 +521,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>   {
>   	struct rxe_mr *mr;
>   	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
> -	int index = key >> 8;
>   
> -	mr = rxe_pool_get_index(&rxe->mr_pool, index);
> +	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
>   	if (!mr)
>   		return NULL;
>   
> @@ -558,3 +537,21 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>   
>   	return mr;
>   }
> +
> +void rxe_mr_cleanup(struct rxe_pool_entry *arg)
> +{
> +	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
> +	int i;
> +
> +	ib_umem_release(mr->umem);
> +
> +	if (mr->map) {
> +		for (i = 0; i < mr->num_map; i++)
> +			kfree(mr->map[i]);
> +
> +		kfree(mr->map);
> +	}
> +
> +	rxe_drop_index(mr);
> +	rxe_drop_key(mr);
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> new file mode 100644
> index 000000000000..b818f1e869da
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
> + */
> +
> +#include "rxe.h"
> +#include "rxe_loc.h"
> +
> +/* choose a unique non zero random number for rkey
> + * use high order bit to indicate MR vs MW
> + */
> +static void rxe_set_mw_rkey(struct rxe_mw *mw)
> +{
> +	u32 rkey;
> +again:
> +	get_random_bytes(&rkey, sizeof(rkey));
> +	rkey |= IS_MW;
> +	if (likely((rkey & ~IS_MW) &&
> +	   (rxe_add_key(mw, &rkey) == 0)))
> +		return;
> +	goto again;
> +}
> +
> +struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
> +			   struct ib_udata *udata)
> +{
> +	struct rxe_pd *pd = to_rpd(ibpd);
> +	struct rxe_dev *rxe = to_rdev(ibpd->device);
> +	struct rxe_mw *mw;
> +	struct rxe_alloc_mw_resp __user *uresp = NULL;
> +
> +	if (udata) {
> +		if (udata->outlen < sizeof(*uresp))
> +			return ERR_PTR(-EINVAL);
> +		uresp = udata->outbuf;
> +	}
> +
> +	if (unlikely((type != IB_MW_TYPE_1) &&
> +		     (type != IB_MW_TYPE_2)))
> +		return ERR_PTR(-EINVAL);
> +
> +	rxe_add_ref(pd);
> +
> +	mw = rxe_alloc(&rxe->mw_pool);
> +	if (unlikely(!mw)) {
> +		rxe_drop_ref(pd);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	rxe_add_index(mw);
> +	rxe_set_mw_rkey(mw);	/* sets mw->ibmw.rkey */
> +
> +	spin_lock_init(&mw->lock);
> +	mw->qp			= NULL;
> +	mw->mr			= NULL;
> +	mw->addr		= 0;
> +	mw->length		= 0;
> +	mw->ibmw.pd		= ibpd;
> +	mw->ibmw.type		= type;
> +	mw->state		= (type == IB_MW_TYPE_2) ?
> +					RXE_MEM_STATE_FREE :
> +					RXE_MEM_STATE_VALID;
> +
> +	if (uresp) {
> +		if (copy_to_user(&uresp->index, &mw->pelem.index,
> +				 sizeof(uresp->index))) {
> +			rxe_drop_ref(mw);
> +			rxe_drop_ref(pd);
> +			return ERR_PTR(-EFAULT);
> +		}
> +	}
> +
> +	return &mw->ibmw;
> +}
> +
> +int rxe_dealloc_mw(struct ib_mw *ibmw)
> +{
> +	struct rxe_mw *mw = to_rmw(ibmw);
> +	struct rxe_pd *pd = to_rpd(ibmw->pd);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mw->lock, flags);
> +	mw->state = RXE_MEM_STATE_INVALID;

To this mw->state, can we use bit operations, such as set _bit, test_bit?

Thanks

Zhu Yanjun

> +	spin_unlock_irqrestore(&mw->lock, flags);
> +
> +	rxe_drop_ref(pd);
> +	rxe_drop_ref(mw);
> +
> +	return 0;
> +}
> +
> +void rxe_mw_cleanup(struct rxe_pool_entry *arg)
> +{
> +	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
> +
> +	rxe_drop_index(mw);
> +	rxe_drop_key(mw);
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 30b8f037ee20..4bcb19a7b918 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -7,13 +7,12 @@
>   #include "rxe.h"
>   #include "rxe_loc.h"
>   
> -/* info about object pools
> - */
> +/* info about object pools */
>   struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
>   	[RXE_TYPE_UC] = {
>   		.name		= "rxe-uc",
>   		.size		= sizeof(struct rxe_ucontext),
> -		.flags          = RXE_POOL_NO_ALLOC,
> +		.flags		= RXE_POOL_NO_ALLOC,
>   	},
>   	[RXE_TYPE_PD] = {
>   		.name		= "rxe-pd",
> @@ -43,23 +42,30 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
>   	[RXE_TYPE_CQ] = {
>   		.name		= "rxe-cq",
>   		.size		= sizeof(struct rxe_cq),
> -		.flags          = RXE_POOL_NO_ALLOC,
> +		.flags		= RXE_POOL_NO_ALLOC,
>   		.cleanup	= rxe_cq_cleanup,
>   	},
>   	[RXE_TYPE_MR] = {
>   		.name		= "rxe-mr",
>   		.size		= sizeof(struct rxe_mr),
>   		.cleanup	= rxe_mr_cleanup,
> -		.flags		= RXE_POOL_INDEX,
> +		.flags		= RXE_POOL_INDEX
> +				| RXE_POOL_KEY,
>   		.max_index	= RXE_MAX_MR_INDEX,
>   		.min_index	= RXE_MIN_MR_INDEX,
> +		.key_offset	= offsetof(struct rxe_mr, ibmr.lkey),
> +		.key_size	= sizeof(u32),
>   	},
>   	[RXE_TYPE_MW] = {
>   		.name		= "rxe-mw",
>   		.size		= sizeof(struct rxe_mw),
> -		.flags		= RXE_POOL_INDEX,
> +		.cleanup	= rxe_mw_cleanup,
> +		.flags		= RXE_POOL_INDEX
> +				| RXE_POOL_KEY,
>   		.max_index	= RXE_MAX_MW_INDEX,
>   		.min_index	= RXE_MIN_MW_INDEX,
> +		.key_offset	= offsetof(struct rxe_mw, ibmw.rkey),
> +		.key_size	= sizeof(u32),
>   	},
>   	[RXE_TYPE_MC_GRP] = {
>   		.name		= "rxe-mc_grp",
> @@ -223,7 +229,7 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
>   	return;
>   }
>   
> -static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
> +static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
>   {
>   	struct rb_node **link = &pool->key.tree.rb_node;
>   	struct rb_node *parent = NULL;
> @@ -239,7 +245,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
>   
>   		if (cmp == 0) {
>   			pr_warn("key already exists!\n");
> -			goto out;
> +			return -EAGAIN;
>   		}
>   
>   		if (cmp > 0)
> @@ -250,20 +256,23 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
>   
>   	rb_link_node(&new->key_node, parent, link);
>   	rb_insert_color(&new->key_node, &pool->key.tree);
> -out:
> -	return;
> +
> +	return 0;
>   }
>   
> -void rxe_add_key(void *arg, void *key)
> +int rxe_add_key(void *arg, void *key)
>   {
> +	int ret;
>   	struct rxe_pool_entry *elem = arg;
>   	struct rxe_pool *pool = elem->pool;
>   	unsigned long flags;
>   
>   	write_lock_irqsave(&pool->pool_lock, flags);
>   	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
> -	insert_key(pool, elem);
> +	ret = insert_key(pool, elem);
>   	write_unlock_irqrestore(&pool->pool_lock, flags);
> +
> +	return ret;
>   }
>   
>   void rxe_drop_key(void *arg)
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index 3d722aae5f15..5be975e3d5d3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -122,7 +122,7 @@ void rxe_drop_index(void *elem);
>   /* assign a key to a keyed object and insert object into
>    *  pool's rb tree
>    */
> -void rxe_add_key(void *elem, void *key);
> +int rxe_add_key(void *elem, void *key);
>   
>   /* remove elem from rb tree */
>   void rxe_drop_key(void *elem);
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 57236d8c2146..682f30bb3495 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -597,29 +597,29 @@ int rxe_requester(void *arg)
>   	if (wqe->mask & WR_REG_MASK) {
>   		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
>   			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> -			struct rxe_mr *rmr;
> +			struct rxe_mr *mr;
>   
> -			rmr = rxe_pool_get_index(&rxe->mr_pool,
> -						 wqe->wr.ex.invalidate_rkey >> 8);
> -			if (!rmr) {
> +			mr = rxe_pool_get_key(&rxe->mr_pool,
> +					      &wqe->wr.ex.invalidate_rkey);
> +			if (!mr) {
>   				pr_err("No mr for key %#x\n",
>   				       wqe->wr.ex.invalidate_rkey);
>   				wqe->state = wqe_state_error;
>   				wqe->status = IB_WC_MW_BIND_ERR;
>   				goto exit;
>   			}
> -			rmr->state = RXE_MEM_STATE_FREE;
> -			rxe_drop_ref(rmr);
> +			mr->state = RXE_MEM_STATE_FREE;
> +			rxe_drop_ref(mr);
>   			wqe->state = wqe_state_done;
>   			wqe->status = IB_WC_SUCCESS;
>   		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
> -			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
> +			struct rxe_mr *mr = to_rmr(wqe->wr.wr.reg.mr);
>   
> -			rmr->state = RXE_MEM_STATE_VALID;
> -			rmr->access = wqe->wr.wr.reg.access;
> -			rmr->lkey = wqe->wr.wr.reg.key;
> -			rmr->rkey = wqe->wr.wr.reg.key;
> -			rmr->iova = wqe->wr.wr.reg.mr->iova;
> +			mr->state = RXE_MEM_STATE_VALID;
> +			mr->access = wqe->wr.wr.reg.access;
> +			mr->lkey = wqe->wr.wr.reg.key;
> +			mr->rkey = wqe->wr.wr.reg.key;
> +			mr->iova = wqe->wr.wr.reg.mr->iova;
>   			wqe->state = wqe_state_done;
>   			wqe->status = IB_WC_SUCCESS;
>   		} else {
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 69867bf39cfb..885b5bf6dc2e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -888,8 +888,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>   				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
>   				wc->ex.invalidate_rkey = ieth_rkey(pkt);
>   
> -				rmr = rxe_pool_get_index(&rxe->mr_pool,
> -							 wc->ex.invalidate_rkey >> 8);
> +				rmr = rxe_pool_get_key(&rxe->mr_pool,
> +						 &wc->ex.invalidate_rkey);
>   				if (unlikely(!rmr)) {
>   					pr_err("Bad rkey %#x invalidation\n",
>   					       wc->ex.invalidate_rkey);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 626706f25efc..96fea64ba02d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -869,12 +869,14 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>   	struct rxe_pd *pd = to_rpd(ibpd);
>   	struct rxe_mr *mr;
>   
> +	rxe_add_ref(pd);
> +
>   	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> +	if (!mr) {
> +		rxe_drop_ref(pd);
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
> -	rxe_add_index(mr);
> -	rxe_add_ref(pd);
>   	rxe_mr_init_dma(pd, access, mr);
>   
>   	return &mr->ibmr;
> @@ -890,6 +892,17 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>   	struct rxe_dev *rxe = to_rdev(ibpd->device);
>   	struct rxe_pd *pd = to_rpd(ibpd);
>   	struct rxe_mr *mr;
> +	struct rxe_reg_mr_resp __user *uresp = NULL;
> +
> +	if (udata) {
> +		if (udata->outlen < sizeof(*uresp)) {
> +			err = -EINVAL;
> +			goto err1;
> +		}
> +		uresp = udata->outbuf;
> +	}
> +
> +	rxe_add_ref(pd);
>   
>   	mr = rxe_alloc(&rxe->mr_pool);
>   	if (!mr) {
> @@ -897,22 +910,25 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>   		goto err2;
>   	}
>   
> -	rxe_add_index(mr);
> -
> -	rxe_add_ref(pd);
> -
>   	err = rxe_mr_init_user(pd, start, length, iova,
> -				access, udata, mr);
> +			       access, udata, mr);
>   	if (err)
>   		goto err3;
>   
> -	return &mr->ibmr;
> +	if (uresp) {
> +		if (copy_to_user(&uresp->index, &mr->pelem.index,
> +				 sizeof(uresp->index))) {
> +			err = -EFAULT;
> +			goto err3;
> +		}
> +	}
>   
> +	return &mr->ibmr;
>   err3:
> -	rxe_drop_ref(pd);
> -	rxe_drop_index(mr);
>   	rxe_drop_ref(mr);
>   err2:
> +	rxe_drop_ref(pd);
> +err1:
>   	return ERR_PTR(err);
>   }
>   
> @@ -922,7 +938,6 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>   
>   	mr->state = RXE_MEM_STATE_ZOMBIE;
>   	rxe_drop_ref(mr->pd);
> -	rxe_drop_index(mr);
>   	rxe_drop_ref(mr);
>   	return 0;
>   }
> @@ -938,16 +953,14 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   	if (mr_type != IB_MR_TYPE_MEM_REG)
>   		return ERR_PTR(-EINVAL);
>   
> +	rxe_add_ref(pd);
> +
>   	mr = rxe_alloc(&rxe->mr_pool);
>   	if (!mr) {
>   		err = -ENOMEM;
>   		goto err1;
>   	}
>   
> -	rxe_add_index(mr);
> -
> -	rxe_add_ref(pd);
> -
>   	err = rxe_mr_init_fast(pd, max_num_sg, mr);
>   	if (err)
>   		goto err2;
> @@ -955,10 +968,9 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   	return &mr->ibmr;
>   
>   err2:
> -	rxe_drop_ref(pd);
> -	rxe_drop_index(mr);
>   	rxe_drop_ref(mr);
>   err1:
> +	rxe_drop_ref(pd);
>   	return ERR_PTR(err);
>   }
>   
> @@ -1105,6 +1117,8 @@ static const struct ib_device_ops rxe_dev_ops = {
>   	.reg_user_mr = rxe_reg_user_mr,
>   	.req_notify_cq = rxe_req_notify_cq,
>   	.resize_cq = rxe_resize_cq,
> +	.alloc_mw = rxe_alloc_mw,
> +	.dealloc_mw = rxe_dealloc_mw,
>   
>   	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
>   	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
> @@ -1166,6 +1180,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>   	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
>   	    | BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST)
>   	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
> +	    | BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW)
> +	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
>   	    ;
>   
>   	ib_set_device_ops(dev, &rxe_dev_ops);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index dbc649c9c43f..2233630fea7f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -319,6 +319,9 @@ struct rxe_mr {
>   	struct rxe_map		**map;
>   };
>   
> +/* use high order bit to separate MW and MR rkeys */
> +#define IS_MW  (1 << 31)
> +
>   struct rxe_mw {
>   	struct rxe_pool_entry	pelem;
>   	struct ib_mw		ibmw;
> @@ -441,6 +444,11 @@ static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
>   	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
>   }
>   
> +static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
> +{
> +	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
> +}
> +
>   int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
>   
>   void rxe_mc_cleanup(struct rxe_pool_entry *arg);
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index d8f2e0e46dab..4ad0fa0b2ab9 100644
> --- a/include/uapi/rdma/rdma_user_rxe.h
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -175,4 +175,14 @@ struct rxe_modify_srq_cmd {
>   	__aligned_u64 mmap_info_addr;
>   };
>   
> +struct rxe_reg_mr_resp {
> +	__u32 index;
> +	__u32 reserved;
> +};
> +
> +struct rxe_alloc_mw_resp {
> +	__u32 index;
> +	__u32 reserved;
> +};
> +
>   #endif /* RDMA_USER_RXE_H */


