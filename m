Return-Path: <linux-rdma+bounces-12715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD78B24BFA
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8972C7AC14F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F91D8DE1;
	Wed, 13 Aug 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9rUlzFd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B562FAC02;
	Wed, 13 Aug 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095535; cv=fail; b=Hm0GvLCuJkj1RMGvhTIX106pmNpYcm2yzm1dZz90DpMw/z52cOizGaUtlHzBekypAEBCw5lVcDEz79RQilSSWZXgHWgaPQX4lzeZ+dQewcNO4SD988QTSglgUd91OxTWeXnmfd1XPdgn3p38rr5DrlH+J9TdU8S/g7ydkrrA5Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095535; c=relaxed/simple;
	bh=aGmiApPT88CyLHYzVjDKbncSPPu6L5nfrbcq/tsWztA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njBit3TzliOTUBePOMZe/YTqo1qHLfJoJc+c+aNY3FFtHWx22Isp/GVpFA9lsOPGiPgfil1dJNJ4n4uAvwnZp5K01HUO914zHSttcpHteG0iXDML5vkUvbFm1+QBeipwOW63Lw0V93rpifL4J5h7a3A5Hj/eXpeLVFBdxCfE594=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q9rUlzFd; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzDtp8iMommBNtUt0FQxtGYuQbURnKGBX+9psRfCru0FYZ6+WhIgJwtTOd/gwDyNNVr5iBvqRX4sPeqW2yLQaEqCqJW4wbn+nfm/gI/kh1IY4LNoBLx0NXJ/fR3Ud/E5pvAVz6X1qXDc/pVNp2NpIvBStwLiTN+bxUFfTnepSYw//HN+cnmXErplCR+5U/qUEYEslLs49hjHJRcV9C7r/N/MBXCNTQjaGXj3tB0Cc09UIkWFFQrnkoA9x2LTuSoVkyONsC+Tzkcn6xFaa7hg+fYuYNLXraN2sfbLNqb8gEzWpz8Q71xuh/Vnwy8fHqUeutj1MzCZ6dvicTnopDg+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+kI3Ho2T+xIfTff+EwJ8ayDGvqZUXM5qn6Ak6ZarO4=;
 b=QBp8Dl395Z5H7CqZkfSFeRGyVWN8KBekYIlMhVFpzcx6T9SFMdTQDpTdwOTKg8RuHeKfufFJdVANQPhS9Ry9SasGY0U9HmC+Pj4nIXCOENB4PhA12ySXXw7Y9sM67vcdY7Y3ev9TlQVRyRlKUez689P1e7vP0x2esa0k77+kcVT4uFthyJ6mE91DVngXWPj1QPievbJqNO/L5NqMp33KV+C8NW+zYjaS5uLfTLF3a58xMICPyxNbtBkdNN9BLgSIMOTs3MNlkJZBWAr9+J6ysj93Dtzbx03gt/x1fjyw+U9QiAaHmBUJqLmyhVSBZ4p8HE412iHdpBX0P1yiX3hNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+kI3Ho2T+xIfTff+EwJ8ayDGvqZUXM5qn6Ak6ZarO4=;
 b=q9rUlzFdh+Ucm2/szwGpmW+DHLmRcJETnao38zLu/aKbWuoD1ZRFwTwxu0mkBnoz5to0vy/kOq7n1kYkklveLnTpOv0rAfL3qRPBkvxnnfbKt2cPPZDXHUBznhoPB8h0YWO45Y7oPosN0cccnyHLZXjjBfX9Ce52TxrANBoTctgSABNmEmsGQt6jGQiQCLiH5hNhq4JbA3xwit/M8+PtL6lbA/VWNgo4m7uOAlZlv2Fi4v5MwRoShi9Z9PNV7mEL9XYoKxygPyFrq7tjvz963AGYOHJCMyAXUkC5rwRD/nle4NKf3aNczKmw6d1iXHR0zgTiNjeg2BbV4Pmpww/HTg==
Received: from CH0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:610:e5::19)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Wed, 13 Aug 2025 14:32:09 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::d4) by CH0PR03CA0254.outlook.office365.com
 (2603:10b6:610:e5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 14:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:32:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:31:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:31:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:31:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 4/6] net/mlx5: Destroy vport QoS element when no configuration remains
