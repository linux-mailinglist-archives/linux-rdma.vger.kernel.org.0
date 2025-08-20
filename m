Return-Path: <linux-rdma+bounces-12833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B267DB2DDE3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72F81C819BD
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178A321F52;
	Wed, 20 Aug 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EyTgAaQN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDC72617;
	Wed, 20 Aug 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696788; cv=fail; b=j2b4f319m7ZALWVRcYqWFsbrXTJ2rmWwqo3JRUkMqDr/ttd6WgBql6fZvMH/1Uy7SGKbFmLnACak8lmxz+FHQ1iqwwjoq38tCfKKCp8DeXFy3ci74DjY+w7XCF5DSN5KYe/+0aclfPzW33ItrX2iJsQyIZVLyZs28gtIXcSDvNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696788; c=relaxed/simple;
	bh=qqz4Y/WH6I65spf71yHeLC2eEfevmaNfogtKBmhBVAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WukT93BmXjokU0fWV53mK8JnyDRCjVh+eBhafMyz9U01oxUrDUWTAzX1WD1fJn3dVYEJe+Ti/4iZBp8pEP7DwRRgyucLevhYhrvioQYroItviOwV3An4H+A9DJNr/wFZMpDuWGzQM/KX6C4/YgPUcOdloZU2IGBtWk1f6gEs/4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EyTgAaQN; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw7fDNwAksWOrLM57Q6hC6WhzsJ+O3XXX2HACln8Q7ZNSCw0HykPPzheyPE95AuGSpDjV3xozCtAsi4OvIGIpcze1grnKIxnqEyZt+OgblUvtxuhFOfhVlEIyJRjFyA6TU5F3N9MQxDNEUI/AkK902gaNAhOvjs126OaGNvy4Ew0fzd4O5youf69PcNCTZM7N2afOhkOIFpU9mE1fBHcaXO2tyaBxEAWwlhuDb9k/X++s7M/MN2QKg1rw3W66XGhlSDzL+EOdcDeIqqvdV5D4jTBFTBe6tCOM+x29yRCN2Pe4+1t42t1XMBXz2Ax7qsUicEpIjCJUU+xvskJj2hF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktf8XY33QF84f+1Xv1hQ5EihYvWS0Y6mSkQcaxUlr18=;
 b=J0rcvuwi8inDOQJ3RK/1bQ+eS4ZVW2e2MwDKctEEa5lQYleEmfUv+6luvrhPOjkDEn2r9H7bIsIJAkK14FL5u9CccQVH08kpO/UvmXgKWUa/3cwPmvUDOXHXtLVykI0S3kr6uOmGP+LdZH3vuSqrOEBOgpgEmI4C5OaxYs/H33o1PVY/7C9SJc7SnZAsdk0nOiq6H07fMj7pMCW34ITp1wj4l0e0kmuoQ1kfX6KWr4DY3uXK7SDEuS2xx357Jg5JL7YIRHueYISG1MDOsoHQ6iwajLA79dvzwktJ/jHtE3/z2hFnr2YVH4gAQ3TquxkoVfko4ZrR/UweRRgVDM/+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktf8XY33QF84f+1Xv1hQ5EihYvWS0Y6mSkQcaxUlr18=;
 b=EyTgAaQNhPwzuIp7GuS/57i59PS7gFfOKorVAntAvcM67FvpoYce61K/BEia5FB84B/jgnmlH542yXkbk3fyygRMA+noTpu56onqivDNYbCb8SSCAsi8CAma04nWLAmmEWSbrYkaXkCZMZE3F+VjB6EHlT0tdVa6GO/bkh0hipjYrEyS3B9sesOxUK/zW7PMeUSB+kiHAYN1oMl3SUAcXFtD5a6LniCcUeZNw1Ixdr/lutlym4oGKI9u8dnDo3btHmAEgQg7tzAgFoTQ2qclgTAyqUZ4AfW8kBvwx10U1J0CyYCft9XWrbVSY6xK7e040KtOHlc1HH8RU4GRPu5H6Q==
Received: from SJ0PR05CA0138.namprd05.prod.outlook.com (2603:10b6:a03:33d::23)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:33:04 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::db) by SJ0PR05CA0138.outlook.office365.com
 (2603:10b6:a03:33d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 13:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:33:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:32 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH V2 net 3/8] net/mlx5e: Preserve tc-bw during parent changes
