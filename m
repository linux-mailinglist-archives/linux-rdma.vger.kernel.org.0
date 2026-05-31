Return-Path: <linux-rdma+bounces-21555-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP4NLtseHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21555-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:43:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E0615D1F
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D64233024637
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C7386C05;
	Sun, 31 May 2026 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJE/LCkN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807138656D;
	Sun, 31 May 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227688; cv=fail; b=q6hiTqULCjU9TMAPHijj7PqgNdtG1UfTzZGwvmpsTrr5pCK6288HtPgTbyNJprMUkVj0zL6bBYvuqLUXX0KCOoroNBmoEJoka1zDQLu3KNdsdSKWgst09sAjFufjrSZ1kbcwTM4+2UkZnkV/c6dqs/rWg2f1tOep6oPuVxvykU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227688; c=relaxed/simple;
	bh=SZHJWt1fZe0cAzexP0NHAkbNJpxwJ60g9f35qvGkQg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZ9xHmt7vuEQKyGopoR8FVsrDNrtZ2+/W5szQHkCok57awz0JCWtZVU/IZ8bHRbsa7oA1we/jRyA68t5JVgEdpjxjidqluD03jXGXe9f+GqOlE4bHiB3I1YC4xr/19mdQIBfgAN0+bw70vz2CjNUAjseC+8qCLeuIbIWKxYmTME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJE/LCkN; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtUP8rgqu16C8OzNOCGnDbbncE5D/ilImrxynUYbSYsUuJCXCshWSimzad8D55XXPhQ7Lzm/mO5FkQbmLpirr9JP9wSFZwvJulUtpTgW4IFouquDUI9YrX9bQkGVtl74cLM3KJCljMCaANtKchJGmPpqIFcHUvycxvTFv4l/5FdkS39NXpdUjQ2By8+06SUl9gTTuDpnV7tZfwQb4y9Is64JCutbC6HtKXzLB4ROwF6CsLOThUjSQHx8ZBAJnrHj7WAnCe62Qtmr+Y/d2sSl7MgLc/p+Au3nWUD9EZfvnIK4A4THPWFL+KTLxdwBVYYf2VyeZ+loWy2QKq3Vol9NqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UKC/sUojFDNzP5hq+E1MhJ7bwEUXF/h4hogCXf3i2g=;
 b=s58BgbSmLFL2iTa3tijtY1Y0TkDzA6A4YD3nsu8rFixyvitPXufk6zp/RM66N/CBLApdMxKWfJWYyEEjBzIQmM9XOWZTLzdBl/RYQuy3kOrWxx9mGyYB4LAmyhgLFsWj2hhtWNWwtIpkjgNPFBt3SQBsM4fC7mEhfQ+lW179wcDzjxvUCy+viidPe9wLWjsni1+nF781aHaKsICu3iXyDiqCnxhR049Q9fKqH3JMGr5gjn9wrWqh1xJrKBQAYAiJXSymvDcNUdmdIRfBNZawl2AdqD9DdbZuBF/oej2hA8x8W0u69tmY0m66nIeRfy72imV55GRmiWPABCQfzSM0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UKC/sUojFDNzP5hq+E1MhJ7bwEUXF/h4hogCXf3i2g=;
 b=TJE/LCkNtOMNviG6MjpcDs1fz33l+99rZ9rw9Q4mLiAAdFavoSs68tIjRgK4hdqErqrGKBH/aAXr50kH30zkt2Ny3kEzRS/g4bS2FrL3ZbxEO8+KpwJJTNhPw/jR4gJz+D0ATL2JViFxJL/D2sMugXSgcOqGD/NXoHoBrWE3Rm+7PyTmcvWf9u9hSakgWaAO4OWEkLK6B5/rFgD4tmy8bHtU4VdLpRzbZahYXmm4d+DdUdpAcABGWed2EZyXdezo+hc+BHlenhiqY97Wb5sMHgL4yo+UKFxGxXKcwAO5vgMd/ukdTd5jThen13tpsU/vG9Xw1gWhC6zn4vFFWh1i5A==
