Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE8B7430FE
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjF2XS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 19:18:58 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:26280
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230448AbjF2XS4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jun 2023 19:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK37CSbIs/dwP8P7HQHIoSM5VwewfKaM6kGAZizCjlwtkwQxpeQDVFhF9YC2A68Aencpcd8glDN8sgujO4nKpCnwPSitcFlvcITsru1u9IcK11clGOJtRpK7sLXMb3tF8uLksrRhfRmOWG28pkO1Z0RnllO8jtlO3kG5jlg/6AuyOTlTlJeFtT7a+DRuLRBQwkSJLteSP9z0WehOlXvxLFq/0/WzfCBn52SUKnY22nFJJ8BxJ2NWGGJ5aW7pfJZbOVwGpbbXlfOVrJ8kGc9mMhJ7vr7cG1RocsMTLAu8A39SalO7njbFXUwAqv3SH8fU5xnCwttnz4GwiP6NCkR3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjewGPxuNMgZiqr2f+67togLgAp0FMrSGx4Fhggr6fE=;
 b=IApjHTAIeD30HgvDktF9I/hKJu5h7yvdl9hzRmBnWDP0bOtYSYTZX1Zg9mV70FnAMVfmtIjta753N9EwZ6QnDQoQZqqkUOsXy2AGMKku8MTH7EkDelBtl8EBpt3OWhXcAtLvge21UI8sH0efH3vA3uSCSvoEdyz80CLCEjd09GOFSc8grbCpi24fbCcuLSewsrV5UlvwgumvJcY02HWj7muKfTP8Iv38tcLn8y3SibMM6oVCealGOZujAiZvjl8SkZJK9tURLwfvsInS2tjDWxMAbsdn9GGFVcsm5XGBvc8RyfRobfZ8j8q02DBjxGBya+QmA6iYrkRiqXqc+VaEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjewGPxuNMgZiqr2f+67togLgAp0FMrSGx4Fhggr6fE=;
 b=Z1KLI9GAcFPbZ31j3223eWLFEs0bboXbarlWPcOOqJDf7fCoHa+Q+IEso+odik+GX2yK0UxqvDwYyHXn6j1pm4+hIKRWKQH+UiUI6Sxy/64gdwwzH2OORRtJHvIwMyek7r0mmJDso3ed5B0g1TqLtI6fuYW+EUBQRZ/qKb1AI6MjuE6Lfw8JW8Ylzzu+9GnLcj7wkYDEvRl7nxqE0s97/n9eKV4mgtv0SYx9qf7sy/bSGRkIVxVIVTPnsG6TBe0LhoS8vk/2Utr4Yzn9IiqT9G42RO0J55WLj6VHgZxuVfAtPEH+xg5k5c4bhHYDjNJ45ocSXo/ZOI4/BeDMn1uG4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 23:18:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:18:54 +0000
Date:   Thu, 29 Jun 2023 20:18:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix potential race in
 rxe_pool_get_index
