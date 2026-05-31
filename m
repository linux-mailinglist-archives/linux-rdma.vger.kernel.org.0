Return-Path: <linux-rdma+bounces-21548-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P4sCmEeHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21548-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:41:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DA615CEB
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE3D930059BB
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBDC3845D5;
	Sun, 31 May 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2rz9gfW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6238423B;
	Sun, 31 May 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227652; cv=fail; b=uCvOsEnnTYJk6ECn6N8quZ2/q4aD+oKgD3GLe3yvNHQ2Mv4R8+SRwBGpbUdxBvksvR3aAtiXMWHZIbFBu5pBxN1h8IqhTpZcopxRz/r6kmsyvHajQzOVt/qz0VL+PckXjiKtTkw2a+XuP2zRLR1PAESIyLVdpssqCBVeWhg3ryw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227652; c=relaxed/simple;
	bh=u+SEIVpOj3Gf79Ylprfc5kmueLEfNDYnXxOc3+s/VNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFeeCrOYxsv/L1d74d44sZQSZ3ZdTPpivHtxOxxD19O8YW4rH7a8Hq0Muav7937WNpI4Ruqsf5HSHkcjZqJF3L9yZ/le8/j3FNqJF48xjnjyAp0xNGR8maxZaBndeye9aTLAg58EaQjiGEyai6z+/fEFPGYuWVMN7BDvlnfa8JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2rz9gfW; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJOxsZUuYof6PSLemy4GijbDxUy/4le7ZfechtN2WkxeuwS3/H7HYGCaPTWnk0fZxeJc+viKBmNK3T/9wHzTDeo1HQhZpwQ5FN0fyBF3+1xw39IzLTU44kiRdhl/1oGzDTyuUhCl0D6LExhTMuOHenxQWTWXX4bQG98qNtwiK1JkD/lglq6HyLzwBynuYs8ptXOm5PzxPkw9Unzwa2X4o5IodI4EgEU3N/aigDR0i51ycEXFqAfidgxUzw5OEHq+j/ktuaKtHCnYCbDON/d0ywdlaEFV5JO4umwU8PrTRM5rUsm7CiuDmnVmH9ZSVfHbQjpy6YT3SaIeAXNno+Fh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hvmj+R1F8Y6pmfg41BEb8ne5v0EuRUUYWQWCscmH7I=;
 b=bxh7knK3pL/nMSe0sPFM7gN6UZCOrtHNPyNCafDBWJ4L23GCIyGR/XEPZ2XtuC9KE26QdXjbb9nOUwMTz/n3y32G7MegI8H8SaQKZ0zwarkEnG8WIWnBBC8rmlEQUr3VK/jKJAg1yzCo/l4femiM2DxugkWgQtknYGtbhGRWUb95JTgSHdMV5+RNU8MxYsJMWkSqy4C+oUAo6h39pDsErSZ4fxxVaoW0wPIPGIssvWjA4P01mPU2GDU9vYiw474IFS7R628SJMLKwkznUK0Z1NE8BB1Q/d8Vh6VwbBgIU9RnwRe2Sej/XTLbIa0oRGsUhC/1y9AtM+ftWwTgdlkgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hvmj+R1F8Y6pmfg41BEb8ne5v0EuRUUYWQWCscmH7I=;
 b=r2rz9gfWdST7ESg14kz+t5G12rCbxTkRA7t/dLfPk5NbqUSZlgwj7fAXAwzPGZY4R9r1EavOtVdcu7ZaHiiEz/dnSsdxWUlfRUaJPgwYKbdNLLq5VMLjx11qPwChcBS7JVEDo54E/xrp8zxw62wauuhUdJMJopgQCcNq3zL5iZKt/hENYPBSuEFtveCA64VmqaYAmYUdPwKoFpUj5J5mJ8w6T5hqkL5HXVmPLbut+NZ/6Rom0I9MGgDretjXWTtgpPn1LiE2HRZeViDpwqvEVrinr82Gx1JaGc45ZuizQ5g3G2c+Rv/97DOsTZ1/OhxPIisByGs1bPp7D+hN/SfJxw==
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Sun, 31 May
 2026 11:40:42 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::22) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Sun, 31
 May 2026 11:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:40:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:21 -0700
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
Subject: [PATCH net-next V2 04/13] net/mlx5: LAG, replace peer count check with direct peer lookup
Date: Sun, 31 May 2026 14:39:44 +0300
Message-ID: <20260531113954.395443-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: debcb1fd-7dbe-4c8a-085b-08debf097230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|7416014|82310400026|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	79/vwFYQZxR0ItvJZc9XhIGPNo81GUwg1L2ZywTCKULOTwGHNx81yOzEnkL3dAsjaPul5FbHoniTXOZCqM27csnLN0bLzH3bRVchwR/o1Z/zRC975CZkuWpjOwV4gqTFdSc1u8OzzMeG6cDj9Aw9hjuZ56ox0pjzjTCGVRp1vRrh7dYX6LJvsMqE5UhmzIMeQRmyIvyB4QMvxc2qYwT++V/p2sT1E2Mch84B4FqtYaH8v9onRnyThcG95N2NJZpXzm1WQL3yMpzjsHL3OaO2dMUoyWBvRygX2qkPB3f2mxdMLSCJsXE6Q4iutsS9xvY7D/DdO3iRi1RSyrRw3pcTQH+GHuUIfAESJQ7SvVyYvppO6R/GLZX2k+x81aOozGNr2mn0QaHW24L/4dRp8CuU1cdIGupK8NGIMPK7tPTQiWX5UQ/Ci3bJlGMIxWaX8Sm6/ENjeQTJq7dP70jhJ6JWXUJOpXq+1oKB/CRej9IVSql/fNohwni8mb9e7xgsdm+iG0fVViLTZ/5O/j8MdxkJmHZXz95h3VkxOm1Ir5siQLVc5XaKXKK+heJAa4Eo9RxJIU2wT8b3ioJcBU8rjRibzP+OJYgZ0eGnMg30/HPVtbstlTzqAwbwsLU1Mg9HpBKwL7sq23rBuTaBkjSF/Dr9ZUpQIKfs7uZg4cC+Z1nzS6YWq9HlUxeBLA6+78Q/JhgIlDGnIvtzWzRozl5mA5S46V82hHSfOKC9tJykecliOWI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(82310400026)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AU9OIPrbhUVu7rDJKuQxs0MchM0tmK6rApeHy7AXpyX8s6NH3WrVgCZX1cusOBN5RrJmI6F+cUCfVd7IFESi73nsGndXo+cZ4jvAcYYZaRyTIxpNdrReTGBbcrGq4aY3fkDxBF/u+mt/14BL8Dda2qL0GYpmXGeCHSfWSapy4xsfWGDujnQQkooWhTTfO0V+iB3Roj9nbxrPHM3GG1HYuZBkqD9CNDrV/k64j99K212yazi+3/KDlZwYrh8MddAkw13+PvfG36ljhcyU9geLN/0R9Dn4yRUW9+2u02nIeQdhbYE881o86BVKCtGWnLdqABP0HqpbOQsgIJWES94zSN5ZNkogzxpsgAI4NdH9A3tEurym7bmRsRVNIgMhxe107Jb1iEjKjrC8UQUhC067FK7NAYx/lHB8MwiGUSddKJS8BqreAQcXLrj/eo804mT3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:42.2691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: debcb1fd-7dbe-4c8a-085b-08debf097230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21548-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 122DA615CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Replace mlx5_eswitch_get_npeers() count-based check with a new
mlx5_eswitch_is_peer() function that directly verifies the peer
relationship between two eswitches.

