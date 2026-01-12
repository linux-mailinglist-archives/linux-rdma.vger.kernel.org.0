Return-Path: <linux-rdma+bounces-15461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61BD12BED
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 14:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BF92301595B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC14358D09;
	Mon, 12 Jan 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NR3OfM0M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B0358D2F;
	Mon, 12 Jan 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224185; cv=fail; b=QFT4Jn2kWHwVkxQ+uiyXxH8dnMDrEgOu2+vdifeVS/75/eVYqwjMyI46wuZmI3quVU7LcGEGrVBNo+vk222UEx7lA+AHQx62+qX5JRLbZoT2ovdg0edNp20oVQyM2HqKTnLYlXsKd01mLim/uFCHx8cHgtRi9mREdHho4RdpHSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224185; c=relaxed/simple;
	bh=zs1Y/N4QT66MKIHuekBBWCz9BoUM9p8dEUiBFXRm/8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuxrPPV8UlVxlEF+7XhYM8EDh7voXdA4x1rZBxIREGf32QC1MHJymGJNUZrBuuLwelxqQ15t5WJKCa36N65F41O3nN6UnlvLVdDqxB9VwO0/dZZHy8OWfJd2pdMjbFEKK0dWq0RzqFJ+pXmzW5LR4nerTZCeEjSPXR9WrM2IRo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NR3OfM0M; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xerUIhuPtOnJDUBEYFnk/3UZ2MQEWOr7CJM/44pMuKYbHtdrQmBlM+Q+dSJij4c6X9YRrTgKjk6OsNEknd40Fg2RTOg12i1mutF5wEWs9oBzLJoA8r+O26HFSNYvG/fWRt9eDWoLxtug9T0o+utuJNv14X0M93dy8svS/WjqgTe+0LpDsoO35G14ucyAwgds0/zKppjbZJ5BrDUIAmP7qAgd14JF58jvac5qnKZvljFUd/o8jbxY0uEn/4vBySJ0BIg4zq+ynit4ZCBMoCauxysckMvJM320MF9bnUKbTZcXgjc4v64MAJoGkUqMZwxSznWwoIC9xamdKcOjAVFAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG3fWHz6UjuMH23PHaVMBoaHKibKpTpw2QsYLKujYu4=;
 b=mBqzJBpBDWBZbWxVrHF21AHaj2biGuHqwJ4LfQx4zvsDAwFJHkEa8RFRTIhEEh5OM6wO8JK8arQv52/pXrU3tD2uhfqU7Dm1IbXDP7eEfaeyilDCWvXD31IKXphkQPvk/5hfG9tz32qj/NN1QVL/hfpxxCbN0m8r0eusOS8u+Ora2swaVNOgKwd0z/fycrVtnZQuTkiXG63nJeeJx17IHKCqxlWgmkQvbA//AnxeswJdQpNkkigG5kX1p/zU1XlZRk6Cs73FjQjjz+z4lKARxINMwgGGZsC9EmLhU7FiKTCaWN8l7WB4mDMEY/4DQxx6Yd0K0DdMGIQQe6icBSS6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG3fWHz6UjuMH23PHaVMBoaHKibKpTpw2QsYLKujYu4=;
 b=NR3OfM0M3OyHkdtM9lRuJCqHO32uzXGdEZa8krVyVnHi+h7zfA3Clw8xre/Go5jdFGLj9xOuGSjQSTm1+Oh+RRdZpcFyFrhaSySVg1I0KbLvRR2mwxWlmpTOfyH4QOZYgGuEHUVwA32bs1IugYO8Z0uxNpjwnPArArpMfIRdTU/04b/cxf8O8CNykAyp5a8H5KKNKMaVKGc/YNLK8uUyMx1oGKRZlN1a6VuUWHzz3R9WmCiL1ciJ874os57H6b9b03QRIXWmSIpg/xD17xQQqw1NNMz04xHq8HPAI5b+ROiOdMUTjZoQnFax5Y88fArexCeTV3J4abG8iCplJ0RvOA==
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:22:57 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::13) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Mon,
 12 Jan 2026 13:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:22:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:22:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:22:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 05:22:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5e: RX, Drop oversized packets in non-linear mode
Date: Mon, 12 Jan 2026 15:22:07 +0200
Message-ID: <1768224129-1600265-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
References: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e26ff4-02b1-4298-927f-08de51ddb31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7T81ldBFV5HwkpeK4VznKhmsPU2yN7GSHmrJ3H2fDjKGdNgu63xfJ36VywA?=
 =?us-ascii?Q?0qwETS61rP2wIWfgI+EWJegafoTXbPuNAB6q4dq3Lv9QD21wZMZmf7JaHLKv?=
 =?us-ascii?Q?8WpLSSzVLfZ1A76YWwZYTXaL4Iumd3l4DDuUty6pQgYlAeW/UnUocib7u5Wn?=
 =?us-ascii?Q?HqCiFl2+MU2Vky8pP22yLxRF6P8AmmeCfJpBTZ1fMPRfMpDCjT1kT+g7BR50?=
 =?us-ascii?Q?rX4J1orlw3aKvC4xfgC7kCiC72g1QnZGYGytm+rWIA3jEiHZDo/r/wek7UlH?=
 =?us-ascii?Q?89V6dEfIYINjAbYsGeeLpjtGj46Q+PeTo9OWDLOwFXiycVy0c/8lx+rtSFUQ?=
 =?us-ascii?Q?D2TNqReuCaT18YmEpGkK8vLPynrHRGiNghGcwnut+EkAh3MWJwVshEyZRmZE?=
 =?us-ascii?Q?Svcif90LtQ7Hq03MmR6KfZ2/3GzNoCrJoFzSvD3ZWtbD5uecVTVZrQ4fmHyw?=
 =?us-ascii?Q?4fpgcucRSoI+eXDGBUWevuHbi/4N2JLA+felBnXj7ODic1BzRjGE/hdaYE1c?=
 =?us-ascii?Q?002asznZpEf4MpMC2YTt0jQGmgPby0rZgBto9WJHddZ9fgcaN6fs8YH7o0Jm?=
 =?us-ascii?Q?pnjoQCXHEsuQ5Q2NWjZQncOX1yLsh1/7FhZTkAXhaeoxwjWB3XiPEbfsp1CK?=
 =?us-ascii?Q?S6Xp+R/wfpb5fDeUhKUNle//cSFw/4MiJrVj1/YE/PQxoaipZvYQzTCvMS+5?=
 =?us-ascii?Q?k4jBHGXFQnx3QDvi1vciyFIxMQzaeEfGOFY/b872kCbLP91adi/Ehz23D7DJ?=
 =?us-ascii?Q?5JWsrVSAG16jyNJ5sIwXFpPFVaXl0oG3qKzqo/jaC9l30KCkQEBxiHOcEG5k?=
 =?us-ascii?Q?ra6MRo1W2ENPSmAGzXIDoN3j7bX67jB3r4zGu6HAXX5HKKajTZVzZnTKkJ9Q?=
 =?us-ascii?Q?M6SemqrlIWDtvtZdq9otwZe6T8eAlHuVT3LNYqojXHBmHpOuUYP98LWKKAbb?=
 =?us-ascii?Q?keKLhJB6pgC3uVWF/SS3Ofp5wztmwgP08ruxnVuHrvl7jJP8rZcZPSzrLdM2?=
 =?us-ascii?Q?ddP7RJjv22i6evBlNKCwdWrF5X+ilsO7GE7bSyuZ1Mb67zL1u7L7GfGIAogy?=
 =?us-ascii?Q?LtzzyWuMMLAFm81GIRe0w6eHkWHBulKcwyIdjPIo2A7OabYv1jzuZ8g64kd8?=
 =?us-ascii?Q?g/S3d3vkpAvUKowhLRibUdGWB3KWzGY9AnsgNseMq5OfzMEI2m4eMNKk4jSz?=
 =?us-ascii?Q?H1pPiH0EKUYf0tac904ay+ZCKySw+5VBB70hfnuqdbkW+K01JDc1Z1CGGUme?=
 =?us-ascii?Q?XIJRw6oyWcfiTTeLPhv//2K74TyqLRUTMhuum0QNfeViEazBy39wNNwf5MUI?=
 =?us-ascii?Q?uqUxE354DV/6ghPSl7CT/y1bJ48tT7Ipyq/94ndWhWCEBa2L01u1OKr0J752?=
 =?us-ascii?Q?YfKxInHBvWqzQ8HtmbI5/2lx4lBDBP5NOqN+iN9Dfk3sHDrtUQcC/uiUmNiJ?=
 =?us-ascii?Q?XBFMP54c6zMadyQKfruvFKNbHH4lETI7rgBkgBG37AHFg7ApZ9Wim+5hfJea?=
 =?us-ascii?Q?LapVQr3ui0773yEc01ZH61ZL0pUoFJw8NF6jchZ8SiCcvqc8OhzWkFeMUE+7?=
 =?us-ascii?Q?Cs4zIvTJQ+9tnYAlMR0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:22:56.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e26ff4-02b1-4298-927f-08de51ddb31c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently the driver has an inconsistent behaviour between modes when it