Message-ID: <ZJ4RXctDIYEhjnQ9@nvidia.com>
References: <20230629223023.84008-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629223023.84008-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0053.prod.exchangelabs.com
 (2603:10b6:208:25::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe0001e-078e-4670-a7e6-08db78f734b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFgGz+8R/n6tKTVTAdWfOM+I4t+/brOZ2wHNSihMXoCdFumZ+F7zBteeIJAMd348xmjWlNv3rQQL5ZtFkA11lATp9AEvg++n1SMTCFHlAA3Ur34d6xVls2Hel/W+cU0TX79djXjES74tI7oCLWaWf+Ww4cId51kcvpryLWCpEZK24GmfMH3tQy53FXM+Uh+s7i7BDnAaSn/6MdZtSNZRpLavM+4YuokFopqje1BI/ClJ24UwEuvqEZgZOiqJacPjXCfgdnxoYyIZX6fcoGDxsf0WXGJfaf0GgR/InHs6f90ZdtN6a8xAC5KjYkW06W79Xn2BFPo7UJ8+oYNkhC5oGUXRrw943/Ir56dA+TAydkZpPgFmsaqv6LxfeisDMfawLKHx+m7ZI9gGJYI3fku+feO+AbMKG3EADTETiDolVFycib4v+cVL/pzRrpcQ+bC/yIhCdXAHCem1Pd/ZClIDyh1pkwL22jpS6ujwfxyZfEiu75f0X968jIhjnXPwwAbJZrk4dsgiWYSZBdbxV31AeQFNYKVIPARrALU4L9amvwxoa1zqyAoDd71U+t3Lumyx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(26005)(36756003)(2906002)(6486002)(478600001)(2616005)(83380400001)(186003)(6512007)(6506007)(6916009)(66556008)(38100700002)(316002)(5660300002)(41300700001)(66946007)(66476007)(4326008)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kvD+fv0JUFf2VuSrT+qb9vGtLdjeFeuWImyRUmpj72RmMNRdfEusk29gOBKB?=
 =?us-ascii?Q?MuQKf0YXw9w60GdiPZd4Q+j9uqOJoXM2VP+4VZht2CQ1lI5uuNXVSntL8UI0?=
 =?us-ascii?Q?4DLvW5qYgD9uGNjX0rJ2QHOUeonvlnTB3Md9MdV/FjtlK51/rHm64+mswayd?=
 =?us-ascii?Q?xnhjE/c6UoKVF4o9xfjbDNBXElHmVH6EHYxS/+GZnODQ/Ob10XAwni4TLqYw?=
 =?us-ascii?Q?OUbRffEz4DPXivSuGi/ZGq1MdX0JNM3LxYNq/g7WnDsnW4Hri+xmsm0TzkTR?=
 =?us-ascii?Q?MrH5rPI6YfaCO6v7fsX4m01EBan9ZmZoI/BMVMLOB0Hc1E+pdYFimHODJkTS?=
 =?us-ascii?Q?YoefYNdYXmtBvyF0QrRCduvJoyTGHRmg6I0EJdKebAEq9UgdTkG/OoYIz/At?=
 =?us-ascii?Q?Kc4Sv4Iz7C4fKCKC6SDqciHlc4+YYwgpdYJe4Bsb8L16JDdZIvUPLDzAQWye?=
 =?us-ascii?Q?2AS6/3Rcc7ZZNalr+WFFMsKM3naEgtFV+nCiB1nKOiZZ8sArphZFr48o4c2N?=
 =?us-ascii?Q?5RJa3A2VJiyBZLR4ZGSLQYCjAYygBzWI0Eg1S0FViGCHhKZNbKk1rYhkrL4x?=
 =?us-ascii?Q?csNJlEyt97LKoso+MAcB0f2NZfm7ph+MC3Z07D5BZehCAYQtgI+wribHIzYk?=
 =?us-ascii?Q?Gas8P2l6gRGQ+RW0N7XPhVJWe+cF9cGpW9cCWsMI17W1kXe0JyTsGmMWZ1K6?=
 =?us-ascii?Q?51nMymmjhCXZ4FsHs4TF7F6GB0BQxM1A1Rq8PjIN4QllvBILiIJ2RhYxVTr0?=
 =?us-ascii?Q?JmjCP6EsbrDZHX8BdUxfEhXALsWS/Jyl79IZRzgoeDHhVef1Nng4fd0FpN2C?=
 =?us-ascii?Q?KoWHF+8KXaBsic4ezv5tGT4T6caeT62kMyPsA6BI2ht9URpxR39AP6fuz8WX?=
 =?us-ascii?Q?yiCccoHkgjjaUwdYv6TSFQEknumhlxRN6yUXr7aELo2aSKPGe6PfaGUHFw/h?=
 =?us-ascii?Q?2IPyRbGl7ygFs+Z4RM4NtGqa+jqkt+rarxHPCzJN6sev/VNAX/o2S6a2aWUL?=
 =?us-ascii?Q?EsctnEly7crdMi0TvuP7nTpQHc44884X5lR514SkqQ6vrT6WsWONCbv3GVgq?=
 =?us-ascii?Q?i9LligotfneMcs7qU1aczi5hnQW+JV3KnFShDqacAjO9hutqn7OUTuLW/15d?=
 =?us-ascii?Q?e+OPlfFiwA50FnEY6OGGOcXpv3202Igki6y6d7MUTbbJ6Ejb3kYQ1Y7t2W53?=
 =?us-ascii?Q?EbmaRrVOIYWcsBd5ZtYv2J8nAru6YtQWZSbxy3gtmUOCU+3TLy4Vg0mjB0VX?=
 =?us-ascii?Q?kdzvhqHnJL0nEaA3S60NUxA7BPDtfx/ub4ZjM7oFZOjjYKFsaRj0XAcADiS/?=
 =?us-ascii?Q?OQg0it9QuvuB36OSa3z701g4iuDdMkD8BtSfcu4bdNbUDlHIqZztf+6px9e/?=
 =?us-ascii?Q?Hz+B+3DELzSfvKagttQ9lolzwKeUN6u1BfqWrfbHwergzZ0mqxMJg7zg6AQa?=
 =?us-ascii?Q?znceRDL9Q+wM8AJlRg4J0KPQ5TssjXe9Qqvg7H4KeIHBIln5w7hRRW6DUwZm?=
 =?us-ascii?Q?ibUFkF470fZQSPauf+7HbC0WIVkSNNcAenZk1+AzmAVcRQ9+lJ7fX1B0tVv7?=
 =?us-ascii?Q?uFQXzjCRKA6/ZZhx+El1cayYE+27dhN821dQAcue?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe0001e-078e-4670-a7e6-08db78f734b7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:18:54.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMBm2cd5dJtSqnv/lHlDY6Jf7I1fjkrmHOXS4wD/10IMhKAdPxUe/bNfTzydjf8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 29, 2023 at 05:30:24PM -0500, Bob Pearson wrote:
> Currently the lookup of an object from its index and taking a
> reference to the object are incorrectly protected by an rcu_read_lock
> but this does not make the xa_load and the kref_get combination an
> atomic operation.
> 
> The various write operations need to share the xarray state in a
> mixture of user, soft irq and hard irq contexts so the xa_locking
> must support that.
> 
> This patch replaces the xa locks with xa_lock_irqsave.
> 
> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 6215c6de3a84..f2b586249793 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -119,8 +119,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>  				bool sleepable)
>  {
> -	int err;
> +	struct xarray *xa = &pool->xa;
> +	unsigned long flags;
>  	gfp_t gfp_flags;
> +	int err;
>  
>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>  		goto err_cnt;
> @@ -138,8 +140,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>  
>  	if (sleepable)
>  		might_sleep();
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
> +	xa_lock_irqsave(xa, flags);
> +	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
>  			      &pool->next, gfp_flags);
> +	xa_unlock_irqrestore(xa, flags);

This stuff doesn't make any sense, the non __ versions already take
the xa_lock internally.

Or is this because you need the save/restore version for some reason?
But that seems unrelated and there should be a lockdep oops to go
along with it showing the backtrace??

> @@ -154,15 +158,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
>  	struct rxe_pool_elem *elem;
>  	struct xarray *xa = &pool->xa;
> +	unsigned long flags;
>  	void *obj;
>  
> -	rcu_read_lock();
> +	xa_lock_irqsave(xa, flags);
>  	elem = xa_load(xa, index);
>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>  		obj = elem->obj;
>  	else
>  		obj = NULL;
> -	rcu_read_unlock();
> +	xa_unlock_irqrestore(xa, flags);

And this should be safe as long as the object is freed via RCU, so
what are you trying to fix?

Jason
