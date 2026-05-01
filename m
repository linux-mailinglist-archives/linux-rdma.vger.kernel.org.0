Return-Path: <linux-rdma+bounces-19833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEMcJMkv9GlM/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:44:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D04AA626
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D373304179E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CB2F83AE;
	Fri,  1 May 2026 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QhOK9IoG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A51218EB1;
	Fri,  1 May 2026 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610566; cv=fail; b=hTJzztMvx3r+ziTMdhJGvG0qVKOkVGpqWKOZqbAAJTM6R5iLjsAa+JqeNRsiehF5w3KtkVS86Qu7YgBGMoxlN5ZjNXBPqmTmhhYDxR6QR8VcrNX2ZNPzxj7f1oOn8Z4/2cLSlOswaoL0rZvJzznaT08FpxkXTm98PmXAHZr+8J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610566; c=relaxed/simple;
	bh=Om35aU01Q3mpzqMnST7rprSIW33NoFxDLnG0fCcXlUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROXdNvC1c1Wea8m4Lvp7xbTE+s4HjKtqamu9SxSjGotTz2vBkrfMrqW9mnrI5RLa0kbRs6PK90aMJp/BNn827nuhbIV0512n0KDsZjsPlyiQUQl7cLy0Q+Lxk1Qcn91+FAy/8i/0gUOO7oRIfZO5sThzgLi6B8eV1mRUr4GM6/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QhOK9IoG; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmrzNMu6CznwUnGYe6mzi2fbLXuh6buoxgKr/DPe7grxEERqoGVSTXRlgFF6XjjZDLw9p5kbq9fDM/DgYhhV4tzLm34VAbYWY2Iu/hLyQxrGU6hQf5f/6keIDYOoGTHEWsyl8McRXpk88mLEVsqT3ZXTX6ZXyjDgpReS2kfMAA8xsT3mkoa1f0BQvVgb0u5wjeNNayRSM3WTL0KVE64bDNnDC8KFtda5o6vJGAjhMv9yA8H5A+MfHwfhgTxPEv+J669v5/P8+5/r5YwOcsW/qA0kHw/HKVK9PV0c/CNMpBTnx/l1C7PrsB73HI4u48ftkBDPvikJs/4pNRlnL3deZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9GR7Tu7iF8rZ9R39TNUJ2FCY2aN6JcmSCKN7wmo+gA=;
 b=LfNmD6wNYVU0cbJfrKCFnfM7b/F8StDWDwy+oKEH3PBxypX8xq7dV0WSuH38bdgZ2WLNtGzLqLmE7+auD4f96mGzGVQv+2NESU8Rjg9EkjA+QXDdtC4Kc8+Qc6sYtg0YT+JVa2Kesrh/oGjuvwtOnH5Dl7oUAe46ZSeCcPOqj2OwVBDhfkNzKduQUfTc9x5Zyi2uBQV/qJFsPEbanhHvf3Q++yvopxz0j3DoBlYcbGk+3QHNncJwKxd3JXpvv43OqcNL05QP0QdvzIlVG5hsS1jL64UrWrYXy3hCXJQks48XwIyX1nDgcK+zJEF3T0sso0ao/IDqcBdVU799u1IAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9GR7Tu7iF8rZ9R39TNUJ2FCY2aN6JcmSCKN7wmo+gA=;
 b=QhOK9IoGjZBG/1rnbX2aeUHK7PDjLupHTeEfvqwnlgrwqNa/54tlvU9cQJ5zBfTAYXjC6Z8dFXkF2Xd1civLZH6hwSPi68azpxYNUGK2/0SQMv1bZOMaotDPnbVkhwd4GtcQJ4AQsPKvCqwjueX4cwYN/q04Z7JfFtmCgySIcS9eXXNujymsgkaRuTYOZCZX2RkcGBtkk2OKh4aptK2CURW90YFDVf+FXdJdibo7HEv7PXEso/WTLKLATrdjMY9aLM6uyBKpHLBdAOtZxN2n9JhczY1UMyDHEDoqHVH3T1LGKSqR4c0XEU9QR7/z44cvrj502ndTOUpXGXRxUC0xxQ==
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 04:42:34 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::9c) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Fri,
 1 May 2026 04:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:42:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:42:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: Add VHCA_ID page management mode support
