Return-Path: <linux-rdma+bounces-5311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A28994800
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 14:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232D81C2459C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F641D9586;
	Tue,  8 Oct 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rWasoDE0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD31D6DA3
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389074; cv=fail; b=IZDmSA7rbKOHhm5b6bVQzXcWZ50cd/YKrTDwtJM15T8rFHKZgrhmpSIyRE8iPVNYqsFoNzlknvmuk4N9jVFneaJ6G4m+fXrkDIaWtopY5lRQJ7nGAxnJTo/wDhPB/2WQua3b1lYz4ZeFEqPPHd55fxbo5L0yZZQsmknY97pUs4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389074; c=relaxed/simple;
	bh=szpTYgeumwu4eJnRFYfGdu+Oia6zDQnf4d47FEh3j6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLdwbMl82aVcyAC+lyzcCSI4QUSUfuf/g4ddlGnCvHbeyv3foI5yPNcNQF3p6U4i+8PI0Ys7Dqd8iOMjP6kFGcbHkH1mWz1aIGaNQvZwqdAw/HOoZmTTViivcuzbPH9bQWaHvbLFNGMGxv0cfYc+h1d+WLsVgVveVqq3V3dTGQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rWasoDE0; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFg7latr3QSzB6FcNXIEBmRpyvBu8M3GmB7UkPjOwhXxCya3J2FCUrKUu/vYbRhhBXTr+xC4W0waTdsj9mwvCYIYIwRaEBI1Mr266696AdWsa3NIr+H99ZwuWu4lDprFN5Yr/mvlR1uhYwIAApa5iMs+fIEKZfjME9Mdfck7BULNPj8HYMaI1p4r0TKILsUk+SeM6vkN7Jo+MMuQEbYHoHE09q2eHsyiQRPJLzNOWHIAUlboyYkmJEJn9DFgN/E4LgenAgoPUQkdfTbxFmsiXVTaCSfhEYz9sA8hqN2MB1+l+fuQ7wY5F4hxUGpu83nBOJhtI/gaKDdvLvnMvKHM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpT3HVtMRCITW4lpYS7QcXduQiH8spmV/p4acgwnifc=;
 b=CPukxSm9cMv51s2S9yePmyTYSKk6tw2xTX5zc2xzd3K7y8kcc4hTZJ9nZr+OJSiUf7a54xyXjNCMdNo+kURDPrm8V4cS4PDV4d3EzsUAw3OpnRos8NPN76Mrvogdl4TwcIyD8qft9PQ4QNcwMKTGMTiQSP92/G3uFSofc2DOvlCLbN+DZirUHlaBktYQL55/pPSeXS0lBzGS1AuTel/yBOXD0HeybFsUO1rx1QbPNj5UdVe5gGNPOR/wXEkdhH8Pwe6t9xbdR/gph73sgEmkGxiKdcqymK7gpNbVQPlEobmAb7fI5y6M2+7J+I643aQU7OBC0fDnsoqJ14cdW7XvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=acm.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpT3HVtMRCITW4lpYS7QcXduQiH8spmV/p4acgwnifc=;
 b=rWasoDE0NBTRyIRG2y3r5dNTCHWVphyCU5kRGIM21uQW4j4fWkvaAdv8H04qERek3wEOXnTok54x8lHK15ow255PGHu3zLGqpcoKTdFKHfyrPGe90mR5KQLWM9WAkjeoL1xmYXbq6D3IdwMhDlBm7KrLVQReENgldJw4GywGY33dl/CryzHn4hLaQPTGKxXYWiaq9LPImMBeOXDtJ6vXtI9UCy4R0L9YqV9Oku3RNaoYar8FlCqNaVKSfFk3QvD7gtCRDS1kjHC1MJesbr7krE7Zfp2/T++0FL6uB+XiyYI7Z2xXa/w1dYmSVoI+vK5s0UkwGkSjN2Lx2AB8glENKg==
Received: from PH7PR13CA0009.namprd13.prod.outlook.com (2603:10b6:510:174::12)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 12:04:26 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::9b) by PH7PR13CA0009.outlook.office365.com
 (2603:10b6:510:174::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 12:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 12:04:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 05:04:12 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 05:04:11 -0700
Date: Tue, 8 Oct 2024 15:04:06 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	"Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Zhu Yanjun
	<yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2] RDMA/srpt: Make slab cache names unique
