Return-Path: <linux-rdma+bounces-19822-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BwIBn4p9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19822-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:18:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE74AA34E
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36FCB3011442
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C62E2665;
	Fri,  1 May 2026 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmiNGIPz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862352DEA89;
	Fri,  1 May 2026 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609078; cv=fail; b=jRhT7cnMkD1gbetzdHD3KmkSiIlhS4eo5E7b8+KAZxIWFQrunQ7/PLUPCQCF1dWJpwywLFf1JRz+4vgO63YGN3HTXRqhixX31jDk/QF+TbFnXH7IYpKLr0WfOwpxmHK4oEMBNWyDytvRRoSGGDyV025N2F406Rp3qLWxXqCHeDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609078; c=relaxed/simple;
	bh=UZ2Cr3jMR6Oh0M51DlIO2rm8B4yYRl2uCpZ3xHgoXI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/yQ+LpJkjjsGy+lcQSosOoGlijX7DFEeFdOMNY+9+8x4TJDdeqSCuToiBOFXZ0aeIKO5IRxADUKdpXJPIAhZ68XZ3ldNT/fM2FPvE0OAR2qWys+1eG2uQyMk+lvx9mqkqZO9rYLD6+uNqDkqxCvRcmGCx/85Br97W0oeNyejFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmiNGIPz; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRSk8Pj2qvtNS0saIb0oey/8m6WmI7FmV2gdaxZm/bixYLXNlLbxzQpMTz0rX0VybVEaCOhi9gomCiwCffKlmS2SbuSjlnpeXy+XbyiksjA240vIBCo45F52ii7infhQhoNzYnT/p0b5Lzare1sEsNqKrH4TIGu5AJDSKXBvGmIXDG3Kx/pbkYkAt1gH9ris1/4zpaE/1A942BR1cfyElUZNZrvXBckiG7xF2RTV/JaN8ruCc9Pzb9U3/xEcwo2hlriYwEUB7V39oyKLaYAZtItzM7yh0uiYoQUZ7CD6Lyn8Ei/rh+KDsiOmlrYvtYqvi6m9H8mL9cs25ZL1dzdanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7viYO4/NrXv3vnHbPEhfLcHIKHelDhljDb8aLbW+ez4=;
 b=AYrz9HEawVpLD4uxhXovC2fAHVs9LvaFPJ64O32oh9mPn01HrxjE73h6fnnUJuyBGJkTu/31CxjD7h5qxI/lTw8UHpfnojvjeFCzkcycZl5Z93sp/Keqjxp5K5wqaR5knVptE8ksAs7I3Jlk7LwuRGrpXSGey9Vtx1QbxhnYaBoniP+/C2AO+2hK1CFNZU4sipC3QdQH8K5dUtUwNcpHWY2YHJReZg51ECww2wcAt01/RNsX+iFOWxcEY4pRudOgSZHZvu9KvVK/MF+XLysEmNBtEhQQY1sjdmcKE5C52ARZoSlYyisbC10nt/AH5676rlFZDUJM4gd+/0WtDmCE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7viYO4/NrXv3vnHbPEhfLcHIKHelDhljDb8aLbW+ez4=;
 b=rmiNGIPzJZoc215rwNU/jlcsP36ONBiNxIrbVI8yzwVLqyBtZi0SlOOV2DeYNs75/TD07cXR3Amvkh5jh1mwSWPt9CMeDgreJu+yfAf6YcRHnCw5Mt1NF9mLcstWn0H6EuSKbs1oKctNLYWmbIbq66c4XawsqJ4kVn0F8UJo7eHSC7Bwid7oKqZoqrO1WlZGZXHTiaNVOmzbG2PrzJliju7YI4vgV0P7hRddyxHk8Y4Xkrk4LEI7UjuJVzvEiRES+Xet2MnxkAHhiGPI7PtXnXLMr2skmqHIcVcoqF7QZmF0cvgFYcIogb67o6M8oP2VeZa3zMCo/EDJpKSZVu6WIA==
Received: from PH7P220CA0088.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::32)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 04:17:50 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::40) by PH7P220CA0088.outlook.office365.com
 (2603:10b6:510:32c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Fri, 1 May 2026 04:17:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 2/7] net/mlx5: E-Switch, add representor lifecycle lock
Date: Fri, 1 May 2026 07:16:28 +0300
Message-ID: <20260501041633.231662-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501041633.231662-1-tariqt@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4c6d2c-1093-4852-f6cf-08dea7389b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	52IJ9QYwCwSkcEMshaEeqxAQ7ro3J576PCaJK/o/AEpUmYQd3psxaesZIW4veReMDu6h2YCsZcTX0AaLGz+T9VA4RUdWltmQsvT0COfU6/TMRgLcrH12mGFyKHPS6FnG8od+YXUdYorunzjKoRzG/UI/6emr5pWRWHhm9xfbCTBSHet6yK+jsrw31eZEHTEaNdm/QV+J3C8rPf1J7GVhDcP3wSLqcsafBRgEf7QMJh9ktsPUZZ5vqb3MR3HUxCjQMxwgXWcem37b8zt40zZ3g2kmkbjNUijoA03/ZZm5TWv3MqHFGlWXnyd3WU9h/zdY4Qu5FX0bNdjpUwykqY4F5IDvFDbnrRZuC95M/BkYKM+qlghlkjUhYqRgm5xQ/KHm0uk+Rs97OkMOVVoCDvXO7W4LJ+U+dMZM9y55dk2OSvtt3Cqlv8X8++LdlKWE8Gfha6x1x4+1yzySINylT4Nm+CSvbU+1iIhnmByV4LlMmh8aUl5FPD5J22Pto33PXw7laDiBU78uyLvvwJ7v9TGFyK+Cx9O2/rWpX+g3MDWz5QaD5zOA3mkCXJW/zeskav14vAcohAYVNHGgJ08c2GCBzU62fjLosr4bhouuHGp62Y3iS9S6U4fZxTwpVHYoKmQDT77Ea40dw7Glm+gdFN4eO5xmBYjqhqIAH1mw1fXO28dwwD1SEUMnbTAIY+91d46kC35DL570q1393zTtwrv9fqHPl9FgPWnHn0KQxVJFWog=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bnsRa5023++WmmuehtbUTxXQIUw/w4tEM2aXb/pZ8ywgi/M7UKY6mlo6x4onVjAMi33glVKhV25AQ7v0I5BGI5QcuMkaHZq660PY4ffCKz0p0DKOWEjEdHhpnzQgKhHee28+crkLYvEN+Z945OHm2E2XrXkiuf7t9WJMqHQzC+eTeSVGQ59VS51s7c/N9U/U4nMqAsW4qxDp9eSI0hi+bpkhYa73DH3I7S1ByWdX3H4hlLMFykSjir/4pIMTg/z37L/tfpwqvrWImJhblDWW/OOAkYptgorIicgK931IYU7ctBkATPwP4rIdZRLU4rVpmC35oPHQ8Qpb1hOsEKpLRNDsQgaCLOTfX41ijIOt/W1xHLXTWNS9rObOYHCH3Jr7JaT8JW94VImxzx56pFJSFIF40vm6c4aMixYK/x51USo9sTREmpFFtaKQfMk5l+83
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:17:49.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c6d2c-1093-4852-f6cf-08dea7389b5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
X-Rspamd-Queue-Id: 9BDE74AA34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19822-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
index 69ddf56e2fc9..6a5143b63dfd 100644
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


