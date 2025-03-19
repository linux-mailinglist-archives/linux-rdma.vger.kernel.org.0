Return-Path: <linux-rdma+bounces-8832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569EA68E85
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45043BE4A1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92991D5AD9;
	Wed, 19 Mar 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6qiiXp+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3ED1C5D79;
	Wed, 19 Mar 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393086; cv=fail; b=SdM0TEQ6wqsQBfl9/OSPw6yU/gOz/aSwqTb+3ktAFOC9XYHxLt4tAaafX/n32reC22xU+R5d7CaMZrC3BYhNl5aT/fyMer7+ahgvRmZoZ/qXGx4KYPpE0LC03t+kJgY16uBFPn8K6Vj7sW9Ui79PsFrtRVuvMQqDT1JNX9PrlWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393086; c=relaxed/simple;
	bh=evxrl2AOjnkMQizgdcCfwx+mBNnklmaBdWUomIIIGgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na1K20ZwBsqe3uvE0jWVuRpeHxpFO6GdpobObDD5/0Jr17IYZGZKPDK6W9H16C9FPjc8ax4LlP0Om6m/zS+ZZKSMHbKPHAnl8dlLmsk1Ew3pUA3uctWWWzVE2PMQ2UwGcxZop2/sscF3e8wsGpisX9l4ZVmzFan7Y9uqfdxYMo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S6qiiXp+; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpf3toeEtS8EulEuS+GbcKEsnFlsN9KuVdj+DWB/4jQ/p0SnEXIbFve2ci4TSriIkcvsloIYvAR41a8n7uKhnE6ftommU4Wl3ihSjy5M24RhyZBQoXlb31SN2tyqCEerBX4RIigA7zZxd+8T6mzmSfRUzJ+HReFz8XP4CENovFOBdKg3rde4lrCk28hY+DQK1rcwp1gtG4frVW7+I3RRCBsbRIWokNoGvQOmE54fcU3gxIi93C+fxbDBuFdolk3YmbPNXJwTI+CeIVO+XUhqs0wi+kyYbfWE4FpYkWxTLYsZom0a+PbQFFLSUMxJ7ZIT3kbGvc/2OU3BHf7OxOT42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpT9QnYwSI4gHouSPHXX/Hpfdoi0NT3B879sThsqwow=;
 b=I3jw1FREo9kt4PN4T1y4eorjkpeN4FJr0hr8DQKg87dkOxfPrAub2nAlGVMRIzlgEWShwg+mv8qqYLNKhtSj+gmb+tG4Bbrb+hcmxu3MbUWqDVNk+c3qnBRkDkV4r3zA65Dbaxu5aV3ODFVeKZJHIhVAGN397E6EL5Dcqbk3XaFiy7SXz7uGsak48FzAVwKrCbZWZ8yIPlXPZ/9SW8BxK2eKJqF16MvzdKLEYUcOCaTXVd1g2dCv9innZnG1jxdJdKnFEk7Tluwm2OP7ShranCaBeGtnaFY9FN+LrkG8GlWaUo701MeCVsSaE88e6f7KhdJRk++MzMO/ikmt4K37cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpT9QnYwSI4gHouSPHXX/Hpfdoi0NT3B879sThsqwow=;
 b=S6qiiXp+4XeiVimNB7wEtncgcJoBpYY5QN0SbMWwhVYxzYNrhWcr/1zQHVt6MQLPNffigowXcyBIzvD/NYXopdrGGgKbG3nqISXiyXFceM5Rybq143HN+PPqlbXYtgsVIkEQMWBSPDfazxamnEBF9orPFM5garZqgjtqGjWI7z89fQOYfNjtHT6Yj93EQDsS1Z2a89PJbYZ8qUXRQRasFRZA0RsFaBzPyoWPznq1NOfxKNnEjJnmHBDsj+o4BNELDMQoK6pA/Gqa1DEg1JqWlJwkz8nMMkwNXjXqqAzDfYl3iat7oq+84/q82uDRE0Powrmr6K1PQE6IhpsZBJT0MA==
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:04:34 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::dd) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 14:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 14:04:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 07:04:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:04:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 07:04:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Paul Blakey
	<paulb@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: CT: Filter legacy rules that are unrelated to nic
