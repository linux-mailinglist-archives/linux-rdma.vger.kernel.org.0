Return-Path: <linux-rdma+bounces-7159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3ABA184FB
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9237A55F7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D71F7092;
	Tue, 21 Jan 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvhFVlyp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3991F542F
	for <linux-rdma@vger.kernel.org>; Tue, 21 Jan 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482936; cv=fail; b=bX/i+DPY6qiQE1qdQia8QvUKJgIUgHrxim1eUgRlmDLasfysI8N77n3HGZ3LNB/aZMbAB9XNNjaM8SAZwcACb/poZmgASt/YSf0Qh1/j0EaTCfNKVlFl8of0Z7H9YPDhFk5rZFHtKOrkrCYfzIhJ4PGD4HGL+vvBOGI+BnDIomI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482936; c=relaxed/simple;
	bh=4mVNptCmGSrmCyTJmVwTwTLFeTUjzmOsJ9/2DI10kE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a6RkwzVuTVZ0N4UW0RdPE7zxHeDSpW6igyBRAzh15P66zmM27cXaKrNs7LWxm1LtG8/bi0MLqpTId3KA1aRSbcdkRg074oNBEfCKvBvxGEy8IZa6mT19+G7id22vQAHtY6WGsylODIB4r2ketQ3U2xi5049gkX2+3gCPWz5MAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CvhFVlyp; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ/V3yGZimFM54e/RvbXoZTEV88RwJm/uJ9G52fquknnRR7XXPWa9WQwXyjCdkqLUYY4m1m9Wf2j4xqDl+d4b7IaSyh6L4DxE7Hl1/RMHr2TEhC1EY82dk4jVwmYd1CzWRjmNGqvsLcbW5vwFGGTtI6kLVRkHW+8vr6yVwpcHcBG1GZytoSM1UIWvg6SXnUsMZsjlO6YUaiO0U8RQmgBo/2NnN/+Lme/rDZWeTBG8q4gWyv4Lpa9tIoM5qqi9KJst9c4uW9X2IIyIOSiG8m2zQMT/SL1m6LeuPR4g0VWxPR0A//U/kO1PJXsKuH4mjosEY/fWX0AUI0P6mnm0SFslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lFI+HuXz6tbUO4aMinUNL1cRW1PGYKpUBRfG1VjSMI=;
 b=VUmcGxlGzI4moKFQlQzGN/yrqPkO0Fn8yseGqzfmOrZIwfwsoRYZDxb6/r2la+PRZ+kU+YHoLYzKiEiWXiIAMqdM7DCjI4Ou7Uv62293byDCYCoDnzjbgxPy9P/6IlO5PkI67MBPZzb/HAd24Ex+ufuDjdrccQl4gmacLTW+RXZbWZDeb9FuV0TXqHFoMCRVef7MzlGzkrWOzPb2kWapT7YlIgxx8qRoCWs4J4iQxGpyJ73b7uElxCeXEOOLS6bZhIeJYz4IPfKGSdbNVcl9p7drAoxRYP8og49qqNrI+Sp11SUdzN7erVChM8tX8EUSJzRk4hANPKGVlzaj6p+5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lFI+HuXz6tbUO4aMinUNL1cRW1PGYKpUBRfG1VjSMI=;
 b=CvhFVlypugBmUGuieKvbQIaK7QOps3OvH1C6ZH+pXpPiZmtc2x4DW/WbajwzesOnYRSGvVyMYn+buxWzFHgNTF4Up7FwYCrich/vy329jt4Vj9Hy53mGbSmFSBQKKUAr7E6fbyn5Y8skmBfBAaueqUstIMP4QVsOp+tsyfPQcEPDkC2PXhC/dEssGDZXhYkzLZmENfUBMHLmXh97kKLrLmjM6jGw7dOiMBdJM/0kUwLApFhjsbJmzB54mDBpD2dCZIjnHoyZsFDr5edxwbx1xTbmioFd2p3w6fIGSzvOoJHVvpxHZcECAIQUkuDXQ3rMv03aeRhUhxHMHYqD9L3HNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 18:08:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Tue, 21 Jan 2025
 18:08:51 +0000
Date: Tue, 21 Jan 2025 14:08:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix a race for an ODP MR which
 leads to CQE with error
