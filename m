Return-Path: <linux-rdma+bounces-21554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAB8LBUgHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:48:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37650615E05
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91DB230BB832
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E70384CD6;
	Sun, 31 May 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nR2O7SUT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252483845A2;
	Sun, 31 May 2026 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227685; cv=fail; b=i8hZlkrpzBo9DpNkeSRNl0O5L9UzVqM5Vfytsch+wsI/zUjzLZ3gM8SuFQplMEpkEWpj6MModzbNbPuYWRkDwxQ+6lpj31xnzTjP+Sy+lkAMoB0u/r1azGal8lLftjuCr/G3ZrToFaKqMohX0EqWFQUQk7zcwXFfyFHL8ecoXxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227685; c=relaxed/simple;
	bh=8aEtJSvkX+Wy2OZy7XextSOd8T2DOYhOqwEsNbAt0dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqbV0MAUtCB+7bovxhSzZ5Z4j4trumICgMbgr1kDZ+4hwTX4fHlOnl8aE0feyfgw0/ygDBr5Oyov3bY4eduNLw8dQmvVLy4Z5t5fSZKQ7R7iPyx4DvKaH3oVZr3Riam2FW1LBW7FCub185VvNaG6CBgJRjwXpz8C4IqjkuxluxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nR2O7SUT; arc=fail smtp.client-ip=52.101.61.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ/TCvPE4Burosf2xo9vrQWG0Y08aSBTyjrxsDNuYaf+oomxZreukfMceoP330JcjSDXCNOTG0MLrE8jY8CjqkcJMF9IPjSMEU1FYrfN+/xgHxScN4n1qS8l2fEOfoNNzo9RQJy1rKGCSbD0WBCyCsSwtxPZg47O9IN1VCazsoZf9i4mNzjWGxvXDKyLssUmhuontslb5WxqeIlSBjfyt0R9aEpkr49x3htCGYpqJDHib9q9m2UAvFCQS/UZ7867DQBBjHauRYVHJk+GsLUkneqPM3ujUo3uS6ahwzk7j4AZojojudNCgrAMzTHk1x9qUtmGp3HeqGjY0AA2lOKXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L3P692k+ByaDkv9O+CK5sp+LoLKIziCYQETiEvfZ1E=;
 b=M/tqk4ePPWhyUhvgyfmtYfrjhkaGItiCll8cYNrc+dQit1fOfOGOyoag3kBSMl8cQEn+UMRtWPCnsJlvyC/OF+sOPxRSPBuMS6XvpkuC83MbvVWqDouTd3K4diDaaBoQdrSMdMJal3kEc/NjrJHGA5o+Dr/50dvcGvtBQXAoZ2W/HwsGvKZxdOP8wNFxM01WWQRzwMZbEJL6wiPwK3lwP3r71GhiPWMY8Px/ND0/pzQTpRu5KO2xZA8UFphOdGm7Sz0YyC1QD7A+dGZ8avLAKUK3VQ4sVjBLxzB2wvg6JnenY291BHBtj9jCL+NIewGcUQpXx4EPavJBVEMMNMD3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L3P692k+ByaDkv9O+CK5sp+LoLKIziCYQETiEvfZ1E=;
 b=nR2O7SUT891T3tdjc3gE79LJlJ5WbI/r6L1agFn5+ZBrgKN6Gyu5dJF+ZMuMb3oIxXtiHO7ra31xmUbexgGhnKG9LHjeORE+00c3zHrJWvDqUnK7qkzKWuSpoiQmrZJjoQ7VWTrhS6XUxLMs1eViYkUZMIPW1Edg7tLP8l9hOfXP8fE6/06VFaL09MwdO3iV0nh/fngKbk1/68W1y0bHoDcBsg5SNGIRv4XyvNdbg0qdGt2qICE4VBZVb6pOivG6MLNr5df6Ob6mgOozbfyg+A2wuUxoKlvtshSelIBuOrIb0ejXm9z01XmkAhdfW0JpqIe15aGxF4G8HoZHcljPDQ==
