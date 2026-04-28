Return-Path: <linux-rdma+bounces-19622-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KWgJItB8Gn1QgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19622-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:11:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8E47D785
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E57C9300C6E2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8C2E54BD;
	Tue, 28 Apr 2026 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tRCUvUUp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589772E7635;
	Tue, 28 Apr 2026 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353081; cv=fail; b=RRKk5I+Z6ptUKsvFddyIijmPpacmTE/cRZWVIcwlmadw+8OXLXx4AuL6eN7YQM/MhruuZBYZ8D1EVCO1+c+N4J1Nl4I6Ktt4x8Vsoz3leKz8Wv/HyGi2OzutOfoq7Fu3cOJhez76kIcbiXT4THYv+Bbg2njuY5ggAk4pfsQmkdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353081; c=relaxed/simple;
	bh=afB0EoVmEflg+bv6JdS0Uwf2WkTTmsz+JxDQyFb/nC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSxyGGoXRRqktPxyT/2qyJJGXOguGJ4rPKVPnACnfwR4Dm00JG36XDqhMK/e+0L1rzQxUW2T1P5LNxSRybC1QFtGTk2zbBvbrU7X5cuOnuAbm1ZfTIOmhuRE3lGDUl8pgP58P8KJESOF9qxxHkngtPgw7D6DOW1fJsICWsLbSco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tRCUvUUp; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQOPD/1VPtAmTRHvyCT4FcdywCC6whUaihVj/OO3gCdbwe3TBP50my/LfXRMfd+JoPnERUXSXatwa592u0guDclEchCQLqspjUegrZw+Hj03Q6hiVhqDlP11aNZ9Zo5RYtYFQeDuQFU9fosqP81ktJRJj4pBP6w5cklA1lNFEhzZ9C9Gi53Rmr3uzHU+qBsmn7WcEIpyW9V6ylGvS+L8PLMeblM2I9pjUs8K0pmKFe2MzprhtSCsUg9npqLskTO7bWgl8AJpxwzMKJNt8XCkVwJzSJLblUSQ74AUqW1HA06HpBopnCPOmR4Tijt/gMZpKiDGS3eFzl7ZdhJxnQDdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yACv4juZoEhMVPGdxDDLyBT4o3QxpeINri0uh41YJs=;
 b=qTCXORIsUuuoqLKorGUJyyJ/tRdDpjNV1mqVNGrEjy6dLOn8CwtjBpyILlcxUqGIwGRnk+NThBYZREiqHpxtd98JWbMmJkD0AgLmpfFzU33ejtxdMuvYnslBAqb37QkrIscsKZ3xRffoaOu2g+3P/+KnAV1GysI6h0JKhd5B8P+Z/+MSt4OTmbmiwgBRPWPBlekSgt+fOwbcJ2Gf/V4bAkdovguxZbRF7s3SQ2AWmhBh3EThnS4Eoza5UBY5YG/bz0grgDxCESP7ZLm4eyG2EJPxlHcAqyO523lmN143xQU/Chg+WrYbrgNimG/0vbsaENGap4dDyvM/9Oyz2q5+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yACv4juZoEhMVPGdxDDLyBT4o3QxpeINri0uh41YJs=;
 b=tRCUvUUpJNTjFfpOCwVkZmDpHyHPfspDfoXNhAdQqpWAujDo6KqZdBDHb206+m3Kvs9t4oj6vrsspKPeLFNai01Sl/vpkNTM+6Vs0PRZS/z7WE2y1olKZpIKcP3mnwPJHG2NSrNbEhm7fdqIfo2tfspkhcnzAjBllmX/Kl8ay0WFsrPdeO+UKmCvuJvMmD03Rw/y679r54IbBGfhENL66z5Gh/GAcX3f3bNiRD6zh+sjAxDF7PEArFIALaauTPAnXbeOswuGZjJmtGKNTU7yvihdsaHvEqDW/m28ikAoc1XVeC8rBfys3qHWoMxWVBeP6ei49wnFjWLklyOgLSVsSw==
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 05:11:14 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::90) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Tue, 28 Apr 2026 05:11:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:11:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 22:10:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 22:10:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next V2 3/3] net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq
Date: Tue, 28 Apr 2026 08:10:17 +0300
Message-ID: <20260428051018.219093-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428051018.219093-1-tariqt@nvidia.com>
References: <20260428051018.219093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ad31f3-5fb6-4159-2838-08dea4e491a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DfSJOelFy113I3h8CHDHyV4hXWf4ikG59SRdabYNXKicSEVlG954K3EMEXbkEgw3ykuOFRSJ55xGUXzuvACcuaTsWhhlhXqCe0zQBd9bop3LJJlWZAmgThRhbBXEzfxvjJdk30EmR8qBulCrmx1tGsBddQLbApKpEC+2iX68m1v8W4T99CJ5atCUxKZpv2bMLr93M3WI4sEm1lr+kib4cV5pPiOv3RaB56bwo5k87Llj2KTSU+Rn0Xg5somCsjI5uM64l15VxvkwH2/Rcb0HHu1dzr0PZljdlJEq+tbHVV1/PEMTjHMihtQgXe5JwqOwzrgUx6lC0QJnDuhVx7713g40ukbs3v3WVS49rB8JGWiM1Ax2T+9hS+eAmn6eaVEEAzJmEeeEamTWnwwf9ZXJ4iq6+AYMkzEXpGPqc8XJRZudwnHPgW4D89pBYEe0P6fiQmnbM+lefS2v/6lYeS9CkCTeOZn3Q3H1oyPrEUjuTI4gnT/IuPAACD+M509ZI+j7stoLnupzoiIICBWhNwZjTXArh0LfNjKxWmknkoGBCNTWU1rW8LF86yDfo1M6t+esPZtrkmDTQ6WJV1R+QDHdRKFNIFwX2l8KCk5zY4UZ0DqJu6OqZYL45ZIksSt1CZMfvSgem5WQ5o2kXBtb+CJIVVqkPfeRMSUBjQG4vKIjks0au7fNsBouwhhBAj0dP4XqL/5cYEwDy8p++Lcc16zZzxoLxSO5Nkc6tUKwS6Y8LobK0kygYHRdGpwxvsOtFZx++65Kmf+UfCUnTA0BKklQpg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H4NdXpZB0IwowdEovVZhTsHFAH+8aYlDhEn/G2MuwnG1XVAzTFb48MiD4Lr0ytXeA4cmeKaSmM3ISG9aKSCX9XgPfBwn+mpYRcBBo+Eea3mc1WG5CmnSjv6g5vIiCn0Fh6ob4w1wBOQVnj4PXsI3Cbj7Pse+hb/bWnP4a8Meq+VIn34M6D1cyMk4tMDUPhsJ2v+s/IJZ/HAYgmKCPFd+UF2glEOpkzeUqkkwnYQTXRj84bOPDtg372RmJWtMGuUNnmUL3Xfgb2+ZbHJOPeCgY9zO0z+7KlSq1VWthFqzF/FKA8lBdrIG5suD4Qhi1mLOZph3hvbe9NywBF/84xLuphjVIHgiANwocDugsbLMToZfexUQeNSVvf1uZ9K9Ir3EI5WIFAspxV0D4gqd6xW1eVz6qt9r22tSqf8H1fAMYdRaMoiKKWM8muxiV5QR82sH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:11:13.4304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ad31f3-5fb6-4159-2838-08dea4e491a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
X-Rspamd-Queue-Id: A4C8E47D785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19622-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

