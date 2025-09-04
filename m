Return-Path: <linux-rdma+bounces-13091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C898B442C9
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F6F581180
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29354234966;
	Thu,  4 Sep 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckYXYNLu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554011F5852;
	Thu,  4 Sep 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003525; cv=fail; b=OM1jn5SHglmjamI+//LcLPWxR7RIDMaBaysM8KTiaX4GW82X+b7hbgAuMExBhAFxZvz4bZIY+0iUSkwXjXG2+oOwJrVbYhMzB7YEd+aY5UHyx3Fos5qs4+seqopScGRBEAWtARnLT1E41C/ygPmxZ6HNp9Aa8BL+j22mcil6K7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003525; c=relaxed/simple;
	bh=vXVm6zzecukC2UgIWjnmVyvU1NDqu8YOTaCm6VOcV/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDMpT9wDT8qJ66ZAWgXwzC3wSKvs5m33QBst7O7DxryxpnqE8Hw315ICkb/Kpe5KNeBiVNbamHGqbYkt/XIZo+YVW3XOTPqw0dPMZuYstFZhGiie6V9lcGxQPCnbiIaSYctodjQF5+5rOizSaNFAIFXE1NcEQfYwTaPHhiCBWg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckYXYNLu; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXZs3NxWCB1DfdGB6ej5KLBh33Jkf0MhCSuA2aFlEKO1zcPOATwZF+2GrmNrT3uUcOOGOdl+5dYxAC73OFwYUO2Ptin6V5QdRjHpxhH/JzLyO0wsYkrA7T2qkU0FBYenevPPWEek4Q4STDyAHY0MMcZfJnrauHGKND37lN8Bj/TZyqvsokWSUNKrLJ3N+Il4y9rpKVX8HGkO67x0T+9wYU6gdRjavyGYG3DXOzuxgN+PgQNNbmWy/iISSf1knfVVDl/s67TIqOjPjXYt2Nf5qu9NUmyHonCLgU4jRdBIjNrGUNST8XVr09jsc05eUHiu87R3PL5I39TkVUpSqAqkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APTufVw4NUP67n2ULFzRwWCwgxwnOAp3QwM5YR8m4IE=;
 b=Pw8ENyhDWC3NmnOH2JcKdoHjctN9jMBMCizUVKltjaxPK9jBiyg/lJ/tMNJ1/YgI/O3MVRO2upt8NCSKxZOdEWEjq3wLfKmGrRg7KGxSweSf0Kz0hT+frqejM0q9aJsQYoenhOBWUHQWXxY21PpdrVAmyW8lDT771aaPvs5M91z/V03MzzK2/MTe3dDdfQrg+1rVJfQVzrCOwr0ojUapMchQAEjMtBqh0t+bhw2Mwi/qwgXW0oxoEwpQtQ+7hze4EPXCGte8xyfaiejkcCG303wSoEfX1tf+dMjmj/OZzR35oQe+kOTHTpd6/18vWuNqAhhqOUEL4hg09b1f19/rWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APTufVw4NUP67n2ULFzRwWCwgxwnOAp3QwM5YR8m4IE=;
 b=ckYXYNLu0uSlAOVP4h0zNsJLHyTqLFSRUIUk1qAfpjaGh0hf+FVBku83Xc8lLT5M+/NbvqJ+f6jlbJGlj7p9Qk0+JTT7FJxMJmVCCYdzUXeo3xdP4MRHU8K4t/93dR6lFNDUFXpVolrEV+gOs1hVFK3pW7U83D3ugTEUfsYqQwb/QraxD/iQaPnKCzuRsugJVATnrqTC7K47+ZE0f545qrYSKdXe1DqzFF5JLM+5cWhYsJ6jtAIdgqqBNd03P7BmCNG+qcRFQdprg9Ar32C1meVdiGOcKrA6eodrN8q7uGCU1CEMI8pNBLz/juRs9DsNeifePqAQK1yvtgHX7G/jhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 4 Sep
 2025 16:32:01 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 16:32:01 +0000
