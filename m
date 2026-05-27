Return-Path: <linux-rdma+bounces-21356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CUVDinrFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:01:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 412675E48B5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63C73043F4D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A839406299;
	Wed, 27 May 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ba785gc3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31333406270;
	Wed, 27 May 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886555; cv=fail; b=UpWW3JlKxWztChb7H53IZeKgoPoOsqlcvgi6pn2AhwT8Y8xPs9qa7QEM/4LS4E+LThL7vP09Yz1EG9+KQIuI7A7hukLTTN100glSpFQkhCtwhygjAAp4m0cw8CKBMTWbGhASYeRvbYM8Cn4/FVQ0BD5NoIF/p/HOVqAGJUNEnuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886555; c=relaxed/simple;
	bh=IPrI7sUDDAjWVCBCLR3deDGQnrnP2EKCkPy4PIpZ+qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AB0cWO+eE9KradR4y4vG39Ek0qZzkasnA9PDFyfGrJ7sHJJeCJNH0MeM+zQaL8ioH1nDocCgSpHSd6z/2CaWG9LSvKuSPibxRoDs0TZHzf5qU9j2/0KAY2CSS+Gvl71YSq1p5jFKmFeb2/ue9ObAxkSju6ADFzlXdaK/FqMYU0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ba785gc3; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKOj42xQDbsZIq2b1hl8f67Bhc2/J8UePS42p+TTEviMYjBBnfHaVQazTKGFEhZU6i/SvKTYlO3y8jwCleLdjJZtL0T5PfLJahg6HSx3aXvnS0eDPop1l5p/MU5XtX/wG7nOqut1R0afPn1v/PqLx0xqcIHt9Eim3HPFY9p0Nd5fzqB5ImNGP/6WCX/GpcCwQWeIYJbN2dut562UAnVrtGKnrWqO6Y+g0fTIRFS3DdYlBQXMelyp1gw3EjqPPQQotBq2jJuksEm2aGQWIwTRRkJBoVIxFzAMzZ4Fgmth0smIwpWqg2wIrZpGOZUb8xNLH4wEfSzUNFJV2l2Ta9+Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DUqHGpi1kP00x6OCGdKld5YupC/sTktRFIvhwPKPbo=;
 b=w0QdjygCEMBtXqRNoU8BL4R9FxA8gU7/UMlRegfCJaID7ZCdR4OM3F2381OZCQo96PWqRHrP5wQ8nPPkakVIw7CZnIqG9BJqJX3zluDcUgxLMwD+bfa2nD8v3qsqNPCjXUMdhfy+I/KHxuRsvLGwGyn2YhiQOHZr8mYgqPgYm0nv9fGI7grKUFMxp/RmbY+IfoLB8YVOsxtuZHBz0I+V6zKdiP4/algahVGLcBrmLLrpuPWJFeGFUd95D2hGVMpvtabpYTKaI5XumVk010IxE69DxkK3wifR0vCZ6c1CWUgTkeCDdP48jdMUdU03G7Ezsv6F1QwIMyIbOnBKyvgyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DUqHGpi1kP00x6OCGdKld5YupC/sTktRFIvhwPKPbo=;
 b=ba785gc30Z1EwofDMHbLTdezQynikj/Bs9DMjD2CZdzF+bkU2lZBDGELUCmiqeBqZXKMBIeo7msQqu8q7JPAxny5KUlk16rgyJ/ZrJn24M9SLOwzttuEVeUiJhipOMlWWuc4z3sOLkLxgulxqI44s6QVlCfFFcMwiU348n+j/GuR7ABEK+nOmqaGIl04/HH5JJc8Puo3CX51yJkO2MSKzRvoabcH76uSlEK41jpptcKmRBhC/qmpC/1oubUjoFcC7rbV2pLjZGS4bMdAKPtzvdLXEDsU3ZnukE+iq6iEMSh3DAPT76pTLmXdU/ya8RIA2Pg9AD8pYuRpv9AWoa2frA==
Received: from MW4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:303:16d::20)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 12:55:41 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::c) by MW4PR02CA0009.outlook.office365.com
 (2603:10b6:303:16d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 12:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:55:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 03/13] net/mlx5: E-Switch, move devcom init from TC to eswitch layer
