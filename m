Return-Path: <linux-rdma+bounces-13263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC89B528C6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A87B8330
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B158265CD0;
	Thu, 11 Sep 2025 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dvHwzGnJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B82571D7;
	Thu, 11 Sep 2025 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572318; cv=fail; b=lxnCmBzWgHMcRcWf5oYWGMKF5D+GOMy9jU59cDdgYtMDb9gbB9+Q2bi2ggmDPZBHzQISgtq6ips1XuR+74Tw3etiuDezNAnGcoYshZ7IXgKbbwW2IljlZkxUVJRsCOdXFkXw1BZ3vHrRjfx4QihN6WcV5RcJ0H1bOMQGTgzDXUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572318; c=relaxed/simple;
	bh=CfWlenwaFc+0UJzXge+tsKAvS2gd3sI8kPnvQyXhbpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqzW4jIcIvgCgbKY2Y/K99KW3Try7cjBY4sbRVIF3zVLqDFP6q40C5BLHOZuwikuxgq1WquhulKBxOSZ9flcR3MmvdXLbcyhEu2CqhRR2Nf1gVbTo281sod142asqwCEWCKX+XpdbuJhHk1a0LgzYNMN86cC0QHgo5LE/xkUE5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dvHwzGnJ; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dx7/Nd6ahDbQS5q0lLJoxMVBCRM/XKPFN6YmfnJdIrZL2ejdqgmNai1BjnDtyQPpBnFPjcdxhBDnNf0UhFGoqwLsCy6rlHNwZ/FszwnjMDZxhhfvhqPN8t7VDqFKS8tLu/4XSDZT5Ht0UOGULF6CYiImD4tlNHu6m2RpnDZCT+E5GfIweJQm0wbweTbuhahMpwYpirKfx1z1Vkkm//F0nWNiaowSxsgDPibb+5F7rGojBMkof13mIt89zM4vD6cBU9FprqAKwBSb0gBiiQL1vFVRf9WSx/USZWAZuTexzI1+UffCVHSsm1/CVie0Ovf3WLaC8SGdS6v9K1moc8zIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r31nVpcfBIj762D6oy6i3/L+eQnXDw/OdUlxFoyaO8g=;
 b=KgdKevn4qCEDixSZ/Bwk0/KJvONkCQ3+0re26AiorjyMyyBbtzQQRSwXoVr01/cuBZR/qovGDddf4pHQBLNjSeJH72/qy7wWjJRlu6Ri+Z1gaNke3cVlf6Mnlip/1tXei0/kQK82pttSpQv7NHmSRKxfg0U7cHf41CctyFWPbCWPFH0UTvQ+T6UHO7zE0NzmSNHbT3mIv72fRVDesJaMu+nNoHEIIuCNTLkAiwZ4Pn1n+Yp6pWjcA0CZj9E5c3Qoxw18V+qHu4iO1Y6et1BtixZpitA/81sHfdeejfqhKzAD8p99036lNHNZdo5fxYTbaWKeqobkybXWVlKBmjUlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r31nVpcfBIj762D6oy6i3/L+eQnXDw/OdUlxFoyaO8g=;
 b=dvHwzGnJuWJcfzb8vce8XFyKeVIKPpOmc1Da6igpwsK1rqU847du+BpA4B8h7Ydoknr+z9cmF4YQ6o8DmKMX7zX5gYEQNfQP+2kFmNsSYi0/DiN3ij3A1LRZWjfx+0oZpfkcwj70zjIEnb4P6dfukP/55u20/oHnO2XwC/J0laWgmp+6Df1H7yUJno2qGqt4w+g/Y9uOpRyU5XrgsTgF1MydO8zHvT0WglerMmW8W1ahJB6sNfpk2WIqRdrkYCz5VZBhnfhOeVMzRSW3s8BST8MGbr/0CN42zvs77YDBQLGAbygnp7DehLnjBpbn+heUU4CY/S5YKtGwO97DCODkow==
Received: from BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:31:49 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::e5) by BL1PR13CA0159.outlook.office365.com
 (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Thu,
 11 Sep 2025 06:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:31:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 23:31:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next 1/4] net/mlx5: Refactor devcom to use match attributes
