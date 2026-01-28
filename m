Return-Path: <linux-rdma+bounces-16147-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FhGO9v1eWkE1QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16147-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:41:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D3A0A71
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A41F8307D0F8
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054D354ADB;
	Wed, 28 Jan 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tznEwWSp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E14354AD0;
	Wed, 28 Jan 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599742; cv=fail; b=ONkoZnRFyfMP/+TPs16JSKTcuhcJvpkNEryK7R940rxT+aIntOy73dSSDDI5CXBLtUHcJinCn92OUJCaoHdsrNwAZUI/K0h0t2UqjsoVOdXdJSJsAmJhUIzCpO7ntS71mBIuXxrTC0e4KApKyr5nmYcD14VtCiTyP0GBkTSV9ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599742; c=relaxed/simple;
	bh=M0fu/5OPmWeOQ4UzhidjqtcBeNtijcyvb1Hxj28Uj0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfHIlzm7DfL2R0lhgRjiFjVKon3rMCLeY8zqTv0msii0COy3xsLjFXWtwF4bZ7K7U8x3gL/lV21zCz9eX7iEIHIpEmIsjon7mt7GMuvFtJp+OoGRrc2MJdS54SUlaHK4lBpC7wuh/z7o6YsscXgkRgOgudpd3L3UC80SkZiAk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tznEwWSp; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0p/9jL/F9lMwfGtjfZCsm/DqP9I8BJ9Es7qL7z2cTmBN9Vj+vgykcFwnrQsED0EfAmNit3v6bGKD6f3IC2ziZma1IV7NoMEf/a9mPay9C3YmqLR3Frb2Pv3ESlmNlxF8aFw1UcDVLt6uN0gWrww3/Fd1bBITvox+4WU22UAI51InZmPsNLXxlqVFa3PSU2XE+jDTo9hFfBu0XQN8TKJslDc0SgO1eqXNnW5kDz8qwRUjYwyY2Fr+dxlJc63tJMgVdHSl+712arXabdJT+NbReRmvSebtZD5Rl5eWhLGkptyX344jt2dLHenN54HYFzq2EGgGbfiT6FPU/vsd+IXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsGrIuUMAb+FUG2KyVyDhz0Z9IaNWv+cQkgBkIzgZC0=;
 b=F4N4KPoRNSF19OH2OB7cqcuywdizB1QvpQ8vXoZ+TX4HjrtZp4rcol4AMrDLN4JZXEG9YiHn1iBUDx0+QZZAMsFpXp579ymoC04LiLXOWrKDoz/5RXuCy0ZlF3o4tB4Lz+obAkSpc7k/+eyFT2njIKxojh7Bj8QY2gqNxNhm7C2+rW5lcFxTeuc9fCp58Wv3epg19daukZA5B4gnNuNQaS3tbuOc0ippN9mi4tR8BjfyqNYp2sXLlDLhtkvSZ6CgB7eXRar764bJk7+SQxTlj1No2V2goW1pDWBeTACh/XmmrOUvUSO96BjkK5CWNJNxknjuTfPZzg328hzdbvTrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsGrIuUMAb+FUG2KyVyDhz0Z9IaNWv+cQkgBkIzgZC0=;
 b=tznEwWSpYz7NEfU1cHoeBFJJ5LR8dUmTpia89VSo29rrCAu1OgaOXVrdvU11MYmYKAEUbMVvTwD+yHF5P9fqZmhpaDZguysJ8tWwGw8Pe5T9nC7WCIeKUPdJ3jNge0Dci7rScVBBF/ILfpK11fSzeB2d2RnBPXQWr4bfwoFQzpTYqkLY+WllN93yaQtncb5RCBcwIF9+Ii7+JvfP9i8RdU8tv9RHNcMOCVaqzTJeg0Z5iI1Ae0gJdwahbs7MFAPlfqEnclKjayRr5ruC4GgbmCo1BZK0iiqkTGsAZe82K8lNlWVdAlogGGrAdXYtQ5R1pgBulsOvYwQPYfYYk2jz8w==
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:28:55 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::a1) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V7 13/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Wed, 28 Jan 2026 13:25:43 +0200
Message-ID: <20260128112544.1661250-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cfaa41-64b4-4569-2610-08de5e606bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5rObm3Jst/ApdmS90EQZ/K4JTdZN4BO9t3QKTg2CBaqJ8radaduUc3f90WvJ?=
 =?us-ascii?Q?6fz70N9gw5QN7N/hJky/2MZ75OayoxUTcROSi4Eb8BjNlRqVBKYDliO7zgQF?=
 =?us-ascii?Q?6XbAqf4njmadyOnh0P+AlcUKfnUm1kC3s5fA7ofXxV/7XQnCmPlKReIQEfdo?=
 =?us-ascii?Q?JP9FDtvmCCuj87sNODtguiyD/GZH11GFLHIE2On4ZlIi+3SU8y7NHLX1BJ13?=
 =?us-ascii?Q?4ulAQl2V2y+8hy08k2Bkq5vVkkHKQ8eQX6dHR3rmdcbyIAbyVBWS2HGi9RHs?=
 =?us-ascii?Q?KzOwRIiwm/5HRPJEQbzMM+s9i8i8IRrgpchSxX5TTI1/cBZRJstOpslqNTeH?=
 =?us-ascii?Q?kDyorgFLt8MTVcVPOmKm1Z87rpcIOEu3ihThQC9Y2DrNiMJv3kD4vyWehJ4A?=
 =?us-ascii?Q?JRq7GSoiR53BakPoeH1/qKfbIS99jmguFRf1A1SBKG2wGRz73e4s6GhHmmL7?=
 =?us-ascii?Q?vAiUHszFbGC1afkwxOaAmvuBnL64U0GWbmOG7AnLHSFvt8Jo47eiQAnL948l?=
 =?us-ascii?Q?CAnqqzEYxSt61g3b7O5XxKwCagkuaI/swOrbSF4B5eNTcSfwI07XHISN6+py?=
 =?us-ascii?Q?i8bVuuctqjvGkngvM3i0P+V+UqBavfqN9MhpW4kXU/ZcPiYIPmenV+ZfIgAN?=
 =?us-ascii?Q?3cwpqVBGnnJCPSewQU9aNLulycgLHkReSNqMG8hSE6paduy8fHNFfSksyWA6?=
 =?us-ascii?Q?asr5z0JtmKxzA7i8Qzn17reFQarzB/CVjEatSZz6z3kvCS4gBj+qQRIsA2Q2?=
 =?us-ascii?Q?CXKgCIqFD3U1aIGOGYtYdZVqA91R5wcQIoCIsdqfGCqUZRGEkL4lnXqk24Uq?=
 =?us-ascii?Q?wOaCufDAFAQbPGp4H2X5XQDH01H7I38IZB5I22bgy0SpeEVi22okH3HQFhNo?=
 =?us-ascii?Q?GucTIuoBRX96gomWKytg0Oof3hbPY4uekE+xHrZqvXCk0kv5sQZAthyhp0lO?=
 =?us-ascii?Q?o+wEoj2Mb04vsodiOv/X9iT7nNUowKsJFj4w9gvLCxcif2nKcFFipCXSfNKb?=
 =?us-ascii?Q?J4zC1ppSiXbvDuahqxQCv3l7qBXRzx9szJysFRTSMo+7EaWA/t3ThZZTAkPe?=
 =?us-ascii?Q?7F9WYWm2SThFqx9F3TVTycBScYVBUPbHoFvV7ftmMIihCB4cb85Yuqplf2AM?=
 =?us-ascii?Q?5/WNg0XGR3BbTl+RUudFcmPv7xlBsvYKhkaax8syQQ9R3CEgb3joqR3I6VDE?=
 =?us-ascii?Q?hcj8HkI8zG8yeF1ajsqyJs0Rt5zZlVTdnJmhW1jQUszzZodehBOS4iIf/21j?=
 =?us-ascii?Q?e6okkf51Idssy+DZwsNuvMtVXuDeEMiLqs46R/6ePWR8gUHcvgx2Lx0QR8SL?=
 =?us-ascii?Q?eItSaQMy5odGOF4hnO18Ax8uuZLh9CG5l+RK7NQh0qhbIu1Ox3A/lmOtDu4B?=
 =?us-ascii?Q?0z//v8IxgqZTwVRwByFPe1JYAJD9l34UY5skGfQCMCCP5xB0MMGemIv+SAsy?=
 =?us-ascii?Q?VeS6Am04VxNNhmDBPF05qQJIbcBGIRSL1BluH8vQGMet1VtH8qMR0EgMnuNY?=
 =?us-ascii?Q?b/HsAssmU4rUnhd+4jFOycKKKvB0jqz7GdotbeMFSxWIU1R5I+cZwk5a0ZvZ?=
 =?us-ascii?Q?ySddtRM7HclT/6vvY6//q6bXdv/NSgx01e5vllrwYkZRZ4c0o6dpduDEXHQP?=
 =?us-ascii?Q?9celqIx37Bmb/2yZCmFutENzS2aPuEEj9ONhVPcgiUGDx4DtUWRfkomp8VTR?=
 =?us-ascii?Q?TQ2y/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:55.2642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cfaa41-64b4-4569-2610-08de5e606bf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16147-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7D8D3A0A71
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Up to now, rate groups could only contain vports from the same E-Switch.
This patch relaxes that restriction if the device supports it
(HCA_CAP.esw_cross_esw_sched == true) and the right conditions are met:
- Link Aggregation (LAG) is enabled.
- The E-Switches are from the same shared devlink device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 122 ++++++++++++------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 0d187399d846..b4abb6fa2168 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -50,7 +50,9 @@ struct mlx5_esw_sched_node {
 	enum sched_node_type type;
 	/* The eswitch this node belongs to. */
 	struct mlx5_eswitch *esw;
-	/* The children nodes of this node, empty list for leaf nodes. */
+	/* The children nodes of this node, empty list for leaf nodes.
+	 * Can be from multiple E-Switches.
+	 */
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
@@ -419,6 +421,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -430,11 +433,18 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
 		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
@@ -446,6 +456,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	struct mlx5_vport *vport = vport_tc_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -457,8 +468,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_tc_element, attr, vport_number,
-		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport->vport);
 	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
 	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
 		 rate_limit_elem_ix);