Date: Wed, 27 May 2026 15:54:17 +0300
Message-ID: <20260527125427.385976-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 374f2b11-0a55-423e-1d2f-08debbef422f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|6133799003|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	B4hpJdONit4/YC4SdUyBZVd8xWMH7ufof7mm0zC2Is7G09dw5hWfFYBCeK1JtE2D2UQnNq7Xo1cq+SNKhengMiPMJxEAgCySSgJYXceoOjXs4+305c5eT9bSFV4HSoqWODhRx8jfVIWWCSTCbM7AxyKIyWRm+VtwIlxqGTuG6VUVl0N7JRcZ/4x4S6AehAO72LCrBBagrxBM6C1nFA6g1JVxXICtMYx2W1laQ7JDIpm3oJ37TWbeEjcRk/09oD03Gha+wx1CxYiyouvsq9y4Af2Azg8SMYicDsd+XNi9E2n4tbB/AELJYRq59AiWdti53h9g3NoGG4USlMskUTA/Sftqv/vUtihgAiZV6ro5mB8o/nSMnaPhPysGleJEJHi3z8DdcJ6XKL2//+akWFkSzl0W0hGWMErp73Q/kHTj+K/CKVle9wu1qLoNIuZn+EeXmWW4sD/MiUZs9PBtTh6UKMXoeCta6b2FK53RCSCUowutGQPkPFuG5pxXiPHFJiQ0EyYXi1/zWLSe14RMCDZQY03UwNjlwtAHESQZ6pWiWxSiQJUob/ctQBAF1nvTVbOsdih7ehBcIQCHHJz3bhCVI5FNwHsX9QG+pLPGpbQ2KCNvPWyjHpxmPlQPbJDH/DyXEkSxSbANR2mwok0YffhQuuoz670sGomMs8cE896n66TBAZVIwLYGgUos2tNTmFzvUEU/Emc0IKeGFZOJGCF/34ku+7KxfyQSQPRmnrmSq1o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(6133799003)(22082099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yDaRpsOJsDRzHpLJ32iq2amjJPNtAFhKUdgOD/ZspWnKoOcUrjHAlcd8IQT4CTWIOjtx4xOAG5C4/nnOTlua7r5ZKG1CAbp2u6L9LkF5TUDT2+zjywGqaHrlOvht+iEPUXt3SokDvne5SKkDWoHDi8ZEYu0PcL6VYLQhGK+ah81/fuMy8jIkmLlBtdZ7yMYYizsJm2K22eUga5aCN5Su34t2KKzXwu8oa/jitbSt9YyoMw0ApUrJ3MxaiItH8e/iW9K0t3g3dTsenrzRUzR/Ul/rurqsN7Q8NG+1k4sfhxl6QhdrGeRCyFxwnB5pROAMxd8bDKmXvjmgrjhY7LAb/b+HCKQ2G8Uu1Z5d2tyaPsLfsfB/YKqgdP6FKkIzIasjoRbXSZAL427scS9DQqF20GE2Zf6A7UIlO8rSEyHkXeXImUkSyU9YzjYjiJaQbtqD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:55:41.4234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f2b11-0a55-423e-1d2f-08debbef422f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21356-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,attr.net:url];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 412675E48B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Move the E-swtich devcom component management from TC layer to ESW
layer.

This refactoring places devcom lifecycle management at the appropriate
layer and prepares for SD LAG which needs devcom registration
independent of the TC/representor initialization.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 20 -------------------
 .../mellanox/mlx5/core/eswitch_offloads.c     |  6 ++++++
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index a9001d1c902f..3846c16c3138 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5394,8 +5394,6 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 {
 	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
 	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
-	struct mlx5_devcom_match_attr attr = {};
-	struct netdev_phys_item_id ppid;
 	struct mlx5e_rep_priv *rpriv;
 	struct mapping_ctx *mapping;
 	struct mlx5_eswitch *esw;
@@ -5456,14 +5454,6 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 		goto err_action_counter;
 	}
 
-	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
-	if (!err) {
-		memcpy(&attr.key.buf, &ppid.id, ppid.id_len);
-		attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
-		attr.net = mlx5_core_net(esw->dev);
-		mlx5_esw_offloads_devcom_init(esw, &attr);
-	}
-
 	return 0;
 
 err_action_counter:
@@ -5484,16 +5474,6 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 
 void mlx5e_tc_esw_cleanup(struct mlx5_rep_uplink_priv *uplink_priv)
 {
-	struct mlx5e_rep_priv *rpriv;
-	struct mlx5_eswitch *esw;
-	struct mlx5e_priv *priv;
-
-	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
-	priv = netdev_priv(rpriv->netdev);
-	esw = priv->mdev->priv.eswitch;
-
-	mlx5_esw_offloads_devcom_cleanup(esw);
-
 	mlx5e_tc_tun_cleanup(uplink_priv->encap);
 
 	mapping_destroy(uplink_priv->tunnel_enc_opts_mapping);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 189be11c4c39..d9683d3ea0e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3866,6 +3866,7 @@ bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 cont
 int esw_offloads_enable(struct mlx5_eswitch *esw)
 {
 	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
+	struct mlx5_devcom_match_attr attr = {};
 	struct mapping_ctx *reg_c0_obj_pool;
 	struct mlx5_vport *vport;
 	unsigned long i;
@@ -3926,6 +3927,10 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_vports;
 
+	memcpy(attr.key.buf, mapping_id, id_len);
+	attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
+	attr.net = mlx5_core_net(esw->dev);
+	mlx5_esw_offloads_devcom_init(esw, &attr);
 	return 0;
 
 err_vports:
@@ -3970,6 +3975,7 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 
 void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
+	mlx5_esw_offloads_devcom_cleanup(esw);
 	mlx5_eswitch_disable_pf_vf_vports(esw);
 	mlx5_esw_offloads_rep_unload(esw, MLX5_VPORT_UPLINK);
 	esw_set_passing_vport_metadata(esw, false);
-- 
2.44.0


