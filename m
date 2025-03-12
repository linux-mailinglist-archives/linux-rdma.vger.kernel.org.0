Return-Path: <linux-rdma+bounces-8604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AABA5DBF8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FF27A3E04
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665B23F42A;
	Wed, 12 Mar 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lo0iCWjj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C023C8A2;
	Wed, 12 Mar 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780234; cv=fail; b=H8RsmZkksa/kkhJVOo9jio75d/jNMU4732xUYoL8nOb8k0SKkyzA6OgLgPzAbHRpmQ6L0B+jAset+vf5nT/i4f/4dL1zONCMlFRYRz7zBfyEASbpq/mTGmuTOmpRy9gIwKuIsUMuRRla/HX7DrIxybufKllNxOzTr3AOxzEAPuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780234; c=relaxed/simple;
	bh=Ko4Wwa0BMSnw+FmANRrPXb1t2KKdYVbbes5Hc1bIbMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LltQpGKYxMOIZHyVs6LrAsjpKexyhYWN3rGE0jWduMmhSntnRxPlJu0Ua2m1XfZ6JW5Tq8P3qSWTEakVWLuvsf7TR9yQpSUIdct4/IzuteJQip2Ejr/LBao6/6kh1PUd7LCgv/7EC0/qW5ArwXixKkNca3jZcY4VDcvZqZtAoCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lo0iCWjj; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxD4mTySMtCBTfZvg8OVxB1GPRSN/bkr1JEs/W/9ahxEYO2v1hKE8EAtdjw/CvX5iLlA/z9P5MsFOgwc7jhR5hs3ym5MZugXywST6zP8ZxPSRYJxWLvGFPzW4/FqpFVE1yY7HBIa2l1jwJpTqTbMNJoJeXpdkhkbTiGiQJtKKpKWBwBgzsTIZ8f1flfxYMgOiCx53M0356r8GxzPRuMLNKf4e4fl6hJpuK3kDVJa1vYVW2r2xwaq0z6DS9AgXJE9knwKW/Kpa3hUltIGbfA8gNaRD5v+8kSn9X9/UcUIu+wLURizNVYHWsGKum5wnt/79S393CAZnsH/hN/16CQ+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fey1L2tE0M3n1UJEhWwZY/3hoCnXj/CEOvfPinEhFXQ=;
 b=uEQueJeaz3DxOJPL/vAr5u2c0rmY7Zei1krdUBZ30W1hrAo06x+U5FiJSDf/At8ZQTY2Be7OeZN9zd2835vTvpYxwNF0660NKB26Nlpjw6f6X6brBFowFdUa38C2OEeuklUQC816oqGIfvqmnWyNCaO1GNfngu5zRecYwaDfzmE2Krn/miVCtwN0MCtv6IDprBQWxWOYWdoV9LHyDjoQZbbsvrhH5Ye8u3+TbEPYPOsxrrQPM7cOozf5Nc+0I3XsUHKf0U9XmNN8pCszr5JanddrKsQ7nma/bPd/RsxE0R3cQCDz7EmSClrVNJjaR3XoRZ6jEhye9gCMOdtwBwLvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fey1L2tE0M3n1UJEhWwZY/3hoCnXj/CEOvfPinEhFXQ=;
 b=Lo0iCWjjzTpvZIf+CUgZzqkMhgxGKNXoRzBQyJK69+ozh8gkXv6pgeXZuXxJOD12a5gVwRRFT4QlGRKrBmzKszkE/4OGrbSfYTsqYy2hM3L8aAmIlKFjLX3rbsbn9Iv2csDcPxQRK3Wj2mR/I28AFIvUdd/J1CWeM82YjNywIMdJbYGRSc1RLzRy2a3zoRlBlYm7v7gfvNVVuvWf4yrbp0rWrBp6m+XzVJMCMKXMnMHLAL2+Cfq1GrdRB8EvNwHhlFtah4csu5FFS2JQpb0LAmq/BuGzWsPR2oE84hgKfeRDB2g8kHhC0U0KlAv27UsmlcQrTm2zBLTBm5JDNGPZlQ==
Received: from SN6PR16CA0066.namprd16.prod.outlook.com (2603:10b6:805:ca::43)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:50:26 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::e3) by SN6PR16CA0066.outlook.office365.com
 (2603:10b6:805:ca::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Wed,
 12 Mar 2025 11:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 11:50:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 04:50:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 04:50:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 12
 Mar 2025 04:50:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/3] net/mlx5: HW Steering cleanups
