Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973A146F295
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhLIR7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 12:59:54 -0500
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:35392
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237660AbhLIR7w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Dec 2021 12:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+LRaHI6eXYG3cbju1NPA7iovrC+xdz+P7RAUs+nnbk2sRljHY+N5KFVfePfQCH+8HbC8Aqbg1a13MWOXmQk8Pm+bZkMXqFGe5SOURZ1tKaHwuVZCCV+1JeiInbR0LlD9UK7S+/PB0aO0LnxbQQMFbJ+FJqIAZNkT7u3VyVHZWQfGVlZKSOyhySd6ZF7STApkkoWN4oeLgtku8jnHf5Ig6pmInR58PPH3iGxHtYpOSkIZhtzOANnSiW8vFNgsRJurlk+7n8BcZPparRn1JKLWPY4Nn5V5SwMk0MDU73FeTePwYhKf2ZqHWAfUD8WkjBJJukD3JGbZ7HJc6pbvmhIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywfiK9bLiypi/L1zDl8V2WbowT2uha+aTAkEzo8tXjo=;
 b=GM8DuIh7wtdVyob7Vm5tiI3uWolRXEMaxRa7D+L/AKm0CN2T5oHk6fKhLhnYWRIFhiKNwuWdbzlbwUUVvyYoak6JLQ1FkgaQHj3yjPvaMUvZupH7z2rcw9GNcMfq09ZWv5q3QbKYVxwoCLleEVPctXAgN3dHJRptwopoe99qdAIdeej4bCNkmb6xpZdSX34lxweEwJuyjuO+Qjp282lCLJOq/RhiYQ7DLvl7ava30f0PDjsdINJW++OiEUzKefEZ5fHsu/r3gxLiFc6y5RcchwcC00SPyGtdR6633HTkBRQpsMJ+YPYQdoeC09D1auNMget9KCT4lwQGFAplI0JCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywfiK9bLiypi/L1zDl8V2WbowT2uha+aTAkEzo8tXjo=;
 b=k1oUx/3w4DyC+wNyYOI4Cop9MPHvXbbXOqkglZMaTmK04JVQbtCPzzZYhV1t03+/w7tWYb4wRPW+HKfkA9fY4uBb3Lc5dV23sCjO9TfXCRtWbWG7kkmz2fiW4IIvK7DcvZbZcbqvcxx1L6wEVFIO9FZCYlrCWhZtHeyORwFlogFBshpQntEVCvuH3OTIh3qM7LXu0nET6QHLRimNvrqE+kACpgfxRvgRKBduwIPZ3YALuKB6WQkNJIAYBeruKHKRn8Lf6xkPnaPiC9jNAmSH2ZgrCT3trnjurXifLaf0jJgH2NLxrWe1LDbvc2H2UuuruSU9C8OM3NMB6+EQ8Mfxxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:56:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 17:56:18 +0000
