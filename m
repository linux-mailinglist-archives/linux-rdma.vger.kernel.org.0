Return-Path: <linux-rdma+bounces-7568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC1A2D1D4
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BDE7A3B49
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 23:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420BD1DB14C;
	Fri,  7 Feb 2025 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gD0yGlYy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA7156F45;
	Fri,  7 Feb 2025 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972543; cv=fail; b=Cc41q5ek5Vq65ruBK7bBkC4bJa8gDwdoGVRS+kH6DMjgkPDmgiXtvglPoWNF7oEkeTYC4uVyMD8AvSHjy/qxZOcuOUW+C7eQ5yFghItO01dfa2oiXdvjw+1K/lHgk4VTyH314XsHg4g930CSXggFmKC814B4ws4Rl5CoSKTQvAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972543; c=relaxed/simple;
	bh=87cwyJ5zzhyV1cY+g5bka52UtmDmt2ROC5erhpdgCtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NmqXhpYbwLEAgMs99dveS4uz6p6FB05q5bIzqdD2dhAIx7+daGmgF2xhx3Me9mF4Zplxkv6RI4Ynk4qAvGgLSFmIXB+4P4aFSMBFiCNWzGCgfX/OXHSJw/cHpkegExOsTrVravrCVWOFVmisWXcJ87n05j6e8vamhqakp1Xiljc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gD0yGlYy; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfiXl2jfgKd8TZ0bakkdJoOLHqB/4TBaGG1+CeVczJ1MQCCOnLimOsCntXMaR96hmlwbeodEGooSLFipktAcgQCTyjJY4bapSt58QqaESAkLa30XUe1E1G1wIcWP59SzSeH4GXXuVA6ujFgvJYDsZJNtMTrKCAIk/1R7pZ4eQZecQ9iRjVDK+92n8xqF5JGAKlKByVBh9NNcXD0ydRnnu4neXFVhCjzuxpOIR5V6NfMV4q1ANzl4tmO/1g0SK+0o7b++qtPsnCEjSEd8EQ2XfDZhg1/hlpu7QZla1mmYQNfviRDQ06f6fh+8nFD7zXa3AyTPtSFIAptljjkmyt+SNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IJxcVuHlNAFZEfUDNg5kUFqgK5uNxX5ZfZNmrr4heU=;
 b=gDg0nHAJDUTT48V8qcsPl4QUpx+OaRRXmytU2CdhNvn+oXmpGjV08o1RZ9Y4kGUfCB4C6+hOYpb7IFVw2xzsPiYfgXb401WRkG5N10m2l/8ekamMM25Kmt+HpDE5jxpjTY7yBcM9cWCa6ipJlNXPHqX7Zqg0bN+vgCVmusBmaCBIw6Y3Wrc6STb2ZT94v2tSsbdfJIoasPt4NUvrzLBU4A5WPjaNLLgcS8JaunSEyydx9IiVIv+R+/K6jcf/hKZ4NSKAIJ1YIHebybgY4ss/nJtFzYyZlPTjs7clxGEBIZKUwbKlue6jPURC+3ex9NLC4CYdfTpiUePyVC4AeDJiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IJxcVuHlNAFZEfUDNg5kUFqgK5uNxX5ZfZNmrr4heU=;
 b=gD0yGlYyIsh1isLAOjTlP2hgsv/V4ftEd7ivUGWwfuUTt/sqnKSnSW/k6A7GHDhPwGomtSpNk/UgW3qQpWZxeUI0fdcgdxYyCh0V7ZAMnKQVfS1h6UenjAjcHuEzrX8HyfqbSnCU2yEw5gWjQMp/zzMRFJmDA4I+YtAc2AvLWTfDKwz309XNHDtcMqSWZyXcTOJSnbhhzlxBBg03Quasv+rxlZth8IU8qGSH7mzzciBdqOjb/lP0vWOJjxf75FGcciJ6giOf5DuB07VZXZENTl4phAcA4wvasB3OIIpqD7ni9JQOxTbfBx62SrIReFnbVr8jzjuRyRFYEpFkfm7kJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 23:55:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 23:55:37 +0000
Date: Fri, 7 Feb 2025 19:55:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 01/10] fwctl: Add basic structure for a class
 subsystem with a cdev
