Return-Path: <linux-rdma+bounces-12816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D3B2BE4C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E665C624928
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0B319844;
	Tue, 19 Aug 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DB7w8dwy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7E311C14;
	Tue, 19 Aug 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597551; cv=fail; b=LAXddApWbROsX4FUm76jJHTJWHLnD7aT/OOn5rETEBAE86skWszGdGCTgBGRsL9OFCu4xFzTz8w1OK3fuxjBwZ9Jwt2qDTS8QMZXLp10FvKpGTVDSr6nvSnwYf23ZgfkXrhZm8p3xqtg6fWw59mUYSj0NojytH1dfb0wBEsszCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597551; c=relaxed/simple;
	bh=9vA0rki4GgxplVlyWsncTU/TNBIbAmVCkfzYO1DsZuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lKoD39YcXeDZHMVRMUWmHzrUQlyIMA5N8Z61Mv9dWUBdHGc5GAhUJH8yYrrNMHDB1f4scU6jcOmbxkXsxARk3z5wVZMab4GC78XEsilHEScz0WOlbxRqxl5vqr2r5E4tEB3bxc80HD2Piss0PvfBCVTa4yZ+K7N4cOxuRARlcPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DB7w8dwy; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJwfMaJiBh3Nrt921uP2LHVG36nr8riTg9hUIIwmhcKjQBx2S/dswexbOqMfbWZKOrsASrou5kTk1phueaOF5pu6WbWVTixjpZBHxpGSQF+9XVrpCOG6Et+w6hGbri1UA6oANuS91cvaH+CpfnMXQgiRjPYbJmc1C8+k1C67STZ0AebNBC4ok8oH4d0z6t1t5V/7y/8v7QJKOZuibWmv3663G3effC7dDQOxedp53xKSvUb+YHKZglW/0c0VYD6tbIXontU6DDoIzPPAE/Q2qYBJ/4K8fseqdrdEVDHFd+Xhj8QvZ5E+f6Dp/ElqD9o2IVGc/Yv0TKxk5nXFoL52Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDHz+n03fdxqMJMAiAnmaw2feT4bYPXPQKYj4fhLUK0=;
 b=FIm79Uu/XsM+yBe9I+RwpP7rcFFHjOLkGG5IFLkL0uEoGk+IqAfPHYcI99HI5BuGsCw857ZY3hm9ecbI4pBhkW+Ri2Dg1CeiJVWm1fKRIZ0SRPkjiYczmsPFhqJykrIYC+qA3FEeU4ceH2G7uEKvnEzsJKuOfmwWFTGEY1N57AJiRWWG/ppH9ms2d7Gqs2GD10CaRGrR/bp/g3npTKI3iPWa1j38biZTFwdxJBPOYIZdlQMmiu3+rVahnmEiohAlHQ5VDR78X0pXAdZY2+YRe/weowQOF2ymjBaMJdtlKL+PJcVaEmKa1LfAa7lo1KC4miZyAkhravu94Jx7HwWIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDHz+n03fdxqMJMAiAnmaw2feT4bYPXPQKYj4fhLUK0=;
 b=DB7w8dwyBicjko7cSW4SF2W1+N6xeBD+XEXGa4PkJufMN5F+lqqbM2V1pfId8ptoIH+8I5aZwgBlCCJWQKmGxGttukLL7uvgGfufFNzMeUPRLrnRFnUSZT0UfmkqXLoev6DhqWfICJ7gEG4gnHzOSoby2Bvb02AJ8y2WLN0DIkURl+tsrAEeo36th0NXX3K7/OaGMmSsXT3e0wvbWeKkkXdWIZDe3K0wgwIumF1Oig/Vs3LJR25pK4w8iYybkJIzmYL/A3ssMc1E1kh4IxfZeLbXe9HR2o/dxYmxwygVhreJAZawcth/MS0KR9MxcA4h0DfypA1K4mzO0aOyDZU7OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:59:07 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:59:07 +0000
