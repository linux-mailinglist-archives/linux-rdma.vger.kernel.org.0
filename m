Return-Path: <linux-rdma+bounces-13867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DD5BDCD1B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488FF3B9A1E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8862BCF41;
	Wed, 15 Oct 2025 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Td6T4XIU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEA1C862D;
	Wed, 15 Oct 2025 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511974; cv=fail; b=oI6qpW3nx3RCMGZfgnzHxRKlsPvHFTSzH8RC+E8yQs/gvPKCY2np8QQD7Qj9JTtjBajVi9d+uBIozp6iEqfED8ZbWjqvYL9YsHnBw1tmPw0xAad91VvqllBPgRZYXzXsXxuCV5DSDunEegQDu4z+6ne9mw+4rKNreF6/WUHPFT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511974; c=relaxed/simple;
	bh=ADr3O5XkXAmAxq3oJZM/wQyQOztgZodHphhSaiKkpZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBFieanDFhWeP2TdXgsE9jaK3MU5KgDEHbbAsQHCkotkACl2PjDISWQtQ5sJMNKgJmrbo2WYz/dYiXDTUmbF0KxNMb2zqJdz1m6PihRl/hmsC1UxIfWTxvbq7tyKUrp84R3cphvwAemeElewkXRWR1DVdv9ToRYiXPIRl2WNEdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Td6T4XIU; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfCP+ij1RKWH2W7Hrh13nIughDouEEJ15btonSB8zlcRKGBpacg75tpqgMxid6v6pEYWezvXlQmVeKgu0QJvgqK9m82bgZd+1mnBrPGsYNonmmhjYMwUicHGsq1ehtobwHULU2pRdoYLqaYQU6UxFLVLtGweS+/vb1GEoMDrMADLODW2hyVSYTt1NO01tcb4oSQ3zvV/f4k6fLPaCLOy5JwUw3tWExPZVSTp5+9/63LSnIl1hw2qEzaYq9cibO004F6mhDuO69fT3gylMnjf4j6A33lWHAU1jBqqQs6MM7vl8dIl9ykHbz5rRUeZcyMv6fcDlC13tnHxMh9yUiNw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0Acrn+BvqXIyuCQtxwoh6iaUvjiNyCmeG9n+9pzjMI=;
 b=jzBu+/ZxDuijkmdU1oZotBgyWe9qf8Bs84OXSlMEIfuncUDNzS6UF1MA7YL02vdzrlg49b562R3IGbrly8nAteg8M672Se6GliAVW1Tvt8iLM1ff3zsuH3RgOKU0OnJ0h1ZyU4QqpU6/CbeOgqsnAbRfOznxolfmSgzzVfAxUeF6XpbG0bgXV/g0dPc5erQ5qZg6R2kQAstLpYtyEjg+586LtPrNthskdB/1TPRDrDCps69MGrhGQVVzUUsh+FzpAfuav2HCLfz4G2hxmGZ03LhV1BAzDoLh+OCUfUxewvr6AHvBTow0nBzV9UDFqtj9ollSduW9oBLxt97B1al98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Acrn+BvqXIyuCQtxwoh6iaUvjiNyCmeG9n+9pzjMI=;
 b=Td6T4XIUlzHMY5a/yyud9mFmeTyB6n6t8hrO0rTy1mVhaRKMllqegC/rm4Ak2BGIohOZh1G66AqgIG3ff37XCcBJ8CMsaj1jqVyO8eML81Bjch8qRz03/h7J/wzx/bCbWVlwJylaCh1Qet8LT9kXHfjUu+uBrderQl4mXcTyHl9fyZRv+Tc5GpzVKjS/PrcnGJZ0en/il/3UrC0AtclMTOkT0/Je/1CWAyRJSCGvzKjcriopkU8vhU4lnHGNKsbEjOb+LUMDijfhv0Gfj9HUtdR/svqm3RrKZZ3Qm3NiZCyp+Lwbw/Hqe1jHZMD9nFgR/l5gQe+m6/ks6ou/Jyn2AA==
Received: from SJ2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:a03:505::18)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 07:06:04 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::46) by SJ2PR07CA0006.outlook.office365.com
 (2603:10b6:a03:505::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 07:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 07:06:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 00:05:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 00:05:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 00:05:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net] net/mlx5e: psp, avoid 'accel' NULL pointer dereference
