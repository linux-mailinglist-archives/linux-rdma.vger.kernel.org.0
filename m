Return-Path: <linux-rdma+bounces-19621-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBtxAn1B8Gn1QgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19621-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:11:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303F47D774
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B1A8302C363
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4B2EAB6F;
	Tue, 28 Apr 2026 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SmTSRu5k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CC2DF6F4;
	Tue, 28 Apr 2026 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353075; cv=fail; b=A/1j0XjUXhj9YV2kyXEZ/P3K1dq2lrICSIvmHr0+VdeSK/HiC5rtVzP9ruGu1UoMd53TeqCnTp/oDm/O+yTM7MndnqwKtbOFN9VrNIWv5htT5kYlAQgCZTHkDMwojCVzhVlLtoU3KqQgxR0y1fMZ86X1aXNOJ31hIsZ5K+xr+5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353075; c=relaxed/simple;
	bh=FeBegYHgxC6g+9IP5tP2bIci31VFVeMh73B4SPPxolI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1537CC/XXFWLdWdbnSftjaQXimPuPKMxIlCTjp5uxgMukJ6XJnWD2/NfjECCkLjOVHKm7WQ/fIrwuEGdsxTKqGMjRq98537tAzAIPsCGnnDQsI8RhdfpMmbeJfcFiv41D+K+aCbUJA9NKEwBey4UJTjadcLVHHu79pI1vBdzuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SmTSRu5k; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osxqSr/Th2LMcUdQRYEHJ+2+QeGA1FT/S6Z2oxkbF2RNHtG6dE2vwfi1ms3qEbS2Yd68VBefAtR5e/hl+Y9CyducHV6zYPqQAK6DzJTv5uDgmleg5HL/DHJoqB4yokJ/LUmaA3LrZF3Athb431dt4D9tERuUpFuK7WYOtUMv0uwJoORbYskX1BKEcsdw0i5bZQ2ocCDrSjfUsinG4iEj6/TZOxVQmIWA6O/uC7S3XEox+05Ph1WMEtnkEpkroIEP0fWJ7iId0rSfIHSQIEAnk9omnrYuO553+/tm3RBRlugonV4UkB0NiR0hfv6gx8acXL4ZzYFNtjpZefvFn06RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIVcmXoATeaL70Wf+2FAe7lz8UQh7lDareZCkJH7G1c=;
 b=IW/07HHNA146FDS0TTlxLd2SPO+LbYklhc3Eid0iMoLgO1zUAXul2vCuSA0fNZmfBMqySFYI4XC49X33mpKhB3mVH4iZEDZi+h7QjD5PFVYhUpRKTIJeiiduuOpFd3N7QsXcyODWAWBUKbrO7brWlwErGrNHamqpU6cCeTHMZt/WW90k9LVMYyfdRSHZXrQG7004sSSIq+lEJqgyJba6y4GyqJ1RoajpznWbX8lpz8RLOIqEwNSxwgzv3QykyJf73eqhwKn573pjhTD68sGGzHfKNOwgedFY6IDdKf1VUy8MMX75+svKoi6UkV/flGQd9zssZL1in7cwWAN90/mC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVcmXoATeaL70Wf+2FAe7lz8UQh7lDareZCkJH7G1c=;
 b=SmTSRu5kdrjF2Kf7r5rNWG7GMxUuDxabjhYa1vj2xf41m5THlxhBRE2KvHEO850XwzSGN6jmnFPh2z+ao2viA1at6f8xGdEfT1dsErba4sVV1A9Zhwd6Jr5Y8/UoqIeFhtfqeG2Z9UAlJUVyMboDNA2HUKpHjH94Zr7SfwvFiPGlpd0wXSdND0lHSV7PM/cvnyghBf+Rfx3U2EqjHYbJElzbAXOis5V5UP6Yz6ekSAkKTQwU1fPYTzZcjRKQPOD9IEcD/6BtPxnHWRItaRuWrzwUDfv5U2FtGSZpcEZBLSanUFtKJRRaVTZetr+MQqceiwG/NiCNdpRMa0bOSDkOPA==
Received: from BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 05:11:08 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::bc) by BL1PR13CA0347.outlook.office365.com
 (2603:10b6:208:2c6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:11:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:10:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 22:10:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 22:10:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next V2 1/3] net/mlx5: E-Switch, move work queue generation counter
