Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204932F3DCF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 01:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436705AbhALVhU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14744 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437086AbhALU60 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jan 2021 15:58:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffe0d4a0000>; Tue, 12 Jan 2021 12:57:46 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 20:57:45 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 12 Jan 2021 20:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWCIAekIZqFMpd4WVSNG5u1QsZU0pgSzaezfk7ysN3mIUZYggMfLScgPvyzCdBBmZopdkByqFDRXj9FH+8vUSbSoTjbR/uQwbeVzMqD1FBr1BJMoSntPtVjcl5DgSwwPZ0HdHVQhcvw+tBePcipMHYvRzBTlORueMpor+8iUuwuCMEaqgxZZQPibDGB9MvAkod/7rdrkuEqlXJNUrz3oUWVuUuRV0uvN3KYVEN8M3JKEBi47tuCK0xp4P9yePwxkxKtF1c38sHNT2wwPQ8+R2mqc/TQDTt27wrPX2ytHNU3zOOz/YIKyhxMl182X7pfgtfEkeRdUtxDBu86RGVti4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNamHuFItSSHOK3CTBZ7Fn6N0UaRHR3x5ULHZGNCQ5Y=;
 b=OktmzyHDwdfhBSyodJL6gueSzAA2AMO22S9ZWAD04/lt9PLJuzA9vZe9wPB7SXgxNlJ3PilGKxMi00odh9aJz3jP69dWxyvBykfJ+fB3lH6OCqg0iabrHJDSruIo8Rf0zjHwtNVYPT5xiDTl6EkDoBRxrtIVKSIhr2AUB4gjdRo3uSmKriPsEbg5gThQSw96elJRK+DZqUWess3FeuboN9J1hmPL4IAApZ0TlltxdD/c5awyguxdY7sw+5OhkhAzs1lDpTsQEvlOV3+7XnFexrZXMiPrnMoFGQbYr8dC4SbM6+rZbvR+bjGNDQPCJPrQ8yJGORqHatCAm6LuDHOU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 20:57:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 20:57:44 +0000
Date:   Tue, 12 Jan 2021 16:57:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next 4/7] RDMA/rxe: Make pool lookup and alloc APIs
 type safe
Message-ID: <20210112205741.GA36057@nvidia.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
 <20201216231550.27224-5-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216231550.27224-5-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 20:57:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kzQjV-0009e5-Ot; Tue, 12 Jan 2021 16:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610485066; bh=dNamHuFItSSHOK3CTBZ7Fn6N0UaRHR3x5ULHZGNCQ5Y=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cB1vuvC7qgji0M5xl4XZRpKqXKffix4/iI1I8sDC0NH+G8dItN1Qu11fiw5+T2wer
         1OE97BKbXq2Y2obRHg++SzwlzkLHnnMjOrdeyBoZDvf7ahxQcUPIbYF0TOeRg5J0rt
         0QuUqgmuA2mIJx4nOk/ue9MuNrG/us11QR64p5YQc2Fl6URCm9qqTpRju1Jc84Kndv
         vN6h/Y1AJl4Boqcpp/HAzif7Maq3N+7tF8ZEeRN2ZF4ECc6xjfrwa5h9E7vGDCLWuq
         DaGmRuPKWlqEYlfE/KWJRQVJ7CB9Vy6j60X3h9HR3i441hMY8DT95QqL1LhF2CZifz
         XCM6zEoG/tIiw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 05:15:47PM -0600, Bob Pearson wrote:
> The allocate, lookup index, lookup key and cleanup routines
> in rxe_pool.c currently are not type safe against relocating
> the pelem field in the objects. Planned changes to move
> allocation of objects into rdma-core make addressing this a
> requirement.
> 
> Use the elem_offset field in rxe_type_info make these APIs
> safe against moving the pelem field.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 55 +++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 4d667b78af9b..2873ecfb84c2 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -315,7 +315,9 @@ void rxe_drop_index(void *arg)
>  
>  void *rxe_alloc(struct rxe_pool *pool)
>  {
> +	struct rxe_type_info *info = &rxe_type_info[pool->type];
>  	struct rxe_pool_entry *elem;
> +	u8 *obj;
>  	unsigned long flags;
>  
>  	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
> @@ -334,16 +336,17 @@ void *rxe_alloc(struct rxe_pool *pool)
>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>  		goto out_cnt;
>  
> -	elem = kzalloc(rxe_type_info[pool->type].size,
> -				 (pool->flags & RXE_POOL_ATOMIC) ?
> -				 GFP_ATOMIC : GFP_KERNEL);
> -	if (!elem)
> +	obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
> +		      GFP_ATOMIC : GFP_KERNEL);
> +	if (!obj)
>  		goto out_cnt;
>  
> +	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);

This makes more sense squashed with the

https://patchwork.kernel.org/project/linux-rdma/patch/20201216231550.27224-4-rpearson@hpe.com/

patch

But I would suggest a simpler answer, the pool APIs should always work
with 'struct rxe_pool_entry *'

Here it should return it:

struct rxe_pool_entry *_rxe_alloc(struct rxe_pool *pool, size_t size)

And then use a compile time macro to enforce that pelm is always
first:

#define rxe_alloc(pool, type) \
   container_of(_rxe_alloc(pool, sizeof(type) + BUILD_BUG_ON(offsetof(type, pelem) != 0)), type, pelm)

This would eliminate all the ugly void *'s from the API. Just the
allocator needs the BUILD_BUG_ON, but all the other places really
ought to use container_of() not void * to transform the rxe_pool_entry
to its larger struct.

Also I noticed this when I was looking - which also means size can be
removed from the struct rxe_type_info as the allocation here was the
only use.

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index d26730eec720c6..d515314510ed6a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -128,14 +128,12 @@ int rxe_pool_init(
 	unsigned int		max_elem)
 {
 	int			err = 0;
-	size_t			size = rxe_type_info[type].size;
 
 	memset(pool, 0, sizeof(*pool));
 
 	pool->rxe		= rxe;
 	pool->type		= type;
 	pool->max_elem		= max_elem;
-	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
 	pool->flags		= rxe_type_info[type].flags;
 	pool->index.tree	= RB_ROOT;
 	pool->key.tree		= RB_ROOT;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 373e08554c1c9d..f34da4d33e243b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -68,7 +68,6 @@ struct rxe_pool_entry {
 struct rxe_pool {
 	struct rxe_dev		*rxe;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	size_t			elem_size;
 	struct kref		ref_cnt;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_state	state;