Date: Wed, 19 Mar 2025 16:03:02 +0200
Message-ID: <1742392983-153050-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
References: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: b26a7430-e7a4-4a3f-51d0-08dd66eefa40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5R1516HOp3OI7Ei6xcT1N2o3AZrbmMIykiu4iQYFIO4WAlcO3xO0RV3cQZhw?=
 =?us-ascii?Q?rCPnZVyiplnE7yiqmHfySFw0zj1YLDyzR4j2jMQ3zuzP8XFcI4PNoSbWKCoJ?=
 =?us-ascii?Q?A1Wfcr8VW5QOF+bilFSDjwTmv3ewwII3lPaVOUOGIS77C7X17RUygLLDvCcc?=
 =?us-ascii?Q?fsyl/yhhI8dIeCMGn+ZNMnCLfqILxojZJpPUV1Htvo3ZUU2ff2PwjLizltzX?=
 =?us-ascii?Q?RpKGO2j3INh0N9z+w+KWjqnd8rfiPZ/7Y6BtE6vaH95JDXkiBUfyW3uGNqMN?=
 =?us-ascii?Q?ivHuD9p7OvPrx4+NJinpK5+dpq86QONL2P5Z8LVf/O2DoPGdyMfbcVArqtpL?=
 =?us-ascii?Q?1ysqMgIGWK6Wtz5mY2PAWCBnB3Le3vZdhZQaSJ8aQQmSlW7Pr+fZn2eP9Kx8?=
 =?us-ascii?Q?SVw+UnX74ILIBYbt9YmilY5qriErp/c+pVsIGFP9Do4akfC0mVPKC4PVfA/g?=
 =?us-ascii?Q?OX3O5+VGpZ4RLM/9MQO+x8uI1O/O3HC794gLe48Q30U10yiNqVu31KR7ZGfd?=
 =?us-ascii?Q?75w5aJx2sfRAJu34iVDnz3Y/gskNUE+VyNAVhuqV+eqq4RUAZPmM2YmhYTDa?=
 =?us-ascii?Q?NYH4ITo6zH3v7xhlL+gWytpf07qnt2Z+NRkUfgSpsstlJ2e2hfaKNmQ6pfpX?=
 =?us-ascii?Q?r3RwYUeQrsvKV+txEVMuZzgZG0lGMgbUM1EeHP/wP5GCqUza7nZjGHr4NblZ?=
 =?us-ascii?Q?kKTgsgMUCY4oLsxsAbQBzFR9mP8nbKvjhfVE0GMBnPxvktHJiePdVLyagAmn?=
 =?us-ascii?Q?w/6qh+hHhewGyHZVWmcfRkPBDEbK4gIcsfBfoOMdRtJQVN67k1m9SnYHYRCB?=
 =?us-ascii?Q?DODu4vJtQ+3/x+fSh93z+rc+zE8XePYfiMA2cgyOGGLhEos6hX1UnvIEOsvU?=
 =?us-ascii?Q?wz6c+sg22MKiy9dVHMm2o9PBFPsU7do19Lsj7wO1DcyUamYQzF7kjhFbe75t?=
 =?us-ascii?Q?+KezIKIhhm95+VPBSMZUt/lPwbaPGsNSj0vz5E1oWq3lIVvJ00l729+pe/zY?=
 =?us-ascii?Q?INO+WvhkfXie9k/aFAX6uCKgntUCMbY+sYA0Ef2ussC7M+oxAQLeC47br/MH?=
 =?us-ascii?Q?weiyhK0CjlY+Yxjm8qDnVO/MY5DeySxaU0NtHzWwYCOm/YoxZQyMTaK1hdwQ?=
 =?us-ascii?Q?imYiAzL3ugFWeaOT1O6rFkBKmIVqAE6svJ2G12WZ2C9UPrwvPrK6FuRhgPoH?=
 =?us-ascii?Q?nvZ19mXJy6JSUOa5zyznIiDnFo+r/l4FW6IRsPo71xdltgQLHm8S7qZkGsyY?=
 =?us-ascii?Q?zLVzGMo7mJtOVF9AHbqiWx+amN09bmmTGniCbUSkO8gdfrOShlU4oB8iVHxO?=
 =?us-ascii?Q?aFhUt6dZ9BSu6UUgr3/gwF35YyK0jeeaxC9ujqObV7KeELthfAnRUBOpP7yh?=
 =?us-ascii?Q?SIs5+fnNI/MUfMqXM2c3n2j+SdAP2OWiUfeUEms5CevTu2Fj0Or5NhJr+kW5?=
 =?us-ascii?Q?ql05F7yE2AajAJMfZjT7vsC/f84xk+hvkTIRgI7XsLbvagt13/ygZDJ68sWO?=
 =?us-ascii?Q?40F4Cx5mgHafJDI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:04:34.2153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26a7430-e7a4-4a3f-51d0-08dd66eefa40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

From: Paul Blakey <paulb@nvidia.com>

In nic mode CT setup where we do hairpin between the two
nics, both nics register to the same flow table (per zone),
and try to offload all rules on it.

Instead, filter the rules that originated from the relevant nic
(so only one side is offloaded for each nic).

Signed-off-by: Paul Blakey <paulb@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index a065e8fafb1d..81332cd4a582 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1349,6 +1349,32 @@ mlx5_tc_ct_block_flow_offload_stats(struct mlx5_ct_ft *ft,
 	return 0;
 }
 
+static bool
+mlx5_tc_ct_filter_legacy_non_nic_flows(struct mlx5_ct_ft *ft,
+				       struct flow_cls_offload *flow)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(flow);
+	struct mlx5_tc_ct_priv *ct_priv = ft->ct_priv;
+	struct flow_match_meta match;
+	struct net_device *netdev;
+	bool same_dev = false;
+
+	if (!is_mdev_legacy_mode(ct_priv->dev) ||
+	    !flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META))
+		return true;
+
+	flow_rule_match_meta(rule, &match);
+
+	if (!(match.key->ingress_ifindex & match.mask->ingress_ifindex))
+		return true;
+
+	netdev = dev_get_by_index(&init_net, match.key->ingress_ifindex);
+	same_dev = ct_priv->netdev == netdev;
+	dev_put(netdev);
+
+	return same_dev;
+}
+
 static int
 mlx5_tc_ct_block_flow_offload(enum tc_setup_type type, void *type_data,
 			      void *cb_priv)
@@ -1361,6 +1387,9 @@ mlx5_tc_ct_block_flow_offload(enum tc_setup_type type, void *type_data,
 
 	switch (f->command) {
 	case FLOW_CLS_REPLACE:
+		if (!mlx5_tc_ct_filter_legacy_non_nic_flows(ft, f))
+			return -EOPNOTSUPP;
+
 		return mlx5_tc_ct_block_flow_offload_add(ft, f);
 	case FLOW_CLS_DESTROY:
 		return mlx5_tc_ct_block_flow_offload_del(ft, f);
-- 
2.31.1