mlx5_eswitch_cleanup() calls destroy_workqueue() while holding the
devlink lock through mlx5_uninit_one(). E-Switch workqueue workers also
need the devlink lock, but previously took it before checking whether
their work item was stale. This can deadlock when cleanup waits for a
worker that is blocked on the same devlink lock.

Mode changes have the same ordering hazard: the mode-change path holds
devlink lock while tearing down the current mode, and old work may still
be pending on the E-Switch workqueue.

Fix this by making esw_wq_handler() check the generation counter before
attempting to take devlink lock. The worker uses devl_trylock(); if the
lock is busy and the work is still current, it sleeps on an E-Switch wait
queue with a short timeout. Invalidation increments the generation
counter and wakes the wait queue, so stale workers exit without spinning
or blocking cleanup.

Invalidate work at the earliest safe operation boundary. Cleanup
invalidates before destroy_workqueue(), and QoS cleanup runs after the
workqueue is destroyed. Mode teardown unregisters the work-producing
notifiers first, then invalidates the queue before tearing down
FDB/QoS/rate-node state. This prevents new notifier work from capturing
the new generation while still making old work stale before expensive
teardown starts.

mlx5_devlink_eswitch_mode_set() now relies on
mlx5_eswitch_disable_locked() for the mode-change invalidation instead
of incrementing the generation after disable. mlx5_eswitch_disable()
gets the same coverage. SR-IOV enable/disable paths invalidate before VF
state changes so work against the old VF count or mode is discarded.

