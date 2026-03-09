Return-Path: <linux-rdma+bounces-17758-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJkqKyuVrmnqGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17758-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:38:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51F236471
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66103068F27
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A537AA78;
	Mon,  9 Mar 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jV/fXjyY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231937B3E1;
	Mon,  9 Mar 2026 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048937; cv=fail; b=dwM3y5CnZARGeYOZwlqkz6jUOiHblyJi0PxVE6tucfmuIlwIa0gbw1D5p/i7SK5X7jL2NtF3bUhewzLYft9q3elUrJ1DN1AvwVsfNeP/bT8Z0OcpfDW+oJmvIU9ymaLryt1mPmlTXA2S186ii9JmK7Dr1uMpHxDQPRos9WF9nJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048937; c=relaxed/simple;
	bh=0yR2HAl9d3DX2+T6r6Ukt7MWib6Bjsdhk3FHuxttulw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZ4A2MU1BEv9liZcfSmM6PCATgKwb4Mp2m3fnZ7g8mpqk4XJ8imDzj59YSl4t9opXmERKNeQgSQrtCIwFnIcotXwT9p+g5sobswenR289zmZyhFOhQjDGILQEtAxH2Xs4eY2csvuuoZlFnQ4K91ALumV/MF7PHJrJy6XBrxBeGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jV/fXjyY; arc=fail smtp.client-ip=40.107.200.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPuYNNdlRNmEKFCvxic3BvoU5/4icup7tQe9myYgWkeAS4zypDxm7ClfPHluS6OUUqvhQgdT0Z5dk1I+cNSPeB0j5YXfV+04NE5XbO6bj/fRIf7zHknMCw+1xWZUTsRtHdXldWGTizfFBeEZiNgHM5dYoTMZd4LEBKQNeA+iYOvobOLmpLKBe6nzEUC/govOkc7iRgCkQ2rie6aZAI1BOriniLQwKRb9elA+9kQAMfctJJPMN/9abwAm/lgImwqP/BMV1ec6h+Cy6823f1aJVBiOHMJh/ZvN58Qo40178dB54nr20Tmh+gHg6O6cbz1jc77ZRxb2UV43X1G3Ak/mTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfo5q2E3/5l/8mYL04XEBFXBuJtCNLqgvUu+LA19EA4=;
 b=otXl5ZI6K3KGdkOb/ThH/AEYD21Efh3+3XPnXWrQGZ+rqWWACWgzjOhADGPP2qJ2UuisjzP1RCXuxU+t7zKMFmgL0UGJobqmTIQiYGFV70D/5bA5y+TKVBRi+6RjnilssgOqKA2+8Ehp+l1u5gYgcMUz0Ke8GL8GeUsAnF0LK8EvgPIjZwj7pOiZSde/1WMTFnfaMoRO4Wv4k/SNwjveWY29mQgsvWu8Wu5C0RCuo7cIZNvalWPo8MyVasiD+TfnHs7racx/8JzM+5sAatc27tPNh+tB5XjL1AEQA72Qx4dh3yPCmJ6hNQWdUML62LWTXXZSZgz1N0MvK5zbkjRO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfo5q2E3/5l/8mYL04XEBFXBuJtCNLqgvUu+LA19EA4=;
 b=jV/fXjyYtcllzVyR8iLJkPW6cWNsn6h+SFRGp5MvMfHEDx0q4WynNeZL+2F2/uwSbKV3RJa3aE2Do66R/aFg3js0/xXjgpfj8gBYJeViF917SwWXXB/xPNcIctOXmmY4l5ArSao0F5So8L5H5oKlAqwFxaURlCdTUipmlcaKDwdm+xB+g4TttiBDdzrpGjztKfp/E06X+siy/7n4gPVF93oEsxyvQXDiS6jGkeM8huGpjxXgVMwGkSEkYdLsPC0w3qi40N6Q5qqU+ci7RRdSNge2FntH4pkc0CtH2xXFvtFl1veKT6jugzI+69JVqKCqE7AxL+KRo8PkDckLEi5D8w==
