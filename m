Return-Path: <linux-rdma+bounces-14945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A5CB001A
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E6A3154922
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949132AADA;
	Tue,  9 Dec 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFtRgWkH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49632AAC1;
	Tue,  9 Dec 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285050; cv=fail; b=GtGBmfMlMzupdCJl6CigP63RuT9auOsg9VJhHW7Ybv/q4q9bStLVN0d7LvjfTA6OFMCPuaXa+m/IZP0wvWV4SJ724X8h6eQLjqkh0WCFF5tCOZTuFJeOM/WbkG3oyu7InjQkfDCnV57ip0RSyO7iRhYRqvgn6mBsNb4oBxgtt00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285050; c=relaxed/simple;
	bh=yIW56Un1EzOAPPzV8gNqyiAYnPLbwxd6Rm7gfk2nhKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjzvFUu/nQe1DvgnFTTpprpbANpeeRbPHFuiDVLMhZfvN7B2sEKVkuaABoHISX3X8wigOzRRmjVuAq+6kci4OuPhJO7XMXKx8vdnZoXSqDDxgpLAwY2uEy5EQHTlu4NlpGLZZREw/Swq0RpdLGXYNWoFjkp0GK7vG+uiSzqb6SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFtRgWkH; arc=fail smtp.client-ip=40.107.200.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqU3h5esez6094m2kNMuPDxIGGNd8U/EUX5n9VP2Ef6WNwVaaR7Bs/GEtRYdx9/FmzSB64bdm9Pz9ryI3k+ney8/AwcIpY9IOITu6rJHGs7+vjGCa1wXZmxwnZ8/Spzna9g2VetA5mPpuIyT2mux5jMiaO7YAS4fPXtA8g4W58BFfsM9d/H1kAELOG2GB4r3NJx8+gLOPD4wdKS1fNkKH9VzPCdNyfhvhastCz0yIo9JcQmta76xC5nVg8nC6VES6s7j5ejB1QF6AhP1ExME6TkIBhBHxcIBXGGnqySDxXdipnjrNyKClYdXWMromYMsLisb1WGmCR/peCAgOBmePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+HV8ITuOvFoPkSm2TlLBjlNUCC1JCFZs+BJijytKNs=;
 b=v1R6F/bo/ea9etWqfGjISNpGaEUZ0Q85VL8aMsvbSEvGtRXaDrtUpee19sUCii+kAHFqwDZcFFsTFgEewkMWhCLNQ/2qvgDr7v8Jc+VDeUSyo+WkgSBNbDLEy3Deu66KSZ/CZ2wZ4RBQVWtDLvJErasnFF3A3MkKBLAWDkhw5Wysr6uzeh3M72w0j5NaUxbXLnQjLwLwaHvxywRRCEo55PxnQaz7c17i0hLjtVYKhbQ9n2MuskEHqYh5IfP/msnn7U7wMvzpfWzelwajjRxEXhO117u1wyf6Ruo8FZPk3dHrA5Q+x3EmAXAyAMfSP2U1Dg9agX9bDg+S7+qu4P06lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+HV8ITuOvFoPkSm2TlLBjlNUCC1JCFZs+BJijytKNs=;
 b=UFtRgWkHDvdtFAPGnTJfloxEhNOhwwN3ITF7TnZullSNqk3lA3Z/e5aV5pfe77xFC5hN7ThUVkgQr4YgHMvj9QgbdbvxL1l2M2taCrx/hGFPAfxjvfK1FRoujAy/dTScDfHqrzgYKp3i5ojv41fsZ4LOPPive7PBbcSmq2CP149EWu7O3LF5n6KeAtBkY1NiVfMvgcMoNZnHwiOcLR1X+itlm4pry2gOKG5PI8DRcL7d60k7lm9O95gxvlmCnZ9PSys4shFWQce/9aIEFJK9IyJ0WEToB8WgdBeYtQiYRbJEZ/VqWbpuJoFyRBtJm9tCNgNb+9Bl/4JJFbmPcJUBUw==
