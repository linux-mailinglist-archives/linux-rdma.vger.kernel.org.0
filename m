Return-Path: <linux-rdma+bounces-7710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A82A33B99
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52D5166ECA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69243211283;
	Thu, 13 Feb 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftoqun3d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F202139D4;
	Thu, 13 Feb 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440075; cv=fail; b=Y4DroGGB2DDudskWHMGodZpAH+/MDmp+CGiJNAzbK+DEZh3c+lupG83Bw2zLzWVMoi/ofmpiCgKDl/jsVFJ4iI8+1B3xpMyCfirAFU5k1PnDbIskIBlsSCRfUbOVOd/a74B6vs7w4ZmYzXdg/yJdJvafwmWvXnR6NceMDb7JxAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440075; c=relaxed/simple;
	bh=ojH3kDt/x9OMIIeopi/QGgnpp5J3dnOue2iL8F09zj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mdms8iUkOjAMGAbFtTKwt1a7w9anP64X5EKzmhPUDMjTO87QV0wgHbnVr6ui6iNCeO9J70xk5c1gX4g7xo+HFQiDuLs0Unn6XyxtB/4c0G9CKFkzm/9x7Ctf3o1wxop1fBB/qfPKeyt/++SWr1J9QUA17kZZ0wvXvWKHxthIuHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftoqun3d; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsTdoZTPgpTcWqsCM9ItOR22wasTOrlmWsBQrl6TlrPoqcXGNs8z5DhpezU9UkZWuCRYF487LzgEFY5FosylTOSB+MMe/f19oEDTBayplgH0xT8ATmzaGy8Orp4wVm5tm48Yux+pt+ggt4V5HuUssmromXE69gYQVOq2ViOa+KPaN4Vgithkank8bapPAk4xIz3XWV87ZHJfxxZLFgi35RQQLzxZTMrXKgctFAWNhO/na1IgZFZVYYT+vuMr9IxIWhR/pvYnnFpCNebv0pAScIAQKIV+Z4eiEO8l28FNaMe1HCX7hTIZUHYpiD/Mq07yT30pNxnoZ4lDpQeBUEKR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NChtB7tIgdawyIjOxj86hLZyW4z0T8d4IWYLMqntPnU=;
 b=afn/ReoQaXhj9EyP68ND4yYkMJRcnDPpx0M8AtMz8CEAX5z9TzTltumi7OQOGm7l0QbCryJHdK7eyUEq5vnK4nThIyALoYj99gWctHueRRIlclZ/AMwWi3V6uavcr1Jeqq37bHhvvrAWj9u+jXXJDkTlLWMKj8tYKDfx3TOuV3Vu/1Aq7LAHImjGN3W9jvjMZ/8KlxdVZqzPdCsvGeIXFxGYwwaLigRoOjFer6jvK9wKxpwzKd8Wllpj4/CM9zk/0DDFPvqMWrS8En11ipZhd2xy8A0DfkOeOMXeJSeImlXUUIBUa9PcSrT4DIb6q+iN3uOI2bgAFea6KK5egFVq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NChtB7tIgdawyIjOxj86hLZyW4z0T8d4IWYLMqntPnU=;
 b=ftoqun3d7XLLIhI6PCDl112Vi8PEYcy2CmfZB9/URNOEF3mN2rmQx5NODeJoyP4Oezi+bRMFmSd9fx42JUT4lmUgt2CoaGSxRVwgyuo2y4VX0CflN2Ix1h6fvrNN0kRHJCd2nf1e3r5mdibmRvnttnrCPZ+xydP++VF0pF9lrZEJTDqQR4xF58N1KgY68yaY2bqf1n3q3Ou0rVXxtP1T/fOp4bdcbvCRZeuk9Bto53hoG85X3sEzCFHuk/GiIUxFOdbC76qwKPVR7S3Cl1EJCKW6iIR/aZDZwAvkq0/qYRUIos8mGvG7KcMuXWOi5YcVeV6SCraev2sCCMiB/pfbLg==