Received: from BYAPR11CA0056.namprd11.prod.outlook.com (2603:10b6:a03:80::33)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Mon, 9 Mar
 2026 09:35:23 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:80:cafe::a5) by BYAPR11CA0056.outlook.office365.com
 (2603:10b6:a03:80::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 09:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:35:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:35:00 -0700
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
Subject: [PATCH mlx5-next V2 3/9] net/mlx5: LAG, replace pf array with xarray
Date: Mon, 9 Mar 2026 11:34:29 +0200
Message-ID: <20260309093435.1850724-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1afdbe-5894-4379-fb62-08de7dbf2fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|7142099003;
X-Microsoft-Antispam-Message-Info:
	qQiYqk9jiZ6t4wOu1Wa68uGpwk1vqJsfnQonwvARXy3szsbDFA24/dz5pfMGCYyR+mw/uf4ECqleGAwj9TJxZxKYBUPNau/m6lR+UnlgAa7iTZ+URN0CicglhY/QdoqVxrP76FRsoKD6d6r0/rsbQ7rrLQt9U2UmsSDC0SZsnbKsEX9p2iNPG05LBEbe4bsLJ0d9WonhuWvyvJB8qcwLuHHbs5MOxzyzznNApU4PIRMVBKPTO7grg/UyJ79zhvRfAaUZpJrPRBduy+Whlz8fWw+EuVW6cr+0t9zXadqnWslkq9eAwFv+VPxIuTJ2nZCnpGd3iY0foVlB6KioEoY+bd5lrBO5MIgMp+vPX5kWt0rgKZGT0nztpXyKaO0VXuehCYEflNFyElFiobF9p73tDw7YhgVxGLHYTqN/jXLkAP4zZ4ZyIGtHyCN7xqPV23DI/hjsgrSIaGT8jCdq+cUUFGIY2jBlwmy7mFN3PfBhV+gPspxKn23O0hImKiWrnnGyTq7woN9LlLkikicZw1lKq5C/EwLjU1CHGo2uk0IZLgeRygj1w8MEv+9rAHwSy5uStm53p0iELwuj4scle86gteaSxa7cD414rlNsVJ1Ls+FNb4vknTqHrQ0jRlW0YEKW3JXryZlCDKkwtKOZitGFYdxiB16+/ArlC3KBEnUurf1a7QTEaZfufbkpRin+9LRUFrtkhxG21DlZOt08yrQL+YVaQDw1lMtA0xa/3jg2ew1o0SwT3nqLiKby4956Wj7Xc3R/e2rRVtZLzamj6sy9dQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SEzihYjs5SPQ39XHCSpHMkv5s4esyn9+1lhUmSqiPBHmhcCGk7kuVzDNgwzMmNaWxO7niKpYK03uJ2gKT9UnuUgb92/VbLTguVz+V1l+6lZ83vuAo4NLMoU8Tr3TPnKz3mUFoxLZT6Y+RkoVNOKNwKZfmYK9mdcklmX4N7Tsbj2iwz9EAoH617CpsXF9ZrwuFmuE0CDqDvfTIm9Z7l8Mc1FuOXcvnvwrvvKYlkR9UPT8hMkW++HKeEUyXE6OWvIRmet71QEwbPSi5CTUMAvNcO9sza4b79iOLxnmhMC/R8pVacd68isdsxGFTFhho3NWmj1RykWLkNM4mCrb4zzHcQ7wNQL1XPoO2+SPwFVvKHUzI2bQwnHHoi0h63J7BmDIpbrwuUC8DsD3b8lqgzN8dt+aWDsQrMScO0VwbD/VW+u4z7iVtqlNuCH3vtuezFMU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:22.6287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1afdbe-5894-4379-fb62-08de7dbf2fcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
X-Rspamd-Queue-Id: DA51F236471
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17758-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Replace the fixed-size array with a dynamic xarray.

This commit changes:
- Adds mlx5_lag_pf() helper for consistent xarray access
- Converts all direct pf[] accesses to use the new helper/macro
- Dynamically allocates lag_func entries via xa_store/xa_load

No functional changes intended. This prepares the LAG infrastructure
for future flexibility in device indexing.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 300 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   8 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  20 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  12 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  20 +-
 6 files changed, 243 insertions(+), 120 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
index 62b6faa4276a..37de4be0e620 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
@@ -145,7 +145,8 @@ static int members_show(struct seq_file *file, void *priv)
 	ldev = mlx5_lag_dev(dev);
 	mutex_lock(&ldev->lock);
 	mlx5_ldev_for_each(i, 0, ldev)
-		seq_printf(file, "%s\n", dev_name(ldev->pf[i].dev->device));
+		seq_printf(file, "%s\n",
+			   dev_name(mlx5_lag_pf(ldev, i)->dev->device));
 	mutex_unlock(&ldev->lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 044adfdf9aa2..81b1f84f902e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -232,6 +232,7 @@ static void mlx5_do_bond_work(struct work_struct *work);
 static void mlx5_ldev_free(struct kref *ref)
 {
 	struct mlx5_lag *ldev = container_of(ref, struct mlx5_lag, ref);
+	struct lag_func *pf;
 	struct net *net;
 	int i;
 
@@ -241,13 +242,16 @@ static void mlx5_ldev_free(struct kref *ref)
 	}
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		if (ldev->pf[i].dev &&
-		    ldev->pf[i].port_change_nb.nb.notifier_call) {
-			struct mlx5_nb *nb = &ldev->pf[i].port_change_nb;
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->port_change_nb.nb.notifier_call) {
+			struct mlx5_nb *nb = &pf->port_change_nb;
 
-			mlx5_eq_notifier_unregister(ldev->pf[i].dev, nb);
+			mlx5_eq_notifier_unregister(pf->dev, nb);
 		}
+		xa_erase(&ldev->pfs, i);
+		kfree(pf);
 	}
+	xa_destroy(&ldev->pfs);
 
 	mlx5_lag_mp_cleanup(ldev);
 	cancel_delayed_work_sync(&ldev->bond_work);
@@ -284,6 +288,7 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 
 	kref_init(&ldev->ref);
 	mutex_init(&ldev->lock);
+	xa_init(&ldev->pfs);
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);
 	INIT_WORK(&ldev->speed_update_work, mlx5_mpesw_speed_update_work);
 
@@ -309,11 +314,14 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 int mlx5_lag_dev_get_netdev_idx(struct mlx5_lag *ldev,
 				struct net_device *ndev)
 {
+	struct lag_func *pf;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev)
-		if (ldev->pf[i].netdev == ndev)
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->netdev == ndev)
 			return i;
+	}
 
 	return -ENOENT;
 }
@@ -349,14 +357,17 @@ int mlx5_lag_num_devs(struct mlx5_lag *ldev)
 
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev)
 {
+	struct lag_func *pf;
 	int i, num = 0;
 
 	if (!ldev)
 		return 0;
 
-	mlx5_ldev_for_each(i, 0, ldev)
-		if (ldev->pf[i].netdev)
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->netdev)
 			num++;
+	}
 	return num;
 }
 
@@ -424,25 +435,30 @@ static void mlx5_infer_tx_affinity_mapping(struct lag_tracker *tracker,
 
 static bool mlx5_lag_has_drop_rule(struct mlx5_lag *ldev)
 {
+	struct lag_func *pf;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev)
-		if (ldev->pf[i].has_drop)
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->has_drop)
 			return true;
