Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242C4457611
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhKSRtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:49:45 -0500
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:55711
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229585AbhKSRtp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 12:49:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUdiuavbCUQDj1By41eXJNbSA4sorCDRx/ldsK4E5MT/mV3s3av5hpYU78O1PF8B12N9oxYs3qbTwRVB9jecnQ1zTZ8c8DJlIvbW3xLHKVCKd6X/V1+HM5BUh1tUAvb6YWJ4R2p73p6PZcaBcWip98Eyrf6zdwIX6/Ey0i9cHsu0GdQ1hFpQ1+GXHnepU/7t1gaJSTqI4CvA2OIZVVslJn6/Hom7nDJ+xbbOK/n73Bj2EV6QVFdieAnObJwqOwYQNh66s23BfWEtmi4dyiFQZHk4twYjo3CVk1wJ6DNzU29o4/bt0IoCUIUoUd0i+nv8Fy26t/0doBmK0fiV97K5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+5Ih/bR1I+iTkX9jXxMfZNdhzLITMJycGhiQVdfpVs=;
 b=naL3+8jK1XtIld0o49JN0nchODtXjINdvVL7c4mjq41k0QL4LbXm/IOtol+FebNYRalsy0LA+pGrQk7oP13rYdh9xAqgcmDRwxBuA14QdTlvfEalpxhEk6BSylztCea3qp0Sya5hHNkDWv2h+MbJlbQT0BLobID+cHnGTk2WT1tCdjMen0SHElYvnASo0o9faxz8ka/jNbF9/Oj6g6pU4AJKduALjaV7WQ2mCaSKOByEkGNOLew6uy5iDbx3bIn/Y8z5aheP8coyGtJCmt6PWFNgLaBSsmYiqpJGGMULPO34ZCy2wKglsRImij4gWEImQ1zhcUQUphFA99vJw9hQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+5Ih/bR1I+iTkX9jXxMfZNdhzLITMJycGhiQVdfpVs=;
 b=mXpcSH5I5574kFaR36OmErUfyFlkexEMCseFrRt6I5XCrSVVaG5wmpjSiTtVog3muxnbtF02cjt87I6Qio+1oEKZIXpldUv1VuJS/FzbYWsQ4aR7RbJiupS4Xlcr+hFM9HZ8QnKe7CNGxmVZ6RVfADEvlVLeEWX+d/EDUXLFV9i8HW5r/ELrg2rWZzyJCLR8vr3IMWTzKx4ZaBmD/cWWy1ZPO3MiOvD+H/L0O459m8upADX1qZr1OIgLAZpwX4BLtQpORc6ZGy8BIAZoA+M7VLaBCerWexrH82pKhO3BMghmbdYvdvU7kY9PTU/3ZcDNXLR2+WVjsbXoJTQeRsXiyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 17:46:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:46:42 +0000
Date:   Fri, 19 Nov 2021 13:46:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 13/13] RDMA/rxe: Protect against race between
 get_index and drop_ref
