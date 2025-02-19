Return-Path: <linux-rdma+bounces-7827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00676A3BD2F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB41018982E8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FD1DEFF7;
	Wed, 19 Feb 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KVdxk6+K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E21DEFE7;
	Wed, 19 Feb 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965375; cv=fail; b=nXkSIW+AeK6U32X7uxXdmW/wS4l8m9IXfL45f9rpq8rbTV80SeFnH1Gjvndlh6aDZJc1oe1J75a9IriuPYgbZmVBeZfhcBz/2qobJ7E5usKhHHtWRZlkqw5ZU3cl0YK9468zDX9nAidiKDpcdifYEI6WfpyOcxIMtzeHolseE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965375; c=relaxed/simple;
	bh=GL8oiqSGZq9GUJx+fSwHL0kJcEduoZRhHPm+ddh4WkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6vqzK1wADhgv83a6D4dQxbzqxsMBW/QMTGnuPXkMIoRlvexJn8rOtJY0sVuv0wlrrdcN8W/7dDjFOHAmSZa2YTYk4xbt/IgSsnik5rm5N1PG29inVC6jMGlvYRdRoFUEYIb9KX3nPirvy6XnrjCHJgSimnPkXVqUcOzLZ3JaVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KVdxk6+K; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV4eNpk6ErnbhIYo8aLvjANnbF/Qvd+9MbIaZSYFHt/tE1tV9dg4cyXrD4WVKUX2soKybloSsJsNvJ07aaKAFkFLXShrZg0lG+Z5ZpBYToAhOaESJz86jvK8Qn8+KShpHxnUW7/FIeFpnbsxli+RqXNFRp0x915mZiZTcxyDdFp0sj1N2OFYzukDpvjYs3L0BFEY362+OOEgAx3Iad32P8TtadLZlNwpoXMMMaIm6dEgMdyKAMfLlRH7o/uB1ZZRsldomrFE+2oDZXUE18PyxwyQiXTA2Bp3+6ea10XyeWZjBxHBTdn5yYPe/jt+tH6MW3spL7HUq7PB5mkSA1DYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKr70o6977j77Ku37DKFP7xzjpGBFbZxByTrQi4PKmc=;
 b=hwIulv+EemKO9ErdOrUd0RJtEsKGJ8OAsKxGBlJwKnDl8ZqLqXes3LQNubiQjEZVDnypG7sAqCHs1tUFeJ4LyutcAiNldCXN4yzmCJe1kQRZYOV26kTYJ1X8D9kjrI2o1xqucXMWLe8KiHKiNtjqFxQ3hKS8FZAC6Og0u7rlce4W1VvEBx39igucxNgvAXNGXr1Sz0+Sx57i2FT2q8SBMa0P98nvxk4sTYGz+AlJWb0BujBN2flySnJl2/PmPag6K/o+ZmDjWfUVveD5z6hTr+eHr1Iw/UbPYiOG6cvs64T6D5l4ll1y0tQdI37yMN1ZZBTNAo8nLTnCGTDz2CSt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKr70o6977j77Ku37DKFP7xzjpGBFbZxByTrQi4PKmc=;
 b=KVdxk6+Kou0EGShJR5yfNhIzkVnsLxniCCX0wzAdu9uYAKrl6vgxtxplYJ50zLJ1E8yrTKgYkg+gb5f4g/OB7ZRa+sK0CBLgTTkittDI/koLDFU7mNtpnnYDNhvodStOdjFoyo/Fw1MjZS+6IbiBJyEDQjKqpGditORmtITf+vT0f93ygvh9Bg2rW8EIvFosALOdlD/tWJ9g4ViawmWYb67WYKU+yIT5H9YqCMI0UBqrhSyxgb/w8HPsDj9fqfTALS7vDFKac5Y5VJcQsNdXyHZPSUwFSavt2Yqkpwxa9fkAzhgO2Phb7LqUIQSk1RTAznJtuhwkfuso5E8E43chZA==
