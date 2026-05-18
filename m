Return-Path: <linux-rdma+bounces-20882-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDx3O8O9Cmoe7QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20882-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:20:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7125675F8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 718D1306F1B6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408E3CF692;
	Mon, 18 May 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZczUh2Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA084327204;
	Mon, 18 May 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088545; cv=fail; b=r7LwIUKHAf5yjjOFy2ZcpwMj91dMlgsq4hcXMrmeTVf9ZQ3/ndBP+ucdCYMD9EpCvsJ26IljYROhFn9zlhfE1hURt4ippxMZHoVe8CMaZEABJyVdI8qmBz/6+ki6j++30O9ZCOZy8GDPS3K7/kVFluNUHm0Um3FwMKVIwQtAJYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088545; c=relaxed/simple;
	bh=7cRR3dROHYOZW3uiR7MbvYW6XohxB2YMs3qlyQJfxoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROsulmPVfRqVoko4Snx6yzIjuLioObJC4C4J54YvnvZdJOzYgQvojFZgd+mm4JCFocx1UkDXcsPqKlgartD0qQgWci7/x8p0P+fSo4qApMTYjFUmwdJASnxxZF6m22Led9V+g72YCycPFdhUleOT+5kAE5PXJ0J+ju5nS8qaFGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VZczUh2Q; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZdvjHbpe6adyeCmQrVE68Ojs84KS29ijDEfMnYH4CHhHAEhf1czEqQYvDnofeJIWt01dEEBWy5CEAxUbPpUvo4Haq0nKvGMvmeLoOpYqd0/TBUaS5LXIVuukuTGzRsMeuYl7/yySxR+IhH9Ht/zs/mF6UQIg4NYIMxU+X1fvzdrwkge8D6mraer2GuNjoRqbNwWwRRN9eaAc8mZWAxBJ/RLTCHz9x/cFzkBX86NAcqzN2BNCZabkJKWDLC+r/z9+XJvwpzIkHMqytJybzRU5Xn1zXBMqh89K4kiw4BBF6sbi/SWzVzEdI+vnasJoOEp/7XndPJw2JeFuk+5t9oBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eY/nYDpFIEhYnyC1EfCso5ub1d7CkBWH5ne33vU02Y=;
 b=C52N7MHJSwyhqA0GDiD9wRufWK+T3f/dgFTi/Lq6wnTN+0ueLmT9A9EouqKFdQaeoqcTaAABd1PXrpNrR9p5I95TDhGSUpsah5CcJdg0UkGqgYGWhW7CKcfVOjtjE3URmjG/sasAE0RXvSkxXGV1gqIrhMzDZC0McLeLzgpwU85VC3a/Lzf9RmFeTipSQ63mcNTe2XcuSJHDFGyALM7gQ5AtUWS88fg7gE9kfg8At5pn8MLl1yLdO8lQxXxiHXtzt3dGuQFzwNEzNHICTmebOkATL+YRsUSQ6knuY5/ETA3V6pTOafkukEAZbq6L6x1wSuU44H4N+qW8HlBxDhxmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eY/nYDpFIEhYnyC1EfCso5ub1d7CkBWH5ne33vU02Y=;
 b=VZczUh2QwUhi75V596TN1txjYPjMepsXWfOqYt76S88V8GNN18KSVLvgBDf75VNQUwvf8WcNoca9RfXA4df3Y0sYsmEnn12W2saUEs8gk0HoYfSaWkHxwB4zQv36gCouAok+TjCzFvJbNgw7V+/XDtAWX0FeBPJeG/SRUy81mV8D5a3ZUJvGetnCoJGkZAlzZ3WPy5IQbighHR8urzMDVbZmRjeCTPXJ/fLH9abiUCpEpK1c0xc7LrW0GtSjmNh+JM2aSDJkeNJtr5gluNZ1fH6l9lXvQYGxBUMrUZUsx7wuQQhTN3nT7Hb+8S9jjkRXw0wiwwAOUpQPWR253eOc1A==
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:15:35 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2c2:cafe::3e) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Mon, 18
 May 2026 07:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Mon, 18 May 2026 07:15:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 5/8] net/mlx5: Add mlx5_vport_set_other_func_general_cap macro
