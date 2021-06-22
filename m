Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D23B0C6C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFVSJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:09:54 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:2107
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233243AbhFVSJc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:09:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfB3Z3dh3Q2cARhdObF0NJ5mxQxJt4ibQnwXkJJR0vOvtem5Cv0APNxaTZbL8wGW5iObY+Gks8Sw2Q7FoCGHovygySA2mCqt6CTYqTPand7OD2nsQUMgNmgTL0zIv3EAhjOMKyon8LeGl9UxHQsu4gMYxTq4b7rCrwk8pYdohjCAriRird/T/iEpDZL0SqgQo3gbLJQWsRgXWaZis2OSpTqsfhLGdhxvke1q8b684ZtPmIvCCLwWTTlczL6X3a+TibRXx8KR3+uOhmRKAMHhb86BEr/gxlNkmxDGn8lYRlfXXkC3FVpxT7sEyuVm+jQqRxwGesVcNSun9fJKTfGxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1PeOAcLl95RaEmrpPoQO3Ixv2kqGfdOYfEKZJDaOCM=;
 b=Yk0378JMe7KO5NYsZXLjRd+23EOmm8pywwjKu6IxqVgOn4NhCi1VkdLZ67LajitaxH2Z+gJ4KBt2mM7q448w2gls0e5dYKcTzJ6LLe+DeWoqfJ4CfnK1ccZI9LOZi3OCjcYqaBS3CwB3gLGCTYbmtQNY1J3QF51FXIljeWAWTR2H/09uj+PwuGC/yjUJmoGcvet8abz6iB1WP2nA6/avaK05V633/kqA+oDUa7hCWtUXyYZ88BTr9AocR5PSQfwk37Ffg5XNVz6+B9LLgam0XXSHeeMR3BTiWGwWUBTLJfsLIlZCw+xEqqT+sWjPhNLQyMjbLzrsxNT2Gem+5kw1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1PeOAcLl95RaEmrpPoQO3Ixv2kqGfdOYfEKZJDaOCM=;
 b=cTPQ29vPNuxMHMXUFE7HwdfLmMECFNirBIiVWUDhK/ffR94GukLHeKbtLPnK37xQsWQx4UlnFmB4YY3hLdR7IpbZsE4amrS9wksAu9ssMd1MVJ1m1nfzHemr7MSCMJTA1fGY+8TTeg7A5PTD4dFF0Ko47cbqn1jaUrF2ygkYix8Zw/npvaDdxPljQP137dX+SjEtd3FsPKoFwflEw4BJjtva7Q4zGDvwvnGVZDVp18fTMif5X2eRzIkG/TN4uZ3oaWfnQVD95gUDtDRG4ozeMYF1XpccFev+xOtUWsWezH8VOmJATfM6pNjUqlIC00UTVFN87pXD9voH/OAWI26ELg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 18:07:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 18:07:15 +0000
Date:   Tue, 22 Jun 2021 15:07:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH rdma-next 3/3] RDMA/irdma: Fix potential overflow
 expression in irdma_prm_get_pbles