Date: Wed, 15 Oct 2025 10:05:23 +0300
Message-ID: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 475a3af2-7d56-4cdc-8f97-08de0bb94de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FYJa2WPE2Ek8WVF8OerEZPztQSAmeUnEYisk7J2mGDpjbPZI5i/sQDdjhd05?=
 =?us-ascii?Q?w8kNPpH0YOgzri5C9Cxb6LeutEJmiXUxyfP2vAKDkYm/AvLqAaquS8Tacg5G?=
 =?us-ascii?Q?vaHoMLzBmOFT+21Qt6ne61CXsXntnIGI65pnLs3DLn4cJOH4DPx+iTqGLpV7?=
 =?us-ascii?Q?B3dwGPIeOlSJ/LipY3bVlsB+1OROnDWIMr+XNmQkdOHSufLKNDZq+Pyr+DQJ?=
 =?us-ascii?Q?Ss4G9zJcDMYaKqRiwlGfSMcQ6YDTIoZE36FmwlLjRXQ8bq6DIp7WXOAFvtbR?=
 =?us-ascii?Q?vjqe4hYsUTu1215Twtas7ftZC7sR5ewfEsB3CUxrizcHWaE3MIiQGqvJ1wYx?=
 =?us-ascii?Q?kkVO3Bhr6Qh7UVIIu8WMWWlX2YdD6I6Lexi3bz9EDJVx434rMqGk2otyB/Cj?=
 =?us-ascii?Q?PLUsDdpq84r+W6aEVKD5LHQvJ+PgmDvIvgqFFubvTailiptYGPIzDHKxP7Qc?=
 =?us-ascii?Q?BpuvwnB2pErVrOh+1xh2fUlqELudWz2imRa5YcZQZcTAJtsWjqYNM6QFYPew?=
 =?us-ascii?Q?nZoSSMDGZi3VN+Kw0EOXpnb0GtgqhGQvvMaeIFV7Ak64iVe27IW4I645bR41?=
 =?us-ascii?Q?YjI+QWgyKwhdFfDz1QIJIZsdnbGL3TwnenOVJvzbAcl3GQYKooK65o1MA2Ms?=
 =?us-ascii?Q?+Wf/MBcsRDfJRc7z/HownRul9KrSdY1iLDsiFoxSn0fVw/eBJ8yrfrSC2M7T?=
 =?us-ascii?Q?3ylx/PRrGKbbIpxMRoKAEr4LEAy+hohMCFEUfR0c8AKd0HNbHs/o0mKW4ADo?=
 =?us-ascii?Q?h8MNGfxLt1wfnH56MOgSrZ9gQDCVUg4SkIgZXFzbtw3PcEydRgFwq7rki1ys?=
 =?us-ascii?Q?/csZrZy3Y/9RYhwAOMux+siJUgCRgwDk5DyAVeuNZG1jeAGdtvgRuwjfdaO0?=
 =?us-ascii?Q?tcZaUsIRV4kiENh6YBKUS6Nnco5QWRzVwDgx0mcQxP0RJ6fcF/ayvcmwglJp?=
 =?us-ascii?Q?wDm6cx0Nz+zUegvBl+IEqkepkqph22N4GFpYKPKwBBnbtvxdTsAB0r8OLjCL?=
 =?us-ascii?Q?PYD9BLqsFIMwQTKoBrdFt7X/GUsF58wMs8c0JKPtSapIinGk123NGD7y9/6h?=
 =?us-ascii?Q?zMEQ8z0+9tl1AWbe+N53XL2McQ8K9M/pN4fHiNbIw0Xzh8WhJYtdR0JVxuje?=
 =?us-ascii?Q?Poq1cj3PUPDjPru2vYaYSo7dvsvPtwgGEbzK52oObpaZ8uRONxJ+pZEVPcbg?=
 =?us-ascii?Q?nGZQ6+Vjy1sJZV1t/Vdx0x+bOkx3oRSFfjKVHdwLAVMO0jWIMImIsWGGenke?=
 =?us-ascii?Q?2yy8WHf0/gqCAzVV93sQW02l6vCHTZMFGl4LnyYSbIgiJpYlkHZxkH9mxa4j?=
 =?us-ascii?Q?H5mMeHLe4ya17fWeFBkanWIzxQJF/2FqagMxEsqCUjdUmnQo3sx5xhlMghSc?=
 =?us-ascii?Q?iNsLbC57naHZH6nEypsEHKgIUK7iPT6k3xesKDBDhvADvUQa92sJ7I7HMdzc?=
 =?us-ascii?Q?LWnxZhJJuWPJVnrMUHS7iGe0mddMkC4vDYOyJ3z05gk8wIAzMLIuGXU3JhDW?=
 =?us-ascii?Q?tqhf25RyPr+ujN0mmrdQvlIqg4ScUOcRBB9cvWBMle+xh+zWdtsMJpE4Gjn+?=
 =?us-ascii?Q?XAEBnJANgbu5kTGexXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 07:06:03.6154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a3af2-7d56-4cdc-8f97-08de0bb94de8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

From: Cosmin Ratiu <cratiu@nvidia.com>

The 'accel' parameter of mlx5e_txwqe_build_eseg_csum() and the similar
'state' parameter of mlx5e_accel_tx_ids_len() were NULL when called
from mlx5i_sq_xmit() and were causing kernel panics from that context.

Fix that by passing in a local empty mlx5e_accel_tx_state variable, thus
guaranteeing that 'accel' is never NULL. Also remove an unnecessary
check from mlx5e_tx_wqe_inline_mode().

Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index b7227afcb51d..2702b3885f06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -256,7 +256,7 @@ mlx5e_tx_wqe_inline_mode(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	u8 mode;
 
 #ifdef CONFIG_MLX5_EN_TLS
-	if (accel && accel->tls.tls_tisn)
+	if (accel->tls.tls_tisn)
 		return MLX5_INLINE_MODE_TCP_UDP;
 #endif
 
@@ -982,6 +982,7 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	struct mlx5e_tx_attr attr;
 	struct mlx5i_tx_wqe *wqe;
 
+	struct mlx5e_accel_tx_state accel = {};
 	struct mlx5_wqe_datagram_seg *datagram;
 	struct mlx5_wqe_ctrl_seg *cseg;
 	struct mlx5_wqe_eth_seg  *eseg;
@@ -992,7 +993,7 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	int num_dma;
 	u16 pi;
 
-	mlx5e_sq_xmit_prepare(sq, skb, NULL, &attr);
+	mlx5e_sq_xmit_prepare(sq, skb, &accel, &attr);
 	mlx5i_sq_calc_wqe_attr(skb, &attr, &wqe_attr);
 
 	pi = mlx5e_txqsq_get_next_pi(sq, wqe_attr.num_wqebbs);
@@ -1009,7 +1010,7 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 	mlx5i_txwqe_build_datagram(av, dqpn, dqkey, datagram);
 
-	mlx5e_txwqe_build_eseg_csum(sq, skb, NULL, eseg);
+	mlx5e_txwqe_build_eseg_csum(sq, skb, &accel, eseg);
 
 	eseg->mss = attr.mss;
 

base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
-- 
2.31.1