Date: Thu, 11 Sep 2025 09:31:04 +0300
Message-ID: <1757572267-601785-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: b0422a2f-1b78-4783-cc6d-08ddf0fce379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PflB94c8uG1NZtMnlCyHf3Tt7ApKx1uGLFgisHlndn0qROb1pEeMOuap3w31?=
 =?us-ascii?Q?lkrz2ABTUzlxCLmzajU6qv+dXQo/zXKnA/xq5IefFuHe7rHKiRax00SGiqOf?=
 =?us-ascii?Q?QVGcrEBrEXtcjfiLibfRlxPQFIdC1zGqRAKUTdIZrCEeDxPvksPbRyB/btSY?=
 =?us-ascii?Q?SubIn3CdXGgBEOlUWV/iw7lSFHoASgzBsHp/ptymO+gGD7mpmWpaKfVB75Wi?=
 =?us-ascii?Q?ENkYrrslwjyHGuuiZWmVvEXKgHXJh7oKHx1IbyZ1TI5/QjBqRACTcmDVYJCL?=
 =?us-ascii?Q?GvP1fBmFRPlbqEAY2jiAn3KFtj73r890NoYU8i4aw/HLwYNCD2LrVdSLomdf?=
 =?us-ascii?Q?FMqrzoO+n7f9Nr5dGkrBO9tY4+8lFTSghUKZSuQ+Cw93fjN3WwguUslApkxv?=
 =?us-ascii?Q?kHSLV/wht+LlNWe8BIlDecl3A273XG0l4t2YkGAPAE2a4Wc6UzcKai6ABVrE?=
 =?us-ascii?Q?1CL5Z1QxoDZu/40dcON3DUprHFGUsGtCJHyDwWbcvzhY5m2IxWrL1fTtY46k?=
 =?us-ascii?Q?HiUDPi11dazBp6GFJujLi1sOFfGzlFckeHEhBBa2Q2A9+YnzjbJthx1An4Th?=
 =?us-ascii?Q?q58NO/EIG9VolSFI2HiVnyPIu+FIqHeLtvzJ4Uo2Orbt0HdcVGlh0dBI8Bvw?=
 =?us-ascii?Q?D92SwuDLkC9rk/8ncYXTF4o2ChR4sesobFMf7M9VFEJsoKngt0aTzx4cke99?=
 =?us-ascii?Q?WNwHouNMP6z22PltlvS1mRjIo0UcXKRZHz7ruH+WSpnIwFf+DNZ6PNcDKjWW?=
 =?us-ascii?Q?gqfyWlZzGu/bv0p4m1kVj/eAwvoUnlrUd71OpzkWc2H3GRZkLcn5w27ygHv9?=
 =?us-ascii?Q?qIe2gVGmi3F6APasQ3oF1Wjvco9SF+AtnoTFBD3qqTai9zjnBZd2xqJUd/qF?=
 =?us-ascii?Q?NIAtNiDN0Ih2BwljaTcHfd/RUehpryfNT2ZMiKahiT8mk6oxJQRpOikY1Ceg?=
 =?us-ascii?Q?v9nrhWGeraRA489Rr4H1z6b6KvY88c45fSuAFZ/ho6i3dr+IoZgNduyquy1b?=
 =?us-ascii?Q?Z3H3mCl3ycgKbF/HtIkVkRKkK/SQsghrxnQOGlMnMj6Qrges/aO2+Vl2YsGG?=
 =?us-ascii?Q?aPjgR+Tbr9cB5gUtWTgYRkBrxMoF4kHkIKjHtF4p+I9MHRQcCiAe3mX7kIAl?=
 =?us-ascii?Q?huPnbv4y/S89mseBrd9k7F7//0r6LGTSIK9+gXUXrdhb68q+HOUkYTz/1uGM?=
 =?us-ascii?Q?vjkbDMi/k6Wu/WjU88b8DOHVclyoHmh2v5E6Akcg5bfN0nFEJ7OWMMLCK+BL?=
 =?us-ascii?Q?4+VFILpPGr3RVbiWcp0Xy3ETWjJMA7SO35/j9XLr2FZeQAwQzeg7OTiehpBJ?=
 =?us-ascii?Q?Q8LEkdpmojPnltSXovz21E1ns090uworZXnWKcz9qLxfG4OcwvuucsrdApFn?=
 =?us-ascii?Q?86rcRHgTJAVtKhoVSraOm0Q5Ss2GighpCKuDcEq9CzRlqjCdTiAHqxCQURMa?=
 =?us-ascii?Q?Ox3ktjEp/t7Mxu7YCqg6Nnkv83pBpOQlAGgwrQ9S6FsJBBBm97R1w6kvaUBq?=
 =?us-ascii?Q?z8bw/1YoNbh3//YbS2kd4EqnuTMiQeyfE2Dq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:31:49.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0422a2f-1b78-4783-cc6d-08ddf0fce379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

From: Shay Drory <shayd@nvidia.com>

Refactor the devcom interface to use a match attribute structure instead
of passing raw keys. This change lays the groundwork for extending devcom
matching logic with additional fields like net namespace, improving its
flexibility and robustness.