Message-ID: <20250121180850.GA881799@nvidia.com>
References: <68a1e007c25b2b8fe5d625f238cc3b63e5341f77.1737290229.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a1e007c25b2b8fe5d625f238cc3b63e5341f77.1737290229.git.leon@kernel.org>
X-ClientProxiedBy: BN8PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:d4::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: edebd4b5-1d42-46c1-aaeb-08dd3a46a922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MN+RKOMQvX5RQtbLt3g8phbwL2Op2DTlsppVhWFF1HwaYXjYxBjXv7ywlAq?=
 =?us-ascii?Q?oWUmOTtxjjaV9bmOXQHIoXxseEVIn7LGZwH5A6up4HB+ma2m3Dkab3zrfkcI?=
 =?us-ascii?Q?w7mG6JJ+Ow7JRjnYMXClOBj5jyDRiUTVKQjv7bUaQsRlEFefLIBMCnbEUF6E?=
 =?us-ascii?Q?Fpe3BWSVmLzHX6xHrqsde1lmRP0iRogQqPLC608sm1S6WK30SnjM11An5U5h?=
 =?us-ascii?Q?ZMA8aEaXhMq7XMtTu43vfnmTg4Vl/V3752sUrSyJ54uZInvVzvdOj8dY/v2P?=
 =?us-ascii?Q?uiNbxiEX5143SjJ95+EuaR9dUR7Itt/QoOc2IlB1LB+ei0NSlsvJr8RKW0ww?=
 =?us-ascii?Q?iVWLg3cf9EZ5FlUCLSYIOWqooQ110htoMS1nrxezZOR36H1qOpVaxGMdfzAT?=
 =?us-ascii?Q?00s9UE9HYzSjKRV1bP6bSTe+rRGLUYkCVlyf+gkxLlSwBKHz48kM2HyIxGFX?=
 =?us-ascii?Q?nB4J9I7VqCApSEpSa1QML/RWisyHVQ6VvinoKjAYt30RUBftBQnvZYmtkymf?=
 =?us-ascii?Q?PWJK7jjV/oXXxhANQim1/TEo6RfmUSqQKRfkRNEt8622fwW4pekG1NH83OOH?=
 =?us-ascii?Q?a10B6e93Qhvfmncb/B3Gab7a1FWndpzqDakclGNQQrY/+C6xgGfco+5Ftcmc?=
 =?us-ascii?Q?1zX6BHUmDvHfuMNiGlLa7RrYMMlwqs/iqA+TquT413qRi51egEr7CxiPxRj5?=
 =?us-ascii?Q?vN7SusgmCV/xEXLay9p8sF1kZaDh96vaUkb0ySVLHPXGHwOD+LSwP61yOIRj?=
 =?us-ascii?Q?zIiPsYP1+zw5PtYJ4RKgdac+VkzmhMvNiyFGNZAyvvU9Dc7oixPWci90P9II?=
 =?us-ascii?Q?xWYNAXwPaEGk0vst8N6bFf3oxfT2N4P7VjYd/nxCeE8Fn99widObKBPeGVB2?=
 =?us-ascii?Q?fcVt6FDsGO/UPmAZ1har+mfG+F6p99fVnexXx0GnDGkZBXVi+HbhsLhivd2s?=
 =?us-ascii?Q?/uWZHD8eD+0pyCM/aSe78/ve7HepxOfO/kmY/HaImxG0FS2Ff7VGtpcz/EpE?=
 =?us-ascii?Q?6ViF6e4NK/zke8ea9gu9/ZVbeN85JgozIZu6TGVgkOzxw0EmqoUPHZ0GWD3N?=
 =?us-ascii?Q?16uVycDYItc25vUMB5NRWaizDGmowWL1lZe1p2fkHSJX6s/8wHPYxzgH9sx+?=
 =?us-ascii?Q?GM+o9GX79OLeqitROK4vnBPYPgb9djsDotsEAzRYkAZW6KrqsLNIm4ck6MW1?=
 =?us-ascii?Q?QxvVPZSJxsq2OlG6KdCBTsJsJAJeE968zkU3qDHfkHbEtnFKP7TqtIz2sjml?=
 =?us-ascii?Q?18o9gJhnL4VOSnwt2rO+BbQN773k9Z0mVKxupMJLRF4iMwI582Y3YGeM9Hm1?=
 =?us-ascii?Q?cvWQFxuSopiJJSJUz/1EXAHdIfibGUvZ31JZrS9lL7nIn2ble+2wL4u4eOSK?=
 =?us-ascii?Q?8AhrDCzpHUcCZMkvU0BNSxCCAZ8i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTyu/fN64TE1G77OfbIOF+wBVPYNU+6WwMiz6B8sC5KNzVpS/DxQL3sgBFjO?=
 =?us-ascii?Q?DAYyPNl7xYZ7ZsPsQPmwXX2jcD2mxu3/SqBkiiZ8snu5kJrQDkhijn1yZcQ3?=
 =?us-ascii?Q?m36NB+rINEHHrKXY8o+oU9TCDfEhXnXta2VRvZNhDOPEJDQosnNI3GHrRjQB?=
 =?us-ascii?Q?Bf5/o98bMDu16ft5TUhdFO8QkbBq/QQu4AzsGSfrG/SsJv+XT0CYnRjcNlul?=
 =?us-ascii?Q?LDVU8WljHlWEm1cjizPQmjj+ve4JlLjYw/eXKzu0xOTb8wBcbsbLyU3DZsao?=
 =?us-ascii?Q?lVu4pUbGF0LNnOhVqhZFisp2ckM5kcmrR/B4HTLTIyL+3V8+L1bX2kjs+jD+?=
 =?us-ascii?Q?RUkxTjMJTmN5q0BgchRZCQN9IHt0sHMlnCVXOiBTWM2SL5ZYiSiwBHjId5Ec?=
 =?us-ascii?Q?0TP3YFpDWWOwmaaBI/tPV6fZ/PzRflh9/kT2h98oVfp0EUl7rBfK1s8vjq0v?=
 =?us-ascii?Q?i39XAp2j16h1AVsrwzjFgmb2NsEM2W+awE6YCA5Mmgcp8eC51Nf7WStGzCSz?=
 =?us-ascii?Q?GN/XzxQlkTVHdY0D+gN4RRgCOD2N0++UbqPQSm5/7nmIndoEUAkICQAONu3y?=
 =?us-ascii?Q?zuqC4OuIUHmLS5+z+pcYm9FuUOBRRD99UfYUrew79UNNKlBFM4vNTNI9Fl7M?=
 =?us-ascii?Q?P/aj4/olONHVlN9Oo2/YmHxek+UNNa0e13hew8hoxfO4gy7B7p0WnYKo1JU/?=
 =?us-ascii?Q?inCw2DB/gLodVT1YV9F9qfqWv6OHxp6HEPNLh5Ni9dtTZAmSZsqQN/M7Iqzc?=
 =?us-ascii?Q?sffFoAKBv46iIQy2VUvcgCHLfswAEdKNR/V7o2Y2C8ufKLNhnGKMWRcektSi?=
 =?us-ascii?Q?bMy8HOX2S7FC0+NhhBC+IvUbMsTcRvfCejst8xFvizJyVOWOxxyTA8JXdsdG?=
 =?us-ascii?Q?d8n8j80R0oDVWdmrBMgj6arO1IAfXsbElT8R37mv32lYDwyK1TRZgb4nkZG6?=
 =?us-ascii?Q?gjmSln8lv7BC7YKXO+Sp8n3PRRdyJenWQO5CxcXmoC5MAWHIXSjmivijw5QT?=
 =?us-ascii?Q?SLdw8oIPYDnmNTGWMQA5QZVeSABStVg5uQZML6WUxd+cA0V//sLQLtKqvK5/?=
 =?us-ascii?Q?SOnftIagPy53autrQX6Uw2Absxvg8ckU1TcnENa4tZ2fLoeN3dGVtFJFFB1q?=
 =?us-ascii?Q?j/d8fo/Mm1UKLmJowlqEXINNXMKU8pjQ4zCY1Z2sIb5KoBaQXO3nGFOXTQ8C?=
 =?us-ascii?Q?fyeK0OF+k0CxxWe6x19gVtfZWlfvlWguAJc5BCmTIjDinvfaeHCk7FyflJk6?=
 =?us-ascii?Q?9bV5ubueb2LbglSCOtfQimZUvOh47FuVJEFluJrc1NSTIXvvUnln+Pyq+tkQ?=
 =?us-ascii?Q?FugShSG8LJe3RRGlogusegetdIDC/GemvMHsjAaZTKbSFbX2MVYTvCtxMIpp?=
 =?us-ascii?Q?fJUJPsK+MrAbD85hXecd4y51dKSarbi2t6otJ7BMgWnyMEzomsNSdIkP9KLw?=
 =?us-ascii?Q?CB/fEHHCrUMF5f/llxXnpAzy7SYYasEU/B8QJ4fTSGkDf1j0DT9aPtRdAiZ6?=
 =?us-ascii?Q?FYjEyut95Ux7RyO6D1RIm/d/XitoxHUphMTz1Pq1YPUdVUwcVGEee5di6Wnt?=
 =?us-ascii?Q?6w6hPrXrDWM5T7VWCvtUtTPVp4m/Gy9CcMPn+G/Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edebd4b5-1d42-46c1-aaeb-08dd3a46a922
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:08:51.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4E0pq6wzDN3oPz2T6kB7R+hioYrvv4qa4+gkzsXchTJDuDIdViNKLBB2D5G5Ya7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

On Sun, Jan 19, 2025 at 02:38:25PM +0200, Leon Romanovsky wrote:
> 
> infiniband rocep8s0f0: dump_cqe:277:(pid 0): WC error: 6,
> Message: memory bind operation error
> cqe_dump: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00
>                     00 00 00
> cqe_dump: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00
>                     00 00 00
> cqe_dump: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00
>                     00 00 00
> cqe_dump: 00000030: 00 00 00 00 08 00 78 06 25 00 11 b9 00
>                     0e dd d2
> ------------[ cut here ]------------
> WARNING: CPU: 15 PID: 1506 at
> drivers/infiniband/hw/mlx5/umr.c:394
> mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
>           Modules linked in: ip6table_mangle ip6table_nat
> ip6table_filter ip6_tables iptable_mangle xt_conntrack xt_MASQUERADE
> nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat
> br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma
> rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_umad
> ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core fuse mlx5_core

Don't word wrap dmesg output in commit messages, ignore any checkpatch
warnings.

> Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Artemy Kovalyov <artemyko@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c  | 17 +++++++++++++++--
>  drivers/infiniband/hw/mlx5/odp.c |  2 ++
>  2 files changed, 17 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason

