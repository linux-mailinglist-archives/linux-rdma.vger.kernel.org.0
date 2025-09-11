Return-Path: <linux-rdma+bounces-13265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CCB528CC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 08:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD117BB8A1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A626E703;
	Thu, 11 Sep 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ci0ylugm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EA25A631;
	Thu, 11 Sep 2025 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572326; cv=fail; b=lBa20wYnB0h0Z+Hr7bfrf9ycAAxZObaTU6vnEKjJG/57s2P0dIbXQ0GrybhEVSs/8FuO+aXswsprW5nKMuJvYJejErUVlmZGYSSLi2gSMIMNoqoG5JUyWvj1fnHGFfGuyhn5ZSbdrYPvQg+ZRgV6HLhSFwYFKRsfPeEmy789IqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572326; c=relaxed/simple;
	bh=mCPKWeZpLIq3zF7NJSmw1YnVV+tMUAPRAL4ipsqc0Tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j15SQWdKNJmsGUhLFItySYfH5DleJ8c/kUjx4Lf5SjC9xpPyg1ky5xRI/0RKtWmOc/GSjjcTaZHg7V//adABUwAUba0UfZ0S3F/zUAikaUxCBWFOyC2ITWKSs28ZxJLzp0tXp6CXEh57Yi9HwhvMBp9gFJ58LLlntiAFu1I1H4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ci0ylugm; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snGNY28WymYlrDN5BY1s+mjmBmLTvTHWAuym8fR6HGKPRgPakZE7LBKoi7MkGOllghtlghh0L61753oRaDVF9qvdVLpZrOfx9C0/5ScJ5UUE88SbdlsHubbsmdZhzZwOOM7FN7rbIGsAteKhFzgmaU9jfx8HC+H5INXNIO37Eyqr1h0JRFFQv5vpRxEUJzRmyhlh7K6y1shXsTxfQcW7aFqdD1NKyiWljMignvSbcn+AhCd/6zs7+mOxHcC9TBtMRJYmd/d+W1lw6rEpkXuJZeU0Y2ToDPtZUCz6zQggWrtwjKILoL6EDy7b8i7IK6Q/XgXkJZE7AbpRjOdrHrrD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb+0fPcrpH1nJvBr46tuy/ZYpzq4upY3mUiARI4CCsM=;
 b=QU3bTkxe7dLdcYAa7JBpcc64hjHp041WdOX27LKgTA+mtlLvCa49JV59JbkK0ayLFqbs/8k78ifDMAlBiuLwN9TbMwsWYt0GJSpZa/tLq7wn2+2tZsXia3ze9wCjry18KHbAi0t39PO5wgLx4jHgWfQ1vomwSMe4CpFAI6J7dC5a0x7zyn/xoJL9bfHlBtKLejnWBIv+MVhFex6o5M6cpzLKogv09FGcjw1LIzCv+TMEWmilNtj8km+fqFPFYwMLw8cLUFGFwtqKtjFX7MHGdEf2qK4474FPnqSnfjC5D7VABW8gEZZuGk89Vs6WdhPHMEJy1dVtw8ur8dvJYCykug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb+0fPcrpH1nJvBr46tuy/ZYpzq4upY3mUiARI4CCsM=;
 b=ci0ylugmjlRkByYbaVUrnVbJytKTHxeOOlWfALNelgJ3YkXAzSCjww0XRG9j1UwL4BABwGI1sHbGg1+WDGTncHKNVUzPK7In8yQ/yiDGcdO8dcob2eQfQm4wt51s2kP84O8MAWRqEtIxO4/944bx2Qd9hwuJr1vTiTHuZcjuXpmAe21RQ5BM1BjH0WtNGOM7/KF4S4d3A2B3+LK7aKQvj8wFZZUAXr8O99lMnh/5MQFJEfFXx6VPZ8zy+YTnQP7+FxVG4oP3NbxvBA7aHk7VSLZ2qkRCWQhFjfJHPSuF6rmKkN18vZpZ/OJycYyKTqu/mcy32y2RxH9I+EHufoymJA==
Received: from CH0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:610:119::18)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:32:00 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::44) by CH0PR03CA0383.outlook.office365.com
 (2603:10b6:610:119::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 06:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:32:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 23:31:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next 3/4] net/mlx5: Add net namespace support to devcom