Received: from CH5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610:1f0::27)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 11:41:18 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1f0:cafe::20) by CH5PR05CA0019.outlook.office365.com
 (2603:10b6:610:1f0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Sun, 31
 May 2026 11:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Sun, 31 May 2026 11:41:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:41:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:41:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:41:10 -0700
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
Subject: [PATCH net-next V2 12/13] net/mlx5e: TC, enable steering for SD LAG
Date: Sun, 31 May 2026 14:39:52 +0300
Message-ID: <20260531113954.395443-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: b5414dbd-10d9-47e8-4e9b-08debf0987a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A4Q22j3apI9Y5HNJkIlwDAm9n0xQYowYa4Xwi166ctFP0ms69Ow2cVs/ekmB/3XY3cYfZWIvpJ6jLWgiYdbzbuTMrUPx6DpmpsE6Rivl6bLbVkMj0eg8a+CqJ+REY01+zeCT92u8zTYs6n5JWVKjr/U9jayU7IH1LsFikp5LcXU7BzyRzSjayRFym0M3XyAJfsdsRm8kvHO5xJ0ubXtYIlmUQSl7J0UbHAvwC1YyT+AHOGw6xqpiNnuOQyT0AwOApHjI3c3ZpaCh1bhGPpIhfUnZwhMZCfk5x0BI1uynDM8CQ7JH14j8ZVoO9ixoBJJ11TRJPlVTyKuGIMJyFM23d6MfiIlscDYkL7NOyKqu7dLZUEn5Osueeacrs1xfluOVQjtgR2A3FGzNYNa5MflWtUJbLWwSar13OTj29h0UZ02XTduzo0CcpLS48MWroVhOFSyoRt+Vo5VOEqMiKCwhdWmLtv5mskb6Vw6vH1SAbU9rP1dTEZECGEBdfGfTPSlxQRp7fdHZpghm0v4UzpNW0IKMGbOQXZy2c881DKdeipUZ2/To78b63Ke6y3SRWgQHQQ4B7ZHsRXFRTEObIkHRwh+B/cRHL76+p+nvqVMazvnPMNyLMnTL0QOeMOxMrbqszjjTkoeLF1XoWssmK8m1uKq53DsvR6qJHxVLt7Thv3BJe9fAry+iJ/N0gWOWi4jndvKrqHuNxRk4ZmX6pjmfe4MS/SvEITJHi4ryjnO2dO4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8RqJB458T3cgbMEazQnNTzl1GrRV15a1J06QrV1zNllDGhhySsOn0TLyjxnSvBEt8WrQNKX4ma0HIopveVJJQEmdwN8Hq0wFierJqh9ihO72jXg9+uUjENBEGIBSrsPBE3YnHs9X8WdhaomzdXMhEXT2+DVMfWGQFKzmHwmj9wABW2daNLUWPQxpWyI7MlxtqD+4PwMy9Wu8ZBWifMWOFG+TSIwtGYyqJd9GNqC3eLx1iO9EKom+NPCtmhpc5e8mIXcLR0VYOupAXMQLCM4ZZ30VVM3zEe/exrgCYGmBsplmnuBqJyBIufDQxuAOtZWKyTX+EQmH0PsRek+Mj5MIdwDVgFrX8wFSDL/Sc8MMPvvrNbMAzVYlL4UncIkh0iepIVZvxpVToBjJY1LSe+WAnKGQiwBwQgCmbB6e5mL4Zfx566Glp4r3iLzIEFEDs3xW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:41:18.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5414dbd-10d9-47e8-4e9b-08debf0987a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21555-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A47E0615D1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Enable TC flow steering for SD LAG mode by extending multiport
eligibility checks and peer flow handling.

SD LAG operates similarly to MPESW for TC offloads - flows on
secondary devices need peer flow creation on the primary, and
multiport forwarding rules are eligible when either MPESW or SD LAG
is active.

Add mlx5_lag_is_sd() helper to query SD LAG mode, and
mlx5_sd_is_primary() to identify the primary device. Redirect uplink
priv/proto_dev queries to the primary device's eswitch in SD
configurations.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 53 +++++++++++++++++--
 .../mellanox/mlx5/core/eswitch_offloads.c     |  8 +++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 14 +++++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 15 +++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  2 +
 7 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
index a0434ceebe69..28cab4bf525c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
@@ -104,6 +104,10 @@ struct mlx5e_tc_flow {
 				   * due to missing route)
 				   */
 	struct list_head peer_flows; /* flows on peer */
+	int peer_index; /* peer-flow index pinned at add time, used at del
+			 * time so removal is independent of LAG state
+			 * changes between add and del.
+			 */
 	struct net_device *orig_dev; /* netdev adding flow first */
 	int tmp_entry_index;
 	struct list_head tmp_list; /* temporary flow list used by neigh update */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 2a16368a948e..910492eb51f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -71,6 +71,7 @@
 #include <asm/div64.h>
 #include "lag/lag.h"
 #include "lag/mp.h"
+#include "lib/sd.h"
 
 #define MLX5E_TC_TABLE_NUM_GROUPS 4
 #define MLX5E_TC_TABLE_MAX_GROUP_SIZE BIT(18)
@@ -2132,7 +2133,7 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 	list_for_each_entry_safe(peer_flow, tmp, &flow->peer_flows, peer_flows) {
-		if (peer_index != mlx5_lag_get_dev_seq(peer_flow->priv->mdev))
+		if (peer_index != peer_flow->peer_index)
 			continue;
 
 		list_del(&peer_flow->peer_flows);
@@ -4196,9 +4197,26 @@ static bool is_lag_dev(struct mlx5e_priv *priv,
 		 same_hw_reps(priv, peer_netdev));
 }
 
+static bool is_sd_eligible(struct mlx5e_priv *priv,
+			   struct net_device *peer_netdev)
+{
+	struct mlx5e_priv *peer_priv;
+
+	peer_priv = netdev_priv(peer_netdev);
+	return same_hw_reps(priv, peer_netdev) &&
+		mlx5_lag_is_sd(priv->mdev) &&
+		(mlx5_sd_get_primary(priv->mdev) ==
+		 mlx5_sd_get_primary(peer_priv->mdev));
+}
+
 static bool is_multiport_eligible(struct mlx5e_priv *priv, struct net_device *out_dev)
 {
-	return same_hw_reps(priv, out_dev) && mlx5_lag_is_mpesw(priv->mdev);
+	struct mlx5_core_dev *primary = mlx5_sd_get_primary(priv->mdev);
+
+	if (!primary)
+		return false;
+
+	return same_hw_reps(priv, out_dev) && mlx5_lag_is_mpesw(primary);
 }
 
 bool mlx5e_is_valid_eswitch_fwd_dev(struct mlx5e_priv *priv,
@@ -4207,6 +4225,9 @@ bool mlx5e_is_valid_eswitch_fwd_dev(struct mlx5e_priv *priv,
 	if (is_merged_eswitch_vfs(priv, out_dev))
 		return true;
 
+	if (is_sd_eligible(priv, out_dev))
+		return true;
+
 	if (is_multiport_eligible(priv, out_dev))
 		return true;
 
@@ -4351,7 +4372,7 @@ static struct rhashtable *get_tc_ht(struct mlx5e_priv *priv,
 		return &tc->ht;
 }
 
-static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow)
+static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow, bool *is_sd)
 {
 	struct mlx5_esw_flow_attr *esw_attr = flow->attr->esw_attr;
 	struct mlx5_flow_attr *attr = flow->attr;
@@ -4372,6 +4393,13 @@ static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow)
 	if (mlx5_lag_is_mpesw(esw_attr->in_mdev))
 		return true;
 
+	if (mlx5_lag_is_sd(esw_attr->in_mdev) &&
+	    !mlx5_sd_is_primary(esw_attr->in_mdev)) {
+		if (!mlx5_lag_is_mpesw(mlx5_sd_get_primary(esw_attr->in_mdev)))
+			*is_sd = true;
+		return true;
+	}
+
 	return false;
 }
 
