Return-Path: <linux-rdma+bounces-13547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CCB8F3B3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3683189EDD5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 07:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E5A2F3612;
	Mon, 22 Sep 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nuGPnRLA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCC2F0C6E;
	Mon, 22 Sep 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525128; cv=fail; b=MCu2msyKitMpiQt8+iE7Do41T/ulePMqgvhHE4PjH1fcuKlvLT4EvZCV0gu84pusZxfwAArCbVUGW1Tp990qGt7hnllPREpht6+Y1wKVL+94F7IBiq44LZBq05U5crO2ehngGhlKs5MBZYbC5nvI7ew8/BUfiQW/PbiqRLL07PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525128; c=relaxed/simple;
	bh=vg7AWpXh/eEViVLYynWAlUH0+9AxrNsVSk0Cs2TlBiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZzjVrLoUD2Hs2il4zcRLr/Ke95v3xohjpkf/6bvnqlUg0Q9nrQ8AG/envLhaTDu5nQvN4l7AMjqphPvwGw1wSGOtxYQWI9+ppbipyfj0kpz6Z0t+JjQxTPdniP1WRHXFN7q6s7wE0DEGD7A1jXJqB/tuu21vgEolX280qbCSbzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nuGPnRLA; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP6nV2JSPu135g9crtXqArzwmbYqXtXLY/U3eYo9OLo5rDAMZNbA8Pl1vkMxPzPK3RaKiCWe4U24xyMMn6uQUWNUx+R4GiZM3UVFdQdI1OVuZWdJH1HuiHVMmsrQLSIleLicDDD3XIR8WnDhaAMbhBAIs+9p6qfYfO7Dx/Mi6EXLRe4nWXEQ6/53bAngNl00TtvGQABdHcJA9IoY6dpD0WiLJxIbmqNlzcGknJmjbZkfjTIXhf+DFRMIHAkouZe49VXHjR4ajCgq+jZBgZR0IpCV0xGyXO6kbtwkMf8JcrOd8WohqDsLeO1cnuERpFVes7caRVi30wk46MI1AlO9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsaNzaZWH2PmATqHXl4/22UDiuxOVLiGuKRQzugdgzE=;
 b=TMCV13q3gxuSBZC0D3Q3RCFDFhj3qYWyYQAVdikq1sFmYSuaKElWl5//47FtzewB2UPyCQF1RBgYRXjsp08EuCSuUTGqRl+iqjgEuI+BypRO9kvvDv/bXo+csJnuE0vyWV7DlPFAhRHRCgd6J4s00R46w1ECOwIpRFIfUDXsS81mWPtpta2q6RHJJ5YUnbPt0CzoJ+lMSoJqUjbGv1Jykolkzw2QB0J2JvVv+C/DdevRWTKZSaHAYBvhsfqxmdj+3Ffg+wCzX7FAioLdULdYUxQ7hvbYgvYMwrKTQR3lasz7qvm52qRUeYss9G7svEy1BWQTtf3JV7GWuRIqsvivzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsaNzaZWH2PmATqHXl4/22UDiuxOVLiGuKRQzugdgzE=;
 b=nuGPnRLANkYaefCm46wiut8rE/DlyYnPvuiaDznL1YiLXJ09DTP8ehNwD7mZRqCBJ/90XvScBlePzeSRtPBz7D9JyygVg4xhPQzfDzF0ah7XrtqUDSIX0ilBn1uUy27hvdiR2lNlug20Je8bE/BUJ24BVzQQTDjxNj9j3cAS8+UTpZXXLl87x5VSniNAlGWfTtGCFVTPa38uPb/h/T7QGeVHZMdJnglT7xjJIDl6iAj1Z5Jqa2IQGt/rL6cWpQi3018HBRgzsqj7NohIKSEqER37DjlXvIB+MUt4oKcve8SUJpTcVckcgdH7wS/dOUn2J3gAa5pJ+XbUA9sUwwIMrA==
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 07:12:02 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::f6) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 07:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 07:12:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:11:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:11:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 22
 Sep 2025 00:11:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 0/3] mlx5 misc fixes 2025-09-22
