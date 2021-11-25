Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE145DFB3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbhKYRb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:31:57 -0500
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:65249
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232053AbhKYR34 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:29:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBlKl0oFbCIDj+NLWZvVkLUqlyXor3urfRiOljuheOXb040QK2GpzKnNzKmJKHADgyykukUbhSnA3RRwPXPakbQQCOo9wyLdrCt/hS96geOdy/Cq3ooEvCTWfOLMK0JWh52yAY1V9NIDON92d/PMMOuj8azW3FniRSzMT82gCHYHWmd2RTE3EPqyb6p/kUCCwmOqVnYB9jDo0N+3mzpyuX5rg+y7kVVVhrkR8qUY8scif1C+zIGoB3OCS69MNf1qFXy9aTjKwaeSWu/26AfOJpauecQBwNBdiY0/l5if6FhGDpMKgwjeJ6LdzTIi0LZOUW8UqGq0xr8ap4LXu6lKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YU2Uvfa585GwOBLMuWW+iYd346h/Bc9ZPL0vcsgXzg=;
 b=ae97CVdX5CJBlyBLg8ilYHM3zOHDxwpsk+dPmeqVENBIa6deBm8HPiN876Qt+CTWfaCyas/rUl/ILqBYHriJfC0H2Zewoc3ydrtyLxoMU9b38cYOdBpW6oSXhyW6qx1Jks4V3xjtcj6etjxHiVI5CLClGU8tpQ8Z1wLefov6gORQfIe86knv75NBILoKjSsFJ7Xkdiqp4lykLsMmzFxmVE/snf+fypWItR+5gmSCGFz/oQO7Ppzb4g9lDf2JY/y+tEA6TH+IMtu93kwedhJHAInXr345IODfbkoUBQw6izpHjn5rWYFxH/wc2ZAboayTG5V7BF62aFs1RV8W4oktwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YU2Uvfa585GwOBLMuWW+iYd346h/Bc9ZPL0vcsgXzg=;
 b=MOgIajIS7FZAr04xq2Oln66sLAyN3bjt8rlZ3w8ukpiEyQqDJqoS9Dox/IixBnU7f6qdLcZKgUL4o7MSYoJR/BjVoOhq9sZzAML4C8Yhlkyh1IBeZzUweBGiIXiBqQF3hGoUcVycDZgJWjHMRUcwFWirgcuLkaHiiqtzlQQmFPwJIsEN3Qijtg9/dDfz2PR0jT1uQvvHvuYxH3C1rJEGpSY7HECReHHvU/KYe6cfWr/BIN/zQd2DwJBXOBtP0fEEXefPeIV4GoxLMC8s4zz2SiGVAHtQo6yxS2KUtvq+E4T6uJCVzZQ9FuCYY84P0Uw/vG4sscdmIF8Xo97GfNZr7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 17:26:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:26:09 +0000
Date:   Thu, 25 Nov 2021 13:26:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Alaa Hleihel <alaa@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] RDMA/mlx5: Fix releasing unallocated memory
 in dereg MR flow
