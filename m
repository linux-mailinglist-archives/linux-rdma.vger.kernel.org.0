Return-Path: <linux-rdma+bounces-18174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PyTEAjTt2n0VgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:53:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3962976F1
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 740943048D86
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E183914FA;
	Mon, 16 Mar 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9CfSpM9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1853909B4;
	Mon, 16 Mar 2026 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654418; cv=fail; b=sIgkjL2aCBAYMwyQyAijbAr50Fx8DBGw0KVsaPF3X5PpxlaTAi6kLeh45+cWEyINIer1RRGbzyDonEEXMcnnVVvAElo2tDMViK/r53+pIzNTLFVdcJMeukscrjrxJRYhyxsFFWf2+395IGxvs/tW/yd3vRJgUdBdqMvbofv6Md4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654418; c=relaxed/simple;
	bh=1zCQgsGjhDs4YBWlRkQ91yKbVMdBs+tL7zQCl+lb+Ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiDjEHNLifSSp5W0KyY9mI4hL3/Q2Qi0/Ah8YeZ+d9JZWcCi2xvpZDyWedcSSJYfmxKwOzTbKBEPBA9aTzbIawscZnrWFEzR2aJ63dY6n8P2sEeF2hSpei7IRajyWoK5UcGKszaYlPiNo9GPP1xw90iS2Ysxvfc9hBXwa9yzJcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9CfSpM9; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2uiAaMTaEE/31TJ17poRUTooKraFaupvr9jwo1NezVGDzCMJMEcsh28PW6jEQw6dZo+tUnqWRFnd+2LB4Zmb4NJDO6ep6Ny/FOdmKOQGIcqyi4M6ccRC2pcT7Oxu3gX1ZEDglc4jNP26WRZoq2aY+8mauKwRP9jo2mHPm1gVd+D+njhqM2X9usd3cQFeHVIOuyqiVfm+kM3z36NEa4WbskDalUNQoaN03cuUxEOfRG/XwXHfp4jGz7pC2cRvI/2fLQTm+4Se7755+Cn6UZCHWA8axAP/Ew+vcpR1LtlogWj0DMX9Pxv5V4OLtX3BoYychHDdcNreaB2lp5LrIRAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuQkD70iI4O8xKaXQv67WurzAY5iruq11XeWKacL5ts=;
 b=YwXBka52rAYdnE71fZZ5ZMZw6o0XBvqKu2tq26r32eanbZafWGmDpfuEn8jDZ6kQet6Ui84NRFS5BYVsrWnulZqElgTwd+D2bfZQDO3XVJGayuOBdMaSkwsLIsPkQJQIruMZBbzrnsoogF85ACcUQY7p/7qS4bcl4x3sIg3gxeDi8t3tRXpHgjU6hNZIAKmoS/3yQq4Ls4e9mchplCa2NbKyz1fhdovMWPojrMN4mY4Tia02WtacLLCliisr1fqmMWNO3tgvYOYXx/7m/RS9tan2Uls6XqtXS2vIdO0HKgmn9ky2ZZYBAVNk0JjnTdEamzMkoMAN2n0MV1hcs0ZZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuQkD70iI4O8xKaXQv67WurzAY5iruq11XeWKacL5ts=;
 b=K9CfSpM9VoJKzsih9nnUjQVoRYjUKOTwS59jtes/WyA2SXIX4uti52YXkafU3p9cJQrbv40BVcUT5rEIZz1eoLkplnemHA12jCCq+cr5VFV73COx/WFvXomgHPXh8rZNEh/w5O/Slg8IvnC8Am3iBh2U3oNM3BDbEz4vMkSZ6HuwZxkgYWhAabsgV/yuoTtryOjzLz96IK08auZ3NEjwDLygRnxgOY8ae6HkgwDvtt4DALp8dgKHMwHUxxYPYtYWa0IxIMpgY7Ln8Z2098JpDiqdXAzofAL/jHanPz5bFsceJyM3kGgXZJFWBZnD0sGPiswcduHZXwai1l0Y9La1mA==
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 09:46:53 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::8) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 09:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Mon, 16 Mar 2026 09:46:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 02:46:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 02:46:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 02:46:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: Prevent concurrent access to IPSec ASO context
Date: Mon, 16 Mar 2026 11:46:02 +0200
Message-ID: <20260316094603.6999-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260316094603.6999-1-tariqt@nvidia.com>
References: <20260316094603.6999-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7869108c-9001-4b80-90a1-08de8340f4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	awBM3ljdfegmskZWzjGV+aIUZx+GkeFnquzA3Unz21KFif2tNsHCpaclsXbCi2dEuT8BppoqIsuPgzKXfVYiDAJTPCGC1q+3u5NaTTtIMiMBUXnI1YIwsph74suJJKRPTYR+a828MnBt5pXQuvOF9a7Nk/eiFkJ5lluvtqpgIVh2MlzK7vzb/jjk6ElPz9ePMq32Gxr3VL7HvEGyjpgJas7MNvFMEPma9353wwGIg9uEvQOFIelECQJ1uW1bqFQWQKVk8fWIAR45QF3cmBJ229ICke/Lhff5mQ/9bB1yXl/W6rR8RrkidBLyMkN7Tx/lqJgh8/mL3/0GKN6xS5k/eFbr8WSbwfV4LeIt3KZEp6O5zAij+W6T1De2+q4bWbRZCOauCdeTFL+0EF1fJfBvsHJVB6f+hG6UKxEoJ+ZHBQk+Jnd8tY3BhErCItJUZoHlU70JB1ROSTsdk1ouZyvUDU42kkPq1qsVLEXyeV/Zi7QH/mpAqX0TxaJsWsJkQL2CabS48WB4JeAiX7fF51mD8CJOY6vVQrTrsmt/K9Dqt5CJGC95PSEPvEily13tY5AB5Qg/hiRD6nesqcGlRbKYyjRlXh4mL3/wWExEFNF0NdHAP8bS4bKiTq252mt8IyIv+atyL45ivFbNOLfJojKpjztFm2zfthSsuNSX/eGyYOM2Bz2zDevuFmLaCWNNRZi01OKFaGI+qcMqLv/xvveNsFOO57oTKpEw3z4tlDVUUxSGSQa8EIMWvGJw/jkECX36+77M5wDCjQsI3TRioG9WnA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J7xR12jxNXbjRmX4AWEg1HFyyr2ajkAncQ6EPxzTUX50g6VS05P0WRCrKBn0fCRIxMTs6dS993Ky51la4uIkIMbVx580nLgA1aH1Uq9ClKTXawiOROoaj2QXdvX+X748hhiMWEWgHVKyUpYbATIggI1+KOLe0Q7SyPJj85dE1JRZiAMu9w5kWbmwur953BRaTm6ZrkDojR3WxsdqNE+TDhJ+Gij6Q60mxP4VkUxwU+nZRUvOzWi2HEL7FDpHxFuIqdrEl5iobeZvnsV42+Yzg+Zspa2ivyvmRorf+NouBGKBqDf3kexYEyQUwG9Eb6zsmldXNMYlK/hXmA04yPjO7fhEw8n22rhum7qwFmey3JDdCOYnZMvgsGOiku08K1qYEDd0BZUYf9YjFwtco5oL0xDQ3OFEUVtmGpim+mvFh2WElpYb3DfO0DinU5xOiv7T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:46:53.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7869108c-9001-4b80-90a1-08de8340f4af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18174-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DE3962976F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianbo Liu <jianbol@nvidia.com>