+	}
 	return false;
 }
 
 static void mlx5_lag_drop_rule_cleanup(struct mlx5_lag *ldev)
 {
+	struct lag_func *pf;
 	int i;
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		if (!ldev->pf[i].has_drop)
+		pf = mlx5_lag_pf(ldev, i);
+		if (!pf->has_drop)
 			continue;
 
-		mlx5_esw_acl_ingress_vport_drop_rule_destroy(ldev->pf[i].dev->priv.eswitch,
+		mlx5_esw_acl_ingress_vport_drop_rule_destroy(pf->dev->priv.eswitch,
 							     MLX5_VPORT_UPLINK);
-		ldev->pf[i].has_drop = false;
+		pf->has_drop = false;
 	}
 }
 
@@ -451,6 +467,7 @@ static void mlx5_lag_drop_rule_setup(struct mlx5_lag *ldev,
 {
 	u8 disabled_ports[MLX5_MAX_PORTS] = {};
 	struct mlx5_core_dev *dev;
+	struct lag_func *pf;
 	int disabled_index;
 	int num_disabled;
 	int err;
@@ -468,11 +485,12 @@ static void mlx5_lag_drop_rule_setup(struct mlx5_lag *ldev,
 
 	for (i = 0; i < num_disabled; i++) {
 		disabled_index = disabled_ports[i];
-		dev = ldev->pf[disabled_index].dev;
+		pf = mlx5_lag_pf(ldev, disabled_index);
+		dev = pf->dev;
 		err = mlx5_esw_acl_ingress_vport_drop_rule_create(dev->priv.eswitch,
 								  MLX5_VPORT_UPLINK);
 		if (!err)
-			ldev->pf[disabled_index].has_drop = true;
+			pf->has_drop = true;
 		else
 			mlx5_core_err(dev,
 				      "Failed to create lag drop rule, error: %d", err);
@@ -504,7 +522,7 @@ static int _mlx5_modify_lag(struct mlx5_lag *ldev, u8 *ports)
 	if (idx < 0)
 		return -EINVAL;
 
-	dev0 = ldev->pf[idx].dev;
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &ldev->mode_flags)) {
 		ret = mlx5_lag_port_sel_modify(ldev, ports);
 		if (ret ||
@@ -521,6 +539,7 @@ static int _mlx5_modify_lag(struct mlx5_lag *ldev, u8 *ports)
 static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev *dev)
 {
 	struct net_device *ndev = NULL;
+	struct lag_func *pf;
 	struct mlx5_lag *ldev;
 	unsigned long flags;
 	int i, last_idx;
@@ -531,14 +550,17 @@ static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev
 	if (!ldev)
 		goto unlock;
 
-	mlx5_ldev_for_each(i, 0, ldev)
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
 		if (ldev->tracker.netdev_state[i].tx_enabled)
-			ndev = ldev->pf[i].netdev;
+			ndev = pf->netdev;
+	}
 	if (!ndev) {
 		last_idx = mlx5_lag_get_dev_index_by_seq(ldev, ldev->ports - 1);
 		if (last_idx < 0)
 			goto unlock;
-		ndev = ldev->pf[last_idx].netdev;
+		pf = mlx5_lag_pf(ldev, last_idx);
+		ndev = pf->netdev;
 	}
 
 	dev_hold(ndev);
@@ -563,7 +585,7 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 	if (first_idx < 0)
 		return;
 
-	dev0 = ldev->pf[first_idx].dev;
+	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
 	mlx5_infer_tx_affinity_mapping(tracker, ldev, ldev->buckets, ports);
 
 	mlx5_ldev_for_each(i, 0, ldev) {
@@ -615,7 +637,7 @@ static int mlx5_lag_set_port_sel_mode(struct mlx5_lag *ldev,
 	    mode == MLX5_LAG_MODE_MULTIPATH)
 		return 0;
 
-	dev0 = ldev->pf[first_idx].dev;
+	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
 
 	if (!MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table)) {
 		if (ldev->ports > 2)
@@ -670,10 +692,12 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev0 = ldev->pf[first_idx].dev;
+	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
 	master_esw = dev0->priv.eswitch;
 	mlx5_ldev_for_each(i, first_idx + 1, ldev) {
-		struct mlx5_eswitch *slave_esw = ldev->pf[i].dev->priv.eswitch;
+		struct mlx5_eswitch *slave_esw;
+
+		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
 
 		err = mlx5_eswitch_offloads_single_fdb_add_one(master_esw,
 							       slave_esw, ldev->ports);
@@ -684,7 +708,7 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 err:
 	mlx5_ldev_for_each_reverse(j, i, first_idx + 1, ldev)
 		mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
-							 ldev->pf[j].dev->priv.eswitch);
+							 mlx5_lag_pf(ldev, j)->dev->priv.eswitch);
 	return err;
 }
 
@@ -702,7 +726,7 @@ static int mlx5_create_lag(struct mlx5_lag *ldev,
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev0 = ldev->pf[first_idx].dev;
+	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
 	if (tracker)
 		mlx5_lag_print_mapping(dev0, ldev, tracker, flags);
 	mlx5_core_info(dev0, "shared_fdb:%d mode:%s\n",
@@ -749,7 +773,7 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev0 = ldev->pf[first_idx].dev;
+	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
 	err = mlx5_lag_set_flags(ldev, mode, tracker, shared_fdb, &flags);
 	if (err)
 		return err;
@@ -805,7 +829,7 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev0 = ldev->pf[first_idx].dev;
+	dev0 = mlx5_lag_pf(ldev, first_idx)->dev;
 	master_esw = dev0->priv.eswitch;
 	ldev->mode = MLX5_LAG_MODE_NONE;
 	ldev->mode_flags = 0;
@@ -814,7 +838,7 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	if (test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags)) {
 		mlx5_ldev_for_each(i, first_idx + 1, ldev)
 			mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
-								 ldev->pf[i].dev->priv.eswitch);
+								 mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 		clear_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
 	}
 
@@ -849,6 +873,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev;
 	u8 mode;
 #endif
+	struct lag_func *pf;
 	bool roce_support;
 	int i;
 
@@ -857,55 +882,66 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 
 #ifdef CONFIG_MLX5_ESWITCH
 	mlx5_ldev_for_each(i, 0, ldev) {
-		dev = ldev->pf[i].dev;
+		pf = mlx5_lag_pf(ldev, i);
+		dev = pf->dev;
 		if (mlx5_eswitch_num_vfs(dev->priv.eswitch) && !is_mdev_switchdev_mode(dev))
 			return false;
 	}
 
-	dev = ldev->pf[first_idx].dev;
+	pf = mlx5_lag_pf(ldev, first_idx);
+	dev = pf->dev;
 	mode = mlx5_eswitch_mode(dev);
-	mlx5_ldev_for_each(i, 0, ldev)
-		if (mlx5_eswitch_mode(ldev->pf[i].dev) != mode)
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (mlx5_eswitch_mode(pf->dev) != mode)
 			return false;
+	}
 
 #else
-	mlx5_ldev_for_each(i, 0, ldev)
-		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (mlx5_sriov_is_enabled(pf->dev))
 			return false;
+	}
 #endif