Message-ID: <20211125172608.GB490586@nvidia.com>
References: <66bb1dd253c1fd7ceaa9fc411061eefa457b86fb.1637581144.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bb1dd253c1fd7ceaa9fc411061eefa457b86fb.1637581144.git.leonro@nvidia.com>
X-ClientProxiedBy: BL0PR01CA0033.prod.exchangelabs.com (2603:10b6:208:71::46)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR01CA0033.prod.exchangelabs.com (2603:10b6:208:71::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 17:26:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIVc-0023e9-Fs; Thu, 25 Nov 2021 13:26:08 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a699783-6eed-43e6-e76b-08d9b038abb6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128FD206C70309D1CA72E3CC2629@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoL1WxKf7x4Egb9WanC0NzE6eXvr9mvSyBc60naWiAU49gk3DKc4SneAd4vioZmwqnk6xVpWOqv5MiEOpJdFGdxEc6J9HJ2AoMzkR6btQMLKxEohHPgii/fyVhJMYWEETXPc6dKFSzTrYbtyfpclbO3njv4oP/3IA5Yy8K/Hc5EobUj7RKtXr7bBbTi7wu6aPpOmW2BDA7zDRJ8wXDKpeqizebPkuCBGbYLCYV3DDAHAvL74PrDA8CIcnBJqUEwtHL+l7iIjF42AwVHr4iTWqdyfu5kzn7+Q/D6vZBGo8LKs6WTTr6KVf2jsAyTlhw66VFXlSH6TfrrFWVG8ctHcqZk1HaF0TLd+Vrf7RzZLetRYfzxWKdDrrIrwGHxnO+zeGzcbf9PQRtsrukoZ4M0sReAlWyEXxkR6ZA+CfL+MeIwa284FI/00+DT8VYnuAwlR1LUNFDnmjnrdbEQntmetyxKUauhM50VnR9moarbwDfZfsfZoyXvqMjxE3EU5J+f1lUPvFvPdCez5aR6ulia1cmdkuax/brZa/pnM4VuzHOhUOTgobyPiQzuD4+QawDWqJrZkZsl5tMq1lJjwI4OnwQNk4Vb2NbjvCPUYXA18cQIPQ/PQEELVBYXQ0XXWhMFzIfxXgOslLSkYfE9xemF5Nl3NHAzw6YYqstsNzADwiBSEIwzGR7YmXn90OeHPQMG5E6sFdBeKIfPmfnM9wwDqXI8uYacfHYfVApPRHRo+gGPMqXvZG/cK6fAB16ar4TqzOU4kpbrAqMXCkujR+Zul5bnL3i/6LGjyDf+o4AQiSvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(1076003)(9746002)(83380400001)(426003)(33656002)(6916009)(508600001)(54906003)(66946007)(2616005)(316002)(86362001)(26005)(36756003)(9786002)(2906002)(8676002)(38100700002)(66556008)(66476007)(8936002)(5660300002)(186003)(966005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0LIcDhd6tGDPHQFuJL1iVQQ2lILnX4BYMMwv8G65ynLA4fCTwSYDlm1BS4l?=
 =?us-ascii?Q?UHqOXR9jD3Nq63f+p1QZ4cwEXjxvicT8VF4NRRDY/oo/IeUdFnORJjVxDX8h?=
 =?us-ascii?Q?scChCt9plLLwlOQR0WLwBccJSpC2oUk/2dPBDbp3IINGOwI76btQgsawd1o6?=
 =?us-ascii?Q?OO16fJOrQNFSTaR7tsSStOHV8WCh9qW4hh01mbqbDT2e5saOxN3thQQtfCbC?=
 =?us-ascii?Q?ToCaZt4q2bql9IEGwPpghg7ENa66xF8FTCFCuf9gsJAj2PJgoLmkd2SWF9Wx?=
 =?us-ascii?Q?Be8hfZN5dwW857qqdXlGlOiym2Uym1dcizbhRTOtxs9N4Xcq8c8HNF53LT0Z?=
 =?us-ascii?Q?wOilOePEnAnrbyAgIlWzq2dr8EWswMoOcfi5hyXPoDGFIM4JWYKXwJwykWxO?=
 =?us-ascii?Q?WfgeBHMmMBjq4a7tDXzV8P0Nn+cj11tZ/TBnVq5SJvJn+O3CIjbAqeBzgauV?=
 =?us-ascii?Q?Fm72dq1Im/RgqOVIMWxzIZAvn7wVgx+UzH2XGJBN80dsJW6bj/bo695KgErO?=
 =?us-ascii?Q?JBorwPDgI4W2klplLpD97ow8VIb2oUCJNVS9GiCx861CGsl5N/VU3qjLAM/F?=
 =?us-ascii?Q?tH7PXL/YbbpFOOZ6ecAfq2pMQPFqvySV6DkwAzwQ8Tbs2mKi7+w+sHxnOom8?=
 =?us-ascii?Q?pB3fjw8mkJBsEF7NAsgFGtHamHT5OhHsfMnsv7Au2SDN2Fj9E2/uOGGimorz?=
 =?us-ascii?Q?kYNpm+9XYb80ZQa8JvGKr08bMrpghWATq5FS/0b6YbG+asIhX6K0V8qXXMzu?=
 =?us-ascii?Q?+Re7/qT2Pjr4gibypjjoVQaCZkwEeuMyd7LdjKmR5gD/o9aZQfW8AmF4DF/p?=
 =?us-ascii?Q?bhUmCF67Yo37mhILOT8xgtrMZuxbYJAnDSInnIyBf64wjbcb1zYpnJLWJv9k?=
 =?us-ascii?Q?Qch5d/40/3uUIUAtSLNUdsPac22l2b3SrfdfMa+Zd9NIf0gTVZ0R/Cd2dhHy?=
 =?us-ascii?Q?voImJhI6+ON93KUfKRqNrQBqtZcMn3jhqmHxsM28dizsNsQmBqgEmL9IcdWa?=
 =?us-ascii?Q?Bfa2rtWLPOV/R10RYVzYsiCyvSDTma6F5oK38uYg7bKMelnWl3oZCLRQCdra?=
 =?us-ascii?Q?SvxlE1FLwjWoKPUV9SO6iuF7y4XXqk1UkLXEPmN8UCN9zVbYq0wMPmZs/H83?=
 =?us-ascii?Q?CpwQ+2jZhpDo/wkL8+zCvj7r3/q3q460yuzgFXGJgSNdJ256fTgGAPAkALFw?=
 =?us-ascii?Q?AfGaz4PKBZWAiDebvMKG829S2kQJDTDWKxBMN1nqiqeyN6B5a8QusltaAfTA?=
 =?us-ascii?Q?pRcV4bUtAYZ5EwDpRMWrk8sM6cn6vMFnBxeaAb/vCOgLE0KJTIqcVGpkgei8?=
 =?us-ascii?Q?SrJ+/nqaky83mxDOeW+BjjGyRe8I/oZuxP1IIa3jMcv7lNiQGFuL0Ul5khlO?=
 =?us-ascii?Q?UOwbHWI2YRB1PsbC9ZGvI4AOgtKVvyh9Q3nm2o2du4OYz5x3OYDKfR4SvUaE?=
 =?us-ascii?Q?GLBTzhe7znk+pMPINjiUFIKlys3Z8xlPYz23UctXpZG+sZtGSGWXYQ2tN+SB?=
 =?us-ascii?Q?K0Rk6Fr1OzsQSto0CZfJdpec6XE7BsyprG9OmbeOR/Zl+up0buS8z3c48wQN?=
 =?us-ascii?Q?Hu/vDG8LmEhJKOFBqiM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a699783-6eed-43e6-e76b-08d9b038abb6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:26:09.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bqn/rpzKhQpRnsYkKVyJPnirKIorK/Aa54Xi5EGQkNTK2VBgdvGMv8lUMyiaZ7Dn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 01:41:51PM +0200, Leon Romanovsky wrote:
> From: Alaa Hleihel <alaa@nvidia.com>
> 
> After the cited patch, and for the case of IB_MR_TYPE_DM that doesn't
> have a umem (even though it is a user MR), function mlx5_free_priv_descs()
> will think that it's a kernel MR, leading to wrongly accessing mr->descs
> that will get wrong values in the union which leads to attempt to release
> resources that were not allocated in the first place.
> 
> For example:
>  DMA-API: mlx5_core 0000:08:00.1: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]
>  WARNING: CPU: 8 PID: 1021 at kernel/dma/debug.c:961 check_unmap+0x54f/0x8b0
>  RIP: 0010:check_unmap+0x54f/0x8b0
>  Call Trace:
>   debug_dma_unmap_page+0x57/0x60
>   mlx5_free_priv_descs+0x57/0x70 [mlx5_ib]
>   mlx5_ib_dereg_mr+0x1fb/0x3d0 [mlx5_ib]
>   ib_dereg_mr_user+0x60/0x140 [ib_core]
>   uverbs_destroy_uobject+0x59/0x210 [ib_uverbs]
>   uobj_destroy+0x3f/0x80 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0x435/0xd10 [ib_uverbs]
>   ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
>   ? lock_acquire+0xc4/0x2e0
>   ? lock_acquired+0x12/0x380
>   ? lock_acquire+0xc4/0x2e0
>   ? lock_acquire+0xc4/0x2e0
>   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
>   ? lock_release+0x28a/0x400
>   ib_uverbs_ioctl+0xc0/0x140 [ib_uverbs]
>   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
>   __x64_sys_ioctl+0x7f/0xb0
>   do_syscall_64+0x38/0x90
> 
> Fix it by reorganizing the dereg flow and mlx5_ib_mr structure:
>  - Move the ib_umem field into the user MRs structure in the union as
>    it's applicable on there.
>  - Function mlx5_ib_dereg_mr() will now call mlx5_free_priv_descs() only
>    in case there isn't udata (which indicates that this isn't a user MR.
> 
> Fixes: f18ec4223117 ("RDMA/mlx5: Use a union inside mlx5_ib_mr")
> Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> v1: 
>  * Different implementation
> v0: https://lore.kernel.org/linux-rdma/e13b7014857ea296285ee5cfcdaaada9007f6978.1634638695.git.leonro@nvidia.com/
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
>  drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++--------------
>  2 files changed, 15 insertions(+), 17 deletions(-)

Applied to for-rc, thanks

Jason
