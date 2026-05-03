Return-Path: <linux-rdma+bounces-19890-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O7LM/yw92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19890-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:33:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C34B752A
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D2D301ABBF
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985363A545B;
	Sun,  3 May 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l+twqPJu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164ED375AB8;
	Sun,  3 May 2026 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840125; cv=fail; b=ovuhkyFTgTIvBuAyxJs103YGTbHOOtyOezpUejJoiCXHib/ZF3vMWo8Is3hd23tqDBqoxsBG5wkY3sOz5VLVseHeZGVmUggpbAyoLG0ONmuqYRFu3nFDrGq8f9ZjFbFa+t73pVjIhiKUQt7MqM3tVDzgHjNewx3ZAxCxoe5cUgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840125; c=relaxed/simple;
	bh=rvC+4FVzKmJ3KAV/2SoQT51NdzAt935lIVEKBogLyso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r27aEJDzb7bkjDKI+WNevt7IQWSApStUHXO6Xsqb8bhs+XYp4UqNMbgtvX4Rmko/DxzwvBOO/MkzQ5W597FYfgC3WokUTaRNE4BcEZ571y4LkeYmxoELqtKWEQdwXk6wHAONkbCSXJPm1K8TqXOpFztcKGQsoqpA63cb4AVY/AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l+twqPJu; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUQpIRxAuWOWkZ6UzWDdrhtF+TfPSnqm5WJ9Sm+D1Wm+ZvovO9OcnJuylvjjfCehC9PPBZuCQoq5XRoaFoVvlMseQXAMfYdJ37oAScF/joKyxFyyBw9OXdHoYx7p/bIHmfnrPwHJWfsHels+tYMT+C92qBnzNLXDwAxII8wJFgvZ3bhSF5zIP3xmoxN0kpvdyVG3IJK2VLZlq5FRnxhNNRd9PJcFj/h14qjqvsMTr2kS3km3etoMpvsx270KZmulpQg3mObnauLCOlRxsWQ+uZdzhPB5+J7oCFCadfLNSKG8lsVTcAMNyf/cnkBk9oJS6p6MvWIxqYm8aE/EFKim/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDznJls6y+OH9RejztqsUXyqBirABiGzYnkIIIULAs4=;
 b=F+fuwAuJtmSdEgigq6I6r1eRNAvrF0EGrvjRhiWBc8ewRmNpgtbmmgld5yyhph30+VqZkobuD/VmlG96466PMrwrBXJ90Yb+8TAK08grCQ3jINtbYg1Rsoab05XSti06E3F80kz6d0ZXy+zXoan+YAPtL+wwFQFspSL1NnTgXJuLEZOre0hzEMqqwAAcbaf7VpKBmU7DhiACBrTNxfNBRL6F5UgxYXVtcKMmLMG7yE/XWrtvLaeGb5aqO/j9iQntJwRWVrsSMxkjn6WYSdONr3BwtNXS6Sn2gwq6HKr1JIuqLmtJ6e/PlXrcNk4NLmgSIg40VgBoqs/ugHoIVe6tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDznJls6y+OH9RejztqsUXyqBirABiGzYnkIIIULAs4=;
 b=l+twqPJucq0cu6I/3imJEwwyMlujTHBYYT5dkY7oZlXlVI5tGaVh0dQJ0s3orZ9NPFVX4xISDC0XtdJKZXVvQpUZC/zOuibTSr//h5hKJ38fyjZiWTG+tWprq0QxjyouSiTKCRwpHEjDxutFvq+qBt4wny+/0rDutRIFT3XsoCkULM3e8AfQJFiHu092pMNjXENlYvdLy9iJlFXxDYN1ESb/16n0rsPYDAUFaF4MwxCkSamepXMSnvEh7300ioiO7dMT/ROWIQ7soPiJa2uMgaSGoGHXfxpyIIqQ6JONpJb3lOnHCCZbe/aY3NpKKi6wHSBslSjaD/Tq7SlTNY1BUQ==
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 20:28:37 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::bd) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.11 via Frontend Transport; Sun,
 3 May 2026 20:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:28:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:28:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:28:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:28:29 -0700
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
Subject: [PATCH net-next V3 7/7] net/mlx5: E-Switch, load reps via work queue after registration
Date: Sun, 3 May 2026 23:27:26 +0300
Message-ID: <20260503202726.266415-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: d831e16a-a445-4f14-6c7e-08dea9528e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	phxySKycFSPRfZPATtmkcNzecE18T9KAkgFI6qcwFeMZrGgE2y5RxK3tq5bqIShQQq4VgqqYFw2PwW6IPWZsPC9YCwmotwceoTGhcxm9wsvYPYJgwjvOw4K71nGRpVW5qaqpeD6QDElXB/kbm1Wz4X+zCkRxuocMBO9V5LxyaXPZesZNnAxinl7wv3soi6K/LKobRKsFPQG2RpvGSqxtyb1uzn1/a+WnmdZAN5GG01qHnq4xix02PLGwJv1IlefeEzI/qnUsNm/KoWwWiH3B6pVtfoLftVmFunrENs183uZAms7McI4wL6ioT5eWfugaQKscO5Ri80a3xclvRJ6PNYcnnQLtwrLi2jJ0zgmhTnnWpgQGBnvQV/RtUTtdkc2B91CxDjzOZ0WdieAa7UJYRs4sLYspL2k1sOwErRXU1eCFlu2G7ABGkxqZdR8Xbcg8jxHPhHX4buIEbQLKuGW34j1dSItTfn5dTx2uwvN8oIXiuy5+srz480d7CEMvAhqswu3NmliMS9z/ctp5RNQFP05c/07v8B5GR3TiV4xuWfeN1Aw+0y7WBvCix2p4xKfdaTElJIAaNfUXE0wpJNAdMjkG1vENvntiED/v274Cq7t2RxipQ5lU2eeCurwUExBt3iLs6pEwRhDi43AT+2alNoeNSghIG5r3ZHw327F9fyQ/MPpI4AIEBa5/h+/cj1eWp2y5U2Q7UlscftCBHnVx3pbETrpJWEQ2KwGFdW5qJLc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/LC0sn8dA9UNgkFdQ8JG3Hoc9nozmU2g9kRwrVxGR8dkJnk6ywLgWqth5maIYZfGzRVHnrxrLHx/SeKnTD70XTahvLyTTTGLBiEb/oijp1TT5u0AHa1bvRULdXSHlhNaOIP8Quk4Koe+eRibaJDpYmmuQRKHC7M6XqNTFPq2UPsl5v0mBTqMQzcTEFCzNAcyYWxo4qpnZlyU7fyhTk2MffvQPRKxuMCdghB2XqrebQ6+5dkjkmJMW/tpkz4mPzQbZCtTa6ohzL/GynotWa5SaEE9oWTf6dWEe0s0VlLMZBs/ZDOV4gsD1q5l1GSGrteM/dlBM8YCcRKmclGyhYJGoeTI4FBZ7NAMEztsqrnRbvB+oafw8WvJOHOshu1+HB698hEfBWK8Oh1+G6VMjIwvSICjbULxGG4KWdHE0BsiP6HPUMmV5HAjcdNSivyO1l1w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:28:37.6016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d831e16a-a445-4f14-6c7e-08dea9528e7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
X-Rspamd-Queue-Id: 375C34B752A
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
	TAGGED_FROM(0.00)[bounces-19890-lists,linux-rdma=lfdr.de];
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

