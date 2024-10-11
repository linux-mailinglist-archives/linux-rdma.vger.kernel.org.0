Return-Path: <linux-rdma+bounces-5389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC499AF80
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2024 01:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D43B1F23124
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC21E491B;
	Fri, 11 Oct 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tX9EAOd3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFD1E3769
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690202; cv=fail; b=t6kyzJ+UaK8GA4hTXVa/rPcryGZf8sabgmy3zZymIFiBehIJIS6bIy9RftA/RxsjqMQ1VDlotzpZ9i8F8Z6yI19uEgzNeR/bYJcHx1lGEXmbWMDhInHovOMluROYy6fRLY+0zlKYyc71VOZAAio3eUnONHlRfvkOPVmqveO2LkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690202; c=relaxed/simple;
	bh=bzh+F3whB4dQigeUwDHPT4XfJ6GbeOrMgpIUAEu3laM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hch7d+zXP5rRI80zsD6778jcvl/HAS2B4fN0SSO2NgMyU3ccG95nh7f/1lcRGzSfi4byhEm24sOvi4UxSRDsk81ub2UxkcynRtgYHTNwSQUtEy4i+Nmp3j7c7mMSWwaLnhRH/gWNAXYDgHTeFciES3hYvGpP6V1Xp24X4/GEWV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tX9EAOd3; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzB4AO9+NYZLsqhHwS7Txs1jzmsbS+X3dbAmg38bs3bOJq+hF9y/SQlPFZhVp+NRzMSeK3E+wwh6LyM4LoN3L5htEaKdEfPIB7XLDN/z7i35UeOg2Aob4al5JJu65y3bR3TTQewq9tFxZLDjda4QLj86Otz+iNR3T+i/wxqTLo87TAgX347qhf9GD1sip7UhvKY7HdV0hsTaRVeQ/YPi/cP95gxJF2o68Pw/6rvCbeWJdk1WjWQEe5xPhmZnYeK/mgXmnfAKiVMsis2SD7rDwUMBATwEbJsrjZBdRqlmaZ9uWMah4rYNqcdylsg4lqij4aLTvtVhao1s+Gb0Dg6kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGxhZJmBJ+eL3UIfT46i4YCEj9GzzKQfpBJuGoamQq8=;
 b=Iniysut8e0T6dicYlVA+vjUG3y/BVdLyoruNKX+4cfBEZzpV/VxigAICp6PfSWaXK72xrVNkrvbt95IBYjxU/5ypa0g2PouxpznlLrIXB2U6aqhhn1MiCX4bgKfBpjS4R2Ds+KTLDRfqoX9jMUkCyRWwXxDVdLnSUgsQF0LqEbyQ+8ki+0IuUNNRvLz1oPb1hq8737CRp8Kdl8uddXi4m5q7jzMfI/ohWIMxnOEEKmT/4pryKHPfVUWQwF1Y4NgIH/Xh/ZKhiiuEgK0EGwKeW61s0Cpz4jybJZzahnM9TS/Cmd6Fo7UH8mDW7C6QghNGWze7YZQbW87RvHKRonmneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGxhZJmBJ+eL3UIfT46i4YCEj9GzzKQfpBJuGoamQq8=;
 b=tX9EAOd3MehC0xgwbnS0hJgxI3tMoy6m7cin/E/DAgw9EoTgSVIvyOPVDaane9XIwJwiw3FENQxLIQwV0R1+4erY0/SNNF/fIfg0Kvn80DnKFF6E0fesowPhGWfMqNBnAjrSLw9DiUZq9POlhBjAJvMBc8x3lWUAuvtV5PcFHN/joW0sukz5jCl4YBiBSnHUh7m2gS9OhzGj/UPiQy7Gf3mM0/fSVrRtfjvfgOUdFSf6478YywfMfCRSGG3WR5SkP/M3ublWCAnOXTwr9jQXhS66IklOjMdQbTOddShICn+wQPYWvttHbHSsl9+b1Hs1f2/aR1mFYKyLfn/KEA9LUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 23:43:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 23:43:16 +0000