Date: Fri, 1 May 2026 07:41:56 +0300
Message-ID: <20260501044156.260875-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501044156.260875-1-tariqt@nvidia.com>
References: <20260501044156.260875-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 4220014e-6b69-4fc1-54d8-08dea73c1037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18092099006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8xGasQUoQAfYBYXcIkStn+CdJdZQbV63ITeAi/SsXy7WWJkfBhLtQjdqQ89hUVzjBF3220SzmWYORnwdBsTzxNiBzLnz3ikVPL+Om1AgMZONwonONj6rqwRfiT4CvoAGojO6x+NZYEo+xpjgF95e5OfKdGZ18dfEK6kTfOmZp/yCv564cvZ67VOvsvd7QygCFBEkr91Yo9TAXmpGvO4PjT5bE1LJFD02b+Rkz4GZLrp0gTYoBPltnQLfbr65bmwzBY6AmYYydDndJA0wQURMrIbzLZwc93+75Wgusjd5tQDXpkAHTsSATM3vwdIvqzhKJn0JuybG6hhLb62tmkQ+tbDbtLKvV7HB8fj370YNclousV0NY2fKmMPnU6baeemDoHyt653qPb2Kicz2wbH8zVvMo4QBxlan0sKn7oPZvGK3ORFw8rvtlOHdPetxeIxhoYvYzxYJCaUE0sq78fEsewa2zyhyoPdg0IrW/ArQIZjaVL4FX7NnFQhHdouVtCbyyDCaFkT+kRncgJ1LzYWW0YD9OZG2hQ7YuRW9Krh4kG+aj8T2YVmboPvlIvF+yNR+g0s0IZk4DI+mxkALIC/lZdye9Sx0RQQG0gsDyHwNUn3ul7gBVR0Lzulfp98JXhVSVfYS9PBzbn76vFR7eSN6NLLScHGiGCjsuv54bU1LHBtFlv0EUBqR1IDwY3BrVvEi9NCEcQGhG0tB6os7aVrjDDLQL256Oj0lBaNVSxTVaRY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18092099006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vpb8FK7Am5MgE3RzHzSjYe8gcffouTNVEhdlE6eNuxkBhRjzSbIP+MvAOpAAU2Ft3NrAiinD071ihZz1f47PXFt5GHQbOEz/SQBWVMvj11P22Ouz+F8cyPNrsetQtyoQPTEqxGLB2MCOvJjO7oxsFE+lUZyo66WZHeDJ2laDrnHnpFysQaz2fkwF1g864SfwNmeLQVBqrhK5UwYT2pGUU2wc5sDoTIskYyx/SlmlfLwgX6FFP/kERFl28aJsqqnYG77CCM81McShnPH8vmFqgT58xWwp792JwvV0gQAx92B/HMl9/VWVyCFA7gfsvGf+pDxMI8yRcaNqLjzHX3stj7qVN1p+tyAFP/X61I/KH7UB5VD0FPdW4IE8NLskK/v9R2wHLwiKtjPTXSb5uiVFSmnSjnADss/etk3A3rxKc2221typF8cSe93NiCuyCGFW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:42:34.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4220014e-6b69-4fc1-54d8-08dea73c1037
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
X-Rspamd-Queue-Id: E08D04AA626
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19833-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Add support for VHCA_ID-based page management mode. When the device
firmware advertises the icm_mng_function_id_mode capability with
MLX5_ID_MODE_FUNCTION_VHCA_ID, page management operations between the
driver and firmware may use vhca_id instead of function_id as the
effective function identifier, and the ec_function field is ignored.

Update page management commands to conditionally set ec_function field
only in FUNC_ID mode. Boot page allocation always uses FUNC_ID mode
semantics for backward compatibility, as the capability bit is only
available after set_hca_cap(). If after set_hca_cap() VHCA_ID mode was
set, modify the tracking of the boot pages in page_root_xa to use
vhca_id too.

Add mlx5_esw_vhca_id_to_func_type() to resolve the function type via
vport lookup in VHCA_ID mode, enabling per-type debugfs counters.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  42 ++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   7 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   3 +
 .../ethernet/mellanox/mlx5/core/pagealloc.c   | 226 ++++++++++++++----
 include/linux/mlx5/driver.h                   |   7 +
 5 files changed, 235 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index e0eafcf0c52a..d3eaefc5c0e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -852,6 +852,48 @@ bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 	return true;
 }
 
