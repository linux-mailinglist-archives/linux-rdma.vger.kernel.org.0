Return-Path: <linux-rdma+bounces-17696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLFVANsdrWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:57:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A779C22ED0B
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43CA13019171
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13713290BA;
	Sun,  8 Mar 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvJTf4L3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52143128D4;
	Sun,  8 Mar 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953025; cv=fail; b=JZHOhWy8RoNJWZRrYKg2B9JUAa8Jx0YavKo8W27o12XDEe0H+RtDRW/ASKejkBdF7nhLVenyJZPP/mbQiFUG9yKrpwrD1JKeVrgrmyU2APo4AEqRnGwtLBz6u9Wsd43PviuS0ylhIZHhFL5uqz7Oi7z9f9RL6ng7uDnSccdMXKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953025; c=relaxed/simple;
	bh=giK97tk2jrO/BGMTpZW0W4/3re2I2YPzW0xbMC+zTpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTjcgMPydepAuagpq8i+vVwbYrQsakoOBnWIDoMdMtUOL9w1MYY3vmO3gYjhFjlfHXap+0dyQE0gmoxwfvaGN092ZGWgy5AflCVf/GzO7TfG28zZYMgfXvsXUMTjr9ouedChXIyp33zJtL+Nw+iajoUM3hwKi+ZYUQ0TfrSD4CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvJTf4L3; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HctR3m6iALjuPbih6PwUzDhIptMItJ4hxiGPwJuJtRjvjY6t7+d9rOOCBCKoaxyU96JK1dOONB5gv1tU/XN7BFwBD2DfvL4UT4zs/p3tcMoP8HVXiTl+EN70tmySL9SX2srHfH8Ykd+dvMQWpzWQLui7rPFK/wnVx+RNwPCld1Rp3xn6StUWJRWxIzsl45/z6iHmYN0Pf97/wmthoFOEFft5hdJlHfTUyxSTP9XPrZE67DqssIBJ18y+B6eaYSRhUJvrkRfnAMqq1C5WF0u+SX5oHwn247iA4J8xsWlKZWGHlRBJ0Pn5qRLgf+1EiunjLO0tuqZQFhb62XfTbQgSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1qF0teyihLLOsI91rghRsUfMB1A62MIbYU70twJcbY=;
 b=owuR1jvW9HppZ7vygzO8E6KhHRwsp374r0C64d/+R0B4PTbWw6GbiXgFCwW0GIIiFvmlyAd3L28sUPl3BzH9ohnM5IikNgMl9vh36pBVjZGt+nJrjBjLRfQu3HLeCYkLzUC9KzoW45xlMD0PzE5YTWVNdpK5qr/6tKHwOjmtqaRoGFr7arac9j2ERp+4o5G8Sh1ki8Y2rujyJqJBiQ+mPSxBVT/qlYehb+kdCyVFqRQNxGFqS2/1WebQPyfTopUCyMFveaJKlS7H1dlR4+tzq83sie2yOyK8JbI8BDcePS9P8xcWALR3CcmnHnMc61O/xOmDQKUjl9OGJKF9j+b6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1qF0teyihLLOsI91rghRsUfMB1A62MIbYU70twJcbY=;
 b=jvJTf4L3nrRolbyGwImh1MH0USXtlgmp2ARj5x3Uq4jVrB2D+ebPj5zqJ3/SuqiFVytOcSyqnn9HcVrvTJZf4N2CrJV1U3DnNSQ66MyfsCyUQJ/zAmKfuiKJRMyjYCMUvwCpJZ1V0aW4V7+rH/as9czeWYbC4Dn71fXc2932ObDg6TNPOPtWjKd0WDygViN0H8e44i36H4XU5Vyk3QlGjSzRy9jOpVorKHuT0DJb8EtVXWG/A8TUJdTanXy+qvExugVjukcXUrU2mf4jynwKRkW4CeZzdIVEFvUJU/FTDW3iUh/iWtohUI0jXpQYAnx566k3rrPZNkbvpomju2aNfg==