Received: from MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::15)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sun, 31 May
 2026 11:41:15 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::17) by MN0P222CA0007.outlook.office365.com
 (2603:10b6:208:531::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:41:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:41:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:41:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:58 -0700
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
Subject: [PATCH net-next V2 10/13] net/mlx5: SD, keep netdev resources on same PF in switchdev mode
Date: Sun, 31 May 2026 14:39:50 +0300
Message-ID: <20260531113954.395443-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: a415c7e6-b109-43a4-0bc4-08debf098582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	s54qHcg3Y8wLuqfj2CSM2f+0eukM9KMj/cy010yKxggB3AblKhB87+lAh4iOUQq3zT6QHsjtyGxwvibn3j/WH149IBoID/an9EJcT/QJBO0RA/F+CoFDOzDBOWNl4OBTrTcP7JBJJ4ztTLqSD/j+/vC1uIUmW1Z/u6h3EByLcmcG/ORHQydvze7kJ/dht3wZz41XWGYuvF2osoh6v3bsFGAvPxrjI3OlLKk0scW7g//1fNmDf0LCf5n8qOrPpPyeiJq60GCelOqaRyhKBCWXs72eytMsV3MmDvjufEr+m2B0g/j+c7IBl5ow8RVXz2np4GMNZZeOT9m+GIJLDbrTsCrOHHbUCjNmEApfCJ0Gy+DI12He5wkjTeYJSRxSNHQhPq6havkTcdJqS++bjYjoeZ/AhixGlH7rLGt4E3XHRgUw0HsMh0m60BuumCuRVu3QphX8xY45ihae1pBQB0LZIA50ppzB9QpMI95rsnAFgdzg0puUAeadSgBX+9uu5KyN4mRiHzwN7ReKsO5g37MnGSPxlvOfzyOgT1CXjKW7WlFoBVJy+qUB60Z4IVUNudY2pw0tCwevEHkqmrM6U9XFj9Q+FQ8hJRQiLTfHgAbGKjTZrzTJ7SKAAdQQX3Ujp9puCbfkOkouxSdRL2HPWe7qdWyVZ07larfKmBJZUepfcWMnbb3V92Vf7w0C4CLj3703+b39U9MAovnZ33h0tRUvXOYzWnsZ7FOadesbrsgjb80=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XpdemKcZlvla4Q4WOTC3WviFUNurHjsKpwARE5Db+J1GwRNZhkShzdFWI10RknGeQfBtXsjTwbQpc48waDdnH/TVUo74VVVgRVXMiiIc1hqAkdJCtNWeY7C3FnkiGPWRT+bFzGsXC8pd3tesmRD635ghTjyR09QQjRybpPfA1rnW0U99oLuvKlU+8Vh18L2aCsAHj09FOAPHvk+Giq5ckQbxyNIqZq5P4+hgHZFB92Z/eH5SHVcvfdR1iRb+7ecIc492h9gIilnlfqOxgNwCprQL6KPSuAZJjE4aPQZPX18Cin7N7NbGP4rPsYE7Njes5Ig0OS1StAv5xociCI8zEzpu3t1SA3GySHkxGySbNTNQpo2MUZKVGPOdri/KmeylP9WFXFJDCuKcEkwak2K1a1TCt1htcu8afaNI6x8yPHy/YC1b5jHWqrKi97+vZC69
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:41:14.6748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a415c7e6-b109-43a4-0bc4-08debf098582
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21554-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 37650615E05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

In SD switchdev mode, network device resources such as channels and
completion vectors must remain on the same PF rather than being
distributed across SD group members.

Modify mlx5_sd_ch_ix_get_dev_ix() to return 0 and
mlx5_sd_ch_ix_get_vec_ix() to return the channel index directly when
in switchdev mode, keeping resources local to the requesting PF.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 8991db3a19cf..ec606851feb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -6,6 +6,7 @@
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
 #include "fs_cmd.h"
+#include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
 #include <linux/debugfs.h>
 
@@ -85,11 +86,17 @@ mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 
 int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix)
 {
+	if (is_mdev_switchdev_mode(dev))
+		return 0;
+
 	return ch_ix % mlx5_sd_get_host_buses(dev);
 }
 
 int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix)
 {
+	if (is_mdev_switchdev_mode(dev))
+		return ch_ix;
+
 	return ch_ix / mlx5_sd_get_host_buses(dev);
 }
 
-- 
2.44.0