Date: Thu, 4 Sep 2025 16:31:38 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mingrui Cui <mingruic@outlook.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Message-ID: <l3st5aik5jtsexq6yng5el5txeif4itbg35kl2ft32zhi3pmef@kn4x6bo4ws7s>
References: <MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cea0379-b566-4e07-e306-08ddebd092f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPLaAVW4d4PE70Hq4h8bZYsZU7i1yic7Bi11tf0YUYcBYGNB/8UN2Hvji65P?=
 =?us-ascii?Q?j9uNhWWp5JS5YRqA/eXMJjMjc7C9mf6NXpsb3Aqr+Ta6p/e2pywk8INTKwdj?=
 =?us-ascii?Q?kTKnEk2JjaDCOxd96xm3r9ojaVnrqDorTIeG+4JMXV8kASO0SOIkCUEbtrh2?=
 =?us-ascii?Q?M6u9X+1GZtZ+21SEgVA9zYzK6qKOnTbTSM9wm+jW3jQVss9EDNEvecy5KwQ/?=
 =?us-ascii?Q?iw3kVSQnuKIW7oYOV6Nj7LWcZ40RhewpO15/tyhJMa7QbRmTCr6eoGrxwj2v?=
 =?us-ascii?Q?KAd2GZpuz2/DyUnvcD35ogIQMqyxanXO7EIw11kS097sI6XJqxQQEqfNf2Y7?=
 =?us-ascii?Q?QnimQDXUkh5n0f3HJyCcFUNpKCSdymTlXMvAtgY+xn9m0RDwkaAfe8Pn3wc2?=
 =?us-ascii?Q?GYWTfxa4MjJIxQKKRyeSuXgs9YOqkUOip849cU1qO4GKYsbXvOTKa+N+OnRg?=
 =?us-ascii?Q?UhhMV3EdiHY0QBWr1roBMPYMAHpM2sxxmT+a/frZlfeOmoAs/QzsUneXaKRO?=
 =?us-ascii?Q?T5sfnGqGNv13o1d9JVNL1N+Sr6ksm/TqD9XtwqmQtOGOfbcbaDcxzAyH6mzh?=
 =?us-ascii?Q?CsKgsNJishB0kSAzjuSNJT7VTRxf/QoHjJZtg8zOIA12rTIlIwdZNiKdVZg2?=
 =?us-ascii?Q?b0eiZCCOSAUQf2HMNA2u9KpPkej0PhfX02TRHx8is2gEuV3S7cXU+y/g6Vbe?=
 =?us-ascii?Q?K6QSEyZftDZl4MhDAES6kHODyGH66lG0tf+zCpp/tlY6qV6oZnOeaf5ET8/J?=
 =?us-ascii?Q?xeNeffXSSs0ZPhZPkWSxzIvriWUhyhmsA39aDv+6yerWosJ/FovJHACCmO+c?=
 =?us-ascii?Q?wzxD/k4VLm21rBeVKnW3EE7o97E75SAe3y1k+FHBTXS14w8lPXFJ+xLTc2mc?=
 =?us-ascii?Q?kcx1zV72nc1PPEXvJKTKCCttlpD1Qg5FWtUgyJu8Ly7QXUE8YlKWghtm0vB0?=
 =?us-ascii?Q?vWFRGP7GewZmvXB+wb4JOBdQheR4BA631eXPD7nrovxfC5UjRHpH6HDAwXo8?=
 =?us-ascii?Q?8yqVqy98mPafVwZijHW0vBvcsuQPXUjnQbdGED/3Qw27gRtV7E4sKrwZD/0/?=
 =?us-ascii?Q?ECqjx5BYdqmaCZ70FPLWpFOuJYyGkJuHdQvl07USX7gMkXzfOYhB95LJ1n3k?=
 =?us-ascii?Q?vrgAROgYQ5Pi0nS7OMgalnfm9NKbZ5ytaSFPqlQFwIm1xlxWsd1Na1/+FYJ7?=
 =?us-ascii?Q?+YjAIM4A1Zqp7I6NGcAyUUy3S+se6lP4bDbMmZD4Ar8Qlome4KHYZacVAvef?=
 =?us-ascii?Q?ahbJPFrV9RPNxYJQjQGi5bfl0rngPOOKsgtfpMvlZS5c/fjXBAZ0NxI5gM1y?=
 =?us-ascii?Q?MopNlUUpfzOS8+JYCw1ERpBFDiq0rXm63GM9kho+/4nOjG1tsFiHUFgVK3a8?=
 =?us-ascii?Q?oXeh4J89w5VECIf+jRavfUdxsaqFvHK3tW09pi6Ms8uiuXlVuW8AENNXL+K1?=
 =?us-ascii?Q?qMT1Y0C8bgjhGE12+eQq7NPwAAjqEdI/nBydUcerxvmzInDJ39hZ1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFB4Xr34PRL93zG6q0UkRTx40uHrREjjQ5LAMD+fL5DSwy/uRgD0KvpDB62R?=
 =?us-ascii?Q?0rdXBN+iqSi08lYfimOu90oKPq8+0mX/ham7md6caq3GHM3ymepyw4JncIQY?=
 =?us-ascii?Q?+SkheCeN1l5MRsyoDzdHDBG1cowlIZVIoTBAMRCO9+oULsCB5Ka6I+Hp2MFB?=
 =?us-ascii?Q?fIFtZakGThe+JxygrYTv8z9U8u5Mdq5v6MiiITQhwp+iWxQAUmJgMajo6sUX?=
 =?us-ascii?Q?/Ev8BFrmYM9C1GGTHuZr861pDNTeRZWj+pRZ4oz7ivycw2bTf5JMj5rCgEnY?=
 =?us-ascii?Q?VZSNEmJxa02zDDuKIKf3bS8QvdvAP3R9Iv04nJrbsFmZ+GKFh/+qAFdkCni8?=
 =?us-ascii?Q?YHr1sWmEpoB0pP+VJD361+2n2amweA9vr3ZvPF238SDBMaRsQ6DPr/UUONSR?=
 =?us-ascii?Q?wS/j74W3nAqGC9uA45V/A2vhRO1pi5MmJUZOpY3Rnbmx1xTt+Xo04ahUYmD9?=
 =?us-ascii?Q?TQyUwS49k04sd3gLJtWuDeYyQ1cnQKBHE8KDUpRrXwQhoxFFNMoFF3hixl43?=
 =?us-ascii?Q?RWQm8ZOUFwb8kY8PfjgkyLjQSZvHnlMo3/I4WenQrdKDPZgxo9hOOMAc4F1W?=
 =?us-ascii?Q?DimVY0Z3Xi5CxkTqHvK7AEtU7I/FtqQuLQONXmL6bWoKHYmryjokrVxKY/eu?=
 =?us-ascii?Q?aCVItEnv15KID38SxebfUBaCfXabJPMKcSXkyMvOi9T2izbpm9sRKs6GIq/4?=
 =?us-ascii?Q?4nStPCXU73VJcIR3MEWuJbz0Kwy0GQr1dIxwlUA9ucAOecv8shZPrrON86Eo?=
 =?us-ascii?Q?8K87CGFH3HKjPXpDWOOfX4qekWqKkJxZ3V8jKbXahSnfc4IWrgFhC+eEvuuT?=
 =?us-ascii?Q?iKOOEhngI+0O3SO4y1+H81bnV0zBZVdDDIwo+gasoNrPJrO2x8Ziwrs8lZZi?=
 =?us-ascii?Q?PxIQF4AMGsqnGk9204taB2EZJqCPrdMQP9BJmlZGb8SHpLjBNnOsR9sOxES1?=
 =?us-ascii?Q?25ODxmauE1YXZLJw516NUOHhZH3SZJ9fzFy5m6OCdAh0babRfuWoShwrSX6V?=
 =?us-ascii?Q?R2i8tuK2MSCDqX7PEl5iyIqLdE9EIeX4Pcd88XAC6TgWDoFNho2NJhWC9RXT?=
 =?us-ascii?Q?14TaCRrDgF6SwOc0MIKfCpjMO21ZdyXjfZyeJA3o4kgrQs/S8ydFypMS/N+L?=
 =?us-ascii?Q?EanltT0iXUNm1STDDCZVPc1y48oeLhGEd2Xi4xrVwQ4n4NY3nhid5jvWfzWO?=
 =?us-ascii?Q?FRY2cE6rfXN6qOocIu6ZICivyTjXSxEhG5nqTcTDB5Ncbynvet4mqy1o5dXz?=
 =?us-ascii?Q?xYnShymaaZ9A8yM5zy02BAcVPnhRJnbgaBOS7j58qWDVLOOjQVn9B4gRgOOq?=
 =?us-ascii?Q?Vifd7yFhTqcgEGY26/YlxkO2ainPaN8KAgpdXy/oAJfDk26QaQCMR5Aj7L0N?=
 =?us-ascii?Q?CAnv8+t7WL0ZoIXQW4LGg/TVjWqkJuMO/P1ub4ftHGaDkxUwqK/JkE9LFcmw?=
 =?us-ascii?Q?QkEYEFGYPx/gd/P3MpXhLadFKsLMjiSmUrGuS86FNMdiBek4xHXWxv3Hcea2?=
 =?us-ascii?Q?aSgv6+uQg84X6UA3s2tWOBY2GEiSevmCm3WL6Wdfa6mnk4DKt44xFBWbFEfE?=
 =?us-ascii?Q?nKOpl/NoBRZz3dpC295/u6hAYDumAz8HkS1MYjBa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cea0379-b566-4e07-e306-08ddebd092f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:32:01.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17ge7yrNy5ETlf/nOzjd2tfAMITToHwRbBb5TyJrWnH4rNpGzuPfjWZRdO3mB+ABjay6YD/za2IDgVD4apw52w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

On Tue, Sep 02, 2025 at 09:00:16PM +0800, Mingrui Cui wrote:
> When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> fragments per WQE, odd-indexed WQEs always share the same page with
> their subsequent WQE. However, this relationship does not hold for page
> sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
> newly allocated WQEs won't share the same page with old WQEs.
> 
> If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> page with its subsequent WQE, allocating a page for that WQE will
> overwrite mlx5e_frag_page, preventing the original page from being
> recycled. When the next WQE is processed, the newly allocated page will
> be immediately recycled.
> 
> In the next round, if these two WQEs are handled in the same bulk,
> page_pool_defrag_page() will be called again on the page, causing
> pp_frag_count to become negative.
> 
> Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> size.
>
Was there an actual encountered issue or is this a code clarity fix?

For 64K page size, linear mode will be used so the constant will not be
used for calculating the frag size.

Thanks,
Dragos