mlx5_eswitch_register_vport_reps() only installs representor callbacks and
marks the rep type as registered. If the E-Switch is already in switchdev
mode, the newly registered rep type must then be loaded for already enabled
vports.

That load path needs to run under the devlink lock, which is not held by
the auxiliary driver registration context. Queue the reload to the E-Switch
workqueue, whose handler acquires the devlink lock, and load the relevant
representors from there.

Since representor registration runs from sleepable auxiliary-driver
context, queue the late reload with GFP_KERNEL. The functions-change
notifier path remains the GFP_ATOMIC user of mlx5_esw_add_work().

The unregister path is unchanged and still unloads representors
synchronously while tearing down the registered callbacks.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 8a7491e9f13d..dea5647de548 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4565,6 +4565,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
 	}
 }
 
+static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return;
+
+	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
+		return;
+
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (!vport)
+			continue;
+		if (!vport->enabled)
+			continue;
+		if (vport->vport == MLX5_VPORT_UPLINK)
+			continue;
+		if (!mlx5_eswitch_vport_has_rep(esw, vport->vport))
+			continue;
+
+		mlx5_esw_offloads_rep_load(esw, vport->vport);
+	}
+}
+
+static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+{
+	mlx5_esw_reps_block(esw);
+	mlx5_eswitch_reload_reps_blocked(esw);
+	mlx5_esw_reps_unblock(esw);
+}
+
 static void
 mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
 					const struct mlx5_eswitch_rep_ops *ops,
@@ -4576,6 +4608,8 @@ mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
 		mlx5_esw_reps_block(esw);
 	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
 	mlx5_esw_reps_unblock(esw);
+
+	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps, GFP_KERNEL);
 }
 
 void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
-- 
2.44.0


