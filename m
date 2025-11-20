Return-Path: <linux-rdma+bounces-14646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3A5C741FD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2E77C2AE17
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2E33EB0D;
	Thu, 20 Nov 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/vNCyNX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59433EB0A;
	Thu, 20 Nov 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644475; cv=fail; b=uuCY5TRGToYD5zfYh5KH9+AQkJGEyc5YqZRfORtt9TVAbmKqBtURE2JfN8lRsKkyBVDSNe636YO8i3Goebrvl74ZZZMvPqZTpZ1BiI+07HDSJug+ylewV4eUx5B+5ywSmorPeMyJnNDh0jjftVF7cbooac/gvrRkjm7vc9gWqcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644475; c=relaxed/simple;
	bh=6IcInnTRJCj0yAcET5rTQb1VR06ZxyPT/b1zQWPLppI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4Y5IOz9d+SlfmqDQwCPc+F2k1K3tkwZtqow4W+zoywcFc4GjpHm0G/Jst+Aud1MuVZpQCfAdh8y5bIDSQ8g0miMYTczjolforKGgCrJwApLUIhCx7z0nBibhvjnJc1CBhz2oFUE9LT/Is/mwMw9M5pCJl9eIhtkbWPOY3YlB+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/vNCyNX; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty7t31nvHCNv+c81gnjIZT8s7YM9MuVZ4wM9UlA5foNQ4XAitcwPF/dzg5U7aZk+D3NxcFZfxXNBSdhWpdrYpWoent1wZ4UsTu/oWH+lGI6N9sJ7eft/nm+WK47e6EUqJonklaM8bhNdSVv0dcgKx4Gx200g3jUgE+xElCaL+lCP2h52oSTCRnoOBYUxYabNLLZgrvyypYwF/6GXs5EmBV/mNIw8rNFXGLN+cXy2rp5QqwTLlnQFoeFfOQQiL+7uiA0nQyNPputcpMCsSyCwltccNPW7PEnrvQh0aX+UbdCSbETeJTjGVTkNV3g/bALYm/kW5eVbUGfNDjJTN/KXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=jMZHHFjGeVKWxoZnD9+HrxFp1bsX91S+pRZxRRMKigc/Ol2QR8p2EaBy+t6PZ0NEc4uQRbkW+o8g9yKuSfz3pk70Ugtdc/pu1g8vzgtCAPTOU5ZwBo4b62FM5SMZXquPqktgzd9d5I4WLyxBtA5RauKevTkYJwF4cRKMfeafYDSGT3C4lSFULb6/p7DTqjkVDL5lOKb7JGUR4r370pp7hEJBA8ym6C3LFTnEtGOXA7BwAtygAZuyRiNRap96StvEgiNKnONH9qwHx9OBS/M7J/WN8qejsbfelWYj+2L8J5767smazU/N+YtbcKTuBE8tf1V6zYRCNYhvUSPm4//2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=a/vNCyNXwEVoinv6tgFel479xS2EZsd2mRWFcvKX4KLDbBoZE/cYlVlN9YTkx5635FZOBNkAggri6kVpO9q1psrTI8HwILdVRbms6zB6U3UHxUAWU2iS24Luuq0C5G8tD5kUs4Ed1qPI76DhsZdFOjeaiI1qt/QWQrHDCIlqCmfXbB4qFba2B5GHCDIj2GK42YFXdI18Rdp9rmLfBpryP+TaP/vws3d9UtdXlF52xBUmH4Ji+8tCS7lDPsazKrRoUY70LAkWMUcytFs3X7DCCU1I3u+EASuHGgrRvwuQ44NJL7ZS2o2ozH63/2IGPBCImO6BiwUTTWiPk9b7hxs7MA==
Received: from BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::8)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:14:25 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::ad) by BL1P223CA0033.outlook.office365.com
 (2603:10b6:208:5b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:14:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 09/14] net/mlx5: Introduce shared devlink instance for PFs on same chip