@@ -4609,6 +4637,7 @@ static int mlx5e_tc_add_fdb_peer_flow(struct flow_cls_offload *f,
 		goto out;
 	}
 
+	peer_flow->peer_index = i;
 	list_add_tail(&peer_flow->peer_flows, &flow->peer_flows);
 	flow_flag_set(flow, DUP);
 	mutex_lock(&esw->offloads.peer_mutex);
@@ -4628,19 +4657,26 @@ mlx5e_add_fdb_flow(struct mlx5e_priv *priv,
 		   struct mlx5e_tc_flow **__flow)
 {
 	struct mlx5_devcom_comp_dev *devcom = priv->mdev->priv.eswitch->devcom, *pos;
+	struct netlink_ext_ack *extack = f->common.extack;
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *in_rep = rpriv->rep;
 	struct mlx5_core_dev *in_mdev = priv->mdev;
 	struct mlx5_eswitch *peer_esw;
 	struct mlx5e_tc_flow *flow;
+	bool is_sd = false;
 	int err;
 
+	if (mlx5_lag_is_sd(in_mdev) && !mlx5_lag_is_active(in_mdev)) {
+		NL_SET_ERR_MSG_MOD(extack, "SD shared FDB not yet active");
+		return -EOPNOTSUPP;
+	}
+
 	flow = __mlx5e_add_fdb_flow(priv, f, flow_flags, filter_dev, in_rep,
 				    in_mdev);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	if (!is_peer_flow_needed(flow)) {
+	if (!is_peer_flow_needed(flow, &is_sd)) {
 		*__flow = flow;
 		return 0;
 	}
@@ -4651,6 +4687,15 @@ mlx5e_add_fdb_flow(struct mlx5e_priv *priv,
 	}
 
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
+		if (is_sd) {
+			/* SD shared FDB: only the matching SD primary. */
+			if (mlx5_sd_get_primary(in_mdev) !=
+			    mlx5_sd_get_primary(peer_esw->dev))
+				continue;
+		} else {
+			if (!mlx5_sd_is_primary(peer_esw->dev))
+				continue;
+		}
 		err = mlx5e_tc_add_fdb_peer_flow(f, flow, flow_flags, peer_esw);
 		if (err)
 			goto peer_clean;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d65f30bb2f80..830fc910a080 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4690,8 +4690,11 @@ EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps_nested);
 
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type)
 {
+	struct mlx5_core_dev *primary = mlx5_sd_get_primary(esw->dev);
 	struct mlx5_eswitch_rep *rep;
 
+	if (primary)
+		esw = primary->priv.eswitch;
 	rep = mlx5_eswitch_get_rep(esw, MLX5_VPORT_UPLINK);
 	return rep->rep_data[rep_type].priv;
 }
