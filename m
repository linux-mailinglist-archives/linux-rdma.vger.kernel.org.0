Return-Path: <linux-rdma+bounces-21359-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKAyHFXsFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21359-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:06:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E375E49BF
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA035309BDE5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACF409603;
	Wed, 27 May 2026 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bBIf0m1R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB1274B23;
	Wed, 27 May 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886572; cv=fail; b=Ubtq3gNEgZL++EQUM2hHHe6RC0vo9F+IxnaPYzwOkIPShRDdO4hJ8sqW/dDKct0EC3rpnz8d4xO8wPhfg+kNA/bOJp+bNLn4s+GEnJaA43NimCHi237TReegfRNdC8nAStoC0DsddiwE0W62rfJ33kfc+VBhvcQY6hWWnKhFfLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886572; c=relaxed/simple;
	bh=Yj9OYZbFMNg4Ig6WQX5Ed7l4sM3qO2R20iABTy9wyd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwnlzuDAa2rhlK/eIXo7EqjUFT2GxPoajtJD3F7OBOKRbVTSpxVuoXo5uHaKCNlwAHIQgEPMMVWd7dTJs4TonIlcL8kzwhZ7ICWu14KD/cmSynmNQEytYuQBwtDbURhgso5n+HlTWAXREpYzV84VOgeBNo1QcxplYM6d5qTgwGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bBIf0m1R; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiDXlAh92ooJsvfz/jcV87ZnUwLrRAq4KbW+kWJbN2W/AIpVu+g3JZ8rbBUBJjvG/woMyYYwbZkO5E4OGj1VC96vQuiuedwWhZkIMpFFGrbCJIk0pl/hvZGxcDqjoVFLMeA5CRb4pBtMuQNY9HnnEn2CZYI3WzwA3K93uM02YHN7lwUg6uVGyp2tietqaXpMTGUXOfcxuWxUVLWxqVOZqyjihoerrWf8LdJoBQYLCXmvCozX1JFWNoVK3j8MYFDKOWV50RSYUGqGR9IaSnd0W45VU0e8E0cmV1TMzc1WrqEMEDmXGrwnIK1vht/9rQ9ksc0sJWpR6MiQArOPNPIahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oyE++elUkQTgOJXFLJYRv5+ScRX/XWe/NesAqkYdHY=;
 b=U4su6gUWeHQwZ+CBtv7sWHp4/ngKnvS1lKswH1jmk1wmZ/+rFGEuzBb105j2vEvXbBN8jspam0A+bJbPP7a7V5L3OHAAJeC0D0G0sboDKsa/Ioe6TY17xZTVTzEavU481CbtK1/Wsk/fV2bwYyLxcvQ262iGB8Qrt/rq4M3EfauTSclaJc7F0/RkazBSJ+hwkY6Ezx4S3kjd3r99jiXnFc2B6nljknh2M+AWxWPV9arSHUshlU9t5tUYkbWwn+CM7bOYZ+mL1M//fXnvdkh6NTZft4GZjdLSb5TkdQSuXBNrLT7hUNr4BUJhgtKFB4fsof3Qr6Nz+ulV0moro6qiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oyE++elUkQTgOJXFLJYRv5+ScRX/XWe/NesAqkYdHY=;
 b=bBIf0m1RuoCZFpl+3B/soVTWE9kfoD7+nLVdu4PhgZayPCN5PvJwA18K7UHGX+y4lRTsyXHvJHlDpDuT+w1m42/WwZY1rDFdFkjqR4j/DbgBzpy//KAaqlT6G0tngokNh7KZScFlqLy7B0sXrDcrM6LCpkz4EwLippZe/5xWBpmbXuK3tjcTFu3D2vSGttrEcfAVX5FHQZs1bNOVv33vogASQ88AKV+iKd/qERLdb+d2xAE5/YqzDdoOn426YpuNyOOROo8otTBFbwTb7LprNQ55Lh4+NMghvMl7dX8pUfXfol6kzwSG4Kn3wigYKAKoaHL11YFmFqenH8BjrEBRnw==
Received: from SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 12:56:05 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a3) by SJ0PR03CA0200.outlook.office365.com
 (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:56:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 07/13] net/mlx5: SD, introduce Socket Direct LAG