Remove the conditional generation increment in
mlx5_eswitch_event_handler_unregister(); mlx5_eswitch_disable_locked()
now handles it unconditionally after the relevant notifiers are
unregistered.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 19 +++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 21 +++++++++++++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 1986d4d0e886..8ec52498be3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1070,13 +1070,17 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 	}
 }
 
+static void mlx5_eswitch_invalidate_wq(struct mlx5_eswitch *esw)
+{
+	atomic_inc(&esw->generation);
+	wake_up_all(&esw->work_queue_wait);
+}
+
 static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
-	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
+	    mlx5_eswitch_is_funcs_handler(esw->dev))
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
-		atomic_inc(&esw->generation);
-	}
 }
 
 static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
@@ -1701,6 +1705,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 	if (toggle_lag)
 		mlx5_lag_disable_change(esw->dev);
 
+	mlx5_eswitch_invalidate_wq(esw);
+
 	if (!mlx5_esw_is_fdb_created(esw)) {
 		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
 	} else {
@@ -1746,6 +1752,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
 
+	mlx5_eswitch_invalidate_wq(esw);
+
 	if (!mlx5_core_is_ecpf(esw->dev)) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
 		if (clear_vf)
@@ -1785,6 +1793,7 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 
 	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
 	mlx5_eswitch_event_handler_unregister(esw);
+	mlx5_eswitch_invalidate_wq(esw);
 
 	esw_info(esw->dev, "Disable: mode(%s), nvfs(%d), necvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
@@ -2072,6 +2081,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	mutex_init(&esw->state_lock);
 	init_rwsem(&esw->mode_lock);
 	refcount_set(&esw->qos.refcnt, 0);
+	init_waitqueue_head(&esw->work_queue_wait);
 	atomic_set(&esw->generation, 0);
 
 	esw->enabled_vports = 0;
@@ -2110,8 +2120,9 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	mlx5_esw_qos_cleanup(esw);
+	mlx5_eswitch_invalidate_wq(esw);
 	destroy_workqueue(esw->work_queue);
+	mlx5_esw_qos_cleanup(esw);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
 	WARN_ON(!xa_empty(&esw->offloads.vhca_map));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e3ab8a30c174..8f4c47975c58 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -36,6 +36,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_link.h>
 #include <linux/atomic.h>
+#include <linux/wait.h>
 #include <linux/xarray.h>
 #include <net/devlink.h>
 #include <linux/mlx5/device.h>
@@ -385,6 +386,7 @@ struct mlx5_eswitch {
 	 */
 	struct rw_semaphore mode_lock;
 	atomic64_t user_count;
+	wait_queue_head_t work_queue_wait;
 
 	/* Protected with the E-Switch qos domain lock. */
 	struct {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 23af5a12dc07..9e2ae217c224 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3694,21 +3694,38 @@ static void esw_wq_handler(struct work_struct *work)
 	struct mlx5_host_work *host_work;
 	struct mlx5_eswitch *esw;
 	struct devlink *devlink;
+	int work_gen;
 
 	host_work = container_of(work, struct mlx5_host_work, work);
 	esw = host_work->esw;
+	work_gen = host_work->work_gen;
 	devlink = priv_to_devlink(esw->dev);
 
-	devl_lock(devlink);
+	/* Do not block on devlink lock until stale work is filtered out.
+	 * Teardown can invalidate the generation and then wait for this
+	 * workqueue while holding devlink lock.
+	 */
+	for (;;) {
+		if (work_gen != atomic_read(&esw->generation))
+			goto free;
+
+		if (devl_trylock(devlink))
+			break;
+
+		wait_event_timeout(esw->work_queue_wait,
+				   work_gen != atomic_read(&esw->generation),
+				   msecs_to_jiffies(60));
+	}
 
 	/* Stale work from one or more mode changes ago. Bail out. */
-	if (host_work->work_gen != atomic_read(&esw->generation))
+	if (work_gen != atomic_read(&esw->generation))
 		goto unlock;
 
 	host_work->func(esw);
 
 unlock:
 	devl_unlock(devlink);
+free:
 	kfree(host_work);
 }
 
-- 
2.44.0


