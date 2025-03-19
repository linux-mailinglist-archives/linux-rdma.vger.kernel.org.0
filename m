Return-Path: <linux-rdma+bounces-8825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371BFA68E47
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889891B63047
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64E257AF6;
	Wed, 19 Mar 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g291UZAx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52553212B02;
	Wed, 19 Mar 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391800; cv=fail; b=Y0j+1QyJGyBGr87Jl3Y8WSeEoIUQMz3+gMIR5xpY2EawizrpjRCLgCMn4TiB2ZhGWePdHmeqTh8xGjCtff3c7xrMXGcwAEbUmPH9tcdfET/J08ZScVpFoFEocr+l+g6eUrl7NX9MnYkS+jtWuGjYMT57cz0wZ9biP0Qt2Me3gDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391800; c=relaxed/simple;
	bh=aDI6LCaBwlsKsHhUia3qb17eA2W5c66J10YJiz5dViY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVS237Jg0ym9GHo1OtK3U8CudWlYzESNgVRqAeEmi9VDhfh1c3tdzvhujdL+W5m4ICpDwW2Xks2NlcEOsIL55FJsft4CCpjfWXCS1zpLGPmnmvVwNs4rMp56qa5co96v1ZwyQTDOZC7Ap3b4uQ+5IIYvCN0PyE3EyGgoPFDNee0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g291UZAx; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML+lNaj3qRtOXV83aPH5SF4XnM7ImjdAwN4jCbfL6cFBR5DmXiK2L3GUYhRmzEvCFIoif9TjreFmVvbqWvhEpIPT6jD6CI1wCJv0jrxMrZJsV2oYfPjVYE5JXL6sLTB6CnO4titw0bg1JSc/sYqGy1asTQDbEtkbDz5ezuVe+oWp3zhEHKdXvvmloC1R0SPP7deeRH6AzG9EmuOnFe3BdeBSzGHFcNNtvK6ZanBR/36UTdSYtapiyjuGuf9meA2Kd92C/AQCtsS/LaBpQGcsgKgWpEXOAVVCki6/+dZKJPZtwQJPUzW0IaZEBxC3QXAM4z692+GD6aUcJ8g/anwg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eQolYvm7K/FbCpvILyj9Hbeq4NqMJDZ+whcTX284/o=;
 b=N23uBoF5DO9dAfXgr9kv+r2225j1/FGpW+avjmZWDRhOwa5315hcJM6V6Ak8MAPIFLhmkIndj46l9szxyrlRxkvnLVnWHKB2ZzCDoruKoULnW0xWQdKaIxLkxP/eqIRSj0ht3rQEJfn/JGirBf61JMt9wakMoeKPpgUL28rS6VtxWiiwDLAIt5WzV/CCpEtEH5jpnWaFFGuFDdoY5rwAgGR8GjZCf6RSHHU6xO5TW8X1X36pDBJfTPvG+O78Tbb+dSP9PkSAAsxrJheFWodTjLmUdJj2E2/wWYdbs2Nnpi8xQ6O31tINa6HnvXyUBk55GArqJeTeywKrovng0tp/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eQolYvm7K/FbCpvILyj9Hbeq4NqMJDZ+whcTX284/o=;
 b=g291UZAxseFIYiwArCJdQr0c8ZZaoTBh5pZOO/2c/2an/XozFZk/kdlCgvc8+A+Iv1qcY1t2IP/6/eUryqbBB5N9R9zS2okET2wyqTeV2Y5V6GFr1OqdhM1vAznO2rME6CWtzqLfhnVY2JzXDVIIHreU1MPgURwvG/NfWPDuZ1S2fZUhRfNZTR78KOo+wqgCiN7e7T5ChRMctR3+n4pIeDCw6w3EPrAFNUL7pZEsMP3sNwlEeVxnvSv6JvB0S23EnsTob/XGBuxZA4PtaN8b44/LkT9oANWYxAp61jPoSAIysX502jlaVsIDEWKxPMznOSDrcHOF4fPQ/mukUoM55g==
