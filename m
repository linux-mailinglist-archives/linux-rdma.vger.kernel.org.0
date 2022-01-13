Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6448CFBA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiAMAcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 19:32:25 -0500
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:34279
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbiAMAcX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jan 2022 19:32:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwBWOS4yh8YU+0tHEs47cP+8c2PWO7j0N4KX7LQJKsSGXc25ExmnuhSxvti79tYxAKboBCuFQa2QvtBf9ZKqWhbcuwVTEURBe+BduU2ghxxY4gUZpuHO9UkCasbsqfPqbx/Uiq00OHgiAJwYFigFk1UVwr2vbK6wLs3sh3uygzn3l5Ai4YUtNyz2NrV6pgvXgTGgJE7cS3Bc2JDhpsqWm+Pg3g6KWIemz6b+jbdxf2rhZSiQdiCxHTNtKfKSuBvOix5tmfbzmLVBNYuftQTLPmh7kLJ/nyJ2OD7knQKqNM72jFW0zYA8GkjH6hhFjTfZJmsc8k6I8/jjqc1Vp7u9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6GozDyB2R47krWnH/O4PF0hF8ndir41QaR1guC5ofE=;
 b=S0xxshHgdRfHI7y9CnJFvqblPPvN+5ta/m0UBmr1IuJzI3rlSDOQW7PYX0DkbJBqmSUnGivtvGlLaijvAFNUD1+tOYchwkTRkVjqsYzEkQSC53UKWm7Ekcc9i60odAt7BNrbJyqvizbgFmOoE5LG/b9vN1uwrqr7Z5Brg8x4aBYk+hiRDxnNRVWwqwMRAchdtK6yFAaVpnk1oItq6icCiVspPB/m9g9b1BFRhDCQz/Jtk/HLLMthwT1EmSOtBEocqLuD+C1Rm2nSMLoZZ2c9LCntRI1iRaDmm5LcLp17AVblWemyOOBGSc7LAUTgpJzV72lo7DlHIavHc24TPCBo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6GozDyB2R47krWnH/O4PF0hF8ndir41QaR1guC5ofE=;
 b=KDdENGWA0Z8cx7iY7RsH2G4TYOWTbidRHA36QyYuSCZ3dTLdwnU0K/wLf8g4CoBSz0JDCbbgEWm/0LXWhScQb2tJFGHGrGOhIigmIcC9z9fDaaeg06s7Zf5WbFz6lM8r48xcYmrDpJ/OC5NNCuOB2rmUINR64WWfbvxfc0a7pdat2W7TEbn/bL6n0LMseRB2OA+HwXPuAvGPUMIaBFclGzx5/VM4bTJweSOLgFjcuaXWASZrL/rsW4BWR85W3KQYWgKTnSxXHJPzTYfqPe+1UZb1vkD7PooS4u/o27+BaJJk6/pApkkMW4EpbTL1RtjIgFCgilNVNSk8Ua/Ew9cjFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BN8PR12MB3169.namprd12.prod.outlook.com (2603:10b6:408:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 00:32:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 00:32:21 +0000
Date:   Wed, 12 Jan 2022 20:32:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Message-ID: <20220113003220.GX2328285@nvidia.com>
References: <20211118203138.1287134-1-keescook@chromium.org>
 <YZpPr2P11LJNtrIm@unreal>
 <20211207184729.GA118570@nvidia.com>
 <202112071138.64C168D@keescook>
 <20211207194525.GL6385@nvidia.com>
 <202201121247.BB9F6E9@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201121247.BB9F6E9@keescook>
X-ClientProxiedBy: BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24134cf-9228-4554-e8ea-08d9d62c2985
X-MS-TrafficTypeDiagnostic: BN8PR12MB3169:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB31698FAD5598B6F55A7C1D4CC2539@BN8PR12MB3169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMqdR6hodb/N+zf6l+u/4B0yf+Cy1+4QpDmpjpKnJ/DNVL/mwBqoOy1pJj1gxSjdff6d07I2LV3g3PB+Q8or5mbuea0P432V3UYuaeX496PnqLGhGVtBluZXi6KTZbhIJGp38cb3uk0ntT9df4EnGD3dpBlyE+NPxnEgVYdP8ojnezNfbZ+mXgtibQe6ioWJejKURZB2mhSykUxwPeBylKvcEavR8M5afn72QNMidRfyWnPhbDkZYkndMLawA78xEz1HdI+KjD9CxvBcKpLcvohZBSjK0qRoPw/whIvS6QpUBrDFlKtkh1vfZMPCsSk3A1TnTnkuvaiPV3ZbCXIiTZAKd9z2U9UQLoaGxbm6AofygifwLq+a2eojbCTZBBhLVyrMSk1K7Nh8gAf0Zv/d8Q14xrpnVhOEnZ2JUCUiWgWvWCjdnPYOZt6uM9SMgAjy9Hr2fK53e0dJHVHoehtf3mPFqPatl+6P+gIliM3JtERsHqE7vfCa6nQHoSq3O6mVb6280q4rMy+rFgOxZqy8EOmFcO6GWNUi0ptMpWDTvwBcHTyGXk8b27o513FVL/WquG9XiyUSgaD/tfHnvRhVfZaKemXXi7IXKFGiCschzkVWypjUK+zv29Y0Dx0H9IUGjC+zbsyYgPzDOPOgtJR53g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6916009)(66556008)(508600001)(1076003)(8936002)(83380400001)(6486002)(66476007)(5660300002)(2906002)(66946007)(186003)(4326008)(38100700002)(2616005)(316002)(26005)(86362001)(8676002)(33656002)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HO2JUSwGWJwLkRUHkBKNX1vac3YXF5BewJDJOtSiFsoR7CWLLlWLSLJ/XWW8?=
 =?us-ascii?Q?sThnCvoSjpdkuYGP2/UvGO2XaMmqmX+5kZrZ9XVpsST16NmKdU2mDb8Td9dS?=
 =?us-ascii?Q?3/TZCLbv4NvQJOsoRtNfxph+HQ6zgX1ONkBc3XNDtu9vQPj5051gZGDs7J6G?=
 =?us-ascii?Q?WBB6gZ6kVvvZQf5L0yMG/Ds+pkwkgcv6W3pAOKYrMHT6TonJj0SbPbpHkIS5?=
 =?us-ascii?Q?eQpetdXVbAvMl+n+VHJCYkf5qcMTZnlK+nbEdbpg7ux4HkCbWJJnMlmBvdFE?=
 =?us-ascii?Q?25GAaWrsHknkH4jLwdSC6s2ZYKdU6/tsW5Z8k2zUGleGt7J0LY5aBiZNeCLI?=
 =?us-ascii?Q?xAfeq0AXgdCP/bE7e9MdqxiMzVWaVBg0o5oWZbNKEX+c67ehcMjNklRe2HmH?=
 =?us-ascii?Q?BA1EwXtt8yX35so2NUQkc4rTpgzvdliT/busg0QQRrdkB16YWUD/4Xz0Bk6U?=
 =?us-ascii?Q?RqTmZ0aMTK/MGpYZfYLC6ZuLl25NPabDmTrHPKZHjLdlt1XJ+G+xQK3BKG6X?=
 =?us-ascii?Q?pFCYocYWrkbQdCXrTraNNYRmRtwVP2holZHbidu4f82e1uQNcOtDBxAzEEJB?=
 =?us-ascii?Q?mDUpDPt9asN/cXZtKu/69MOY1Co6GyxQZ7MsXTZejSluNWYIqpSJJsVayH3i?=
 =?us-ascii?Q?LtMtMak9ohmQolyOtQ2Ew0CYi2qymBKqMfcicEBTqkvCFlZDt5ZgZOw9+9dY?=
 =?us-ascii?Q?k1BWGHl92ACMwXmN3ClVK62ZaD/BLpBLUIvTJMqdQ/9LA6p3MruokNOrzAj/?=
 =?us-ascii?Q?PEuDI7k+B4xxujR3uIJeUitIAhhAFQXW1kYnXJmEcvko60B09d1rziwjZ+/V?=
 =?us-ascii?Q?R51jzz8jQ1HCuy0UyjFIMRPbJGtLn1TidQtdGMZCU/z+ezn5xavlNBdQfSpN?=
 =?us-ascii?Q?gKHnh6bkCA+fwCtt88VnDAQXg9CRdnU7AT1/7Xwxuiud36jSbbSkmM1VWtsv?=
 =?us-ascii?Q?L/AprOwZ/nKFb4UAVg8ShhjkEBaeWVx83r1vOLDIbl4NGuVVo3VqhlYtwXUJ?=
 =?us-ascii?Q?NzQ/cKCNsIcqxtYZJ17vRzD83Uh3AJAfTzO6dzLPKKZNnee3C6Ag+2q8NRm/?=
 =?us-ascii?Q?UwzYGp1Mg2trYpqpKNfObAgPXqirISeYj8QGA6UlLn5WgIsQTwlhfiYdWMfT?=
 =?us-ascii?Q?oiBmoOP7yB1hirelBfdQ4jiSYjm13YnslZVCnacfqlIkmQM2c5X5yTS4RMGu?=
 =?us-ascii?Q?cRjyZ7u0lIUShGFVqboCkshwURcLQXStyp06V9xyCFGlYy7xTmkZGKCNElbd?=
 =?us-ascii?Q?VOe/QjDxermX1uhnMMKhl5guEUYJK9vWZy9eMuogQXIOcKl41Zjx0R9qJqzm?=
 =?us-ascii?Q?aROXMY7J8tdt9biOvQOIigneTVwZ5PI78GSuJkZufCePlxUEbHRbEfxSsFqc?=
 =?us-ascii?Q?ewdB6P5AAKRTyVK1mhFjwvnIWA+GbEbBg3afhg02ZhcfwzUN7MT5rJjcpKfA?=
 =?us-ascii?Q?OgaB4u5VwMQQCLrByGf9HuQfNXk1gBf7mxFyKiCr5An6wGa/8f7lOv70eoWQ?=
 =?us-ascii?Q?XU5mJYiHDuATW4/DwCtpLgTLBp2BNkkWABI017T/rb9rDDRyr7h2UYrZa20/?=
 =?us-ascii?Q?lkqQ2xDyhNnEXBMl3/A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24134cf-9228-4554-e8ea-08d9d62c2985
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 00:32:21.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu0TCaP13cFcDAcG2acQea9Wt1MFledQhNmzrrvLVxUXMkNdigsiBlc7QQ70PJiX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3169
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 12, 2022 at 12:49:13PM -0800, Kees Cook wrote:
> On Tue, Dec 07, 2021 at 03:45:25PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 07, 2021 at 11:41:07AM -0800, Kees Cook wrote:
> > > On Tue, Dec 07, 2021 at 02:47:29PM -0400, Jason Gunthorpe wrote:
> > > > On Sun, Nov 21, 2021 at 03:54:55PM +0200, Leon Romanovsky wrote:
> > > > > On Thu, Nov 18, 2021 at 12:31:38PM -0800, Kees Cook wrote:
> > > > > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > > > > field bounds checking for memset(), avoid intentionally writing across
> > > > > > neighboring fields.
> > > > > > 
> > > > > > Use memset_after() to zero the end of struct mlx5_ib_mr that should
> > > > > > be initialized.
> > > > > > 
> > > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
> > > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > > > > index e636e954f6bf..af94c9fe8753 100644
> > > > > > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > > > > @@ -665,8 +665,7 @@ struct mlx5_ib_mr {
> > > > > >  	/* User MR data */
> > > > > >  	struct mlx5_cache_ent *cache_ent;
> > > > > >  	struct ib_umem *umem;
> > > > > > -
> > > > > > -	/* This is zero'd when the MR is allocated */
> > > > > > +	/* Everything after umem is zero'd when the MR is allocated */
> > > > > >  	union {
> > > > > >  		/* Used only while the MR is in the cache */
> > > > > >  		struct {
> > > > > > @@ -718,7 +717,7 @@ struct mlx5_ib_mr {
> > > > > >  /* Zero the fields in the mr that are variant depending on usage */
> > > > > >  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
> > > > > >  {
> > > > > > -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> > > > > > +	memset_after(mr, 0, umem);
> > > > > 
> > > > > I think that it is not equivalent change and you need "memset_after(mr, 0, cache_ent);"
> > > > > to clear umem pointer too.
> > > > 
> > > > Kees?
> > > 
> > > Oops, sorry, I missed the ealrier reply!
> > > 
> > > I don't think that matches -- the original code wipes from the start of
> > > "out" to the end of the struct. "out" is the first thing in the union
> > > after "umem", so "umem" was not wiped before. I retained that behavior
> > > ("wipe everything after umem").
> > > 
> > > Am I misunderstanding the desired behavior here?
> > 
> > Ah, it is this patch:
> > 
> > commit f0ae4afe3d35e67db042c58a52909e06262b740f
> > Author: Alaa Hleihel <alaa@nvidia.com>
> > Date:   Mon Nov 22 13:41:51 2021 +0200
> > 
> >     RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow
> > 
> > Which moved umem into the union that is causing the confusion
> > 
> > It hasn't quite made it to a rc release yet, so I suppose the answer
> > is to rebase this on that then it is as Leon  says about cache_ent
> 
> The umem patch appears to have been reverted. Should I send an updated
> patch for memset_after()? I think it would simply be:

No, I'll fix it in the merge. It is still correct to zero everything
after cache_ent

Thanks,
Jason