@@ -466,6 +476,13 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 		 vport_tc_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share,
 		 vport_tc_node->bw_share);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx,
 						 extack);
@@ -1194,6 +1211,29 @@ static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
+					       u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++)
+		if (tc_bw[i])
+			return false;
+
+	return true;
+}
+
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
+						     u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw = (node && node->parent) ? node->parent->esw : esw;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static int esw_qos_vport_update(struct mlx5_vport *vport,
 				enum sched_node_type type,
 				struct mlx5_esw_sched_node *parent,
@@ -1213,8 +1253,17 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		struct mlx5_eswitch *esw = parent ?
+			parent->esw : vport->dev->priv.eswitch;
+
 		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
+		if (!esw_qos_validate_unsupported_tc_bw(esw, curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1224,10 +1273,9 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 		extack = NULL;
 	}
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
 						 extack);
-	}
 
 	return err;
 }
@@ -1575,30 +1623,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
-static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
-					       u32 *tc_bw)
-{
-	int i, num_tcs = esw_qos_num_tcs(esw->dev);
-
-	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++) {
-		if (tc_bw[i])
-			return false;
-	}
-
-	return true;
-}
-
-static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
-						     u32 *tc_bw)
-{
-	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-	esw = (node && node->parent) ? node->parent->esw : esw;
-
-	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
-}
-
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1803,18 +1827,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
+static int
+mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
+				       struct mlx5_esw_sched_node *parent,
+				       struct netlink_ext_ack *extack)
+{
+	if (!parent || esw == parent->esw)
+		return 0;
+
+	if (!MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling is not supported");
+		return -EOPNOTSUPP;
+	}
+	if (esw->dev->shd != parent->esw->dev->shd) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot add vport to a parent belonging to a different device");
+		return -EOPNOTSUPP;
+	}
+	if (!mlx5_lag_is_active(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling requires LAG to be activated");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int
 mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 				 struct mlx5_esw_sched_node *parent,
 				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	int err = 0;
+	int err;
 
-	if (parent && parent->esw != esw) {
-		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
-		return -EOPNOTSUPP;
-	}
+	err = mlx5_esw_validate_cross_esw_scheduling(esw, parent, extack);
+	if (err)
+		return err;
 
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
-- 
2.44.0