comes to oversized packets that are not dropped through the physical MTU
check in HW. This can happen for Multi Host configurations where each
port has a different MTU.

Current behavior:

1) Striding RQ in linear mode drops the packet in SW and counts it
   with oversize_pkts_sw_drop.

2) Striding RQ in non-linear mode allows it like a normal packet.

3) Legacy RQ can't receive oversized packets by design:
   the RX WQE uses MTU sized packet buffers.

This inconsistency is not a violation of the netdev policy [1]
but it is better to be consistent across modes.

This patch aligns (2) with (1) and (3). One exception is added for
LRO: don't drop the oversized packet if it is an LRO packet.

As now rq->hw_mtu always needs to be updated during the MTU change flow,
drop the reset avoidance optimization from mlx5e_change_mtu().

Extract the CQE LRO segments reading into a helper function as it
is used twice now.

[1] Documentation/networking/netdevices.rst#L205

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 ++-----------------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 11 +++++++-
 include/linux/mlx5/device.h                   |  6 +++++
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3ac47df83ac8..136fa8f05607 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4664,7 +4664,6 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_params new_params;
 	struct mlx5e_params *params;
-	bool reset = true;
 	int err = 0;
 
 	mutex_lock(&priv->state_lock);
@@ -4690,28 +4689,8 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 		goto out;
 	}
 
-	if (params->packet_merge.type == MLX5E_PACKET_MERGE_LRO)
-		reset = false;
-
-	if (params->rq_wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ &&
-	    params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO) {
-		bool is_linear_old = mlx5e_rx_mpwqe_is_linear_skb(priv->mdev, params, NULL);
-		bool is_linear_new = mlx5e_rx_mpwqe_is_linear_skb(priv->mdev,
-								  &new_params, NULL);
-		u8 sz_old = mlx5e_mpwqe_get_log_rq_size(priv->mdev, params, NULL);
-		u8 sz_new = mlx5e_mpwqe_get_log_rq_size(priv->mdev, &new_params, NULL);
-
-		/* Always reset in linear mode - hw_mtu is used in data path.
-		 * Check that the mode was non-linear and didn't change.
-		 * If XSK is active, XSK RQs are linear.
-		 * Reset if the RQ size changed, even if it's non-linear.
-		 */
-		if (!is_linear_old && !is_linear_new && !priv->xsk.refcnt &&
-		    sz_old == sz_new)
-			reset = false;
-	}
-
-	err = mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, reset);
+	err = mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL,
+				       true);
 
 out:
 	WRITE_ONCE(netdev->mtu, params->sw_mtu);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1f6930c77437..57e20beb05dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1570,7 +1570,7 @@ static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
 {
-	u8 lro_num_seg = be32_to_cpu(cqe->srqn) >> 24;
+	u8 lro_num_seg = get_cqe_lro_num_seg(cqe);
 	struct mlx5e_rq_stats *stats = rq->stats;
 	struct net_device *netdev = rq->netdev;
 
@@ -2054,6 +2054,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u16 linear_hr;
 	void *va;
 
+	if (unlikely(cqe_bcnt > rq->hw_mtu)) {
+		u8 lro_num_seg = get_cqe_lro_num_seg(cqe);
+
+		if (lro_num_seg <= 1) {
+			rq->stats->oversize_pkts_sw_drop++;
+			return NULL;
+		}
+	}
+
 	prog = rcu_dereference(rq->xdp_prog);
 
 	if (prog) {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7f46a8fbfa1..6e08092a8e35 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -962,6 +962,12 @@ static inline u16 get_cqe_flow_tag(struct mlx5_cqe64 *cqe)
 	return be32_to_cpu(cqe->sop_drop_qpn) & 0xFFF;
 }
 
+
+static inline u8 get_cqe_lro_num_seg(struct mlx5_cqe64 *cqe)
+{
+	return be32_to_cpu(cqe->srqn) >> 24;
+}
+
 #define MLX5_MPWQE_LOG_NUM_STRIDES_EXT_BASE	3
 #define MLX5_MPWQE_LOG_NUM_STRIDES_BASE		9
 #define MLX5_MPWQE_LOG_NUM_STRIDES_MAX		16
-- 
2.31.1