Date: Tue, 19 Aug 2025 09:58:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Gal Pressman <gal@nvidia.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Message-ID: <6dguqontvbisoypbfxw5xyscyqhvskk5avf7gwqgwajc4ic75a@id3pume2f4hw>
References: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
 <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-2-b11b30bc2d10@openai.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-2-b11b30bc2d10@openai.com>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 33413e9b-d273-4adb-58bb-08dddf07091b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dc9ktUKGx5s4C/Oa2Gwv7CFrJa3Hz8RCP5qkaw23QqTQligEUQynWcaBdAge?=
 =?us-ascii?Q?29sY8nzHK07p8BeZcndKZxGHSxVCvUV+BavAoW/YrpZCOG1BwtuZiI59tbOr?=
 =?us-ascii?Q?DG82jJlI1Q8nf4Iqz/TKeY3TmYsbbSmUfiaoywQYctD6pbIAjEnvn/sbnyg5?=
 =?us-ascii?Q?Tl/l19bM8cj7Pi/ABoPj1g9M60oVf3hCrqieY6j0csS3Dr1139B7TI3/xQ48?=
 =?us-ascii?Q?CoR1nM/kR5bL1V3+HeQLIzfhmXezFhMLBMDC0J74Ka2zixks4TDuh7d1VZkK?=
 =?us-ascii?Q?ZE0xqDgErgSu6anYAatOSSKaU/CIbWyu7h6Dh9zZXTwYP4uy0zhg5DXJ9gNp?=
 =?us-ascii?Q?xwEyhUwOrtidq+ZtqUmzed2ghBOTgBsCesDUUFYgrzjqZNiuiBMJ6hgvYG3+?=
 =?us-ascii?Q?sFIG/N7KrJhulgbysXQ2Yeb5onladxnq8h1Bh5vQmEuhWtI5K8884B/0i3g+?=
 =?us-ascii?Q?5hlg2zF/gMZnR2+I/2VIl1d6mfpGEm27zmML8FT+UuGRqDLWxnlMQ6RwBtIm?=
 =?us-ascii?Q?wsa76Jpc2bvlZsA/D0KMbFHLycKJUuidwFczSeZfc8Nu7aeWcT4adhkC0EDS?=
 =?us-ascii?Q?iUNMfMLCDSsSayAog2PRe5e2iVdCq4VHA9RvSM/gx1Yfg6lOysrZMZfwoS5O?=
 =?us-ascii?Q?iEOe2E6xn5TRLFHtzzD73dNxPV5gP8OP9nNXpPIesC1nuzfgNIv4I8eGbsmG?=
 =?us-ascii?Q?944vOA9MscpH7zB32+YrzHDnFSxPSYACSVKnlsX1HNAE8a0fHhNzYnVGTIMl?=
 =?us-ascii?Q?SNmP35IOxqS43HZm5ZhZFWkTskKySNXnJT+GzWsP923JnofpqgfR0JeMXQK2?=
 =?us-ascii?Q?jpoQ4CHgw8KVTbdxUPkNHt6h7OHfXKLImu6qnxTCg2TF6BP3Vq+H2PFP1/7A?=
 =?us-ascii?Q?3T0X7NQ2zkX/XP7aAIx2qXFo9mDh2lSqsq7t8q2cxSUCq+4BtpZYKF0C8tgJ?=
 =?us-ascii?Q?f9Frne4cJlYlba+a0MJapEMYuCoAb0g7wSGjGn7cwyUNoKhbKJ0hxbPEP4ZT?=
 =?us-ascii?Q?TZWcQCmC++ntNjp2eaRcFjdtV6QblnP4+hTMngqFzA/jim0KmN6raZ8PCK6M?=
 =?us-ascii?Q?TTHlsIvzSZt2K/nUPaJlPh3xH4xshowaqbJZltrO6vcIHM5bo104qMKkG9Az?=
 =?us-ascii?Q?v+rsnt4Z7bfqCsNmQu7k3Nqvlhbu5a2mXX45QDgK7GNpdkJ2Gj2bhtLoN5sq?=
 =?us-ascii?Q?oZPUjDoTTsWjqiFUXDtJzMyRNB3AP8rjG5QNSIBEvwKl83MhlmhyhHn7P9h6?=
 =?us-ascii?Q?1RXEPnJTGYm31bP/XBGAV0vVhUel9JRzK+R9R+S8DwNkKpjjdY4NAEYC17Qj?=
 =?us-ascii?Q?fNUqzN9H8vMDsvR/qKeQ3kA6yBCc8oWGOWkzjoruoQN7G7vouJ3Mdh5TPBWb?=
 =?us-ascii?Q?Bs6Bk1DMgVvn88ccN7TUMlVaF7A8jjc73qHzKV9tbrij82G4mJZTEGx5uGAP?=
 =?us-ascii?Q?5xijbVpvcwZh7xsfFAeEnfyMAjnRcJLQsXv2rM3wAOTq/Sn1d/bHGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DiGANgB5+Qo5VxsVccsdgtO/9UgJp7rrCS1sOQstE1E0dcMwJnzrjEjDNpk5?=
 =?us-ascii?Q?wwBMFY+tiUVQ5ofxEURKEYSU3KFBW+LMc7T2N5p3BnaI+3N72ka4K3fooLjJ?=
 =?us-ascii?Q?PQ87bCqUj+6kKRy8aa8iNlX0LDhOw57qw8u95mkuj68isypTO42Hq/GyIgRc?=
 =?us-ascii?Q?gg0yktMsc2bYPiggo1YpjTlA26OOCh/LwaLDl3TGV/ErGpbVg3Ph05D08j0P?=
 =?us-ascii?Q?xdWx3cUAPVKFhFYZYgsqfLyOZnSvJFzV3OgVfOxqpxPFQvXjTAB2ds7zWdLi?=
 =?us-ascii?Q?mhW42FpcsRDf3HhLNZaXxToCxeoA/e98brBugUk/atdBg6fE6ILR2FTKbrpf?=
 =?us-ascii?Q?x3vWi0Xs91tmFEwwTamUIZXN0yCncc6S0/8IaN/PxpDNFtFlJ2FBMMydCjwg?=
 =?us-ascii?Q?pi3XPEThP6tB9CBKtAKqmH7ZFa0V/pl4lMSGPy3l9keyxIp8bYDYjbtf6Mzr?=
 =?us-ascii?Q?Pnaw9ngEDafLOXFbAfP/2L1YSAU0I/Pf7ypebbvb9FUq5rbv0y4pCtvv3iZo?=
 =?us-ascii?Q?R5hVwyxtmiKKDW8h0h8oENcs4nU+w9i+bn1LiHjJugiGcaukhfYLGzY9sPGf?=
 =?us-ascii?Q?FZ1KcHvzoDM+Co006GJzqNt5oK/AW7PhRPEImophQipUKOk37+E2dJiw2zas?=
 =?us-ascii?Q?mob/7MAP3VzRnA/43H0lPoEBdpAJHjJXUAuVZHV5chIC0ZBesDU2C2pSsmvU?=
 =?us-ascii?Q?r7IvtBAIPiFk7bmOmJJWg2MnNJPUFGkV0Sb7JnfRDFcxcsIeocZ/WW/wK7/O?=
 =?us-ascii?Q?7i61BLk488YTyh1AuiNY218kMa4D7X74iDNoOO2T3Hd0inChiFlduMuu5uSa?=
 =?us-ascii?Q?PUeCEBLTYFCVT4iUk0vtAVIL3PSi/dCLrYn+uXdkGlAnym2bBgJtHqFLWGrS?=
 =?us-ascii?Q?kKs6eexAKLLOeTLyRld9HEG7kv4jPhFjY/H6464uq/RIELAXOSj1aAQ11iD4?=
 =?us-ascii?Q?SMDa6XUJbEBgBQe0vZ7GF/+Ztd2ImEQp6Bdwsa9hUkj5gmiePCrJp32bEvXm?=
 =?us-ascii?Q?QMzn/5VJty7yq4We2dwHQy0A5lpTMC0hzbW8acoaHHjM1hzvSFfv4PKH9NDO?=
 =?us-ascii?Q?97Zu62EiKJxLJz8YAii9jjEPfu77mt4QP44a98yEgA6mHDvLLCfFZCHB0664?=
 =?us-ascii?Q?JyocCKZLPkMt2xqBJNIEiYDDa7i1/CfM6ys3T50LXylDDsbij1ZDNl1n+fWe?=
 =?us-ascii?Q?T9qtCv4vT/Qs//MX+7+5z5pRiPLu+4RqlT+wKbZQs76q3RPBpOGImeazzuOL?=
 =?us-ascii?Q?YpSzUdij1GPnwssOfKLrLXmihh6FCZ++nhwdSkcTL613cOAVwUGx3I34kiiK?=
 =?us-ascii?Q?UQRMr7+xuK4olNB7C2bf7oPMNu1CYf4zok5Cl0Fy6ucQmiglw7CQ1yv1bEV+?=
 =?us-ascii?Q?0VspnsXVCGeLDBN0jHPFAKEA4k6awZ9H1dBFbYzRcqpHmKbGQwKusdgbP9HM?=
 =?us-ascii?Q?9DbsSUkD50KE4faljj3nOMggk/thWPPJiZWmTlUh2XBR0idv/FEd14Zg9N2K?=
 =?us-ascii?Q?tm3sRXzX4FfKXYeqRUk8pVgprg5sx/J9/pJpY/9LANEFsmVp/kjhrIbUXJf9?=
 =?us-ascii?Q?EbUZ9Rr2t8lXfLiGJD2F41dZC0TvUvMcasJ4DDTs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33413e9b-d273-4adb-58bb-08dddf07091b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:59:06.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9rmPCgBKX6llfMksPlO5Qd/sGnf7hqpPsk2cK5nu9BAq/9FyaQ1E9S4TPNMS7aznY1X9fR+Z3DuZvn13Q7JtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On Sat, Aug 16, 2025 at 08:39:04AM -0700, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
