Return-Path: <linux-rdma+bounces-12258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D4B08C79
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555FB5A01DB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E32BD00C;
	Thu, 17 Jul 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qD9iS2eg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430A29E10A;
	Thu, 17 Jul 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754006; cv=fail; b=pLbdwWu2bbecfwTN828pR05iqPzpJKayr4QPMfFNS2uz/hWaYMG9UzvxO77ccLL5rbX1q4jJclLPvafNya8trJ3m8vcTgd8ijLv5Z09/bfRyEozlupjA0biMhAOuvFuWopWzq4Uike6HNHDoRZMLd1RM6RY73VsK7+lY6HqcoC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754006; c=relaxed/simple;
	bh=4yp9+QUM7QP28Rf0yMEY5CSW/XCXByRRk4nRR5/Epyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1HnLmVHE0iEgMnU3wV4D8zaWA4nfbPzg6lE+eilqUfIirp/W0SSOQ5MVSTZCZiUneuRCwyFRDFeSakoXNYiPgq8oEWVpd7p0f4jzULn1XPKJnLd80DhvZlrcyq2QzSx924Q4CsgIXUaQSy8uOl+j7ZSfMhB8hS1X0Z6RMUglXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qD9iS2eg; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTx6rr4FQCKaU4Z53kQN33rP9m4uGoE0wk9NAbEQsRrTqPKZGwDF1q+JWabXzZVztVPiyslNcDDH8unjPPXSe72lU23KeAm/PqD+rPcf22Yb16HZhzoLysBg/1aEtpZW1OiA+gLswhEBYJkih0WRjzCWzOiH7LD6Dov4AsGalDHoMfs9+PFTjF30qMn9G8pEec8pb/gbf64PCRPmIp3HT+oHG+DmqoiDk2Rc4KvYnFDI3C0XryZtCvMeeJOktKAxMkAxqto+m5w8RVyVAFouDoNlzBUNZkqjNcW6GufOeW3RocwHzE2mAlK7t51nobrKWu/n3MNI5k3GdVASfJMS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3oS/mq9Np/h0e/x75bE3JEVo/WfqspF/rW5SJh5i0I=;
 b=kW4bHS9cqNREbXLe9spykGm2x2dHkKvfCzBLZpTKrgdT+WJ3HERti3UTLJaamggpw5dr8UPzPE0emBpaT67rthOZZBwEd4P3JB4B77E+oWPDoLyD8jX4Eg8vN7AeUQ5IKmUGJbfrl+Y58swRG5jEBFPbgPuvuZQxY5eiZV/s6qpbDZsNaHcGC59KAkwJYO5CuC5ukkiyVIxBx2k4fEzOnz04B0Cw36GAd2etN1x89Bevj56RxSc2ltqDju17pPS6hagr/T1JwrkqYxwB9XaXeVbthu06GEdf4Uqo12iVto3O68iAv4l1IBT1+8N6wPpCBfGFN/GxkPQFenQgLgEmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3oS/mq9Np/h0e/x75bE3JEVo/WfqspF/rW5SJh5i0I=;
 b=qD9iS2egOIB/sXcpX9G9g56taYCpj6ADnfFBfK7PMsSP92isJHw9NdG4imWNcgD3Gvo77VJsW4WF2iMpOuwnH+MvEciHs2Asatrmhj925zXK+2VriycH+8F4y14ryKHRR7dOhsj9zV2Ab8ZbB9Jo+jLA6JAJ7VsGTcFLM1vHe5TKtoox9OlGDSPZaTc4ASuDbknHQjJbgt478is57/Dwm9mF6oasNArRIfV9TWa/HQQO67gkcoDOhstOtuCj4W5CB8ewFxZCfdCXQthyNKriANmJB4eVhv8+rM9b7Xm+AjEafxvBcGtFxCM3f0q0HkXXaqHzlV8FesxBhmykgo8BLg==
