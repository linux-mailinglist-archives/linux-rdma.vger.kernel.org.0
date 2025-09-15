Return-Path: <linux-rdma+bounces-13378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B342B57D23
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0662A08E8
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5A3128D9;
	Mon, 15 Sep 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fiRfa8ra"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06130BF77;
	Mon, 15 Sep 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942909; cv=fail; b=ZAK6DIlUhRILXxpScBk9mTizVXnJPWBSMMmJubB1iGwnS+B3AvRamptaGb4k7cqEM8cVAEUqNbQ0LM1xLde4My1cuuEiUDE3k6FemBwwfiunfNAID//asZbSSIKTq4EeSzmW4IjTZtyY0o96/VdJHyMACsapJaJBUaTNjWfgmy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942909; c=relaxed/simple;
	bh=mZzUdjAnvPmkO3IUkc6DY2dto9pdZsGpGEqhlCD2Nnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vpw5/p7jpYsPx1jHsLIP3qpGbNAKWEZNlIdooBRDW91Pk5GwpFxrA/qAuOv8WVYL14thTcSOlVe/IMXRFh1oRPeoy9ThvH92tfk9vt85pvOkbdTryCUnWye8sKorpbE1YxgFtNlKpRKRNdjDhQsmAxOdvjWqtlb4kBz+clHRpqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fiRfa8ra; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0L71mzzRsGlIHQ9GniOacSCoIXIol2iI1W4AVceT/ksdkJB4Ik/O1cltoE47p7krhPZy1NHsRbQQgyRUURJ3dCfRtIn58hTYvlKJilp3CPFqVo4RW7X+suXSdHgaK39izRNHOc/Ei/ptIadwPgIRk4d85h9LvC2ugeG+mZobG2LyG5j4YYhFk52QzvRTpeffAKTaoP9iuCkc0NHNvIz1WA6HVfgMs4wWoYeKuaN01VRxTIC2X+2N8hGkoRz6YnyaibT5AU9MLqOxUJOLvgAaIayg2DLl8XgbAuoAzEXmHlPniesXyIGjFxbYAhP7cQgiQOcRO4fZzu3tklT2847Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdeOJBJzMeks55E3szjAFJgrbinjaV097RaXdUKwYE8=;
 b=Fn2JCmWACtV4KINu4rfVG/HyEaiy7gAxpssbRugojil6PUNQwmZBKT6ofXrGZ/OdWhpw5Lsx24+BEtSI/1rju6ig7PbYj9HMRGvWY+TYda8b6q4HeRyLusBunT/G7J4U9HVQHVmEvr9HkNULy5ZTe6MQWUPtyTqxEWbYh17Iu5yz3YOPJgxwtFCcIZ0hyqUsJLjOVMF1F15vpGVqGR6L9edsBmsr3Akw6gC6/DplnnOiutwthyy2Qb09Lv5HRLu3+gUh9LBxqGqJ3Ur7RNBxsqND0KYSpz8xmcDmWqe+/eOuW7u1h0aPkL/grxHUm5iNIJvtYZU85YkkU6Mf/yvxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdeOJBJzMeks55E3szjAFJgrbinjaV097RaXdUKwYE8=;
 b=fiRfa8raMmEAsAr0rubwTZhZnDUuiAL9V5gifr6JaM7tSuvf86/9gOrLcD9QA7ESg168LP+Ofe8tr2IvifgIvxy1/a2UH47+GlCYcjvvGjr0fHm7VPLM1vyChXw2i7kkGSCYXdKtQikOteoCMpDtmbJuvl8oWQmxT+nXvcylGhka5QY17uHW3mpHp7hjdm5L3nl+7FwlTpMP0xJft0w3HwvWV19sgoWLsa3Tp9CP+nkTAJ5cJPGNYadcB7rIbHA6rfnZ0Ou2AHl6ZnIrl8Q7ZPI0M4wmmTde2CDGs/zFdSlE2SjD3o0xxsha7oPvgb5M3370SWQ2D09zviBHGCKtkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:28:20 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:28:20 +0000