Message-ID: <20250207235536.GF3660748@nvidia.com>
References: <1-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <67a697f02bc0b_2d1e2948a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a697f02bc0b_2d1e2948a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ede545-3776-422c-7822-08dd47d2eb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jxY2jZO0Krs35EVU96blVD+ga80a0GyelExnC8OKNf5l0+AHJWWHTPPBJVui?=
 =?us-ascii?Q?De2gXrplojq/9YDyuYlJV93aX6CvyujvjIS3mSK1QPcBu4v35/+fx+0w503g?=
 =?us-ascii?Q?P4FEPdGLi1VFcm0Zx1OhCzqUTC6PaNncHYgasJXfcvnq1dYiqNFM0FETTKBM?=
 =?us-ascii?Q?t3Yvy81rg2F3OZysCHPPB2U9WNV2PahfeQ/J/g32/cp1V0IlYIRJc9XAZSLh?=
 =?us-ascii?Q?+FWV8CiikgqMIojFFAmhfuUVTARnD0mdP3Y8EETdhs72he+6d+rYAAOgBFEO?=
 =?us-ascii?Q?p9GaMvC8Ys4Gx3s8Bi2+sZedCG5qjwZpDOV0Z3jFghtBYFwprfXhuYtW8axl?=
 =?us-ascii?Q?UuvRpaH1YU1xHuyqS7rGv7OnUFhwbl9VuxngXaqjJa4D+lpGsoTaGiysnMww?=
 =?us-ascii?Q?FLiqh9OJkmJYrLpWH9BliZ9G9GQWaN9oGQCwrziOHfR7FrI+oV5hvRcug247?=
 =?us-ascii?Q?1GUcclPGS3vSaC1C7TSzW2INqk4HreMIa1pQNzGmgM/JtOhO7H5Qm17R0w6y?=
 =?us-ascii?Q?UV9aT9wT80zwd9cc88gg6F1Kt20kfGuXoo4eqPeHkumgklCgoBkPmnndcnIK?=
 =?us-ascii?Q?VbSeGt92ickH2CpFdg2kauncgmCn31QIUapuLti+dDhZ8C+80tB4llQyya97?=
 =?us-ascii?Q?huSHwUc7Wgs7C5YYk4yz7yJK4/7OxQU9s8RwyA9EuOK2e2ByO994aSudS2g8?=
 =?us-ascii?Q?9qsyoEitmE04iXBi0NveP7DEwyJ7rYr6ldilXjZ1joZu4t3ic2K+CJXJQ/w6?=
 =?us-ascii?Q?Wx5VH8s0wc0PwM69eMbX+Urvk3quyqZsDDJpSPqspVvasJKHF0ZhUkdt3Df4?=
 =?us-ascii?Q?U4Z99ijv7hVtzoUIlIQ9vN0IsrG8RQmqDe7XvJ5JFu2dCHP3RrTPLBKz7W5v?=
 =?us-ascii?Q?kx/m+8yKlb5iQDNgNgTVGOEq1/EIuWXMACrYdfRfImAD3rTHAKMdvw2GbDy3?=
 =?us-ascii?Q?Om0FRxeNtsapVgJ6v2jiTPuEY6ne3+GBst4la+dmlv0b6xnmWL3jNUmGdx21?=
 =?us-ascii?Q?BvdWw3/SK0VmlLru4/lx1yv07R8Qjpjp3UttHHZFT6Lr0Y7QQlYTYY814YGr?=
 =?us-ascii?Q?0LvMRywdXcT4uC3u7xiWgd/KcVBNDjbGWym4u7tmiRnG30X+lW+mSuRfqs0p?=
 =?us-ascii?Q?zO974JghOjlpk7G/bTn/aHDuywm7oF61WD1k8kQc0DV3JoALwVPfP1JxNG33?=
 =?us-ascii?Q?FFWsEtEy7brxVJmsJHQrBimO9RnMNEHvKVhh+cwEZgUlWvQdKN352llDLh6p?=
 =?us-ascii?Q?N05znra6Da2Vz7WHhsfxl6GJYlUH7l6M1jEKLMiW3qkit8II+K54tipcgJ4m?=
 =?us-ascii?Q?hZuycE+MFN6RBpas/4r2SJ4ZI/sx+3rA9qSrWjpJw9YjKoEqgies/tRozyz0?=
 =?us-ascii?Q?lb9+0o0qY1ftoNj1/2ScYiMX+grc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfi6IEim4DqT2CLq1Ubv7XGQXgWSY/nHPZNNg6s7fCSVKR5hLxPJs8qKMDAf?=
 =?us-ascii?Q?HiHCyPuAmlu6Vk5XN9iYQ7qWq0J0jXtSgn9+i30PF6HAAIZiaNYuTt/4P9NR?=
 =?us-ascii?Q?OtLycASNaEKqtdGwXV3mg+WqboRODu5GuEpvLjJUbu2LMnEknRLSpp+nQdtY?=
 =?us-ascii?Q?mdVH2UECIwIjCXLULTJtEAT0Q05IcD3y00G8Q0IStCkGj8q3vLen4yI23fAe?=
 =?us-ascii?Q?hnOk5Pg53tOfy5qtCbuMLauJayNpzlt1+Bhy6/9MUpvC29mhQpmm5c1EkQUL?=
 =?us-ascii?Q?8f6jGqmsiTPhnPd/CGlPgFGrCHHhaynhCef8T1ryB86xMc1fwj/dLDssVwRE?=
 =?us-ascii?Q?CF1XNIFZGXlRrWO5++pZ2RKm3B8AqBHYZHfae0Wzq1s0K0BfXk27xlQoAgQ2?=
 =?us-ascii?Q?zGXBQs4t9noBgG9lI2NX7YmSbcZtCEJq1ozLKjM1s74pAKFZyKm8gbL3Y+0A?=
 =?us-ascii?Q?1I8oaDHuflhh9WbzUIxVNzBP79R2C1tTSgIDsh0rhgI8ksVYl00jmmU9bdlN?=
 =?us-ascii?Q?pczT9THQia//OiIZSZVi65wrbm/K3Qzf/cHZ+WW0gYfc1K0BOQIkc+34ZyiS?=
 =?us-ascii?Q?mKKq6JQ1HrTMNQdE48Z/B5cEj1JI0n5pv4EoSVNGF1i6P2lNMpLlVP4OuUI9?=
 =?us-ascii?Q?SdPFySrQ0xDU0mrBAq5vFmhgzfVm1O7j70+C743VRj+lOaVLkuoxd0NURtFi?=
 =?us-ascii?Q?KJ3eHhOO517/KrBOSqHOvrN/G2HWGn3v61Unbg9MXIN8MUQhRQiFwXaQ6cFY?=
 =?us-ascii?Q?os2EO0k5SBDDDaUWL5afJqKOw1JmpG26cyw2iv1rYafZJrc85UNgxgkrfpuo?=
 =?us-ascii?Q?yJ2dJv/pJkX/nLxIqBt+gJEUyDK4MCLGb+a7eLvQ3B/9CHND2gjsrTjCo7Rt?=
 =?us-ascii?Q?8HrxhmAsTsNGknpslgAa8Vbf+9A1u9187AvyR7Kr6+GKlNGy7rkB3koXYcFe?=
 =?us-ascii?Q?uLDpf9mHIhsl0ayoBYr8UmIoevpeFyH0THUckgc5OY/IiGhf5EK6Hi9ME3lS?=
 =?us-ascii?Q?kpRP1IWkSkUKbgeiNxzfs6EZPtIUk9sHl6Z9SqMzfwNpRxJEy+9pIoISvBoV?=
 =?us-ascii?Q?YRZ+V0HL8qV5nB1/YJpgOKsewELxCckSoqqm9Oxj25jENpY0HGmLbr9Hls3C?=
 =?us-ascii?Q?doXlYZuSN+vRlchUzt5jN7w4y6g2aIn45/EKAGXKsEX0KuQjFxnHBFQGmvvz?=
 =?us-ascii?Q?SbjOIPwdEpA3u/cek+2My1TeH871qNx1kOas5vw8NJDJq0xGL/LI1/PPeIij?=
 =?us-ascii?Q?Xq8H1iEwAEXsUu5WTRCI8S7nyhv4rLgsmlG52fG+oCowGETyycSNNRTm3bBw?=
 =?us-ascii?Q?hy+2KYfQjuu26s0s2sIrBryDPjziJvscu9speuDSGMtNJWU4weKoXQu2XNRk?=
 =?us-ascii?Q?181bB0qr1X5tG9Wbx2+mM6ylYb0ompOad/gI/sO2JaG/qY/bTcHfHt0N3HGj?=
 =?us-ascii?Q?ZcHbgEuCHbtyAVCAY4N2gK3sspvf3/hqBPQ2NnMv0SfTyJkY1iJYM+AEVJgz?=
 =?us-ascii?Q?Bcl9G5qEu6Xh0+yKYci5MeBiiciNMvp6P8HKeEmtlsF3Y7rWvMmo/8lhQJYH?=
 =?us-ascii?Q?W7DDymEjcjNml3uht3k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ede545-3776-422c-7822-08dd47d2eb24
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:55:37.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhkZ/QkrQcOU6Ypy4H4HohwHgCIQzliHFBG0GjKXViLyxfVct3p9sKjyz6RI96Q2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

On Fri, Feb 07, 2025 at 03:32:00PM -0800, Dan Williams wrote:

> > +#define fwctl_alloc_device(parent, ops, drv_struct, member)               \
> > +	({                                                                \
> > +		static_assert(__same_type(struct fwctl_device,            \
> > +					  ((drv_struct *)NULL)->member)); \
> > +		static_assert(offsetof(drv_struct, member) == 0);         \
> > +		(drv_struct *)_fwctl_alloc_device(parent, ops,            \
> > +						  sizeof(drv_struct));    \
> > +	})
> 
> I have already suggested someone else copy this approach to context
> allocation. What do you think of generalizing this in
> include/linux/container_of.h as:

I also have several places doing that too in iommufd and I think we
have a variation in rdma as well.

Let me suggest we go around after the fact and propose a consolidation
patch. I think it will be easier to understand like that?

> #define container_alloc(core_struct, drv_struct, member, alloc_fn, ...)    \
>        ({                                                                 \
>                static_assert(__same_type(core_struct,                     \
>                                          ((drv_struct *)NULL)->member));  \
>                static_assert(offsetof(drv_struct, member) == 0);          \
>                (drv_struct *)(alloc_fn)(sizeof(drv_struct), __VA_ARGS__); \
>        })

It makes sense to me

Jason