Received: from BYAPR06CA0045.namprd06.prod.outlook.com (2603:10b6:a03:14b::22)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 12:06:41 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::49) by BYAPR06CA0045.outlook.office365.com
 (2603:10b6:a03:14b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 12:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 12:06:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 05:06:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Jul 2025 05:06:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 05:06:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch
Date: Thu, 17 Jul 2025 15:06:10 +0300
Message-ID: <1752753970-261832-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
References: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0566cd-5159-43b0-7087-08ddc52a6409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hA4EBnuUix9p4VNcVNvxn+tnUElVEPuahjTOheTazjEx5WK6LUSY2Qc0uJ08?=
 =?us-ascii?Q?+bIjVvUtFwhDe4SEML7Ch9Yy3xULmWgoarYOZQqoBEx7TiN80zL3OUVDnDmr?=
 =?us-ascii?Q?4tgdoSjUiWGcyJ43L+f4ZWeX4QjYd93mqHjAMA7I3TnewW09YUZ0q42lksZr?=
 =?us-ascii?Q?aAV/uj2nD8CTqv29PcsiOUArJEsAXmPmwg2Ox46j/pgJp2+hSIdCqbrTfuA6?=
 =?us-ascii?Q?MvdtmUPwbZ/TTeDj6ni3ItaKgLxyghB2pqTO+9uq8Mv87zQj9ImgAYYlNUSy?=
 =?us-ascii?Q?2Zl4l2BHVkJhAEBm7ZPyIMSOmEOm6p/Tcdfa/N2dlV47PdV2AGHNrb3bhcok?=
 =?us-ascii?Q?GkTPFzl2kVhner9nRqPkc1jEBYk3WT6yRzXHIg7x09uhupaBDD4UKyuE+NBC?=
 =?us-ascii?Q?TS4gmpPndb6t/jx3ytqQWjtebRSI9yo0ryPuGaN0YT6lby2tgmz+8meydflY?=
 =?us-ascii?Q?OdNpDehAxZZy6zvPR3wa7zOc67m7QH9qG6pbaQTu+MLFYYgXW3UtRjVPTkyS?=
 =?us-ascii?Q?dAoXSczx1muY08zMhNRYygDeTlZgt0UrtxD72O5t2iTmmjStZsWk+lCRDQhv?=
 =?us-ascii?Q?rXFqdCzmbw6BH21SCB5QcrGzLObTtz8sVixMEzfPZRWg/vx0IztkRrV1qdp5?=
 =?us-ascii?Q?07kq8SBP8Q32aeSJobRA0gTxN9HCTI86PNzRhgX1H5dghvCKsOmv9hzlietW?=
 =?us-ascii?Q?blTZlLtQ2PK7y1VOSBr3BviHByh1fgP4ldVx9Kb+3kfef2qbRxoVynsL4QmG?=
 =?us-ascii?Q?2Fi2StDkxKqhtdfp59vvZ+OzB7A8pWppspqpGOY014aTxWAZ+9AkfuKz/fPM?=
 =?us-ascii?Q?5Ipf9O3FGDKGjBb6CYxQAsVqdIoQf+BzsQDidzfGvHdkvtOaBxhn+C1drJ9F?=
 =?us-ascii?Q?Yu62PwlrZK/g8cvQE5d0ZynkLcbjuBuZty9lDcqJNdj2DrLXbAMr6sUbwYj+?=
 =?us-ascii?Q?tfe1PGhhh1Zl4NEE+8QuhMHuCSafop3NVmIxXmQa99K4Q6EvFCnLqXlKdG+L?=
 =?us-ascii?Q?n/oBfPYiP9qXYGRa9rUsLDWdBfDa7nWb/d5rGpc4j8fcZ8NLxpQ1NBA5wQUo?=
 =?us-ascii?Q?eC66HX/Hc0gdqUq2mC4te+gXfej5u52f0vMaVTKFOhVyepVux28l8N9qCWwJ?=
 =?us-ascii?Q?8e/l1CyT0OYMEkhDaM/2Le+eqvWFZUpslvCM8cJiKiDz2MCjnpmQYYovAqw6?=
 =?us-ascii?Q?IiqFDmJXh3rncSi4Tc2/Ptl5rjklNODvG/unfvSBzf2MnFZD70UAgTL1H0J5?=
 =?us-ascii?Q?h3obrE5C52KHQ+SbyFOvgLW2QV54EsN/0H/2lc+iBtgh8fjapXcz5wCePqqT?=
 =?us-ascii?Q?WPUZ/5dKdy6E1IUtZIxkJOsB8Ap+2wuAd6jX+KGTNz8EAWKeGBqIsTB+GwU8?=
 =?us-ascii?Q?BgBlWoc9TKkY4o5WGEmm3Lj9Q/qhbyJb+3Qn4IMtCX4X500fIga4n04huUW1?=
 =?us-ascii?Q?49vFdZPa7cMC1XfX/g31f9VZ4a2psEi9n6IyK8jMmoOAx15qZU5a3L547ReI?=
 =?us-ascii?Q?UAqUptKx++6zaDOfCU2mBDZg04l5fVDOIKlN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:06:41.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0566cd-5159-43b0-7087-08ddc52a6409
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

From: Shahar Shitrit <shshitrit@nvidia.com>

In the original design, it is assumed local and peer eswitches have the
same number of vfs. However, in new firmware, local and peer eswitches
can have different number of vfs configured by mlxconfig.  In such
configuration, it is incorrect to derive the number of vfs from the
local device's eswitch.

Fix this by updating the peer miss rules add and delete functions to use
the peer device's eswitch and vf count instead of the local device's
information, ensuring correct behavior regardless of vf configuration
differences.

Fixes: ac004b832128 ("net/mlx5e: E-Switch, Add peer miss rules")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 108 +++++++++---------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 0e3a977d5332..bee906661282 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1182,19 +1182,19 @@ static void esw_set_peer_miss_rule_source_port(struct mlx5_eswitch *esw,
 static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 				       struct mlx5_core_dev *peer_dev)
 {
+	struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_act flow_act = {0};
 	struct mlx5_flow_handle **flows;
-	/* total vports is the same for both e-switches */
-	int nvports = esw->total_vports;
 	struct mlx5_flow_handle *flow;
+	struct mlx5_vport *peer_vport;
 	struct mlx5_flow_spec *spec;
-	struct mlx5_vport *vport;
 	int err, pfindex;
 	unsigned long i;
 	void *misc;
 
-	if (!MLX5_VPORT_MANAGER(esw->dev) && !mlx5_core_is_ecpf_esw_manager(esw->dev))
+	if (!MLX5_VPORT_MANAGER(peer_dev) &&
+	    !mlx5_core_is_ecpf_esw_manager(peer_dev))
 		return 0;
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
@@ -1203,7 +1203,7 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 
 	peer_miss_rules_setup(esw, peer_dev, spec, &dest);
 
-	flows = kvcalloc(nvports, sizeof(*flows), GFP_KERNEL);
+	flows = kvcalloc(peer_esw->total_vports, sizeof(*flows), GFP_KERNEL);
 	if (!flows) {
 		err = -ENOMEM;
 		goto alloc_flows_err;
@@ -1213,10 +1213,10 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value,
 			    misc_parameters);
 
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
-		esw_set_peer_miss_rule_source_port(esw, peer_dev->priv.eswitch,
-						   spec, MLX5_VPORT_PF);
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		esw_set_peer_miss_rule_source_port(esw, peer_esw, spec,
+						   MLX5_VPORT_PF);
 
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1224,11 +1224,11 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			err = PTR_ERR(flow);
 			goto add_pf_flow_err;
 		}
-		flows[vport->index] = flow;
+		flows[peer_vport->index] = flow;
 	}
 