Date: Tue, 28 Apr 2026 08:10:15 +0300
Message-ID: <20260428051018.219093-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcb95e8-361c-4c49-9aad-08dea4e48eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HqTm0XZpE/FS3bzDLLObHZOZPSerxiHGgPw/JIUvIdrAt+w06y1/inIgW+2R6pNNBCnT4Lyun0Y9lNHI9lRJScGL/gBjYopW41H3daCbuoxJfAqZmujK1ho4ztC2DvsRoMuUn1fz6mYtDhqmE1P4EOzCTUdWUTjf8H1mqumzhOAUCDJiDlHeG6gwosD+wLeS8yv13davCOyZBa+6mvpzkLxhkvr5u4In4lw/CfL6MmqtI3nDez2XetoxdWztLtQFnLg544eZSle2T+xCpmq5FWtjRjOXXC6t3gHfe0bp8vBnqZeHgjHaJ3oitejUOrRV/lFcxS7lg8QeC7KYLV9ZrJi7mNdol+iGpt8Mm8L9qqgOCKQLKarFoYhjsgp9hVYz+QdutIStFvNrWXIZ/ARTFIEXP2NsvgdoZjuQKL+x2ECLysS3itKt1tHlW3QLrdrDyLdjz2fU+gC33J0jzvbwCGx5pxPexMr7HfHHADO2M2cCa5ApoHuIzd1H2srVeYAzkXb1jD7aef0BVxiNImjbxfceYQsQ3wy3XxL79VA3fFjpLl51mATAKRAv4oc6EYLZBnt8AlCKZulnnMhXCxgMfUzKSDMQoOQrMHMTLjlsZAvuWD+SloQSpWKQhRN/TYCWgfkIpMt6clhMsrZ2dbXB/+YAi+5H2G5ZRLA8Rgg3yQxUq1XptVOV9urRJAjvWD0YyhOoyeMGsyl+8RKlikpHNq4FeTjg9gHxOXVDOpPbW5OaMWVQmOYUO+jpaNhGlgU7rHL5JKqjtdyTa7eqcVT0pg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7V+6LGJKBUyYcx8i9wO5lawLQUvArasTjYLDFJouw6XmieCLO5N0b4P/lDte0nHodt8hLhlREZMWmVmNKRD3nMrshvOyf0zO4PGJDuOfcJDlne7kKPdhk1n/w/wN6r/kr/fPjt4VYfgPemA+OqAyLHwRajCRrtZXGoXA+3UPLRzdcS5178+//LEcAOfWOgMl43R2YQMaXLtYJOZrHBKVKqXrYVtvXhA+tFHs/WqKsZU/DzI9EPW1/ZMRphLAVhX27iPDlMMG00dRYGAm9CM49mOQXF4H5DlRjs/00oUu8nULE1Lnp3ALwDHnpriRwGKzV5cEwIqwOLome6n0QcRRvqJ7c/vGx7Re2AJOD2is+/ewG5k8S/5XeImRvjvX4FJ+c0ZlB2jgLKE+nVBtp7rfZwUXFiaJPuvmkVQsmh5y+P2Uy3D6aknwz3k442MPlHBD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:11:08.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcb95e8-361c-4c49-9aad-08dea4e48eb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
X-Rspamd-Queue-Id: 7303F47D774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19621-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

The generation counter in mlx5_esw_functions is used to detect stale
work items on the E-Switch work queue. Move it from mlx5_esw_functions
to the top-level mlx5_eswitch struct so it can guard all work types,
not just function-change events.

This is a mechanical refactor: no behavioral change.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..1986d4d0e886 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1075,7 +1075,7 @@ static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
 	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
-		atomic_inc(&esw->esw_funcs.generation);
+		atomic_inc(&esw->generation);
 	}
 }
 
@@ -2072,6 +2072,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	mutex_init(&esw->state_lock);
 	init_rwsem(&esw->mode_lock);
 	refcount_set(&esw->qos.refcnt, 0);
+	atomic_set(&esw->generation, 0);
 
 	esw->enabled_vports = 0;
 	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 5128f5020dae..0c3d2bdebf8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -340,7 +340,6 @@ struct mlx5_host_work {
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
-	atomic_t		generation;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
@@ -410,6 +409,7 @@ struct mlx5_eswitch {
 	struct mlx5_devcom_comp_dev *devcom;
 	u16 enabled_ipsec_vf_count;
 	bool eswitch_operation_in_progress;
+	atomic_t generation;
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a078d06f4567..b2e7294d3a5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3667,7 +3667,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
 	devl_lock(devlink);
 
 	/* Stale work from one or more mode changes ago. Bail out. */
-	if (work_gen != atomic_read(&esw->esw_funcs.generation))
+	if (work_gen != atomic_read(&esw->generation))
 		goto unlock;
 
 	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
@@ -3729,7 +3729,7 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type
 	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
 
 	host_work->esw = esw;
-	host_work->work_gen = atomic_read(&esw_funcs->generation);
+	host_work->work_gen = atomic_read(&esw->generation);
 
 	INIT_WORK(&host_work->work, esw_functions_changed_event_handler);
 	queue_work(esw->work_queue, &host_work->work);
-- 
2.44.0


