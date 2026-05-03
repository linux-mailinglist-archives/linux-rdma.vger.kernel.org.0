Return-Path: <linux-rdma+bounces-19886-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFCoGWGw92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19886-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:30:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6314B74D9
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 842653011BF0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444137C0FF;
	Sun,  3 May 2026 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ppa0o3NW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95136E47E;
	Sun,  3 May 2026 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840100; cv=fail; b=uTENljuYwTqf6LjuD0u8UdChcn+sgiOVepGkJtZNPewkp59pk8DxIsruD19x04Qaazj1k5XN4H/6gqvKNCm5ZVkZJqaZltZYUegkhg5D+jS6EkyONBuquXN9ux/W/1xmmX0CT8W1RTsj1rMo/gstxjUAhuvNyRv/gMM6vNNn75A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840100; c=relaxed/simple;
	bh=QGg2DF5BggThypHLfDOp6+qtEfemJe5RwLaPJdU2FSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0icWj8x+r2IYpIrbFD5vGQ70KNS9QcL76cyndaS9bk1NNxayhiNo39NHe7SKSNKDb8tTa2vGHSGaiPPNox9IjTKKHfErKY/NdNIHiI/+utP8C6iqgSI2QOK64kPWsY0Wxhx20cVRuQ8WIty9Ryiy7sqDg302MJz+wNIqjfHBi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ppa0o3NW; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh+qZ+YyoiBGjbURK1K8TVlLuhHc0fcDKVw6k//cCRTMIoriVNRZHCIzbwVRIGbGGZG/+CIYGJaS4K+7KqZsTKCooOLTkgJMVkq5IWrNGD0xnLRjsHbdoTbRG87IEMh6pt1SSZ8teroIBGDi82HYnxUYCHo4ds0/zuZOuRhuKjBBzNyyx5zQA370CS7Y2PHorxrEPmVu2TvaeaiaXJlgCi2nFH1Js+wERDfa0crxIMtU1dXP3Hpmb2SQX3K/P7O576g9fxrybM+yBHzjmhK7IEujwF4IiIdihdpwpBe8rIGwrs17c6ojEmmWOTkqEQ7Hjxal84vrbWWoLhbBTY5Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/ztLhB2L+z2PxiN3Ttkn7IVn/nTNATR5C9JkDnKcng=;
 b=T1ljoyP2f9EkerxSWk6PAJC9rtwSx29kbjJT/t0moQaQhuNMate+9Sf9+0Cd7LZ+JNazcvRwO6WDgXV4nMzU90CgRXoU8nH11bRT86dAB3amhTTHV06Y+C4j2DMj1E4rEYnYUC67+PIYiImsmZtRAd7ZO/T2SlGbcCfy7n1uG1uRSXWeEo0pHlnB9ztUKTqQC3tcK82COUk7ewNBO+DWpZFZecw3umnWo8XUyDAQkXvAQHqV7LYC3+dmbXySt01Cq8p79t2tR26oA2GzQie0JJEP57zh1kQ/2aXRzeDM8GDWTDAbB2DG/7DiqdEtJpIUWPKMj8eqHYm+lpJgaAL0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/ztLhB2L+z2PxiN3Ttkn7IVn/nTNATR5C9JkDnKcng=;
 b=Ppa0o3NWkNBK9uxE5bLRDO+3uN0EpcCx0w7KvOOORzlzWa+H63OfWNVabeqH8uRjA5W+brUWRkrPrs3DIvb91RRRNKZ07FdNBgNDsm8u3Caa7jnS/xZwrRk/Jtgl0svAMxMk/YH5mVwEfWF0pYIlQEAh44WAtRkJFkWK5T77p0bb51TKjtspnfrhduiihH+k4NMMDEoH3zPouKUwCIUFoqLQomy/PotKIBIcIDQv0F6lvQATBBJQZgdy3/LKQQTpjp4woGVm67LGU6Jdec7a4wXg0XYCnrZm+y2PmXP6rd/FDNLdeSHhZbM6ifcSeTiwna9OwNvLACtCnF512OHigA==
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 20:28:12 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ca) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.13 via Frontend Transport; Sun,
 3 May 2026 20:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:28:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:28:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:28:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:28:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Simon Horman
	<horms@kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 3/7] net/mlx5: E-Switch, add representor lifecycle lock