Date: Wed, 27 May 2026 15:54:21 +0300
Message-ID: <20260527125427.385976-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: b1742eb9-0c35-4e12-5c4e-08debbef5030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6VsoD6sz82hajTOs/9G8tuax3hhuR8H7FYMhdPRLp4VIovJRYPKnw8AKay5/zR9DMsdTTpYbr/w/frWg6RGZz54Wvg9ZvAxK44iC1UfEyQ2J0Wl0eGKlaLDxKm2EwerOO/Hv9uMN72GzA2PLzW5/iYD9s8aVsbYc9ndReZ6nB2h7JRUyvhZ8cyJBKitVqHlPw9oJaQmd2WwLs+K3S27ose8Ki2gJBnnrV7KK8cw0qezLw98IPYan0AV7Q1o0/7yyvvuz105VBBxyGKygJ1q2DwHCZMWAyI0/YVnBtTVxynybyAaJK8awdolHcZkdnB91SK+m3LbVL4OxMxjbHcOvx8JFwSqA+tFLjXuNB+eMdBFk35F1xPa8Q1Uj9/PcfvNCywD0TCtFj0uwESCqB+Dk9sjX0Xk65LkCeK9M4L2N5K2hHDmYR/RmVSz3IwTtxllk2ji0kMR5Lj0Q3lcKubXZhN2xT64H2Wop1ejckW/6UHlezAAnm65zr0/yAEzoCdjvEJ8+NPwrjdbPqA/UIhduk7ivTEnLRriOHeLT5WnO5dObVyOfhzr408Q8ieSqCSzRvVLDW6bxoAdOc9Vpb3+ZzjerZ4OubkR4TCdH3bjhCLqCaGo9kaOixsj7NjHiHSH698/hacw3GAk2dTKP6exU0vqMIEHnF/gO3BcUPzpNjvusQnq/sGqNt2aSJLtoNDc2ATr+aJymMi6eDgie82O0N0Cjm3HQHtuN8cgadPvjnos=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q0TdYtol8VF6rQ99XOl0S4tLE451hjfDRKLJJnVNSgjAW+3+gwWADFCysZeTaAXTX00VGTmiM6cC/JIBEBYgQwzOkITXKf7+8Rnvo9lGx9cQPitPPSV/Ry9JTJIpuqqapnrk2wP6c7E9/T6+GV2CsbJy+0cr/vDBM2L82o2pCPLrtCLK8f5kvX3B4kQxWht5wmLQRamsHnHZxVCNjJwo+AxLtemzeroBXG5OeLZSell7CTJcOzQqb0sDtAvcE8dC3aLN6VEEJUGkqEBKum4g+71X8aV9L7nNhXatNv9Hjz4nGuUgq/ZZhXD38ljv5MjcuV6Zozs0RprUarP6tQQV4IkMqI2yO0HlVMg/XtlVqjaqdS6vjDowXWk8yNX5XWWezTBm9Ko5An0w9Uu41gnaRe6Q6tkfqLe++i4SSNEMWsk6uDqNPk1pTcGs4CFTNq0H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:56:04.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1742eb9-0c35-4e12-5c4e-08debbef5030
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21359-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C3E375E49BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Register SD secondary devices with the existing LAG structure by
adding them to the primary's ldev xarray with a shared group_id.
This ties the SD LAG lifecycle to the SD group lifecycle.

Add sd_lag_state debugfs entry for LAG state visibility. To avoid
race between this entry and LAG deletion, have debugfs creation
and deletion done last on SD init and first on SD cleanup.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 135 ++++++++++++++++--
 1 file changed, 121 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index bbd77ae11e84..e341d814873a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include "lib/sd.h"
+#include "../lag/lag.h"
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
 #include "fs_cmd.h"
@@ -223,6 +224,108 @@ static void sd_cleanup(struct mlx5_core_dev *dev)
 	kfree(sd);
 }
 
