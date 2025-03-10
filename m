Return-Path: <linux-rdma+bounces-8543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA76A5A638
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361B73AF766
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCEC1F0998;
	Mon, 10 Mar 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pd78Um+7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01101E47C5;
	Mon, 10 Mar 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642113; cv=fail; b=LmjEVhV/Xy1Rs9w4Cc+kBgW5x2e9GBGxkevwBx11hJpz9nJ8vt3k9lu9ug79oJJ9JD0MoFqti9aIqPGsmJYVyrS3NgnhyUNCq1t+NdcSq9SjuIIxvZBe1LH7uiatCNxW5KZ++Tu2BKxRB9hcLyYjT0E0Az5aozf3R5eCeK26QMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642113; c=relaxed/simple;
	bh=i/bU3aySBLT8akfXvCL9gkTOZYy9/PDhBaR1RCQfIhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG0itnGBq88JUi4C7c3G1mkFsUvC1mv4tsLXwSJYRlufvujWYb42lA2olDgXNpAXfv0WMa83T85dLlTMsaMOWNaot7x0wEhQBHNOYmjKhV2OnsWiRh0NkbP9VtTUel0zPqnCPcU4p5x9/m9DDysQjL+DfeijABKzjiTBuVTAO6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pd78Um+7; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhd/uU3S1TNYPjyVKp8R/WG5szwHCNrIQF4ZLHtFUSXP+JeZvCNb/fjWfCtzhdkbz2O7lhNpauxyJV6ss6lqf0UU3oqIHHS5lTM2uvd0WGb6mgO6/kP6FfCujS7/a5dClGyvn/EHogsgZ/hXc9Bhhamh/yvMLTXRb1i2MQho3Da2ul/58bYz5/+mszjQRA1wFKvi7giFdKIzDmchC//LSAB/IPCcjhok7f2iJR5FtMD+YlnNj4KPMEZzVfgpCTNr1DAaHi+GM8usXtHOUYlOSDA5rNLCGn8gxtWSKREAEjZn3JRYYRVL7I23wGyyCvK5vmCzSv2xZCDX2p33DNSPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YMerGf34Y3jDuRg4zOxypPBrWSEe5Yp84aqmdmlXO8=;
 b=bRevsHAxcIi6QP1RPXhR1CQmp5QTNI2k75x3dTR/tylZVA9wZfMO0jBPtmr6757g04a6QjrI2xzeyNtPCoHAYOZhERwwy1w4sVSq5aIa7KP95ieYNDiEFrSfiskzX5VD1A6EkySyNEYpfuQ77d6tdN5UDUmsuAiquXMgDUQew0j0ok7Q8htM9gfEwsV+NxBdhpB/zT+w5/mr85xkVxgmCgCOBNsx3jlh+BiaCZs5LevZHnGOECCIeLno4P2y1QtaxmLDAKpZ4e1QVL6v9/+4YR0VKbmNHgtwaewwVgIaUvTJQsIX4JYyEc7jJ1yH8z2rt6L8txnkcv5bSa+nP9qAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YMerGf34Y3jDuRg4zOxypPBrWSEe5Yp84aqmdmlXO8=;
 b=Pd78Um+7h2pBF7JMdptWTBv9WAidHWS6eg+SjJYPI+oW/tU0Toli4hl6kchlq/bSjj23C7ZjmYwteC/6aCZx4FL3Vk7OMV5L0Wo9zdBxW0ZvIpQSasFULxjRZWsOt2110NDcZL9F7H3qGzEGlm81i3Uhfg5B/zGeBSDyKyVsTz7+ifPfiM1Ep32GmArusYvUgqFApQKJUoA3+aZid2xkwMhKNjcJ9bL+Nc0iDcXKal18Fr8Izz4rcHydvsebWJ3exWastEowq10XAkLpSP53H+2aEouTO/fYLeBgwLZWzys0gofNnBk06jYun8c+7qu+xXVNZ8mAydVxaBi/tupO0g==
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:28:27 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::fc) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:28:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 14:28:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 14:28:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 14:27:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/4] net/mlx5: Preserve rate settings when creating a rate node
Date: Mon, 10 Mar 2025 23:26:55 +0200
Message-ID: <1741642016-44918-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7001c6e5-2594-4e60-0097-08dd601a7d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkHDLRkdsEMBtRBBQD+BZhiv9giEA3TGH2LvuD2IvUgHIr+HQIiYe/+KGE83?=
 =?us-ascii?Q?zUgrkEqC8bt/sm/0sxj3uvcT35/LHwp7Vr+1buAv0PwF1IgEOj4zLsMCJxpC?=
 =?us-ascii?Q?C6VV/RdJi0IrAGV2oKkhNm7iIxD9EehOKoQTP1hiSMypFjNAGta33zrQ7ywY?=
 =?us-ascii?Q?KNDYHptPB4EdJ8vpD24ASYaAoHNfhtMOF086apX+42KZX2WxEMlvF8KxhfnA?=
 =?us-ascii?Q?vpF2I/LK8gmrWESLQYvqOWHRay+RkBoc+qdoarg5ibqMh2oCo/tyzNvEaRUD?=
 =?us-ascii?Q?UTcK1MOXM6JHMQ4BqVClCIJsMJzXuHYeHVkg48WyXZRch8038cIxeD9BTAa8?=
 =?us-ascii?Q?YQusw9wxMbczF13S4j9hKGsfGH7vy+UeZRy77AUzdgMxQrnbJXpIk1Quy1kR?=
 =?us-ascii?Q?QLLjWTH3KoBNWG4myQ6Kpv0cMAXvfpERRLPxBYsCjuNY/R6Hmd0pL8uLTz8h?=
 =?us-ascii?Q?4D9y/4UPNfyJ/KEk9zf5SomgvF+Y3AMDTOZa0qJNdhAINBGr3vXOZj1EVWpE?=
 =?us-ascii?Q?wLspkif7G+bK+27ky5tXe3Wnms6WGW6kEiE324fN1DP02w6di2BVPld+5ZHA?=
 =?us-ascii?Q?Fg8S60h1qYJ2O2Tq2ydwGwFTQ4d3RLBjh1+uOjAHmRa90oei1F2knMyTjmjU?=
 =?us-ascii?Q?Tap4EZwnBfDZqlhHgYMsr3m782f4S6RbtSfL384oFm3zpxgtCVMA458yPrzN?=
 =?us-ascii?Q?LWQ1AY9MeMq55XnjFcl4AsV/jz7wjetUXZuhqGwrLyttr0q+s4om2bkzOl4y?=
 =?us-ascii?Q?oC4Ui++XjxGETGymekw3VITL3cULxlYp1jR92uDZB7GHg7u1fCkVwAOqa+An?=
 =?us-ascii?Q?xDPNbw5tThStlaCGn/Qh0Z25b/+sTFDA1xUmWl4a6txLI0p9+w8w990SXErt?=
 =?us-ascii?Q?EGhsFmC/pn+oZl+nZ8PzV44ZutTyam1OTXUGIlzmYlLjnM9kc6EIVleMcIWM?=
 =?us-ascii?Q?O32aMxyjglh9TaHNlMawCWsQRFBoE+M/BTK9JfmSzJSy8xZOClZ9qqU8tp21?=
 =?us-ascii?Q?brZoOkF8z3H+uSgXPjzjruQmrce3ZEDE32VFS3gIc6qgrXCiJ2L8MW/UPb6E?=
 =?us-ascii?Q?OtSDOFPasFmwF67qXweTdxMNGMLAbSnarBbiDx/6cAE3qiGo6gHwKCJo+uPF?=
 =?us-ascii?Q?0PhwU1jDA1vDeDecZmSiAbckQMIELpiNuFOvENn3hYdFmyA3CyIQLfOMQkAr?=
 =?us-ascii?Q?jt5Tt2ZmlKhCpkkOuIoU2BWnZXkKEimI/qhioV1crxsjFArGfSs5MYZ1WMH+?=
 =?us-ascii?Q?8tCw4VPZ/Cxy1Mw1hfZ3Q0ZdrUUHypD525T0S+Qv1f5nIHrum5C2VOFjj04v?=
 =?us-ascii?Q?5NO7ap9tH9WKq88dJWPj4WF1b8zol+4QFcZHbRbkBivWtuQoBAO3jzMgL8vg?=
 =?us-ascii?Q?t0uTaOqHk0XsSo6eNE5f7wn+yVcg2TAz0n3qflXYFgzNTpW7xCZM/YSJCQkz?=
 =?us-ascii?Q?v+YV7vIeNPMYW+8ikSABRHib5Zk8IjE1OMQ8XWmSF/NS/Z5Rkm84mLshXiOd?=
 =?us-ascii?Q?Jh/5Ouo6LL1/J18=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:28:24.7591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7001c6e5-2594-4e60-0097-08dd601a7d9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

From: Carolina Jubran <cjubran@nvidia.com>

Modify `esw_qos_create_node_sched_elem()` to receive max_rate and
bw_share values while maintaining the previous configuration.

This change is essential for the upcoming patch that will modify rate
nodes and requires the existing settings to be preserved unless
explicitly changed.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 959e4446327d..3c850efb4ca3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -320,8 +320,9 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 	return 0;
 }
 
-static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
-					  u32 *tsar_ix)
+static int
+esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
+			       u32 max_rate, u32 bw_share, u32 *tsar_ix)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	void *attr;
@@ -338,6 +339,8 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 parent_element_id);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw, max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share, bw_share);
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
 	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
 
@@ -409,7 +412,8 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 	u32 tsar_ix;
 	int err;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0,
+					     0, &tsar_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
@@ -476,7 +480,8 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0,
+					     &esw->qos.root_tsar_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
-- 
2.31.1


