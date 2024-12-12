Return-Path: <linux-rdma+bounces-6490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956239EFF13
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D029287C8C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795F1DE2CB;
	Thu, 12 Dec 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RsEyIq/U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9471D9A79;
	Thu, 12 Dec 2024 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041720; cv=fail; b=oOSF+fFO16rr4VQZ+jCR/s3yZDFaWiWJwAtszaAgEm1mV88NTC5qUgjw8KX861CnL9wW/x4LkOzluPUFSaI7wVfSKJ3UBiHQXWBRpgptbO7JRFBBuexupZ6fvIERpNzNAA8aiL4esYT9OXcusD+1Ol4qi5MU5bubuvLDgosYXG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041720; c=relaxed/simple;
	bh=XEqtPLe7Gg0fW07J+l+BO4sY00AZ2RVEo9TqN/TLpYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4z6gWdcohF1zClrxdiHgoJvuNR9hweZtY4iBD+MwsC09nm8ThqjJXHoCj+hHlOIFzxYC1ulTu960Kn08+CZwxI/UuIkgXh+UvOqAZzQTJpd4ayF8NCXoZ6dRy4HBI3qjrGTsTGWqhUNOlg8lQYCQJvKeDdie1YrmUIUEjBmA7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RsEyIq/U; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2WNWCkJJAF7PBSAuO0Y9yacSvi2pQ0UxhI3tR4J47Ohis5lGanKpgc7e/qDrrAx25oWRspisVvRR0AZxLAhsfW//zqGdn4tO1nXURNykRe96qZNYI2eAvSxVpu3/FaXohDZfRi6E8mL6m8ordmtkr/xiDvkXWUPR+b3+SOrbmDFcfWcuHr8S6fgz1fPof/vYUxDgfz5la+DqrNuzdKnPQEfubb/iGoloKsZ03sGR9+PcFdwuAF5Bbvd2L41guAXMdfTkpNGk5cOFE1+ylzM4bBTp1P59AvtcXIIxWO0frf5ZXZDxUzPPpOPCuw3xCByQrZ8FLsSgo298nYeDbC3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoOlDCrv2inFmLx+EiKmh5OvwdWotJsYbks6hDkNMv4=;
 b=BvQREJAktTzUVPMUh5ralG+dH0xakPS71y0dNSY4Q+cq/RY771E/OSM5704geMgjJgZDrZVxkHK7tP2lCTiQmr3D83gmihs71BcMhVndUUmZjQg1znQHqpnmYA9/JBPo7uivTu8hKlb5S0Sw+jmA69lUujEQkbmGjzT3wJO7KrqDTbZCtAY7mq2yzYqcw2LdZ8cy4jKzFo6DBKyJXsGvcHLb/+aaKldmsNvNEbgxvRisx6k1H8+1mItodqHQh6iXpIEM4ZIc0mFrlDgKVzYnSqbu25A+FCxfTPcBZ00kCC70wL/N+AwKZQuxKkjYX6mos8Q5qCNojwsrt6+0BjgsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoOlDCrv2inFmLx+EiKmh5OvwdWotJsYbks6hDkNMv4=;
 b=RsEyIq/Uwvn9gTcAVsy1WM7uCWdI8d7KaJt32T5T48VcFFccdCdiJPO4J7Cghm5HBJ74sdlueCbFLvHaYq6FuWJj8UITcYc6tniG6fgvohihlxElD6MJVo0iN6ZHxFajNlPF+C/v6lhKyiGb+9/WnlRje55c99s9OnUvN8tQ76WNRoFRuhKJaGfGtgt7O07wOd1S49pqNtx+ZD1KMXX8tKkIi+AzixM8y9fuTFWONdStrXksgqeThxDn/tjF2Z2z6sZpAcqk7cDVMgH4EBhvjqLQpGy6jAgl354mdCQ4I7l7kGcwyCI7RoIg8SGf0lLdd83jKkz4rfVQQhBYOrupBw==
Received: from MN2PR22CA0013.namprd22.prod.outlook.com (2603:10b6:208:238::18)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 22:15:07 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::90) by MN2PR22CA0013.outlook.office365.com
 (2603:10b6:208:238::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 22:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:14:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:14:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:14:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Rongwei Liu
	<rongweil@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 02/10] net/mlx5: LAG, Refactor lag logic