Received: from BL1PR13CA0211.namprd13.prod.outlook.com (2603:10b6:208:2bf::6)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Sun, 8 Mar
 2026 06:56:51 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::e0) by BL1PR13CA0211.outlook.office365.com
 (2603:10b6:208:2bf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Sun,
 8 Mar 2026 06:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:56:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:43 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 4/8] net/mlx5: LAG, use xa_alloc to manage LAG device indices
Date: Sun, 8 Mar 2026 08:55:55 +0200
Message-ID: <20260308065559.1837449-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260308065559.1837449-1-tariqt@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eac3be6-1e30-4c01-7a89-08de7cdfe045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	v8jfrF8wux3awHmf6lUt+P1qE3mZQWdpW1aerbgVB32Ya+uQaeJKlJ36HQxMPIQvpfbvhne/QHnxgEeX0h64OuyOP5onH4dbffudLf5yu8lTmNdw2V8eUeyDhnpdIChGDeV9gH2EYvM2dTEtNsAJ4ZQECZ8j9A+A/IEj05wNFoPX6cRywJLX6EI+YQcYEPeDjRjNtcK7w/Ul8+o3+naZPugVVt4jLR813xcspPzSq5q/w2OytHKPmuD8dixX5ftor6+/2oaoqGiPi43QgrAVWzH+WecZfXtRpL3Jiwavm3AzzPMTN2/E66mkkX97ugHiHuaS5RYlEAxXUmnjOwG/Q1TO9XBFpcKKWuDrC4kbNhNUA+SpUdQEjA5CW6OQ+3M0pPTr2PPMZx1WKMGWhD+6xJBQQm7tGqdH1Wa1F2lfhzrFR9eW6W4IRXzjvdhC4N7VsUAni965dvG5721svJQ4YdodFRMoeuML1TNF8vhgNlXzdw0SCx6Hq+8z87QF6DCqH6+9pokTKmWEVQvFdK+P9B0BJvW/kL4Hf+1iGLBtJZMH/1nh8JmFd5P9JvJZXa9O3hvzSYIr+CdSNA8tAH7jZXFmORiA9KV5FGuL2YK4722sR30EheEbxMNzSm/Bq7WfoK/235uaTnr6buf3v43yIJl8rgDQ4UyyY1ZxLnSiE4dg9p2LtU1k7UYa7e2nu1biu6245aHS7NwTT0GamU88j2nqrqP55C/eUgmiBBtBoA8BTB6Q38YN9VaAwibBYzstG0jZyL3XLRVyb4oayzcF/g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0eYZm8pjFoNtWABYqMiY9wRnc9W8v4RThTsOqS85lxfMC7omGvzchATOnb4vilnJfFs0JmD+8JJWHBx3aZH3DHTpLBcWYUrYJiy7KwYtN2bbuO1q5v1WzN2CjIZ0T8ZNuE4f7wNnO6xKN2Uy4nC7QN3KKjnMvKu3pX0dg5zaG1RRX0j4cQf58Upl4i0eFELpqFfx0zkUk6kIbLGrr9/aK8OzZUMrDbC/iotyF8CZ52olnNdQQC0iRTHJ9v6uuBaOnBgntAVk9gOTwOFF9BInFjMPft7UiNPNb0nWoVoyQCw4s6F+szuyvL9xzgAXL2QZ/NNCtAHCc3uPtH9FM+r3/VK4D0SHLp3HtLOEK+TU7pWm/PHjJ19VdlGy8N93O+hitlNU+dO2rhhJbziHyc5Ao8NOukTx7/J18hx6jWY8OuY7cO/B9U0DbFeNneEW+8sE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:56:51.3480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eac3be6-1e30-4c01-7a89-08de7cdfe045
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
X-Rspamd-Queue-Id: A779C22ED0B
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17696-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Replace the use of mlx5_get_dev_index() for xarray indexing with
xa_alloc() to dynamically allocate indices. This decouples the LAG
xarray index from the physical device index.

Update mlx5_ldev_add_netdev/remove_mdev to find entries by dev pointer
and replace mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1) calls with
mlx5_lag_get_master_idx() where appropriate.