Date:   Thu, 9 Dec 2021 13:56:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Aharon Landau <aharonl@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/7] RDMA/mlx5: Replace cache list with Xarray
Message-ID: <20211209175616.GV6385@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
 <63a833106bcb03298489a80e88b1086684c76595.1638781506.git.leonro@nvidia.com>
 <20211208164611.GB6385@nvidia.com>
 <9c1d9ad2-0619-16cb-4be3-c763668639de@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1d9ad2-0619-16cb-4be3-c763668639de@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64887b38-eb50-45b6-2fda-08d9bb3d335e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206B9E2F0DF3A2A3F4D9B91C2709@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnG+nlVGM2xvrpYujaLAriNazhBpbsvntgBEB9dinNjKTIT+niz85YIVsXvnDTQTiMhRHd1VH+raZQ9bJ/U6VVAdAIpvBD8B5Qpqm8ObKqe2KAX4pM1LbdOxjOQJgnvCmje6UZ5wHTC1UltwElsV7/ytvXsjHSc+KFABVCb4qy4cy9qfRKgDGKNUNyhW+tfC+FA2ecb6KalX0UmPXtTOPjYUMkEKq/KIH3zEVCqyopiI27It48FCHBqf7El+/8hrtZnna0F3ucDOFZbtV3NsBSI6y8QrH9ZqHLhHAo8CAvBrBQJUrCpc3bSzNGbjqiO4SwK35dL2qSjnNsVvuZRhQy5pNnqHXn4XvkgRh5AzMaaXCb5d/wx7ZxXAarjLTDBVop1c0/ZrO8IHYi2FYiRhuIn0jXTUSyW6o848XktZJr4twHixsEOgsuoIkCAPWxaP6OmU1VhlsbRmBXG4A74//g14cSAzkSxbQt2CUcIV1ZZOGxN6dCsXdZmJOzoRrz4SeOdO4xpMsTVCOufbqBIpr4u5DW9uO/qKqGoyKhHGU9/uM+s+QUm8r0Dz5yFpurcghD9IuDZnFu7wJyRSl/roB2cirbLLuc/LCR9mqRMYmrFkKJqPfZxBhp5943NWz23KaFp+9ySSFUDxH3NtvPg5o8xjjTcAPhq/W7y4SVpiSzZBETfqwAkiIg1Oa41b3ZrkhOvV0YHJA3ewwV/3zXnCXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(2906002)(316002)(6862004)(33656002)(186003)(66946007)(6506007)(6512007)(26005)(2616005)(66476007)(37006003)(508600001)(66556008)(6486002)(5660300002)(86362001)(6636002)(8676002)(83380400001)(8936002)(4326008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yr3e5Kg9xJCnA2Wh0PLyEINxNkPQjmJYsUZu6FD4odI6sgrwyhYhca/R0i4B?=
 =?us-ascii?Q?1Cui0RepvXFmdoCNZOoTVCCN0T/l4phz0y56yxh2ZKW9nAs6asTs0TPq0c77?=
 =?us-ascii?Q?AaUMhjeQ79t4B9nK98RqmSj+Mx7v3KczRtsNgj5R3A6zH6GMYCwCznhi9sLi?=
 =?us-ascii?Q?u2p05SzJcvRQyfusuMAYOZWNpkgdXQ7iH1BspRzn3u64XKeVOcDcmWnB6MPr?=
 =?us-ascii?Q?qhxd9apvfcxXif3dH/UT+USd673menFhNwkvr+5sY3RuMj3RQclef7dtcmj5?=
 =?us-ascii?Q?w/5AM6UPXhDyfjK90CFIOa43y01L6SXU57+ANvVhdJUA0XNlEpzAETL53gzO?=
 =?us-ascii?Q?yhX11XlKI9hXxZiVbSZQqwWxm9Aghj2LZbn/zcfeTf/KeCcdvnnajvzODBjD?=
 =?us-ascii?Q?q4Akaj+fz4x0wU+yKnJgJ7FPPwUWV3Fpz3It2Qf1NNuLrczExk7ueDHj5Vt1?=
 =?us-ascii?Q?YFk15a3g1YrO1Xi6lS7BYR6SW2DWX5r9IKjFyjL3f2Ari2OxmKreo8Wztzyq?=
 =?us-ascii?Q?ayAKHMSDVLcv3iXv58ISnAbQut7FieUDVkRGKDt02mWSGDMijUeUs8QtyvlH?=
 =?us-ascii?Q?omac/QqA+YsjK9LbiEHQbL4Y/xa00N4llkeMSJN7cTVgVTdaxcbGTqhgU17B?=
 =?us-ascii?Q?hzHIsg6nIYbXnF7aOj9dde7P+R4Puq5mXDSKhd1OT/Pm6pcCV1IpXvdJu8Tt?=
 =?us-ascii?Q?RziJyTjtiFqTBoiVEJIryVx6DwGQkRHNYo2i8/haz7X3Pg7Q32cAQcK+AwPZ?=
 =?us-ascii?Q?Jw+jLTbtLJ3cspC9y+NDntrQ/DnTzl84z7Ph7fxXH/bkT0eZC0iNO6rrrZqD?=
 =?us-ascii?Q?azuVavFW9mf9Z1Qh9dX1k8tCJfYrXEfFq/yIOaTAAWxX4Fahjht/WhQm2MjD?=
 =?us-ascii?Q?W2FbsjqsnvWW+9PzI7x49kZtLVIibv0BD+lQsuQZ5SWrOcBIqqsFP8kGFf3p?=
 =?us-ascii?Q?mPtHZste9Hz4P/47SwD/vqSwEjiLFSJiZ46TWJECy19Sau9hU6fdJUBjkF6b?=
 =?us-ascii?Q?sQdtqcngPaux+ohn01eWkyoUgYfTE4wPfe/fIK0WGa9n04vouiaWucssOAvm?=
 =?us-ascii?Q?NTnSYxAZdouHtkItAkGCqLV8TMTFOaoDatDZ0mjNE2/WRUL5v1k/Vv7M42Ne?=
 =?us-ascii?Q?X1jwiBgQ4Bkbx+J5gnSN9OP6hKFn5L9A4k2WojJVP3jc+H9f7UMLUZvnq4Ks?=
 =?us-ascii?Q?CpTXZGGIdbm6f9zRrPHh4C3SCEMKZGhH8T4xdqFyEG9Mxw+nJ1kcSvGNFN53?=
 =?us-ascii?Q?ym0+p+pP1qdKQ/9fiqIa7B0/e6VU58HTWdQv+i+duGqCK6wrmd+KEpRMxP4E?=
 =?us-ascii?Q?35OFhJfH/r1KEVSDWgTE4U/1i9nV9qRN9BVvmcTz6YTrMqpYRDParMwvw/HL?=
 =?us-ascii?Q?dCfHpdrfW/gFVK+SDhtyozGw5xq/NLFxw7nOTZGQ2z+cotMNEO3j+HlLih6J?=
 =?us-ascii?Q?SAG1Xd82XyFUBaQIJHAUo39s7xbZo2unFFXsrXD3+GjA4JT1okQiXMubv8D6?=
 =?us-ascii?Q?lRCP4mLunrHSWyOB72IS249RkwAD6puJv2yhfzSSsZODOgD4GcaCMGAsZFYK?=
 =?us-ascii?Q?aTY9XY6FqklwXZZHvaM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64887b38-eb50-45b6-2fda-08d9bb3d335e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:56:18.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2YkXupWf4ELpz2C2WvwMuHL8WlY++w9a93qky3KAnPiYFuJPWiPH7igOPTn2XCS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 09, 2021 at 10:21:22AM +0200, Aharon Landau wrote:

> > It feels like pending and (reserved - stored) are really the same
> > thing, so maybe just directly limit the number of reserved and test it
> > after
> The mlx5_ib_dereg_mr is reserving entries as well. Should I limit
> create_mkey_cb due to pending deregs?

Sure, it is the same concept, deregs are going to refill things just
as wass as new creations.

> > > @@ -287,39 +318,37 @@ static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
> > >   {
> > >   	struct mlx5_ib_mr *mr;
> > > -	lockdep_assert_held(&ent->lock);
> > > -	if (list_empty(&ent->head))
> > > +	if (!ent->stored)
> > >   		return;
> > > -	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
> > > -	list_del(&mr->list);
> > > -	ent->available_mrs--;
> > > +	mr = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
> > > +	WARN_ON(mr == NULL || xa_is_err(mr));
> > Add a if (reserved != stored)  before the below?
> I initiated the xarray using XA_FLAGS_ALLOC, therefore, the __xa_store above
> will mark the entry as ZERO_ENTRY.

Oh, do not use XA_FLAGS_ALLOC, this is not what is it for

Jason