Message-ID: <20211119174640.GD2988708@nvidia.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-14-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103050241.61293-14-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 17:46:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo7yC-00CXlI-PI; Fri, 19 Nov 2021 13:46:40 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b40134a-b5e7-4022-fa94-08d9ab848bd3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126725166CC2C08F3D96490C29C9@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqUQDJCGEhPUMqvP57lUucVCkjWs0EHGndc27T+xekBxJSgPtE5mzJkQCEem/j2z7JaVzOd5xVEAWoBv3tHYzCo7jJIlTYBqs700Se8bsdeYifEuw6mmOYq1W6ULr8mE1PxMtjCVk09kv+db9/Nk+7Ne2SkYUp3ubxSj6/iKDAzskezCxJodz6PAkuvUYL49ruQomKTUuaEyrCKDNAcd/aiHXrLTmfM5y5Oov9y1r9jwkHMONiZDhHqnx+SSk7AvzHWSs8KTA0wGz/YgcV8Hs9ZnpOV9NUvV77pwLsnS5YrOoKg5tkdkyQb2dgkZMeE/04UlqF8G9iU5Ujkg0yadrAPyM/KWx7eyhiLqsm9ttYPjbBpTtxfQc3vtTxOSLcmTVFSk5MPuL2U/ny65SjrJoxC9N9n7CCyyCTzbUGJl+Py7mOOMGSivuZL6/rblWSqBAD3dSk+pDgz1ophNdbhe3gZU6E1QTpKMt1kgXawStH0w6nC9T+JXiiigTQidhDECZGs5LopC933/G6Y+B1e4Io903MMI8fUuoYkxBWFcljkf2zVXar3tbJ9rpoq1PUVhkNHc5VxhomIu05tlelil3iVuVp+sot7n0JJFDoZdbZt/mlh4H6IteOVWqod85EmCtq1yImwLXps+ePCEM4M+CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4326008)(83380400001)(8676002)(8936002)(186003)(66556008)(508600001)(2906002)(36756003)(9746002)(9786002)(66476007)(66946007)(86362001)(316002)(2616005)(26005)(33656002)(38100700002)(1076003)(6916009)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Di3H21e/Be0GUmxI8+9HaL5TZUFbIGJkIZV8NH/fU/eePq1QtsZ4m3aNH+oE?=
 =?us-ascii?Q?Ytt56oBDUem2u2PmzgPMvZRaNEYN9uG13byY7SX/Lp/rVWL0+UxLcS/uWhjj?=
 =?us-ascii?Q?kbheqfuBF2V+MqUf9nkyz0ld8Sh/0Qh2HtaTc7ESLVxNogyeGUKmF6PK4UL+?=
 =?us-ascii?Q?hL2UjVhQNh3N9Z5fG+SylTLv7tMi5rMnt0uc80xShtCAFCK2EbMinQDnWjo/?=
 =?us-ascii?Q?D6b6i1PTMKXNK6HmkbNGaBvYAp2/ecFmyZAC3E+wAQJJM4zbLdBPOGb1PjxC?=
 =?us-ascii?Q?XT/SIw74nBb1E5s1ZSMwU5OEPdzOxMs9S0vl+BmBP6MB4gFyFtZS8s6UKtD0?=
 =?us-ascii?Q?dq35nnDB7EWDfrEeEWjLaXayypQF61MTJzwqadh30XX7jJxi71Fxc9IXVt/M?=
 =?us-ascii?Q?CK7awqycwEJh7ijnmzHjR4bih8oxRxSrCZYXgfOs6sC2yQj8ux8smFdG1hgY?=
 =?us-ascii?Q?BoLL9JAvIaVvq4XG7HtjXNsnHh0o1pFOKyaCuonP+fGISaCapl3dgfx54k4D?=
 =?us-ascii?Q?5Xc1mQyONnbVj4okkYhPBSseluqLvmwzY0fVLK7HGaMZS2YFQ3ICY2utTuRF?=
 =?us-ascii?Q?4SmbcxKsdKvEtJjO7QsZhieC0z0xbZ3tzhHgQ1B1XYdCzsx6FTCh7uq9d4kO?=
 =?us-ascii?Q?2PtnxQwbpbCrXscCljjF+3TtSXaAQfi+cX/0Huq+8b7ZsNoL3YUR/jzORGzz?=
 =?us-ascii?Q?S4JfG2f1fL/k+87KmW/LPDu2+ImBHazaHBv6FSlPcp2UqIKbsTv7gW86jdkG?=
 =?us-ascii?Q?QHRoM07JnDTJycw4JKa8HprPUwpuUAV8TmqRRxbPGbKz9xrOy5KdSZ6hVmhx?=
 =?us-ascii?Q?hiUYllFrRnH2q24BYki3vINEV3FoQ4OhPBcnk4Y1ZPBrv9u3zaJVtZj2/vvR?=
 =?us-ascii?Q?86O9ENV0W+X05kMQjwRVLsxJuvKeG9WglM6vpDIHKXXRKizoZQpeFn594FtL?=
 =?us-ascii?Q?UaloRVCw7ymzkgM3bLr8gEoJ5/5mPCFOjx+DfM0zImIvMNnm4N8uQtDmnwl+?=
 =?us-ascii?Q?6mbgECtkqiYkw26reySRjGgBztD9Lc9/9i3l8RVPNSoYYRTje021UklOHMLz?=
 =?us-ascii?Q?0dczzJiD0jNFmKKKe4Wj7gE4uIDYBQNGrduw0FGQQGOvrHit0QMu0Ic/od+M?=
 =?us-ascii?Q?TIztWbk5jb78vRQKsAjb27rpovAI9m5KBM5LsDcTapBBLXDvGXDqh3NCCfJh?=
 =?us-ascii?Q?jzhZG6xJkXUirO3TsLjcf3eE77WGvkRRUOZ4dkuX1Mt2hYqjvifLn46IWu5Q?=
 =?us-ascii?Q?mggO5xtHO5SsXZ/0OkVARgKNXU6C6jppACc3Ia9aHf0DLqDVvmcxm5bqYKrD?=
 =?us-ascii?Q?vcIAXj7nvRSE+IAFrZkXra1rS6VQzkszBsOVuGdGvvMXAn45KV27CJo/13lw?=
 =?us-ascii?Q?ExkWkviSnjmYS2y2QiAyxyESq6xHVXfpxJz1hIUYI2WYTHR+cytRpmUCK8m7?=
 =?us-ascii?Q?m8rwT7cEo0v81IvI7F15CSdenTrvi+GiBxEYMR9v7l45v9SEZ0GSbEdW8L3M?=
 =?us-ascii?Q?tlZEI6Y0+nNf/dQRH4VFyIhhe0XVrz0gDCQDZ8dn2ZezsB27CNFPHfS2rG0H?=
 =?us-ascii?Q?B6+BFSKJs7r2a431I5c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b40134a-b5e7-4022-fa94-08d9ab848bd3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 17:46:42.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn8n2wxpiWRHypqAnoSkJf8wKMTHPrxo5aAAPlqfIERdnumjLUrB6iu5mfyFcoD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 03, 2021 at 12:02:42AM -0500, Bob Pearson wrote:
> Use refcount_inc_not_zero instead of kref_get to protect object
> pointer returned by rxe_pool_get_index() to prevent chance of a
> race between get_index and drop_ref by another thread.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 863fa62da077..688944fa3926 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -272,8 +272,13 @@ void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index)
>  	}
>  
>  	elem = xa_load(&pool->xarray.xa, index);
> +
>  	if (elem) {
> -		kref_get(&elem->ref_cnt);
> +		/* protect against a race with someone else dropping
> +		 * the last reference to the object
> +		 */
> +		if (!__rxe_add_ref(elem))
> +			return NULL;
>  		obj = elem->obj;

That doesn't really work without RCU, since now you just use after
free on the ref_cnt atomic.

Jason