+u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	struct mlx5_vport *vport;
+	unsigned long i;
+	u16 type;
+
+	if (vhca_id == MLX5_CAP_GEN(dev, vhca_id))
+		return MLX5_SELF;
+
+	if (!esw)
+		return MLX5_FUNC_TYPE_NONE;
+
+	mutex_lock(&esw->state_lock);
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (vport->vhca_id != vhca_id)
+			continue;
+
+		if (vport->vport == MLX5_VPORT_HOST_PF) {
+			type = MLX5_HOST_PF;
+			goto unlock;
+		}
+
+		if (xa_get_mark(&esw->vports, i, MLX5_ESW_VPT_SF)) {
+			type = MLX5_SF;
+			goto unlock;
+		}
+
+		if (xa_get_mark(&esw->vports, i, MLX5_ESW_VPT_VF)) {
+			type = MLX5_VF;
+			goto unlock;
+		}
+
+		type = MLX5_EC_VF;
+		goto unlock;
+	}
+	type = MLX5_FUNC_TYPE_NONE;
+unlock:
+	mutex_unlock(&esw->state_lock);
+	return type;
+}
+
 static int esw_vport_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	bool vst_mode_steering = esw_vst_mode_is_steering(esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 2fd601bd102f..5940b4cbfd77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -863,6 +863,7 @@ void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
 				  struct mlx5_vport *vport);
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
 bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id);
+u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id);
 
 void mlx5_esw_offloads_rep_remove(struct mlx5_eswitch *esw,
 				  const struct mlx5_vport *vport);
@@ -1034,6 +1035,12 @@ mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 	return false;
 }
 
+static inline u16
+mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
+{
+	return MLX5_FUNC_TYPE_NONE;
+}
+
 static inline void
 mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev) {}
 static inline struct mlx5_flow_handle *
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index a242053f3a58..52cf341ad6b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -597,6 +597,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 	if (MLX5_CAP_GEN_MAX(dev, release_all_pages))
 		MLX5_SET(cmd_hca_cap, set_hca_cap, release_all_pages, 1);
 
+	if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode))
+		MLX5_SET(cmd_hca_cap, set_hca_cap, icm_mng_function_id_mode, 1);
+
 	if (MLX5_CAP_GEN_MAX(dev, mkey_by_name))
 		MLX5_SET(cmd_hca_cap, set_hca_cap, mkey_by_name, 1);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 77ffa31cc505..7ebe88aa3b3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -38,6 +38,7 @@
 #include "mlx5_core.h"
 #include "lib/eq.h"
 #include "lib/tout.h"
+#include "eswitch.h"
 
 enum {
 	MLX5_PAGES_CANT_GIVE	= 0,
@@ -69,9 +70,24 @@ enum {
 	MLX5_NUM_4K_IN_PAGE		= PAGE_SIZE / MLX5_ADAPTER_PAGE_SIZE,
 };
 
-static u32 get_function(u16 func_id, bool ec_function)
+static bool mlx5_page_mgt_mode_is_vhca_id(const struct mlx5_core_dev *dev)
 {
-	return (u32)func_id | (ec_function << 16);
+	return dev->priv.page_mgt_mode == MLX5_PAGE_MGT_MODE_VHCA_ID;
+}
+
+static void mlx5_page_mgt_mode_set(struct mlx5_core_dev *dev,
+				   enum mlx5_page_mgt_mode mode)
+{
+	dev->priv.page_mgt_mode = mode;
+}
+
+static u32 get_function_key(struct mlx5_core_dev *dev, u16 func_vhca_id,
+			    bool ec_function)
+{
+	if (mlx5_page_mgt_mode_is_vhca_id(dev))
+		return (u32)func_vhca_id;
+
+	return (u32)func_vhca_id | (ec_function << 16);
 }
 
 static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_function)
@@ -89,12 +105,21 @@ static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_funct
 	return MLX5_SF;
 }
 
+static u16 func_vhca_id_to_type(struct mlx5_core_dev *dev, u16 func_vhca_id,
+				bool ec_function)
+{
+	if (mlx5_page_mgt_mode_is_vhca_id(dev))
+		return mlx5_esw_vhca_id_to_func_type(dev, func_vhca_id);
+
+	return func_id_to_type(dev, func_vhca_id, ec_function);
+}
+
 static u32 mlx5_get_ec_function(u32 function)
 {
 	return function >> 16;
 }
 
