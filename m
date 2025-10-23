Return-Path: <linux-rdma+bounces-14008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50347C00340
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA41A648A9
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66A305E14;
	Thu, 23 Oct 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCaBcDSw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C90302179;
	Thu, 23 Oct 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211083; cv=fail; b=dmfqzmDIMglMpsYiV4+HPLnKxE6lsbWzRItifPM+dxX14R0zshah94nLAIvJ5TMhesM9QKDbO0wBvYURVBS/M9Jx14pHi8PIWQ8bkdKASCkoI1zx9Ma2z5vlnTpkPGKgtQPEqZ2pOU7tYYv4vxLvhMpdEX8Bnvoj/RnR8ATPyI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211083; c=relaxed/simple;
	bh=T4tpnlYY219/UpWtogd4PZtVXRCLq0NYXJQM4EM9yBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT0gufdnqQOt9+ipfDMYy3hOT37Dr6s8dnAy1abyByM7vMizsRTFFXseU52kOoMmkZ/6wti0CMs8yWMQu9hOZo8CAXGuiYARJrL/+Y82bFZhuR4noYKnhMtVEkDi14hjO2dSbyGKex+JRMjchzl5iFPraMT5oAuaOxCWXpeuMUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCaBcDSw; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8BEN62fB6eply7RMLz3ctcrz+IMUl7E3qQP0n7RkCInIAZtZTEfxwso9EjGXeQaQ7hrDH0HiWB9BXuU8ATVEsikRufeI7hGKsZct1PU9/QUv+FQrED62ZFY8iF773MC8QfrPh/r+qdDg9Md6w95xCsVr1DAnEWfebhHnpa4MZC1R+XhtCaiOabyfGXvmsCMWIYQTakvBJ0LXAAHuI+4iXOMe1MaNw0QKFC3Q05J15y1q8CHX6HP3HdRLDuOEP53oK+ZPTX4lyBCwL4DKo7/IpjDIrHsApEssjXwETcWUosb5mQTaRI4emsOMFo7tCL+pOUwxCAkaweDdQfZi5/FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KV+zY+JTmSR40lqkym1c3A0ZY8GSjWA9tiAbyNOquY=;
 b=C3zWObCONez4synA8Vt+UmnVXAwfL1J5uP6A6v6rt3lzl0gviFMV0jx2QiY1HAeDHj+yyezmuBoitCtEcbcIhWwEGzJE5Ff21cJiD7TwT6HwbzA4TQmhEoc99lXpgdxxSUt8YglvgqEI8cIgJE2ne33tNejrTewyCMcln82jonV7UYTmL78IYsUVaCIOkoJlBKzpD75yDbmhS53qxh2CC+QuFi5Zqo5MTn0xP+VpmLiQfErCVqR3QgZkHUKRqdMX2o7qtmxclsb3cehJERKAqnsyf+Tw+iapPZJ0Qx7BW93m7qGGOHn8Ka7ZsW9Ac0eh+HzQ7HROaTq4J3FyEnG4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KV+zY+JTmSR40lqkym1c3A0ZY8GSjWA9tiAbyNOquY=;
 b=YCaBcDSwvAaED+4UzO61YzKWjUm18+9v77pR/BNBoo/ixSrouA7dC9PYDZf/8dwmVByGn159bSb5LyZGXRVu5MVCptmVld/86n5gH41HH8X2DHumklsfgzQMYGKlPGOFw7NKKO0PSMwZ8eYXlgqlQL+UVf4jyE0kBDpGzSIABnFRTaxG1Z8SaksQU/9e6rDagCNzfwLdaxXCewvCUQ/4Qq5ATujX4VrD+icwr5OTwaBLeZuTd5ad2Vs2QxQdBlhObnRfCwAL1UxXI9y30ViQPaWXME9qgNv3jcXId8tfmhFK8q8/58ac2K/xr4DYIsb8TWiCzWq6ahDDOcfzoG/jkw==
