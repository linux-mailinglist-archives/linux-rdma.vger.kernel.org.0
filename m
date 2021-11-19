Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10264575B6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhKSRlw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:41:52 -0500
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:48352
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236900AbhKSRls (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 12:41:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7f31qh/ZfFG3e0Qj9NEfbY3MWJkrx7ct8cQWa3no2N+2cEeFNFOUqdlV0yCHOPISnPEYpYJPDoc84o8pzVkny+38Y0lFEMgtBfukjNw/bk3OJV6pzzcpr528q/+Wkhy7i3Qfrb0ARUAYT7qzysGq28iusuRS/Qk0bkr2waggf7rZAVZRx978XHJOkGRLmLWu/AONTSvnnW2pu2TDZU13KF5nR8HZqR4xFBsxSO98orzLwzDFnnujx18piyARaaXroo0Vj9P4G7troY9dRsatoVbXULl07CDSX7sx4OvOcJR/zbeu4RYX53xryVHqNzDs6/0E35dw/JepsodAYIrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcJOoLTxdG16gYDfqdv1AUlKzwXWhI2zzE/yWuJqxgA=;
 b=RfntUW9ROmERR778xAp08X1Asd6ryTMDfIP9QWH3KrDNFkDesAIPveFjm7sKqulCzdInCuN3r3cgPiV+gZ9O7xvCix4Fk3pXn6ygJ92yTalYlW99lvg5IVTa+8UBfH3q72/1cuHLbL+NXyrrPQM2do6k6XUMxLB0JNspB+C5zVtFLZvCCoaaGMSh33PAEqwhy531D2jn6+o4iptyB2LPgBOMhtk1MfdzVj+txcfvPsUcIuz7nG13AMT2EJ37cSV9CYnszQNjY8ERkTIHzAWIk+4zM9D4LBF6t1S1OX1KY8kVva+sBh1ovq+pFMnkukYl0D7jo0Bz1t3OSx14UuAxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcJOoLTxdG16gYDfqdv1AUlKzwXWhI2zzE/yWuJqxgA=;
 b=tHiWyRdp2d4JiUMeZrv8j+eIEhqif6L0f6UuIQ49f6iKXuuJElyAJAtApAQNgBy0zrUVHpzFZGSWJAl6+eheIWug6L0xv2g508xv3+shuzzV4ZHjuHpwHm9HhkxVIEW/emZvHkmJlZJOVd8EomKmmjbb2IzE4iS/BzrDVJCfMzxp/SFo3TpUIJbVpKikIpO1Zca0nT9FY5rsqLLBaTabU6Au+urAn1rCvJIOZ4Pn/Er2enbu+fYPzIFY/A0/3t0FhZ7EDLL2R1v0jqclX4SmofKN0HcmkcfsQHltOROjxj/eE2HqUtudx6pu4BC7hMxUTzBP0RnVvmvCNr4j7qnBBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 17:38:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:38:44 +0000
Date:   Fri, 19 Nov 2021 13:38:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 05/13] RDMA/rxe: Replace RB tree by xarray
 for indexes