@@ -4713,6 +4716,11 @@ EXPORT_SYMBOL(mlx5_eswitch_get_proto_dev);
 
 void *mlx5_eswitch_uplink_get_proto_dev(struct mlx5_eswitch *esw, u8 rep_type)
 {
+	struct mlx5_core_dev *primary = mlx5_sd_get_primary(esw->dev);
+
+	if (primary)
+		esw = primary->priv.eswitch;
+
 	return mlx5_eswitch_get_proto_dev(esw, MLX5_VPORT_UPLINK, rep_type);
 }
 EXPORT_SYMBOL(mlx5_eswitch_uplink_get_proto_dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index a2c7e2927431..dd3f18f85466 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -2425,6 +2425,20 @@ bool mlx5_lag_is_sriov(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_lag_is_sriov);
 
+bool mlx5_lag_is_sd(struct mlx5_core_dev *dev)
+{
+	struct mlx5_lag *ldev;
+	unsigned long flags;
+	bool res;
+
+	spin_lock_irqsave(&lag_lock, flags);
+	ldev = mlx5_lag_dev(dev);
+	res  = ldev && __mlx5_lag_is_sd(ldev, dev);
+	spin_unlock_irqrestore(&lag_lock, flags);
+
+	return res;
+}
+
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index cbe201529661..e412bb85027c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -202,6 +202,7 @@ static inline bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 }
 #endif
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev);
+bool mlx5_lag_is_sd(struct mlx5_core_dev *dev);
 int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 			struct mlx5_flow_table_attr *ft_attr);
 void mlx5_lag_demux_cleanup(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index ec606851feb8..25286ecd724e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -49,13 +49,16 @@ static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
 	return sd->host_buses;
 }
 
-static struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
+struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 
 	if (!sd)
 		return dev;
 
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		return NULL;
+
 	return sd->primary ? dev : sd->primary_dev;
 }
 
@@ -69,6 +72,16 @@ struct mlx5_devcom_comp_dev *mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
 	return sd->devcom;
 }
 
+bool mlx5_sd_is_primary(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	if (!sd)
+		return true;
+
+	return sd->primary;
+}
+
 struct mlx5_core_dev *
 mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index bf59903ab23f..011702ff6f02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -10,6 +10,8 @@
 
 struct mlx5_sd;
 
+struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev);
+bool mlx5_sd_is_primary(struct mlx5_core_dev *dev);
 struct mlx5_core_dev *mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx);
 int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix);
 int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix);
-- 
2.44.0


