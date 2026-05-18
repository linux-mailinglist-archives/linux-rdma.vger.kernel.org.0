Return-Path: <linux-rdma+bounces-20883-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFeWBve9Cmrb7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20883-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:21:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4844567646
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2AAA307FB32
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DE3D1CB1;
	Mon, 18 May 2026 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Of2mbNg8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B73B47CC;
	Mon, 18 May 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088546; cv=fail; b=Mj5fD/pMa+qJhSpXT8kbOwFteQ8h2lbr/wm88udeJLerS7f4b3U9UJkV22+WmStCCBvTpa9ZEiK1kC2N18ZIHBMbVXr5E+04Ww+zFZaXR3+HBn64rYHEl6eBgObQq+ixdH1qtJKsBUyIwQd5Xw6FuVmyxKkEbITGlA0a86z7Cfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088546; c=relaxed/simple;
	bh=tQGfnkH9F4I81N/g/P3ZmdfBdICToAbIKUkaztMRL/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ju+DGFnFAro/DtLxB0+DZaI5V6QshWk451Bnv5RKxAbd64U3stSI8ueWDC1HbImecLXN6WCRCziiuelycIeFhKQ8nvX6ZybLlp+5Dv/eNOWyuO7vwKcWtc94lBQIqACnbeRzQGjUDLBM1iR8FLiIYqEllFgTeq5TxKZbH8cxkxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Of2mbNg8; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8kulFoA2Nrcg4sCUuvqy0FWcfLZWlErNyVabjQubHdiIRgLQ6MUbzP2tjZgvhw4WHvX6ZZBLd6piN1Pl4zsdDrku73ypYb4uzWLA7BLfnqTeBgLO8sUixynb32P/VTxsvV0AaU8TYfesQKRUEZ9muFAd86CCHeLDqMfab1lVGnyOMiDMf3oh4MTKZ8eBDRy3zOcpvACak3fr1X3zD4NaECMDm9fFN2kNZIgHTpD8krf2bzq9vxF9J29xjGw1Q8wMtpAs1srQai+dFnc3U6vhW1uaRNNiQcEeHznf/tO+XgaYllI6i8kEIgKbCG1fVC+Vl5pTbfsrHdSNUmdiq2cWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+MCUb8TmhXN5OyMFxVX6ZGv5Yl8Zo6tIBlnxEBQmPU=;
 b=IK0H5Fc1Va9zWUOiFYD+BurX9GN8RTXhgtDVFO7uh9FDFgpLrQfOO6SYZH2zB10yZRamFwdEIwGB+TnrBzP1fDU5HXCr7udzbN8bhE1rVfiT2r/fb5yIDjPL0vFjNWMb2sxd/hFZQ44zSYU4kx0URTKEVeBwIrUgODaU5sBLncnVpC9kbDbk6ciB6i/DI64zgAjCopqrtSK/jSP+8V57ywW2ixJBXTUAUp5ujiQmQnY0tlsOuVoHhsIPYSy26/6OudlPEJ6Vn6KbLNN0YYZEorORhKYJbchPJzlvIj3/RrHmbn7kqhWwu0tleIyWRWGu4QnLhTnv0PCXSbnJmmH/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+MCUb8TmhXN5OyMFxVX6ZGv5Yl8Zo6tIBlnxEBQmPU=;
 b=Of2mbNg8XQIWQAw2T9DYceYUdvpKTeBHDSJk22aYM3mV5cuEZJ6InA1OVQSE+r3ysSTIixnxEZ/3GCAB+qwUI/NuqxEmPSyJYu7WTUEKrSvXxey2CnZvjqbVDk/ftQSKrmGCOaGlSeWXlaGHaxjFzOGNxg/WwelAoUceNTTzP+/r/iBhn61/QsP3TPY1nldQXA7nOjxCFXngJ72rq7BKSjcbOV5lwWadN+7E9AvYcJxgdGRxDjiIv/TI7HDIoQ0lfUMPz0L7PsxXSjDxKjTGIu9k5zFmkkHf2LiilNqHVfzMgsaTMQguU0OcdFYCCpz+VtlQp+VMbdGt3QH0wvwaXQ==
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 07:15:41 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::d4) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Mon, 18 May 2026 07:15:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:22 -0700
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
Subject: [PATCH net-next V2 6/8] net/mlx5: Refactor mlx5_set_msix_vec_count() SET_HCA_CAP
Date: Mon, 18 May 2026 10:13:54 +0300
Message-ID: <20260518071356.345723-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c4b4a0-cbce-4c94-efa3-08deb4ad44c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	18k/7Ek5Lle1IrIuXEFITxmUJeSzcQHvJI2G5E2HxM9Pca5O64n8djBc1qNLEAYjsp6YGhmC7aovSrEeBbt5hemJjQ6lnjaoPcBmLsq7wzfjrV+cZbTIDZCefRi8BGsjLn9quIntH1AlS3tccuyWX2DslCM7PzPmhjs0fF47WfAeUrnxFxuedeQWiSSpzRjAOK32sd6WTZTGaBJimPx8TRG+gNM/yDMsuW2ISxmFTkk4mubJnkLWNrs+dSiRfV4rtmUK/AK6PGkcoiGQYBT0ycAY5F1BEdgUdYcr4lXw7e+wWcxFXu46VqZF0kTjxLiGjzM+uqOBSl/LpIeBiPKvLVBrcYlOdqfnzqQJLwsJVTE1IJhPQ0H/uzIeg5/g+ttcoywqtZLu7QGaX7B6M/Fc+1/HJ0FRcLRcroGCFNmqU+LLMt4t41MOCxT+VB/dqnXBiNfV3CyGM9s/IA98WHr2iIaIakfAvhnoKvncP1xmcHu2Kmt1oAC9IiMBEHCvDhF04CnluZ+IQ/lqL99i7sVlghxaTsLPZU3vk2I6mF2GibHLSzJxudlzrjmE29aTzmh270DCSIbtA82SIIBcKg9fVg85CtLnx3FK4lZzj8D9i60BaXOAbxgNmGoIYz6GFnYAl2op9hYGJLUJE/SQ/mx6x32WGm4lNpxNImfn3zqpaACjPI2q+2KJlMR3OgpnGPeJUBSU3B7+Ri3gt9lRAZrMOVtClrMjLvqE4AziXhKF85Q=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mtkRdYfMP8g3ePVxR5lztx6vSL3cqK9x/uYcOo0go3Pk+B4ABsgzgJfR2xWmMyTuefPmw41QvigbcWSUBy8JySupypmhOT1f7sMhzXdpF4QveAvtG41NfHwMV6EzE1pgQzmqOrFPm5+gGvfiVZOaQWfwN+3hOxTxI5JfACpSoAa2JZ8pemnJkr6J5ux9ENtQdXdwa545tpYuyybhaA6DOoMPN4gE53w8SexoIQVqR5ON9EtTMwfKVgOd6iPKRvhH5ppTAJzcELj9kQYOWbyHoD+vTUKdGSNlj7b14L8Ju9jDZ5cv4wtWFQA8CkdeyH6g6415Lfr39X8B+PB64wWwli4vSR+NN4j2t11o+Rjg6EP/bWqwChAk1TA6VlL9gJkqWVotwFzH1HhPp/0YlnYCfjeJymFIblCwOL1Feoa0uuFhxZSmO+PPNYkx0rOxnkoj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:40.7035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c4b4a0-cbce-4c94-efa3-08deb4ad44c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679
X-Rspamd-Queue-Id: A4844567646
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
	TAGGED_FROM(0.00)[bounces-20883-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Use mlx5_vport_set_other_func_general_cap() instead of open-coding the
SET_HCA_CAP command. This removes redundant buffer allocation and
ensures consistent use of vport-based function addressing.

mlx5_vport_set_other_func_general_cap() supports both function_id and
vhca_id based addressing, so this also enables SET_HCA_CAP for vhca_id
indexed functions which was not supported before.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 27 +++++--------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index e051b9a939ee..0f5b8bc7861e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -87,9 +87,8 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 			    int msix_vec_count)
 {
 	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
-	void *hca_cap = NULL, *query_cap = NULL, *cap;
 	int num_vf_msix, min_msix, max_msix;
+	void *query_cap, *hca_caps;
 	bool ec_vf_function;
 	int vport;
 	int ret;
@@ -111,11 +110,8 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 		return -EOVERFLOW;
 
 	query_cap = kvzalloc(query_sz, GFP_KERNEL);
-	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
-	if (!hca_cap || !query_cap) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!query_cap)
+		return -ENOMEM;
 
 	ec_vf_function = mlx5_core_ec_sriov_enabled(dev);
 	vport = mlx5_core_func_to_vport(dev, function_id, ec_vf_function);
@@ -123,21 +119,12 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 	if (ret)
 		goto out;
 
-	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
-	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
-	       MLX5_UN_SZ_BYTES(hca_cap_union));
-	MLX5_SET(cmd_hca_cap, cap, dynamic_msix_table_size, msix_vec_count);
-
-	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
-	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
-	MLX5_SET(set_hca_cap_in, hca_cap, ec_vf_function, ec_vf_function);
-	MLX5_SET(set_hca_cap_in, hca_cap, function_id, function_id);
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	MLX5_SET(cmd_hca_cap, hca_caps, dynamic_msix_table_size,
+		 msix_vec_count);
 
-	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1);
-	ret = mlx5_cmd_exec_in(dev, set_hca_cap, hca_cap);
+	ret = mlx5_vport_set_other_func_general_cap(dev, hca_caps, vport);
 out:
-	kvfree(hca_cap);
 	kvfree(query_cap);
 	return ret;
 }
-- 
2.44.0