-	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_ECPF);
+	if (mlx5_ecpf_vport_exists(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
 		MLX5_SET(fte_match_set_misc, misc, source_port, MLX5_VPORT_ECPF);
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1236,13 +1236,14 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			err = PTR_ERR(flow);
 			goto add_ecpf_flow_err;
 		}
-		flows[vport->index] = flow;
+		flows[peer_vport->index] = flow;
 	}
 
-	mlx5_esw_for_each_vf_vport(esw, i, vport, mlx5_core_max_vfs(esw->dev)) {
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev)) {
 		esw_set_peer_miss_rule_source_port(esw,
-						   peer_dev->priv.eswitch,
-						   spec, vport->vport);
+						   peer_esw,
+						   spec, peer_vport->vport);
 
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1250,22 +1251,22 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			err = PTR_ERR(flow);
 			goto add_vf_flow_err;
 		}
-		flows[vport->index] = flow;
+		flows[peer_vport->index] = flow;
 	}
 
-	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-		mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
-			if (i >= mlx5_core_max_ec_vfs(peer_dev))
-				break;
-			esw_set_peer_miss_rule_source_port(esw, peer_dev->priv.eswitch,
-							   spec, vport->vport);
+	if (mlx5_core_ec_sriov_enabled(peer_dev)) {
+		mlx5_esw_for_each_ec_vf_vport(peer_esw, i, peer_vport,
+					      mlx5_core_max_ec_vfs(peer_dev)) {
+			esw_set_peer_miss_rule_source_port(esw, peer_esw,
+							   spec,
+							   peer_vport->vport);
 			flow = mlx5_add_flow_rules(esw->fdb_table.offloads.slow_fdb,
 						   spec, &flow_act, &dest, 1);
 			if (IS_ERR(flow)) {
 				err = PTR_ERR(flow);
 				goto add_ec_vf_flow_err;
 			}
-			flows[vport->index] = flow;
+			flows[peer_vport->index] = flow;
 		}
 	}
 