Date: Sun, 3 May 2026 23:27:22 +0300
Message-ID: <20260503202726.266415-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260503202726.266415-1-tariqt@nvidia.com>
References: <20260503202726.266415-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: f658e02c-1ed0-4c9d-da90-08dea9527fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tZOCGa27904VoREP0tbZSjYXi7lGE8qOmmyAhfWiN6Z3UGNgrX6JzTGIdXGDOECZtkeyfsjAe3ngvX00dsBqusNynWLZLUdDCssM9P3JQycByEPen1RXGmCpeaSywWM86yXDfta6mV88l3k/3j7iBuPYJdkl0gxZ3/UgAJ50nQzJULG2qzmxwRdfl4dMkoebxzwwEaS0x8XENL6hTA8ZoNxuX9mxcpY+xW8xyEw+EkeN108RGDKPS5H6HJ+Q1dDoUrzhaxYqgpHW81KlSiEG22+KWVGXEWkIaLJNXwP6s4tfU7Sva6WkxMGtnLlg8nmLDLEId5FDN+td8UCe4C4g9yDaBksGgrw2Atd/RkXxAwdaCWfpq2O/XzJUxZ3ae2n5l1Fsk/Bc9GU71o1vVFftRfcaq5d9b6Rp1TaS7VWUKeWA2mRa8iP1J0/yNT6f1e56jnru2T6UWoJLerGYoAEWU0ROM5Jbgj/ktioyubHcbOLDl2T3ahbw1d/DCDyKZ95QD7vbM/G/bQBVLh93Fml6M8guiYEemCcl8ucommgklW9YH7PV3cN914T9QvEAaZpseSGRD95EmOsybhvWNtTMoYWDZESbLQD6WQXz8gjQ6jHtZtUP1lpAnMignCVIMXvEh4bciIWrnKX6bvlP59kU+cInDSbXRvaZ9RI9L2hHXPyGnlxgKt1pDRqHzEEf5yOJaqudsycKJf/cscECcABS50d2AO1NejhnsrtPPO9D+Nc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3QISL8TLuWbQKRtE2+dyUCjcmtVESXAo0PtSe5QskWuE/D6HkWEpmeHOIjNipS+ifv7Dg6BlPBoLRAhalOa55U7NumjI/drBVgIr3M21yNfz1UlW3fqlLsoxGi0A7hS3infS3aJZnJHUD7o9W+umiY/9QWrd1p5DALBEmhYin/rYFQhYaeNBk9xyIv4QiTg406kOLWPU6iZ3CRa4aOuxUhae1UxMuSyl2GkXPux3Wms8ay1uEJ8lyxan8X5+q17CLoWtxbHVPh0xTazwl6ZDpRwXX1ccNhLDRj4xNRw7OZgQ5TJKkaB4Il1DCkrDbPARdH5gCxAEAR5bBovY+/S/UDUBKslyxJTUdeMLpVM2S+Fwb5V/lpfBqFCB6r2g/7J7aNu1Xig1Sbf41hdyLuld+nqyHBD55L+kMkUHzdaNUpBhpkz7/6lxcwT23xQQvFaA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:28:12.6871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f658e02c-1ed0-4c9d-da90-08dea9527fbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
X-Rspamd-Queue-Id: BC6314B74D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19886-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Add a per-E-Switch mutex for serializing representor lifecycle work and
provide small helpers for taking and dropping it. Initialize and destroy
the mutex with the E-Switch offloads state.

Add the lock and helper API first. Follow-up patches will take the lock in
the individual representor lifecycle components. This keeps the functional
changes split by component and leaves this patch without intended behavior
change, making the series easier to review and bisectable.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  6 ++++++
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 2fd601bd102f..3858690e09b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -316,6 +316,7 @@ struct mlx5_esw_offload {
 	DECLARE_HASHTABLE(termtbl_tbl, 8);
 	struct mutex termtbl_mutex; /* protects termtbl hash */
 	struct xarray vhca_map;
+	struct mutex reps_lock; /* protects representor load/unload/register */
 	const struct mlx5_eswitch_rep_ops *rep_ops[NUM_REP_TYPES];
 	u8 inline_mode;
 	atomic64_t num_flows;
@@ -951,6 +952,8 @@ mlx5_esw_lag_demux_fg_create(struct mlx5_eswitch *esw,
 struct mlx5_flow_handle *
 mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
 			       struct mlx5_flow_table *lag_ft);
+void mlx5_esw_reps_block(struct mlx5_eswitch *esw);
+void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
@@ -1028,6 +1031,9 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
 	return true;
 }
 
+static inline void mlx5_esw_reps_block(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw) {}
+
 static inline bool
 mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 69134ce2a908..af7d0d58c048 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2413,6 +2413,16 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
 	return err;
 }
 
+void mlx5_esw_reps_block(struct mlx5_eswitch *esw)
+{
+	mutex_lock(&esw->offloads.reps_lock);
+}
+
+void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
+{
+	mutex_unlock(&esw->offloads.reps_lock);
+}
+
 static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 {
 	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
@@ -2645,6 +2655,7 @@ static void esw_offloads_cleanup_reps(struct mlx5_eswitch *esw)
 	mlx5_esw_for_each_rep(esw, i, rep)
 		mlx5_esw_offloads_rep_cleanup(esw, rep);
 	xa_destroy(&esw->offloads.vport_reps);
+	mutex_destroy(&esw->offloads.reps_lock);
 }
 
 static int esw_offloads_init_reps(struct mlx5_eswitch *esw)
@@ -2654,6 +2665,7 @@ static int esw_offloads_init_reps(struct mlx5_eswitch *esw)
 	int err;
 
 	xa_init(&esw->offloads.vport_reps);
+	mutex_init(&esw->offloads.reps_lock);
 
 	mlx5_esw_for_each_vport(esw, i, vport) {
 		err = mlx5_esw_offloads_rep_add(esw, vport);
-- 
2.44.0


