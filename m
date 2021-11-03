Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933B64441ED
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 13:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhKCMyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 08:54:25 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:54593
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231343AbhKCMyY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Nov 2021 08:54:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJWySGlKSKDtZpxUaX4uZeOl8NHe8wxjRcjbvbetsVze5XxAAzpCAFMPXrK9ynaNAQJQ04icmMunlI2T534iA80KiFLN+0QtH3ZJAIfpbqOzxnkKU1tSAUdV9XXLsWKhOFlIpJALmHRPqSY5dnlWp7lc/LLIhErAeKDBi7EfY4g7kIAMa10rC++AH0V0RzJ5kKQgpXr5L+IhgKyAlAo9ImaNMieO9hIe7PMOi5PvC3CD7UMT/+ah+8YMnMRIiSv4Hcm1vsFZf1a+Llhm1mxWTY4qcFOV+gXYKNt1cUQiJ3i6JTunUoJsNEtCwQG3qjq7M6fCm4azNT+6EHW3z+MwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opss/6RUy2VSWWrC5gAxEUguc5TRIsXpCfVFoNfJWEs=;
 b=DZkwJtj2W0t/hCqhqny+l2xn62tknksG7x/OZhapoXoMmJvsKpB+JphadVUejOjT23yFz3gZPZk3Lz++Ni45OGoegZrlOgObL+gz8gpqr+mSsDoVwmR6nvnUiILn0IPOfo7CHzsMxUVjNbfu/eZ4Umdnln7Cwerj2PIRIoywpmRViXROiMryDdHdvqbJNy6tSpjoT8sq6YG4M2TMrpNW8eGsT9aphl/Q7OhoeZsPnEWYG7p2qVDP7/2oGHRdnRnWww47EDPCs5WGqTasKCmlAKVpvn76vI2wmjTtcKreqQxaFnMY82Z9QWtX0BFwcbJLwzYfsqlHFp150BZnnSQawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opss/6RUy2VSWWrC5gAxEUguc5TRIsXpCfVFoNfJWEs=;
 b=YeBsBnjRLJ5hfJmclztM6WKsJ7oPAqKODkBdHbXUE3zBFJIPadgnfOVmXCvYT0/1aO0qXU08759n68Ma3KDW4awHpDJRQXuLSdBSxQLXHyZOy8UCcWyJIODuB+ZzOLwNW/HZRifbGUjjaAHPjc4WUaIF8/RWwHdhAfQDSzV9EsS2J/MADnNCSNeAY2lpFl4UoYmcteVFgXOGMsbcJctFDMHJ81mZIaR2WSCLWA4cjmCxQa/srBR3hFCUQjmuzNY8C83T9+lsm6ai6+tFWJY+GfWTRFnei+n3cz7+SDjzqDsHu/cqsnheVKHiSrLdxgNlNUtfVMl7IIqrX5Sfp7fQXg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Wed, 3 Nov 2021 12:51:46 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::8817:6826:b654:6944]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::8817:6826:b654:6944%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 12:51:46 +0000