Message-ID: <20210622180714.GF2371267@nvidia.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
 <20210622175232.439-4-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622175232.439-4-tatyana.e.nikolova@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Tue, 22 Jun 2021 18:07:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvknq-00Aben-De; Tue, 22 Jun 2021 15:07:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba7759bb-156d-497a-5148-08d935a8911e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160E28DA2B7C6E5E8CDE488C2099@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmWxWb0Sz34CjVo5sNxoY4Uqk57ALGLXKNWNzWfSwq5lSaSVqO4jt6X/ZCgCxxdpTwWxUIrGlshcxD+CeMdmf7OZIFZXNkDW1or3KW96bnh/t2Tmi90rBDE/0f+oUuGJkSaBnsm8gnjMnxj9Ildnm1WX9VkvngdvHtn48BzRAgTtDTjlc7fovWM1v9Hw/EHQYjtgxjSUuc+T6h9Qc/BlMMJohcxN1Xz4V8XdNUqY0/EzNrLpoXf35PQnHcgpOjjoV+TPpeHcpzRPyhFOmVLs7hv3aNS5wZO1EvHLwTevVCITGNekKyV7JDjNvSUpFEig/+NUFaF6b5Wx6/B8nhOUa2LmFH6aElco6WqU9VvlfGEgOmVgjRNH95FQdP6ODjERYRsytr47SSMrSSbf9I/aiGiwpeQyTsqqRAbyfp2v9KWjcN94HRiBqvvQHI3Fk1kN5DD5qRysmXt4tzo7eK5B+aZBNR60ov8ZHT5ijrLmSManV0tGGG3a79mxz9B59JbKozxseXEhH4YgzsJbU4mzzj8cPJYBtbHT9mWZhaNilsUc+gXmvsnZxO9MDCQC/MQPwB5+XmROYOol7JarmKMowt42xLVXAEdxoPEyjZAYzW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(426003)(66476007)(66556008)(9746002)(83380400001)(2616005)(9786002)(86362001)(36756003)(38100700002)(316002)(6916009)(66946007)(33656002)(186003)(1076003)(26005)(8936002)(8676002)(4326008)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/hDBU4xlEq7EaaMV6nYssS7Z/NbBgBycCALxEK501AJzfIa8l1yVvY7Dw1S?=
 =?us-ascii?Q?rtqu7ZKDtsWxFYjifBlcsOKI4DIxitDXs8qi0xE9+FZqOeuUFEg5Yj4K7+3C?=
 =?us-ascii?Q?YS+ylz5lDxyW0Rst8h4A61ncoz+diOR2FkQM9aRWCkuzF0QfiiBuVjkvVUTW?=
 =?us-ascii?Q?4lEHWpm335D0l5gFPmoTVhq10sjSemiejfTFwHT3bDzSISK+GUQjjwtjbA/Y?=
 =?us-ascii?Q?CCc9JGMiTb+oxe7xItHy6eD3yZ5n9xgHjrZ0PlfjWWtwQkbq6JLUJeK7XXOy?=
 =?us-ascii?Q?UJx3KjwuRTmDG7hkTuo7h1wDe8uvtEIECpEuudrLZEFizKd4rLQWQV8O556f?=
 =?us-ascii?Q?dck4agLkCjYmR9dO8amz3n+beRY7Mx1j6fC/Cdo7gJjw81mGQyG72O4OK+de?=
 =?us-ascii?Q?iFg2sFQm3EbtVbvT3aclbvbNOL4i83BW2sJp+Nx3FupM38WX/dasAzidZtoF?=
 =?us-ascii?Q?s+TEKxy3CvJ6mFwB6ujRaMhJJzJk24WVjTNuUey34arKQ6YBzIKoip+TAWTi?=
 =?us-ascii?Q?KMPq+OvPZ8ak/VP83XpRiWWCd2HL36D2sD6/vlinMz3oEgNW2k3nyaO10rJj?=
 =?us-ascii?Q?IuF+gTm8yqMU6ohGlQNsLajEUxE3SW5r8n33XR/ROXiA4/v1Q58KoNoygIIu?=
 =?us-ascii?Q?2Mhfa9uW5/RTXyulDPXlPZsTzz6g4sJy0EPUok6z9Cjy2ptM8UAHP04Ebetq?=
 =?us-ascii?Q?nDhuYYz7AkXHXJjD5GyXmzRJ0W9YA80squArYd1D2qPnIFBUzaw6kEXub4PP?=
 =?us-ascii?Q?Ap1+1kyPGPBDhTWcBWwRPqyDzexZ8k1vw1wduKMc7xLNp25aVwGjal8PZeXw?=
 =?us-ascii?Q?FjDFmr0ISIuDOVDwBC9YcWPfgGryDJN2fryhdRMGP0viYCNftkDrjJLAK227?=
 =?us-ascii?Q?FOky13BdbjDRHbSOA8ZNSYiYXI8V13I+gYsEeTJTokHCjsQT4Ap6s494inEC?=
 =?us-ascii?Q?vzzew/ApDbowYCjT3Yxn8FeYuz/i7Wv6+38CHQlOWIlZGXs4KBbm6+nDHwON?=
 =?us-ascii?Q?INi5MI13jtZObjSd4E4i5ZuNfwjpt55H4zdxUxlYjIY0I0/rhOnNq3uIsbnV?=
 =?us-ascii?Q?A7N7OPgP/BQgBC6zoQFpW5yHYLfkyQioMc9zAH6KnchuNB1Kms8PzuvMnlKi?=
 =?us-ascii?Q?iWUMBH1Gf1yH201Yh78xmxGkQXeBXGcBy/oM3twKE9n0/PHNH2PLPP2oR3fM?=
 =?us-ascii?Q?PJqg4hjg2WL+4R/UlkyggWfurHWJl4sFaeP/DFf5iu40XXLf2MIIq25ktFaJ?=
 =?us-ascii?Q?SpazVL6pooH5XGGVTCgS9snpvMw6CD/Mfn0khUEl6hcUsHCtsZ6XUUMyGDng?=
 =?us-ascii?Q?lRfwrmm0NbZjn1d0Qy1YtbOl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7759bb-156d-497a-5148-08d935a8911e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:07:15.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 708o7RtGktdEhdSO5RtxEELnNJrk29DOGXjFJZdTg2kS0o9SMcGIWrBPvaf8lVr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 12:52:32PM -0500, Tatyana Nikolova wrote:
> From: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> Coverity reports a signed 32-bit overflow on "1 << pprm->pble_shift" when
> used expression to compute bits_needed that expects 64bit, unsigned.
> 
> Fix this by using the 1ULL in the left shift operator and convert
> mem_size to u64.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1505157 ("Integer handling issues")
> Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  drivers/infiniband/hw/irdma/pble.h  | 2 +-
>  drivers/infiniband/hw/irdma/utils.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
> index e4e635dc4fd9..e1b3b8118a2c 100644
> +++ b/drivers/infiniband/hw/irdma/pble.h
> @@ -121,7 +121,7 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
>  					      struct irdma_chunk *pchunk);
>  enum irdma_status_code
>  irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
> -		    struct irdma_pble_chunkinfo *chunkinfo, u32 mem_size,
> +		    struct irdma_pble_chunkinfo *chunkinfo, u64 mem_size,
>  		    u64 **vaddr, u64 *fpm_addr);
>  void irdma_prm_return_pbles(struct irdma_pble_prm *pprm,
>  			    struct irdma_pble_chunkinfo *chunkinfo);
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index ea1df5918c11..e50b6f89b37e 100644
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -2314,7 +2314,7 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
>   */
>  enum irdma_status_code
>  irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
> -		    struct irdma_pble_chunkinfo *chunkinfo, u32 mem_size,
> +		    struct irdma_pble_chunkinfo *chunkinfo, u64 mem_size,
>  		    u64 **vaddr, u64 *fpm_addr)
>  {
>  	u64 bits_needed;
> @@ -2326,7 +2326,7 @@ irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
>  	*vaddr = NULL;
>  	*fpm_addr = 0;
>  
> -	bits_needed = (mem_size + (1 << pprm->pble_shift) - 1) >> pprm->pble_shift;
> +	bits_needed = (mem_size + BIT_ULL(pprm->pble_shift) - 1) >> pprm->pble_shift;

Isn't this just DIV_ROUND_UP_ULL() ?

Jason
