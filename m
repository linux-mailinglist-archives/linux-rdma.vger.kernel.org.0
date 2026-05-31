Return-Path: <linux-rdma+bounces-21553-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBIHOvEfHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21553-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:48:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D5E615DEE
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595B530AC0AD
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A363859F4;
	Sun, 31 May 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RtMzGx20"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E32384CE3;
	Sun, 31 May 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227679; cv=fail; b=JXh+VhSy3g3gVRt0VE/8V31tx2kmzLP5EO5HveMqE0OMjMlp87uUKpwrF3wDgz6ocdyt2+1aNUHvG8NIx6FZEugg8w74Bb2V6FCn1OuFcfl5JwSib+tWqe2THbzFsrkD0rB+flJL42PWx7dIhE8JPF4N2++cGRJT1rjAoiIdlSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227679; c=relaxed/simple;
	bh=DBFy0emQdt6LTTJfxIzblGktGuoVIkE/QfqEJY71KDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JagI6BhV0mMk7+bbrm+0vf1Fkw0KP7eyMcUJej2G2pHzrXGLrWiUtYKBgm77W2sMyO+dGvkpx/cFuHrXU48QBwgku2l/ry73idj8GDhTpVS7UaToLHhlcDzuJMga+8kKkt259ahKhk8dwnJFiWnA73swPoD7qwVv3WKk+zy4u+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RtMzGx20; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1cyK3qEtIJnBo+Y8ZeFbuj8j8GkCwFEI5DDhusSCkIEK9iJJcJj64zyKQK37MNkoJLiDyd9rNbFT5Mx9/a+mKDYGaeL2BY990Rj33gpYugYT/fL3AlW8CNi4vUVHvGp2J76OnjLRtPVLTCTK4SrxJLSTOtrNzWiUupqOjLEvf0Tr8B+Kcq3+lfWsdbnrwPjoyAcDS/ks2sssDH3q/409klI4g3+6Vr/qCfWmIaB5YH2VFGy2WrCVl/l7UsbCY1xcntyvMhhdw3V0DqOHOZkwtadMW021UpEy/m6V5jTZ4IszSHFZ2JuIwvaRHK23n7g6CdhUWMicp7VQxYhwkmIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi9divZH6dVIU9Q2bKhYm7skW80niwvxqnoML9x7Mz8=;
 b=ABv/hNqNO6+ty+/YLiRfXF9zSEOMvWGovVxos8BoHHzXcjuBNloilpb4n4XUXXL/2AAtcwVT32vvwZCz8p6dUgAlsoETJswoGpufE0yu5VTygRNtUNvT5I6gtLIyQoEAIYFTO0/59x+Izxa5ty7zanubX5Vk9Q9y81WDRTCzn0KQnOTngv51iNsIluo5rVlODXDQFGDwEMVfgYNk0csbBrCYaab3F6VZk+H4pQadV1v0s4Zg+4NX8qcgv+CmHZeyF45o6j7Wa4CCgIAwHUEbHvLceuHVW9ka/r06HQCuZYOVsxCOZDFvIDKRepfzBK1wasJCCRsLQCWb8WINUtVjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi9divZH6dVIU9Q2bKhYm7skW80niwvxqnoML9x7Mz8=;
 b=RtMzGx20zII/LByq0JWzxWD1YgbNVI63/RMw0kEMw8NmC8PAJur9y34B1Vfak3ybfORL1uQBZ2yBVeRlFRZB77/OL0Gj6yLHCN+77gUx++FYSfUrLPqiRLzhm9ovIu4J7SCF0isdD1rGNsJrOQXV7ezxsn8lXn0DhVdeVVayEQNc7romuwLCzC0azDeVTd1NwUOg+BFWO0xPensm/u+7JgOPPH+LfEk6C1Yl+DFt87nuZS6pO/HrN69vJZzv/0W2WvQ6RAkid/qv+CI/3puX3bMIcleAT1xNSkL/9U/9/avDat8oqks/koD/6vxioUhq+GQzUXxRHXOI2vXukKBkew==
Received: from CH5PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610:1f0::6)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 11:41:12 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1f0:cafe::16) by CH5PR05CA0005.outlook.office365.com
 (2603:10b6:610:1f0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Sun, 31
 May 2026 11:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Sun, 31 May 2026 11:41:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:41:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:41:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:41:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 11/13] net/mlx5e: TC, track peer flow slots with bitmap