-	roce_support = mlx5_get_roce_state(ldev->pf[first_idx].dev);
-	mlx5_ldev_for_each(i, first_idx + 1, ldev)
-		if (mlx5_get_roce_state(ldev->pf[i].dev) != roce_support)
+	pf = mlx5_lag_pf(ldev, first_idx);
+	roce_support = mlx5_get_roce_state(pf->dev);
+	mlx5_ldev_for_each(i, first_idx + 1, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (mlx5_get_roce_state(pf->dev) != roce_support)
 			return false;
+	}
 
 	return true;
 }
 
 void mlx5_lag_add_devices(struct mlx5_lag *ldev)
 {
+	struct lag_func *pf;
 	int i;
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		if (ldev->pf[i].dev->priv.flags &
-		    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
 			continue;
 
-		ldev->pf[i].dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-		mlx5_rescan_drivers_locked(ldev->pf[i].dev);
+		pf->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+		mlx5_rescan_drivers_locked(pf->dev);
 	}
 }
 
 void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
 {
+	struct lag_func *pf;
 	int i;
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		if (ldev->pf[i].dev->priv.flags &
-		    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
 			continue;
 
-		ldev->pf[i].dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-		mlx5_rescan_drivers_locked(ldev->pf[i].dev);
+		pf->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+		mlx5_rescan_drivers_locked(pf->dev);
 	}
 }
 
@@ -921,7 +957,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (idx < 0)
 		return;
 
-	dev0 = ldev->pf[idx].dev;
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	roce_lag = __mlx5_lag_is_roce(ldev);
 
 	if (shared_fdb) {
@@ -932,7 +968,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 			mlx5_rescan_drivers_locked(dev0);
 		}
 		mlx5_ldev_for_each(i, idx + 1, ldev)
-			mlx5_nic_vport_disable_roce(ldev->pf[i].dev);
+			mlx5_nic_vport_disable_roce(mlx5_lag_pf(ldev, i)->dev);
 	}
 
 	err = mlx5_deactivate_lag(ldev);
@@ -944,8 +980,8 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 
 	if (shared_fdb)
 		mlx5_ldev_for_each(i, 0, ldev)