Date: Thu, 20 Nov 2025 15:09:21 +0200
Message-ID: <1763644166-1250608-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 8015dcb2-4f42-4e09-4293-08de2836ba8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|30052699003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Odnd4Du+dnXeZT6LezDqG4xueTCIQFvdrFW9k4az5dh37maimrZ7HKpogx1n?=
 =?us-ascii?Q?JHeX2qT7F/5KFEd9yW/jnXMtZQVOUKB6KmbqwIbw2aiUa7CZTr9U4n9uABga?=
 =?us-ascii?Q?JAyswtwlQ4WAShtHwa0VaEMx7NoU6BeDkJHBf0j07sNcH6sMLgtH9CxFGgH1?=
 =?us-ascii?Q?lC6IjsTpfH5f+zSkuKrlTFfBk5p3RrEVc/8czX3Go84dwGvnSkicODZOo4AB?=
 =?us-ascii?Q?eZ8ix45eoKcM8CurIHvNfvC33DNsmncNPs61ZHcfIxmRyTfRR0+Cua8ERb56?=
 =?us-ascii?Q?hPFpvG28oQvIZsoMzmrngV7GWOV0+9nkWxcexox3k0Zpv19YLkyFfJsUovrF?=
 =?us-ascii?Q?9q6xr1bg1YtwFapqBSBHGZO2U9vH421n27z+wWYgqAFy2T8G0L20cNgSL0LR?=
 =?us-ascii?Q?7ItGOc0ZaMhkfsqJNQjbvrmWCZYcXJSfpXRbyKsAtYPw2CH0Er6lXqQvbaZg?=
 =?us-ascii?Q?tWHcNZe5DkKUpQnJkLoZRbs2A7lR6k6Ip+Y3xUvYkPIweKzlOlYOZhwozUV9?=
 =?us-ascii?Q?n1evzEO4IEIvzhXn+CztLhbQRLqdFTDYJ5lJ/t8sk+XXO+6EYjEMbZ2ABeH5?=
 =?us-ascii?Q?P82WmfGTcrPvqnwhP79bGIW7+y/FcQV+rsm3tn4xxKGfer4XiqmqVxE4a2xr?=
 =?us-ascii?Q?I9EVqeUKA2tFzWdZ7vkk/xB0E7LkVclaCS91viTcP+q0e4cY/3RlYDBio1g0?=
 =?us-ascii?Q?7dkkZC8v76UwwzPuq1z8zcVyqXLxo6Xqxf1KoUlM8OjbT3FdZItsTxl9UK9Z?=
 =?us-ascii?Q?/+6E3pNUcMxQt13Tcww0Y5Rz2LrdGL2hktBxV6gkI4z4FRs1X0OAeXa0QWj1?=
 =?us-ascii?Q?dJtb3kWsgV38fcFw14LEzmxxPBQ+mdNq5e9W9tgvxkPBT4HUYA++dO1Jw1l2?=
 =?us-ascii?Q?BtC1GaLbnZmQaKmL/JKCPU/StqWMZtLhQOX3Xoko30mZG+tLGKGMe1dWgZ0d?=
 =?us-ascii?Q?eA20G0/WMRYmFHyLJ7EnB2gqh04YtDshEVfyO5kBWw595QMON6bRXqZ18zs4?=
 =?us-ascii?Q?bkGKoABzXYlhaYYQsRv3D+znSKUzUCCg9ZylLnzOC6LpCOVmfAIk0zyWGVO1?=
 =?us-ascii?Q?QgMcVutFsdsd+ckTzn5kExtDBdQVELoXW4/LRbqXoZLL99dsttQx5vu1jlIl?=
 =?us-ascii?Q?3LHyXnc3Sjqg++QqdZBWbo207r+ygJZz0mhAEOWlSHmkTr4thZlyUUGJHBBr?=
 =?us-ascii?Q?r74ROrx+KDEcFtI4lqIVM48uVI7Q/7TImtBbTo2n27lOinVf68GP5P5TBVma?=
 =?us-ascii?Q?t8Tv190qww65+ojcD+UnDO58LkRVFLQf3qvdN/7IADD714zM3jPGjGwhQ/a8?=
 =?us-ascii?Q?QWK39LWyGpsPxG1x+j0HausEmfO6T6cZJAeNiGmeSYnqcJPBgu726rx9C6So?=
 =?us-ascii?Q?G76eEL/Kyg69q1/gjbL3u/cE/nMwOptFghSnf2wcUgnDGZKSWeOho15kgoC9?=
 =?us-ascii?Q?aer0vl1G4xBoqZyZUTVv8kuDkaDTLg7+fBYZzkzCq6GjiPGj4dmc5U/AKQ61?=
 =?us-ascii?Q?TmpWwRUonPnYf6XCPiEJMiz9jcPT9dpvMBwydBWR/ZxzYf20k7XepvqMw7X+?=
 =?us-ascii?Q?fjDWPykF+udPiHl4I1c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(30052699003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:25.4448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8015dcb2-4f42-4e09-4293-08de2836ba8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is not good object to pin the configuration
knobs on.

Introduce a shared devlink, instantiated upon probe of the first PF,
removed during remove of the last PF. Back this shared devlink instance
by faux device, as there is no PCI device related to it.

Make the PF devlink instances nested in this shared devlink instance.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  18 ++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 166 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  13 ++
 include/linux/mlx5/driver.h                   |   5 +
 5 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 8ffa286a18f5..d39fe9c4a87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 024339ce41f1..a8a285917688 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,17 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(priv_to_devlink(dev->shd),
+					      devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -2015,6 +2023,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2026,6 +2041,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2047,6 +2064,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..e39a5e20e102
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <linux/mlx5/driver.h>
+#include <linux/mlx5/vport.h>
+
+#include "sh_devlink.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created for PF group of the same chip.
+ */
+struct mlx5_shd {
+	/* Node in shd list */
+	struct list_head list;
+	/* Serial number of the chip */
+	const char *sn;
+	/* List of per-PF dev instances */
+	struct list_head dev_list;
+	/* Related faux device */
+	struct faux_device *faux_dev;
+};
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
+{
+	struct devlink *devlink;
+	struct mlx5_shd *shd;
+
+	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
+				&faux_dev->dev);
+	if (!devlink)
+		return -ENOMEM;
+	shd = devlink_priv(devlink);
+	faux_device_set_drvdata(faux_dev, shd);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+	return 0;
+}
+
+static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
+{
+	struct mlx5_shd *shd = faux_device_get_drvdata(faux_dev);
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	devlink_free(devlink);
+}
+
+static const struct faux_device_ops mlx5_shd_faux_ops = {
+	.probe = mlx5_shd_faux_probe,
+	.remove = mlx5_shd_faux_remove,
+};
+
+static struct mlx5_shd *mlx5_shd_create(const char *sn)
+{
+	struct faux_device *faux_dev;
+	struct mlx5_shd *shd;
+
+	faux_dev = faux_device_create(sn, NULL, &mlx5_shd_faux_ops);
+	if (!faux_dev)
+		return NULL;
+	shd = faux_device_get_drvdata(faux_dev);
+	if (!shd)
+		return NULL;
+	list_add_tail(&shd->list, &shd_list);
+	shd->sn = sn;
+	INIT_LIST_HEAD(&shd->dev_list);
+	shd->faux_dev = faux_dev;
+	return shd;
+}
+
+static void mlx5_shd_destroy(struct mlx5_shd *shd)
+{
+	list_del(&shd->list);
+	kfree(shd->sn);
+	faux_device_destroy(shd->faux_dev);
+}
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct mlx5_shd *shd;
+	const char *sn;
+	char *end;
+	int start;
+	int err;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
+		if (start < 0)
+			return -ENOENT;
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn)
+		return -ENOMEM;
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	guard(mutex)(&shd_mutex);
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->sn, sn)) {
+			kfree(sn);
+			goto found;
+		}
+	}
+	shd = mlx5_shd_create(sn);
+	if (!shd) {
+		kfree(sn);
+		return -ENOMEM;
+	}
+found:
+	list_add_tail(&dev->shd_list, &shd->dev_list);
+	dev->shd = shd;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	struct mlx5_shd *shd = dev->shd;
+
+	if (!dev->shd)
+		return;
+
+	guard(mutex)(&shd_mutex);
+	list_del(&dev->shd_list);
+	if (list_empty(&shd->dev_list))
+		mlx5_shd_destroy(shd);
+}
+
+void mlx5_shd_lock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+	devl_lock(priv_to_devlink(dev->shd));
+}
+
+void mlx5_shd_unlock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+	devl_unlock(priv_to_devlink(dev->shd));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..54ce0389cfea
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+void mlx5_shd_lock(struct mlx5_core_dev *dev);
+void mlx5_shd_unlock(struct mlx5_core_dev *dev);
+void mlx5_shd_nested_set(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1c54aa6f74fb..29fd4dff1cd1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -735,6 +735,8 @@ enum mlx5_wc_state {
 	MLX5_WC_STATE_SUPPORTED,
 };
 
+struct mlx5_shd;
+
 struct mlx5_core_dev {
 	struct device *device;
 	enum mlx5_coredev_type coredev_type;
@@ -798,6 +800,9 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	/* node in shared devlink list */
+	struct list_head shd_list;
+	struct mlx5_shd *shd;
 };
 
 struct mlx5_db {
-- 
2.31.1