Date: Thu, 11 Sep 2025 09:31:06 +0300
Message-ID: <1757572267-601785-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cea58d3-c183-4974-6a0c-08ddf0fce9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBpp30k1+BUvJAh0mBRKgLw234/0UPeFRfZ6vWa5K1hzCVquPoElbmcjJ93c?=
 =?us-ascii?Q?mlb3Q1v5ydoqAHKz3Hfc7O9wxQn+Y0XvmKjUXmclFhZKUvwWkp5Jfnjl4wSQ?=
 =?us-ascii?Q?C26YCzJuhnTfqOInn5sYrZLGEprOHG0t9JYwFkF/P681u4CmTV+z2Fnix4fn?=
 =?us-ascii?Q?Af+Mdij5NgC62pHk0HWJ+yosCwQxp9IoR8f3AUSQFObw44hklfpap2Hm9W0R?=
 =?us-ascii?Q?ZPjKuXqke7rhvGDGi8KQWVyNhoTdNhruZqGL3dqfXfulCYmFbLTS/rSSQQWS?=
 =?us-ascii?Q?mf3jMXADLmK4sqJ0sy0bp7XP9jaHxFAy9wMzHtFo1YYMSFbxTC2wRwdOn9QM?=
 =?us-ascii?Q?EpyTdE0mTVgcVNMcrBYDDzks4113Zrjf5Oui4xM1fVz0x8jgisnTeQQk6gzx?=
 =?us-ascii?Q?ISVtjNeoOQ9ObLJCq/bfFka9XOvS27x0KU2oOLoyCSZ9SVpGesDzEAntV3UK?=
 =?us-ascii?Q?G0/D/51hRN8gPII4QDb2FGigjtlcZ05gWR3teQxDrVyw5KzBn0aTDqYeuB2x?=
 =?us-ascii?Q?mgZDOZmauqIy66g5hmoquIUczh9YxTCNLzIgT/9w/qy1/lnOvYuGuKUdyUfY?=
 =?us-ascii?Q?IIL990U/JVTIinrIFxV1CsdaHavRls/AZSayb8ZK6kAzEyQCFkUZiq9mqxMY?=
 =?us-ascii?Q?zcI4+pws8pWqC09RjzT6QD/ZAHapMW8/odGzk+H7tR2QEpZpkNYhmlT6fu/n?=
 =?us-ascii?Q?34g2PVunkEGIVft7/1kpn90xyb+H+biQE0vrpAD+dGgvQ3DWMZTbKkStDzmK?=
 =?us-ascii?Q?aRFKF22vmMriICy+nVoFB/7tGOS7A7Y/wR0iqqjsDUFrmpAp2JngWIcZDYCt?=
 =?us-ascii?Q?NXhkYmIGfxFGPmXJyvIcfHdVueAa5oCvupK43ZU7eUeqCZTHPXyap15r941r?=
 =?us-ascii?Q?ouITXzz9ux1hg/QQAGiVv7LN3qNBkJSzsZMAnnGG3YsO35tLI54Z4ftEJjq9?=
 =?us-ascii?Q?/dcirj1TmIdPG+NXuWQnrCr/vHcHm3bmc5lpq8keCTdUEAxPlpzd56QYZJcM?=
 =?us-ascii?Q?QbTA+gEVEgYdbsOWlK48bDVKUCqwA3+QeRF/32z289wKoc6Hnh08WimqOiYn?=
 =?us-ascii?Q?TnTjs7q/Qd1tcbjllbxaQTA0At6bEB3VPzPndamRhUAhlF6IgHYRRBhM2KTt?=
 =?us-ascii?Q?48DQoccTzJkCPbgp1ppOkzjXg/7go2tQTnjBwbWpKYrvP37iiBpcoXB6MIT0?=
 =?us-ascii?Q?86gEBa2kcOQcIx97YZS9ycHRJ5u+czGbcrkb504MTJl6Jg7qKbxiFkiNhzLd?=
 =?us-ascii?Q?YQ67/dZjoDivsFsOFTUi278qMqJj0fnrI6wYaMDeTPN7vuWblyDgtCmVpUoC?=
 =?us-ascii?Q?BwWEDRWxshkXDXvbBHX0nKZHBIEr/btvB/hl6CUJWoqCMzGXXiXePCwRPMNM?=
 =?us-ascii?Q?c1/OsICmIWiyDC8BWHgQ11OUoKbgYzpNXWdBwavVRnjP5LXunzFPurV9DJEs?=
 =?us-ascii?Q?Ue3e383W3PSpNvbZgnX65QBM6G+7XqQS9y4I44VJ/dB37G9ZQ+2QpcEmfnm3?=
 =?us-ascii?Q?oE6wg2T7pKiYUElcX5oNmtAwmtF7ad53FfkE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:32:00.1633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea58d3-c183-4974-6a0c-08ddf0fce9e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

