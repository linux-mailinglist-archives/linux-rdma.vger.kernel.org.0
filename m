Return-Path: <linux-rdma+bounces-8234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE0A4B16B
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215667A2FED
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22AA1E22FA;
	Sun,  2 Mar 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9QLsy6U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B81D7E35;
	Sun,  2 Mar 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917536; cv=fail; b=IaQM9y2GhFXIAmz6ZuAW+D4C62SOQoYngS7vSzeISHmmcODIr94sTmeIaT8zmPbjcWEmYRJfC7gvNxS8JbNXBn75PAoYW3t+0H6srw/97MvqLyJHuG7iCRziRx0x7Cx5USq5rUPMObg52k7RaUIsNTCRdkPr6+ExlieQW0l2u2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917536; c=relaxed/simple;
	bh=ORjDJAzBBv0UOwYHP2gMf4g7G1NKf5DkRtwgM84RrgY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWWuSf+DAH6JW3jEJkurvcltrRUL+fT+XiQMrbkx7Q4jjoQbZBuiDm9X/lMTIDjEhm02kG6QUmfgxSKLc9EFCNX9n7OYNITxom8+wex2jpP/2lsqyGDvPpvj7Od4YjzTWMe3Eqa1cTAPsROr3SSVSR81MRrluOgwN+Ui+K2bkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9QLsy6U; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEvHVO/yu8vA88Eo547PLhs7Rx+yuNm5we0XFb0NMqhQh+AvugUecGOYhdR7CodSuqnaCusslg9TY/TtI46hx71dFf0bhsQKB2sG4bjqjLqaZuP4BMUROQLjHMFGuqoH7InAst9HGmuXSJcHA2qWeQgrcaxQmZ5FsfYWgxvyXgPcTJLs3b5QAk/HXVhKEHHE6IaZWdijTVhinkO4aCRqGt0HhnGyKW22tOiwfKpePsh0VBjB+FUTVthYdSRIsx126vR++bVXU0YU+GmRO7qijpO1Ftkpr8PezhVOd/4KMgOJhi50wMMvkR9nTiGmB/1eidFQQboETrtZCgGH1chLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUA+pykReXys/3OVUgTsWqz4sHr9l0NMJS5nWo1ekM0=;
 b=cYY4wBgVTsYOjiaLnyjYBwjNAh+ZM+emXhWVX+Lbn/M2RihXdO881E2hNrz5ztRybjC17Sq69CGe0Sl5h3eG4lZ1JJmjp1cHXBychYL+Mop0sNUum9NPKDTXzqroEK29jjV6OQ0wZMUuwErPvz6I7N/5nAbmVZwFy0ZJQnk3bkhLVSFy47jXtoLQDKu3xvPoOqa4G/5SQ8eJ4vjqDG8olRBbu+HgFlncc9fz+vYMTlkLzTrmtntmHByrE0y1Q7+4lBf/Ao/9UjazO8zg6SWySHe7Azf6pGknc/VanHAsUyDFnmmFimQXDrhTGAcjU3/Nwx+mrSdE1AhMYT/myFFGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=bestguesspass action=none header.from=nvidia.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUA+pykReXys/3OVUgTsWqz4sHr9l0NMJS5nWo1ekM0=;
 b=Y9QLsy6UPu8plnbzKtV7nGG2hK7yrLJMRMn6MHygLZZlT0Amx2rK62ygRT1K3cy5XiwX/y1shtNjDi15kp9MzW7CvMQDBP82YG7PBZ/Jm11KdJKi3Mf6GLwBX47Q+V1DSb1uMNFN3mkXHYxzXIwBQ3kZxmnDn/gX7+UJu7UUG0oC3FZSTuTcaGnu1cTiLtMpbaErxNemcJRkRY5AssoUusGDFqZDvUvhnmDNB46RhQiOp7Hsk0J45YEpliHYSw91xS1wEqgihDhcDu4wIiaxTaVrzGvgnfFq2QloRFSJk4MVxYPioDtTv6mv6GTliGsl+waZrdeBUJeykg9NCdHkXQ==
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 12:12:10 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::65) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.12 via Frontend Transport; Sun,
 2 Mar 2025 12:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Sun, 2 Mar 2025 12:12:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Mar 2025
 04:11:49 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 2 Mar
 2025 04:11:48 -0800