Received: from BL0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:207:3d::17)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:17:51 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::fb) by BL0PR02CA0040.outlook.office365.com
 (2603:10b6:207:3d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 09:17:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 02:17:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 02:17:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 23
 Oct 2025 02:17:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5: Add software system image GUID infrastructure
Date: Thu, 23 Oct 2025 12:16:57 +0300
Message-ID: <1761211020-925651-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 07facaa9-8f29-4a4c-7a86-08de12150a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?40d0jHO28honym7+qVz2QzM5SUdIXLRiHFENCH48vx6et/Y0bfOVJZ+flpnF?=
 =?us-ascii?Q?DJSm9Xa/5oazTn37tMphgrK41d67mamlMRYOnvWV/F7Hq7XEXqQkBVAJjxUE?=
 =?us-ascii?Q?TE8ZT9h8BwhOU8UCH71NhchTQNZI65TzRp0URegIpaydVZV7tdb3SSuc5bYC?=
 =?us-ascii?Q?RsLbkw/rUYNiDoKa2+FA59grjxzLhndgZWtyWJewDpDEzoJ4GbnCuLy6gk91?=
 =?us-ascii?Q?c3Bh8DqAR4lw+WW5McyCAiiV4WI9w/IbQUA4apwNr71pdS2znkf+/fiRN4/3?=
 =?us-ascii?Q?RYrsS0RcaSrkStSyWDH2k/X5uPX5ZXu2+eWKp41TvUzgAWG4Xmkfb1JRia+u?=
 =?us-ascii?Q?CTDq07/OftOACERA8b7Od5ppQVvQug3aRhP7341KdhZoddXoF7QLUUtE7XEg?=
 =?us-ascii?Q?7OJeaJY1YOnRIYlRij2J7Keyl3IvNfWb4in+Kvd2/P+W4y3/aLZ+6VeO4KYS?=
 =?us-ascii?Q?Sry5fokpm2IDuj/mKsi8l/BVIM0VRMmzgMl4TgAhJxk43Ub2hUB/fh4BaqNa?=
 =?us-ascii?Q?3m5nlSUiC4QCBgD0qdoq+89MVb4xW7g1+Ed88hww1yAp3bf4/1Mlc+qgrhUE?=
 =?us-ascii?Q?SgimO6TFvR/NIxdL30l6jZh8vmd7NrjzKg+oXIkzAD+OLOh8gwUpKQ+Z0yb8?=
 =?us-ascii?Q?UCTCQKMw9n2jh2UorDJrpW+D95r3gSdSv3c39T8QXHx5RV7rH8fH81xfzWV0?=
 =?us-ascii?Q?i6qq5TaWKTa1gVOIhnv7xB+RxXz0MUPWDzgCWXTfX3LfBHMBWK2RqZ+JeXbQ?=
 =?us-ascii?Q?B8wM+rUbRFvTVupa5a2dCqru6jLfbavrvVFDvfbBr8YoVSUL7ywkDPa8p6qg?=
 =?us-ascii?Q?4+mQzZj/KcKL58Un2YPO3leTjF+PwOHiZLtaLRxrJN6OOrP4Xu2kHx5YoCpD?=
 =?us-ascii?Q?UW+71c3/BJKk6TMqWPqt3OGHhyXUF5IQcTQ2UHTAULFwvMmv9GKdj01B2dcf?=
 =?us-ascii?Q?JyZWWiDcaFBFElvLz0Ds7oPztfoyL+kASMSZtl8xFRUcPr3LYxn2i0bNvMnc?=
 =?us-ascii?Q?Z+8/G5PoMk84ZNGIL8rGL2oFgT4trs8TiYCqKBM5phaozxPtINuYM8neDExP?=
 =?us-ascii?Q?yUYrC9CKaP4Ms9af+rGQD+jtHPcoWq7P8KTO8Tr6kgvHryyUA6sSYMKrMeyL?=
 =?us-ascii?Q?FryyPJmpEuthyFpEbLiRIE3uLABlpdAKkYNovz4UDpYKw+lMwJX+N46X3fNU?=
 =?us-ascii?Q?nwV13V5wxSr3VJtmb6iofWPmyoLizi2O851GBjxmow0Br6j/1xMuR2WD3JL0?=
 =?us-ascii?Q?FG0Tquck0IhAdqku7wyP7iQkKGrP9pH/RLh/vvznOzVXME0wR789bzmCbqUS?=
 =?us-ascii?Q?RtQMnS1JKMpKHY3QbtshXN9SfrBNuGb+L3RGHTVrhKQsR1rhAGRsZVme+gdU?=
 =?us-ascii?Q?ulb58/X8bMBuTpCsyjMMz6NrDt8se53qNQb55NIRoMJ8ThUoyDzAH0fZVCY9?=
 =?us-ascii?Q?Z6S1NZBg000dBHLqSKoOmf8aDwWv4MVj7BLTuxbLTuHgflDzb/i/rDH8E0KZ?=
 =?us-ascii?Q?WgJ//PbE5B6iui2CFxErKrS0bfEc2nWhCBFtSff9Il+MRAUDBZgpS2JGA3VO?=
 =?us-ascii?Q?b+v5G9tXnkeEO1VUdxU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:17:50.9876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07facaa9-8f29-4a4c-7a86-08de12150a6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

From: Mark Bloch <mbloch@nvidia.com>

Replace direct hardware system image GUID usage with a new software
system image GUID function that supports variable-length identifiers.

Key changes:
- Add mlx5_query_nic_sw_system_image_guid() function with length parameter.
- Update all callsites to use the new function and buffer/length approach.
- Modify mapping contexts to use byte arrays instead of u64 keys.
- Update devcom matching to support variable-length keys.
- Change mlx5_same_hw_devs() to use buffer comparison instead of u64.

This refactoring prepares the infrastructure for balance ID support,
which requires extending the system image GUID with additional data.
The change maintains backward compatibility while enabling future
enhancements.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 12 ++++++---
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |  7 ++---
 .../ethernet/mellanox/mlx5/core/en/mapping.c  | 13 +++++++---
 .../ethernet/mellanox/mlx5/core/en/mapping.h  |  3 ++-
 .../mellanox/mlx5/core/en/tc/int_port.c       |  8 +++---
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 11 +++++---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 26 ++++++++++++-------
 .../mellanox/mlx5/core/esw/devlink_port.c     |  6 +----
 .../mellanox/mlx5/core/eswitch_offloads.c     |  8 +++---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 ++-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  2 ++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 15 +++++++++++
 include/linux/mlx5/driver.h                   |  3 +++
 14 files changed, 80 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 891bbbbfbbf1..64c04f52990f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -564,10 +564,14 @@ int mlx5_rescan_drivers_locked(struct mlx5_core_dev *dev)
 
 bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev)
 {
-	u64 fsystem_guid, psystem_guid;
+	u8 fsystem_guid[MLX5_SW_IMAGE_GUID_MAX_BYTES];
+	u8 psystem_guid[MLX5_SW_IMAGE_GUID_MAX_BYTES];
+	u8 flen;
+	u8 plen;
 
-	fsystem_guid = mlx5_query_nic_system_image_guid(dev);
-	psystem_guid = mlx5_query_nic_system_image_guid(peer_dev);
+	mlx5_query_nic_sw_system_image_guid(dev, fsystem_guid, &flen);
+	mlx5_query_nic_sw_system_image_guid(peer_dev, psystem_guid, &plen);
 
-	return (fsystem_guid && psystem_guid && fsystem_guid == psystem_guid);
+	return plen && flen && flen == plen &&
+		!memcmp(fsystem_guid, psystem_guid, flen);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
index 0b1ac6e5c890..8818f65d1fbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
@@ -40,11 +40,8 @@ void mlx5e_destroy_devlink(struct mlx5e_dev *mlx5e_dev)
 static void
 mlx5e_devlink_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_id *ppid)
 {
-	u64 parent_id;
-
-	parent_id = mlx5_query_nic_system_image_guid(dev);
-	ppid->id_len = sizeof(parent_id);
-	memcpy(ppid->id, &parent_id, sizeof(parent_id));
+	BUILD_BUG_ON(MLX5_SW_IMAGE_GUID_MAX_BYTES > MAX_PHYS_ITEM_ID_LEN);
+	mlx5_query_nic_sw_system_image_guid(dev, ppid->id, &ppid->id_len);
 }
 
 int mlx5e_devlink_port_register(struct mlx5e_dev *mlx5e_dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.c b/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.c
index 4e72ca8070e2..1de18c7e96ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.c
@@ -6,6 +6,7 @@
 #include <linux/xarray.h>
 #include <linux/hashtable.h>
 #include <linux/refcount.h>
+#include <linux/mlx5/driver.h>
 
 #include "mapping.h"
 
@@ -24,7 +25,8 @@ struct mapping_ctx {
 	struct delayed_work dwork;
 	struct list_head pending_list;
 	spinlock_t pending_list_lock; /* Guards pending list */
-	u64 id;
+	u8 id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
+	u8 id_len;
 	u8 type;
 	struct list_head list;
 	refcount_t refcount;
@@ -220,13 +222,15 @@ mapping_create(size_t data_size, u32 max_id, bool delayed_removal)
 }
 
 struct mapping_ctx *
-mapping_create_for_id(u64 id, u8 type, size_t data_size, u32 max_id, bool delayed_removal)
+mapping_create_for_id(u8 *id, u8 id_len, u8 type, size_t data_size, u32 max_id,
+		      bool delayed_removal)
 {
 	struct mapping_ctx *ctx;
 
 	mutex_lock(&shared_ctx_lock);
 	list_for_each_entry(ctx, &shared_ctx_list, list) {
-		if (ctx->id == id && ctx->type == type) {
+		if (ctx->type == type && ctx->id_len == id_len &&
+		    !memcmp(id, ctx->id, id_len)) {
 			if (refcount_inc_not_zero(&ctx->refcount))
 				goto unlock;
 			break;
@@ -237,7 +241,8 @@ mapping_create_for_id(u64 id, u8 type, size_t data_size, u32 max_id, bool delaye
 	if (IS_ERR(ctx))
 		goto unlock;
 
-	ctx->id = id;
+	memcpy(ctx->id, id, id_len);
+	ctx->id_len = id_len;
 	ctx->type = type;
 	list_add(&ctx->list, &shared_ctx_list);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.h b/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.h
index 4e2119f0f4c1..e86a103d58b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mapping.h
@@ -27,6 +27,7 @@ void mapping_destroy(struct mapping_ctx *ctx);
 /* adds mapping with an id or get an existing mapping with the same id
  */
 struct mapping_ctx *
-mapping_create_for_id(u64 id, u8 type, size_t data_size, u32 max_id, bool delayed_removal);
+mapping_create_for_id(u8 *id, u8 id_len, u8 type, size_t data_size, u32 max_id,
+		      bool delayed_removal);
 
 #endif /* __MLX5_MAPPING_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
index 896f718483c3..991f47050643 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
@@ -307,7 +307,8 @@ mlx5e_tc_int_port_init(struct mlx5e_priv *priv)
 {
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	struct mlx5e_tc_int_port_priv *int_port_priv;
-	u64 mapping_id;
+	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
+	u8 id_len;
 
 	if (!mlx5e_tc_int_port_supported(esw))
 		return NULL;
@@ -316,9 +317,10 @@ mlx5e_tc_int_port_init(struct mlx5e_priv *priv)
 	if (!int_port_priv)
 		return NULL;
 
-	mapping_id = mlx5_query_nic_system_image_guid(priv->mdev);
+	mlx5_query_nic_sw_system_image_guid(priv->mdev, mapping_id, &id_len);
 
-	int_port_priv->metadata_mapping = mapping_create_for_id(mapping_id, MAPPING_TYPE_INT_PORT,
+	int_port_priv->metadata_mapping = mapping_create_for_id(mapping_id, id_len,
+								MAPPING_TYPE_INT_PORT,
 								sizeof(u32) * 2,
 								(1 << ESW_VPORT_BITS) - 1, true);
 	if (IS_ERR(int_port_priv->metadata_mapping)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 870d12364f99..fc0e57403d25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -2287,9 +2287,10 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 		enum mlx5_flow_namespace_type ns_type,
 		struct mlx5e_post_act *post_act)
 {
+	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
 	struct mlx5_tc_ct_priv *ct_priv;
 	struct mlx5_core_dev *dev;
-	u64 mapping_id;
+	u8 id_len;
 	int err;
 
 	dev = priv->mdev;
@@ -2301,16 +2302,18 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 	if (!ct_priv)
 		goto err_alloc;
 
-	mapping_id = mlx5_query_nic_system_image_guid(dev);
+	mlx5_query_nic_sw_system_image_guid(dev, mapping_id, &id_len);
 
-	ct_priv->zone_mapping = mapping_create_for_id(mapping_id, MAPPING_TYPE_ZONE,
+	ct_priv->zone_mapping = mapping_create_for_id(mapping_id, id_len,
+						      MAPPING_TYPE_ZONE,
 						      sizeof(u16), 0, true);
 	if (IS_ERR(ct_priv->zone_mapping)) {
 		err = PTR_ERR(ct_priv->zone_mapping);
 		goto err_mapping_zone;
 	}
 
-	ct_priv->labels_mapping = mapping_create_for_id(mapping_id, MAPPING_TYPE_LABELS,
+	ct_priv->labels_mapping = mapping_create_for_id(mapping_id, id_len,
+							MAPPING_TYPE_LABELS,
 							sizeof(u32) * 4, 0, true);
 	if (IS_ERR(ct_priv->labels_mapping)) {
 		err = PTR_ERR(ct_priv->labels_mapping);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 54ccfb4e6c4e..a8773b2342c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5233,10 +5233,11 @@ static void mlx5e_tc_nic_destroy_miss_table(struct mlx5e_priv *priv)
 int mlx5e_tc_nic_init(struct mlx5e_priv *priv)
 {
 	struct mlx5e_tc_table *tc = mlx5e_fs_get_tc(priv->fs);
+	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
 	struct mlx5_core_dev *dev = priv->mdev;
 	struct mapping_ctx *chains_mapping;
 	struct mlx5_chains_attr attr = {};
-	u64 mapping_id;
+	u8 id_len;
 	int err;
 
 	mlx5e_mod_hdr_tbl_init(&tc->mod_hdr);
@@ -5252,11 +5253,13 @@ int mlx5e_tc_nic_init(struct mlx5e_priv *priv)
 	lockdep_set_class(&tc->ht.mutex, &tc_ht_lock_key);
 	lockdep_init_map(&tc->ht.run_work.lockdep_map, "tc_ht_wq_key", &tc_ht_wq_key, 0);
 
-	mapping_id = mlx5_query_nic_system_image_guid(dev);
+	mlx5_query_nic_sw_system_image_guid(dev, mapping_id, &id_len);
 
-	chains_mapping = mapping_create_for_id(mapping_id, MAPPING_TYPE_CHAIN,
+	chains_mapping = mapping_create_for_id(mapping_id, id_len,
+					       MAPPING_TYPE_CHAIN,
 					       sizeof(struct mlx5_mapped_obj),
-					       MLX5E_TC_TABLE_CHAIN_TAG_MASK, true);
+					       MLX5E_TC_TABLE_CHAIN_TAG_MASK,
+					       true);
 
 	if (IS_ERR(chains_mapping)) {
 		err = PTR_ERR(chains_mapping);
@@ -5387,14 +5390,15 @@ void mlx5e_tc_ht_cleanup(struct rhashtable *tc_ht)
 int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 {
 	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
+	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
 	struct mlx5_devcom_match_attr attr = {};
 	struct netdev_phys_item_id ppid;
 	struct mlx5e_rep_priv *rpriv;
 	struct mapping_ctx *mapping;
 	struct mlx5_eswitch *esw;
 	struct mlx5e_priv *priv;
-	u64 mapping_id;
 	int err = 0;
+	u8 id_len;
 
 	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
 	priv = netdev_priv(rpriv->netdev);
@@ -5412,9 +5416,9 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 
 	uplink_priv->tc_psample = mlx5e_tc_sample_init(esw, uplink_priv->post_act);
 
-	mapping_id = mlx5_query_nic_system_image_guid(esw->dev);
+	mlx5_query_nic_sw_system_image_guid(esw->dev, mapping_id, &id_len);
 
-	mapping = mapping_create_for_id(mapping_id, MAPPING_TYPE_TUNNEL,
+	mapping = mapping_create_for_id(mapping_id, id_len, MAPPING_TYPE_TUNNEL,
 					sizeof(struct tunnel_match_key),
 					TUNNEL_INFO_BITS_MASK, true);
 
@@ -5427,8 +5431,10 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 	/* Two last values are reserved for stack devices slow path table mark
 	 * and bridge ingress push mark.
 	 */
-	mapping = mapping_create_for_id(mapping_id, MAPPING_TYPE_TUNNEL_ENC_OPTS,
-					sz_enc_opts, ENC_OPTS_BITS_MASK - 2, true);
+	mapping = mapping_create_for_id(mapping_id, id_len,
+					MAPPING_TYPE_TUNNEL_ENC_OPTS,
+					sz_enc_opts, ENC_OPTS_BITS_MASK - 2,
+					true);
 	if (IS_ERR(mapping)) {
 		err = PTR_ERR(mapping);
 		goto err_enc_opts_mapping;
@@ -5449,7 +5455,7 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 
 	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
-		memcpy(&attr.key.val, &ppid.id, sizeof(attr.key.val));
+		memcpy(&attr.key.buf, &ppid.id, ppid.id_len);
 		attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
 		attr.net = mlx5_core_net(esw->dev);
 		mlx5_esw_offloads_devcom_init(esw, &attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index cf88a106d80d..89a58dee50b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -7,11 +7,7 @@
 static void
 mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_id *ppid)
 {
-	u64 parent_id;
-
-	parent_id = mlx5_query_nic_system_image_guid(dev);
-	ppid->id_len = sizeof(parent_id);
-	memcpy(ppid->id, &parent_id, sizeof(parent_id));
+	mlx5_query_nic_sw_system_image_guid(dev, ppid->id, &ppid->id_len);
 }
 
 static bool mlx5_esw_devlink_port_supported(struct mlx5_eswitch *esw, u16 vport_num)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4cf995be127d..cbe848b3df65 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3557,10 +3557,11 @@ bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 cont
 
 int esw_offloads_enable(struct mlx5_eswitch *esw)
 {
+	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
 	struct mapping_ctx *reg_c0_obj_pool;
 	struct mlx5_vport *vport;
 	unsigned long i;
-	u64 mapping_id;
+	u8 id_len;
 	int err;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
@@ -3582,9 +3583,10 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_vport_metadata;
 
-	mapping_id = mlx5_query_nic_system_image_guid(esw->dev);
+	mlx5_query_nic_sw_system_image_guid(esw->dev, mapping_id, &id_len);
 
-	reg_c0_obj_pool = mapping_create_for_id(mapping_id, MAPPING_TYPE_CHAIN,
+	reg_c0_obj_pool = mapping_create_for_id(mapping_id, id_len,
+						MAPPING_TYPE_CHAIN,
 						sizeof(struct mlx5_mapped_obj),
 						ESW_REG_C0_USER_DATA_METADATA_MASK,
 						true);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 59c00c911275..24f1107c7c6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1418,10 +1418,12 @@ static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
 static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 {
 	struct mlx5_devcom_match_attr attr = {
-		.key.val = mlx5_query_nic_system_image_guid(dev),
 		.flags = MLX5_DEVCOM_MATCH_FLAGS_NS,
 		.net = mlx5_core_net(dev),
 	};
+	u8 len __always_unused;
+
+	mlx5_query_nic_sw_system_image_guid(dev, attr.key.buf, &len);
 
 	/* This component is use to sync adding core_dev to lag_dev and to sync
 	 * changes of mlx5_adev_devices between LAG layer and other layers.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 609c85f47917..91e5ae529d5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -10,8 +10,10 @@ enum mlx5_devom_match_flags {
 	MLX5_DEVCOM_MATCH_FLAGS_NS = BIT(0),
 };
 
+#define MLX5_DEVCOM_MATCH_KEY_MAX 32
 union mlx5_devcom_match_key {
 	u64 val;
+	u8 buf[MLX5_DEVCOM_MATCH_KEY_MAX];
 };
 
 struct mlx5_devcom_match_attr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 082259b56816..acef7d0ffa09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -444,6 +444,8 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev);
 void mlx5_uninit_one_light(struct mlx5_core_dev *dev);
 void mlx5_unload_one_light(struct mlx5_core_dev *dev);
 
+void mlx5_query_nic_sw_system_image_guid(struct mlx5_core_dev *mdev, u8 *buf,
+					 u8 *len);
 int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap, u16 vport,
 				  u16 opmod);
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 2ed2e530b07d..4224e2750865 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1190,6 +1190,21 @@ u64 mlx5_query_nic_system_image_guid(struct mlx5_core_dev *mdev)
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_system_image_guid);
 
+void mlx5_query_nic_sw_system_image_guid(struct mlx5_core_dev *mdev, u8 *buf,
+					 u8 *len)
+{
+	u64 fw_system_image_guid;
+
+	*len = 0;
+
+	fw_system_image_guid = mlx5_query_nic_system_image_guid(mdev);
+	if (!fw_system_image_guid)
+		return;
+
+	memcpy(buf, &fw_system_image_guid, sizeof(fw_system_image_guid));
+	*len += sizeof(fw_system_image_guid);
+}
+
 static bool mlx5_vport_use_vhca_id_as_func_id(struct mlx5_core_dev *dev,
 					      u16 vport_num, u16 *vhca_id)
 {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 5405ca1038f9..dcf262aa9ea6 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1379,4 +1379,7 @@ static inline struct net *mlx5_core_net(struct mlx5_core_dev *dev)
 {
 	return devlink_net(priv_to_devlink(dev));
 }
+
+#define MLX5_SW_IMAGE_GUID_MAX_BYTES 8
+
 #endif /* MLX5_DRIVER_H */
-- 
2.31.1