Date: Wed, 13 Aug 2025 17:31:14 +0300
Message-ID: <1755095476-414026-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ff6987-07a1-4ec8-ac52-08ddda762f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Mm/ijmlfsxpp3T70aWMaxapVQygBIg4bzDO3g67Pm/ZMDsUDe1hgJRYhaYf?=
 =?us-ascii?Q?IiyksswjJ6MGwr32Ejfh/SERQnBS4g+Dja1j9o6VkXoN7S0jVZN4jP8UiKzk?=
 =?us-ascii?Q?jEO2DkaPWE+ZEZWgp/sjoPDrBx1xTFCXraK/2h1Z+2N/Y62Je/C7+rK2Vbzj?=
 =?us-ascii?Q?x3K1IoWOnwM4Y2jkDeKX72H5bhBR+v5aSVoDIDSl9uZT8syg5Ael1+0G8LdG?=
 =?us-ascii?Q?awsNhjNSUQNUn4Cd9yuNTQ+S8riuDVLLzhdKaDYhoKtg1d/Rp/qoNIqLrQCz?=
 =?us-ascii?Q?P5OIWvOevbgvfypNC5nkQU4CwoumX61O3UOn7xJbO6R7y5FhQIvDxIIfiI2e?=
 =?us-ascii?Q?dWHhAo1W5z/1YuLF4wtFl/YXQZt0biS5hv8RP5kZQAAbaO6eDXhyQ6lwbw1y?=
 =?us-ascii?Q?SQiY+0Xw1Q5jzpIuZtFRrmt+SnuIDXI1kJLmRRsf3QvFJzdUG0+6z1SFqAko?=
 =?us-ascii?Q?5OxMwN1kn8Jxg2S2e3cEeVPjgGhO3zMuFlzTXNJCyfsLd6KyVoeWofrE1q9Q?=
 =?us-ascii?Q?J1/kMhHjreVqm2Ld4VkrlYrTvD7U6FfYUyLmusyjME9YB/xl4Co79cL3HAUd?=
 =?us-ascii?Q?UEeFHNivERmgXsrdvMYcqyLixFcJyhYM793rwNXZN0xNvy7HJ5Coocw+Wvfg?=
 =?us-ascii?Q?mo8RSjHRdX30sILdsQMxzkdb3O+43aVJXVGBhh/zUtFLJh/x02R4ns+uYuEF?=
 =?us-ascii?Q?qpkPN5PmfB08oqj13pwg9bsrQKgoXnuszyzxn1ldiUjESnIyDXDyNLwp0M9t?=
 =?us-ascii?Q?MtmucmEzX2d3+GjI2EcWvHRsdHCCBzf0Xsk++XodjotO4YqvkEt85BMJISZt?=
 =?us-ascii?Q?FnMwHoC4QlI7N4jvFV7+yNXWDQo/HF+dqqmYt1becQ+WhrNejuTI5FzO3rpb?=
 =?us-ascii?Q?guKHllqGwoQMvnCSXncvbkUFSdSOoybx/DW3QShI8MX60KmOQRd0G4RbX0F0?=
 =?us-ascii?Q?Z0Ibm4TX0mMLxX3flaUQYcSsGDmb9fLJHgWA/SMOuSJH/D/2hghd+Kucxabj?=
 =?us-ascii?Q?YxwCsq1fqAUM+2aR12UqkftVHN0Nm9uhvDb4aatJNmc77oHcheXDSV4pxXac?=
 =?us-ascii?Q?3hvKXrPrM6igVaim1wzQgv8+BStUrqCR/kiHpNmlRPDVJlPZAMAOJCzvZQpU?=
 =?us-ascii?Q?FlqNhn19EE/DJQVGU3H20pcvc7WCBM/ZRoLmaifv4hPdbQJv6Enr1ApuW2c/?=
 =?us-ascii?Q?2pOVLz9v0Z10TJKX6KtG3NiKbkSqFiN8SO8iU0GjafmTEcqwI7dmqLa9exBE?=
 =?us-ascii?Q?Ymg4rdCk5h1YwBIS6WL6oslL8vz+130YAb8MvmEx20fXuZQSgiL817/+oNSU?=
 =?us-ascii?Q?KVNGHpiCv5/tOF8YGH3rayN5FIWEp8I0p8fACcGcrLVle3CYbdCFi83g0aHY?=
 =?us-ascii?Q?RlzTEIGfsHu5hRe/3ZrS01P2h6VgyIBaT+wzuMugvzW691oONx1ajlk60y/q?=
 =?us-ascii?Q?BgOz/4dwS5I6C2g1AejKs/sRAOAwbCZYhb8pjAFMCR0JRy5+H6M+KgQQF336?=
 =?us-ascii?Q?4N1fjhp2YxQTK+D0ZeQJF//TLQ9797sKaOvF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:32:09.2184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ff6987-07a1-4ec8-ac52-08ddda762f74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

