Return-Path: <linux-rdma+bounces-21547-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MXpAgsfHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21547-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:44:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF789615D71
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E427304AC3D
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98A384CC4;
	Sun, 31 May 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJTR1G9o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75238422F;
	Sun, 31 May 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227644; cv=fail; b=evnkf+vWZ4goc7zpA01oW9OKUgPfm/xLnfL9bCMc2IoJ8eiRbXjBfSHSYhDeeLo08fvooDdcWeKoZQz9yh0P1S8fckp6bFlMI7mo+lYsbXnx0Ueh7xiP+cl1QknGLWlxrxo9leqewE6YohV0t3N+/8YjJP7MCDYIT1E0DS+lrMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227644; c=relaxed/simple;
	bh=IPrI7sUDDAjWVCBCLR3deDGQnrnP2EKCkPy4PIpZ+qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUV3D1ZwnDBW8f4PBsN1MURr0/1PsHXN4JefVaIjQL+LwHhignjHksfmbsDv0GDOAfaWYxpU68M4+F/GTR6ofRqK6AMfyXZ4A9eIRASRzA/3isFdMLIh8oy2Npu/ajLWfTcQXH2BvYadFqMGdcBTEj/Z7bZQolb+lIpEiaMPs90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJTR1G9o; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7yHdV8kIgEnf+pw/UNdQUD7o8rVm5Sn/+A4b9gJSB5O768QyCwky8N1jbgua+qdHcdNJTEYWdjkffeM7k6sclVCFF7BTUlRB2AKsPEvWqK5v/6uyr+FUVPu2ms1kj/7bSq9fqVtbF5uMKgpUQr1R3mepJRfspj4cwF2w+gzkDdUexAAbBDw1ETijpzNzoRv6VYxjDC+s6DNUX9ymQ27OvfD1QzsCb5n6rKIAbdtlm4pkdnaQZL117lMPonCoZlSdkKvLmXvk9qpE9xb5RoI3A/7QISykkJmYMlW7Tp8eB0tIFCfkLHLaLaAs4Z/HbJhfzDJeGJK06cIUFIFZiw6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DUqHGpi1kP00x6OCGdKld5YupC/sTktRFIvhwPKPbo=;
 b=U6u1wSdymqRLepTVqnHsEmLA6MvwZamUV8nNud0RBbSc7Wa/O/EpCf0LldQ5rlEcbtbZfkp7kj8xXNnfCshDf5wZ1tk74fGRFh/VBtC1QxDTnYhLmtIctorL0UVuhwyM2njYbFssbQobI171t0w6s5f+384hInB+WfhInE8c78dD0reCJBe8ekymosH20Nz87H+WRxuDwsb96qOIgS4JvEBZGRXiSUxV/Pw88B7XBKuSa/SIkDn3kkrtt07g6uO+2Jx2PD1nqhomYApsd5iq2/QAK7m3/LCPA5QLcpWOf2hATwW1A7AvLTAo1QfRKknGRB8Vp68iJGHvR85kEXdO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DUqHGpi1kP00x6OCGdKld5YupC/sTktRFIvhwPKPbo=;
 b=iJTR1G9okP/Mi+axSBqHI7/R4rLy6NqGD2A12fbO68OjYoGRG6gaFOJtyBWu6xtQRO8HW6KS2EXf+3VP94XcVbFYS6Y3OAb7dUXeazEh1jLWIyJyIiEYZquf5zE0e1lCGGi/mcCv8lnRRc+uCVYELPF5c5nE0Fd5ZPbW/a9tlR0TaN61bg3l4jYSrE4U9bPtld8YPp905hw72MZadod0W3946UaS9qDdgQKVrCXc/tKQtYnB6syi1/PdJbu+b6mTg1UdRGrDRpoWXl8tIdl9yitpOKCksSaIO98Xxd5yTOY6VFQA9zV9EHUtmnT163ibimXyvVyqjKuBS6c8sE2HCg==
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Sun, 31 May
 2026 11:40:38 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c3::4) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Sun, 31
 May 2026 11:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:40:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 03/13] net/mlx5: E-Switch, move devcom init from TC to eswitch layer
Date: Sun, 31 May 2026 14:39:43 +0300
Message-ID: <20260531113954.395443-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 05979410-c050-479e-0670-08debf096fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lByrjGswkVFyJNZhqc8IUK1WN981FYyjZ9TVuAdrZqzK4t4R8w9584AA3a50rJE8ZJrmBC9WnDqKrGEAVgd6FQk12jvq5BceqJKcagWqb1/5imBC7wJEMD/7l4IB+DO+ejLWrTlBh79RESlhkLuJsApUCzz7Olud3zbiDOOA+MGx1z12/aq8MZNKHNQmfjn6ULOqASIedvaxouAabcNDSbe2JmY1YLZxWpeENCXWZHw2Ur/dZRHr5LD5WJGRMlMnSzCn8OD8BUi5IfpY8JYA1WEEwFiKYfBNfiFXv6uPSQS4obGlu9EbqNvdgZ7UAaSvxSqFCGXR80TLfvago0Tfp6cLVf9Q+57JXr6xKSAhuLlW6ev6FgKz1KugUamNCgeBJrVCwYToJY2fRKXM+pvrJVaA1yTZQVz3V/OwWgZfj9T90ORBZu1JHi2//8iZijSUvhSWglwuvfZ6Gk9oBjk2Vbqhp0QkjmFD01oOxhe4Ax2QA1GboLhZ2hWzhPo6hzoRvA84d0s6kFrEv8JKWRfZbMj6J2qLZEMYTYL8A+SqnWSIDyhtrPcS8eOvHWf4umjkYHWRQTnZp7lS7SBR7QknU4pQMohMZwWofOS/D2Iw/hkdtSY4nWrN1v9IwQqIcveycOGH7nTpR4vfC3omRG1KfmEywkz38p8275Qtqj3RdR7OkAmbAehoKOud3sUHeTu470I6YxPS5ho6id1KPo3tT8c6skwiLgs4acT1knUbE0g=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gFE/jfwi1YH8Eay3zDnChepYuV/pTsVEpXOTTveW7V88VOjU0+O06oVL6+bYLW++3lrTyNxGkDmcjepk1XfCYWxCOvD/DLHaJuaN52hUIk5A7VJrJxkqPuirHwccY9sxS21J6mwuU8JHmqVwN3M4Wd09O7GW83ybduzVSI/JPdlz32FSE7+CCOr8FMPH3Vq7x0Ycdvb4pF6PxRhUHZou07p7QxEFM7GY82ZTcEPBm4q6AGCN9qj9io8yo1JhaGvMDg6xbE9kTDeO6+YkByTlJdyLR6ZJdWwB/eoitSfnpDxsGAPzY95rp6tf7sbSNrH0Bx6wrMV4+nJOHrDsTgVfBVhB730zGkuLYnqHqz6Ym/JF88ddMZBYI1/mhYaRmiGyc2wwBg9PLAANGIgP7fS8klmvjd52NngE6wZmGP7+2Re+7mkEtwex48r9DYz6Ie7v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:38.0410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05979410-c050-479e-0670-08debf096fa9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21547-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,attr.net:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BF789615D71
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