Date: Sun, 31 May 2026 14:39:51 +0300
Message-ID: <20260531113954.395443-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: aefac012-fae2-4a46-4553-08debf09842b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	cWdbGKUHEpBd2DhRhtNFm0BJE7ewuUHENWaM1jYM6IiQl7LwC4ysuY6xP5g6co00vmRT8Lo2wgWQOk5idvNbOha5R9DZ1XvGp4rWZB0PNeBZfme6ExMRAEpv1SbFR/DxG3rtZnT3pRI2bK+9jxHq94gu96abCTK9XRrqBrlZQvhnPJGekbG4ZgwhbJKR5Yamz1OJ8GpSoaHpKwCZ52ovjGG7A3Pczpkq6+4CkqSfaCwrAKv/QB+AoscqYHio9FWHf1jHZHwxouA6ZNuplZG9VdJah0F2WXeuKR7sqWlmIXzKxEmiJUOvnlQMuNYdibexwXRpeI26OAT7Xx15oTR6B5LeMcJbmdDghbxha5Ms3gFQtb9elRjFt6j/IDCKLvyt/NmMk9FIrTnmxiKI3lJAl5oFEW5JaCQlURq8Y/2eh/AlZhOPI88Xp5hIOkzDv0OgbPaLguBikr0iq0/gdazp3HWlaMQSaVz9uOm1I7QvgYibA9TmEg7LEAKoWIuN/l8vP4dA8FXrG7o/nKjSjAclqNfNBliHjtnv3LEbSQibN29vmW5gGDd0UF2e8mmcad+1aU6ab7PgD9BV4Jt+0RW+jXEbf3hGGWo+nfnB93vJLBmgLtUW2coj5/jj9Z2TEOePhpfR7xSMLxN1CRvR+ppaoaIfe57HkTzAmoiWUQUeNxuGW5TrLVpyhdvmwIXMv8dD9QkqKsZidwb1Qaaj+IxQB2BJFuo/A7n/MRNksbf1jx0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U7kSvDgTIUaBu/hdr0jWBC+2jwMHOaTBrWkF0nX+vY3HzEsgX7FvlqhdyypGTXpOSAnPFSuS2DXzZJMi+jiPqQCEpjcLEKm1/7prX6pGVyqWIzOPbKPVQwIQJUsu/kg4Wt0SlrcjBFcvlzZfgmZxdEIr5fZp/jeligPqS27+fagfmUYyCVxdOm7iZxziGyXhr2/vfmiw89Z0EE8YPbZ58W9d4OkreoHl2tTZHgXaDL/Z3totpKdnic0pawWlkPoTtok3kX/inDJeEbs/DUqakxXaXPmxylErMCeCBN0t61J+QDLHpAIcf1WMZtdEP+D9e7+xZlwxNcp0yf28LElOnwTuk1dos9y+f0y08yE0jrVnhrQMnSLuLnCHwPF1CmzKsvymiG+WlgBwGnMZCEx7kfmk6bG/mayY8TrEOzcuuNx7kK1lxMdivKI9IeIdRd3b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:41:12.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aefac012-fae2-4a46-4553-08debf09842b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21553-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 83D5E615DEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

With SD devices joining the LAG, peer flows are not created for all
devcom peers - SD devices skip peers that belong to a different SD
group. However, the delete path iterated all devcom peers
unconditionally, attempting to delete from slots that were never
populated.

Track which peer slots are populated using a bitmap in mlx5e_tc_flow.
The delete path now iterates only set bits, matching exactly the slots
that were set up during flow creation.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c      | 10 +++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
index efb34de4cb7a..a0434ceebe69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
@@ -97,6 +97,9 @@ struct mlx5e_tc_flow {
 	struct mlx5e_hairpin_entry *hpe; /* attached hairpin instance */
 	struct list_head hairpin; /* flows sharing the same hairpin */
 	struct list_head peer[MLX5_MAX_PORTS];    /* flows with peer flow */
+	DECLARE_BITMAP(peer_used, MLX5_MAX_PORTS); /* tracks populated peer
+						    * slots
+						    */
 	struct list_head unready; /* flows not ready to be offloaded (e.g
 				   * due to missing route)
 				   */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 3846c16c3138..2a16368a948e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2128,6 +2128,7 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 
 	mutex_lock(&esw->offloads.peer_mutex);
 	list_del(&flow->peer[peer_index]);
+	clear_bit(peer_index, flow->peer_used);
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 	list_for_each_entry_safe(peer_flow, tmp, &flow->peer_flows, peer_flows) {
@@ -2147,16 +2148,10 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 
 static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
 {
-	struct mlx5_devcom_comp_dev *devcom;
-	struct mlx5_devcom_comp_dev *pos;
-	struct mlx5_eswitch *peer_esw;
 	int i;
 
-	devcom = flow->priv->mdev->priv.eswitch->devcom;
-	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
-		i = mlx5_lag_get_dev_seq(peer_esw->dev);
+	for_each_set_bit(i, flow->peer_used, MLX5_MAX_PORTS)
 		mlx5e_tc_del_fdb_peer_flow(flow, i);
-	}
 }
 
 static void mlx5e_tc_del_flow(struct mlx5e_priv *priv,
@@ -4618,6 +4613,7 @@ static int mlx5e_tc_add_fdb_peer_flow(struct flow_cls_offload *f,
 	flow_flag_set(flow, DUP);
 	mutex_lock(&esw->offloads.peer_mutex);
 	list_add_tail(&flow->peer[i], &esw->offloads.peer_flows[i]);
+	set_bit(i, flow->peer_used);
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 out:
-- 
2.44.0