Date: Sun, 2 Mar 2025 14:11:44 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Nelson,
 Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Message-ID: <20250302121144.GB1539246@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <7-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c13cec6-b0aa-4b9a-0e07-08dd598373f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KgIgu4zCloGeTsdvdxWduwtUfxkw9BLok313k0KuGyK7dnbHrxOySN28zDko?=
 =?us-ascii?Q?R0bnAJeKYxiZMXORuVbLUgme0yGYhTg8/YbUr6ytsaprcyjFRTTeepTk21bC?=
 =?us-ascii?Q?gO4TkeU+FMUI2JoyD4vDSXzf2akkjioinw0FDikQuoBujARZZr6AyQbZbcUt?=
 =?us-ascii?Q?khSrw3OOczEIAZLbCkRO1khdGPcMbsBZcyVitfKznKEbzAdgm28ZWed2/aE1?=
 =?us-ascii?Q?00ewAf6Y06yHV336Q4r9E7nWxuZZ7bD/C7ulxfgMZoCW8+7Rtic4YmtQPV3G?=
 =?us-ascii?Q?db3GOfvwFBdimnh+YDuPC+COuE0YwpI/NV/6G05MeCkor2JOi7jU6Hat3TEH?=
 =?us-ascii?Q?aTt7CKhOHzyfMv5tMrIFGM2otagwFoWNvrxbXBnr/g2a+3LhunVyr5XgJolL?=
 =?us-ascii?Q?sBDGbhvHIgyna2qIQXWpGAKcPX8/pG5nfl53KbdzC6TM1H9ElQGvydwPMiS/?=
 =?us-ascii?Q?GT9hKnSLtNlRLqElT1u1IZxrjeXxViMTPgfaO5NdCev2ERnRMBGYU/vf1VO5?=
 =?us-ascii?Q?pYPYwCINZ56RtnO8QEmYzr1Mlf8dveqTsMEVlZae2ePySKXBy918ipfRP/5f?=
 =?us-ascii?Q?9LhDy6aZYNwUVzvMu/QkFDi+2Mx3T5Kj6mShVB6ulUrUuUadVeshdTEkIra/?=
 =?us-ascii?Q?lB7WtJW43w5AmQ4oWZBQJND09ztcnLRFRhlWKqT4xHlASjqVHY7xVo9RI4Pf?=
 =?us-ascii?Q?mU+NuZeEKnHkjrudp6g2k42kankim+eDdqWgl33npvkAqyLdbXRDeEpjCAdD?=
 =?us-ascii?Q?rtMWy4yZ4lKoc6E9HPVRAsuw4fyMKkSAKLZTCfwBQsYMQwYbEAuHkD4AAuci?=
 =?us-ascii?Q?Fa22uVJmwEZ5lplXtaLNg0jFpdtu1yO0Fi8lI6SOXKsIo4OsRem7uWW/TOcu?=
 =?us-ascii?Q?B8T3r7jHkNukdTOS574C4qZgsQjpel3S3YNch/Q+81bbKkIBKwI7r3lycmYG?=
 =?us-ascii?Q?+jbUbc43ZvI7V7f/9e9QJ06IY83KUn0vSFahu19i4CTvWA3+tlkfQMPpNDCQ?=
 =?us-ascii?Q?lOU3QjuhO99EDDx95Xmz/NycwDe5y0T1XGD8gNZw6Id3OgZfmbx9irAI0UUp?=
 =?us-ascii?Q?HPVDtpuW+R7i1VpJmP+8xeJoal23gqa7jcd42S+GELOT+rp3MVpg+Kt8+ei4?=
 =?us-ascii?Q?HXqQp++3sIkkop1hcnrPmz5c+0Nc6HNF4MxWt51D8GinAJNzB6ZBQkfrvuOI?=
 =?us-ascii?Q?pq+MraPlM8Fx0tdSeaRZzLGQDIVBDZdHMnXEY05cjLaL6eSW9ylFDdRIOHou?=
 =?us-ascii?Q?mjVd+7WPjOcStQ2cDWyBe/TXH7q/vI0MtJDvg9e5phaFZ0GmIYXJZt4lrU7w?=
 =?us-ascii?Q?IwEHQbiMEUX0zHUxiXy4ffVr6L29QNKErwlyRgM+HIUKdY5rAllQoVmMRf+k?=
 =?us-ascii?Q?LZeyHapWyirRoAUhOF+vv+j8cvTnA8cEi3CCOHqvbuCywvDXWmkWqFfdEj/0?=
 =?us-ascii?Q?Gn+l40eR5Xgy7kuzPPmb2jyLBYisKfF2u39zzXjJSH8Fu4CsPp+UdpP+27et?=
 =?us-ascii?Q?NIilJZoQcsQ/DEU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 12:12:07.5762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c13cec6-b0aa-4b9a-0e07-08dd598373f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

On Thu, Feb 27, 2025 at 08:26:35PM -0400, Jason Gunthorpe wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>

<...>

>  FWCTL SUBSYSTEM
> +M:	Dave Jiang <dave.jiang@intel.com>
>  M:	Jason Gunthorpe <jgg@nvidia.com>
>  M:	Saeed Mahameed <saeedm@nvidia.com>
> +R:	Jonathan Cameron <Jonathan.Cameron@huawei.com>

These are unrelated changes, probably rebase error.

>  S:	Maintained
>  F:	Documentation/userspace-api/fwctl/
>  F:	drivers/fwctl/
>  F:	include/linux/fwctl.h
>  F:	include/uapi/fwctl/
>  
> +FWCTL MLX5 DRIVER
> +M:	Saeed Mahameed <saeedm@nvidia.com>
> +R:	Itay Avraham <itayavr@nvidia.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/fwctl/mlx5/

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