Received: from CYZPR05CA0013.namprd05.prod.outlook.com (2603:10b6:930:89::11)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 11:42:49 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::96) by CYZPR05CA0013.outlook.office365.com
 (2603:10b6:930:89::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 11:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:42:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 03:42:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 03:42:34 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 03:42:31 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, "Dragos Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5: Bridge, correct config option description
Date: Wed, 19 Feb 2025 13:41:08 +0200
Message-ID: <20250219114112.403808-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250219114112.403808-1-tariqt@nvidia.com>
References: <20250219114112.403808-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5304c6-dfd3-4972-cb2d-08dd50da889a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rj5sFdut3qfNiNDknqSME1hDG/ZKgCRHeZWlE1JCyuwTVE+8EAx6gpRr8dQ8?=
 =?us-ascii?Q?De4wsk+lXEX+qhwqNUevZeQfd8LJlOz+9nWJAaczYGn66SgZA6Ee6glBPjp6?=
 =?us-ascii?Q?hD1QDWBLX0jmAvd8ETJ3+4c0VrPrFRRrsYoboNjBV/NMBK16MqfnM3Cxzv5r?=
 =?us-ascii?Q?vPjzg6nzEukwoHWNlvWcO7eesnFXBFpVy06VOg/tQpk1tdqPNIdetp84tYoi?=
 =?us-ascii?Q?IPQyoShVLEVlYiZuwpNSPY2YUzTu5y/vaoTDyzA1WH2AKbljW/M4B9lS9uwq?=
 =?us-ascii?Q?uhdwJDXYume/Cy5RPjJrWdPbrCOA1mNZrxSzM4H7CYS9VmrSlPrzTLV1vUOS?=
 =?us-ascii?Q?X7ASzfTR9Mo2fVB1MpHGo86PFz1SLqDnwCzNNiEO8EiiSHh9NmaXItazPVuM?=
 =?us-ascii?Q?/xPAvR91evnhZublrQKocYdEEED1DG3RIOQsm4L6yrqq9fvwQWOXQxno+5mp?=
 =?us-ascii?Q?zl48Eemgu5ddVKIpiO7gIR/x9bttdvh1JMyZnUWu7FHbJxkNgFsBg4ttyqf0?=
 =?us-ascii?Q?HnDWCJR3wHnWBqRso6Pnt3Uhstpa2+Ikcw9ZM6EkPrSwKIfukh/p7TIN0nsJ?=
 =?us-ascii?Q?nn2fdmsvuvgEixHshaRV+VcJzeP69mUbCM8U7C1PTBZbHec56zKpE2ezyLRd?=
 =?us-ascii?Q?KJcz4hKRfB48Vk9MfPyLQFuGBy68/vkDo93qN8YE+XQKse56zIHeyvz/p20d?=
 =?us-ascii?Q?v0nFJdADihAjVTsuGy4rRiXCXJrZ2nL5BuJvs8N00m7kdyUIjyA1UuIBJGi4?=
 =?us-ascii?Q?nEsroB4+QaOU6dfJYoBY8qGi0ym3/qdqCuKVZJWzt4BOfTv1Vv0qoiU0Zw1h?=
 =?us-ascii?Q?DnMyCLNB5V33TnLWrukawJeRlASoH+ks8KDJrL+vAVVgM4GnLulCmko1jK2w?=
 =?us-ascii?Q?pp+0oEAGBntbSPcK4Ux11UJizkcIbtYdvLR4qIDn+amaRv5rkIf65t+mLZca?=
 =?us-ascii?Q?2ajMaFG7jjA1smDVOybs2DGM7C+a1EJZPC/o9poBnd54453Du9ZAzJh63t8G?=
 =?us-ascii?Q?AKIfbAgvMff2fFOeB7iDUM7dNygw64ovFVDpmANf2lco2SdQ9w+6dHCZlD7j?=
 =?us-ascii?Q?L833kMSTkEUMuLye7sZF5lxgQT5JFKnNmXYmXMx7ZfYOfqHbiSad69RJBOTb?=
 =?us-ascii?Q?mli//6f+einmXgoJf277dOVBwAH+qHQtH6a4k2+xHB56sNapZzxtRbaX+2WA?=
 =?us-ascii?Q?qZn265elLHSgh4TCn3WmqpVA904LfwOGNEzdOjJa327LHPvxAtPCOpCdxUJq?=
 =?us-ascii?Q?w3yfUSJmPfNixP6s9G9BWs7bvTIC8BnVruzKzHvcv/iLBvBBlrPkBCjRYs5Q?=
 =?us-ascii?Q?Oa+notEwSim+xth2ib5CCmZpn7dUG7Zt1rkc/nE9wrTu+h4omLHAf4WO3az9?=
 =?us-ascii?Q?xYf1Wq6hpE5MUgIApAGCyG2K9XFOZ8GBkcfXvi5RF2hpZTyKaRwsPR+oz6qh?=
 =?us-ascii?Q?mpeDzgNh3TreLquNVJMuJQH46036U2RMY+snEXsBgKE/bNxY5Ynl0FT1tHVj?=
 =?us-ascii?Q?nt1ZmOajTKRpANo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:42:48.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5304c6-dfd3-4972-cb2d-08dd50da889a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097

From: Cosmin Ratiu <cratiu@nvidia.com>

The implication of the previous help text was that without this option
enabled, representor devices couldn't be added to a bridge device, while
in fact that was possible, just that rules didn't get offloaded to hw.

This commit clarifies the help text.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index ea6070180c96..bf4015a12b41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -80,8 +80,8 @@ config MLX5_BRIDGE
 	default y
 	help
 	  mlx5 ConnectX offloads support for Ethernet Bridging (BRIDGE).
-	  Enable adding representors of mlx5 uplink and VF ports to Bridge and
-	  offloading rules for traffic between such ports. Supports VLANs (trunk and
+	  Enable offloading FDB rules from a bridge device containing
+	  representors of mlx5 uplink and VF ports. Supports VLANs (trunk and
 	  access modes).
 
 config MLX5_CLS_ACT
-- 
2.45.0