Date: Mon, 15 Sep 2025 13:28:11 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mingrui Cui <mingruic@outlook.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	saeedm@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Message-ID: <gns4qcq7gz24conarxktc5hl3hzgwiltqqotg2675ra2uz7awv@rszzlmr7kztr>
References: <l3st5aik5jtsexq6yng5el5txeif4itbg35kl2ft32zhi3pmef@kn4x6bo4ws7s>
 <MN6PR16MB545062E2EBB54C553CE059CFB70CA@MN6PR16MB5450.namprd16.prod.outlook.com>
 <kv5syvra5hlvswecmzrbgne7ydmj6pf4dhzcoica3fdo6dina6@64w5pvo3lvbt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kv5syvra5hlvswecmzrbgne7ydmj6pf4dhzcoica3fdo6dina6@64w5pvo3lvbt>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 314cf901-bcf6-4215-10bc-08ddf45bbc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sm96kfjkZLp1rvht9byDF4yfpXvxhob+BwTeein3mPwQsH2N+nvX2Yyk8nF?=
 =?us-ascii?Q?yKRpX6aWa0mYpK8s9Ku9wG5YAguG7yL1O1BD3cGpfIy1BEdESkFKBTuUQMJF?=
 =?us-ascii?Q?8nVnh7f6mlDHfJPtnLkA43F6spST0vXCXOCOJg02ErRPkedIfp9EOVC5pL1i?=
 =?us-ascii?Q?2Bhrgw29DYJlgRJLt1P06JxQfQ6OL52Yflib537xDIEvxRqwxtP/avwulU9p?=
 =?us-ascii?Q?Z1pzNb+KSZyUlV4DtAWxl0mReCicfrWYA3VvGqGJi5BMomEwLSJMxa+uERLW?=
 =?us-ascii?Q?ksLmbmsUIpOgo4vays37NV7DXKnlj+QhHC3P3y04h6YOLA68JvSWnjB4RI6Z?=
 =?us-ascii?Q?6vLZ6A5sVFyAq1tnbFZ4uktEeCkpPXYHlQmFC7SXYJJkMyZfTS+D1hmps3Av?=
 =?us-ascii?Q?XDLfW/ZGbrtvgwFvg9f/wnb3vyejl2Zryzx0nLCW6MTKYpbr+OPcmhVMiR3o?=
 =?us-ascii?Q?MJAMMtEe72oelqMllUScQdIJODh3nV6A0aoXHTYW7ARHQm5FJZaqBBjvqG2r?=
 =?us-ascii?Q?m49MKcIcNPiD3ZhcepPxoonDP3Tu4SAwJXZ1u0m5m4aXsNR+fDKbYhff/BqL?=
 =?us-ascii?Q?aTMYBDm5pY95WdKfbbc9VwVCgB2Hcs1E565Cf2GxB7A75MZ4BHdDGRKfRsdV?=
 =?us-ascii?Q?XFdQFuGBzQO2W+tDwQ0/4KfqJwi6JSyXFwf56tTT4zXOnt/X+WzADXSZWk/s?=
 =?us-ascii?Q?KS7rvjgbEt/RjHyOrONch+S+r03NrQmF5CTnsr0DxG+nTl/NI73zVOk26cfZ?=
 =?us-ascii?Q?UiGzpgDk09ksgEkH0/c8PCiKeixYVzMNIaObsoOjVjh4jPNBEagSmA6/dy09?=
 =?us-ascii?Q?ssX6qPLQ7gqe36G8i2JQRMInAubkH1yeHBo/hpHoXQcqk8I3TiEeWdlKV0d/?=
 =?us-ascii?Q?Xs4NGfvxHAEjkK/Q9wZn/OpcWluWKHkhkeJ9u+eCgXgm2ap9Lggbj6B5/VNx?=
 =?us-ascii?Q?p3bCKgMFlyhrxpCYhYBdfZNfqvw3S6VhVhDwwPZO1BD+gK/5xsJnc831J4Sf?=
 =?us-ascii?Q?oSGobvBqhGy3QZjsLLWJrcwWPFrmxNaI/tBpaGhicWiaUrTJY9q7i7SmcsDf?=
 =?us-ascii?Q?M8Mo3ScCr6HfbnLplqZgeLzauKGbU0rhOelaaOyv5zJD6vKKCnJ2fvXxyJk2?=
 =?us-ascii?Q?xTY0MCJ9aRxv5JW5jroRRK7+mZEti5eW/3t1YDw1rMWSoYxv3RmdkufhQbKL?=
 =?us-ascii?Q?6nTKyRd4wzwtHujuppasJIvRgWvcGx11DUZJV86YhvsnSt4SuJ2h6poC24BC?=
 =?us-ascii?Q?sCeOVZ8qn0FfbRRGYZm6pzH/OAcmTOYPf5IChCi5e9C7yGQp9qxOTNZ9pM6n?=
 =?us-ascii?Q?zqQu5sVJYhlNc0Kn6Z+MaJ7QZEfXdwx1AJ6E8M+ehiJsJHCNl0jZtPuLNCRG?=
 =?us-ascii?Q?XRnFHw4cOBUX7pBNwxQsj0esZ2CNgflyqzpKIl1af0MemBlot2paws4leZAL?=
 =?us-ascii?Q?+Uw5WOhvwJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z6AUu2IO4ksWf/giGqJB7q7FbYOCEzbNw/CJymg7DTWHVgAN80FTqMF4IgAL?=
 =?us-ascii?Q?R6lCTh2fxPPpLvZ5VFBOJVro6xpLs428SKeoATk2nWG/TIXRnthRIqK0/nQl?=
 =?us-ascii?Q?KuCKEIfI7KYT0UiJAAfkP0EJJWtd3NISdtHIYfjh6/BGkV2AZsmtxAonrCrX?=
 =?us-ascii?Q?dXRNvMtlNzlTgZ8MtmIVuY/0xNBWyKHTOnwd4lTbBBhkFu57XRlUJmaHYIIL?=
 =?us-ascii?Q?b6ogio6Y57Olp2OPmCBOdBL1BCVr60Feqds95I6hxksngj/MB0f5OSvwD5V8?=
 =?us-ascii?Q?aWRSkvmEA/KlTbViPoV3RHxu+60HVGD+S32x5FDAS+/fk7LomM1sc8ZRVzyp?=
 =?us-ascii?Q?qKNbbHYjXT0IySZZ/fTR/GZbZ10hjiXMX6t9dHeEr7nOSNVrDMSulw0U5Mw2?=
 =?us-ascii?Q?5V9vC79Nhrz+grxjEcUGe08jfg+RM7td4YSmTFf+0VmmWchFUWWAvSSro9zk?=
 =?us-ascii?Q?jpItSx258QU1VIFoZ4Lw8P1NxtQ5o7OMnyteMUojEoA7Wumh8nFO8+ozWTjB?=
 =?us-ascii?Q?ncwnojErTQJtPMgBShJzZvizDUIaoajxgA38S3xMtnYiBLP4VIzIM6QmTDko?=
 =?us-ascii?Q?LUs1Qzm1xJVCj5ogW5LtCTzafvfS407J8EqsSKUbJIYUaFKwoP4aoY4etWgA?=
 =?us-ascii?Q?QdGkumMvfq+yH/XBQLeaGHf2OBnvmeuMfNwrxMC8HQby/BgtjCwV8EZ0V7V7?=
 =?us-ascii?Q?yYzcf7i3LyeQBNcgdNRj3cOTbr3juuXJsizlRWTdPg70hSYEovwY8ZQpnYFL?=
 =?us-ascii?Q?Y2yJPjIjgiJzqoYwk04Y130oElRSUmLDOIc9kMRWkEgn+2LiAGVD8mw9WIP9?=
 =?us-ascii?Q?lj4S4iOgMZd7KKCYVVno7gT4r5UbVuVsfWVaQAtaHPgTM8iXQ9WUycFwVWnb?=
 =?us-ascii?Q?fn7zJjmg54ULbb8y0+Xk2SFD2u3WnUcK2dGJUDDYTsV259wwziIerKtKuhqT?=
 =?us-ascii?Q?1566aPOrE4wxkjcQOJbb4wyXXi9UMiV3lXpVYZDBVJzVzNjN2jEOmBBBxBZp?=
 =?us-ascii?Q?b0S2x42j+qKLWEoVkVHprDkDLfVVamTHR1O1jJf5/Wv6gqBkrW0yxyB/4h0j?=
 =?us-ascii?Q?zgzpw3Rzb3ld9N03Yi0Ot7Yi7Jz/tCvp50NpoBfshXbIjvoZZr8dX5ZPxptq?=
 =?us-ascii?Q?E7miQbHRE8YEGmNOhn6RGToE7TYOT+6R2cjzzVbftdcV7wy8HNkQ7valDrAD?=
 =?us-ascii?Q?3o77XfjedCUlo2ye0v2XgNVsKp9NuFNr3NuC1JrJ92TlvMgbXm40amxTOGtX?=
 =?us-ascii?Q?/l6BnphFLZ41Re9j5oPRuud+ARFv2mymRGa8vl4UGA4BxHve4sBNUGDukegS?=
 =?us-ascii?Q?8gcrXtjQVZOBUoWKuoZ09ioLnA/cRA8f5pEDFBYufxtw3hsrSDxuHnBQWLNs?=
 =?us-ascii?Q?V0kmbsBW+bQ43i/yVBu/DoWTUCbOjj0Qzkk27ridozDWxpXowWUhZmbITpab?=
 =?us-ascii?Q?GPZeYJ1wTm9vzj0GubNvlkEgHtcNBBOkOyYflQqiVzGkpSE/ntCPOtBWuxX0?=
 =?us-ascii?Q?R0Gn/63S0jYrP57O7XkdBi/cjpdcQtnkXTyOknFTNuq+8d4ZMr/VC6pcA00V?=
 =?us-ascii?Q?ugi8Wz1d2kwfP7Or13roUGlpnaVW2gxosVLVWxIz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314cf901-bcf6-4215-10bc-08ddf45bbc70
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:28:19.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOJSM9ajCOh3nyvWloppVgZE/sXv25OPMrXLlGg8wU9r6vfEKBrcFz7qY9FE327J9fQCrz6WMiFHoaZRDeCJ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