-static u32 mlx5_get_func_id(u32 function)
+static u32 mlx5_get_func_vhca_id(u32 function)
 {
 	return function & 0xffff;
 }
@@ -196,7 +221,7 @@ static struct fw_page *find_fw_page(struct mlx5_core_dev *dev, u64 addr,
 	return result;
 }
 
-static int mlx5_cmd_query_pages(struct mlx5_core_dev *dev, u16 *func_id,
+static int mlx5_cmd_query_pages(struct mlx5_core_dev *dev, u16 *func_vhca_id,
 				s32 *npages, int boot)
 {
 	u32 out[MLX5_ST_SZ_DW(query_pages_out)] = {};
@@ -207,14 +232,20 @@ static int mlx5_cmd_query_pages(struct mlx5_core_dev *dev, u16 *func_id,
 	MLX5_SET(query_pages_in, in, op_mod, boot ?
 		 MLX5_QUERY_PAGES_IN_OP_MOD_BOOT_PAGES :
 		 MLX5_QUERY_PAGES_IN_OP_MOD_INIT_PAGES);
-	MLX5_SET(query_pages_in, in, embedded_cpu_function, mlx5_core_is_ecpf(dev));
+
+	if (mlx5_page_mgt_mode_is_vhca_id(dev))
+		MLX5_SET(query_pages_in, in, function_id,
+			 MLX5_CAP_GEN(dev, vhca_id));
+	else
+		MLX5_SET(query_pages_in, in, embedded_cpu_function,
+			 mlx5_core_is_ecpf(dev));
 
 	err = mlx5_cmd_exec_inout(dev, query_pages, in, out);
 	if (err)
 		return err;
 
 	*npages = MLX5_GET(query_pages_out, out, num_pages);
-	*func_id = MLX5_GET(query_pages_out, out, function_id);
+	*func_vhca_id = MLX5_GET(query_pages_out, out, function_id);
 
 	return err;
 }
@@ -334,7 +365,7 @@ static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
 	return err;
 }
 
-static void page_notify_fail(struct mlx5_core_dev *dev, u16 func_id,
+static void page_notify_fail(struct mlx5_core_dev *dev, u16 func_vhca_id,
 			     bool ec_function)
 {
 	u32 in[MLX5_ST_SZ_DW(manage_pages_in)] = {};
@@ -342,19 +373,23 @@ static void page_notify_fail(struct mlx5_core_dev *dev, u16 func_id,
 
 	MLX5_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
 	MLX5_SET(manage_pages_in, in, op_mod, MLX5_PAGES_CANT_GIVE);
-	MLX5_SET(manage_pages_in, in, function_id, func_id);
-	MLX5_SET(manage_pages_in, in, embedded_cpu_function, ec_function);
+	MLX5_SET(manage_pages_in, in, function_id, func_vhca_id);
+
+	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
+		MLX5_SET(manage_pages_in, in, embedded_cpu_function,
+			 ec_function);
 
 	err = mlx5_cmd_exec_in(dev, manage_pages, in);
 	if (err)
-		mlx5_core_warn(dev, "page notify failed func_id(%d) err(%d)\n",
-			       func_id, err);
+		mlx5_core_warn(dev,
+			       "page notify failed func_vhca_id(%d) err(%d)\n",
+			       func_vhca_id, err);
 }
 
-static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
+static int give_pages(struct mlx5_core_dev *dev, u16 func_vhca_id, int npages,
 		      int event, bool ec_function)
 {
-	u32 function = get_function(func_id, ec_function);
+	u32 function = get_function_key(dev, func_vhca_id, ec_function);
 	u32 out[MLX5_ST_SZ_DW(manage_pages_out)] = {0};
 	int inlen = MLX5_ST_SZ_BYTES(manage_pages_in);
 	int notify_fail = event;
@@ -390,9 +425,12 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
 
 	MLX5_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
 	MLX5_SET(manage_pages_in, in, op_mod, MLX5_PAGES_GIVE);
-	MLX5_SET(manage_pages_in, in, function_id, func_id);
+	MLX5_SET(manage_pages_in, in, function_id, func_vhca_id);
 	MLX5_SET(manage_pages_in, in, input_num_entries, npages);
-	MLX5_SET(manage_pages_in, in, embedded_cpu_function, ec_function);
+
+	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
+		MLX5_SET(manage_pages_in, in, embedded_cpu_function,
+			 ec_function);
 
 	err = mlx5_cmd_do(dev, in, inlen, out, sizeof(out));
 	if (err == -EREMOTEIO) {
@@ -405,17 +443,20 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
 	}
 	err = mlx5_cmd_check(dev, err, in, out);
 	if (err) {
-		mlx5_core_warn(dev, "func_id 0x%x, npages %d, err %d\n",
-			       func_id, npages, err);
+		mlx5_core_warn(dev, "func_vhca_id 0x%x, npages %d, err %d\n",
+			       func_vhca_id, npages, err);
 		goto out_dropped;
 	}
 
-	func_type = func_id_to_type(dev, func_id, ec_function);
-	dev->priv.page_counters[func_type] += npages;
+	func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
+	if (func_type != MLX5_FUNC_TYPE_NONE)
+		dev->priv.page_counters[func_type] += npages;
 	dev->priv.fw_pages += npages;
 
-	mlx5_core_dbg(dev, "npages %d, ec_function %d, func_id 0x%x, err %d\n",
-		      npages, ec_function, func_id, err);
+	mlx5_core_dbg(dev,
+		      "npages %d, ec_function %d, func 0x%x, mode %d, err %d\n",
+		      npages, ec_function, func_vhca_id,
+		      mlx5_page_mgt_mode_is_vhca_id(dev), err);
 
 	kvfree(in);
 	return 0;
@@ -428,14 +469,14 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
 out_free:
 	kvfree(in);
 	if (notify_fail)
-		page_notify_fail(dev, func_id, ec_function);
+		page_notify_fail(dev, func_vhca_id, ec_function);
 	return err;
 }
 
-static void release_all_pages(struct mlx5_core_dev *dev, u16 func_id,
+static void release_all_pages(struct mlx5_core_dev *dev, u16 func_vhca_id,
 			      bool ec_function)
 {
-	u32 function = get_function(func_id, ec_function);
+	u32 function = get_function_key(dev, func_vhca_id, ec_function);
 	struct rb_root *root;
 	struct rb_node *p;
 	int npages = 0;
@@ -454,12 +495,14 @@ static void release_all_pages(struct mlx5_core_dev *dev, u16 func_id,
 		free_fwp(dev, fwp, fwp->free_count);
 	}
 
-	func_type = func_id_to_type(dev, func_id, ec_function);
-	dev->priv.page_counters[func_type] -= npages;
+	func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
+	if (func_type != MLX5_FUNC_TYPE_NONE)
+		dev->priv.page_counters[func_type] -= npages;
 	dev->priv.fw_pages -= npages;
 
-	mlx5_core_dbg(dev, "npages %d, ec_function %d, func_id 0x%x\n",
-		      npages, ec_function, func_id);
+	mlx5_core_dbg(dev, "npages %d, ec_function %d, func 0x%x, mode %d\n",
+		      npages, ec_function, func_vhca_id,
+		      mlx5_page_mgt_mode_is_vhca_id(dev));
 }
 
 static u32 fwp_fill_manage_pages_out(struct fw_page *fwp, u32 *out, u32 index,
@@ -487,7 +530,7 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
 	struct fw_page *fwp;
 	struct rb_node *p;
 	bool ec_function;
-	u32 func_id;
+	u32 func_vhca_id;
 	u32 npages;
 	u32 i = 0;
 	int err;
@@ -499,10 +542,11 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
 
 	/* No hard feelings, we want our pages back! */
 	npages = MLX5_GET(manage_pages_in, in, input_num_entries);
-	func_id = MLX5_GET(manage_pages_in, in, function_id);
+	func_vhca_id = MLX5_GET(manage_pages_in, in, function_id);
 	ec_function = MLX5_GET(manage_pages_in, in, embedded_cpu_function);
 
-	root = xa_load(&dev->priv.page_root_xa, get_function(func_id, ec_function));
+	root = xa_load(&dev->priv.page_root_xa,
+		       get_function_key(dev, func_vhca_id, ec_function));
 	if (WARN_ON_ONCE(!root))
 		return -EEXIST;
 
@@ -518,10 +562,11 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
 	return 0;
 }
 
-static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
-			 int *nclaimed, bool event, bool ec_function)
+static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_vhca_id,
+			 int npages, int *nclaimed, bool event,
+			 bool ec_function)
 {
-	u32 function = get_function(func_id, ec_function);
+	u32 function = get_function_key(dev, func_vhca_id, ec_function);
 	int outlen = MLX5_ST_SZ_BYTES(manage_pages_out);
 	u32 in[MLX5_ST_SZ_DW(manage_pages_in)] = {};
 	int num_claimed;
@@ -540,12 +585,16 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
 
 	MLX5_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
 	MLX5_SET(manage_pages_in, in, op_mod, MLX5_PAGES_TAKE);
-	MLX5_SET(manage_pages_in, in, function_id, func_id);
+	MLX5_SET(manage_pages_in, in, function_id, func_vhca_id);
 	MLX5_SET(manage_pages_in, in, input_num_entries, npages);
-	MLX5_SET(manage_pages_in, in, embedded_cpu_function, ec_function);
 
-	mlx5_core_dbg(dev, "func 0x%x, npages %d, outlen %d\n",
-		      func_id, npages, outlen);
+	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
+		MLX5_SET(manage_pages_in, in, embedded_cpu_function,
+			 ec_function);
+
+	mlx5_core_dbg(dev, "func 0x%x, npages %d, outlen %d mode %d\n",
+		      func_vhca_id, npages, outlen,
+		      mlx5_page_mgt_mode_is_vhca_id(dev));
 	err = reclaim_pages_cmd(dev, in, sizeof(in), out, outlen);
 	if (err) {
 		npages = MLX5_GET(manage_pages_in, in, input_num_entries);
@@ -577,8 +626,9 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
 	if (nclaimed)
 		*nclaimed = num_claimed;
 
-	func_type = func_id_to_type(dev, func_id, ec_function);
-	dev->priv.page_counters[func_type] -= num_claimed;
+	func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
+	if (func_type != MLX5_FUNC_TYPE_NONE)
+		dev->priv.page_counters[func_type] -= num_claimed;
 	dev->priv.fw_pages -= num_claimed;
 
 out_free:
@@ -658,30 +708,101 @@ static int req_pages_handler(struct notifier_block *nb,
 	 * req->npages (and not min ()).
 	 */
 	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
-	req->ec_function = ec_function;
+	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
+		req->ec_function = ec_function;
 	req->release_all = release_all;
 	INIT_WORK(&req->work, pages_work_handler);
 	queue_work(dev->priv.pg_wq, &req->work);
 	return NOTIFY_OK;
 }
 
+/*
+ * After set_hca_cap(), the second satisfy_startup_pages(dev, 0) may see
+ * VHCA_ID mode. If page_root_xa already has the PF entry from the first
+ * (boot) call under FUNC_ID keys 0 or (ec_function << 16), migrate that
+ * entry to the device vhca_id key so lookups use VHCA_ID semantics.
+ */
+static int mlx5_pagealloc_migrate_pf_to_vhca_id(struct mlx5_core_dev *dev)
+{
+	u32 vhca_id_key, old_key;
+	struct rb_root *root;
+	struct fw_page *fwp;
+	struct rb_node *p;
+	bool ec_function;
+	int err;
+
+	if (xa_empty(&dev->priv.page_root_xa))
+		return 0;
+
+	vhca_id_key = MLX5_CAP_GEN(dev, vhca_id);
+	ec_function = mlx5_core_is_ecpf(dev);
+
+	old_key = ec_function ? (1U << 16) : 0;
+	root = xa_load(&dev->priv.page_root_xa, old_key);
+	if (!root)
+		return 0;
+
+	if (old_key == vhca_id_key)
+		return 0;
+
+	err = xa_insert(&dev->priv.page_root_xa, vhca_id_key, root, GFP_KERNEL);
+	if (err) {
+		mlx5_core_warn(dev,
+			       "failed to migrate page root key 0x%x to vhca_id 0x%x\n",
+			       old_key, vhca_id_key);
+		return err;
+	}
+
+	xa_erase(&dev->priv.page_root_xa, old_key);
+
+	for (p = rb_first(root); p; p = rb_next(p)) {
+		fwp = rb_entry(p, struct fw_page, rb_node);
+		fwp->function = vhca_id_key;
+	}
+
+	return 0;
+}
+
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
 {
-	u16 func_id;
+	bool ec_function = false;
+	u16 func_vhca_id;
 	s32 npages;
 	int err;
 
-	err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
+	/* When boot flag is set, the icm_mng_function_id_mode capability is
+	 * not yet set (only set after set_hca_cap()), so use FUNC_ID mode
+	 * for backward compatibility. When boot is false, set mode from
+	 * cap (set_hca_cap has run successfully).
+	 */
+	if (boot) {
+		mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_FUNC_ID);
+	} else {
+		if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode) ==
+		    MLX5_ID_MODE_FUNCTION_VHCA_ID) {
+			err = mlx5_pagealloc_migrate_pf_to_vhca_id(dev);
+			if (err)
+				return err;
+			mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_VHCA_ID);
+		}
+	}
+
+	err = mlx5_cmd_query_pages(dev, &func_vhca_id, &npages, boot);
 	if (err)
 		return err;
 
-	mlx5_core_dbg(dev, "requested %d %s pages for func_id 0x%x\n",
-		      npages, boot ? "boot" : "init", func_id);
+	mlx5_core_dbg(dev,
+		      "requested %d %s pages for func_vhca_id 0x%x\n",
+		      npages, boot ? "boot" : "init", func_vhca_id);
 
 	if (!npages)
 		return 0;
 
-	return give_pages(dev, func_id, npages, 0, mlx5_core_is_ecpf(dev));
+	/* In VHCA_ID mode, ec_function remains false (not used). */
+	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
+		ec_function = mlx5_core_is_ecpf(dev);
+
+	return give_pages(dev, func_vhca_id, npages, 0, ec_function);
 }
 
 enum {
@@ -709,15 +830,17 @@ static int mlx5_reclaim_root_pages(struct mlx5_core_dev *dev,
 
 	while (!RB_EMPTY_ROOT(root)) {
 		u32 ec_function = mlx5_get_ec_function(function);
-		u32 function_id = mlx5_get_func_id(function);
+		u32 func_vhca_id = mlx5_get_func_vhca_id(function);
 		int nclaimed;
 		int err;
 
-		err = reclaim_pages(dev, function_id, optimal_reclaimed_pages(),
+		err = reclaim_pages(dev, func_vhca_id,
+				    optimal_reclaimed_pages(),
 				    &nclaimed, false, ec_function);
 		if (err) {
-			mlx5_core_warn(dev, "reclaim_pages err (%d) func_id=0x%x ec_func=0x%x\n",
-				       err, function_id, ec_function);
+			mlx5_core_warn(dev,
+				       "reclaim_pages err (%d) func_vhca_id=0x%x ec_func=0x%x\n",
+				       err, func_vhca_id, ec_function);
 			return err;
 		}
 
@@ -751,6 +874,9 @@ int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev)
 	WARN(dev->priv.fw_pages,
 	     "FW pages counter is %d after reclaiming all pages\n",
 	     dev->priv.fw_pages);
+	if (mlx5_page_mgt_mode_is_vhca_id(dev) && !dev->priv.eswitch)
+		return 0;
+
 	WARN(dev->priv.page_counters[MLX5_VF],
 	     "VFs FW pages counter is %d after reclaiming all pages\n",
 	     dev->priv.page_counters[MLX5_VF]);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index b460b3bae195..8e22ea662644 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -556,6 +556,12 @@ enum mlx5_func_type {
 	MLX5_HOST_PF,
 	MLX5_EC_VF,
 	MLX5_FUNC_TYPE_NUM,
+	MLX5_FUNC_TYPE_NONE = MLX5_FUNC_TYPE_NUM,
+};
+
+enum mlx5_page_mgt_mode {
+	MLX5_PAGE_MGT_MODE_FUNC_ID,
+	MLX5_PAGE_MGT_MODE_VHCA_ID,
 };
 
 struct mlx5_ft_pool;
@@ -575,6 +581,7 @@ struct mlx5_priv {
 	u32			fw_pages_alloc_failed;
 	u32			give_pages_dropped;
 	u32			reclaim_pages_discard;
+	enum mlx5_page_mgt_mode	page_mgt_mode;
 
 	struct mlx5_core_health health;
 	struct list_head	traps;
-- 
2.44.0