Received: from BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) by IA1PR12MB7544.namprd12.prod.outlook.com
 (2603:10b6:208:42c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 09:47:49 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2a01:111:f403:f900::2) by BL6PEPF00016415.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 13 Feb 2025 09:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:47:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 01:47:36 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 01:47:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 01:47:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 4/4] net/mlx5: Add sensor name to temperature event message
Date: Thu, 13 Feb 2025 11:46:41 +0200
Message-ID: <20250213094641.226501-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213094641.226501-1-tariqt@nvidia.com>
References: <20250213094641.226501-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fc5d6a-0184-424a-8ecb-08dd4c1379bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6YNwk61GLUuB2d8uXu7tDVTvlz/EvEGiPjGS5gaxZ8vcTEybcFtLWcROe6I?=
 =?us-ascii?Q?iMyE2uTQm+z3CFY4cpwUCdK9NT1emSKayLTeWTM0Ve1PVo2Sk/OfOgow4OOp?=
 =?us-ascii?Q?sBgJT3AfaAkLemCug0miIiE5y+L19qUqnZT+AjFfPZTgpG1cn+IRDu9fa4ri?=
 =?us-ascii?Q?Jn5na9rjBFuRmPXx3gktkSoEOGxgq+IcL25Q4K1hhCBz+HPw4ZQYvJ9kjuKI?=
 =?us-ascii?Q?eTpKGzcOlYGfbtn5MtIW38MOp+3+tpJyrR5/VA2yBTIab9Zejq28+JEyi/WD?=
 =?us-ascii?Q?gFViOFHQvFI5MYSZVDBFhpGTNXYKxiPriP9u1crZ9UeQpbq7BRmYn9TeEUP4?=
 =?us-ascii?Q?/Fv4NLRcL6S7bNBpf+sZ9ZMJeB6Jthu+r98stuLzDKPwaqDqd9B+snfFkFFe?=
 =?us-ascii?Q?epJXs2zYwHUdYqVOV4Kc5kQYQ8xVIUkuyiZNKO9s9810cJJutBdbqMZiLP2W?=
 =?us-ascii?Q?O+QIf/PHOQowczoWzeuZnXr2lTDosRP2JQECsGoav7ICIkWpk+daj5PzdLm9?=
 =?us-ascii?Q?6TMi7enf/psT6NBuv5nFSuw0YhKkJeSpVI8TONNBR34bK+ynem2MR/dqpDQn?=
 =?us-ascii?Q?5Gw0VhNyGN9RfVsSu7bXQSHwzRkTDccWnykv7TUErrSFhsWIUXkj5urBZQLo?=
 =?us-ascii?Q?hyAm7dlhrPLuhdM9ECeVP3I34+zNWsczmtRh3CI8jEx7OW7k4V9hcjIJcYPe?=
 =?us-ascii?Q?PQS1rRYZp9+XR5BFRxjpfeQk4nbiTt5swMbxrntK/OlyqaT1RCs6Kv5bHqch?=
 =?us-ascii?Q?VDdpqZ0QRJLB5EtRReWJCEaZmYoXcGzBso34qFvcSdy73KWiyLU1dq9aVnfs?=
 =?us-ascii?Q?ip0LHIeic2GJ3hl8nBS8wF9NwmXSfvgBrwKNSjuIkM3zWrVsje080s2/PKWo?=
 =?us-ascii?Q?klTNhcT+RN+j40d72+SmZqXMd84lk91ziFyrSC2/MNluq3leO4B9vbJHudgo?=
 =?us-ascii?Q?9e8SF6B6UzXwAtk5MaJvICb0QEx2xF4l0CKExHoaL7L+/4kMENcFj1Retl8c?=
 =?us-ascii?Q?L18oNZBMThHH7X3z/cONMy+8QUV5kfgcp8uPMUmER7l/ppZxBwReWOzy8/O+?=
 =?us-ascii?Q?V0XYTp1DMBKHYEqkJJ+SkNS6P0VD1yaucSTlR7XJ3aTMHBeBt6EYHIxFZoAv?=
 =?us-ascii?Q?/0MRxnM2kEJWOiZmKI8k3vIJ7oHESb1ktJAIFyrzpa+YK4fSz5YaHWuNvJvK?=
 =?us-ascii?Q?MMmbxa/e6SUShQ/SnGmbUk2X73vKBonYyBNNLDUwv1FO6yJJPipPsm7GIP22?=
 =?us-ascii?Q?9zf7MlpXvwyciDSTdvpxy5NvABCpdm71hOA/bb4dHo7KLiUKRhmSHTPnSy4i?=
 =?us-ascii?Q?VzsAyKt5ULOq+D961buf7EHsHJy17BUTQ2THgGw4ABJ8oYsSGhaaV1Bog4Kl?=
 =?us-ascii?Q?CGbgK4Uq1nKp6L2qZwHsnWs21M7VF9dWnboAyuwceFVq0x3AxbawCLTmWNgA?=
 =?us-ascii?Q?KWOTm2FFmdiHEGgXWU0wGelog0138zMnD+odV+VYcLHixluaBf5//d+5nMYF?=
 =?us-ascii?Q?sNNi4JQ7B0Dm6hw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:47:48.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fc5d6a-0184-424a-8ecb-08dd4c1379bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