Date: Mon, 18 May 2026 10:13:53 +0300
Message-ID: <20260518071356.345723-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260518071356.345723-1-tariqt@nvidia.com>
References: <20260518071356.345723-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: f280ef1e-e0ec-4283-df74-08deb4ad4168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	5CaToMrto6DPIu22Gbkchzkf3OQ/feZ2bYMM9RUM3ZTz11MH6kl0cNiGhhkV1oeRLnwar0xUaAOAs/PrSBInzZmjNCznN3ml45YoFp/u0Xpqw7fVv+Mk00e7PMYKOg+j9iLPAOYw/lCTcvg5gderA5Z0G0lqP+SZn/8i7xEt0bJNnebulmr1CcQXKNR9oHyYq+rgfYAXcOIcepF9EYmBVyVqvvfDUqD31GLgwsRnoFL2LWRsDKGnUM3wu3LB6BGVvc2GJzWw5p999NpCm724R1OuSV7ZeMVxXH6xSb1FI81VYViAerM2leyjtwlMCCbB1kdTz3YoDMHytymbzScO2dB0YzylFNpDZTvLOlFAIXp93MTqknLsWWoHmFM3jqjuCOQ2pJCbN5nefkub681QH3UnoBT72126n65o26A9F5Xcva799aWCUtyAPjFcAaoUw4fBHoTWMXEnhhQL/r0Mtkf3WiXsvo89QM6a8ZhB22FeXmuEZeV/XuOTdD5tVbADRGhF3Zp1MSv5zMnMBD2/7psL3aKkSkQO8YFK9r6BbFmYoQb+0UkGAWHXHntpAcb1fGCK4P7Tc30dxRy9DA4FIwEUXSiTp86TQizP0Il4f89/45OpRkNLUQpssTXwF9ACkuzFztiUG20M3ipKP7XBMp3MQ+tDK46mo1/RF6qWdeIVZ9S/5A5QmWf78vjzWfWjVFUI0fAakuP4xLtelbIEadh+5DVMuL9irYvO1dpOxYY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tqb5l355O6VuQLVpnQgjETat4ZKoSdW+YQR1KYpJB6Gdq1lddiRzT4V8S4BDaLr4CahPrvw0f/H1N6C6mjNcX1T+BD1KIu7/XmRK89JcuLKOEHGQdivp0JVUVNuwFBq1JBViV/M1XrcDC6EedfwqQiKHmuCzSPRpIT8u6++h/h+0swEEmn8A3NieDguZTO0kyNCvUvsHQoah96hTvPHa05WqfL0M42VOID1eWt3XzPDtY9hlGpCf8peVC58GSr/DwCXYVyHvKiThup1JBt+08j8HfdR0nyvGGdYtImoqog/jWjCv2fT/ze0NUO0oAsJNT3pxrvIuqm39NtGKqLSmYTD+2kTqRTUhPgJnBQHR5RKY08r3yeb32hP4YMypPSlzQxaGC1Us9lechBoPkcNR566DsIVe+cv/9fk+KqxmZud60fsg6z26YV0nprDykXea
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:35.0681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f280ef1e-e0ec-4283-df74-08deb4ad4168
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
X-Rspamd-Queue-Id: 8E7125675F8
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20882-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Add mlx5_vport_set_other_func_general_cap() convenience macro, symmetric
to the existing mlx5_vport_get_other_func_general_cap(), and use it in
mlx5_devlink_port_fn_roce_set().

No functional change in this patch.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h        | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index acbc37b05308..b06b10d443bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4951,8 +4951,8 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	MLX5_SET(cmd_hca_cap, hca_caps, roce, enable);
 
-	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
-					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+	err = mlx5_vport_set_other_func_general_cap(esw->dev, hca_caps,
+						    vport_num);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA roce cap");
 		goto out_free;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index d70907f499a9..2eba141bd521 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -457,6 +457,10 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
 	mlx5_vport_get_other_func_cap(dev, vport, out, MLX5_CAP_GENERAL)
 
+#define mlx5_vport_set_other_func_general_cap(dev, hca_cap, vport)	\
+	mlx5_vport_set_other_func_cap(dev, hca_cap, vport,		\
+				      MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE)
+
 static inline u32 mlx5_sriov_get_vf_total_msix(struct pci_dev *pdev)
 {
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
-- 
2.44.0