Date: Wed, 20 Aug 2025 16:32:04 +0300
Message-ID: <20250820133209.389065-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3a83a8-2635-41cd-92e0-08dddfee173b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j7qVDtY9MGHlYnH8TQ787xOhbXkOfzE4Xch2CjBYa0JNxhDc28RIEAN9fG80?=
 =?us-ascii?Q?sd6uuRyzGAvlWhH0G1I2P/PWXz5wOJFNsGTLenO7SRDcnt0tlztcQIhfroZS?=
 =?us-ascii?Q?yrcoq87blWsXQ24hS2NrhNQVzYlG9gsZgpjbCYx6OtTKaqcpE6ikvwV+rN7N?=
 =?us-ascii?Q?YUJY1pdPUqYvZRQwyrYV1yVHBF1PT0Tdopf/5o9xO2EYFJdDYx0f5/UIwLMf?=
 =?us-ascii?Q?lviI8OWLaM2luZD1ivYBE5Jn09Zp0qljKmRBo3dKTgeSeqlelvvKzXLx07ss?=
 =?us-ascii?Q?McEJpMnXd5KKVjgOEkv4gVRAtRXNv52MbYebXNbGcGqzQMPscJ8Zoy81VloI?=
 =?us-ascii?Q?eL0y4yhH39XhjDU9ZlGjbuAsKkvJQYD04DAw03hCJN/9rMD32mPRlqavY2Hm?=
 =?us-ascii?Q?zmZcFpu13L3KqhuwAI7wbL4za5OIpaW/9koPgV8JVW8md0j+91hXNmW2Cleq?=
 =?us-ascii?Q?ba2+oGs11cXy95DnMD40Z6iDE1GkF4+/gTtG7AqMNqsDEtOF0zDvYUdOhgTV?=
 =?us-ascii?Q?M5Sd10XICornhFIvEssxcPlZVAsJlLJcHtXF099KVqeYyr4+BZDrXvJRnlrr?=
 =?us-ascii?Q?yLtnOXBHyHQmwf9HpTUmY0rKr2mGJGtv4rm688R5qSDqxMVhr8ugpqgL2aid?=
 =?us-ascii?Q?JZ2MKfBif/MH+b4vIgbcramhReUcqY4CaJFkaIc5uRXE0XJw73a1lUiKjTv+?=
 =?us-ascii?Q?Oetu5KdyyTKPifIQPAWpLT9Wto1bDmoCXvtS8IQLGJS+X7HMbAjZ0Z5E3qKw?=
 =?us-ascii?Q?4xnhxMIpUhgElTGabj+Mknq6mvia9ym6ZtxQzuST2eLSNQTawmB+FCby/YnJ?=
 =?us-ascii?Q?gIC+SlAWInPzItz/QS4FaP3LM6RirOU//NErHw88ZySsUVwv9JU/RzFHnZ0K?=
 =?us-ascii?Q?65MhHnFf1DaVOAVB/1XUhTGzmWH9MFyDWQODlPuZKSUNCwkMyFcsDqcFcqiA?=
 =?us-ascii?Q?k5FKwKwKQCn395zCiugljUcUFyeXOCx1urPqbVY7E7L7cxhVYYW7qAbb9xiG?=
 =?us-ascii?Q?oKgnDUXPFvM0C49d6z9go+fmNm7/kzYjdpiZPlEFpR8s85WNxvWdOWYSHCrY?=
 =?us-ascii?Q?mtAQwBZtZRm8pM/v2f75DgzAgpOERtT0/LztihoUg/erkIyep4SqdJYutyZi?=
 =?us-ascii?Q?PTf1qli0A+Bx78QXfjhWw1tBfUP1Rja1nNRR03UcKVIKYdnhPQYU0UcyxWxn?=
 =?us-ascii?Q?cHBbjYV+CEwI73Ir58e4sPJX8qBpTzslPXwUiUT5MreRwSnWYoIUZXoaReGq?=
 =?us-ascii?Q?tMo/ktZIoNZXDCuD0gk0DkfBvBwfk7bXcpyvflFP8gj285ICfJ0bzcZwYbsB?=
 =?us-ascii?Q?PPvcCrlwIY/0b/A1PHO8891fJEuIZsXXvTFaBVrwKCQf+7C28A3PdbHpfFe2?=
 =?us-ascii?Q?9qVY5r62SamY5k40tLerI7B7713iRUmGzpjeYiC06Ae6S/JR5kxjJzHIol0S?=
 =?us-ascii?Q?io6bKyZXK8ysj3kBVMUJ15e+Vrbc1Ov+LHmAsIz5IMFo31C8loWxZE+XGi2d?=
 =?us-ascii?Q?XGtYzk+OtnDqDffjoZiiff9InhlKDBhsuJYR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:33:04.0175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3a83a8-2635-41cd-92e0-08dddfee173b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462

From: Carolina Jubran <cjubran@nvidia.com>

When changing parent of a node/leaf with tc-bw configured, the code
saves and restores tc-bw values. However, it was reading the converted
hardware bw_share values (where 0 becomes 1) instead of the original
user values, causing incorrect tc-bw calculations after parent change.

Store original tc-bw values in the node structure and use them directly
for save/restore operations.

Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index cd58d3934596..4ed5968f1638 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -102,6 +102,8 @@ struct mlx5_esw_sched_node {
 	u8 level;
 	/* Valid only when this node represents a traffic class. */
 	u8 tc;
+	/* Valid only for a TC arbiter node or vport TC arbiter. */
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
 static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
@@ -609,10 +611,7 @@ static void
 esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
 				 u32 *tc_bw)
 {
-	struct mlx5_esw_sched_node *vports_tc_node;
-
-	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
-		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+	memcpy(tc_bw, tc_arbiter_node->tc_bw, sizeof(tc_arbiter_node->tc_bw));
 }
 
 static void
@@ -629,6 +628,7 @@ esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
 		u8 tc = vports_tc_node->tc;
 		u32 bw_share;
 
+		tc_arbiter_node->tc_bw[tc] = tc_bw[tc];
 		bw_share = tc_bw[tc] * fw_max_bw_share;
 		bw_share = esw_qos_calc_bw_share(bw_share, divider,
 						 fw_max_bw_share);
@@ -1060,6 +1060,7 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 		esw_qos_vport_tc_disable(vport, extack);
 
 	vport_node->bw_share = 0;
+	memset(vport_node->tc_bw, 0, sizeof(vport_node->tc_bw));
 	list_del_init(&vport_node->entry);
 	esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, extack);
 
@@ -1231,8 +1232,9 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
-	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *curr_parent = vport_node->parent;
+	enum sched_node_type curr_type = vport_node->type;
 	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
 	int err;
 
@@ -1244,10 +1246,8 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
-		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node,
-						 curr_tc_bw);
-	}
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1258,8 +1258,8 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	}
 
 	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
-		esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node,
-						 curr_tc_bw, extack);
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
+						 extack);
 	}
 
 	return err;
-- 
2.34.1