No functional changes.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 +++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  7 +++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 +++--
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 +--
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 14 ++++++---
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 31 +++++++++++++------
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  | 10 +++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 ++-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++--
 9 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 714cce595692..fe5f5ae433b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -235,9 +235,13 @@ static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
 
 static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
 {
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = *data,
+	};
+
 	priv->devcom = mlx5_devcom_register_component(priv->mdev->priv.devc,
 						      MLX5_DEVCOM_MPV,
-						      *data,
+						      &attr,
 						      mlx5e_devcom_event_mpv,
 						      priv);
 	if (IS_ERR(priv->devcom))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 32c07a8b03d1..9874a15c6fba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5387,12 +5387,13 @@ void mlx5e_tc_ht_cleanup(struct rhashtable *tc_ht)
 int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 {
 	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
+	struct mlx5_devcom_match_attr attr = {};
 	struct netdev_phys_item_id ppid;
 	struct mlx5e_rep_priv *rpriv;
 	struct mapping_ctx *mapping;
 	struct mlx5_eswitch *esw;
 	struct mlx5e_priv *priv;
-	u64 mapping_id, key;
+	u64 mapping_id;
 	int err = 0;
 
 	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
@@ -5448,8 +5449,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 
 	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
-		memcpy(&key, &ppid.id, sizeof(key));
-		mlx5_esw_offloads_devcom_init(esw, key);
+		memcpy(&attr.key.val, &ppid.id, sizeof(attr.key.val));
+		mlx5_esw_offloads_devcom_init(esw, &attr);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 4fe285ce32aa..df3756d7e52e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -433,7 +433,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs);
 void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
 void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
-void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key);
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
+				   const struct mlx5_devcom_match_attr *attr);
 void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
 bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw);
 int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
@@ -928,7 +929,9 @@ static inline void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw) {}
 static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
 static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
 static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
-static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key) {}
+static inline void
+mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
+			      const struct mlx5_devcom_match_attr *attr) {}
 static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
 static inline bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw) { return false; }
 static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d57f86d297ab..bc9838dc5bf8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3104,7 +3104,8 @@ static int mlx5_esw_offloads_devcom_event(int event,
 	return err;
 }
 
