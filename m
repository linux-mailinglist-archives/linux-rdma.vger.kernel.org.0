Return-Path: <linux-rdma+bounces-21551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAjfK5MfHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:46:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357F615DB9
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAEA03079575
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CAD3859E2;
	Sun, 31 May 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3VVH09P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42F384CEA;
	Sun, 31 May 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227667; cv=fail; b=uLgGaWeFqwzfLs09HjuufpfMbubLtAoPqEgJDWpn1nk1I52GlxaDuVpp1Z3KWadhgWpqAwqB960dhwU/FA/7gLMuhUijcmE1KtK4HAkiNFhlaU5rS/iuFtv4L28MxppOaUXbRlVt/+o9MVIGxtQgY8vXBSAFxiZGm1g0jz6B90g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227667; c=relaxed/simple;
	bh=Yj9OYZbFMNg4Ig6WQX5Ed7l4sM3qO2R20iABTy9wyd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdegj9hfZ4tx6KqgdwGwmJHsVvgdQZpyJppcTwbi0sJWNt9qidsf2Tj5roPHSRANr5DkkBCVAuuZScXgQxpzOV4h3GgK1BYt2dtbqDOnnxdQms+PSFi5Xa5sji00fMsGhTHzkTC0E8I9/ADIbEqs8GQfhvEAakxC3a6dtdgcfic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3VVH09P; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk6acukcsYfQSEQKM83w+mTgZDfwIxsquux3qYkD5qNzAwF5Hfi+Pr85l00xzeQF0Pk3lzdoo3h5Z9mgtDzAJIs4EKJFybbwvTuizmeLDzIkTw4qWzIUpfzfZpYrCjrCY+DFjPmNnQ+J/5fiaibgKqV4ujoXElgVnfgbRChha8+4i4eRtX3zGFBRcUlxZhQj3IQCFyT/XFmi6Hss+phZqY83O2wRiArYdjx4dL6ONEKsNpCU1TvVc4W1+3Xlf85CKjCil3E0EGUN70IAbNdmlrRIAv2Vy5Zfc7OPkFAUPEsoDslmHKuRALHbygebYgNLkVPdZKMPfkMlTk1/4w73XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oyE++elUkQTgOJXFLJYRv5+ScRX/XWe/NesAqkYdHY=;
 b=PcvK3UqN38eUQva+cTmj7e5WvcMyjDJiu/iIascj5arERXpgEzhVU7X4BaiE5khBq/JHeM40Rdv6R145gU9xqiloUtjPWofn78r6+c8+d4lfDVc40pL+z5pbByzNM4vOfnq93pTK1eUlHcdVLuyvd1LC5KdHYx7RCZHv2axOmItM+t/gr3fjark7al1+BX9hv+JmA9/PrDZnxfBTp3o9IcPro8jki4N5UuFs/S+YEgAHV8N6uxyBo2T9BNOou/e8eR4V4UiVpP9E8MProyCLC62dB+AMJskrXMomjY8vtWltYilTCVheGaP/aOHOblFgD9iWMTAgHbZfR66Hs5ZEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oyE++elUkQTgOJXFLJYRv5+ScRX/XWe/NesAqkYdHY=;
 b=T3VVH09PzlMkK/37mSkS4ppYevzMQk20XAYuzqI+ooC9sTBX1s5dmXBhgQbRsNoJJPjK6u9U1/1h5Ne7P+JPCMOnuTzSUbHnbE+bsglHtocM2O31q5/Ms2UqjFVRchztxBnp1JlNC6jFMrPTkCsr4aMjqgpKZibue6+dw8EupMiKrtZRAY39QAPm90Tmui4kxVwkVQ6xx+kbxUTcxM8yuSXxD/6TTs4MqDpP9XMaMbo3G5VpAocC+O+0lQJsqne8X2+6M+B9G6036mjsdcudoWUpF+ef6ssui+kQw85yu0SQtV9i2688XaUyaqEV68F2BcAEEXmDkfoJgnDoVUzVsQ==
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Sun, 31 May
 2026 11:40:58 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::8e) by CH0PR07CA0028.outlook.office365.com
 (2603:10b6:610:32::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Sun, 31
 May 2026 11:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Sun, 31 May 2026 11:40:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 07/13] net/mlx5: SD, introduce Socket Direct LAG
Date: Sun, 31 May 2026 14:39:47 +0300
Message-ID: <20260531113954.395443-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cb1f9e-c050-4aee-dd7b-08debf097bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	f54gS5bh/IDxTsqmGomz34MuNDxP14dWbiYF7yh2O1MiDWaWkKl/quFYhBYurQleKTyBz61q4lTBe0QMnkcJqkkzu9D2JPs7CnVApWSxN7WXnu51h7iDm4biMxo7rjFLBAWfzBgoNcMtzxoI/jUY/NvfmuC5PmEZP/qrSUeBn8G4sAA/UZjPzthHKq6df9J4RfriUHt+ufJSHrQ0ooPjab8TARVneRJwdczgFEROfHFi16EjNFYOTAzDasCsrmPJ0PJO2mxO9ZITKIfxSWNpo6FXXoIG7c94LtDjHUYmg0+5ZgOSyl6seo1b5dCEBUr+NfPjcLfehdIL9lqJ8g4/bXSsx27lIDcMxU0m+ZMJX8fYRebVU+yV1zoldtBBVDXDJV08GsPPp4S+Jsw2/oZdYMkesrRH5tDltYyIeJVZ3P4gjSAf/nxEe+cU+j3B9a2t2DajFlrLpZS4PJsNR3aZlgzGmUgXtdiZTrHAR/ohH9p1ca88x9OOwCe8TUwVQwKqonWkTW+ib91qPTytsDTyKgq9bW075v8TbMBKLZM4VZCu8cP9ZDNoqYJbOX8QgOE5OrvJqj/44AM1P9OQ6NhZmRVFkwomxZNIdZJq+5tu9s3CLucmspwlfTBQjB+nqkYmuCU0n7Z5ehB712U1WFFj3qPm0QnP1OKnif1qP+xPuBqrd5jo49wFmfG+QuctYx39mXI3Oxu1KSB/GhZ5su8Z5tzQ5/NPrYMRKD+Y/jcmqcs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UPY2y47htifSzkiqniiOQjeQOQQaPDh+3bhBKonkQ3RD4VtnmrTPUThAIeqKW81/tMYDbzk/5PnDBctHoH7p2IRcOmU6f/+ZFirHEiKaFsOhM6M/xP5d+2UgoQED5QXsrAgqLJr0mcY8lK5cQSqjWYLKUPKN3bwSXgWuX6F2jCX+s/LX10Co8T+qyhjvKguSEko+s88VgeVvPVjycBkrRAT2jUKA2ZHaFQ83PiiT8546fZcHUuSRi5dYpF/DnmxYaMeklQ1nO/B+JguO17p6ALJhfnfTBcNNCfSnZgmOUl2iwsuYTvgfjr/i8FckVK9sUCRbs/yeZ/F4GXXzlhcc/Kjt0WAaW3rL9YnjgYR0aK6e4JiIRZby6izfQZFJdtJ8jUXaZTvlB3lwSOzRCLJ6d4LLgwRloUZs7zv644BT78VA0rcPU2hicwoRLvomR/ml
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:58.3340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cb1f9e-c050-4aee-dd7b-08debf097bbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21551-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7357F615DB9
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