Date: Mon, 22 Sep 2025 10:11:31 +0300
Message-ID: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f0e5e5-1db0-49f1-17cd-08ddf9a753b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxWpmy4evUdWvIduGdsSerDKBMW11vL+ksINYx4+1W4kI3vfFNn3W041Wv80?=
 =?us-ascii?Q?0rSTdCKqFoKBPkn9XJqMLjvHRZChu4YJ3wgQwy/pCCMIa/AWToLILfRWih4s?=
 =?us-ascii?Q?HS73+r11izvdcVXtD38UTfG2VD4ZOjczd4zy/dcxd7kTzmTqyyQm5QtMFQXs?=
 =?us-ascii?Q?7QjtrEMVHO4CXHO0zbA14TyiHb381650YJAhjMecep3gdLUGg9o3VIvqhguw?=
 =?us-ascii?Q?YzgA9AHO3s+nK5mIuDWr+P5GO6lBG1p9q3/feRhPqG9clhWaOhCL9GpchxPc?=
 =?us-ascii?Q?H5XuCZ3F8Wi9bDw0sGkfDhAH84oQ6W7JeAJSeHA0lXlO39O429yVV0EHnxjG?=
 =?us-ascii?Q?Y2d/8SQVOxTZUW1Q3eokX/qtU3BsYzLoA6tgyzTMROK/EJSzawoXGO9XlwXk?=
 =?us-ascii?Q?h0C/hwBVSzNNm4sennGlBz4bB84qUSYMzSAq+cMzKvVAHHu4dxnvLiYCu9gJ?=
 =?us-ascii?Q?ec58wPeNSlO2yMnM/C6uLd/HVVfLDKamkEgQJeWr77YKgSJdcQIiPoI41gP/?=
 =?us-ascii?Q?2XAtxvgkldOU5yk6G62iCtzj/hxA5s8KfgJkvvkxE1e7NcW86ELewsbZgIz7?=
 =?us-ascii?Q?msEB+ACP/wDfivIpqEN8aHXyugwdAfvi8Hr3mPavrmTCp/baRkdjrHOS2B6b?=
 =?us-ascii?Q?3svJRUgfRVsW3fPDInj7UN3uQlI7O0hNRta8j53f09cy590IrRqB8AFTgFil?=
 =?us-ascii?Q?qpW47BT7kdLiAYi9qtRwZ2/NDrM3Lu9VJ/WBPKN4P5BExQH7zYyzjH5VBpJH?=
 =?us-ascii?Q?v03DZlkwDbbal07VOs+ayZ9NryYCS3zU4a+ob4dyU4FjMI6R7pElrTEXzB4l?=
 =?us-ascii?Q?QeDcwGoxa1Id4GwM7AzzjdUiJeaMUv87h5+3Y8KO8IdJaeQN5y+fjcu1ogE5?=
 =?us-ascii?Q?cp1N/uGcbDrZI7ckkpLvNueMyfVyyVM/cLGJvrZifVF5grdlZeWaL812BUYe?=
 =?us-ascii?Q?DafxADE8jfjrej6bIjQRKVX8K+pY74XzsT61dHbjBW6v4XgdiELUZsRF45w1?=
 =?us-ascii?Q?2huk5ycSy5p/MPcJniOBZEaVRDCqobFK87RPw8VU8SKHx1V00VLC9jh/FErT?=
 =?us-ascii?Q?s9ozdbai5yZkMVPxCyAID06nPFeO/zwzFatqX2fj9A8sa7+06hYUOyxDLjrE?=
 =?us-ascii?Q?hJy2hA2hkpIsPL6gp7cQ18KnTQ6BnzrDzcw0gKlywZ1nyt/mhPcj9OaRL/Xn?=
 =?us-ascii?Q?vsv7IxICfktxRBXk5xh7cuf5VFgF8iWWPCUyLHXjwrvVKXcihsY7RLB521rT?=
 =?us-ascii?Q?FPlm3dzPQA6UeG3oI1zB2VT4568PPqqwh2cqUCm3ohS+HwaUtv5gBHEMN1dE?=
 =?us-ascii?Q?DkBVeZUt9Oaqf+BALX7dVIGqx+m1Skmgnes6dBwyF4rPjdMqmLfcMYtXb8cW?=
 =?us-ascii?Q?lpCWjqhB+vtYbH7I2dhUTya5GSgLVLWVIBTgCKN1xUOFh5vTSftAAHxtA+ci?=
 =?us-ascii?Q?xQVShKPjyvP8/Olm9FM56xXjWtOCz1MskKMJJwEUJhODaSKab/12c4gC527X?=
 =?us-ascii?Q?ggEfCHzmWvMwJP1BnuOLpdwgqhLnOmH10hWo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:12:01.3768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f0e5e5-1db0-49f1-17cd-08ddf9a753b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

Hi,

This patchset provides misc bug fixes from the team to the mlx5 Eth
and core drivers.

Thanks,
Tariq.


Carolina Jubran (1):
  net/mlx5e: Fix missing FEC RS stats for RS_544_514_INTERLEAVED_QUAD

Moshe Shemesh (1):
  net/mlx5: fs, fix UAF in flow counter release

Yevgeny Kliteynik (1):
  net/mlx5: HWS, ignore flow level for multi-dest table

 .../ethernet/mellanox/mlx5/core/en_stats.c    |  1 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  1 +
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 25 ++++++++++++++++---
 .../mellanox/mlx5/core/steering/hws/action.c  |  4 +--
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 11 +++-----
 .../mlx5/core/steering/hws/fs_hws_pools.c     |  8 +++++-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  3 +--
 include/linux/mlx5/fs.h                       |  2 ++
 9 files changed, 40 insertions(+), 17 deletions(-)


base-commit: b65678cacc030efd53c38c089fb9b741a2ee34c8
-- 
2.31.1