-void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
+				   const struct mlx5_devcom_match_attr *attr)
 {
 	int i;
 
@@ -3123,7 +3124,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
 	esw->num_peers = 0;
 	esw->devcom = mlx5_devcom_register_component(esw->dev->priv.devc,
 						     MLX5_DEVCOM_ESW_OFFLOADS,
-						     key,
+						     attr,
 						     mlx5_esw_offloads_devcom_event,
 						     esw);
 	if (IS_ERR(esw->devcom))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 7ad3baca99de..8f2ad45bec9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1435,14 +1435,20 @@ static int mlx5_clock_alloc(struct mlx5_core_dev *mdev, bool shared)
 static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
 {
 	struct mlx5_core_dev *peer_dev, *next = NULL;
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = key,
+	};
+	struct mlx5_devcom_comp_dev *compd;
 	struct mlx5_devcom_comp_dev *pos;
 
-	mdev->clock_state->compdev = mlx5_devcom_register_component(mdev->priv.devc,
-								    MLX5_DEVCOM_SHARED_CLOCK,
-								    key, NULL, mdev);
-	if (IS_ERR(mdev->clock_state->compdev))
+	compd = mlx5_devcom_register_component(mdev->priv.devc,
+					       MLX5_DEVCOM_SHARED_CLOCK,
+					       &attr, NULL, mdev);
+	if (IS_ERR(compd))
 		return;
 
+	mdev->clock_state->compdev = compd;
+
 	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
 	mlx5_devcom_for_each_peer_entry(mdev->clock_state->compdev, peer_dev, pos) {
 		if (peer_dev->clock) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 7b0766c89f4c..1ab9de316deb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -22,11 +22,15 @@ struct mlx5_devcom_dev {
 	struct kref ref;
 };
 
+struct mlx5_devcom_key {
+	union mlx5_devcom_match_key key;
+};
+
 struct mlx5_devcom_comp {
 	struct list_head comp_list;
 	enum mlx5_devcom_component id;
-	u64 key;
 	struct list_head comp_dev_list_head;
+	struct mlx5_devcom_key key;
 	mlx5_devcom_event_handler_t handler;
 	struct kref ref;
 	bool ready;
@@ -108,7 +112,8 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc)
 }
 
 static struct mlx5_devcom_comp *
-mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
+mlx5_devcom_comp_alloc(u64 id, const struct mlx5_devcom_match_attr *attr,
+		       mlx5_devcom_event_handler_t handler)
 {
 	struct mlx5_devcom_comp *comp;
 
@@ -117,7 +122,7 @@ mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
 		return ERR_PTR(-ENOMEM);
 
 	comp->id = id;
-	comp->key = key;
+	comp->key.key = attr->key;
 	comp->handler = handler;
 	init_rwsem(&comp->sem);
 	lockdep_register_key(&comp->lock_key);
@@ -180,21 +185,27 @@ devcom_free_comp_dev(struct mlx5_devcom_comp_dev *devcom)
 static bool
 devcom_component_equal(struct mlx5_devcom_comp *devcom,
 		       enum mlx5_devcom_component id,
-		       u64 key)
+		       const struct mlx5_devcom_match_attr *attr)
 {
-	return devcom->id == id && devcom->key == key;
+	if (devcom->id != id)
+		return false;
+
+	if (memcmp(&devcom->key.key, &attr->key, sizeof(devcom->key.key)))
+		return false;
+
+	return true;
 }
 
 static struct mlx5_devcom_comp *
 devcom_component_get(struct mlx5_devcom_dev *devc,
 		     enum mlx5_devcom_component id,
-		     u64 key,
+		     const struct mlx5_devcom_match_attr *attr,
 		     mlx5_devcom_event_handler_t handler)
 {
 	struct mlx5_devcom_comp *comp;
 
 	devcom_for_each_component(comp) {
-		if (devcom_component_equal(comp, id, key)) {
+		if (devcom_component_equal(comp, id, attr)) {
 			if (handler == comp->handler) {
 				kref_get(&comp->ref);
 				return comp;
@@ -212,7 +223,7 @@ devcom_component_get(struct mlx5_devcom_dev *devc,
 struct mlx5_devcom_comp_dev *
 mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       enum mlx5_devcom_component id,
-			       u64 key,
+			       const struct mlx5_devcom_match_attr *attr,
 			       mlx5_devcom_event_handler_t handler,
 			       void *data)
 {
@@ -223,14 +234,14 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&comp_list_lock);
-	comp = devcom_component_get(devc, id, key, handler);
+	comp = devcom_component_get(devc, id, attr, handler);
 	if (IS_ERR(comp)) {
 		devcom = ERR_PTR(-EINVAL);
 		goto out_unlock;
 	}
 
 	if (!comp) {
-		comp = mlx5_devcom_comp_alloc(id, key, handler);
+		comp = mlx5_devcom_comp_alloc(id, attr, handler);
 		if (IS_ERR(comp)) {
 			devcom = ERR_CAST(comp);
 			goto out_unlock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index c79699b94a02..f350d2395707 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,6 +6,14 @@
 
 #include <linux/mlx5/driver.h>
 
+union mlx5_devcom_match_key {
+	u64 val;
+};
+
+struct mlx5_devcom_match_attr {
+	union mlx5_devcom_match_key key;
+};
+
 enum mlx5_devcom_component {
 	MLX5_DEVCOM_ESW_OFFLOADS,
 	MLX5_DEVCOM_MPV,
@@ -25,7 +33,7 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc);
 struct mlx5_devcom_comp_dev *
 mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       enum mlx5_devcom_component id,
-			       u64 key,
+			       const struct mlx5_devcom_match_attr *attr,
 			       mlx5_devcom_event_handler_t handler,
 			       void *data);
 void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index eeb0b7ea05f1..d4015328ba65 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -210,13 +210,15 @@ static void sd_cleanup(struct mlx5_core_dev *dev)
 static int sd_register(struct mlx5_core_dev *dev)
 {
 	struct mlx5_devcom_comp_dev *devcom, *pos;
+	struct mlx5_devcom_match_attr attr = {};
 	struct mlx5_core_dev *peer, *primary;
 	struct mlx5_sd *sd, *primary_sd;
 	int err, i;
 
 	sd = mlx5_get_sd(dev);
+	attr.key.val = sd->group_id;
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
-						sd->group_id, NULL, dev);
+						&attr, NULL, dev);
 	if (IS_ERR(devcom))
 		return PTR_ERR(devcom);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0951c7cc1b5f..1f7942202e14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -975,6 +975,10 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 
 static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 {
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = mlx5_query_nic_system_image_guid(dev),
+	};
+
 	/* This component is use to sync adding core_dev to lag_dev and to sync
 	 * changes of mlx5_adev_devices between LAG layer and other layers.
 	 */
@@ -983,8 +987,7 @@ static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 
 	dev->priv.hca_devcom_comp =
 		mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_HCA_PORTS,
-					       mlx5_query_nic_system_image_guid(dev),
-					       NULL, dev);
+					       &attr, NULL, dev);
 	if (IS_ERR(dev->priv.hca_devcom_comp))
 		mlx5_core_err(dev, "Failed to register devcom HCA component\n");
 }
-- 
2.31.1