Received: from BL0PR0102CA0015.prod.exchangelabs.com (2603:10b6:207:18::28) by
 DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Tue, 9 Dec 2025 12:57:20 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::17) by BL0PR0102CA0015.outlook.office365.com
 (2603:10b6:207:18::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:57:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:57:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:57:11 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:57:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, William Tu <witu@nvidia.com>
Subject: [PATCH net 8/9] net/mlx5e: Do not update BQL of old txqs during channel reconfiguration
Date: Tue, 9 Dec 2025 14:56:16 +0200
Message-ID: <1765284977-1363052-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0e3981-ef96-43fc-55c6-08de37227d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApxRs75NSbasNNmvT2wsXoZugCaROq4O5SP6Ma1jPesTAUsqsxmK82TdZg0S?=
 =?us-ascii?Q?PvONa1FXcrVENIv/NaWmMrdXnFKdSgmRVGSj2ZJFkModuGdI9U5B4t2lG7N9?=
 =?us-ascii?Q?LGonOzanMD/NUpZoHRE9kGT/98IgjPGmqE4ZMJkfGRE6waj7NO2vreYbNHbE?=
 =?us-ascii?Q?g84VtQd0WjthuecOmDeyoOdigou8HvFQEmdISb2+LAZncOIyaq9KG4h3h0mG?=
 =?us-ascii?Q?F1aUaQAZZJMj3VE2mLCreAtyxymCYazcm2g4jhMKA/M0+1lxBTFAQWBengy8?=
 =?us-ascii?Q?Lj67g23ue81cMJJT4cvrpN5ZHuvLbG1YIoWrcCTR8NkT9SESA/dOmgyB+nLW?=
 =?us-ascii?Q?/rAH3TOsaq1QoKfxulkWXYaUD916YduH+/qC2UxEjlqAfKhxnV6WklH6ERUt?=
 =?us-ascii?Q?Og4X3TF4FosBDMbC93pwGawl2/5uZkUeV/T7+3cVJWVb84/5SQhOGYuBnEl/?=
 =?us-ascii?Q?fQXFRSNUzE1JRb4KK/66cPXTdZX/bbNpIxM0I//n2ve6goGkeiZ2Qn738qgH?=
 =?us-ascii?Q?9kX25MWnigwFcyuAnNICSfTjRUgTjprz4UkX+CgSEkMgyONMyIIMuTd4I2CT?=
 =?us-ascii?Q?W1EUFoEUmLccTQ2xGwTAkmkOBlNz6IV96VxYsLjbGUWFnwkUb7vC87GoqtNa?=
 =?us-ascii?Q?4W83iEHPkF9yFVThKKYoCZ8ArEO/IWciKZVkkf1Doy/YUzHbft1AJt/NOnC0?=
 =?us-ascii?Q?V5HAuBchSyyCIrW8taBiZ5QakigTJUepc4/T/p/AIQNa3OrMzv6KFNfiQdty?=
 =?us-ascii?Q?nC0mMwAFXX1mF4Kv9Esbf7AerqoBlbcghQ/Az9tE4wgGuEDnkRZgE01yntvE?=
 =?us-ascii?Q?tdQUmhtMXzHiRvKQQj/IDm5Jy0fvHP/QwQmCx739fhYThaO7w8KCSr9VAGs8?=
 =?us-ascii?Q?nnFGdIWPY7FbUtpasZIz5xEkOy0h1m3Fp9wsfFaFBWsZ3YnjLrJqqirPppKk?=
 =?us-ascii?Q?L38dAycQ+xDd5k6k87bRK8E6LZQ4LXzoYidHVz2g8jSEX1iw/9bZ89FlrKpB?=
 =?us-ascii?Q?HnCFn/NhO7Oh4nUYz6gMc9IgTksT8wD7PHkIektCrGu1SIoytzSuucyg2f//?=
 =?us-ascii?Q?SImr8TH6R+qJc/1xQ11TkXJVDyvgwzMWgmkZ8bCoSPgpvXuztfnnBkEXOsAK?=
 =?us-ascii?Q?yIOnahEiUSpFgCFX1tCghTCA5FuJnah3re6WqUjS2ifDrJi2PPzM8ihzugiY?=
 =?us-ascii?Q?3DtulaCvRbkF0GXEPRfPDoTJgOt/t6nX8CNEuZ086BFfgoClaJTftsmJQlol?=
 =?us-ascii?Q?jfz9xvzIk95kDG4kbbrMHsmeqGiKBFs4lHY214E5FeeFc0i+HXj3Av1nMaP6?=
 =?us-ascii?Q?B0SFXW2b6toRZU/6QO6GHWYKdHTdiKaZA2V8wI05xZXpGOgw3L00CDuW67VP?=
 =?us-ascii?Q?dFRk2TRThf6yRgbR1dj8EFC3WCOckWj+d3pfaTNCZwGZoXIBqEqtjB+hUneE?=
 =?us-ascii?Q?6tq4CEqdXo6fRhBXJ4HwGQBw9YgRj27nroLylMilnV964HM9tDXRl83MFk7P?=
 =?us-ascii?Q?1xZqvYxUmFyw8wsNfiEFhPfxlSBUUJMdRKV+r8NpWo/6q0NN2b64vay2J0Xy?=
 =?us-ascii?Q?JwygKdl+xtLzkIoj2vJJMnit96gE1JIvBe0yTzSG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:57:20.2594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0e3981-ef96-43fc-55c6-08de37227d54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

During channel reconfiguration (e.g., ethtool private flags changes),
the driver can trigger a kernel BUG_ON in dql_completed() with the error
"kernel BUG at lib/dynamic_queue_limits.c:99".

The issue occurs in the following sequence:

During mlx5e_safe_switch_params(), old channels are deactivated via
mlx5e_deactivate_txqsq(). New channels are created and activated, taking
ownership of the netdev_queues and their BQL state.

When old channels are closed via mlx5e_close_txqsq(), there may be
pending TX descriptors (sq->cc != sq->pc) that were in-flight during the
deactivation.

mlx5e_free_txqsq_descs() frees these pending descriptors and attempts to
complete them via netdev_tx_completed_queue().

However, the BQL state (dql->num_queued and dql->num_completed) have
been reset in mlx5e_activate_txqsq and belong to the new queue owner,
leading to dql->num_queued - dql->num_completed < nbytes.

This triggers BUG_ON(count > num_queued - num_completed) in
dql_completed().

Fixes: 3b88a535a8e1 ("net/mlx5e: Defer channels closure to reduce interface down time")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 14884b9ea7f3..a01ee656a1e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -939,7 +939,11 @@ void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq)
 	sq->dma_fifo_cc = dma_fifo_cc;
 	sq->cc = sqcc;
 
-	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
+	/* Do not update BQL for TXQs that got replaced by new active ones, as
+	 * netdev_tx_reset_queue() is called for them in mlx5e_activate_txqsq().
+	 */
+	if (sq == sq->priv->txq2sq[sq->txq_ix])
+		netdev_tx_completed_queue(sq->txq, npkts, nbytes);
 }
 
 #ifdef CONFIG_MLX5_CORE_IPOIB
-- 
2.31.1