+static int sd_lag_state_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_core_dev *dev = file->private;
+	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	bool active = false;
+	int i;
+
+	ldev = mlx5_lag_dev(dev);
+	if (!ldev)
+		return -EINVAL;
+
+	mutex_lock(&ldev->lock);
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev) {
+			active = pf->sd_fdb_active;
+			break;
+		}
+	}
+	mutex_unlock(&ldev->lock);
+
+	seq_printf(file, "%s\n", active ? "active" : "disabled");
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(sd_lag_state);
+
+/* SD LAG integration is optional. If LAG isn't available on this device
+ * (e.g. lag caps are off), or registering secondaries fails, just warn
+ * and continue - SD can operate without the LAG-side bookkeeping.
+ */
+static void sd_lag_init(struct mlx5_core_dev *dev)
+{
+	struct mlx5_core_dev *primary = mlx5_sd_get_primary(dev);
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_core_dev *pos, *to;
+	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int err;
+	int i;
+
+	ldev = mlx5_lag_dev(primary);
+	if (!ldev) {
+		sd_warn(primary, "%s: no ldev (LAG caps off?), skipping\n",
+			__func__);
+		return;
+	}
+
+	mutex_lock(&ldev->lock);
+	pf = mlx5_lag_pf_by_dev(ldev, primary);
+	if (!pf) {
+		sd_warn(primary, "%s: primary not registered in ldev, skipping\n",
+			__func__);
+		goto out;
+	}
+
+	pf->group_id = sd->group_id;
+
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		err = mlx5_ldev_add_mdev(ldev, pos, sd->group_id);
+		if (err) {
+			sd_warn(primary, "%s: failed to add secondary %s to ldev: %d\n",
+				__func__, dev_name(pos->device), err);
+			goto err;
+		}
+	}
+
+out:
+	mutex_unlock(&ldev->lock);
+	return;
+
+err:
+	to = pos;
+	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
+		mlx5_ldev_remove_mdev(ldev, pos);
+	pf->group_id = 0;
+	mutex_unlock(&ldev->lock);
+}
+
+static void sd_lag_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_core_dev *primary = mlx5_sd_get_primary(dev);
+	struct mlx5_core_dev *pos;
+	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int i;
+
+	ldev = mlx5_lag_dev(primary);
+	if (!ldev)
+		return;
+
+	mutex_lock(&ldev->lock);
+	mlx5_sd_for_each_secondary(i, primary, pos)
+		mlx5_ldev_remove_mdev(ldev, pos);
+
+	pf = mlx5_lag_pf_by_dev(ldev, primary);
+	if (pf)
+		pf->group_id = 0;
+	mutex_unlock(&ldev->lock);
+}
+
 static int sd_register(struct mlx5_core_dev *dev)
 {
 	struct mlx5_devcom_comp_dev *devcom, *pos;
@@ -473,27 +576,32 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_unregister;
 
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		err = sd_cmd_set_secondary(pos, primary, alias_key);
+		if (err)
+			goto err_unset_secondaries;
+	}
+
+	sd_lag_init(primary);
+
 	primary_sd->dfs =
 		debugfs_create_dir("multi-pf",
 				   mlx5_debugfs_get_dev_root(primary));
-	debugfs_create_x32("group_id", 0400, primary_sd->dfs,
-			   &primary_sd->group_id);
-	debugfs_create_file("primary", 0400, primary_sd->dfs, primary,
-			    &dev_fops);
-
 	mlx5_sd_for_each_secondary(i, primary, pos) {
 		char name[32];
 
-		err = sd_cmd_set_secondary(pos, primary, alias_key);
-		if (err)
-			goto err_unset_secondaries;
-
 		snprintf(name, sizeof(name), "secondary_%d", i - 1);
 		debugfs_create_file(name, 0400, primary_sd->dfs, pos,
 				    &dev_fops);
-
 	}
 
+	debugfs_create_file("sd_lag_state", 0400, primary_sd->dfs, primary,
+			    &sd_lag_state_fops);
+	debugfs_create_x32("group_id", 0400, primary_sd->dfs,
+			   &primary_sd->group_id);
+	debugfs_create_file("primary", 0400, primary_sd->dfs, primary,
+			    &dev_fops);
+
 	sd_info(primary, "group id %#x, size %d, combined\n",
 		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
 	sd_print_group(primary);
@@ -508,8 +616,6 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(primary_sd->dfs);
-	primary_sd->dfs = NULL;
 err_sd_unregister:
 	mlx5_sd_for_each_secondary(i, primary, pos) {
 		struct mlx5_sd *peer_sd = mlx5_get_sd(pos);
@@ -548,11 +654,12 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	if (primary_sd->state != MLX5_SD_STATE_UP)
 		goto out_clear_peers;
 
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
+	sd_lag_cleanup(primary);
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(primary_sd->dfs);
-	primary_sd->dfs = NULL;
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 	primary_sd->state = MLX5_SD_STATE_DOWN;
-- 
2.44.0