Date: Fri, 13 Dec 2024 00:13:21 +0200
Message-ID: <20241212221329.961628-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0cab78-e9cb-40cc-87b8-08dd1afa6f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/tf7PThw+5iddzlcSusXGoP+UWz5TcJ4W17UafZy2zWHvDt/Aj4oOhtCK4PG?=
 =?us-ascii?Q?FITVoUNpDsj28+weNTk1IfNk7oh57KmhZUC8slMP5J0HrtBYQj3oLhmUwXAb?=
 =?us-ascii?Q?shxTTMCb4pDRp4+xacaST4YiBVQAnATae8pzsDDvxKKGhe3gtH8m/+qodUnB?=
 =?us-ascii?Q?yxt17T67vaWAn5ppmL+smEgtUk7mgxsPk6Gyj1vF1uwO5qZ4i/zn+llzLReQ?=
 =?us-ascii?Q?7yxLP6tkGV1jlXJ3EFfY1Hnv/Hz0QO39QFbKCRn8n6YXQ9P0QCeIvOeUXV46?=
 =?us-ascii?Q?l1Z6aH7W1OcqN//TST57ZUqkdNCK/3c12YCUVOS+UHA3eNW0ftyeajNUSV6O?=
 =?us-ascii?Q?+MClw2wcEO7htCstA+LxDozjig0NHwM5gT6VLktzSIUSHIa2im0+nPR+JqPS?=
 =?us-ascii?Q?JPmE9MmqFTGPKu+yYP3wLu7xyNl+M8H1NRicdk9Kik6/9ciaz3MIrLbeclGD?=
 =?us-ascii?Q?NfUuE7tQXUsnD8pSZS5f/ZGeSo/j55IuuNyqElwpUmFyEHo9P4Jx+Sxlk6C4?=
 =?us-ascii?Q?RAcGzFCxa5oPVQbIRbc/nWckOue50FsyGhVZkxR2x9llkSgD9qzdttoSYZ2W?=
 =?us-ascii?Q?oQI0Q089vXoREjT/rUrOcfDUGdYSsKat4w26FNepgiKA2NSNVgl12R4baCyg?=
 =?us-ascii?Q?PSaV2vEpFOYF4p3+3TtQqz03UEtVNHcDsYvPrzLhTcbPljLDfbcsWn2vEP3j?=
 =?us-ascii?Q?R9gmpPAfO2vyqaE1PYFAGgOU5CBcOr3dNXtMOW+35aFPmbWx4NbpTr3j9UQ/?=
 =?us-ascii?Q?ZTWaf87oppE5j3n6As/K+lsYiLsrQ0X4QV0Pv/K1N+T034jcSoHzrOljtF10?=
 =?us-ascii?Q?Ya6x5vyd2Fg7YfxIpJiFSoio1zwdrNiy88GxTFwAyJtEuHYkTxe/SHmd6TR+?=
 =?us-ascii?Q?zBPLUaQcL8q5ArzswXQbFA8oZ41u8qgTzHaCBFjwa+kvkWQX+coOqi7krTj+?=
 =?us-ascii?Q?75wr6PeEouZiAxOTqfar8/dwEby5xLdcazTEWsNZG4Ut5Z6TdZnnlnXPri2m?=
 =?us-ascii?Q?C11WIV0uh/8JLGWuDOJu5lsgzPOzgHFIDcCmJZ9jRnw5LmJaplRnzVjiT+j9?=
 =?us-ascii?Q?KU+A6/rf0Y7z8WcHj0LE+XYnucjPPZiQpBSXLURwuxx+Nq5CZBIBBmJyAsg2?=
 =?us-ascii?Q?QpTbibpr8frNKoweBaFTZ9ZB8L1NcAnUfmGcT49EwpEOt1wXbAxm7FX/zciv?=
 =?us-ascii?Q?BQBoSk5xr9trevPz4S9eYrT/HNC/fhHI5HvEiJEgaoCNlRTRWgUzYyvSM5ym?=
 =?us-ascii?Q?A6EznfwCOi744K6GmK+wHah5ZWQxMeVfBxU29XI589MuMCenlNDbcX594gdT?=
 =?us-ascii?Q?E/9NXArX1tQ2eAvIxDWGsFrqDlkkHWLH8dfLdv7z+YOh2FC1rY6p/5fLYXcL?=
 =?us-ascii?Q?E5WG3daik2AbiBA5EmLI0vVH9aXoR6lTkW5ztGYU1Vs1xAof3Fh3sSRSrcNY?=
 =?us-ascii?Q?SNijCUT40st/FHSCQ+MocA1oJQ56eKKe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:06.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0cab78-e9cb-40cc-87b8-08dd1afa6f5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

From: Rongwei Liu <rongweil@nvidia.com>

Wrap the lag pf access into two new macros:
1. ldev_for_each()
2. ldev_for_each_reverse()
The maximum number of lag ports and the index to `natvie_port_num`
mapping will be handled by the two new macros.
Users shouldn't use the for loop anymore.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |  13 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 181 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  14 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  24 ++-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  10 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  16 +-
 6 files changed, 137 insertions(+), 121 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