No functional changes intended

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 242 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  29 +++
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   3 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  12 +-
 4 files changed, 230 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 81b1f84f902e..4beee64c937a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -288,7 +288,7 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 
 	kref_init(&ldev->ref);
 	mutex_init(&ldev->lock);
-	xa_init(&ldev->pfs);
+	xa_init_flags(&ldev->pfs, XA_FLAGS_ALLOC);
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);
 	INIT_WORK(&ldev->speed_update_work, mlx5_mpesw_speed_update_work);
 
@@ -326,14 +326,42 @@ int mlx5_lag_dev_get_netdev_idx(struct mlx5_lag *ldev,
 	return -ENOENT;
 }
 
+static int mlx5_lag_get_master_idx(struct mlx5_lag *ldev)
+{
+	unsigned long idx = 0;
+	void *entry;
+
+	if (!ldev)
+		return -ENOENT;
+
+	entry = xa_find(&ldev->pfs, &idx, U8_MAX, MLX5_LAG_XA_MARK_MASTER);
+	if (!entry)
+		return -ENOENT;
+
+	return (int)idx;
+}
+
 int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq)
 {
-	int i, num = 0;
+	int master_idx, i, num = 0;
 
 	if (!ldev)
 		return -ENOENT;
 
+	master_idx = mlx5_lag_get_master_idx(ldev);
+
+	/* If seq 0 is requested and there's a primary PF, return it */
+	if (master_idx >= 0) {
+		if (seq == 0)
+			return master_idx;
+		num++;
+	}
+
 	mlx5_ldev_for_each(i, 0, ldev) {
+		/* Skip the primary PF in the loop */
+		if (i == master_idx)
+			continue;
+
 		if (num == seq)
 			return i;
 		num++;
@@ -341,6 +369,75 @@ int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq)
 	return -ENOENT;
 }
 
+/* Devcom events for LAG master marking */
+#define LAG_DEVCOM_PAIR		(0)
+#define LAG_DEVCOM_UNPAIR	(1)
+
+static void mlx5_lag_mark_master(struct mlx5_lag *ldev)
+{
+	int lowest_dev_idx = INT_MAX;
+	struct lag_func *pf;
+	int master_xa_idx = -1;
+	int dev_idx;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		dev_idx = mlx5_get_dev_index(pf->dev);
+		if (dev_idx < lowest_dev_idx) {
+			lowest_dev_idx = dev_idx;
+			master_xa_idx = i;
+		}
+	}
+
+	if (master_xa_idx >= 0)
+		xa_set_mark(&ldev->pfs, master_xa_idx, MLX5_LAG_XA_MARK_MASTER);
+}
+
+static void mlx5_lag_clear_master(struct mlx5_lag *ldev)
+{
+	unsigned long idx = 0;
+	void *entry;
+
+	entry = xa_find(&ldev->pfs, &idx, U8_MAX, MLX5_LAG_XA_MARK_MASTER);
+	if (!entry)
+		return;
+
+	xa_clear_mark(&ldev->pfs, idx, MLX5_LAG_XA_MARK_MASTER);
+}
+
+/* Devcom event handler to manage LAG master marking */
+static int mlx5_lag_devcom_event(int event, void *my_data, void *event_data)
+{
+	struct mlx5_core_dev *dev = my_data;
+	struct mlx5_lag *ldev;
+	int idx;
+
+	ldev = mlx5_lag_dev(dev);
+	if (!ldev)
+		return 0;
+
+	mutex_lock(&ldev->lock);
+	switch (event) {
+	case LAG_DEVCOM_PAIR:
+		/* No need to mark more than once */
+		idx = mlx5_lag_get_master_idx(ldev);
+		if (idx >= 0)
+			break;
+		/* Check if all LAG ports are now registered */
+		if (mlx5_lag_num_devs(ldev) == ldev->ports)
+			mlx5_lag_mark_master(ldev);
+		break;
+
+	case LAG_DEVCOM_UNPAIR:
+		/* Clear master mark when a device is removed */
+		mlx5_lag_clear_master(ldev);
+		break;
+	}
+	mutex_unlock(&ldev->lock);
+	return 0;
+}
+
 int mlx5_lag_num_devs(struct mlx5_lag *ldev)
 {
 	int i, num = 0;
@@ -411,11 +508,12 @@ static void mlx5_infer_tx_affinity_mapping(struct lag_tracker *tracker,
 
 	/* Use native mapping by default where each port's buckets
 	 * point the native port: 1 1 1 .. 1 2 2 2 ... 2 3 3 3 ... 3 etc
+	 * ports[] values are 1-indexed device indices for FW.
 	 */
 	mlx5_ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < buckets; j++) {
 			idx = i * buckets + j;
-			ports[idx] = i + 1;
+			ports[idx] = mlx5_lag_xa_to_dev_idx(ldev, i) + 1;
 		}
 	}
 
