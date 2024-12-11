Return-Path: <linux-rdma+bounces-6442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD49ECD84
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2897C162986
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFD236923;
	Wed, 11 Dec 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bulrQ5Al"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D7233689;
	Wed, 11 Dec 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924658; cv=fail; b=AuCX9NNajYfIXh7XTA9ayGOkQ3xmfiWxMc6iDY0u8yXUq/v1Gnqi9+94BXq6vZH9ijt8wXiifjfpnccHlmKG5B+li7+znZqsuUWtF8s1+4w6kidsrljltTWlHMwaSQoZt1iykrh0z5yp3TJAdlW9ZIOM2+zKvhZgfBQmoBSmCME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924658; c=relaxed/simple;
	bh=AgFl2ZdpNwSQL41LhymUKQ07IQYrgKXswjCWquKviLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB5G9Gv9PjDWLiEtjKI1elldR5yDB3X+zJ5bNtsLsarJLqtBhYBXRUEdIilIq29bCuXIr/fX4TPQJXc6Z+05gE+aF60SRv8KAw7/T4w95k9cBsStr2pPLuFoQ7OkUCR5alaWqHR2uMXzG8nZLNtrGqNMML3jxhf0xt0Val2WQrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bulrQ5Al; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl/Np9kzVk9u79O+Eg9lNEivToDTbFC2UhpUrq9WddRp8Nv4r7SAq40ozmyElfb1d7rJVr/Ppp4XbCahY+Hehv9l43rfT9u1csbSbT908BlJPNsW11nLdeBjzkuKkJUlRZZO6X4Hnup+8Ft5wJKwhInd5IltY7dYlGBEFa2PDoLmi81vSCFyztBdY1UGVBOOhXxB5b0gTaZv1Q202IX1pxu9nEkPvnDRwfuoL8KUTsuZbcZ29g7IlBII+znY0W4rm9i3gU049VT5Yxhwreg6MpIc2X6H/kl82QeW51Uo26MjEnuO09m1rdkXaDi/Z3sFVebD8zCxkz6vIQbggk0Xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbXJMMwHFYJ4TaeUKdaUIx5zd6lk1RrnyB7+/vfOvWY=;
 b=ClaHLSfFbBWMjr+bITYdJ2TnF/8VwVdSzyLyKib0ADOAE5vdi/AeVpjZEcpeUoHBLCny1y7XEoeC82Fbp5JxDCn0yGBB/vLQ4+ifAHIkWVlG28whqsmwiEFl8AS2Hsanv2u7suMC2phfxZE8Tw9QDDMzYAdpvoxtDim51ohkxF7pfbmyIiEbue2Th0STm0eBiuc7C+Kzee/pf3RKXmETXGExgSIlPn/0IQRaVp+jy8kDT5adV/TgFJBDCL7iu4oVbzZDPYPVX0Hzdj9EseUcRtxqcbxloyOkoUxYUMxYqwRwoONXz0bO1+By7C1X7BCNSbCkidaGq7WtK0IKGH9FPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbXJMMwHFYJ4TaeUKdaUIx5zd6lk1RrnyB7+/vfOvWY=;
 b=bulrQ5AlNWHtzSld7nlwFo+iOQjIESy3eMWXoHQ+FvWoj8vI5qbGggwHiBbVvpoxthdic2eKsPyiqVa/VTMw6FRYpuOxQLV1PNeVJxcTjtud8kqfAaxfyYKJSvuEm4MtayIhjz8awyCRrGGQjaLCmJIn++1PavQgM1r2immT3NQNDTtkz2qBMl9cT+6unUHE4Ec9npD78rZMPK41ykmWTEFuMawIXiV4uWDZpGWFjOuX3CzOgHKvPzcWekxxTO2yYjNxPGh9oPZnByvYFEBe8RGSg58o3KyiUVLulOqq+MmBKXAt15haj1QRrpXvrdhO8CmiFCqvUe5qtFna65WcuQ==
Received: from CY5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::26) by
 SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.22; Wed, 11 Dec 2024 13:44:07 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::be) by CY5P221CA0012.outlook.office365.com
 (2603:10b6:930:b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 13:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:44:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:56 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:43:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/12] net/mlx5: fs, add mlx5_fs_pool API