From: Shahar Shitrit <shshitrit@nvidia.com>

Previously, a temperature event message included a bitmap indicating
which sensors detect high temperatures.

To enhance clarity, we modify the message format to explicitly list
the names of the overheating sensors, alongside the sensors bitmap.
If HWMON is not configured, the event message remains unchanged.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/events.c  | 31 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/hwmon.c   |  5 +++
 .../net/ethernet/mellanox/mlx5/core/hwmon.h   |  1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index e85a9042e3c2..01c5f5990f9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -6,6 +6,7 @@
 #include "mlx5_core.h"
 #include "lib/eq.h"
 #include "lib/events.h"
+#include "hwmon.h"
 
 struct mlx5_event_nb {
 	struct mlx5_nb  nb;
@@ -153,11 +154,28 @@ static int any_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+#if IS_ENABLED(CONFIG_HWMON)
+static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev, struct mlx5_hwmon *hwmon,
+					  u64 bit_set, int bit_set_offset)
+{
+	unsigned long *bit_set_ptr = (unsigned long *)&bit_set;
+	int num_bits = sizeof(bit_set) * BITS_PER_BYTE;
+	int i;
+
+	for_each_set_bit(i, bit_set_ptr, num_bits) {
+		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
+
+		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
+	}
+}
+#endif /* CONFIG_HWMON */
+
 /* type == MLX5_EVENT_TYPE_TEMP_WARN_EVENT */
 static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 {
 	struct mlx5_event_nb *event_nb = mlx5_nb_cof(nb, struct mlx5_event_nb, nb);
 	struct mlx5_events   *events   = event_nb->ctx;
+	struct mlx5_core_dev *dev      = events->dev;
 	struct mlx5_eqe      *eqe      = data;
 	u64 value_lsb;
 	u64 value_msb;
@@ -169,10 +187,17 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	if (net_ratelimit())
-		mlx5_core_warn(events->dev,
-			       "High temperature on sensors with bit set %#llx %#llx",
+	if (net_ratelimit()) {
+		mlx5_core_warn(dev, "High temperature on sensors with bit set %#llx %#llx.\n",
 			       value_msb, value_lsb);
+#if IS_ENABLED(CONFIG_HWMON)
+		if (dev->hwmon) {
+			print_sensor_names_in_bit_set(dev, dev->hwmon, value_lsb, 0);
+			print_sensor_names_in_bit_set(dev, dev->hwmon, value_msb,
+						      sizeof(value_lsb) * BITS_PER_BYTE);
+		}
+#endif
+	}
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
index 353f81dccd1c..4ba2636d7fb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
@@ -416,3 +416,8 @@ void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
 	mlx5_hwmon_free(hwmon);
 	mdev->hwmon = NULL;
 }
+
+const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel)
+{
+	return hwmon->temp_channel_desc[channel].sensor_name;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
index 999654a9b9da..f38271c22c10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
@@ -10,6 +10,7 @@
 
 int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev);
 void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev);
+const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel);
 
 #else
 static inline int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)
-- 
2.45.0