@@ -1282,25 +1283,27 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	return 0;
 
 add_ec_vf_flow_err:
-	mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
-		if (!flows[vport->index])
+	mlx5_esw_for_each_ec_vf_vport(peer_esw, i, peer_vport,
+				      mlx5_core_max_ec_vfs(peer_dev)) {
+		if (!flows[peer_vport->index])
 			continue;
-		mlx5_del_flow_rules(flows[vport->index]);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_vf_flow_err:
-	mlx5_esw_for_each_vf_vport(esw, i, vport, mlx5_core_max_vfs(esw->dev)) {
-		if (!flows[vport->index])
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev)) {
+		if (!flows[peer_vport->index])
 			continue;
-		mlx5_del_flow_rules(flows[vport->index]);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
-	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_ECPF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_ecpf_vport_exists(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_ecpf_flow_err:
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_pf_flow_err:
 	esw_warn(esw->dev, "FDB: Failed to add peer miss flow rule err %d\n", err);
@@ -1313,37 +1316,34 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 					struct mlx5_core_dev *peer_dev)
 {
+	struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
 	u16 peer_index = mlx5_get_dev_index(peer_dev);
 	struct mlx5_flow_handle **flows;
-	struct mlx5_vport *vport;
+	struct mlx5_vport *peer_vport;
 	unsigned long i;
 
 	flows = esw->fdb_table.offloads.peer_miss_rules[peer_index];
 	if (!flows)
 		return;
 
-	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-		mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
-			/* The flow for a particular vport could be NULL if the other ECPF
-			 * has fewer or no VFs enabled
-			 */
-			if (!flows[vport->index])
-				continue;
-			mlx5_del_flow_rules(flows[vport->index]);
-		}
+	if (mlx5_core_ec_sriov_enabled(peer_dev)) {
+		mlx5_esw_for_each_ec_vf_vport(peer_esw, i, peer_vport,
+					      mlx5_core_max_ec_vfs(peer_dev))
+			mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
-	mlx5_esw_for_each_vf_vport(esw, i, vport, mlx5_core_max_vfs(esw->dev))
-		mlx5_del_flow_rules(flows[vport->index]);
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev))
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 
-	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_ECPF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_ecpf_vport_exists(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
 	kvfree(flows);
-- 
2.31.1


