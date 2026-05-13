Return-Path: <linux-rdma+bounces-20574-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CENRJ29zBGprIQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20574-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:49:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC553352E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FAF5301233A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CC421A04;
	Wed, 13 May 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHWAuJwT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743942189F;
	Wed, 13 May 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676364; cv=fail; b=Qf3HbcsiAfP86XmTPOo+vkQFrE/QE1eezO4NvUDeoeNGtZwBFEoMBzTl6Y/QfWz5rBjbeBLbqoXO3xlp7I7po5qjn4U22IYOsBCZjEuhndKZwd91DOlNiLACtogoFeLViv7uQgxDhloUKoiCLaxrxbW0B9rVoe3G6YPXzX7e4eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676364; c=relaxed/simple;
	bh=V15wS9spFkiWUx1/5Lqc7+r1TH5sa1C65lZ8iMdHxKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjgqSrQviLJIKot0UZgCmVZ7gNA/kAx9JSXbs/VVtO0aoPhI68c6VGZV7h/OnRatGPU+xmfRfdkuIi6U2bZ/tBOAOZ7o2iH1JkEJWlaF/erDMZ3N86OHe9+JgxeeE2d3lWTAexrONPOJtDjEO8ha+sLPrad5wGRT/AJKqvlpDtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHWAuJwT; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXNRYViPmFemEAusL4GHhKEu6b6T3BYpki87mGgyWi71pVITYPT1EsIIbKIgu1ndpC3eLmZGJAyDC8bag8xQbydeotodpvMCQVjSYBqB05I92CBtodft+0fvJWj/Qd/HC2Npg64ocC8YbJKQQ0+gMhVaEn9d0atCbF+rbOdFrcyIgUmS1GO7RDY4o+xLjL9mbeeVUX87wAP9UwkrmsECxn8nvirqiYzG11ErOOexCHakUPrWgBIZGCyucBONo20TL79j5iQ9vavDoVJfpsQGTDTgyX7P9txdd+7RjMPmUbBju1DlDBgprr36tFURV87ANHjUypL0eXt0lsQkKEQuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWfqBPBc7Ui74uY4hnkbq1n6JVGL2IGW0/e3F37VFGA=;
 b=VP2ZfaLaG7YwWqCnJUE+zJGwonc18rrmZFYy3mBi9gcvtz9EIFdsYU2dNMRWeEXgw6OhHfRyb03H9eqNw5aD34bb5q6lTWkad9wVvtkj50fq3qLUg8KG9zMzW17k+XH9RMRTgQwtCmW3PAeujLxXNED6/0+w1eh8OE2jjlZsdW+u71jBOI32K16QCUMJPdQJRQl8USIAESL88v6z0+7+mDbVbWujg+XMXiGcL7QeuyZFFVXRUE3qDHo65tsGYjoKzWSSIMOXAAGwSDPwFZlPx+V14EpL5oXmhk9O0uQWfPtrpW0/5/EVfVmJWKGIQLKabJ5MqOOL3MnI9j8ncS/KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWfqBPBc7Ui74uY4hnkbq1n6JVGL2IGW0/e3F37VFGA=;
 b=SHWAuJwTDUnjL6+p8A0FbTRjuiW+rj1FcqE8tK4n+0ApvnL0imjcmO0le4Tb3vaTGcW8a8/bbBFlpw2IgIgJV+KBCexikE5dSU+pWHnBXPO75W1Vztx7B+rq5H7iS/DbRrxIYvVAlyyJhb/b7QSzTBSD1mozdRLPNmdckL1qBCDMi/7OdAHQ1iMoh4hk0gnXOakoB/pO6+sWgYR39+EWMUNUVAQPzNu3G8djEIGbDMqp12Hri/QyWWSTAQCjc9b1o8zd/DUvL2iXl9ctLtMMr4wC4lippTKzwF1HTMHfpOekjG8/LQh+JI3gpbCgnGspAl9DsgjxFCmx3fwtZhRP+g==
Received: from CH0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:610:e5::11)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 12:45:52 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::48) by CH0PR03CA0246.outlook.office365.com
 (2603:10b6:610:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 12:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 12:45:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 13 May
 2026 05:45:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 13 May 2026 05:45:33 -0700
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 13 May
 2026 05:45:30 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Stanislav Fomichev
	<sdf.kernel@gmail.com>, Paolo Abeni <pabeni@redhat.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] IB/IPoIB: ndo_set_rx_mode_async conversion