@@ -427,8 +525,12 @@ static void mlx5_infer_tx_affinity_mapping(struct lag_tracker *tracker,
 	/* Go over the disabled ports and for each assign a random active port */
 	for (i = 0; i < disabled_ports_num; i++) {
 		for (j = 0; j < buckets; j++) {
+			int rand_xa_idx;
+
 			get_random_bytes(&rand, 4);
-			ports[disabled[i] * buckets + j] = enabled[rand % enabled_ports_num] + 1;
+			rand_xa_idx = enabled[rand % enabled_ports_num];
+			ports[disabled[i] * buckets + j] =
+				mlx5_lag_xa_to_dev_idx(ldev, rand_xa_idx) + 1;
 		}
 	}
 }
@@ -683,20 +785,23 @@ char *mlx5_get_str_port_sel_mode(enum mlx5_lag_mode mode, unsigned long flags)
 
 static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 {
-	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	int master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_eswitch *master_esw;
 	struct mlx5_core_dev *dev0;
 	int i, j;
 	int err;
 
-	if (first_idx < 0)
+	if (master_idx < 0)
 		return -EINVAL;
 
-	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
 	master_esw = dev0->priv.eswitch;
-	mlx5_ldev_for_each(i, first_idx + 1, ldev) {
+	mlx5_ldev_for_each(i, 0, ldev) {
 		struct mlx5_eswitch *slave_esw;
 
+		if (i == master_idx)
+			continue;
+
 		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
 
 		err = mlx5_eswitch_offloads_single_fdb_add_one(master_esw,
@@ -706,9 +811,12 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	}
 	return 0;
 err:
-	mlx5_ldev_for_each_reverse(j, i, first_idx + 1, ldev)
+	mlx5_ldev_for_each_reverse(j, i, 0, ldev) {
+		if (j == master_idx)
+			continue;
 		mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
 							 mlx5_lag_pf(ldev, j)->dev->priv.eswitch);
+	}
 	return err;
 }
 
@@ -717,8 +825,8 @@ static int mlx5_create_lag(struct mlx5_lag *ldev,
 			   enum mlx5_lag_mode mode,
 			   unsigned long flags)
 {
-	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
 	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
 	u32 in[MLX5_ST_SZ_DW(destroy_lag_in)] = {};
 	struct mlx5_core_dev *dev0;
 	int err;
@@ -764,16 +872,17 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 		      enum mlx5_lag_mode mode,
 		      bool shared_fdb)
 {
-	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	bool roce_lag = mode == MLX5_LAG_MODE_ROCE;
 	struct mlx5_core_dev *dev0;
 	unsigned long flags = 0;
+	int master_idx;
 	int err;
 
-	if (first_idx < 0)
+	master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	if (master_idx < 0)
 		return -EINVAL;
 
-	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
 	err = mlx5_lag_set_flags(ldev, mode, tracker, shared_fdb, &flags);
 	if (err)
 		return err;
@@ -817,7 +926,7 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 
 int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 {
-	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	int master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	u32 in[MLX5_ST_SZ_DW(destroy_lag_in)] = {};
 	bool roce_lag = __mlx5_lag_is_roce(ldev);
 	unsigned long flags = ldev->mode_flags;
@@ -826,19 +935,22 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	int err;
 	int i;
 
-	if (first_idx < 0)
+	if (master_idx < 0)
 		return -EINVAL;
 
-	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
 	master_esw = dev0->priv.eswitch;
 	ldev->mode = MLX5_LAG_MODE_NONE;
 	ldev->mode_flags = 0;
 	mlx5_lag_mp_reset(ldev);
 
 	if (test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags)) {
-		mlx5_ldev_for_each(i, first_idx + 1, ldev)
+		mlx5_ldev_for_each(i, 0, ldev) {
+			if (i == master_idx)
+				continue;
 			mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
 								 mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+		}
 		clear_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
 	}
 
@@ -868,7 +980,7 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 {
-	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	int master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 #ifdef CONFIG_MLX5_ESWITCH
 	struct mlx5_core_dev *dev;
 	u8 mode;
@@ -877,7 +989,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	bool roce_support;
 	int i;
 
-	if (first_idx < 0 || mlx5_lag_num_devs(ldev) != ldev->ports)
+	if (master_idx < 0 || mlx5_lag_num_devs(ldev) != ldev->ports)
 		return false;
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -888,7 +1000,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 			return false;
 	}
 
-	pf = mlx5_lag_pf(ldev, first_idx);
+	pf = mlx5_lag_pf(ldev, master_idx);
 	dev = pf->dev;
 	mode = mlx5_eswitch_mode(dev);
 	mlx5_ldev_for_each(i, 0, ldev) {
@@ -904,9 +1016,11 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 			return false;
 	}
 #endif
-	pf = mlx5_lag_pf(ldev, first_idx);
+	pf = mlx5_lag_pf(ldev, master_idx);
 	roce_support = mlx5_get_roce_state(pf->dev);
-	mlx5_ldev_for_each(i, first_idx + 1, ldev) {
+	mlx5_ldev_for_each(i, 0, ldev) {
+		if (i == master_idx)
+			continue;
 		pf = mlx5_lag_pf(ldev, i);
 		if (mlx5_get_roce_state(pf->dev) != roce_support)
 			return false;
@@ -967,8 +1081,11 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 			dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
 		}
-		mlx5_ldev_for_each(i, idx + 1, ldev)
+		mlx5_ldev_for_each(i, 0, ldev) {
+			if (i == idx)
+				continue;
 			mlx5_nic_vport_disable_roce(mlx5_lag_pf(ldev, i)->dev);
+		}
 	}
 
 	err = mlx5_deactivate_lag(ldev);
@@ -986,14 +1103,18 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 {
-	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev;
+	bool ret = false;
+	int idx;
 	int i;
 
+	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	if (idx < 0)
 		return false;
 
-	mlx5_ldev_for_each(i, idx + 1, ldev) {
+	mlx5_ldev_for_each(i, 0, ldev) {
+		if (i == idx)
+			continue;
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		if (is_mdev_switchdev_mode(dev) &&
 		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
@@ -1011,9 +1132,9 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
 	    MLX5_CAP_ESW(dev, esw_shared_ingress_acl) &&
 	    mlx5_eswitch_get_npeers(dev->priv.eswitch) == MLX5_CAP_GEN(dev, num_lag_ports) - 1)
-		return true;
+		ret = true;
 
-	return false;
+	return ret;
 }
 
 static bool mlx5_lag_is_roce_lag(struct mlx5_lag *ldev)
@@ -1239,12 +1360,16 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			}
 
 			return;
-		} else if (roce_lag) {
+		}
+
+		if (roce_lag) {
 			struct mlx5_core_dev *dev;
 
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-			mlx5_ldev_for_each(i, idx + 1, ldev) {
+			mlx5_ldev_for_each(i, 0, ldev) {
+				if (i == idx)
+					continue;
 				dev = mlx5_lag_pf(ldev, i)->dev;
 				if (mlx5_get_roce_state(dev))
 					mlx5_nic_vport_enable_roce(dev);
@@ -1598,15 +1723,21 @@ static void mlx5_ldev_add_netdev(struct mlx5_lag *ldev,
 				struct mlx5_core_dev *dev,
 				struct net_device *netdev)
 {
-	unsigned int fn = mlx5_get_dev_index(dev);
 	struct lag_func *pf;
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&lag_lock, flags);
-	pf = mlx5_lag_pf(ldev, fn);
-	pf->netdev = netdev;
-	ldev->tracker.netdev_state[fn].link_up = 0;
-	ldev->tracker.netdev_state[fn].tx_enabled = 0;
+	/* Find pf entry by matching dev pointer */
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev) {
+			pf->netdev = netdev;
+			ldev->tracker.netdev_state[i].link_up = 0;
+			ldev->tracker.netdev_state[i].tx_enabled = 0;
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&lag_lock, flags);
 }
 
@@ -1631,23 +1762,22 @@ static void mlx5_ldev_remove_netdev(struct mlx5_lag *ldev,
 static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
 			      struct mlx5_core_dev *dev)
 {
-	unsigned int fn = mlx5_get_dev_index(dev);
 	struct lag_func *pf;
+	u32 idx;
 	int err;
 
-	pf = xa_load(&ldev->pfs, fn);
-	if (!pf) {
-		pf = kzalloc_obj(*pf);
-		if (!pf)
-			return -ENOMEM;
+	pf = kzalloc_obj(*pf);
+	if (!pf)
+		return -ENOMEM;
 
-		err = xa_err(xa_store(&ldev->pfs, fn, pf, GFP_KERNEL));
-		if (err) {
-			kfree(pf);
-			return err;
-		}
+	err = xa_alloc(&ldev->pfs, &idx, pf, XA_LIMIT(0, MLX5_MAX_PORTS - 1),
+		       GFP_KERNEL);
+	if (err) {
+		kfree(pf);
+		return err;
 	}
 
+	pf->idx = idx;
 	pf->dev = dev;
 	dev->priv.lag = ldev;
 
@@ -1662,11 +1792,14 @@ static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
 				  struct mlx5_core_dev *dev)
 {
 	struct lag_func *pf;
-	int fn;
+	int i;
 
-	fn = mlx5_get_dev_index(dev);
-	pf = xa_load(&ldev->pfs, fn);
-	if (!pf || pf->dev != dev)
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev)
+			break;
+	}
+	if (i >= MLX5_MAX_PORTS)
 		return;
 
 	if (pf->port_change_nb.nb.notifier_call)
@@ -1674,7 +1807,7 @@ static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
 
 	pf->dev = NULL;
 	dev->priv.lag = NULL;
-	xa_erase(&ldev->pfs, fn);
+	xa_erase(&ldev->pfs, pf->idx);
 	kfree(pf);
 }
 
@@ -1744,7 +1877,8 @@ static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 	dev->priv.hca_devcom_comp =
 		mlx5_devcom_register_component(dev->priv.devc,
 					       MLX5_DEVCOM_HCA_PORTS,
-					       &attr, NULL, dev);
+					       &attr, mlx5_lag_devcom_event,
+					       dev);
 	if (!dev->priv.hca_devcom_comp) {
 		mlx5_core_err(dev,
 			      "Failed to register devcom HCA component.");
@@ -1775,6 +1909,9 @@ void mlx5_lag_remove_mdev(struct mlx5_core_dev *dev)
 	}
 	mlx5_ldev_remove_mdev(ldev, dev);
 	mutex_unlock(&ldev->lock);
+	/* Send devcom event to notify peers that a device is being removed */
+	mlx5_devcom_send_event(dev->priv.hca_devcom_comp,
+			       LAG_DEVCOM_UNPAIR, LAG_DEVCOM_UNPAIR, dev);
 	mlx5_lag_unregister_hca_devcom_comp(dev);
 	mlx5_ldev_put(ldev);
 }
