Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9107E46C35A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 20:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbhLGTNX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 14:13:23 -0500
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:16417
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240856AbhLGTNV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 14:13:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z91qwsd6OOdac9sSGxAMeJ6FvPLCzZqY5Zh/+jvrSHWK2Ay2ppBuy7FSxtNYZiGX4kPyZ4+dEvMAaH7jDSYdOrVvqPKV3D1Xm03THzr7chHz0AzIUS/c7W7n6GWytADT82caQssFVHB2CKmu5xfW71vaZRyhsPqdv7sVFd6mpPaJ+jo8CHnFA7Vu9b8q5otmeggc3xsukxVZNhcCJEgFSy/hpHEyXJoqZKqViFoZ1CuYWAg9Hg9uraHjNFxVaXK0PMD3/FEnZIclNMkeikwVmia/tSjRYvqua8m9pHePrkKXwRO6AQ5+vARYuBrLSVYbgQCtTcZCBRVy31bOoJntuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBp7kbYaLizpPTM/DLdxLWIUlDM9LG27Lwpvnby+F98=;
 b=IsGKVQKLKZSwhKI7NmvhjUqtG8aZazHxnNmBe11DBncAcdJWl75BMol6C1QRHBzXv82doTC/TgodSrRFIbVAf37rLT5wtVzik7ThM3bMWs9k0tFW+LjGCqAtGSpomqia3yLrLStopYrDiewkK96F9FuKNxTZjfrKC8Xj32apZtm8CklPsa2qWaoKbjD+Qvh/W3q7jo7/B/B+HNOBmc4FWVP7V+JrIvxlcapdvZxFy9Dh0XIe9uROVcw02renNIXkByoNdWJVXy5+lxdwHUaTltAVnR0G8/kE+xFKlPenSaZNLcHfOpx2Wih9XCe+FIhdEk+lO4zLvuY2/hyeQC03ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBp7kbYaLizpPTM/DLdxLWIUlDM9LG27Lwpvnby+F98=;
 b=aQsLxhhyuifm6Qc4yEVLkjtVRb5VbvPRYxln+aD8T+KkAvnJmunQ5nMLwmi2zoBr5tMA7vvftubS/354OuXKwZHAISpz0g2pBVmPUfRjf4sRljbl8ZO6o4LiwO3iYolt4i1BuCOYUPBs462ArRZ20l/QQGrfsYaaSWkvQsThH8YWrz1HPzTmteh18me7rh8Kfvu7K3AyQnJCjKI4tOzKXz47BeQxgYpUe+AM8FfaM0f6/m3L7wuq3p1UDsWvU6WNOwqDwJURZiOxwNtcZf9qrAAOOQu/+PaB7Hte5xProAmiSc6qPm+GCDBgBr7eA9Sdem0NiKSpmgA4q8+YDMGceA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 19:09:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:09:49 +0000
Date:   Tue, 7 Dec 2021 15:09:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v6 1/8] RDMA/rxe: Replace RB tree by xarray for
 indexes
