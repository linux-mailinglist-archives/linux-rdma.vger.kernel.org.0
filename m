Return-Path: <linux-rdma+bounces-15551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B60D1E9D6
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 13:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3B6302AE3A
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90B393DD5;
	Wed, 14 Jan 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="apGhmQiH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976A346AC2
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391969; cv=fail; b=UKH1HQg7NG2tDdzQSMoyG8NMFGQh/aGPlX9uC82EwVBCs00JTWMUhHeDUIazMGNrvv0R6pU2FQfFrEx9ak8A9wqCI4Bab6FLtEmc62cVkxeD/y3o3vpJA4cRkJ6deXuMujJyU3zQy9zpLX3ttBbvtqjZ+Rv3oO7fgGcbPK4s+Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391969; c=relaxed/simple;
	bh=buVrsk5or+UsTluo1BIuYWEehrxjki+u1oEFx7NuWJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTdpBdurfWCXeWuJT5xRmdJmW9UWM93xMJN29tJUY4P2x5QbYo6UhHM2GbHixm7okUFT9y/s9GxO4whvmPK6CuQrnFhXn0Q1h3lZ3vAJw/QwwRoAZHTI2+UDhEekDh2Q/LgdGqCdyL+eG908u4UTVlKypiaKoNWZO6kCNS94nOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=apGhmQiH; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPVjbHTDhirtTxePgEMf/guXvMzQDac9jU9iataxIejXTSLUxgupvRQNMZVhRBp749tSjYBWW+o2z1nMpEcrFC+yOHJzS51T8ROZAYpV2jllluVtJvwg9b6idF9yhqecGwfbETSUo6rhyvEi6ekPckmOHKpJdfP/TVUc3PbITtvnh9KbslKx2vCxyc+lcOwtc9mAb6FHCOVOVIisEGKFYhdjrr7tZyuBd6BPSQd+Jl+dVXW55N4y8WHjsiFF5vogMHkNX5FwaPj2uT1qftfVNLDZMGVv9nWt1DKZVHu3D56bw5R0EdY22epqaL5OQcOM4ZUU98JXkGddjzStYB4qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/dbIrJvcPeRVieYlW3j6BzAFF8miXw11hYl63wVB/4=;
 b=TQRNp6PkDNDVKNuSZJW8rHHfbGtcns2Gbarr+NL1UqhRrvjxplxErfc0uGiAeIdgPHVJGGdv3UjB1OF5PrZq8YHxwnMMIAazbYZx6onpNR7SLIJOLTqfTnWMdE7eykmOgwpPqSHKhz7NROsPqTUN1YAf8rbkjssZIb84BlGaFYOmMJ9DpOYxYuFuaKFZgKV7lJLweqQJHxG8ISm3DDl9EFUeDaRq/OA1u2n/lFSwNg4dYR3MitJsoYLCu4/GszdRPNbY+QU0CcREd/WOt9xY1TNdZv+Ay7knwuuPr8bnu/rzF7AIkk2bUY7zx3zd635E3yVnxTYZCCoSH8TFXIMInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/dbIrJvcPeRVieYlW3j6BzAFF8miXw11hYl63wVB/4=;
 b=apGhmQiHhCPddVvKMauzEUVa5/rEhi1y0FbC7SCYLtaQoUbQDRQbsWfqqqwlNrBCw/7s4lCTfvjkk8eReItl9tmcxk6BTlceQ1nnfx3SaQV2uu3XVThxQ4i9e8joNJF8JXjmGv/tW2MCpUSZnfF4k4Geeg4Qb/H6Cm59wY1NzQCCFZMOAPZikUV9As/himzlrNq808ON/7u1ff/8vItyQxW/031GkfpV+vmF3mLrRTLSYgaxnB95Ufnlzf+GYyj/5mINrfRKpxIQZgHUFIOBY5Y7W1txBtReysOzId4VzbdRfteDcc9zPme5evqpLGNhbyHaXu6upYNBHHw9eMH2Yw==
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 11:59:21 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::8d) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 11:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 11:59:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 03:59:02 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 03:59:01 -0800
Date: Wed, 14 Jan 2026 13:58:58 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
Message-ID: <20260114115858.GA10680@unreal>
References: <20260114100728.484834-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260114100728.484834-1-siva.kallam@broadcom.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 008251e7-807b-42c2-2390-08de53645ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?koR5pmZ5fZZpPA4Q798mbJUVPH45WYjKfPXcpp2SurRzCHSHCDTP6q3xzxzu?=
 =?us-ascii?Q?ORzu5jYamgAvBKZk2L022aStRxQfy/58MV0nsxfCeaZiyxflv1cdFHo2weOW?=
 =?us-ascii?Q?zCOn1JYTLUI1lKd3XaQkPPqw/jyLciY407/rpnwD4ABes11wiZMCMFpL9aUp?=
 =?us-ascii?Q?HgIXIyYByissf4hiDaM49B3ELzPVeU+9z033kF8sQc2q2+qngaKEY4eS/JtB?=
 =?us-ascii?Q?zgPIzHP/HCP5Slun34kJB+gtOMD3Dz1GoCHpX5X/QxLwAwgCGM38zjWKmYWW?=
 =?us-ascii?Q?cQjuddY/nTrMxWjXxKqRfNYcXy448inhEuYfOVqLzAG/KbTFooM4erY/Zd6Z?=
 =?us-ascii?Q?ZtvHhMwPO7VRTXrB2GSJxHGvvJGoQ81bvL9RSjcXgZs0JoYrA/2K6B4EiZdx?=
 =?us-ascii?Q?Zv5WOyzBEy/Lc599LMv5Dp8BMYUoJyuWTcWWiwyywJtIFikJQvY7nQbjxw44?=
 =?us-ascii?Q?phdy8T+5JO7+yoYJd7JR6lfvBqfhrAtDZgEEoFgX/FwnLW9cpdOyRMPg1hyL?=
 =?us-ascii?Q?IADIhPGMjb7soOyFoZIK45slPxtkyKdEI/2JUfPTHyw15jKg9x0YsonySfEU?=
 =?us-ascii?Q?O7D5OzF5C/1FZNLI30MteFIFzy13aSvCcPK8UOzufJ32FxwWmWkg4mSAqz4M?=
 =?us-ascii?Q?iKDzxW6Zce9a8Y7LbQ1cJVCD6JWTkZ07rUwdCItb70K/s66zo0IvgPz197zv?=
 =?us-ascii?Q?DVkAeB7QgJB9O91LjuUXUWljRleK51/atEWZSOJSBWjkVZoUZadc31XbTY86?=
 =?us-ascii?Q?sK+j0n0LFnGL8I8cmvbHqUxNXwhFTTV3eSnB60rerBdedYwppIpVbBUAQHn6?=
 =?us-ascii?Q?07InUbbvBEwCzgzoTVRdErPnGRkCVOtbhYRFGx3UOCdGCMkrDHNYVQoenik+?=
 =?us-ascii?Q?SEYgh3ZfGI2+vWFeNKbk4vRHv/q4amdulTp3Oxo1fzfi+NcP5d5S4CcX7L7h?=
 =?us-ascii?Q?SVVGGlt+g2mBAEbVrtrx/2oGn5M27Kp0oPLQ0Vv4tBr6IjL4dY02C0QBCgQR?=
 =?us-ascii?Q?JMHd2DT47ekNPJqxI+pCTN+dCtBhR0SPZJ10AhBMV+zTW8iiC53ufQ96CTPH?=
 =?us-ascii?Q?7RMUzm5OfWvyjlVfILfMCzqVbn9bWNxDO+9jDF+a4Qy3wgLc2QvcD6qKJcNX?=
 =?us-ascii?Q?jk4hvHN8oTU8eFIhUJ+b/jVA1WINzLsbmqBA+/IMuBn41RWJa6fACPtZUE6i?=
 =?us-ascii?Q?ajwVAvTF2SBk+o4hvKixAqbKvwdTY4C6MOohNoDeCpAg3Z0JM3niS74jubmp?=
 =?us-ascii?Q?7LwZ73DAqcPtBY+I7m4nBrBt+ssO1ERkthzGThsSbog7ijDI/TsMxPyqlczp?=
 =?us-ascii?Q?vWzf8LmPhrZDOx3kjcvbU4R/uPf/HHt73BRyZgPFhubQBpXIYUirXCvzZ2Cl?=
 =?us-ascii?Q?PgrvzuGMiYm45DBFjDaHWt9EwH4qqfnd2mzFig0Ne3sZVevv60o2zKDXG15U?=
 =?us-ascii?Q?i5tdD5kZwvhuZ9LTM5iZ/DK2RNnSXXpisqGIm1ba8yJC45sTHLY3QVwg3O07?=
 =?us-ascii?Q?eTvj3HeI1vdUlSDK57ZgCoDDIrx870G0rLI7y1PEmWMSMx828dk3vU6Vp8OC?=
 =?us-ascii?Q?eg3GVEZU672G7aK18yiZGxzJTYPaaQL93j8qLVdkxhTDEFuYN6ubC+AxQ2Aw?=
 =?us-ascii?Q?ce7oKYaX9oHDpTsggN09oj8jKg6wFU1BcO05mfjAQDzyT7O7KB8FM7tyw1kj?=
 =?us-ascii?Q?kXG/0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 11:59:21.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008251e7-807b-42c2-2390-08de53645ac6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772

On Wed, Jan 14, 2026 at 10:07:28AM +0000, Siva Reddy Kallam wrote:
> Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.

This should be accompanied with use of such define, where is the call to
ib_register_device() in bng_re?

Thanks

> 
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> ---
>  include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> index 89e6a3f13191..b78bcc8cf3e7 100644
> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -256,6 +256,7 @@ enum rdma_driver_id {
>  	RDMA_DRIVER_ERDMA,
>  	RDMA_DRIVER_MANA,
>  	RDMA_DRIVER_IONIC,
> +	RDMA_DRIVER_BNG_RE,
>  };
>  
>  enum ib_uverbs_gid_type {
> -- 
> 2.25.1
> 
> 

