Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41C746DF5C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 01:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhLIAW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 19:22:29 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:1126
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238445AbhLIAWZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Dec 2021 19:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0NIieEohfq5wxmzppPKVmss7eCbj37SPTw/5WZSW+ey9mPrCkRrb0yQosNMFOIPKFU8g1OVLSYx0fJdf9qSJfcu7O6l61g6KMiElMCSOK2AibQdlK5c6kyT6YN05U+9qU4dOAJutOYjiyHy9pBB8UeqDdq6WZxU59q+LO4cDnyFo2upzAnZFPGqO1DABsfTTx856U2h83t1HgmEb/4zWvsbrkUV2oADqSp2zQr7/asJw8948KFOIabU8mmnlynXNP8NUROcCkYK5DjIqBY9MaGeW+QgIY60Q9Bu7kAhErf2Eb3Fk47eDJ9kWQZLiRj7NiKRfAwfrqEWPqK+qh3ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0TkcJZB9/4yGwNCxeRkpohBqbO/2NRwd9NTrBqVUkI=;
 b=AvT4HNmH9XQR8sJni11eZY7UEYTPOyrJBDyRCUyXIdfBGZxXbWLlwCtNVlaGRdqeEgmfe92+OCglL6+6hlgpPe9IRxdhd9GMcrntRf5ELaHAHF3Jmes2ORlsD+MyhzklV+5sKFCH7KszZTm4jld5Pad5rSSn68/ajK9PQ1miXEISIx+fgvDVKy0mIUWwpQu2uwIZhZsubenx0VotABEPjvyOR8PyBaRgTlpIPjkxE2OjIk5bhSYqdvWBmZKI+oGbAEIin7iadgJ9nbr86OH7gkoHU3zGvpEI8EUI16L8VucKG5QrV9S0GbV32MN3Stb3iY79LAClfSz8Ung+XusZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0TkcJZB9/4yGwNCxeRkpohBqbO/2NRwd9NTrBqVUkI=;
 b=FQkJCGCxEwsBfxVbCZoECat7GgO6XKCbu7W1wknaxW8LHGqv3iN+LcpxWsfwVAJSQyZbzBoZAI2PQPpFHhvnZRicMpsXqpH+G5o35CXkhQwXgWQ29RBPtJL3I8fnPNzjnGfGrlr8Qu+EvFBuK3aa9nWwGG2CQc6zd7dYo3bDIYofbLp+VHv8W2tcjg7KlrBFf92RboikSo68jA9RhBYnVgafdunxCyNVe7XpbIeJZmRYos6FQshJZ5ue9rEIR2tEnBkm/ij7M3cuVyzcR+GRQgfzhSx6wWYoW1xtdy9nbczD5rAqD9G5gkwRAwxNp5h3Kcyo6aONX2brubzvWqAs0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 00:18:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 00:18:51 +0000
Date:   Wed, 8 Dec 2021 20:18:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v6 1/8] RDMA/rxe: Replace RB tree by xarray for
 indexes