Date: Wed, 11 Dec 2024 15:42:16 +0200
Message-ID: <20241211134223.389616-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241211134223.389616-1-tariqt@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b0f175-d0db-495d-1bd3-08dd19e9e27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6C2fOOpBgif7xTa7E4gqlB9oU0f4Ihg+nPYYS/Fu2zk9Dce+Uaj/DdyVSDGj?=
 =?us-ascii?Q?B6e7ABnaZAm8ZzmKtb84DFFRSU3HqpHEXUao456ZaldMGjluSvmv5rujucA1?=
 =?us-ascii?Q?ScZITCsoXs4tJfVHdV5n2n+wo3KOMiO18NLzP8Na5a0kV5us1CgKS60LBO+I?=
 =?us-ascii?Q?2PYNB1CoDj782EBnAfl06kxVyX1+3Xyqdqm/Z6X6uaQ+KHyuVeV1fU6xPVxL?=
 =?us-ascii?Q?N1LqpiHdW7C67qBswutA3X+V/9o3PHc7+SApFtlpSvbGiqw1nkziEIFfXm3b?=
 =?us-ascii?Q?2A4VQAUB+3fMuZ1k8pctBb0DTlYc/OE1Rr+7rrBQIhy8sTcVEC0fgJKEYgNL?=
 =?us-ascii?Q?Wa4USC3GlCPBqJbl3M5sMlo2iEwEFnaXEs9RoOH8t/kTH6iMd30a8t/9Fysd?=
 =?us-ascii?Q?yzlXdLvjKy+9vXuWDVRgRIb6qzrwipMJu9Au79StR7U5CClX1bePir7GjM1P?=
 =?us-ascii?Q?EG4Hr/ppcyA5GuG5Yi4Ix4qJezXJWNSh1Dt4AbC/lYO3JvY42/lqxSMnvyPT?=
 =?us-ascii?Q?fLmuv+ZFcjn+d+qXZBikvMMtvlu6LlUyJq1VAJ/aN++UwgZsFiH9YNH0owP7?=
 =?us-ascii?Q?KwX/KizU6RjLKOaP5BtYB5kjxxVH9cWXVwaAZoMWyAKtAx831rkx2m8Aemfu?=
 =?us-ascii?Q?lQEpFPq2pq7YL3QWBJ/e3T5wsU3JsQIpvf88Oe3FEGcnJuhv3LvjPO1paCtA?=
 =?us-ascii?Q?TBTkdOayTPqVCjkBRDvFDUVY0zqV9dTLOkvkekz6CxY69gYzeYYXkAuzJVsn?=
 =?us-ascii?Q?Neat4W5u4ws8BVQqsjJgb7bVDN7YUYjbaGJlQtH06DzzJZ5BKVILeNFVRTv7?=
 =?us-ascii?Q?40Lj9Z0/Tvi3bhHwPSYezBjrZcBcT+G80eoqb/kU3XJVdf+JI+AphIhLrRO7?=
 =?us-ascii?Q?ae5Ry7ap9mNrSJqwTDNiK7WC5FtfAOnppix/JRcEMICHewj+LwYB6wz7h/OB?=
 =?us-ascii?Q?BIpG0pQrFG9xtwxaVYRprCIuzfc5MtnSZ66QYi4hElBgYTsJBLgsVF52I+Ie?=
 =?us-ascii?Q?HdRNA8n9bKZmzK8twLyN8gJcsQsEpp1cB6/kYCSjWyx9vNPoGf8FJfa0KpyF?=
 =?us-ascii?Q?AI0rh92CbvFdN5rMuSMHrQTLRlYEoRQgUhwGNHFusPn7/RiYjQmJkQtQw9Da?=
 =?us-ascii?Q?2eEMHm9Xl5EUvFqKPNvqbLlg+4+EHi0KsQ/5eEvNAkmJg2C3qjdrcqmdsFss?=
 =?us-ascii?Q?D89iOjt6yLc3A1WyxvY2e4X57du1xvsYpUBr/x7quxLodEDyqqre4OIqwZ2Q?=
 =?us-ascii?Q?JtKRJjIwtdbVL5WCbdYSsw36ID9Y8yJGli2N5CAObltFskvP1wQ1c9kMuXQ5?=
 =?us-ascii?Q?O9Qu4mrwwibfoGIAV+Za5EXwfyR19nVUGQVyrHjgcdJPCBoRJzhk+czXTmd3?=
 =?us-ascii?Q?TnefCLWFLjw+N0OzJ5XvxSYtXubx9Mkma+kN6FjcxV61E9vw77+cvmYK3Rzz?=
 =?us-ascii?Q?pOxWTnCCLK55m6h9M2Vo2aA5inMEsfY2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:07.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b0f175-d0db-495d-1bd3-08dd19e9e27c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