The query or updating IPSec offload object is through Access ASO WQE.
The driver uses a single mlx5e_ipsec_aso struct for each PF, which
contains a shared DMA-mapped context for all ASO operations.

A race condition exists because the ASO spinlock is released before
the hardware has finished processing WQE. If a second operation is
initiated immediately after, it overwrites the shared context in the
DMA area.

When the first operation's completion is processed later, it reads
this corrupted context, leading to unexpected behavior and incorrect
results.

This commit fixes the race by introducing a private context within
each IPSec offload object. The shared ASO context is now copied to
this private context while the ASO spinlock is held. Subsequent
processing uses this saved, per-object context, ensuring its integrity
is maintained.

Fixes: 1ed78fc03307 ("net/mlx5e: Update IPsec soft and hard limits")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h         |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c | 17 ++++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index f8eaaf37963b..abcbd38db9db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -287,6 +287,7 @@ struct mlx5e_ipsec_sa_entry {
 	struct mlx5e_ipsec_dwork *dwork;
 	struct mlx5e_ipsec_limits limits;
 	u32 rx_mapped_id;
+	u8 ctx[MLX5_ST_SZ_BYTES(ipsec_aso)];
 };
 
 struct mlx5_accel_pol_xfrm_attrs {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 33344e00719b..71222f7247f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -370,20 +370,18 @@ static void mlx5e_ipsec_aso_update_soft(struct mlx5e_ipsec_sa_entry *sa_entry,
 static void mlx5e_ipsec_handle_limits(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
 	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
-	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
-	struct mlx5e_ipsec_aso *aso = ipsec->aso;
 	bool soft_arm, hard_arm;
 	u64 hard_cnt;
 
 	lockdep_assert_held(&sa_entry->x->lock);
 
-	soft_arm = !MLX5_GET(ipsec_aso, aso->ctx, soft_lft_arm);
-	hard_arm = !MLX5_GET(ipsec_aso, aso->ctx, hard_lft_arm);
+	soft_arm = !MLX5_GET(ipsec_aso, sa_entry->ctx, soft_lft_arm);
+	hard_arm = !MLX5_GET(ipsec_aso, sa_entry->ctx, hard_lft_arm);
 	if (!soft_arm && !hard_arm)
 		/* It is not lifetime event */
 		return;
 
-	hard_cnt = MLX5_GET(ipsec_aso, aso->ctx, remove_flow_pkt_cnt);
+	hard_cnt = MLX5_GET(ipsec_aso, sa_entry->ctx, remove_flow_pkt_cnt);
 	if (!hard_cnt || hard_arm) {
 		/* It is possible to see packet counter equal to zero without
 		 * hard limit event armed. Such situation can be if packet
@@ -454,10 +452,8 @@ static void mlx5e_ipsec_handle_event(struct work_struct *_work)
 		container_of(_work, struct mlx5e_ipsec_work, work);
 	struct mlx5e_ipsec_sa_entry *sa_entry = work->data;
 	struct mlx5_accel_esp_xfrm_attrs *attrs;
-	struct mlx5e_ipsec_aso *aso;
 	int ret;
 
-	aso = sa_entry->ipsec->aso;
 	attrs = &sa_entry->attrs;
 
 	spin_lock_bh(&sa_entry->x->lock);
@@ -466,8 +462,9 @@ static void mlx5e_ipsec_handle_event(struct work_struct *_work)
 		goto unlock;
 
 	if (attrs->replay_esn.trigger &&
-	    !MLX5_GET(ipsec_aso, aso->ctx, esn_event_arm)) {
-		u32 mode_param = MLX5_GET(ipsec_aso, aso->ctx, mode_parameter);
+	    !MLX5_GET(ipsec_aso, sa_entry->ctx, esn_event_arm)) {
+		u32 mode_param = MLX5_GET(ipsec_aso, sa_entry->ctx,
+					  mode_parameter);
 
 		mlx5e_ipsec_update_esn_state(sa_entry, mode_param);
 	}
@@ -629,6 +626,8 @@ int mlx5e_ipsec_aso_query(struct mlx5e_ipsec_sa_entry *sa_entry,
 			/* We are in atomic context */
 			udelay(10);
 	} while (ret && time_is_after_jiffies(expires));
+	if (!ret)
+		memcpy(sa_entry->ctx, aso->ctx, MLX5_ST_SZ_BYTES(ipsec_aso));
 	spin_unlock_bh(&aso->lock);
 	return ret;
 }
-- 
2.44.0