From: Carolina Jubran <cjubran@nvidia.com>

If a VF has been configured and the user later clears all QoS settings,
the vport element remains in the firmware QoS tree. This leads to
inconsistent behavior compared to VFs that were never configured, since
the FW assumes that unconfigured VFs are outside the QoS hierarchy.
As a result, the bandwidth share across VFs may differ, even though
none of them appear to have any configuration.

Align the driver behavior with the FW expectation by destroying the
vport QoS element when all configurations are removed.

Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 54 +++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 1dc98e4065af..811c1a121c03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1160,6 +1160,19 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	return err;
 }
 
+static void mlx5_esw_qos_vport_disable_locked(struct mlx5_vport *vport)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw_assert_qos_lock_held(esw);
+	if (!vport->qos.sched_node)
+		return;
+
+	esw_qos_vport_disable(vport, NULL);
+	mlx5_esw_qos_vport_qos_free(vport);
+	esw_qos_put(esw);
+}
+
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
@@ -1173,9 +1186,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	parent = vport->qos.sched_node->parent;
 	WARN(parent != esw->qos.node0, "Disabling QoS on port before detaching it from node");
 
-	esw_qos_vport_disable(vport, NULL);
-	mlx5_esw_qos_vport_qos_free(vport);
-	esw_qos_put(esw);
+	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
 	esw_qos_unlock(esw);
 }
@@ -1676,6 +1687,23 @@ static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 	return true;
 }
 
+static bool esw_vport_qos_check_and_disable(struct mlx5_vport *vport,
+					    struct devlink_rate *parent,
+					    u64 tx_max, u64 tx_share,
+					    u32 *tc_bw)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	if (parent || tx_max || tx_share || !esw_qos_tc_bw_disabled(tc_bw))
+		return false;
+
+	esw_qos_lock(esw);
+	mlx5_esw_qos_vport_disable_locked(vport);
+	esw_qos_unlock(esw);
+
+	return true;
+}
+
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
 	if (esw->qos.domain)
@@ -1703,6 +1731,11 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 	if (!mlx5_esw_allowed(esw))
 		return -EPERM;
 
+	if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent,
+					    rate_leaf->tx_max, tx_share,
+					    rate_leaf->tc_bw))
+		return 0;
+
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
 	if (err)
 		return err;
@@ -1724,6 +1757,11 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	if (!mlx5_esw_allowed(esw))
 		return -EPERM;
 
+	if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent, tx_max,
+					    rate_leaf->tx_share,
+					    rate_leaf->tc_bw))
+		return 0;
+
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", &tx_max, extack);
 	if (err)
 		return err;
@@ -1749,6 +1787,11 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	if (!mlx5_esw_allowed(esw))
 		return -EPERM;
 
+	if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent,
+					    rate_leaf->tx_max,
+					    rate_leaf->tx_share, tc_bw))
+		return 0;
+
 	disable = esw_qos_tc_bw_disabled(tc_bw);
 	esw_qos_lock(esw);
 
@@ -1930,6 +1973,11 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	struct mlx5_esw_sched_node *node;
 	struct mlx5_vport *vport = priv;
 
+	if (esw_vport_qos_check_and_disable(vport, parent, devlink_rate->tx_max,
+					    devlink_rate->tx_share,
+					    devlink_rate->tc_bw))
+		return 0;
+
 	if (!parent)
 		return mlx5_esw_qos_vport_update_parent(vport, NULL, extack);
 
-- 
2.31.1