Date:   Wed, 3 Nov 2021 09:51:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <20211103125144.GB1298412@nvidia.com>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 12:51:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1miFk0-005Ro5-Op; Wed, 03 Nov 2021 09:51:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2c127a-b011-4f77-7f46-08d99ec8b1c2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5264:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52640B7056DE4BE58A6E607CC28C9@DM4PR12MB5264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fB1+PdC6hVDwyKh4aK+0gPUxIr4f1dXIUcTMc+RYcDZbU/+wfDEAC3F/+viZKA7XLDMnZ6q5zIpJVjGWxKQ8iAWOPgL7vBkexkzOrH68i++43FDc5j0tW4nkVYCQXLr/0WZqwXzeE9/+Mdh1MGXY86smBKrcYa+mgF7N3eo1csuUv4ce0BEJZXaiyBArUIkQF9I8YX9JIQjoIzeQ0gUopG5+Lvvq3Gdwcsjf4ECfoGk7lsj1dxGu7IwZHOwFUZUpZCaok2/MvjVvX9NkNPbCTml1LCCQm9CnkU/sBsbrdrL4tvSVVFBZyG+Ht0cKQZnueTcR0Juc9/mLjgeBuMZMuYN/c3yhoUBtyQz7wHBLhtgBAu+4PgTL6/9vB5OXwqU1nHw+FI24qF+9gvHoQbu9zfwAU3lLG1V53nF3w+V5foIw/d4MGWH8uExb8FPghJGm64+gor1jp8FN9lXKd8PaXrnUd7c0IPmivLdqOX6rwr/71Gd3Q19eU1Yk8m06nV+1LcuCyto9J9/y9UHzGajzQDHCVsSpGZqetUJqjMlSGsA6ihL43saH7xbS4yQjZhZtjK7tuIBHK9dOeuU3sftItn4ARgVNTCU9/mDTZ4ufNjBYTZYdrf/KgXkmH9OPgE7Q40ETbFVZlWvaqx+GoxF+5PJwgZgooQjA+eg7vtJGrNPZYXoK5RH48lsBvEsuTq4YQFUU4Nn+bR9gnXAlykXCMy+ZdbHd7WGxS4vJ1G4J8oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(966005)(5660300002)(36756003)(66556008)(9746002)(66476007)(26005)(186003)(508600001)(6916009)(8676002)(2906002)(426003)(86362001)(38100700002)(4326008)(8936002)(9786002)(1076003)(316002)(33656002)(83380400001)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6yZ1Sc4rqb5156FU7FqynMZ/5nEpDU7c+3CMW4mlVscf73m0lrwvTwmRDXe?=
 =?us-ascii?Q?5pbhiFWZmo5uDbA9sNpdppNgv7slWwQ6ceIMT9tz1WpyPqOFQgzOgXwH+RCR?=
 =?us-ascii?Q?hYqeR+Nr2tLZlJb89EQJKBaPuanHHngND6HzveMPKbUrcvqtHEpxfKIMGQFj?=
 =?us-ascii?Q?7pd8spPOQWT0rrwmWnAQodN6JKWde+lFM7ub0ZuMrUEhM4G44OoXR5X5zHCH?=
 =?us-ascii?Q?TMGxADBDJlz6Kzq0VglmnDKiueEt7WQ/NJjb8S/c1MxNxC303MNAdugGCaFR?=
 =?us-ascii?Q?0r0ss90TbGCS7rGaNcUMwUnKoOMT7J8ejXbxoR+KKcWDVVMsero7TtzkMh2u?=
 =?us-ascii?Q?T1tlFvjmrpnt54y6jMlHyS9QqLiVKHoCKFlmYt2Z6f5SAXc4XzSflyxC3lBr?=
 =?us-ascii?Q?sAZeUUgyJyrz0cwXbHQT8TV62fYzfSLmNc6DVgoy4+Ie6OXfumjW3CojFlIj?=
 =?us-ascii?Q?03syIxY6LfHJ7YhflNBNKktvhHkpMOOnBXr/OQrO7zJheK6v1ktZ4AznXGwU?=
 =?us-ascii?Q?vC3ekGmchtMVkhE8vPi8Bk5TIpZeGyYoZPng65sDVPhRO3ggaKy5h0GDDRZ0?=
 =?us-ascii?Q?0m213CLERaoSLnddvk72ODVUfCIgyiakMatCSfCTQIP9oI9vpLJRXvyoM/7o?=
 =?us-ascii?Q?5TZY/GYVliAbINs6XvJCy+wnaQq0Vak+6c3a6tjpjCoNqKDB4ugMTAm24eTz?=
 =?us-ascii?Q?/5rUlohFIIGtjhV9nrUvtrWSsxTAY83Pi3Ztuhxq2fiUEM65IlPAJUI7iMZa?=
 =?us-ascii?Q?rswM06jRY1e9ntmwKTsYzYlFJi8DHYgMBPAv5igxv8iP0hbS8melDG7GMggD?=
 =?us-ascii?Q?bJjAnb+aDG4ly8Hr4o4NnJdqVWrPNVgi8YzjJ2dfQ92pgZdeWLtWbDHZs9Oz?=
 =?us-ascii?Q?XanYQPnmaFHAeM1nHi7Ntqgw/v37bwkaCCFiM9dTIosGOP6LgXS2jshwwkgz?=
 =?us-ascii?Q?vxBSa/hWrW6BO4IAdhOGNX9lVrCAEQq16qDYGvtbJUYj3WehRiP3ceHrhh0V?=
 =?us-ascii?Q?YNV+RVgTnArbUZTO49CgxhRmcxj+kRjYRm68owU3lOF0AvoNccUmU+UbHXJ7?=
 =?us-ascii?Q?FsWEOlkKgKnWmZjI3DW98wuLIMQhn5zZpszJ/FRdcwFYKUCJKGRd/AoDXf0A?=
 =?us-ascii?Q?9TFYxlnqeBM8uqRHMcPpup7fnDHX09k4EGC3okiXpJbB4l3VsdZw6j9J8oNq?=
 =?us-ascii?Q?laoei80w94DKnzcpIPVrwD9polah0xJhJoMgzNCZDPVEQhV5ecJmFHF+ZP5q?=
 =?us-ascii?Q?JBwrQ0XrZQR1PXhRnAjaM1eXE+Bl9bHoxKSaxyO66Ki+68smP9MrxA8NEDlR?=
 =?us-ascii?Q?TwDfeMewke84WvBomzWaZQcif89PBgkJRrdgcZ9bBi+vGS1h7st0D64+Danh?=
 =?us-ascii?Q?P7GI540AyXD1kr6UyfLnEd97ADwaPcW3WlllIZYBHm15rRidsF01fytCf5qF?=
 =?us-ascii?Q?OrLewnJhKx7AQ5XEVfgLOaB89GHCkeTg6anRgYcPXv3fFAWWPjAMNlo2PIea?=
 =?us-ascii?Q?JRyiSv9TrDCCeN00MMEN1J4zlL8HL42wRu7ALyiOblIdsv4Hl8FpcJ2g60ro?=
 =?us-ascii?Q?QVTOxdMDUMu/fhOMtTI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2c127a-b011-4f77-7f46-08d99ec8b1c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 12:51:46.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwV2pkFKPJx8hGRRJ3z4b2DY8W3BwAHDQbaovQ5oIsqhQrGEynfVLCx4d45ea6to
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> flag is provided.
> 
> Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 3 ---
>  1 file changed, 3 deletions(-)

I rewrote the commit message:

    RDMA/core: Require the driver to set the IOVA correctly during rereg_mr
    
    If the driver returns a new MR during rereg it has to fill it with the
    IOVA from the proper source. If IB_MR_REREG_TRANS is set then the IOVA is
    cmd.hca_va, otherwise the IOVA comes from the old MR. mlx5 for example has
    two calls inside rereg_mr:
    
                    return create_real_mr(new_pd, umem, mr->ibmr.iova,
                                          new_access_flags);
    and
                    return create_real_mr(new_pd, new_umem, iova, new_access_flags);
    
    Unconditionally overwriting the iova in the newly allocated MR will
    corrupt the iova if the first path is used.
    
    Remove the redundant initializations from ib_uverbs_rereg_mr().
    
    Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
    Link: https://lore.kernel.org/r/4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com
    Signed-off-by: Aharon Landau <aharonl@nvidia.com>
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