@@ -1798,6 +1935,9 @@ void mlx5_lag_add_mdev(struct mlx5_core_dev *dev)
 		msleep(100);
 		goto recheck;
 	}
+	/* Send devcom event to notify peers that a device was added */
+	mlx5_devcom_send_event(dev->priv.hca_devcom_comp,
+			       LAG_DEVCOM_PAIR, LAG_DEVCOM_UNPAIR, dev);
 	mlx5_ldev_add_debugfs(dev);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 09758871b3da..30cbd61768f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -7,6 +7,12 @@
 #include <linux/debugfs.h>
 
 #define MLX5_LAG_MAX_HASH_BUCKETS 16
+/* XArray mark for the LAG master device
+ * (device with lowest mlx5_get_dev_index).
+ * Note: XA_MARK_0 is reserved by XA_FLAGS_ALLOC for free-slot tracking.
+ */
+#define MLX5_LAG_XA_MARK_MASTER XA_MARK_1
+
 #include "mlx5_core.h"
 #include "mp.h"
 #include "port_sel.h"
@@ -39,6 +45,7 @@ struct lag_func {
 	struct mlx5_core_dev *dev;
 	struct net_device    *netdev;
 	bool has_drop;
+	unsigned int idx; /* xarray index assigned by LAG */
 	struct mlx5_nb port_change_nb;
 };
 