From: Moshe Shemesh <moshe@nvidia.com>

Refactor fc_pool API to create generic fs_pool API, as HW steering has
more flow steering elements which can take advantage of the same pool of
bulks API. Change fs_counters code to use the fs_pool API.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 294 +++++-------------
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 ++++
 4 files changed, 331 insertions(+), 213 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index be3d0876c521..79fe09de0a9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -17,7 +17,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
 		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o
+		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 8cd5e274d6d3..2a167a2fd25d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -34,6 +34,7 @@
 #include <linux/mlx5/fs.h>
 #include "mlx5_core.h"
 #include "fs_core.h"
+#include "fs_pool.h"
 #include "fs_cmd.h"
 
 #define MLX5_FC_STATS_PERIOD msecs_to_jiffies(1000)
@@ -65,17 +66,6 @@ struct mlx5_fc {
 	u64 lastbytes;
 };
 
-struct mlx5_fc_pool {
-	struct mlx5_core_dev *dev;
-	struct mutex pool_lock; /* protects pool lists */
-	struct list_head fully_used;
-	struct list_head partially_used;
-	struct list_head unused;
-	int available_fcs;
-	int used_fcs;
-	int threshold;
-};
-
 struct mlx5_fc_stats {
 	struct xarray counters;
 
@@ -86,13 +76,13 @@ struct mlx5_fc_stats {
 	int bulk_query_len;
 	bool bulk_query_alloc_failed;
 	unsigned long next_bulk_query_alloc;
-	struct mlx5_fc_pool fc_pool;
+	struct mlx5_fs_pool fc_pool;
 };
 
-static void mlx5_fc_pool_init(struct mlx5_fc_pool *fc_pool, struct mlx5_core_dev *dev);
-static void mlx5_fc_pool_cleanup(struct mlx5_fc_pool *fc_pool);
-static struct mlx5_fc *mlx5_fc_pool_acquire_counter(struct mlx5_fc_pool *fc_pool);
-static void mlx5_fc_pool_release_counter(struct mlx5_fc_pool *fc_pool, struct mlx5_fc *fc);
+static void mlx5_fc_pool_init(struct mlx5_fs_pool *fc_pool, struct mlx5_core_dev *dev);
+static void mlx5_fc_pool_cleanup(struct mlx5_fs_pool *fc_pool);
+static struct mlx5_fc *mlx5_fc_pool_acquire_counter(struct mlx5_fs_pool *fc_pool);
+static void mlx5_fc_pool_release_counter(struct mlx5_fs_pool *fc_pool, struct mlx5_fc *fc);
 
 static int get_init_bulk_query_len(struct mlx5_core_dev *dev)
 {
@@ -447,11 +437,9 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
 /* Flow counter bluks */
 
 struct mlx5_fc_bulk {
-	struct list_head pool_list;
+	struct mlx5_fs_bulk fs_bulk;
 	u32 base_id;
-	int bulk_len;
-	unsigned long *bitmask;
-	struct mlx5_fc fcs[] __counted_by(bulk_len);
+	struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
 };
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
@@ -461,16 +449,10 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
-static int mlx5_fc_bulk_get_free_fcs_amount(struct mlx5_fc_bulk *bulk)
-{
-	return bitmap_weight(bulk->bitmask, bulk->bulk_len);
-}
-
-static struct mlx5_fc_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
+static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
 {
 	enum mlx5_fc_bulk_alloc_bitmask alloc_bitmask;
-	struct mlx5_fc_bulk *bulk;
-	int err = -ENOMEM;
+	struct mlx5_fc_bulk *fc_bulk;
 	int bulk_len;
 	u32 base_id;
 	int i;
@@ -478,71 +460,97 @@ static struct mlx5_fc_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
 	alloc_bitmask = MLX5_CAP_GEN(dev, flow_counter_bulk_alloc);
 	bulk_len = alloc_bitmask > 0 ? MLX5_FC_BULK_NUM_FCS(alloc_bitmask) : 1;
 
-	bulk = kvzalloc(struct_size(bulk, fcs, bulk_len), GFP_KERNEL);
-	if (!bulk)
-		goto err_alloc_bulk;
+	fc_bulk = kvzalloc(struct_size(fc_bulk, fcs, bulk_len), GFP_KERNEL);
+	if (!fc_bulk)
+		return NULL;
 
-	bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), sizeof(unsigned long),
-				 GFP_KERNEL);
-	if (!bulk->bitmask)
-		goto err_alloc_bitmask;
+	if (mlx5_fs_bulk_init(dev, &fc_bulk->fs_bulk, bulk_len))
+		goto err_fs_bulk_init;
 
-	err = mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id);
-	if (err)
-		goto err_mlx5_cmd_bulk_alloc;
+	if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
+		goto err_cmd_bulk_alloc;
+	fc_bulk->base_id = base_id;
+	for (i = 0; i < bulk_len; i++)
+		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
 