Date: Wed, 13 May 2026 15:45:18 +0300
Message-ID: <20260513124519.3357165-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3301ff-8938-40da-7339-08deb0ed915e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	3rzxceY1rz1axvvj+2Wm794YwPzZOry2J80tlK2QYcaubLtq7pJ8NRIup7HzcXFMfFF5YhEWpMRTjjqUtrgniG2gpp6YWFmZgrCY5+1OZkz/8qfDQo4s+HkKmMhjk4c+kF5BrzWqd66HgVjB++ApDzo1f+v4QxiIhiKnqbr0lHo22L/2pe+5qReGWcRCVcbPF34qP4U8VexKu6scJC67oU66ZlOhKHqUqpWTcicVa8X1sbCxE9O2ewzynCjjl95eSo9awJ+Cdm8eBxnIhsyuHVrPRiSr/fnKiuqDcj0+UE4rs/UNFQMmPW5Hn5fZM2UIkfjcGTle8c0es4J+GulNX9PoNvTaU+vZDITV4sHRWDJBkjAeX+6bzjczqx2pmtxfMko+Kc5P9jVTk7rD4RxG/X9P040YZMgQhsOw5gzWcUjOhStzxXrhsxUvjATxyKH3+ogRswuqzg5deTXi9kMRNSqOSD187R2uGSic7EP3A9vuxIHq8bXUmGpFEz34uniqBtxQqZWs+FilwTptFCwA6gKcPn5IqNq3PLjfQXJNYqX3Ujf0UNYoYPxutIjOnP3D50fBHnbfjxXIn2XtKwXT1IputjDtAXoOiJ6Pct5FLrYm37uAmDlXciyhCOcSIUFrB9AyQoTiLyvoY3dhFIHhs4cBKeRktDbpq3oaWmYh06e/IzGUGNSh823CDrTkPMntWNFYXU7DquGvU/yhygNDR3TCgQmKLdV75LsYL3FZFko=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RNAT+BNIk6AVmw7pfFcWtL8azgxQOd6JnR1wAja09CKrHq9MgmWGHj1C/7ZNsRXNiEzPRdTmHmHb3Z8gH0ui27B/QiDjLc0x8VvxBQqTBFo7wu6g0Cg9RNQJNlc/orZ3DTmn/IQn+1fEfXWcWuoOyohtL7CHEjni6qKZn+4Km2wpfaR/Pus2d40M4FEvOG2CKIf1yvWeS7qk7TMilhA8ZKsuRHyQRnqXUmLQgN6+FlTz/bqWgy6pL2Aw0F9LCx51RxKqOvFLdQ9tQrx+hGpMWN4Wq7iwOpd23fZXiyZyibNGK0uLU7MLYS5QeUnZMfRJXvrO/LAzH7uO1SLMPn7GMbsg7lhCaKNTavxQ5jXkjlqD3PUTonKzaPNdNUhSEDlL/ySoi89ZEE3PrHsSXb07NGcvbid8ibV/4v7JXH2LXRVgznp9uwKBRvz+RO866FUR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:45:52.4469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3301ff-8938-40da-7339-08deb0ed915e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
X-Rspamd-Queue-Id: 13EC553352E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,intel.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20574-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The commit in the fixes tag added a warning for devices
that are netdev ops locked that they should be converted
to .ndo_set_rx_mode_async. IPoIB for mlx5 is such a
driver which was missed during the conversion because the
flow is more complex:
- mlx5 part of IPoIB device was converted to ops-lock in commit [1].
- ipoib_intf_init() then overrides netdev_ops with
  ipoib_netdev_ops_{pf,vf}, which still wired ndo_set_rx_mode to the
  legacy sync path -- tripping the new warning on every probe.

So now we have the following splat:
  netdevice: ib0 (uninitialized): ops-locked drivers should use ndo_set_rx_mode_async
  WARNING: net/core/dev.c:11366 at register_netdevice+0x83c/0x21d0
  ...
  register_netdev+0x1f/0x40
  ipoib_add_one+0x35c/0x880 [ib_ipoib]

This patch implements .ndo_set_rx_mode_async but it simply schedules the
multicast restart task like before. This is done to maintain the
assumption that this task and others [2] must run on the same order
workqueue to avoid racing with themselves. The race between
ipoib_mcast_join_task() and ipoib_mcast_restart_task() would be the most
obvious example.

[1] 8f7b00307bf1, "net/mlx5e: Convert mlx5 netdevs to instance locking")
[2] ipoib_mcast_join_task, ipoib_mcast_restart_task,
    ipoib_mcast_carrier_on_task, ipoib_reap_ah, ipoib_reap_neigh

Fixes: 3cbd22938877 ("net: warn ops-locked drivers still using ndo_set_rx_mode")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 402671567736..3e1e1e861739 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1297,7 +1297,9 @@ static int ipoib_hard_header(struct sk_buff *skb,
 	return IPOIB_HARD_LEN;
 }
 
-static void ipoib_set_mcast_list(struct net_device *dev)
+static void ipoib_set_rx_mode_async(struct net_device *dev,
+				    struct netdev_hw_addr_list *uc,
+				    struct netdev_hw_addr_list *mc)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
@@ -2160,7 +2162,7 @@ static const struct net_device_ops ipoib_netdev_ops_pf = {
 	.ndo_fix_features	 = ipoib_fix_features,
 	.ndo_start_xmit		 = ipoib_start_xmit,
 	.ndo_tx_timeout		 = ipoib_timeout,
-	.ndo_set_rx_mode	 = ipoib_set_mcast_list,
+	.ndo_set_rx_mode_async	 = ipoib_set_rx_mode_async,
 	.ndo_get_iflink		 = ipoib_get_iflink,
 	.ndo_set_vf_link_state	 = ipoib_set_vf_link_state,
 	.ndo_get_vf_config	 = ipoib_get_vf_config,
@@ -2183,7 +2185,7 @@ static const struct net_device_ops ipoib_netdev_ops_vf = {
 	.ndo_fix_features	 = ipoib_fix_features,
 	.ndo_start_xmit	 	 = ipoib_start_xmit,
 	.ndo_tx_timeout		 = ipoib_timeout,
-	.ndo_set_rx_mode	 = ipoib_set_mcast_list,
+	.ndo_set_rx_mode_async	 = ipoib_set_rx_mode_async,
 	.ndo_get_iflink		 = ipoib_get_iflink,
 	.ndo_get_stats64	 = ipoib_get_stats,
 	.ndo_eth_ioctl		 = ipoib_ioctl,
-- 
2.54.0