Received: from BN9P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::23)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 13:43:12 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::35) by BN9P222CA0018.outlook.office365.com
 (2603:10b6:408:10c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 13:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 13:43:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 06:42:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 06:42:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 06:42:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"Dragos Tatulea" <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: TX, Utilize WQ fragments edge for multi-packet WQEs
Date: Wed, 19 Mar 2025 15:42:26 +0200
Message-ID: <1742391746-118647-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebb3b1a-1b51-490a-f985-08dd66ebfd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iz/ngcc4XDluttSsTnMeDJ3CpTo2zdyl7tA8T8v+lvoOcMZTbEXoTv0JCqcw?=
 =?us-ascii?Q?dK1npY5qfjjPdfxQH/4jAFqVBs6NcDlQnuGo8r6HIrdGBWU3yXyPYSvRCwjg?=
 =?us-ascii?Q?FdYh10AnTrNi38cMAFXsmc7PqUltHM9+DS+U4iNKM9Y7rm/UDu1BQkH2OOqu?=
 =?us-ascii?Q?53nXBYcMF9eyCKrBPek8ljBdyELKg+9jRO7iYGkQSj/XWKExnEam0SJqQTWn?=
 =?us-ascii?Q?dMyBcNQySBDis9d4vUZ034D4iJpeh6N/ZoEMNjDWMEfCrdvp4Gk283wd1Bvp?=
 =?us-ascii?Q?z3By1xgLaig56aVYjp+MqC25jZNlUBsqRDruSScPTg7mgB25uz6H2wdyFB1U?=
 =?us-ascii?Q?nYT4L3EYZVE52auf85f6gWXrZY11Kcacq5BAu2WqejMDuVYggIdJKJpmk1br?=
 =?us-ascii?Q?eI/yaZAPELl1kdEJYPTHEky0+w95QdlCnC6EmO1rfcJZg97v/YHMv0WAI2zY?=
 =?us-ascii?Q?RwNqBwXgnOZq0iZtK/lonqKFNwj51rJVsFUPcr09CR7DGbs/b+kEoII1rFl6?=
 =?us-ascii?Q?x1tbiL4667uMpKMOrCAqwH3TCCnroweMwqmveR4Ia7wrId3jBZ8qN/CklMb2?=
 =?us-ascii?Q?HizWWcDOJA6jXg/E22kuabrzCb5rBtmwpeoDfFgti7AQxKhmyzH3+qdH8Ib8?=
 =?us-ascii?Q?491ITVIgOxaWqPnrvVYV84xbcSC6sZCVXWYOJGMlm0uUf7927uY5nMmP5JDQ?=
 =?us-ascii?Q?tC+nPtNLfLgGo8eObFor7hnOj6aOnhMhYL7dsisJZ0Pg9CZeIlrY/an0cVX/?=
 =?us-ascii?Q?lrFau0T5ZhEYeMlyFf51/W7SjsI706P9Scf8UALtKk6bGzrlhqngD0j6Tjuf?=
 =?us-ascii?Q?AJZU5ltii/bTnbI//csD7x77VodXt3dyPFHoPMDRobX9AbGDBJ5hTNrdjCmg?=
 =?us-ascii?Q?bTCbcSC0bctHfco/TJCQLjFEcFF4fRvCKlUn9ld8JnYxiDXDjIbRgIzMV8u9?=
 =?us-ascii?Q?l+vKtQqt2lq65t8FTS+WEdTGHwoZUbQp2D3t9+Ct0Jz+CdQ6sm3bDCGBieEX?=
 =?us-ascii?Q?2Y6MWInUjU1FNY5vDlRVNEGBPP+ufbcwUtDfl5/6MGFkDPTY3NmcSfOmp9yw?=
 =?us-ascii?Q?0TvVhyTeD6M2xU4TqyBcGkgRXhlbpHaxBfJRIDKxhi5xww3SPc2M7dEeSRix?=
 =?us-ascii?Q?Ajh9aG+AzGcwPwFaEyTUwlnOUSBxzkR9ZASVWwgKi0jzliAS0wn25cV+evWp?=
 =?us-ascii?Q?Q0gt1XJgVEn8liitpVcMiLSJUFq4FsAQlDwvMHvxYamTunPJR4bAq8zM9Fbb?=
 =?us-ascii?Q?8XFjgMz3O6K2gARt13Uih1RH8PgNoWNZsR9yW7qvryTlBXA6Va5VhnZKdQpH?=
 =?us-ascii?Q?3obgxSlJht4Ip3hqse98oCP1Nc6X4Y3Pr7vLZowebYPwWsXc9peFDrAdg0WH?=
 =?us-ascii?Q?PHcmFaTthrYAn3965ppIzKemQLlfDb4hKr83D9AbeF2vFcAeld7FQJj0ciYD?=
 =?us-ascii?Q?n6W+KYymSikDvj7Grq3b+6Ur82kmMBTlXWnUOGtiitXsoWphuokgEewcQQsB?=
 =?us-ascii?Q?JxuQuDhRVudaiBY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:43:11.1785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebb3b1a-1b51-490a-f985-08dd66ebfd89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

For simplicity reasons, the driver avoids crossing work queue fragment
boundaries within the same TX WQE (Work-Queue Element). Until today, as
the number of packets in a TX MPWQE (Multi-Packet WQE) descriptor is not
known in advance, the driver pre-prepared contiguous memory for the
largest possible WQE. For this, when getting too close to the fragment
edge, having no room for the largest WQE possible, the driver was
filling the fragment remainder with NOP descriptors, aligning the next
descriptor to the beginning of the next fragment.

Generating and handling these NOPs wastes resources, like: CPU cycles,
work-queue entries fetched to the device, and PCI bandwidth.

In this patch, we replace this NOPs filling mechanism in the TX MPWQE
flow. Instead, we utilize the remaining entries of the fragment with a
TX MPWQE. If this room turns out to be too small, we simply open an
additional descriptor starting at the beginning of the next fragment.

Performance benchmark:
uperf test, single server against 3 clients.
TCP multi-stream, bidir, traffic profile "2x350B read, 1400B write".
Bottleneck is in inbound PCI bandwidth (device POV).

+---------------+------------+------------+--------+
|               | Before     | After      |        |
+---------------+------------+------------+--------+
| BW            | 117.4 Gbps | 121.1 Gbps | +3.1%  |
+---------------+------------+------------+--------+
| tx_packets    | 15 M/sec   | 15.5 M/sec | +3.3%  |
+---------------+------------+------------+--------+
| tx_nops       | 3  M/sec   | 0          | -100%  |
+---------------+------------+------------+--------+

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h   | 17 +++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c    |  3 ++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h    |  6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |  7 ++++---
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 8df185e2ef7f..32ed4963b8ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -398,6 +398,7 @@ struct mlx5e_tx_mpwqe {
 	struct mlx5e_tx_wqe *wqe;
 	u32 bytes_count;
 	u8 ds_count;
+	u8 ds_count_max;
 	u8 pkt_count;
 	u8 inline_on;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 5ec468268d1a..e837c21d3d21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -214,6 +214,19 @@ static inline u16 mlx5e_txqsq_get_next_pi(struct mlx5e_txqsq *sq, u16 size)
 	return pi;
 }
 
+static inline u16 mlx5e_txqsq_get_next_pi_anysize(struct mlx5e_txqsq *sq,
+						  u16 *size)
+{
+	struct mlx5_wq_cyc *wq = &sq->wq;
+	u16 pi, contig_wqebbs;
+
+	pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
+	contig_wqebbs = mlx5_wq_cyc_get_contig_wqebbs(wq, pi);
+	*size = min_t(u16, contig_wqebbs, sq->max_sq_mpw_wqebbs);
+
+	return pi;
+}
+
 void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq);
 
 static inline u16 mlx5e_shampo_get_cqe_header_index(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
@@ -358,9 +371,9 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
 
 void mlx5e_tx_mpwqe_ensure_complete(struct mlx5e_txqsq *sq);
 
-static inline bool mlx5e_tx_mpwqe_is_full(struct mlx5e_tx_mpwqe *session, u8 max_sq_mpw_wqebbs)
+static inline bool mlx5e_tx_mpwqe_is_full(struct mlx5e_tx_mpwqe *session)
 {
-	return session->ds_count == max_sq_mpw_wqebbs * MLX5_SEND_WQEBB_NUM_DS;
+	return session->ds_count == session->ds_count_max;
 }
 
 static inline void mlx5e_rqwq_reset(struct mlx5e_rq *rq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 6f3094a479e1..f803e1c93590 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -390,6 +390,7 @@ static void mlx5e_xdp_mpwqe_session_start(struct mlx5e_xdpsq *sq)
 		.wqe = wqe,
 		.bytes_count = 0,
 		.ds_count = MLX5E_TX_WQE_EMPTY_DS_COUNT,
+		.ds_count_max = sq->max_sq_mpw_wqebbs * MLX5_SEND_WQEBB_NUM_DS,
 		.pkt_count = 0,
 		.inline_on = mlx5e_xdp_get_inline_state(sq, session->inline_on),
 	};
@@ -501,7 +502,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
 
-	if (unlikely(mlx5e_xdp_mpwqe_is_full(session, sq->max_sq_mpw_wqebbs)))
+	if (unlikely(mlx5e_xdp_mpwqe_is_full(session)))
 		mlx5e_xdp_mpwqe_complete(sq);
 
 	stats->xmit++;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index e054db1e10f8..446e492c6bb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -182,13 +182,13 @@ static inline bool mlx5e_xdp_get_inline_state(struct mlx5e_xdpsq *sq, bool cur)
 	return cur;
 }
 