Date: Wed, 12 Mar 2025 13:49:51 +0200
Message-ID: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 851c8eda-3bb6-49c9-ff1e-08dd615c1430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tDDL5jzMdF6A/hRoK5/Uzn9zj8RgNwrlQlao5eMjc3PMjBIVK5p68VNbWI3L?=
 =?us-ascii?Q?TcKuFuW4sCRuG/NA+1jwJyrKBRYqvj9rWLmKm2zOa6283qkA4MEbXRVwuS59?=
 =?us-ascii?Q?BKZ9xnqv83cymZrS58NMTOGCLlPbON0GpjLNnuLPUbCdNMM8hvVOarHaKUrr?=
 =?us-ascii?Q?jHBvcGSpXq3TJqGWQ6AK0isH1r5DGSznfaznxnUIM+E5B74bT+9jhKA+NERT?=
 =?us-ascii?Q?imMFTBjtcoD8j+6sFGGDrXEKrFSU/om7ulsrtLZs35eJxmENZTAMIveJfmzI?=
 =?us-ascii?Q?B3x7H2b87o22hUyk7kI7xQVeChAjMMuh8alwmONXoCoE2gKk3bBv8+PqxXZu?=
 =?us-ascii?Q?gXp9Z8eZW3VZGlEPCTQsNlxsSWlY9Ng1oNqt79N2kQzGmkQAqShEATCWZ52M?=
 =?us-ascii?Q?tYcD9lM+2vr2jXhLDKyU/8zyRdJBD7Edk9QJFWirMDpe2HNXrJogYSg3QVeF?=
 =?us-ascii?Q?qZJZoHzY6+X8sOZ3w1889Gf79aBpAkzaq9ohIo/R6PwJCCQyd4FLZhmGVWv7?=
 =?us-ascii?Q?QU3jXu9puqnDg1oVkW6UpT5IVkYdqIAFmKJLJ5ZHE1z53w1IvDaixeQzbBa1?=
 =?us-ascii?Q?38cOHwkcWHmzNvlDkS0zttD3cDKdkK0EzVNt2Z8oQf67SQ8z6p4No6onja6h?=
 =?us-ascii?Q?WNfVr72xIf3YPZSiauhTnp4ruja+4NDCsSJ+nO1DS5fFDtAfLPceuiDMLYPM?=
 =?us-ascii?Q?SOobGG+NBi6sXkkV4Vjwm0Tg5OR61rOCF6B17MVnR0TayaRC2peHc/TrE701?=
 =?us-ascii?Q?b6gxhljIPydH/fma0oIckgMGtft66KpFYwa9fHCo93QjfsaLrLlDQprDBCZS?=
 =?us-ascii?Q?0aoSrVH9va8qBQ/stsviNbGFfC6hSJOFIi0eW49ZrfV/2Q6xm+8eZd3lfy8n?=
 =?us-ascii?Q?e4bXRTFePbAfyp4K5sOLocNO+j8meukK5LbKImQUimgJcAqRBdsC8zJucIn2?=
 =?us-ascii?Q?yGzlFip3mKv2N81vHZxqr0WPUFVt5CH7OlkJi6qbBVML5zkRL0PL9ne8w3EE?=
 =?us-ascii?Q?eE0i0LHDvZ7nsOX6ZLtZM/L7hei9EN4urlkeSqyitPXckfzVAsYpUJsUcnet?=
 =?us-ascii?Q?aHHu1uHa+LS7kSSnd3I2hvxxur8l6KRGxvazIkTQKTUe6k5MT22SIc+mQ6ip?=
 =?us-ascii?Q?qvWSGArw4uWKVVoPwUE0bGFOM6Us3KRt9pKVYmoS/GJiavYZZiybMz+Ga7JW?=
 =?us-ascii?Q?QCmhsIe/UKOSc1Z0iNKLFXyBg6LFQ2iNFcCkblmldG+kM9dE+/J1pZgsVnMD?=
 =?us-ascii?Q?lzavdMofNWYJf4m1vKQHuBvJLvMkuBKyBnThXZUUZT7wAo7kt0GkLQ76iCWl?=
 =?us-ascii?Q?o5qtvNs7N0/VV6v0s0A7lzolJVL49DDH8WpckW1wOrEzSuCSvxMs6wvEWdvw?=
 =?us-ascii?Q?tAQ/Idqb0fIye1rTSRYMWNrZaH/ZkVvq8jgmgi7E29oZQWEBtQKKjA6pM2yd?=
 =?us-ascii?Q?YFpVVuI9y9pFbpvNFxDHfdb4Xc5cjI6xd5ZT3ddWh2FBpAJ7kP34hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:50:25.8713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c8eda-3bb6-49c9-ff1e-08dd615c1430
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

This short series by Yevgeny contains several small HW Steering cleanups:

- Patch 1: removing unused FW commands
- Patch 2: using list_move() instead of list_del/add
- Patch 3: printing the unsupported combination of match fields

Regards,
Tariq

Yevgeny Kliteynik (3):
  net/mlx5: HWS, remove unused code for alias flow tables
  net/mlx5: HWS, use list_move() instead of del/add
  net/mlx5: HWS, log the unsupported mask in definer

 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c  | 6 ------
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h  | 3 ---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/definer.c  | 6 +++---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c  | 3 +--
 4 files changed, 4 insertions(+), 14 deletions(-)


base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
-- 
2.31.1


