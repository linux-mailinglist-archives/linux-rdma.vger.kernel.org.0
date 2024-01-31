Return-Path: <linux-rdma+bounces-837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A98441A8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDAFB274DC
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357D81ACF;
	Wed, 31 Jan 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Blkb+qV3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BF80C0F
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710699; cv=fail; b=HPjEzQheL/iA6ce7NXaw0t+Frby1rCMMkrwF972o2yZSGgiAOrX3TvMIv4hZ+228XBidzknJR2cI0EjdCLLEOKJjgyJ6yeQmjy6681ZFbWdGG+GleSAEICz/7gsIYa8dVFAlJ0ZaIFFXznHpSd8PLFgdIB9hv1mNCKPMuNNrt0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710699; c=relaxed/simple;
	bh=OPudhIfd7cmhWY0DDVk9THKyAE8+tnz8GAkCTdmSOAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DYiJnN6uK4uaS2okUdhUw/5sXLxBxlx+MuaDSFN0ZyyLG2gG/I/3g2SdBUPGzqshubcTc0NAh3YYZI6YM7qRUfSa8W3R20vWc+yjUScKz+OKmeUk91WEoip18yyDReUMQnTWiDe+hFupKqEGZEg6Hulv2fscgDUQ9vMGLougMkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Blkb+qV3; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnb6QWwr+VjLXcUyXyJ6wTU9OkbMk+mzDrcoMu6dmCJxuA+6IQLoSSAXjEfHVrCL6Fn2TtJT83jg7E55QYS/BGMVpkLuzR9delzv104JENDVPqV5PNvFpjlnT33PzY9VsVqvK6oTBgLgSFojS/yG+PZR+9zNGfrJ5ws/q7KoJqg/8IQ8wTUVl5bNbR2P/fRpEvbN6q154Q0T2XbqAJ9T4QXNfYnFHmEHz/Jv35FwyILvYPj657f1ICRrk4pSinmPlzE30OKEJDlqYCt9UCC63vrTR6GB19DPMuTCGwF08qUqZYzReD9N9vRD+cg7vp7Qo1OfgjaaAsUvNpdfPihZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/LfHVLpwZm5qDoNzy2DSx1OGS0WG/3WvKjEO1eZiw0=;
 b=NAPSK26MTBMqDLqsh910n6nRsgN8mEKsOeF928GVStCWiZllmMKnYYb2amNSuBlrJ3IXMLTF6pbX9dW/3yjwaa8dnAOrMY0HkClgRERyx0cD4mufvM1AnaEt5dzjSved41ibvBtJe4jYNHztqixQQ6Ma1jyMo1IZSjJHoFZ3TdwZO41mMYVpvhGUYTRx4cmePcZSbY1SVO0pypxt0pbybiwK1u/7bAEFM5MT/BJNhde06Cnnxgu/bdC+2LQS+gcEFVZ7jlCoHBWRYpQRGagz9Lwu/85u25UhQjkZMHVRulxB88Cv58s/xwc/pL/4HNE5YSKyBgiOmwsOTTLdIrIwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/LfHVLpwZm5qDoNzy2DSx1OGS0WG/3WvKjEO1eZiw0=;
 b=Blkb+qV3MdyOapYbgjPa8sSb4GaMf8xaD7ealkAu0JLZc59ZcjPU+hsVknGWcYTtvQfYm1xc9iz8PoHtWY3aKAM4NqWBeBjffpcCiZvmIeUz1Fo6p+3ZY5DT5ovd8kFUCgotR6Qp+7UK/TRpY984CUJXryRtiD3Sv/kMDeQqIj++VMZ8wAIF1xnDGHyIBLuS3YKt19LSjAOOkXVcEdHWv0aKFkDm/sNGAaXwObkDNQzQfw3s0mif+lp3te+Xn+WKQzKw4/kHnM+jmZUuD6Nvfv7cjrkohfRfOyiI/xXwtVLmDdYCXkLUGu2vx+PoJiJVUO/Pqlb3orFZc4gfz60XOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 14:18:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:18:11 +0000