-	bulk->base_id = base_id;
-	bulk->bulk_len = bulk_len;
-	for (i = 0; i < bulk_len; i++) {
-		mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
-		set_bit(i, bulk->bitmask);
-	}
+	return &fc_bulk->fs_bulk;
 
-	return bulk;
-
-err_mlx5_cmd_bulk_alloc:
-	kvfree(bulk->bitmask);
-err_alloc_bitmask:
-	kvfree(bulk);
-err_alloc_bulk:
-	return ERR_PTR(err);
+err_cmd_bulk_alloc:
+	mlx5_fs_bulk_cleanup(&fc_bulk->fs_bulk);
+err_fs_bulk_init:
+	kvfree(fc_bulk);
+	return NULL;
 }
 
 static int
-mlx5_fc_bulk_destroy(struct mlx5_core_dev *dev, struct mlx5_fc_bulk *bulk)
+mlx5_fc_bulk_destroy(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk)
 {
-	if (mlx5_fc_bulk_get_free_fcs_amount(bulk) < bulk->bulk_len) {
+	struct mlx5_fc_bulk *fc_bulk = container_of(fs_bulk,
+						    struct mlx5_fc_bulk,
+						    fs_bulk);
+
+	if (mlx5_fs_bulk_get_free_amount(fs_bulk) < fs_bulk->bulk_len) {
 		mlx5_core_err(dev, "Freeing bulk before all counters were released\n");
 		return -EBUSY;
 	}
 
-	mlx5_cmd_fc_free(dev, bulk->base_id);
-	kvfree(bulk->bitmask);
-	kvfree(bulk);
+	mlx5_cmd_fc_free(dev, fc_bulk->base_id);
+	mlx5_fs_bulk_cleanup(fs_bulk);
+	kvfree(fc_bulk);
 
 	return 0;
 }
 
-static struct mlx5_fc *mlx5_fc_bulk_acquire_fc(struct mlx5_fc_bulk *bulk)
+static void mlx5_fc_pool_update_threshold(struct mlx5_fs_pool *fc_pool)
 {
-	int free_fc_index = find_first_bit(bulk->bitmask, bulk->bulk_len);
+	fc_pool->threshold = min_t(int, MLX5_FC_POOL_MAX_THRESHOLD,
+				   fc_pool->used_units / MLX5_FC_POOL_USED_BUFF_RATIO);
+}
 
-	if (free_fc_index >= bulk->bulk_len)
-		return ERR_PTR(-ENOSPC);
+/* Flow counters pool API */
+
+static const struct mlx5_fs_pool_ops mlx5_fc_pool_ops = {
+	.bulk_destroy = mlx5_fc_bulk_destroy,
+	.bulk_create = mlx5_fc_bulk_create,
+	.update_threshold = mlx5_fc_pool_update_threshold,
+};
 
-	clear_bit(free_fc_index, bulk->bitmask);
-	return &bulk->fcs[free_fc_index];
+static void
+mlx5_fc_pool_init(struct mlx5_fs_pool *fc_pool, struct mlx5_core_dev *dev)
+{
+	mlx5_fs_pool_init(fc_pool, dev, &mlx5_fc_pool_ops);
 }
 
-static int mlx5_fc_bulk_release_fc(struct mlx5_fc_bulk *bulk, struct mlx5_fc *fc)
+static void mlx5_fc_pool_cleanup(struct mlx5_fs_pool *fc_pool)
 {
-	int fc_index = fc->id - bulk->base_id;
+	mlx5_fs_pool_cleanup(fc_pool);
+}
 
-	if (test_bit(fc_index, bulk->bitmask))
-		return -EINVAL;
+static struct mlx5_fc *
+mlx5_fc_pool_acquire_counter(struct mlx5_fs_pool *fc_pool)
+{
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_fc_bulk *fc_bulk;
+	int err;
 
-	set_bit(fc_index, bulk->bitmask);
-	return 0;
+	err = mlx5_fs_pool_acquire_index(fc_pool, &pool_index);
+	if (err)
+		return ERR_PTR(err);
+	fc_bulk = container_of(pool_index.fs_bulk, struct mlx5_fc_bulk, fs_bulk);
+	return &fc_bulk->fcs[pool_index.index];
+}
+
+static void
+mlx5_fc_pool_release_counter(struct mlx5_fs_pool *fc_pool, struct mlx5_fc *fc)
+{
+	struct mlx5_fs_bulk *fs_bulk = &fc->bulk->fs_bulk;
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_core_dev *dev = fc_pool->dev;
+
+	pool_index.fs_bulk = fs_bulk;
+	pool_index.index = fc->id - fc->bulk->base_id;
+	if (mlx5_fs_pool_release_index(fc_pool, &pool_index))
+		mlx5_core_warn(dev, "Attempted to release a counter which is not acquired\n");
 }
 
 /**
@@ -556,22 +564,22 @@ static int mlx5_fc_bulk_release_fc(struct mlx5_fc_bulk *bulk, struct mlx5_fc *fc
 struct mlx5_fc *
 mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 {
-	struct mlx5_fc_bulk *bulk;
+	struct mlx5_fc_bulk *fc_bulk;
 	struct mlx5_fc *counter;
 
 	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
-	bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
-	if (!bulk) {
+	fc_bulk = kzalloc(sizeof(*fc_bulk), GFP_KERNEL);
+	if (!fc_bulk) {
 		kfree(counter);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	counter->type = MLX5_FC_TYPE_LOCAL;
 	counter->id = counter_id;
-	bulk->base_id = counter_id - offset;
-	bulk->bulk_len = bulk_size;
+	fc_bulk->base_id = counter_id - offset;
+	fc_bulk->fs_bulk.bulk_len = bulk_size;
 	return counter;
 }
 EXPORT_SYMBOL(mlx5_fc_local_create);
@@ -585,141 +593,3 @@ void mlx5_fc_local_destroy(struct mlx5_fc *counter)
 	kfree(counter);
 }
 EXPORT_SYMBOL(mlx5_fc_local_destroy);
-
-/* Flow counters pool API */
-
-static void mlx5_fc_pool_init(struct mlx5_fc_pool *fc_pool, struct mlx5_core_dev *dev)
-{
-	fc_pool->dev = dev;
-	mutex_init(&fc_pool->pool_lock);
-	INIT_LIST_HEAD(&fc_pool->fully_used);
-	INIT_LIST_HEAD(&fc_pool->partially_used);
-	INIT_LIST_HEAD(&fc_pool->unused);
-	fc_pool->available_fcs = 0;
-	fc_pool->used_fcs = 0;
-	fc_pool->threshold = 0;
-}
-
-static void mlx5_fc_pool_cleanup(struct mlx5_fc_pool *fc_pool)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc_bulk *tmp;
-
-	list_for_each_entry_safe(bulk, tmp, &fc_pool->fully_used, pool_list)
-		mlx5_fc_bulk_destroy(dev, bulk);
-	list_for_each_entry_safe(bulk, tmp, &fc_pool->partially_used, pool_list)
-		mlx5_fc_bulk_destroy(dev, bulk);
-	list_for_each_entry_safe(bulk, tmp, &fc_pool->unused, pool_list)
-		mlx5_fc_bulk_destroy(dev, bulk);
-}
-
-static void mlx5_fc_pool_update_threshold(struct mlx5_fc_pool *fc_pool)
-{
-	fc_pool->threshold = min_t(int, MLX5_FC_POOL_MAX_THRESHOLD,
-				   fc_pool->used_fcs / MLX5_FC_POOL_USED_BUFF_RATIO);
-}
-
-static struct mlx5_fc_bulk *
-mlx5_fc_pool_alloc_new_bulk(struct mlx5_fc_pool *fc_pool)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-	struct mlx5_fc_bulk *new_bulk;
-
-	new_bulk = mlx5_fc_bulk_create(dev);
-	if (!IS_ERR(new_bulk))
-		fc_pool->available_fcs += new_bulk->bulk_len;
-	mlx5_fc_pool_update_threshold(fc_pool);
-	return new_bulk;
-}
-
-static void
-mlx5_fc_pool_free_bulk(struct mlx5_fc_pool *fc_pool, struct mlx5_fc_bulk *bulk)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-
-	fc_pool->available_fcs -= bulk->bulk_len;
-	mlx5_fc_bulk_destroy(dev, bulk);
-	mlx5_fc_pool_update_threshold(fc_pool);
-}
-
-static struct mlx5_fc *
-mlx5_fc_pool_acquire_from_list(struct list_head *src_list,
-			       struct list_head *next_list,
-			       bool move_non_full_bulk)
-{
-	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc *fc;
-
-	if (list_empty(src_list))
-		return ERR_PTR(-ENODATA);
-
-	bulk = list_first_entry(src_list, struct mlx5_fc_bulk, pool_list);
-	fc = mlx5_fc_bulk_acquire_fc(bulk);
-	if (move_non_full_bulk || mlx5_fc_bulk_get_free_fcs_amount(bulk) == 0)
-		list_move(&bulk->pool_list, next_list);
-	return fc;
-}
-
-static struct mlx5_fc *
-mlx5_fc_pool_acquire_counter(struct mlx5_fc_pool *fc_pool)
-{
-	struct mlx5_fc_bulk *new_bulk;
-	struct mlx5_fc *fc;
-
-	mutex_lock(&fc_pool->pool_lock);
-
-	fc = mlx5_fc_pool_acquire_from_list(&fc_pool->partially_used,
-					    &fc_pool->fully_used, false);
-	if (IS_ERR(fc))
-		fc = mlx5_fc_pool_acquire_from_list(&fc_pool->unused,
-						    &fc_pool->partially_used,
-						    true);
-	if (IS_ERR(fc)) {
-		new_bulk = mlx5_fc_pool_alloc_new_bulk(fc_pool);
-		if (IS_ERR(new_bulk)) {
-			fc = ERR_CAST(new_bulk);
-			goto out;
-		}
-		fc = mlx5_fc_bulk_acquire_fc(new_bulk);
-		list_add(&new_bulk->pool_list, &fc_pool->partially_used);
-	}
-	fc_pool->available_fcs--;
-	fc_pool->used_fcs++;
-
-out:
-	mutex_unlock(&fc_pool->pool_lock);
-	return fc;
-}
-
-static void
-mlx5_fc_pool_release_counter(struct mlx5_fc_pool *fc_pool, struct mlx5_fc *fc)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-	struct mlx5_fc_bulk *bulk = fc->bulk;
-	int bulk_free_fcs_amount;
-
-	mutex_lock(&fc_pool->pool_lock);
-
-	if (mlx5_fc_bulk_release_fc(bulk, fc)) {
-		mlx5_core_warn(dev, "Attempted to release a counter which is not acquired\n");
-		goto unlock;
-	}
-
-	fc_pool->available_fcs++;
-	fc_pool->used_fcs--;
-
-	bulk_free_fcs_amount = mlx5_fc_bulk_get_free_fcs_amount(bulk);
-	if (bulk_free_fcs_amount == 1)
-		list_move_tail(&bulk->pool_list, &fc_pool->partially_used);
-	if (bulk_free_fcs_amount == bulk->bulk_len) {
-		list_del(&bulk->pool_list);
-		if (fc_pool->available_fcs > fc_pool->threshold)
-			mlx5_fc_pool_free_bulk(fc_pool, bulk);
-		else
-			list_add(&bulk->pool_list, &fc_pool->unused);
-	}
-
-unlock:
-	mutex_unlock(&fc_pool->pool_lock);
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
new file mode 100644
index 000000000000..b891d7b9e3e0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#include <mlx5_core.h>
+#include "fs_pool.h"
+
+int mlx5_fs_bulk_init(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk,
+		      int bulk_len)
+{
+	int i;
+
+	fs_bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), sizeof(unsigned long),
+				    GFP_KERNEL);
+	if (!fs_bulk->bitmask)
+		return -ENOMEM;
+
+	fs_bulk->bulk_len = bulk_len;
+	for (i = 0; i < bulk_len; i++)
+		set_bit(i, fs_bulk->bitmask);
+
+	return 0;
+}
+
+void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk)
+{
+	kvfree(fs_bulk->bitmask);
+}
+
+int mlx5_fs_bulk_get_free_amount(struct mlx5_fs_bulk *bulk)
+{
+	return bitmap_weight(bulk->bitmask, bulk->bulk_len);
+}
+
+static int mlx5_fs_bulk_acquire_index(struct mlx5_fs_bulk *fs_bulk,
+				      struct mlx5_fs_pool_index *pool_index)
+{
+	int free_index = find_first_bit(fs_bulk->bitmask, fs_bulk->bulk_len);
+
+	WARN_ON_ONCE(!pool_index || !fs_bulk);
+	if (free_index >= fs_bulk->bulk_len)
+		return -ENOSPC;
+
+	clear_bit(free_index, fs_bulk->bitmask);
+	pool_index->fs_bulk = fs_bulk;
+	pool_index->index = free_index;
+	return 0;
+}
+
+static int mlx5_fs_bulk_release_index(struct mlx5_fs_bulk *fs_bulk, int index)
+{
+	if (test_bit(index, fs_bulk->bitmask))
+		return -EINVAL;
+
+	set_bit(index, fs_bulk->bitmask);
+	return 0;
+}
+
+void mlx5_fs_pool_init(struct mlx5_fs_pool *pool, struct mlx5_core_dev *dev,
+		       const struct mlx5_fs_pool_ops *ops)
+{
+	WARN_ON_ONCE(!ops || !ops->bulk_destroy || !ops->bulk_create ||
+		     !ops->update_threshold);
+	pool->dev = dev;
+	mutex_init(&pool->pool_lock);
+	INIT_LIST_HEAD(&pool->fully_used);
+	INIT_LIST_HEAD(&pool->partially_used);
+	INIT_LIST_HEAD(&pool->unused);
+	pool->available_units = 0;
+	pool->used_units = 0;
+	pool->threshold = 0;
+	pool->ops = ops;
+}
+
+void mlx5_fs_pool_cleanup(struct mlx5_fs_pool *pool)
+{
+	struct mlx5_core_dev *dev = pool->dev;
+	struct mlx5_fs_bulk *bulk;
+	struct mlx5_fs_bulk *tmp;
+
+	list_for_each_entry_safe(bulk, tmp, &pool->fully_used, pool_list)
+		pool->ops->bulk_destroy(dev, bulk);
+	list_for_each_entry_safe(bulk, tmp, &pool->partially_used, pool_list)
+		pool->ops->bulk_destroy(dev, bulk);
+	list_for_each_entry_safe(bulk, tmp, &pool->unused, pool_list)
+		pool->ops->bulk_destroy(dev, bulk);
+}
+
+static struct mlx5_fs_bulk *
+mlx5_fs_pool_alloc_new_bulk(struct mlx5_fs_pool *fs_pool)
+{
+	struct mlx5_core_dev *dev = fs_pool->dev;
+	struct mlx5_fs_bulk *new_bulk;
+
+	new_bulk = fs_pool->ops->bulk_create(dev);
+	if (new_bulk)
+		fs_pool->available_units += new_bulk->bulk_len;
+	fs_pool->ops->update_threshold(fs_pool);
+	return new_bulk;
+}
+
+static void
+mlx5_fs_pool_free_bulk(struct mlx5_fs_pool *fs_pool, struct mlx5_fs_bulk *bulk)
+{
+	struct mlx5_core_dev *dev = fs_pool->dev;
+
+	fs_pool->available_units -= bulk->bulk_len;
+	fs_pool->ops->bulk_destroy(dev, bulk);
+	fs_pool->ops->update_threshold(fs_pool);
+}
+
+static int
+mlx5_fs_pool_acquire_from_list(struct list_head *src_list,
+			       struct list_head *next_list,
+			       bool move_non_full_bulk,
+			       struct mlx5_fs_pool_index *pool_index)
+{
+	struct mlx5_fs_bulk *fs_bulk;
+	int err;
+
+	if (list_empty(src_list))
+		return -ENODATA;
+
+	fs_bulk = list_first_entry(src_list, struct mlx5_fs_bulk, pool_list);
+	err = mlx5_fs_bulk_acquire_index(fs_bulk, pool_index);
+	if (move_non_full_bulk || mlx5_fs_bulk_get_free_amount(fs_bulk) == 0)
+		list_move(&fs_bulk->pool_list, next_list);
+	return err;
+}
+
+int mlx5_fs_pool_acquire_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index)
+{
+	struct mlx5_fs_bulk *new_bulk;
+	int err;
+
+	mutex_lock(&fs_pool->pool_lock);
+
+	err = mlx5_fs_pool_acquire_from_list(&fs_pool->partially_used,
+					     &fs_pool->fully_used, false,
+					     pool_index);
+	if (err)
+		err = mlx5_fs_pool_acquire_from_list(&fs_pool->unused,
+						     &fs_pool->partially_used,
+						     true, pool_index);
+	if (err) {
+		new_bulk = mlx5_fs_pool_alloc_new_bulk(fs_pool);
+		if (!new_bulk) {
+			err = -ENOENT;
+			goto out;
+		}
+		err = mlx5_fs_bulk_acquire_index(new_bulk, pool_index);
+		WARN_ON_ONCE(err);
+		list_add(&new_bulk->pool_list, &fs_pool->partially_used);
+	}
+	fs_pool->available_units--;
+	fs_pool->used_units++;
+
+out:
+	mutex_unlock(&fs_pool->pool_lock);
+	return err;
+}
+
+int mlx5_fs_pool_release_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index)
+{
+	struct mlx5_fs_bulk *bulk = pool_index->fs_bulk;
+	int bulk_free_amount;
+	int err;
+
+	mutex_lock(&fs_pool->pool_lock);
+
+	/* TBD would rather return void if there was no warn here in original code */
+	err = mlx5_fs_bulk_release_index(bulk, pool_index->index);
+	if (err)
+		goto unlock;
+
+	fs_pool->available_units++;
+	fs_pool->used_units--;
+
+	bulk_free_amount = mlx5_fs_bulk_get_free_amount(bulk);
+	if (bulk_free_amount == 1)
+		list_move_tail(&bulk->pool_list, &fs_pool->partially_used);
+	if (bulk_free_amount == bulk->bulk_len) {
+		list_del(&bulk->pool_list);
+		if (fs_pool->available_units > fs_pool->threshold)
+			mlx5_fs_pool_free_bulk(fs_pool, bulk);
+		else
+			list_add(&bulk->pool_list, &fs_pool->unused);
+	}
+
+unlock:
+	mutex_unlock(&fs_pool->pool_lock);
+	return err;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
new file mode 100644
index 000000000000..3b149863260c
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#ifndef __MLX5_FS_POOL_H__
+#define __MLX5_FS_POOL_H__
+
+#include <linux/mlx5/driver.h>
+
+struct mlx5_fs_bulk {
+	struct list_head pool_list;
+	int bulk_len;
+	unsigned long *bitmask;
+};
+
+struct mlx5_fs_pool_index {
+	struct mlx5_fs_bulk *fs_bulk;
+	int index;
+};
+
+struct mlx5_fs_pool;
+
+struct mlx5_fs_pool_ops {
+	int (*bulk_destroy)(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *bulk);
+	struct mlx5_fs_bulk * (*bulk_create)(struct mlx5_core_dev *dev);
+	void (*update_threshold)(struct mlx5_fs_pool *pool);
+};
+
+struct mlx5_fs_pool {
+	struct mlx5_core_dev *dev;
+	void *pool_ctx;
+	const struct mlx5_fs_pool_ops *ops;
+	struct mutex pool_lock; /* protects pool lists */
+	struct list_head fully_used;
+	struct list_head partially_used;
+	struct list_head unused;
+	int available_units;
+	int used_units;
+	int threshold;
+};
+
+int mlx5_fs_bulk_init(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk,
+		      int bulk_len);
+void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk);
+int mlx5_fs_bulk_get_free_amount(struct mlx5_fs_bulk *bulk);
+
+void mlx5_fs_pool_init(struct mlx5_fs_pool *pool, struct mlx5_core_dev *dev,
+		       const struct mlx5_fs_pool_ops *ops);
+void mlx5_fs_pool_cleanup(struct mlx5_fs_pool *pool);
+int mlx5_fs_pool_acquire_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index);
+int mlx5_fs_pool_release_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index);
+
+#endif /* __MLX5_FS_POOL_H__ */
-- 
2.44.0