index f4b777d4e108..798fb414d932 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
@@ -105,20 +105,20 @@ static int mapping_show(struct seq_file *file, void *priv)
 	struct mlx5_lag *ldev;
 	bool hash = false;
 	bool lag_active;
+	int i, idx = 0;
 	int num_ports;
-	int i;
 
 	ldev = mlx5_lag_dev(dev);
 	mutex_lock(&ldev->lock);
 	lag_active = __mlx5_lag_is_active(ldev);
 	if (lag_active) {
 		if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &ldev->mode_flags)) {
-			mlx5_infer_tx_enabled(&ldev->tracker, ldev->ports, ports,
+			mlx5_infer_tx_enabled(&ldev->tracker, ldev, ports,
 					      &num_ports);
 			hash = true;
 		} else {
-			for (i = 0; i < ldev->ports; i++)
-				ports[i] = ldev->v2p_map[i];
+			ldev_for_each(i, 0, ldev)
+				ports[idx++] = ldev->v2p_map[i];
 			num_ports = ldev->ports;
 		}
 	}
@@ -144,11 +144,8 @@ static int members_show(struct seq_file *file, void *priv)
 
 	ldev = mlx5_lag_dev(dev);
 	mutex_lock(&ldev->lock);
-	for (i = 0; i < ldev->ports; i++) {
-		if (!ldev->pf[i].dev)
-			continue;
+	ldev_for_each(i, 0, ldev)
 		seq_printf(file, "%s\n", dev_name(ldev->pf[i].dev->device));
-	}
 	mutex_unlock(&ldev->lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 7f68468c2e75..73fd3f747f1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -43,10 +43,6 @@
 #include "mp.h"
 #include "mpesw.h"
 
-enum {
-	MLX5_LAG_EGRESS_PORT_1 = 1,
-	MLX5_LAG_EGRESS_PORT_2,
-};
 
 /* General purpose, use for short periods of time.
  * Beware of lock dependencies (preferably, no locks should be acquired
@@ -72,7 +68,7 @@ static u8 lag_active_port_bits(struct mlx5_lag *ldev)
 	int num_enabled;
 	int idx;
 
-	mlx5_infer_tx_enabled(&ldev->tracker, ldev->ports, enabled_ports,
+	mlx5_infer_tx_enabled(&ldev->tracker, ldev, enabled_ports,
 			      &num_enabled);
 	for (idx = 0; idx < num_enabled; idx++)
 		active_port |= BIT_MASK(enabled_ports[idx]);
@@ -113,7 +109,7 @@ static int mlx5_cmd_create_lag(struct mlx5_core_dev *dev, u8 *ports, int mode,
 	return mlx5_cmd_exec_in(dev, create_lag, in);
 }
 
-static int mlx5_cmd_modify_lag(struct mlx5_core_dev *dev, u8 num_ports,
+static int mlx5_cmd_modify_lag(struct mlx5_core_dev *dev, struct mlx5_lag *ldev,
 			       u8 *ports)
 {
 	u32 in[MLX5_ST_SZ_DW(modify_lag_in)] = {};
@@ -148,33 +144,31 @@ int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_cmd_destroy_vport_lag);
 
-static void mlx5_infer_tx_disabled(struct lag_tracker *tracker, u8 num_ports,
+static void mlx5_infer_tx_disabled(struct lag_tracker *tracker, struct mlx5_lag *ldev,
 				   u8 *ports, int *num_disabled)
 {
 	int i;
 
 	*num_disabled = 0;
-	for (i = 0; i < num_ports; i++) {
+	ldev_for_each(i, 0, ldev)
 		if (!tracker->netdev_state[i].tx_enabled ||
 		    !tracker->netdev_state[i].link_up)
 			ports[(*num_disabled)++] = i;
-	}
 }
 
-void mlx5_infer_tx_enabled(struct lag_tracker *tracker, u8 num_ports,
+void mlx5_infer_tx_enabled(struct lag_tracker *tracker, struct mlx5_lag *ldev,
 			   u8 *ports, int *num_enabled)
 {
 	int i;
 
 	*num_enabled = 0;
-	for (i = 0; i < num_ports; i++) {
+	ldev_for_each(i, 0, ldev)
 		if (tracker->netdev_state[i].tx_enabled &&
 		    tracker->netdev_state[i].link_up)
 			ports[(*num_enabled)++] = i;
-	}
 
 	if (*num_enabled == 0)
-		mlx5_infer_tx_disabled(tracker, num_ports, ports, num_enabled);
+		mlx5_infer_tx_disabled(tracker, ldev, ports, num_enabled);
 }
 
 static void mlx5_lag_print_mapping(struct mlx5_core_dev *dev,
@@ -192,7 +186,7 @@ static void mlx5_lag_print_mapping(struct mlx5_core_dev *dev,
 	int j;
 
 	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &flags)) {
-		mlx5_infer_tx_enabled(tracker, ldev->ports, enabled_ports,
+		mlx5_infer_tx_enabled(tracker, ldev, enabled_ports,
 				      &num_enabled);
 		for (i = 0; i < num_enabled; i++) {
 			err = scnprintf(buf + written, 4, "%d, ", enabled_ports[i] + 1);
@@ -203,7 +197,7 @@ static void mlx5_lag_print_mapping(struct mlx5_core_dev *dev,
 		buf[written - 2] = 0;
 		mlx5_core_info(dev, "lag map active ports: %s\n", buf);
 	} else {
-		for (i = 0; i < ldev->ports; i++) {
+		ldev_for_each(i, 0, ldev) {
 			for (j  = 0; j < ldev->buckets; j++) {
 				idx = i * ldev->buckets + j;
 				err = scnprintf(buf + written, 10,
@@ -286,7 +280,7 @@ int mlx5_lag_dev_get_netdev_idx(struct mlx5_lag *ldev,
 {
 	int i;
 
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		if (ldev->pf[i].netdev == ndev)
 			return i;
 
@@ -310,7 +304,7 @@ static bool __mlx5_lag_is_sriov(struct mlx5_lag *ldev)
  * with mapping that points to active ports.
  */
 static void mlx5_infer_tx_affinity_mapping(struct lag_tracker *tracker,
-					   u8 num_ports,
+					   struct mlx5_lag *ldev,
 					   u8 buckets,
 					   u8 *ports)
 {
@@ -323,7 +317,7 @@ static void mlx5_infer_tx_affinity_mapping(struct lag_tracker *tracker,
 	int i;
 	int j;
 
-	for (i = 0; i < num_ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		if (tracker->netdev_state[i].tx_enabled &&
 		    tracker->netdev_state[i].link_up)
 			enabled[enabled_ports_num++] = i;
@@ -334,15 +328,16 @@ static void mlx5_infer_tx_affinity_mapping(struct lag_tracker *tracker,
 	/* Use native mapping by default where each port's buckets
 	 * point the native port: 1 1 1 .. 1 2 2 2 ... 2 3 3 3 ... 3 etc
 	 */
-	for (i = 0; i < num_ports; i++)
+	ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < buckets; j++) {
 			idx = i * buckets + j;
-			ports[idx] = MLX5_LAG_EGRESS_PORT_1 + i;
+			ports[idx] = i + 1;
 		}
+	}
 
 	/* If all ports are disabled/enabled keep native mapping */
-	if (enabled_ports_num == num_ports ||
-	    disabled_ports_num == num_ports)
+	if (enabled_ports_num == ldev->ports ||
+	    disabled_ports_num == ldev->ports)
 		return;
 
 	/* Go over the disabled ports and for each assign a random active port */
@@ -358,7 +353,7 @@ static bool mlx5_lag_has_drop_rule(struct mlx5_lag *ldev)
 {
 	int i;
 
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		if (ldev->pf[i].has_drop)
 			return true;
 	return false;
@@ -368,7 +363,7 @@ static void mlx5_lag_drop_rule_cleanup(struct mlx5_lag *ldev)
 {
 	int i;
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		if (!ldev->pf[i].has_drop)
 			continue;
 
@@ -396,7 +391,7 @@ static void mlx5_lag_drop_rule_setup(struct mlx5_lag *ldev,
 	if (!ldev->tracker.has_inactive)
 		return;
 
-	mlx5_infer_tx_disabled(tracker, ldev->ports, disabled_ports, &num_disabled);
+	mlx5_infer_tx_disabled(tracker, ldev, disabled_ports, &num_disabled);
 
 	for (i = 0; i < num_disabled; i++) {
 		disabled_index = disabled_ports[i];
@@ -442,7 +437,7 @@ static int _mlx5_modify_lag(struct mlx5_lag *ldev, u8 *ports)
 
 		return mlx5_cmd_modify_active_port(dev0, active_ports);
 	}
-	return mlx5_cmd_modify_lag(dev0, ldev->ports, ports);
+	return mlx5_cmd_modify_lag(dev0, ldev, ports);
 }
 
 static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev *dev)
@@ -458,7 +453,7 @@ static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev
 	if (!ldev)
 		goto unlock;
 
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		if (ldev->tracker.netdev_state[i].tx_enabled)
 			ndev = ldev->pf[i].netdev;
 	if (!ndev)
@@ -483,9 +478,9 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 	int i;
 	int j;
 
-	mlx5_infer_tx_affinity_mapping(tracker, ldev->ports, ldev->buckets, ports);
+	mlx5_infer_tx_affinity_mapping(tracker, ldev, ldev->buckets, ports);
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
 			if (ports[idx] == ldev->v2p_map[idx])
@@ -596,9 +591,9 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
 	struct mlx5_eswitch *master_esw = dev0->priv.eswitch;
 	int err;
-	int i;
+	int i, j;
 
-	for (i = MLX5_LAG_P1 + 1; i < ldev->ports; i++) {
+	ldev_for_each(i, 1, ldev) {
 		struct mlx5_eswitch *slave_esw = ldev->pf[i].dev->priv.eswitch;
 
 		err = mlx5_eswitch_offloads_single_fdb_add_one(master_esw,
@@ -608,9 +603,9 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	}
 	return 0;
 err:
-	for (; i > MLX5_LAG_P1; i--)
+	ldev_for_each_reverse(j, i, 1, ldev)
 		mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
-							 ldev->pf[i].dev->priv.eswitch);
+							 ldev->pf[j].dev->priv.eswitch);
 	return err;
 }
 
@@ -671,7 +666,7 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 		return err;
 
 	if (mode != MLX5_LAG_MODE_MPESW) {
-		mlx5_infer_tx_affinity_mapping(tracker, ldev->ports, ldev->buckets, ldev->v2p_map);
+		mlx5_infer_tx_affinity_mapping(tracker, ldev, ldev->buckets, ldev->v2p_map);
 		if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &flags)) {
 			err = mlx5_lag_port_sel_create(ldev, tracker->hash_type,
 						       ldev->v2p_map);
@@ -722,7 +717,7 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	mlx5_lag_mp_reset(ldev);
 
 	if (test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags)) {
-		for (i = MLX5_LAG_P1 + 1; i < ldev->ports; i++)
+		ldev_for_each(i, 1, ldev)
 			mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
 								 ldev->pf[i].dev->priv.eswitch);
 		clear_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
@@ -766,7 +761,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 			return false;
 
 #ifdef CONFIG_MLX5_ESWITCH
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		dev = ldev->pf[i].dev;
 		if (mlx5_eswitch_num_vfs(dev->priv.eswitch) && !is_mdev_switchdev_mode(dev))
 			return false;
@@ -774,17 +769,17 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 
 	dev = ldev->pf[MLX5_LAG_P1].dev;
 	mode = mlx5_eswitch_mode(dev);
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		if (mlx5_eswitch_mode(ldev->pf[i].dev) != mode)
 			return false;
 
 #else
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
 			return false;
 #endif
 	roce_support = mlx5_get_roce_state(ldev->pf[MLX5_LAG_P1].dev);
-	for (i = 1; i < ldev->ports; i++)
+	ldev_for_each(i, MLX5_LAG_P2, ldev)
 		if (mlx5_get_roce_state(ldev->pf[i].dev) != roce_support)
 			return false;
 
@@ -795,10 +790,7 @@ void mlx5_lag_add_devices(struct mlx5_lag *ldev)
 {
 	int i;
 
-	for (i = 0; i < ldev->ports; i++) {
-		if (!ldev->pf[i].dev)
-			continue;
-
+	ldev_for_each(i, 0, ldev) {
 		if (ldev->pf[i].dev->priv.flags &
 		    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
 			continue;
@@ -812,10 +804,7 @@ void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
 {
 	int i;
 
-	for (i = 0; i < ldev->ports; i++) {
-		if (!ldev->pf[i].dev)
-			continue;
-
+	ldev_for_each(i, 0, ldev) {
 		if (ldev->pf[i].dev->priv.flags &
 		    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
 			continue;
@@ -842,7 +831,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 			dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
 		}
-		for (i = 1; i < ldev->ports; i++)
+		ldev_for_each(i, MLX5_LAG_P2, ldev)
 			mlx5_nic_vport_disable_roce(ldev->pf[i].dev);
 	}
 
@@ -854,7 +843,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 		mlx5_lag_add_devices(ldev);
 
 	if (shared_fdb)
-		for (i = 0; i < ldev->ports; i++)
+		ldev_for_each(i, 0, ldev)
 			if (!(ldev->pf[i].dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
 				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 }
@@ -864,7 +853,7 @@ static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev;
 	int i;
 
-	for (i = MLX5_LAG_P1 + 1; i < ldev->ports; i++) {
+	ldev_for_each(i, MLX5_LAG_P1 + 1, ldev) {
 		dev = ldev->pf[i].dev;
 		if (is_mdev_switchdev_mode(dev) &&
 		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
@@ -892,11 +881,11 @@ static bool mlx5_lag_is_roce_lag(struct mlx5_lag *ldev)
 	bool roce_lag = true;
 	int i;
 
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		roce_lag = roce_lag && !mlx5_sriov_is_enabled(ldev->pf[i].dev);
 
 #ifdef CONFIG_MLX5_ESWITCH
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		roce_lag = roce_lag && is_mdev_legacy_mode(ldev->pf[i].dev);
 #endif
 
@@ -956,7 +945,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		} else if (roce_lag) {
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-			for (i = 1; i < ldev->ports; i++) {
+			ldev_for_each(i, MLX5_LAG_P2, ldev) {
 				if (mlx5_get_roce_state(ldev->pf[i].dev))
 					mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
 			}
@@ -966,7 +955,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
 
-			for (i = 0; i < ldev->ports; i++) {
+			ldev_for_each(i, 0, ldev) {
 				err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				if (err)
 					break;
@@ -977,7 +966,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				mlx5_rescan_drivers_locked(dev0);
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
-				for (i = 0; i < ldev->ports; i++)
+				ldev_for_each(i, 0, ldev)
 					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
@@ -1010,12 +999,9 @@ struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
 	int i;
 
 	mutex_lock(&ldev->lock);
-	for (i = 0; i < ldev->ports; i++) {
-		if (ldev->pf[i].dev) {
-			devcom = ldev->pf[i].dev->priv.hca_devcom_comp;
-			break;
-		}
-	}
+	i = get_next_ldev_func(ldev, 0);
+	if (i < MLX5_MAX_PORTS)
+		devcom = ldev->pf[i].dev->priv.hca_devcom_comp;
 	mutex_unlock(&ldev->lock);
 	return devcom;
 }
@@ -1068,7 +1054,7 @@ static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
 	u8 bond_status = 0;
 	int num_slaves = 0;
 	int changed = 0;
-	int idx;
+	int i, idx = -1;
 
 	if (!netif_is_lag_master(upper))
 		return 0;
@@ -1083,8 +1069,13 @@ static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
 	 */
 	rcu_read_lock();
 	for_each_netdev_in_bond_rcu(upper, ndev_tmp) {
-		idx = mlx5_lag_dev_get_netdev_idx(ldev, ndev_tmp);
-		if (idx >= 0) {
+		ldev_for_each(i, 0, ldev) {
+			if (ldev->pf[i].netdev == ndev_tmp) {
+				idx++;
+				break;
+			}
+		}
+		if (i < MLX5_MAX_PORTS) {
 			slave = bond_slave_get_rcu(ndev_tmp);
 			if (slave)
 				has_inactive |= bond_is_slave_inactive(slave);
@@ -1234,15 +1225,12 @@ static int mlx5_lag_netdev_event(struct notifier_block *this,
 }
 
 static void mlx5_ldev_add_netdev(struct mlx5_lag *ldev,
-				 struct mlx5_core_dev *dev,
-				 struct net_device *netdev)
+				struct mlx5_core_dev *dev,
+				struct net_device *netdev)
 {
 	unsigned int fn = mlx5_get_dev_index(dev);
 	unsigned long flags;
 
-	if (fn >= ldev->ports)
-		return;
-
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev->pf[fn].netdev = netdev;
 	ldev->tracker.netdev_state[fn].link_up = 0;
@@ -1257,7 +1245,7 @@ static void mlx5_ldev_remove_netdev(struct mlx5_lag *ldev,
 	int i;
 
 	spin_lock_irqsave(&lag_lock, flags);
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		if (ldev->pf[i].netdev == netdev) {
 			ldev->pf[i].netdev = NULL;
 			break;
@@ -1267,13 +1255,10 @@ static void mlx5_ldev_remove_netdev(struct mlx5_lag *ldev,
 }
 
 static void mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
-			       struct mlx5_core_dev *dev)
+			      struct mlx5_core_dev *dev)
 {
 	unsigned int fn = mlx5_get_dev_index(dev);
 
-	if (fn >= ldev->ports)
-		return;
-
 	ldev->pf[fn].dev = dev;
 	dev->priv.lag = ldev;
 }
@@ -1281,16 +1266,13 @@ static void mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
 static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
 				  struct mlx5_core_dev *dev)
 {
-	int i;
+	int fn;
 
-	for (i = 0; i < ldev->ports; i++)
-		if (ldev->pf[i].dev == dev)
-			break;
-
-	if (i == ldev->ports)
+	fn = mlx5_get_dev_index(dev);
+	if (ldev->pf[fn].dev != dev)
 		return;
 
-	ldev->pf[i].dev = NULL;
+	ldev->pf[fn].dev = NULL;
 	dev->priv.lag = NULL;
 }
 
@@ -1406,7 +1388,6 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
 
 	mutex_lock(&ldev->lock);
 	mlx5_ldev_add_netdev(ldev, dev, netdev);
-
 	for (i = 0; i < ldev->ports; i++)
 		if (!ldev->pf[i].netdev)
 			break;
@@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
 	mlx5_queue_bond_work(ldev, 0);
 }
 
+int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
+{
+	int i;
+
+	for (i = start_idx; i >= end_idx; i--)
+		if (ldev->pf[i].dev)
+			return i;
+	return -1;
+}
+
+int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
+{
+	int i;
+
+	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
+		if (ldev->pf[i].dev)
+			return i;
+	return MLX5_MAX_PORTS;
+}
+
 bool mlx5_lag_is_roce(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev;
@@ -1467,7 +1468,7 @@ bool mlx5_lag_is_master(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev;
 	unsigned long flags;
-	bool res;
+	bool res = false;
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
@@ -1555,7 +1556,7 @@ u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 	if (!(ldev && __mlx5_lag_is_roce(ldev)))
 		goto unlock;
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		if (ldev->pf[i].netdev == slave) {
 			port = i;
 			break;
@@ -1594,13 +1595,13 @@ struct mlx5_core_dev *mlx5_lag_get_next_peer_mdev(struct mlx5_core_dev *dev, int
 	if (!ldev)
 		goto unlock;
 
-	if (*i == ldev->ports)
+	if (*i == MLX5_MAX_PORTS)
 		goto unlock;
-	for (idx = *i; idx < ldev->ports; idx++)
+	ldev_for_each(idx, *i, ldev)
 		if (ldev->pf[idx].dev != dev)
 			break;
 
-	if (idx == ldev->ports) {
+	if (idx == MLX5_MAX_PORTS) {
 		*i = idx;
 		goto unlock;
 	}
@@ -1621,10 +1622,10 @@ int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
 {
 	int outlen = MLX5_ST_SZ_BYTES(query_cong_statistics_out);
 	struct mlx5_core_dev **mdev;
+	int ret = 0, i, j, idx = 0;
 	struct mlx5_lag *ldev;
 	unsigned long flags;
 	int num_ports;
-	int ret, i, j;
 	void *out;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
@@ -1643,8 +1644,8 @@ int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
 	ldev = mlx5_lag_dev(dev);
 	if (ldev && __mlx5_lag_is_active(ldev)) {
 		num_ports = ldev->ports;
-		for (i = 0; i < ldev->ports; i++)
-			mdev[i] = ldev->pf[i].dev;
+		ldev_for_each(i, 0, ldev)
+			mdev[idx++] = ldev->pf[i].dev;
 	} else {
 		num_ports = 1;
 		mdev[MLX5_LAG_P1] = dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 50fcb1eee574..1be34eb43723 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -103,7 +103,7 @@ int mlx5_lag_dev_get_netdev_idx(struct mlx5_lag *ldev,
 				struct net_device *ndev);
 
 char *mlx5_get_str_port_sel_mode(enum mlx5_lag_mode mode, unsigned long flags);
-void mlx5_infer_tx_enabled(struct lag_tracker *tracker, u8 num_ports,
+void mlx5_infer_tx_enabled(struct lag_tracker *tracker, struct mlx5_lag *ldev,
 			   u8 *ports, int *num_enabled);
 
 void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev);
@@ -119,9 +119,21 @@ static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
 	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||
 	    !MLX5_CAP_GEN(dev, lag_master) ||
 	    MLX5_CAP_GEN(dev, num_lag_ports) < 2 ||
+	    mlx5_get_dev_index(dev) >= MLX5_MAX_PORTS ||
 	    MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_MAX_PORTS)
 		return false;
 	return true;
 }
 
+#define ldev_for_each(i, start_index, ldev) \
+	for (int tmp = start_index; tmp = get_next_ldev_func(ldev, tmp), \
+	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
+
+#define ldev_for_each_reverse(i, start_index, end_index, ldev)      \
+	for (int tmp = start_index, tmp1 = end_index; \
+	     tmp = get_pre_ldev_func(ldev, tmp, tmp1), \
+	     i = tmp, tmp >= tmp1; tmp--)
+
+int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx);
+int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
 #endif /* __MLX5_LAG_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index b1aa494c76ba..9596cf433815 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -153,6 +153,7 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 	struct net_device *nh_dev0, *nh_dev1;
 	struct fib_info *fi = fen_info->fi;
 	struct lag_mp *mp = &ldev->lag_mp;
+	int i, dev_idx = 0;
 
 	/* Handle delete event */
 	if (event == FIB_EVENT_ENTRY_DEL) {
@@ -186,10 +187,12 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 
 	if (!nh_dev1) {
 		if (__mlx5_lag_is_active(ldev)) {
-			int i = mlx5_lag_dev_get_netdev_idx(ldev, nh_dev0);
-
-			i++;
-			mlx5_lag_set_port_affinity(ldev, i);
+			ldev_for_each(i, 0, ldev) {
+				dev_idx++;
+				if (ldev->pf[i].netdev == nh_dev0)
+					break;
+			}
+			mlx5_lag_set_port_affinity(ldev, dev_idx);
 			mlx5_lag_fib_set(mp, fi, fen_info->dst, fen_info->dst_len);
 		}
 
@@ -214,6 +217,7 @@ static void mlx5_lag_fib_nexthop_event(struct mlx5_lag *ldev,
 				       struct fib_info *fi)
 {
 	struct lag_mp *mp = &ldev->lag_mp;
+	int i, dev_idx = 0;
 
 	/* Check the nh event is related to the route */
 	if (!mp->fib.mfi || mp->fib.mfi != fi)
@@ -221,11 +225,15 @@ static void mlx5_lag_fib_nexthop_event(struct mlx5_lag *ldev,
 
 	/* nh added/removed */
 	if (event == FIB_EVENT_NH_DEL) {
-		int i = mlx5_lag_dev_get_netdev_idx(ldev, fib_nh->fib_nh_dev);
+		ldev_for_each(i, 0, ldev) {
+			if (ldev->pf[i].netdev == fib_nh->fib_nh_dev)
+				break;
+			dev_idx++;
+		}
 
-		if (i >= 0) {
-			i = (i + 1) % 2 + 1; /* peer port */
-			mlx5_lag_set_port_affinity(ldev, i);
+		if (dev_idx >= 0) {
+			dev_idx = (dev_idx + 1) % 2 + 1; /* peer port */
+			mlx5_lag_set_port_affinity(ldev, dev_idx);
 		}
 	} else if (event == FIB_EVENT_NH_ADD &&
 		   fib_info_num_path(fi) == 2) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 571ea26edd0c..dd1b2caa0182 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -15,7 +15,7 @@ static void mlx5_mpesw_metadata_cleanup(struct mlx5_lag *ldev)
 	u32 pf_metadata;
 	int i;
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		dev = ldev->pf[i].dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = ldev->lag_mpesw.pf_metadata[i];
@@ -36,7 +36,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	u32 pf_metadata;
 	int i, err;
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		dev = ldev->pf[i].dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = mlx5_esw_match_metadata_alloc(esw);
@@ -52,7 +52,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 			goto err_metadata;
 	}
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		dev = ldev->pf[i].dev;
 		mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_MULTIPORT_ESW,
 					 (void *)0);
@@ -98,7 +98,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 		if (err)
 			goto err_rescan_drivers;
@@ -112,7 +112,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	mlx5_deactivate_lag(ldev);
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
-	for (i = 0; i < ldev->ports; i++)
+	ldev_for_each(i, 0, ldev)
 		mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index ab2717012b79..6b52b09ffc40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -44,9 +44,7 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 	struct mlx5_flow_destination dest = {};
 	MLX5_DECLARE_FLOW_ACT(flow_act);
 	struct mlx5_flow_namespace *ns;
-	int err, i;
-	int idx;
-	int j;
+	int err, i, j, k, idx;
 
 	ft_attr.max_fte = ldev->ports * ldev->buckets;
 	ft_attr.level = MLX5_LAG_FT_LEVEL_DEFINER;
@@ -74,7 +72,7 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_UPLINK;
 	dest.vport.flags |= MLX5_FLOW_DEST_VPORT_VHCA_ID;
 	flow_act.flags |= FLOW_ACT_NO_APPEND;
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			u8 affinity;
 
@@ -88,13 +86,13 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 								      &dest, 1);
 			if (IS_ERR(lag_definer->rules[idx])) {
 				err = PTR_ERR(lag_definer->rules[idx]);
-				do {
+				ldev_for_each_reverse(k, i, 0, ldev) {
 					while (j--) {
-						idx = i * ldev->buckets + j;
+						idx = k * ldev->buckets + j;
 						mlx5_del_flow_rules(lag_definer->rules[idx]);
 					}
 					j = ldev->buckets;
-				} while (i--);
+				};
 				goto destroy_fg;
 			}
 		}
@@ -346,7 +344,7 @@ static void mlx5_lag_destroy_definer(struct mlx5_lag *ldev,
 	int i;
 	int j;
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
 			mlx5_del_flow_rules(lag_definer->rules[idx]);
@@ -565,7 +563,7 @@ static int __mlx5_lag_modify_definers_destinations(struct mlx5_lag *ldev,
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_UPLINK;
 	dest.vport.flags |= MLX5_FLOW_DEST_VPORT_VHCA_ID;
 
-	for (i = 0; i < ldev->ports; i++) {
+	ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
 			if (ldev->v2p_map[idx] == ports[idx])
-- 
2.44.0