@@ -90,6 +97,28 @@ mlx5_lag_pf(struct mlx5_lag *ldev, unsigned int idx)
 	return xa_load(&ldev->pfs, idx);
 }
 
+/* Get device index (mlx5_get_dev_index) from xarray index */
+static inline int mlx5_lag_xa_to_dev_idx(struct mlx5_lag *ldev, int xa_idx)
+{
+	struct lag_func *pf = mlx5_lag_pf(ldev, xa_idx);
+
+	return pf ? mlx5_get_dev_index(pf->dev) : -ENOENT;
+}
+
+/* Find lag_func by device index (reverse lookup from mlx5_get_dev_index) */
+static inline struct lag_func *
+mlx5_lag_pf_by_dev_idx(struct mlx5_lag *ldev, int dev_idx)
+{
+	struct lag_func *pf;
+	unsigned long idx;
+
+	xa_for_each(&ldev->pfs, idx, pf) {
+		if (mlx5_get_dev_index(pf->dev) == dev_idx)
+			return pf;
+	}
+	return NULL;
+}
+
 static inline bool
 __mlx5_lag_is_active(struct mlx5_lag *ldev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 0e7d206cd594..5eea12a6887a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -67,9 +67,9 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 
 static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 {
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev0;
 	int err;
-	int idx;
 	int i;
 
 	if (ldev->mode == MLX5_LAG_MODE_MPESW)
@@ -78,7 +78,6 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	if (ldev->mode != MLX5_LAG_MODE_NONE)
 		return -EINVAL;
 
-	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	if (idx < 0)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 7e9e3e81977d..2a034b2a3eee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -84,8 +84,11 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 			idx = i * ldev->buckets + j;
 			affinity = ports[idx];
 
+			/* affinity is 1-indexed device index,
+			 * use reverse lookup.
+			 */
 			dest.vport.vhca_id =
-				MLX5_CAP_GEN(mlx5_lag_pf(ldev, affinity - 1)->dev,
+				MLX5_CAP_GEN(mlx5_lag_pf_by_dev_idx(ldev, affinity - 1)->dev,
 					     vhca_id);
 			lag_definer->rules[idx] = mlx5_add_flow_rules(lag_definer->ft,
 								      NULL, &flow_act,
@@ -358,7 +361,7 @@ static void mlx5_lag_destroy_definer(struct mlx5_lag *ldev,
 		return;
 
 	dev = mlx5_lag_pf(ldev, first_idx)->dev;
-	mlx5_ldev_for_each(i, first_idx, ldev) {
+	mlx5_ldev_for_each(i, 0, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
 			mlx5_del_flow_rules(lag_definer->rules[idx]);
@@ -595,8 +598,11 @@ static int __mlx5_lag_modify_definers_destinations(struct mlx5_lag *ldev,
 			if (ldev->v2p_map[idx] == ports[idx])
 				continue;
 
+			/* ports[] contains 1-indexed device indices,
+			 * use reverse lookup.
+			 */
 			dest.vport.vhca_id =
-				MLX5_CAP_GEN(mlx5_lag_pf(ldev, ports[idx] - 1)->dev,
+				MLX5_CAP_GEN(mlx5_lag_pf_by_dev_idx(ldev, ports[idx] - 1)->dev,
 					     vhca_id);
 			err = mlx5_modify_rule_destination(def->rules[idx], &dest, NULL);
 			if (err)
-- 
2.44.0