From: Shay Drory <shayd@nvidia.com>

Extend the devcom framework to support namespace-aware components.

The existing devcom matching logic was based solely on numeric keys,
limiting its use to the global (init_net) scope or requiring clients
to ignore namespaces altogether, both of which are incorrect in
multi-namespace environments.

This patch introduces namespace support by allowing devcom clients to
provide a namespace match attribute. The devcom pairing mechanism is
updated to compare the namespace, enabling proper isolation and
interaction of components across different net namespaces.

With this change, components that require namespace aware pairing,
such as SD groups or LAG, can now work correctly in multi-namespace
scenarios. In particular, this opens the way to support hardware LAG
within a net namespace.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c     |  3 +++
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c    | 13 +++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h    |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c    |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9874a15c6fba..09c3eecb836d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -66,6 +66,7 @@
 #include "lib/devcom.h"
 #include "lib/geneve.h"
 #include "lib/fs_chains.h"
+#include "lib/mlx5.h"
 #include "diag/en_tc_tracepoint.h"
 #include <asm/div64.h>
 #include "lag/lag.h"
@@ -5450,6 +5451,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
 		memcpy(&attr.key.val, &ppid.id, sizeof(attr.key.val));
+		attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
+		attr.net = mlx5_core_net(esw->dev);
 		mlx5_esw_offloads_devcom_init(esw, &attr);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 1ab9de316deb..faa2833602c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -4,6 +4,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/list.h>
 #include "lib/devcom.h"
+#include "lib/mlx5.h"
 #include "mlx5_core.h"
 
 static LIST_HEAD(devcom_dev_list);
@@ -23,7 +24,9 @@ struct mlx5_devcom_dev {
 };
 
 struct mlx5_devcom_key {
+	u32 flags;
 	union mlx5_devcom_match_key key;
+	possible_net_t net;
 };
 
 struct mlx5_devcom_comp {
@@ -123,6 +126,9 @@ mlx5_devcom_comp_alloc(u64 id, const struct mlx5_devcom_match_attr *attr,
 
 	comp->id = id;
 	comp->key.key = attr->key;
+	comp->key.flags = attr->flags;
+	if (attr->flags & MLX5_DEVCOM_MATCH_FLAGS_NS)
+		write_pnet(&comp->key.net, attr->net);
 	comp->handler = handler;
 	init_rwsem(&comp->sem);
 	lockdep_register_key(&comp->lock_key);
@@ -190,9 +196,16 @@ devcom_component_equal(struct mlx5_devcom_comp *devcom,
 	if (devcom->id != id)
 		return false;
 
+	if (devcom->key.flags != attr->flags)
+		return false;
+
 	if (memcmp(&devcom->key.key, &attr->key, sizeof(devcom->key.key)))
 		return false;
 
+	if (devcom->key.flags & MLX5_DEVCOM_MATCH_FLAGS_NS &&
+	    !net_eq(read_pnet(&devcom->key.net), attr->net))
+		return false;
+
 	return true;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index f350d2395707..609c85f47917 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,12 +6,18 @@
 
 #include <linux/mlx5/driver.h>
 
+enum mlx5_devom_match_flags {
+	MLX5_DEVCOM_MATCH_FLAGS_NS = BIT(0),
+};
+
 union mlx5_devcom_match_key {
 	u64 val;
 };
 
 struct mlx5_devcom_match_attr {
+	u32 flags;
 	union mlx5_devcom_match_key key;
+	struct net *net;
 };
 
 enum mlx5_devcom_component {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index d4015328ba65..f5c2701f6e87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -217,6 +217,8 @@ static int sd_register(struct mlx5_core_dev *dev)
 
 	sd = mlx5_get_sd(dev);
 	attr.key.val = sd->group_id;
+	attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
+	attr.net = mlx5_core_net(dev);
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
 						&attr, NULL, dev);
 	if (IS_ERR(devcom))
-- 
2.31.1