On Mon, Sep 08, 2025 at 02:25:48PM +0000, Dragos Tatulea wrote:
> On Mon, Sep 08, 2025 at 09:35:32PM +0800, Mingrui Cui wrote:
> > > On Tue, Sep 02, 2025 at 09:00:16PM +0800, Mingrui Cui wrote:
> > > > When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> > > > fragments per WQE, odd-indexed WQEs always share the same page with
> > > > their subsequent WQE. However, this relationship does not hold for page
> > > > sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
> > > > newly allocated WQEs won't share the same page with old WQEs.
> > > > 
> > > > If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> > > > page with its subsequent WQE, allocating a page for that WQE will
> > > > overwrite mlx5e_frag_page, preventing the original page from being
> > > > recycled. When the next WQE is processed, the newly allocated page will
> > > > be immediately recycled.
> > > > 
> > > > In the next round, if these two WQEs are handled in the same bulk,
> > > > page_pool_defrag_page() will be called again on the page, causing
> > > > pp_frag_count to become negative.
> > > > 
> > > > Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> > > > size.
> > > >
> > > Was there an actual encountered issue or is this a code clarity fix?
> > > 
> > > For 64K page size, linear mode will be used so the constant will not be
> > > used for calculating the frag size.
> > > 
> > > Thanks,
> > > Dragos
> > 
> > Yes, this was an actual issue we encountered that caused a kernel crash.
> > 
> > We found it on a server with a DEC-Alpha like processor, which uses 8KB page
> > size and runs a custom-built kernel. When using a ConnectX-4 Lx MT27710
> > (MCX4121A-ACA_Ax) NIC with the MTU set to 7657 or higher, the kernel would crash
> > during heavy traffic (e.g., iperf test). Here's the kernel log:
> > 
Tariq and I had a closer look at mlx5e_build_rq_frags_info() and noticed
that for the given MTU (7657) you should have seen the WARN_ON() from
[1]. Unless you are running XDP or a higher MTU in which case
frag_size_max was reset to PAGE_SIZE [2]. Did you observe this warning?

[1] https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/net/ethernet/mellanox/mlx5/core/en/params.c#L762
[2] https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/net/ethernet/mellanox/mlx5/core/en/params.c#L710

Thanks,
Dragos