Message-ID: <20211119173843.GA2988708@nvidia.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-6-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103050241.61293-6-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0039.namprd20.prod.outlook.com (2603:10b6:208:235::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 17:38:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo7qV-00CXcn-8l; Fri, 19 Nov 2021 13:38:43 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc5769d4-121e-422f-c81f-08d9ab836f3d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB511280E985C5D680E4EB6B83C29C9@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2YGBrRvzoHZ2s+2JVPxN1A31bWVIbHBcGmcEUxmRNuowQ47i5xGtEba6xj43jiRMKUOtUdLu/PilesD7/90PswSdENfjD/j8+ehFHourlL7S0v1fSZihRma40T6xTatigSlvlaKqK6S+Kgj000p6s0eAwgY48LHO+F6EkPepDcrMyuBKgorqL6zG64ZcSgbKUXytykWu8pJNMsKDzgYY8DhJYAXmzIRPEOQ1P/ubUa2LcmVPwT3eTnqduLAJwKEWPWjj8w1HForLP04ntlgegzVLddviK9PraoNbknIMkrEGMFOKyeNEPLZlgKaJ2y+91FCDPd+V4FF4uCDSxqPRcUeLh0V3I28AlhjrR3wJI/mt8u7oGGGFcG18PXWQ4KFDFRAD2s2AzqnwuOk91cNp0MVTIlZox1DjTiJ7RR8ioDwg+FYJd1Uv6ry2S3Mqj1/WntyT6gOumsWE8n7cRZnxdYKssb1wjaFm4JtNT3PRqyUxIswkbP+0kDGXUFoHslCdgKe1o1hR6WQajXKE3mZxZCEHW9DUqZ1OeV0TNpnsfzGyqHvgN7qAGWmkSZoyQmT3vPox/4Ox9ZQXDZ/hvMsS/lKZKM0u//8Bqp1ucR1DwL8Keyw2V2kNw84DQ9kHkH1rlLqVCvv7Cw49BJMwBr+1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(2616005)(8676002)(186003)(38100700002)(36756003)(86362001)(6916009)(2906002)(33656002)(8936002)(426003)(4326008)(66476007)(5660300002)(9746002)(9786002)(66946007)(66556008)(1076003)(316002)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/GhjyosQQSFf63kMIUm5Fyva4S6WIIyggSiik3to+vKbij0HgRZMnTgQG9y?=
 =?us-ascii?Q?v9fo2e+bNYtTK3LJ2jaCdmub6q6DT4RrsxhP/iModjCTge3eY5ZovdrNDLKW?=
 =?us-ascii?Q?emp9Qr7IiEA7v3N+6ZkL6W5Dcz6zdzUSXLa6oKEjF/8hsc+bjElEg9eEDY2r?=
 =?us-ascii?Q?FehqcctfC7dvu82zBdH8RN/4S7pW+5jucuCPeY0gKfbqmc9OmKk3utBad2ej?=
 =?us-ascii?Q?W/NWNFYxXEltF7ookFkNKOxCIEt7f2Ws/AZIwRXkRvvZb7XIRC7Jp3ZCHmPR?=
 =?us-ascii?Q?8FrtdeII2Lw2lUgNQW5ybjaZWiWXmtCQNtZnDMkQck/7J8ekAwrGu9agJDPe?=
 =?us-ascii?Q?sFZyZBr8c7Zrd2cs0vddx/NHiiSTW2LbHHrajo5G+NktoCB1qy+JmVf522oC?=
 =?us-ascii?Q?t0YCVKQdPyyzVLN2M6bHxAzw5YnlzV1sxWFuhZ/E1kQ3VPQUZ+0y/kc6Tfnp?=
 =?us-ascii?Q?a9Q/LmLHwr2w/JTWC/349yGJSZ7eyrcrcLRD/2PHEjUgwuUo/rYyxuYv2FCj?=
 =?us-ascii?Q?A2bbwdU4PlRlkdITWflfg7iSSsQer00RHAaM4t6GzaRr5qpBcI6f5pBcuN3h?=
 =?us-ascii?Q?vgv01V4vzefsEyThPVejngOh4CVJfNz295wQWDiHTcRemAftuxf/9hUgevZq?=
 =?us-ascii?Q?jVbKw61kxygnoYle3B7HDPHvLSiCLpRohe8CM6uEjLgKC1DUQQpBFxefoSHZ?=
 =?us-ascii?Q?5lJu0EtbbXWib5v+9o0Dh79bIaFXjUL0Hh4ruzF0NnlSLAGQBKHrpE07BFGc?=
 =?us-ascii?Q?c/L2YmVUhbEsqX8b1jPfaHCJ4Q6mzBICa0tUttxmhwdRYtKpVdRngK8Jr9t3?=
 =?us-ascii?Q?s4k6WZ++K5db4vOEjycSAJG+W67d9P7UeHyfS5YrXWv0d7rXqWnsUHYn/ylo?=
 =?us-ascii?Q?mrbcjh9XoaoTJzVbMBUiArRc5qizSVGgaLMRxAaX3kedN62Sk6HahMbNi0sR?=
 =?us-ascii?Q?guYH0Hk57bsTYy0jjEuqpjv6zgRTuHGGRweOZJxtvrlmPl0qjJ0tRrZlNPNe?=
 =?us-ascii?Q?MurIEWRTl1I1O+ydnUhEBfIVZ8C5jd2SA5Urj05vdGe98rQ5NhN3FzJ+yrog?=
 =?us-ascii?Q?AdS7dBJsvCc8Ac7cvbFmOfhDMr92Foc6HRIDcgwI/lMBQXNHTrv5+pDVOQ2T?=
 =?us-ascii?Q?WCnGwwnv8wc+5ug69DRH++KNmBiqWGsD89C3Mm83QJeYLoNbb/+bVyLT2AkN?=
 =?us-ascii?Q?whk+hfV8Xp/zVXAcfXdYrDDnoUPVZ+BlCFPEYbf3ubn25afyoBzhO0ev8DP3?=
 =?us-ascii?Q?2TDi4ws9GN0iq/UFgjmdK6MYsdIlzY0T3c672+VR874GuBhl1ajZiPdGfejL?=
 =?us-ascii?Q?stk1NTnhDNwBFjHBhTsFQbP1tcYz23hsmgNHjGa/oFKw7EiVHHskbzzCNMW7?=
 =?us-ascii?Q?ZS5AHfliyPwbLV+WrdO3PoaGpsjD/sz/TjWzPrqcdIJECe5F8wvSqZHzNTvv?=
 =?us-ascii?Q?kUjZHLny1eapTtgZGEM6k7bnZawIzyUs1+ahvVuqD2Qg8/BDa7rG1a/ciiIy?=
 =?us-ascii?Q?ehXcvGT3wqUEBd9lmyy2+MiKqHHYR27XACzZRo/S3OLsE1WOIr2NYg8wXfmP?=
 =?us-ascii?Q?gJtL0clCkZoSuA45T84=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5769d4-121e-422f-c81f-08d9ab836f3d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 17:38:44.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx2eSGFepqVBkS3oGMQuMqLhLBsSK5nQfgqtfOFe6f8egmOkLtg5trhrayCHAByz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 03, 2021 at 12:02:34AM -0500, Bob Pearson wrote:
> @@ -342,8 +229,18 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
>  	elem->obj = obj;
>  	kref_init(&elem->ref_cnt);
>  
> +	if (pool->flags & RXE_POOL_INDEX) {
> +		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
> +					 pool->xarray.limit,
> +					 &pool->xarray.next, GFP_ATOMIC);

This uses the _bh lock

>  void rxe_elem_release(struct kref *kref)
> @@ -397,6 +315,9 @@ void rxe_elem_release(struct kref *kref)
>  	struct rxe_pool *pool = elem->pool;
>  	void *obj;
>  
> +	if (pool->flags & RXE_POOL_INDEX)
> +		xa_erase(&pool->xarray.xa, elem->index);

But this doesn't ?

Shouldn't they all be the same?

And why is it a bh lock anyhow? Can you add some comments saying which
APIs here are called from the softirq?

> +void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
>  	struct rxe_pool_elem *elem;
>  	void *obj;
>  
> +	elem = xa_load(&pool->xarray.xa, index);
> +	if (elem) {
>  		kref_get(&elem->ref_cnt);
>  		obj = elem->obj;
>  	} else {

And why doesn't this use after free elem? This pattern is only safe
when using RCU or when holding the spinlock across the
kref_get.. Since you can't use rcu with the core allocated objects it
seems this needs a xa_lock?

Jason