This change prepares for SD LAG support, which is a virtual LAG that
does not have num_lag_ports capability and cannot use the count-based
peer validation.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h   | 11 ++---------
 .../mellanox/mlx5/core/eswitch_offloads.c       | 12 ++++++++++++
 .../mellanox/mlx5/core/lag/shared_fdb.c         | 17 +++++++----------
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8a94c38f8566..94a530d19828 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -955,6 +955,8 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
 int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
+bool mlx5_eswitch_is_peer(struct mlx5_eswitch *esw,
+			  struct mlx5_eswitch *peer_esw);
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
@@ -970,13 +972,6 @@ static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
 	return 0;
 }
 
-static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw)
-{
-	if (mlx5_esw_allowed(esw))
-		return esw->num_peers;
-	return 0;
-}
-
 static inline struct mlx5_flow_table *
 mlx5_eswitch_get_slow_fdb(struct mlx5_eswitch *esw)
 {
@@ -1058,8 +1053,6 @@ static inline void
 mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					 struct mlx5_eswitch *slave_esw) {}
 
-static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
-
 static inline int
 mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d9683d3ea0e7..d65f30bb2f80 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3296,6 +3296,18 @@ static int mlx5_esw_offloads_set_ns_peer(struct mlx5_eswitch *esw,
 	return 0;
 }
 
+bool mlx5_eswitch_is_peer(struct mlx5_eswitch *esw,
+			  struct mlx5_eswitch *peer_esw)
+{
+	u16 peer_esw_i;
+
+	if (!mlx5_esw_allowed(esw) || !mlx5_esw_allowed(peer_esw))
+		return false;
+
+	peer_esw_i = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
+	return !!xa_load(&esw->paired, peer_esw_i);
+}
+
 static int mlx5_esw_offloads_devcom_event(int event,
 					  void *my_data,
 					  void *event_data)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index e5b8e9f1e6fd..b5cbe3409720 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -10,7 +10,7 @@
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev;
+	struct mlx5_core_dev *dev0, *dev;
 	bool ret = false;
 	int idx;
 	int i;
@@ -19,6 +19,7 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 	if (idx < 0)
 		return false;
 
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	mlx5_ldev_for_each(i, 0, ldev) {
 		if (i == idx)
 			continue;
@@ -27,19 +28,15 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
 		    MLX5_CAP_GEN(dev, lag_native_fdb_selection) &&
 		    MLX5_CAP_ESW(dev, root_ft_on_other_esw) &&
-		    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
-		    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+		    mlx5_eswitch_is_peer(dev0->priv.eswitch, dev->priv.eswitch))
 			continue;
 		return false;
 	}
 
-	dev = mlx5_lag_pf(ldev, idx)->dev;
-	if (is_mdev_switchdev_mode(dev) &&
-	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
-	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
-	    MLX5_CAP_ESW(dev, esw_shared_ingress_acl) &&
-	    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
-	    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+	if (is_mdev_switchdev_mode(dev0) &&
+	    mlx5_eswitch_vport_match_metadata_enabled(dev0->priv.eswitch) &&
+	    mlx5_esw_offloads_devcom_is_ready(dev0->priv.eswitch) &&
+	    MLX5_CAP_ESW(dev0, esw_shared_ingress_acl))
 		ret = true;
 
 	return ret;
-- 
2.44.0