> 
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
> 
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
> 
> So, let's avoid copying parts of the payload to the linear part. The
> goal here is to err on the side of caution and prefer to copy too little
> instead of copying too much (because once it has been copied over, we
> trigger the above described behavior in skb_gro_receive).
> 
> So, we can do a rough estimate of the header-space by looking at
> cqe_l3/l4_hdr_type. This is now done in mlx5e_cqe_estimate_hdr_len().
> We always assume that TCP timestamps are present, as that's the most common
> use-case.
> 
> That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> the headlen (which defines what is being copied over). We still
> allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
> 
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
> 
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
> 
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
> 
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
> 
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90

As Tariq and Gal said: Nice!

> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 37 ++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..0f18d38f89f48f95a0ddd2c7d0b2a416fa76f6b3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1991,13 +1991,44 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
>  	} while (data_bcnt);
>  }
>  
> +static u16
> +mlx5e_cqe_estimate_hdr_len(const struct mlx5_cqe64 *cqe)
> +{
> +	u16 hdr_len = sizeof(struct ethhdr);
> +	u8 l3_type = get_cqe_l3_hdr_type(cqe);
> +	u8 l4_type = get_cqe_l4_hdr_type(cqe);
> +
> +	if (cqe_has_vlan(cqe))
> +		hdr_len += VLAN_HLEN;
> +
> +	if (l3_type == CQE_L3_HDR_TYPE_IPV4)
> +		hdr_len += sizeof(struct iphdr);
> +	else if (l3_type == CQE_L3_HDR_TYPE_IPV6)
> +		hdr_len += sizeof(struct ipv6hdr);
> +	else
> +		return MLX5E_RX_MAX_HEAD;
> +
> +	if (l4_type == CQE_L4_HDR_TYPE_UDP)
> +		hdr_len += sizeof(struct udphdr);
> +	else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> +			    CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> +			    CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA))
> +		/* Previous condition works because we know that
> +		 * l4_type != 0x2 (CQE_L4_HDR_TYPE_UDP)
> +		 */
> +		hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
> +	else
> +		return MLX5E_RX_MAX_HEAD;
> +
> +	return hdr_len;
> +}
> +
>  static struct sk_buff *
>  mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
>  				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
>  				   u32 page_idx)
>  {
>  	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
> -	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
>  	struct mlx5e_frag_page *head_page = frag_page;
>  	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
>  	u32 frag_offset    = head_offset;
> @@ -2009,10 +2040,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	u32 linear_frame_sz;
>  	u16 linear_data_len;
>  	u16 linear_hr;
> +	u16 headlen;
>  	void *va;
>  
>  	prog = rcu_dereference(rq->xdp_prog);
>  
> +	headlen = min3(mlx5e_cqe_estimate_hdr_len(cqe), cqe_bcnt,
> +		       (u16)MLX5E_RX_MAX_HEAD);
> +
How about keeping the old calculation for XDP and do this one for
non-xdp in the following if/else block?

This way XDP perf will not be impacted by the extra call to 
mlx5e_cqe_estimate_hdr_len().

Thanks,
Dragos