Message-ID: <20211207190947.GH6385@nvidia.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206211242.15528-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: CH0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:610:b2::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:610:b2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:09:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mufqV-000WEu-Ix; Tue, 07 Dec 2021 15:09:47 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea66b773-70f4-4afc-ce81-08d9b9b523a8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5521BFAE302DB6FE1C71FE6CC26E9@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6dnDeuIfetJB/Vur/kKh6803F5p5lJViWSs46Ff3WkfBqhzf7plg7U8li+KbS4YWKc17a3TxD0Bx5f0lHG2yHV3HzxFcjMF8NmRFV8XFY+s4DCDYNhS8Wxf8HQEm2jKviBNm12vOV1c/Kvla1IK3Q+ynR5fBXEzP3Jf3zjw2WrSfwpodlMksxMOrT/TOirKhIEl4KmBFf234fFkDKTsYpHcIHaT5eG9Jdi3mM+IVhhok6eNaMa+vArkHiFhiXMmWo9gGoS/srFZri1rKexVyzYH3Y1uikB64Ju805Q6afcNqSN4iYVNO675dAg987k1Ly9AygnDCk6fw1j2fgAay+i55Qxsd9yU4iHNV7KaYa+V/EKrYVbZ6Ur5E6A/zHcyEiSsuWdF/LwKAnqbIY3hwSHozuUQwcIDt9c1inr5D+pzYswgxzLeJP9Hn3JHUdgo6MeCE1vQhs4t51qBys1C44inC5k9Gt2Fgv8DM5hZf56YphqAYx01xRzX6BawM8M5+KkVx3T08ddspoupTXf1BQlemOX/QTQNghH4ByMUgrzDa0Z+gGazXqk1Xc6LVQYSWVkK231AuAHXANGZGnJO9G3qu4ipaxFRnBXgVeKrj2e4LRFNyYJdtuOfWg1QFhXiTl1RRYy4zT19cnG8RVHoHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(4744005)(1076003)(83380400001)(508600001)(33656002)(4326008)(8676002)(9746002)(316002)(38100700002)(9786002)(36756003)(426003)(86362001)(26005)(2906002)(66946007)(66476007)(6916009)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3wZ1Vj4JEnbttdyoVfPTHY5QOG1YlzkzLwzUCJitEilwjHm3pCtLszEKfc0B?=
 =?us-ascii?Q?mat1xCmC5X/fVdO1K0KQrexuawm9GtnBIkV8e+rMRMrl+nPFSvFL/4LjHv+l?=
 =?us-ascii?Q?td/SHzGNcD3loN35eRdSt88gNgrDA4hcZIIIJ9Fq7bBCIJhNEDU+3kLaaFG8?=
 =?us-ascii?Q?Gu1o5qp1momI2/3Juwz53ETEymQ0jfLOJvg4JazfIFmoPvel/aWQhhYg1O3L?=
 =?us-ascii?Q?jZ2gF/b3p5Z1adZPZv0BXYM/EPbjUXgBCIs560sJb+RisNNJKa0YCOrOCX1k?=
 =?us-ascii?Q?tox2w1a3SfLqL2/ooV6E8tJETyZujXmC9Z8wwzWnLbTVWCdRhnJAugiddsFi?=
 =?us-ascii?Q?5cjctXlJy1WK9NwU2YSW3T6to0e+hmTWipYazJZDqnriFGIj9sh3AAmW51Ck?=
 =?us-ascii?Q?5Lxu+RE/JtetYVzqQV86BsseqjD7qvYFVesfuxnNDJyTccFwIfczQ7MUMRbP?=
 =?us-ascii?Q?4g/z12vGFce5qpibae7354ESCtJhJEmb3tcQRkFjXZwbv/zl5JevCmOxFiW5?=
 =?us-ascii?Q?VzwG+Xn0WUsP/dC06cjRdzPt9t11TJKsYJfYtgG2eb17tjzGyeZh5se9dLqV?=
 =?us-ascii?Q?7XULBHa0w7yN/bXTbqjeqfhASqrbncB3plb8na8OvBjzIHfaMX0alboWSQRp?=
 =?us-ascii?Q?9CzlNSN9iv3S2VrVJ9C1Ip1+Qi96nvKaf9SZmQgCHYeckMjTWKYvtYGxz8Ky?=
 =?us-ascii?Q?Aml2AeTLeXot7plGwp2ZTnSQLieEUvcR1qPGoOm3tGD1uCkFS7vAihIOEd4B?=
 =?us-ascii?Q?VbBK26+qBJYcty+QXOmyuaNpFw+48QedO1URWvpx8jckCO+etvcfG1ynQgv/?=
 =?us-ascii?Q?69b+gg8xzSQY7Nx+aqco/aEwtBdihRI6cx0aqKIMTvAPujwyvqekRdG9hfrn?=
 =?us-ascii?Q?NLp6zOcqzO0V76XYuDbH/44UULxKxTunV1Pww68xUXGmkzALSa4cOFNawS0q?=
 =?us-ascii?Q?rhHzSO5An3HmEttGervJ9OGa3m9TnOESaZC5V8wNs7fYiFx0wr8oUzqKO0TU?=
 =?us-ascii?Q?Ig/w5pA8xwqXu1FTHWcdgoYoO5DRO1G8l42KwFiVdUrOSYosC1FIHZ+ul7oG?=
 =?us-ascii?Q?zU7fk73t8uKU/brILXNvC1Kdh/4qn8F0MA4caGa/X60E38S2a8b28rLr43xs?=
 =?us-ascii?Q?WoociIjdOR5Wq/sY5QhjjijRz65QpXRT9F366AJ4lRPxkyICbxA3Ctc7sA+p?=
 =?us-ascii?Q?WElICjRyPWq3rhqVBCwAdJOLfJhR4ampxBkmJBNs8sqAY6cJkTVezxuS8Wbf?=
 =?us-ascii?Q?5+Zc1x2paPgn444L2jgQxR+N3IrRKnX2T2LYylTxyRBn7MAT3KBja5kRD7j8?=
 =?us-ascii?Q?HGjnlyiwH8cJqOXOHi2wY0bGJ0V4zkcH0mHn04e86JO0CyCoBgG9trmldRdn?=
 =?us-ascii?Q?nNMHEK4KcBRo0pVAIq2tExpuJuBUIZGzfwliumBg26usH2ZBTJwrau16aJzt?=
 =?us-ascii?Q?R+CgPXnVO7UsyltxJF9W7ZcX1agDV2a+PRToRHcLvxvhm65FULHeevkItNTv?=
 =?us-ascii?Q?0qngteOvFVG8CvnB0tHRN2lmCtXKRn1+Cswa+yUTtsYftJX2ygdSBqiyApuK?=
 =?us-ascii?Q?PV8eaFhFNhuWsRQNiQE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea66b773-70f4-4afc-ce81-08d9b9b523a8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:09:48.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlvuXNYqiwV8JM4lSQBG1VATbUZZwyEKXdvsNM26oKAJ10GI2s+psf0YXPr2ARLs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 03:12:36PM -0600, Bob Pearson wrote:
>  	if (pool->flags & RXE_POOL_INDEX) {
> -		pool->index.tree = RB_ROOT;
> -		err = rxe_pool_init_index(pool, info->max_index,
> -					  info->min_index);
> -		if (err)
> -			goto out;
> +		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
> +		pool->xarray.limit.max = info->max_index;
> +		pool->xarray.limit.min = info->min_index;
> +	} else {
> +		/* if pool not indexed just use xa spin_lock */
> +		spin_lock_init(&pool->xarray.xa.xa_lock);

xarray's don't cost anything to init, so there is no reason to do
something like this.

> +/* drop a reference to an object */
> +static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
> +{
> +	bool ret;
> +
> +	rxe_pool_lock_bh(elem->pool);
> +	ret = kref_put(&elem->ref_cnt, rxe_elem_release);
> +	rxe_pool_unlock_bh(elem->pool);

This is a bit strange, why does something need to hold a lock around a
kref?

Jason