Message-ID: <20211209001848.GK6385@nvidia.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-2-rpearsonhpe@gmail.com>
 <20211207190947.GH6385@nvidia.com>
 <dc322ec4-bbcc-77eb-0c84-5461d08c5378@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc322ec4-bbcc-77eb-0c84-5461d08c5378@gmail.com>
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b821df8-815f-44d6-69fa-08d9baa979fc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB516092AF6E00713C4BE8D5AEC2709@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5eEPOzwDKr6YXS4nfOEl0UNqZUwF2TiTy95H0XcFby6GCgl84s+ZCkEocEkpD2+87vfPUyCKanMmfdaUWPdcLefJRIeIfsBRznbhu8ACJSgQGbmVBMNi6NXDykGI3RWT+VYaN0uhJwTLZab695mY1+NV36uWLrvfaHwrKJV45+zMdzr6hXvULDqE0Vpx10En2qskUPzSNfvnRYKVQwssAeUZv/5KDfS0Aoc6i47UoqQFPH+8NFUAmmfytZvgRycF5MDkBWw+ZPxMcOcovgnfR3fYQksrMOZ3jDDh8c/kxCM25BqWdjXG2JH3ZB67YonLklvOzJaSUaI7GAAnZRt0tMtVn7rLWwUWLhLPLLroZjqTivL7lBCi6MAWNRwldvQVw4A9qkRw6J74gnNhxkrOaWAEROXYWSE/35PJKMQ1DpqqiGf33QkbL0O2RSfq3DUbL2H8AdSRo135CrJs2QR/5dRgaZjBJ32jcEFR6HSu8EOLfKHxwa4j1/Bs87rkkq6yqdA6ouA5uPjIqyFJDU8jigPOJPo3Hqk03sFe8HZwZsIyS4fIygr5zCZ4tltUxK/fsxlpULmW8DAsG861Z74pg64P+gb3Bt4p0pqMCc/W6bfaj+6Nx/4KZw8tJPxi4HDqD9XolEyoRsSQ9Mgbnp+ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(5660300002)(186003)(8676002)(33656002)(4326008)(2616005)(6506007)(508600001)(38100700002)(6916009)(26005)(53546011)(86362001)(6666004)(316002)(1076003)(6486002)(36756003)(6512007)(2906002)(66556008)(83380400001)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgJVzN2kFNPb3GdmLKDJYRvkXfT4pTbXR6HULcCzEKvKdrwYmcdE937tmv+8?=
 =?us-ascii?Q?Oh14GCjGq1t4G/Jyfos1m7Gh4zbocrycu5e8TQGCOXPSWoZElm1pvRHQfAu4?=
 =?us-ascii?Q?ITxxeipjN+gbcpH3gfmz4/p3+oF01l5dDe5RH8ysSsC7sdtzm722bwskwQwb?=
 =?us-ascii?Q?Q0TphsHEkgaPVZpxC9W/fjoQhePOp+FF85j7+GFS7KRHUkN4lWw0Yc84VQGE?=
 =?us-ascii?Q?abzcPULsOY49U7y/097TqCRvOFTInuHhNmgGTMOppOpgH4KrqFewG4XDiMVN?=
 =?us-ascii?Q?uL+fAecWChlzOJujcGyKurnNvv6C9dWWBmRZ4XDZWQOZS4etvds/vlu4pBHr?=
 =?us-ascii?Q?yH8QVCO6F87YUbYp3+csJ6RMX2oBFSbBxTndZ8dgUCc/8tlxtLIVNtTAysI0?=
 =?us-ascii?Q?+eb/bwSu+M32YgJEVneAOXrcxqbynq72/q65DZBWnEeQTvpdC3LoMTou5c1c?=
 =?us-ascii?Q?e4YTH174HcdGLAqSEWYYd7JVvpaXWX+rNeHkBBl0F6iy/CgLbsq4Y0/VJZr6?=
 =?us-ascii?Q?X2ZLTbMhSlioK4nzDR7t1HZIz+qzdb7ITaOmxAuGWk1SdNI+HZ76btTpIYJl?=
 =?us-ascii?Q?Iz9tp11hRs5fNX1P8IOy/cTEVdOneZZFUViJDTS1f0J8saoYgowT42bcF361?=
 =?us-ascii?Q?2oIOjpXzya4ZWbTQfJXAmDJe8L4RvYdzf6HaRI6G4+bTAamrVR5plHfZnnIw?=
 =?us-ascii?Q?fg8V2FDCFn6SphdpQX8kZparNoBJwpm+ZNSZ9nJQnBs9eBgvvlc9ZF1MnDHf?=
 =?us-ascii?Q?l99LvmLppp9MZwwn9h8exvIvoq0ScuSAw64nqmAg9VPktFO8erTsUHfGYdEG?=
 =?us-ascii?Q?Twt/BjZsoAGY8ywX3r2FDiykR9ELJGUofFRhq/vkTuIwX3TQr5BvZDZoKujq?=
 =?us-ascii?Q?08ASphaUiXXmhbdmYuUccVThpce/QZdMZ9fKZ0dJSABTgf9M6O1A8fQ2/Hij?=
 =?us-ascii?Q?zRo6ZD/xpg3o8dTy2XFlXs6oKHmwgeP9LP87jQzGQ6UW4wp0f3IdEGT9wFny?=
 =?us-ascii?Q?/WVOmR0vKu5yK8FPSqDOpbrchD3oZZMJZR6r6BY+pBBiknitWVpTZnWY07Hc?=
 =?us-ascii?Q?dkDzXMAoerTXm2scj1eiwEGK3DKiCjM9YfmlOLceFr2AUFv8zOZuWdfU8PRT?=
 =?us-ascii?Q?Osr5P65fyfl4QuWbJ5QtNsahcwfEMnnrU2S1Go9FowZ9EZBOPQk9KaVit0K+?=
 =?us-ascii?Q?+MBiQio8erxNpXyub0Pj5SuesJGlY1+i5s2oKJ1yOI0t5uxU0H3wLAAJefSJ?=
 =?us-ascii?Q?f/Ls0jIJghKWK+HySstgVObXOlYPgxLACzXy6PclcCJ/7Gi9JygK5rF1/auP?=
 =?us-ascii?Q?qfr68E8BASjlOcZb7zvyAu3oj022lWqAyztttB0FPZozLOVtdCWP6ktMpvLo?=
 =?us-ascii?Q?hDRL2pBalzctDjP7cCaR9GFkbHxKPTn412kIlXK0QkHEp07CpsfS7EQ7VAHO?=
 =?us-ascii?Q?C9ozrzNlOQ+IFxHdC4ip/a/XeZowW+VHuR74r3+w4lZ7pdV6dJwqFK1sqiKl?=
 =?us-ascii?Q?RhSpyZK7CFx6l2XFdWQPuuVKduw9scfqs8kBKYljGDFdLWZyMb8tOVBI9//o?=
 =?us-ascii?Q?wKIt/5fXljCAnBU8Ess=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b821df8-815f-44d6-69fa-08d9baa979fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:18:51.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRuXAkda4F+vLpe4B+a2dYlRUi7Mjj6bzhD6zGEfWq5TeA3m9lbti4/fXjms43os
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 08, 2021 at 06:16:21PM -0600, Bob Pearson wrote:
> On 12/7/21 13:09, Jason Gunthorpe wrote:
> > On Mon, Dec 06, 2021 at 03:12:36PM -0600, Bob Pearson wrote:
> >>  	if (pool->flags & RXE_POOL_INDEX) {
> >> -		pool->index.tree = RB_ROOT;
> >> -		err = rxe_pool_init_index(pool, info->max_index,
> >> -					  info->min_index);
> >> -		if (err)
> >> -			goto out;
> >> +		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
> >> +		pool->xarray.limit.max = info->max_index;
> >> +		pool->xarray.limit.min = info->min_index;
> >> +	} else {
> >> +		/* if pool not indexed just use xa spin_lock */
> >> +		spin_lock_init(&pool->xarray.xa.xa_lock);
> > 
> > xarray's don't cost anything to init, so there is no reason to do
> > something like this.
> OK
> > 
> >> +/* drop a reference to an object */
> >> +static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
> >> +{
> >> +	bool ret;
> >> +
> >> +	rxe_pool_lock_bh(elem->pool);
> >> +	ret = kref_put(&elem->ref_cnt, rxe_elem_release);
> >> +	rxe_pool_unlock_bh(elem->pool);
> > 
> > This is a bit strange, why does something need to hold a lock around a
> > kref?
> 
> This also relates to your comment on 8/8 patch. There seems to be a race opportunity
> between the call to kref_put(&obj->elem, rxe_elem_release) and the call in
> rxe_elem_release() to xa_erase(). If a duplicate or delayed packet arrives after the the
> final kref_put() and before the xa_erase() one can still lookup the object from its index
> (qpn, rkey, etc.) and take a reference to it. The use of kref_get_unless_zero and
> locking around kref_put and __xa_erase was an attempt to fix this. Once you call kref_put
> with the ref count going to zero there is no way to prevent the object getting its
> cleanup routine called.

This is why you use kref_get_not_zero only during the xa lookup, then
during that race it returns failure

Costs nothing as the atomics are already all required.

Jason