-static inline bool mlx5e_xdp_mpwqe_is_full(struct mlx5e_tx_mpwqe *session, u8 max_sq_mpw_wqebbs)
+static inline bool mlx5e_xdp_mpwqe_is_full(struct mlx5e_tx_mpwqe *session)
 {
 	if (session->inline_on)
 		return session->ds_count + MLX5E_XDP_INLINE_WQE_MAX_DS_CNT >
-		       max_sq_mpw_wqebbs * MLX5_SEND_WQEBB_NUM_DS;
+		       session->ds_count_max;
 
-	return mlx5e_tx_mpwqe_is_full(session, max_sq_mpw_wqebbs);
+	return mlx5e_tx_mpwqe_is_full(session);
 }
 
 struct mlx5e_xdp_wqe_info {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f8c7912abe0e..4fd853d19e31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -525,9 +525,9 @@ static void mlx5e_tx_mpwqe_session_start(struct mlx5e_txqsq *sq,
 {
 	struct mlx5e_tx_mpwqe *session = &sq->mpwqe;
 	struct mlx5e_tx_wqe *wqe;
-	u16 pi;
+	u16 pi, num_wqebbs;
 
-	pi = mlx5e_txqsq_get_next_pi(sq, sq->max_sq_mpw_wqebbs);
+	pi = mlx5e_txqsq_get_next_pi_anysize(sq, &num_wqebbs);
 	wqe = MLX5E_TX_FETCH_WQE(sq, pi);
 	net_prefetchw(wqe->data);
 
@@ -535,6 +535,7 @@ static void mlx5e_tx_mpwqe_session_start(struct mlx5e_txqsq *sq,
 		.wqe = wqe,
 		.bytes_count = 0,
 		.ds_count = MLX5E_TX_WQE_EMPTY_DS_COUNT,
+		.ds_count_max = num_wqebbs * MLX5_SEND_WQEBB_NUM_DS,
 		.pkt_count = 0,
 		.inline_on = 0,
 	};
@@ -626,7 +627,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	mlx5e_tx_mpwqe_add_dseg(sq, &txd);
 	mlx5e_tx_skb_update_hwts_flags(skb);
 
-	if (unlikely(mlx5e_tx_mpwqe_is_full(&sq->mpwqe, sq->max_sq_mpw_wqebbs))) {
+	if (unlikely(mlx5e_tx_mpwqe_is_full(&sq->mpwqe))) {
 		/* Might stop the queue and affect the retval of __netdev_tx_sent_queue. */
 		cseg = mlx5e_tx_mpwqe_session_complete(sq);
 

base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
-- 
2.31.1