Date: Wed, 31 Jan 2024 10:18:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
Message-ID: <20240131141810.GH1455070@nvidia.com>
References: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
 <5e04d7a1-5382-179b-968f-97820e376129@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e04d7a1-5382-179b-968f-97820e376129@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 4304e8a2-1ce1-4733-b0c3-08dc226774d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8rrf3utb+ezpetNkNgx63+CwXN9wPJLSBSupcZz1cS4sgJP2OqtKJx2gT5qxVZIXThkKN0KmrI5M9ES5j6fZ5NBBKHE0Hdx+UXye50XOfxZ4L2nl4MEfGdaH+Mhgfkm0jYB3Fsg/rfLfdP2eTJRvewQnxRgMzGXIxeriJzl9v4z5hE3SEK/Snt6sQtLMUTLMDdRBClv9vFAhwO6k/8Uq4ZhbVvWxbl9o1Wxty4+fz5tre3e9lpYbB+Gzxu+SZsgYSZUd2BknnzSO3+lwXH4mrLZSRqiZNm97Qk7prTQd0TNYSRxNCtVTVKuKLnre4e0FpzRYRELPdd4jvc+66bpWy0lYECe+8qZ8Cjj23OxOBmju6kCfSNecN1AeT59mAfML5IJg3e/FddV/4p4HTqggylH7cKUAPHmdgAOzJpFTGjlTEFfuF1LSOFqCQ+LPDYqQ/ctpyg/NxFejM2gp7eYW41RbgwSgPLl6oMbolClSQQGklqrzUw0yaW0p2T4w0X/qnj8BdVVLSiE4uN92JlREDjjYIBxu/UZpc+HQOuvX2kvqx4Hoc0fiqASC526ozsn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(36756003)(86362001)(8676002)(6862004)(66899024)(8936002)(4326008)(2906002)(6636002)(5660300002)(33656002)(6486002)(66946007)(54906003)(37006003)(66556008)(66476007)(316002)(53546011)(38100700002)(6512007)(6506007)(478600001)(2616005)(26005)(107886003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNJchTcd9qBI4kph47F1UZ+I/EysUtNnfbffFGU+bfc6136w5i7aa+1ur/Hl?=
 =?us-ascii?Q?hKdR5EpfVUkJ5zhU/Eok8VHak4trkt3NTDWK34iXTp1qNbMfp6iwrE2x3No/?=
 =?us-ascii?Q?kSfaaR9T+P2+YSfvEWRIjNOAsS9ypAb9QDszO/SX1zgNefDadksDiRi+fSuP?=
 =?us-ascii?Q?5dW56HKSDJGSxQi2gacxGmg1SqEEtR5YdT3HvRN9D/SP6Q1aVKeD701Lb6qT?=
 =?us-ascii?Q?5O3i3yyB7zWrcG70o7vEG02FirMmV5BqFzbBIgLNEYZmIdX39mKpiaY+2bZI?=
 =?us-ascii?Q?KU64tbiGSz3of3Xld2G7xwmzbMsZWXPHPwkGjDsIrOJgoG1P8R4iDcOojndJ?=
 =?us-ascii?Q?dFlldc78JbBfnpRka0//+jqMGavA5xjngUTu9qJRRRVwU60ojqEp8DJK8FqQ?=
 =?us-ascii?Q?c52ZCZXXAdMo41j52gEt3I4/XMrmscoobFILcBVi+eO/muks4oyLI8OVChIq?=
 =?us-ascii?Q?Tn+kDkNiPVqiGWwZl0Ptof7XxHi/ENOytTpZ6JuTFnivB6HHoAG0uyFYho12?=
 =?us-ascii?Q?P4WoGQOf84mIGIYGgpbFA9nmadrXzy3CcxOES4OAf9KEEMcaM5eWnmwUkxV4?=
 =?us-ascii?Q?bp1tZD7nqwxly4sLzQxNX5bUhOy6tAX5sqNfUs3zjozT6rODj7GJtk82Cusu?=
 =?us-ascii?Q?3o45UVXd2JHyTkHmXhwlChmLg6ebgiz+N0Ufhsl0uUNrBeEFNZF65kCaTKnx?=
 =?us-ascii?Q?tqs6V+foUpbNwhC0jZ7DW9t2ix4D7NpMw6BncSSnhVPzkvDttwKeEWjy+5rn?=
 =?us-ascii?Q?xH0FF+8fBh9jHyyGlZ9rCXUybMiZBBpT3s3mrwiglun5kZXixOns7Sb7dhH/?=
 =?us-ascii?Q?kl58l2KdpvvG8MRZZU9Zr/LWPXptNaYZi5irlHDgH4jhCE9QRu7454SUl1vM?=
 =?us-ascii?Q?jGWshc+JAdZskuffPn0EwOTBBlgsfvFDVQS0/0q6dY6cgIYGVCDo1vsdt5kU?=
 =?us-ascii?Q?oYdE7beFItDZu5nb7xUEh6ol2289ncGbNYMckMlA2far9ijPRs466zV2Croy?=
 =?us-ascii?Q?hPf4GIYBkDAUhPLQlQIYiKuXBVk4M52Ap0fQ4c8iJWhZNdKMbNFMz9CEvkG4?=
 =?us-ascii?Q?ded/a8C8WlR1yaShmlXeuI8p2ImIqnE+3s5q1OF2peh9LHkWysci267pa+Dj?=
 =?us-ascii?Q?p7uFJb0bOKGaoLP68IdDbEiNj068yGltLugO0gsIB7ZcSFwCbI56Sc1mAH9o?=
 =?us-ascii?Q?Cx7QmWFAnNEuoqsnLnfdpTLJtoBjQrtA93JW8EW4+x3Swre19NC5DEprFSa8?=
 =?us-ascii?Q?0weRALA26enoCCV0AGfbNGaf+get55eS65jvlSGvMLpwAvw2vnX+tzH/yrWU?=
 =?us-ascii?Q?X8ptCKYWd21TAgOdtNtWYq0IntYWgte2wSIpDpy4XrnFBb5/ym3cTrvwvC5z?=
 =?us-ascii?Q?F9x6El4dhPQLkODQCugiUyCeuWSeXketqhz1O5/6GvvlnFacqns3CfxCSp+Z?=
 =?us-ascii?Q?QKJzYZCHJDTSxwvYZAGdG1L60fC9YblPBKxNlj6417aK7dPrSE872N84IO0Z?=
 =?us-ascii?Q?w99Q9mpUJnzeyZ1LySWrA5MMe/djvbPaVwNh7fUWiqtNbmwHRY0Cz4uur7NQ?=
 =?us-ascii?Q?WAiYx9NkhoVkSJm1A0BOXjGgjPHPMGA9hji8pUt9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4304e8a2-1ce1-4733-b0c3-08dc226774d7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:18:11.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1M4W5K90UN3MnCxkLfSWRplXnlr5o6Yvzrwd7PkZ2mOt3BXguqYtjeiQQwH1bXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On Wed, Jan 31, 2024 at 02:50:03PM +0200, Michael Guralnik wrote:
> On 29/01/2024 19:52, Jason Gunthorpe wrote:
> > On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
> > > From: Or Har-Toov <ohartoov@nvidia.com>
> > > 
> > > In the dereg flow, UMEM is not a good enough indication whether an MR
> > > is from userspace since in mlx5_ib_rereg_user_mr there are some cases
> > > when a new MR is created and the UMEM of the old MR is set to NULL.
> > Why is this a problem though? The only thing the umem has to do is to
> > trigger the UMR optimization. If UMR is not triggered then the mkey is
> > destroyed and it shouldn't be part of the cache at all.
> 
> The problem is that it doesn't trigger the UMR on mkeys that are dereged
> from the rereg flow.
> Optimally, we'd want them to return to the cache, if possible.

Right, so you suggest changing the umem and umr_can_load into
is_cacheable_mkey() and carefully ensuring the rb_key.ndescs is 
zero for non-umrable?

> We can keep relying on the UMEM to decide whether we want to try to return
> them to cache, as you suggested in the revoke_mr() below, but that way those
> mkeys will not return to the cache and we have to deal with the in_use in
> the revoke flow.

I don't know what this in_use means? in_use should be only an issue if
the cache_ent is set? Are we really having in_use be set and cache_ent
bet NULL? That seems like a different bug that should be fixed by
keeping cache_ent and in_use consistent.

Jason