Message-ID: <20241008120406.GF25819@unreal>
References: <20241007203726.3076222-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007203726.3076222-1-bvanassche@acm.org>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: da4030e1-33c1-492b-92fb-08dce7915b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBLvch6xYNvxB/kQYmh1H2CbxRWXmQtXgIDlbs1F5GsKIYqpWUZf3ic0LRbW?=
 =?us-ascii?Q?Dcxt7Wxg5Llul+4VVQWt7DGs/nUYa/lLLXIBNkK6Sp7iDZEykggCIvfD8pRN?=
 =?us-ascii?Q?Z4TMiX25gQ3os8rpOvsiuBOiBlbjbBp0SXMMrmGqmjlGsfR/ZufBSCc2Tr/l?=
 =?us-ascii?Q?q3Xa+xjPLOAiETuNvD72eNv91km6y7GL1gUWMTPHbfIOOUGRwnCdfHJN4zLu?=
 =?us-ascii?Q?XFW350uoUnbYj7Y58mLyfp/igCp0ifIRdW6iAMP8cLs2GeB99DIa61I7zRXn?=
 =?us-ascii?Q?55vj3GHjYzp6E/f6scs/y6IsGE15QI6jv4nY0eKRB5/IWWx70hzpCJu12GQ3?=
 =?us-ascii?Q?VMHktyCa1cdMPE0SKC+Sk688guH5YHopmuGHKi+QE7V75J2gvwaAAWjbMYPp?=
 =?us-ascii?Q?uKyJY9fSVjeq2sWYKe/MgC/IY941CcEXrVfsdZFDfUv65ygsmXPfbWhPKPN/?=
 =?us-ascii?Q?RV7M6IgAiAm0G+1BgfyNNDwUWc+EjWt9WNiP340MIu5eve2G5zpssEKqRzD+?=
 =?us-ascii?Q?z1jlatgjt+RXMR/q4RD7JBbUZaRwurkViBtovQ24Krx7fIFJ6bncRF1DakEu?=
 =?us-ascii?Q?8Wb3VoxIeIvy1bJX7mVQycpEMKOEvQqmtLg7MMfnsJJs0CnSS81T5ottgOQ/?=
 =?us-ascii?Q?ktAvw9YV+3K/CNNlzYTWR3eigs8M760nxPyFPNRabFf4xzt4hMjnqlQJYJBW?=
 =?us-ascii?Q?HEgqlrBmkxM9AebuGBXwCgRHCqR696+4slstaR227XWM6pnLoXJORAj57LzW?=
 =?us-ascii?Q?WCRDOZ2Z903J+ymsQqWeQ9TIwaUHJjOabT0E2ZKyFqlDhOhJmwW2Tc2zp6dt?=
 =?us-ascii?Q?s+1qyjGxAfaz8jpS8fdCApk4NzA5vncs8wZQR9FXlOh+r0mU6vP/wHlWIsQM?=
 =?us-ascii?Q?yGPjrasxZCbz+wF/wSIEYE5W7vGO1Y/XfbX/kU1ShPHsAElWd6fhu3FoopZj?=
 =?us-ascii?Q?uJ4vS7q0CHm0hMBe7JIAFl+fd0irDz3ufUuZ8BspQ6MsYkb72OKS/QQwEQLs?=
 =?us-ascii?Q?J6vydz6B3B1qvJYQ1ezxEGDzg1zyeCdo1ADFul3sJWAt1ENUvMWsppke/3Sf?=
 =?us-ascii?Q?wNiOgc1VhSqJuif5iUN6YaadHeeSyk1akLiOrgxtPG8UFo6vOQ31AFFOuL5V?=
 =?us-ascii?Q?GHkB6/Ra5oVBEe0fCiOWeDjFKHjqeObln9hehu4CHdp+h2ThV6PnSplPT/Uj?=
 =?us-ascii?Q?g3JpLrtN2Ft0oiBSIE7yCGAbvgwLp27K+gH4ncRfvwPph5m9n6jRqNx/mmYq?=
 =?us-ascii?Q?L4SYn9bTefMrWaQczaK+YtvzAd0EVFh6A4FqXFP4Wv2wB2ts4IhsXW44qqxj?=
 =?us-ascii?Q?x++mbDCQD4G/8H3+/d7aKsJF5MuRdqYspWAANqU0d/FZFJgnpdg6QtQ5mqMW?=
 =?us-ascii?Q?bKEGhaZ0rkm5dQbT4rtGi6V9DwqB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 12:04:26.2962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4030e1-33c1-492b-92fb-08dce7915b1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

On Mon, Oct 07, 2024 at 01:37:26PM -0700, Bart Van Assche wrote:
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
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 79 +++++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 12 deletions(-)
> 
> Changes compared to v1:
>  - Instead of using an ida to make slab names unique, maintain an xarray
>    with the slab size as index and the slab pointer and a reference count as
>    contents.

<...>

> +	if (IS_ERR(xa_store(&srpt_memory_caches, object_size, e, GFP_KERNEL)))

xarray API needs to be checked with xa_is_err() instead of IS_ERR().

Thanks