Date: Fri, 11 Oct 2024 20:43:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3] RDMA/srpt: Make slab cache names unique
Message-ID: <20241011234314.GB2274801@nvidia.com>
References: <20241009210048.4122518-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009210048.4122518-1-bvanassche@acm.org>
X-ClientProxiedBy: BN9PR03CA0706.namprd03.prod.outlook.com
 (2603:10b6:408:ef::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6ec90d-7e2e-414e-47fb-08dcea4e7a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hi6YDQHLRt3jEZOrlj6tipYc+Kn4menNu8feuLesnpPfWi4XuAgoHKZw1kDg?=
 =?us-ascii?Q?d9AWk35IoML9jad8cfDEMmLffUIOxLDOwDNLJDwBqc02Px/BmrUEefNne117?=
 =?us-ascii?Q?dFUkRvYTeJoiFjas6pyO94JvhmZXVX4It3fhq+Mzvfzpko6o7cDNxTh7uxjd?=
 =?us-ascii?Q?4Vxn7BTKWt8B9dKL4lZvXYVpJeYzfp0EgQkIPIqoB/a/Y4/OcqMRCjRF3twH?=
 =?us-ascii?Q?KFBEFpPYObtMKSUMEXDf7wMPo7LagFF7KI7cijL7tOr/e5DQ5lruXWo5CzJU?=
 =?us-ascii?Q?8XxNx0SXiJBQMM8CGH4cHqp1s7U2yWq3llyeB/sFe+8SesZSAmy+ot5z3vtZ?=
 =?us-ascii?Q?dN5Dsn2VLz/yJYSByv2/uXvfOi4IdtvZ8CZO8rPTrYGsBTpbvVr1KkbpGqw2?=
 =?us-ascii?Q?Ff+C68RaAfDjLKpSVz5rYriScKQg8Wg1ZolmEIUbjzUNi02TmQi1wd0y3aBI?=
 =?us-ascii?Q?BtE4D2HTNyrtH2qD7ly4eUGh9ADdKyBEykk947wQfuSHrXRhloo325+wUHxj?=
 =?us-ascii?Q?21uhh19VPUefptdXDTCTbuab1F/jF1GnQjBj4gtLlim+7lDTXfVFBkkLu6H/?=
 =?us-ascii?Q?his/opAoBA7zbfg2vzp0rIpl78UEKOWXml3Y5lm7V4fT6RmtiZnRkrzCbvP6?=
 =?us-ascii?Q?IPrgScBGeMn55asUPvjO2DafKDJHXUu/z1ARVU183eSixuzwTQPden0VBvSZ?=
 =?us-ascii?Q?cOIaPjh/HVgQt8/+Q4ua0u/F4+9ehAi+FvNL83tg2slVfFu5aIkbSYSZGy8W?=
 =?us-ascii?Q?u/GZUlQHyohFNEJzLdoNKdfij+ChvDYIzpLSMCogC5uVztc6DV96SgpwFycS?=
 =?us-ascii?Q?+Ovy84BPbRhjqG2Anbal74wIrSy1foamQn570XB6/VMxwGLyllcb4Qwsh6Jn?=
 =?us-ascii?Q?D2RYSoydWVyrN4sJNzHifAB10++Fqcbp1XoFL+n8LwMQHV/ZAIuWMW3e/TZh?=
 =?us-ascii?Q?aN5ify5I27bCKgyGySw8Z0ve511+7CQCM26s/YeAO/v1GylIN3EogzKS03t8?=
 =?us-ascii?Q?uTeDGflE6S7t1F8zOWMlwz0738ZQmhO/X85AVJet6a6ijgDaKl4xiL10oGjS?=
 =?us-ascii?Q?Xfpn7PPHHpUrsQ1xj9nKmqPJKyf1uOhsVff97DUZ0c7efd6TTakPsJ0vBBEX?=
 =?us-ascii?Q?rl9ej4V6+wP/aAvJZkRCJTS3BsFpSm/q0oe+qoWhK5R4rUJ9aNmkL6QSNahH?=
 =?us-ascii?Q?8PU4dQVuDMkbbiUYQzOzCmkH8XR8dhaLEl9cQnCi3Lk/d7PyrF0IIX1nqTYx?=
 =?us-ascii?Q?puEZ95EJrPBZ4NjiGAXyEX6uTAADFfMMTkwDG66EHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aT5hsFCMEzUCkKQqhQfOUHZmhrSdJKiGK2VFX/54NZYgqzffpHQhhuVW4md?=
 =?us-ascii?Q?9vwtflx4DbJsDSlmTQUmC/ZgstdC4eCfpIFo++OFLCFf+ycnykM9tOtJ7NLx?=
 =?us-ascii?Q?OPoV0LQFRR3F4qUROX/You9BcVXZCgIPArMD4ZDNYEs/0D81DIVwmw43hC74?=
 =?us-ascii?Q?aijGu4cogdWMM60/NJZ30H91PO+4/S8SICdVjDc3wLg7yTBV7PJNfqPV4rx7?=
 =?us-ascii?Q?opGEcmbYbFliOI/ZVdkoxNvM4ovTlJSx4I/BPQTGTONWESjy+bAwQNrIybDN?=
 =?us-ascii?Q?x5dVAl7mYA/wy6oDX8FipsCTbxANjHVcjuxO3L1+4bfBM5dcX4ZKJv5he8Jm?=
 =?us-ascii?Q?28WebQOsHH7DdXjCSfZGPI8AMhXlNFG9jlzdFGQlT3gZd9b1JX4Tgg26tvtM?=
 =?us-ascii?Q?p7ngpypYYJeivgKOctPLZi0zI4p7dmeUAMulcI/xYBPcEv429oPMUV5sOwDp?=
 =?us-ascii?Q?LZj8XHTfFnlYDf9v/Zc8X+Orc1pSYk3Bv42RWbp5ovIB/Dx5VsycuBBmuHzd?=
 =?us-ascii?Q?/YeWXmZXIICRezw8q14pjmAFjwEAKsyMI2I5ggQzG5+otpDe+aCWhd3r0jmx?=
 =?us-ascii?Q?ETnTy/XmmCrIdI68qGN8AF02aulDGz0C/zFbCq6PNtHTeMefnx77rtZeVOiz?=
 =?us-ascii?Q?8YtNr7hUyghwtSlFstevrAQMDrQGfoEUGnAWvzf4UA8JeZ72RDRzp2eYX839?=
 =?us-ascii?Q?iOfscwuNFzynQLfPweW6ijgdc5tsTwYm9WG3v62uEOhWjrObPV6ev9P/GXxm?=
 =?us-ascii?Q?JifIt9m4bfUos9ml97sDB89jT6TIsE9nqXkHxPoHRJ6dMFRQYU77JvTRxpmm?=
 =?us-ascii?Q?ZXIvYowjfH19a8CCYWl8csdScv6TKsq8CeDqHeKtfiwQnfSFuQmtEe3oR16L?=
 =?us-ascii?Q?BCvlwbsWygdTM0JiZsg31anUCHGO7eVptXVkNspeEKSuuk1cl6RNdLmf/Bvy?=
 =?us-ascii?Q?5V09jiaswps9PiSXRCWLMXTXURGj4fxT+hu+cKkYn0OKTAUrmW9YypUTibib?=
 =?us-ascii?Q?6vbfWVPFKc4GofMClEpqFmeVeHj/2eZuuIV+H/xllLWgVCgP1UUBNtWZ760/?=
 =?us-ascii?Q?3QzOC6Yf54a5zA8FOvG9Jif/YnO06NIlZl+Chol+YSgi2JI/CnofQE92aBNP?=
 =?us-ascii?Q?Q/f6Pgw2AFdM1/4Ckgjrvek1xvVsKGaqUdaSoG8vMbFJ3A92SdZYU1Q34wM1?=
 =?us-ascii?Q?XG913kxyKVxZBYEI9ysymewQLiEWRWfEvR20qcD17Cj4iH3DPc1+oLlg4q7q?=
 =?us-ascii?Q?z5EXsb9YbOzlyETcqQosMaPvO+A1WQULw/iP76Wd/fDF7nw0LQg9pMHVlSOH?=
 =?us-ascii?Q?4ApRj+EicdLinMKqlncLEbt9db93InDLB8IsUV0ICL+mev+oVVcBPR95KI/d?=
 =?us-ascii?Q?itFSBAiAkafm5mKrwVsdUefKB9hpW7Oxhvykh//Gyfn8YL/ogNHAmYsa6G5R?=
 =?us-ascii?Q?fy+6neKtvoSNbbY7vfdmn7QqTxducGcm9KIJVkuSAw9BFYqpQKXk160Z6/dF?=
 =?us-ascii?Q?yy8NXb/VpJ4plci5r3LLhHyP2CzUIN8HAaVwx54XXHjXnIhMaKtifJmi8hd3?=
 =?us-ascii?Q?P7eJe4pnEG4lfSDfZGg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6ec90d-7e2e-414e-47fb-08dcea4e7a40
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 23:43:16.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL5533SdJxcSQ3TZvg7gvDHPyZMqnjPN99WTawP1tTqZTZ/K+zj7XNsGjTS7qF08
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

On Wed, Oct 09, 2024 at 02:00:48PM -0700, Bart Van Assche wrote:
> Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
> DEBUG_VM=y"), slab complains about duplicate cache names. Hence this
> patch. The approach is as follows:
> - Maintain an xarray with the slab size as index and a reference count
>   and a kmem_cache pointer as contents. Use srpt-${slab_size} as kmem
>   cache name.
> - Use 512-byte alignment for all slabs instead of only for some of the
>   slabs.
> - Increment the reference count instead of calling kmem_cache_create().
> - Decrement the reference count instead of calling kmem_cache_destroy().
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> 
> Changes compared to v2:
>  - Use xa_is_err() instead of IS_ERR() to check the xa_store() result.
>  - Removed a WARN_ON_ONCE() statement that would never trigger a warning.
> 
> Changes compared to v1:
>  - Instead of using an ida to make slab names unique, maintain an xarray
>    with the slab size as index and the slab pointer and a reference count as
>    contents.
> 
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 80 +++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 12 deletions(-)

Applied to for-rc, thanks

Jason