-			if (!(ldev->pf[i].dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+			if (!(mlx5_lag_pf(ldev, i)->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
+				mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 }
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -958,7 +994,7 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 		return false;
 
 	mlx5_ldev_for_each(i, idx + 1, ldev) {
-		dev = ldev->pf[i].dev;
+		dev = mlx5_lag_pf(ldev, i)->dev;
 		if (is_mdev_switchdev_mode(dev) &&
 		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
 		    MLX5_CAP_GEN(dev, lag_native_fdb_selection) &&
@@ -969,7 +1005,7 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 		return false;
 	}
 
-	dev = ldev->pf[idx].dev;
+	dev = mlx5_lag_pf(ldev, idx)->dev;
 	if (is_mdev_switchdev_mode(dev) &&
 	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
 	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
@@ -983,14 +1019,19 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 static bool mlx5_lag_is_roce_lag(struct mlx5_lag *ldev)
 {
 	bool roce_lag = true;
+	struct lag_func *pf;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev)
-		roce_lag = roce_lag && !mlx5_sriov_is_enabled(ldev->pf[i].dev);
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		roce_lag = roce_lag && !mlx5_sriov_is_enabled(pf->dev);
+	}
 
 #ifdef CONFIG_MLX5_ESWITCH
-	mlx5_ldev_for_each(i, 0, ldev)
-		roce_lag = roce_lag && is_mdev_legacy_mode(ldev->pf[i].dev);
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		roce_lag = roce_lag && is_mdev_legacy_mode(pf->dev);
+	}
 #endif
 
 	return roce_lag;
@@ -1014,13 +1055,17 @@ mlx5_lag_sum_devices_speed(struct mlx5_lag *ldev, u32 *sum_speed,
 			   int (*get_speed)(struct mlx5_core_dev *, u32 *))
 {
 	struct mlx5_core_dev *pf_mdev;
+	struct lag_func *pf;
 	int pf_idx;
 	u32 speed;
 	int ret;
 
 	*sum_speed = 0;
 	mlx5_ldev_for_each(pf_idx, 0, ldev) {
-		pf_mdev = ldev->pf[pf_idx].dev;
+		pf = mlx5_lag_pf(ldev, pf_idx);
+		if (!pf)
+			continue;
+		pf_mdev = pf->dev;
 		if (!pf_mdev)
 			continue;
 
@@ -1086,6 +1131,7 @@ static void mlx5_lag_modify_device_vports_speed(struct mlx5_core_dev *mdev,
 void mlx5_lag_set_vports_agg_speed(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *mdev;
+	struct lag_func *pf;
 	u32 speed;
 	int pf_idx;
 
@@ -1105,7 +1151,10 @@ void mlx5_lag_set_vports_agg_speed(struct mlx5_lag *ldev)
 	speed = speed / MLX5_MAX_TX_SPEED_UNIT;
 
 	mlx5_ldev_for_each(pf_idx, 0, ldev) {
-		mdev = ldev->pf[pf_idx].dev;
+		pf = mlx5_lag_pf(ldev, pf_idx);
+		if (!pf)
+			continue;
+		mdev = pf->dev;
 		if (!mdev)
 			continue;
 
@@ -1116,12 +1165,16 @@ void mlx5_lag_set_vports_agg_speed(struct mlx5_lag *ldev)
 void mlx5_lag_reset_vports_speed(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *mdev;
+	struct lag_func *pf;
 	u32 speed;
 	int pf_idx;
 	int ret;
 
 	mlx5_ldev_for_each(pf_idx, 0, ldev) {
-		mdev = ldev->pf[pf_idx].dev;
+		pf = mlx5_lag_pf(ldev, pf_idx);
+		if (!pf)
+			continue;
+		mdev = pf->dev;
 		if (!mdev)
 			continue;
 
@@ -1152,7 +1205,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 	if (idx < 0)
 		return;
 
-	dev0 = ldev->pf[idx].dev;
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	if (!mlx5_lag_is_ready(ldev)) {
 		do_bond = false;
 	} else {
@@ -1182,16 +1235,19 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				mlx5_lag_add_devices(ldev);
 			if (shared_fdb) {
 				mlx5_ldev_for_each(i, 0, ldev)
-					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 			}
 
 			return;
 		} else if (roce_lag) {
+			struct mlx5_core_dev *dev;
+
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
 			mlx5_ldev_for_each(i, idx + 1, ldev) {
-				if (mlx5_get_roce_state(ldev->pf[i].dev))
-					mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+				dev = mlx5_lag_pf(ldev, i)->dev;
+				if (mlx5_get_roce_state(dev))
+					mlx5_nic_vport_enable_roce(dev);
 			}
 		} else if (shared_fdb) {
 			int i;
@@ -1200,7 +1256,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			mlx5_rescan_drivers_locked(dev0);
 
 			mlx5_ldev_for_each(i, 0, ldev) {
-				err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+				err = mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 				if (err)
 					break;
 			}
@@ -1211,7 +1267,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
 				mlx5_ldev_for_each(i, 0, ldev)
-					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
@@ -1243,12 +1299,15 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
 {
 	struct mlx5_devcom_comp_dev *devcom = NULL;
+	struct lag_func *pf;
 	int i;
 
 	mutex_lock(&ldev->lock);
 	i = mlx5_get_next_ldev_func(ldev, 0);
-	if (i < MLX5_MAX_PORTS)
-		devcom = ldev->pf[i].dev->priv.hca_devcom_comp;
+	if (i < MLX5_MAX_PORTS) {
+		pf = mlx5_lag_pf(ldev, i);
+		devcom = pf->dev->priv.hca_devcom_comp;
+	}
 	mutex_unlock(&ldev->lock);
 	return devcom;
 }
@@ -1297,6 +1356,7 @@ static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
 	struct netdev_lag_upper_info *lag_upper_info = NULL;
 	bool is_bonded, is_in_lag, mode_supported;
 	bool has_inactive = 0;
+	struct lag_func *pf;
 	struct slave *slave;
 	u8 bond_status = 0;
 	int num_slaves = 0;
@@ -1317,7 +1377,8 @@ static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
 	rcu_read_lock();
 	for_each_netdev_in_bond_rcu(upper, ndev_tmp) {
 		mlx5_ldev_for_each(i, 0, ldev) {
-			if (ldev->pf[i].netdev == ndev_tmp) {
+			pf = mlx5_lag_pf(ldev, i);
+			if (pf->netdev == ndev_tmp) {
 				idx++;
 				break;
 			}
@@ -1538,10 +1599,12 @@ static void mlx5_ldev_add_netdev(struct mlx5_lag *ldev,
 				struct net_device *netdev)
 {
 	unsigned int fn = mlx5_get_dev_index(dev);
+	struct lag_func *pf;
 	unsigned long flags;
 
 	spin_lock_irqsave(&lag_lock, flags);
-	ldev->pf[fn].netdev = netdev;
+	pf = mlx5_lag_pf(ldev, fn);
+	pf->netdev = netdev;
 	ldev->tracker.netdev_state[fn].link_up = 0;
 	ldev->tracker.netdev_state[fn].tx_enabled = 0;
 	spin_unlock_irqrestore(&lag_lock, flags);
@@ -1550,46 +1613,69 @@ static void mlx5_ldev_add_netdev(struct mlx5_lag *ldev,
 static void mlx5_ldev_remove_netdev(struct mlx5_lag *ldev,
 				    struct net_device *netdev)
 {
+	struct lag_func *pf;
 	unsigned long flags;
 	int i;
 
 	spin_lock_irqsave(&lag_lock, flags);
 	mlx5_ldev_for_each(i, 0, ldev) {
-		if (ldev->pf[i].netdev == netdev) {
-			ldev->pf[i].netdev = NULL;
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->netdev == netdev) {
+			pf->netdev = NULL;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&lag_lock, flags);
 }
 
-static void mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
+static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
 			      struct mlx5_core_dev *dev)
 {
 	unsigned int fn = mlx5_get_dev_index(dev);
+	struct lag_func *pf;
+	int err;
+
+	pf = xa_load(&ldev->pfs, fn);
+	if (!pf) {
+		pf = kzalloc_obj(*pf);
+		if (!pf)
+			return -ENOMEM;
+
+		err = xa_err(xa_store(&ldev->pfs, fn, pf, GFP_KERNEL));
+		if (err) {
+			kfree(pf);
+			return err;
+		}
+	}
 
-	ldev->pf[fn].dev = dev;
+	pf->dev = dev;
 	dev->priv.lag = ldev;
 
-	MLX5_NB_INIT(&ldev->pf[fn].port_change_nb,
+	MLX5_NB_INIT(&pf->port_change_nb,
 		     mlx5_lag_mpesw_port_change_event, PORT_CHANGE);
-	mlx5_eq_notifier_register(dev, &ldev->pf[fn].port_change_nb);
+	mlx5_eq_notifier_register(dev, &pf->port_change_nb);
+
+	return 0;
 }
 
 static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
 				  struct mlx5_core_dev *dev)
 {
+	struct lag_func *pf;
 	int fn;
 
 	fn = mlx5_get_dev_index(dev);
-	if (ldev->pf[fn].dev != dev)
+	pf = xa_load(&ldev->pfs, fn);
+	if (!pf || pf->dev != dev)
 		return;
 
-	if (ldev->pf[fn].port_change_nb.nb.notifier_call)
-		mlx5_eq_notifier_unregister(dev, &ldev->pf[fn].port_change_nb);
+	if (pf->port_change_nb.nb.notifier_call)
+		mlx5_eq_notifier_unregister(dev, &pf->port_change_nb);
 
-	ldev->pf[fn].dev = NULL;
+	pf->dev = NULL;
 	dev->priv.lag = NULL;
+	xa_erase(&ldev->pfs, fn);
+	kfree(pf);
 }
 
 /* Must be called with HCA devcom component lock held */
@@ -1598,6 +1684,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 	struct mlx5_devcom_comp_dev *pos = NULL;
 	struct mlx5_lag *ldev = NULL;
 	struct mlx5_core_dev *tmp_dev;
+	int err;
 
 	tmp_dev = mlx5_devcom_get_next_peer_data(dev->priv.hca_devcom_comp, &pos);
 	if (tmp_dev)
@@ -1609,7 +1696,12 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 			mlx5_core_err(dev, "Failed to alloc lag dev\n");
 			return 0;
 		}
-		mlx5_ldev_add_mdev(ldev, dev);
+		err = mlx5_ldev_add_mdev(ldev, dev);
+		if (err) {
+			mlx5_core_err(dev, "Failed to add mdev to lag dev\n");
+			mlx5_ldev_put(ldev);
+			return 0;
+		}
 		return 0;
 	}
 
@@ -1619,7 +1711,12 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 		return -EAGAIN;
 	}
 	mlx5_ldev_get(ldev);
-	mlx5_ldev_add_mdev(ldev, dev);
+	err = mlx5_ldev_add_mdev(ldev, dev);
+	if (err) {
+		mlx5_ldev_put(ldev);
+		mutex_unlock(&ldev->lock);
+		return err;
+	}
 	mutex_unlock(&ldev->lock);
 
 	return 0;
@@ -1746,21 +1843,25 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
 
 int mlx5_get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
 {
+	struct lag_func *pf;
 	int i;
 
-	for (i = start_idx; i >= end_idx; i--)
-		if (ldev->pf[i].dev)
+	for (i = start_idx; i >= end_idx; i--) {
+		pf = xa_load(&ldev->pfs, i);
+		if (pf && pf->dev)
 			return i;
+	}
 	return -1;
 }
 
 int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
 {
-	int i;
+	struct lag_func *pf;
+	unsigned long idx;
 
-	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
-		if (ldev->pf[i].dev)
-			return i;
+	xa_for_each_start(&ldev->pfs, idx, pf, start_idx)
+		if (pf->dev)
+			return idx;
 	return MLX5_MAX_PORTS;
 }
 
@@ -1814,13 +1915,17 @@ bool mlx5_lag_is_master(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev;
 	unsigned long flags;
+	struct lag_func *pf;
 	bool res = false;
 	int idx;
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
 	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
-	res = ldev && __mlx5_lag_is_active(ldev) && idx >= 0 && dev == ldev->pf[idx].dev;
+	if (ldev && __mlx5_lag_is_active(ldev) && idx >= 0) {
+		pf = mlx5_lag_pf(ldev, idx);
+		res = pf && dev == pf->dev;
+	}
 	spin_unlock_irqrestore(&lag_lock, flags);
 
 	return res;
@@ -1899,6 +2004,7 @@ u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 {
 	struct mlx5_lag *ldev;
 	unsigned long flags;
+	struct lag_func *pf;
 	u8 port = 0;
 	int i;
 
@@ -1908,7 +2014,8 @@ u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 		goto unlock;
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		if (ldev->pf[i].netdev == slave) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->netdev == slave) {
 			port = i;
 			break;
 		}
@@ -1939,6 +2046,7 @@ struct mlx5_core_dev *mlx5_lag_get_next_peer_mdev(struct mlx5_core_dev *dev, int
 	struct mlx5_core_dev *peer_dev = NULL;
 	struct mlx5_lag *ldev;
 	unsigned long flags;
+	struct lag_func *pf;
 	int idx;
 
 	spin_lock_irqsave(&lag_lock, flags);
@@ -1948,9 +2056,11 @@ struct mlx5_core_dev *mlx5_lag_get_next_peer_mdev(struct mlx5_core_dev *dev, int
 
 	if (*i == MLX5_MAX_PORTS)
 		goto unlock;
-	mlx5_ldev_for_each(idx, *i, ldev)
-		if (ldev->pf[idx].dev != dev)
+	mlx5_ldev_for_each(idx, *i, ldev) {
+		pf = mlx5_lag_pf(ldev, idx);
+		if (pf->dev != dev)
 			break;
+	}
 
 	if (idx == MLX5_MAX_PORTS) {
 		*i = idx;
@@ -1958,7 +2068,8 @@ struct mlx5_core_dev *mlx5_lag_get_next_peer_mdev(struct mlx5_core_dev *dev, int
 	}
 	*i = idx + 1;
 
-	peer_dev = ldev->pf[idx].dev;
+	pf = mlx5_lag_pf(ldev, idx);
+	peer_dev = pf->dev;
 
 unlock:
 	spin_unlock_irqrestore(&lag_lock, flags);
@@ -1976,6 +2087,7 @@ int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
 	int ret = 0, i, j, idx = 0;
 	struct mlx5_lag *ldev;
 	unsigned long flags;
+	struct lag_func *pf;
 	int num_ports;
 	void *out;
 
@@ -1995,8 +2107,10 @@ int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
 	ldev = mlx5_lag_dev(dev);
 	if (ldev && __mlx5_lag_is_active(ldev)) {
 		num_ports = ldev->ports;
-		mlx5_ldev_for_each(i, 0, ldev)
-			mdev[idx++] = ldev->pf[i].dev;
+		mlx5_ldev_for_each(i, 0, ldev) {
+			pf = mlx5_lag_pf(ldev, i);
+			mdev[idx++] = pf->dev;
+		}
 	} else {
 		num_ports = 1;
 		mdev[MLX5_LAG_P1] = dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index be1afece5fdc..09758871b3da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -64,7 +64,7 @@ struct mlx5_lag {
 	int			  mode_changes_in_progress;
 	u8			  v2p_map[MLX5_MAX_PORTS * MLX5_LAG_MAX_HASH_BUCKETS];
 	struct kref               ref;
-	struct lag_func           pf[MLX5_MAX_PORTS];
+	struct xarray             pfs;
 	struct lag_tracker        tracker;
 	struct workqueue_struct   *wq;
 	struct delayed_work       bond_work;
@@ -84,6 +84,12 @@ mlx5_lag_dev(struct mlx5_core_dev *dev)
 	return dev->priv.lag;
 }
 
+static inline struct lag_func *
+mlx5_lag_pf(struct mlx5_lag *ldev, unsigned int idx)
+{
+	return xa_load(&ldev->pfs, idx);
+}
+
 static inline bool
 __mlx5_lag_is_active(struct mlx5_lag *ldev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index c4c2bf33ef35..f42e051fa7e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -29,8 +29,8 @@ static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 	if (ldev->ports > MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS)
 		return false;
 
-	return mlx5_esw_multipath_prereq(ldev->pf[idx0].dev,
-					 ldev->pf[idx1].dev);
+	return mlx5_esw_multipath_prereq(mlx5_lag_pf(ldev, idx0)->dev,
+					 mlx5_lag_pf(ldev, idx1)->dev);
 }
 
 bool mlx5_lag_is_multipath(struct mlx5_core_dev *dev)
@@ -80,18 +80,18 @@ static void mlx5_lag_set_port_affinity(struct mlx5_lag *ldev,
 		tracker.netdev_state[idx1].link_up = true;
 		break;
 	default:
-		mlx5_core_warn(ldev->pf[idx0].dev,
+		mlx5_core_warn(mlx5_lag_pf(ldev, idx0)->dev,
 			       "Invalid affinity port %d", port);
 		return;
 	}
 
 	if (tracker.netdev_state[idx0].tx_enabled)
-		mlx5_notifier_call_chain(ldev->pf[idx0].dev->priv.events,
+		mlx5_notifier_call_chain(mlx5_lag_pf(ldev, idx0)->dev->priv.events,
 					 MLX5_DEV_EVENT_PORT_AFFINITY,
 					 (void *)0);
 
 	if (tracker.netdev_state[idx1].tx_enabled)
-		mlx5_notifier_call_chain(ldev->pf[idx1].dev->priv.events,
+		mlx5_notifier_call_chain(mlx5_lag_pf(ldev, idx1)->dev->priv.events,
 					 MLX5_DEV_EVENT_PORT_AFFINITY,
 					 (void *)0);
 
@@ -146,7 +146,7 @@ mlx5_lag_get_next_fib_dev(struct mlx5_lag *ldev,
 		fib_dev = fib_info_nh(fi, i)->fib_nh_dev;
 		ldev_idx = mlx5_lag_dev_get_netdev_idx(ldev, fib_dev);
 		if (ldev_idx >= 0)
-			return ldev->pf[ldev_idx].netdev;
+			return mlx5_lag_pf(ldev, ldev_idx)->netdev;
 	}
 
 	return NULL;
@@ -178,7 +178,7 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 	    mp->fib.dst_len <= fen_info->dst_len &&
 	    !(mp->fib.dst_len == fen_info->dst_len &&
 	      fi->fib_priority < mp->fib.priority)) {
-		mlx5_core_dbg(ldev->pf[idx].dev,
+		mlx5_core_dbg(mlx5_lag_pf(ldev, idx)->dev,
 			      "Multipath entry with lower priority was rejected\n");
 		return;
 	}
@@ -194,7 +194,7 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 	}
 
 	if (nh_dev0 == nh_dev1) {
-		mlx5_core_warn(ldev->pf[idx].dev,
+		mlx5_core_warn(mlx5_lag_pf(ldev, idx)->dev,
 			       "Multipath offload doesn't support routes with multiple nexthops of the same device");
 		return;
 	}
@@ -203,7 +203,7 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 		if (__mlx5_lag_is_active(ldev)) {
 			mlx5_ldev_for_each(i, 0, ldev) {
 				dev_idx++;
-				if (ldev->pf[i].netdev == nh_dev0)
+				if (mlx5_lag_pf(ldev, i)->netdev == nh_dev0)
 					break;
 			}
 			mlx5_lag_set_port_affinity(ldev, dev_idx);
@@ -240,7 +240,7 @@ static void mlx5_lag_fib_nexthop_event(struct mlx5_lag *ldev,
 	/* nh added/removed */
 	if (event == FIB_EVENT_NH_DEL) {
 		mlx5_ldev_for_each(i, 0, ldev) {
-			if (ldev->pf[i].netdev == fib_nh->fib_nh_dev)
+			if (mlx5_lag_pf(ldev, i)->netdev == fib_nh->fib_nh_dev)
 				break;
 			dev_idx++;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 74d5c2ed14ff..0e7d206cd594 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -16,7 +16,7 @@ static void mlx5_mpesw_metadata_cleanup(struct mlx5_lag *ldev)
 	int i;
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		dev = ldev->pf[i].dev;
+		dev = mlx5_lag_pf(ldev, i)->dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = ldev->lag_mpesw.pf_metadata[i];
 		if (!pf_metadata)
@@ -37,7 +37,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	int i, err;
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		dev = ldev->pf[i].dev;
+		dev = mlx5_lag_pf(ldev, i)->dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = mlx5_esw_match_metadata_alloc(esw);
 		if (!pf_metadata) {
@@ -53,7 +53,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	}
 
 	mlx5_ldev_for_each(i, 0, ldev) {
-		dev = ldev->pf[i].dev;
+		dev = mlx5_lag_pf(ldev, i)->dev;
 		mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_MULTIPORT_ESW,
 					 (void *)0);
 	}
@@ -82,7 +82,7 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	if (idx < 0)
 		return -EINVAL;
 
-	dev0 = ldev->pf[idx].dev;
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	if (mlx5_eswitch_mode(dev0) != MLX5_ESWITCH_OFFLOADS ||
 	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
 	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||
@@ -105,7 +105,7 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
 	mlx5_ldev_for_each(i, 0, ldev) {
-		err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+		err = mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 		if (err)
 			goto err_rescan_drivers;
 	}
@@ -121,7 +121,7 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
 	mlx5_ldev_for_each(i, 0, ldev)
-		mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+		mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 16c7d16215c4..7e9e3e81977d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -50,7 +50,7 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev = ldev->pf[first_idx].dev;
+	dev = mlx5_lag_pf(ldev, first_idx)->dev;
 	ft_attr.max_fte = ldev->ports * ldev->buckets;
 	ft_attr.level = MLX5_LAG_FT_LEVEL_DEFINER;
 
@@ -84,8 +84,9 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 			idx = i * ldev->buckets + j;
 			affinity = ports[idx];
 
-			dest.vport.vhca_id = MLX5_CAP_GEN(ldev->pf[affinity - 1].dev,
-							  vhca_id);
+			dest.vport.vhca_id =
+				MLX5_CAP_GEN(mlx5_lag_pf(ldev, affinity - 1)->dev,
+					     vhca_id);
 			lag_definer->rules[idx] = mlx5_add_flow_rules(lag_definer->ft,
 								      NULL, &flow_act,
 								      &dest, 1);
@@ -307,7 +308,7 @@ mlx5_lag_create_definer(struct mlx5_lag *ldev, enum netdev_lag_hash hash,
 	if (first_idx < 0)
 		return ERR_PTR(-EINVAL);
 
-	dev = ldev->pf[first_idx].dev;
+	dev = mlx5_lag_pf(ldev, first_idx)->dev;
 	lag_definer = kzalloc_obj(*lag_definer);
 	if (!lag_definer)
 		return ERR_PTR(-ENOMEM);
@@ -356,7 +357,7 @@ static void mlx5_lag_destroy_definer(struct mlx5_lag *ldev,
 	if (first_idx < 0)
 		return;
 
-	dev = ldev->pf[first_idx].dev;
+	dev = mlx5_lag_pf(ldev, first_idx)->dev;
 	mlx5_ldev_for_each(i, first_idx, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
@@ -520,7 +521,7 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev = ldev->pf[first_idx].dev;
+	dev = mlx5_lag_pf(ldev, first_idx)->dev;
 	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
 	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
 	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
@@ -536,7 +537,7 @@ static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
 	if (first_idx < 0)
 		return -EINVAL;
 
-	dev = ldev->pf[first_idx].dev;
+	dev = mlx5_lag_pf(ldev, first_idx)->dev;
 	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
 	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
 	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
@@ -594,8 +595,9 @@ static int __mlx5_lag_modify_definers_destinations(struct mlx5_lag *ldev,
 			if (ldev->v2p_map[idx] == ports[idx])
 				continue;
 
-			dest.vport.vhca_id = MLX5_CAP_GEN(ldev->pf[ports[idx] - 1].dev,
-							  vhca_id);
+			dest.vport.vhca_id =
+				MLX5_CAP_GEN(mlx5_lag_pf(ldev, ports[idx] - 1)->dev,
+					     vhca_id);
 			err = mlx5_modify_rule_destination(def->rules[idx], &dest, NULL);
 			if (err)
 				return err;
-- 
2.44.0


