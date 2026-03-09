Return-Path: <linux-rdma+bounces-17760-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMFxEoeVrmnRGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17760-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:40:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40223653B
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE92D3088228
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B637AA77;
	Mon,  9 Mar 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qlVtM7S1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FA33AD9C;
	Mon,  9 Mar 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048950; cv=fail; b=WrDHEQMHgdYMnWdDF9X3EDV8fRqKsa5Y687rOmGcLDYCzFygonyiZ7ZW0IgY8SwETV4CBmvbeDMRVpg5bxRXYWbpXBhjY8PGRSjfv2aWY1WegZA8Zkxgi54A12IvVUc6P1LzTMK6vwQaEJVN8epSdTR/baSyxwKnbslJTRyyMD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048950; c=relaxed/simple;
	bh=3lVyrFxKsm+hxTAua2yz50dK5RAFGvdof0tFA/bcang=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiKAqJFIQjaUXtczgLXSpT/8W703EJnTRzYYaPnYDtzCJGTo8VwBmXv2HWfKcnRw+/DTi7kMbyPRSe9ECswlK88+uRinEPZlVWdS6oNAl55YodB7xR1w06htfFyWwD6V2IynlbN3vBaD4AYvcH0ikd36+majA/Bi//7vPzHh2lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qlVtM7S1; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNwYE0G6b/6eQ1J352ykb413RHSAP6vdwA660aAmo2zacvjh5ar7Z4IFzYDKm+MT8m66ZgyhGlwawLsd61MURGM7D1MmzHbWIgv8FeLrfGPnODHMfn/vmXOO7IEtZvydsYbVObBRx09hlNt2XspV+ns93C9+uI/NpcTqMD+Kba4SuuaWdCujMTiq2yVUJkt6q4/5CIUlYY26OQ7XFfaIFJAosFnhb0cy+ueR6VPLHVOQ/lH2wRwWJXHSe4p5K+b4eAhtmxcEyrf6orfVNLN6NvImr4ecWgEvPtVD7AzVlAb93ff6TKqlc5FojnRy4Zxk5otqP4YDt+3jsAuibNfWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26udrvnR/u7mtxYmbvOFMlxEe2+M1aoM4GKQtMry0TU=;
 b=HdsICVDVKI6m/vH6jXEAqOCMA/xbV02ZPYS7ITICd9nOSP38VyfHqpGQVZ+KGuVd106U3+8w++/dyQBmzLpSN85zkq+7o68H9Ujq0DbzvvYijZ3g25c2Ft0OlSZmErd2xIL5no/+Fm1+9ctPCVCMfWMGk5HeIEt/3ZRYWdqX0ZG9B7D4FRqzMZVYxGjeX/mjhxiLVzLyIpCnzXk4Y2PELQLNw+Gt211IQ3A82jPKQw4LZIHP35rCJrxlqOLoZN3yL7o4gUJNMBgPWnv6gaPy4DkdGgR+w8WZ6kIWVv8ORHwUvBcWk+kWS2fldnM9SxV6QRTVfqfwjkdVyWISxkwrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26udrvnR/u7mtxYmbvOFMlxEe2+M1aoM4GKQtMry0TU=;
 b=qlVtM7S1zmTdxy+wJpeYsJKe9wCA/k10NROUHuXWMALs8MEyy7xIPPGtUY5zxHg9gYmqbjCErS9zE/DD8mVuT6ijEeGqbRwiBzuKpaeOAKAXo4UpvaRcTmbHisJVar16c+Mjyd1ZBl1uFg1vPYv5vqhoJ+TndIkN0rtYPvoGmi66tXT9wsu8rxl0ALv4Rmi7pntPynRaN7tt3qcvD6Xl8vQHii51O3WjZqdg2vYJEVw+YZtB06eY0EuLf7FRPCwrokP08qtaL6icu6JXwHKAtAnSDmkon38c4Jhsow2baBJGQa9mGA2I0kVivNa++hNoAvB18wa8VjmsNHIJnK5K5g==
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:35:44 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::5e) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.6 via Frontend Transport; Mon, 9
 Mar 2026 09:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:35:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:35:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 6/9] net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number
Date: Mon, 9 Mar 2026 11:34:32 +0200
Message-ID: <20260309093435.1850724-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 63db9bc4-b602-4328-b5ba-08de7dbf3c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	hK+1Hip6xzO/5IkZYY9F/885Ryq/w9uR58krqj2VzrvDbnk5rMkwQZRbhoiR0JcXC00ku9k6MLodeEY9/KMPrMWAA+0GPdxKMcuKbdrE73uJ7LmMNnVobdb4ylNvJnDfA97I9qcZ6xOJSt/pFGvorDgCJNtuQMw35CPLibo4kqY9fmWyTtWDt5ORWokThfUDg9HOe+Pd3JY1uC+CAOHx6UGTMeiZCsh7X+6rkazNRM5pTz5aIbMHr48PNzr7lNlxcoJrnkm7+l4ni1y1rARkuRwvSLjua6dO0To/BDqSYT3FgwN6ayiISuK7hMfmSOCrK9UZMw4IbnZD5I5sRpA1R3S1HkeSwHgHbyDmZliv6abwH2FVM6MVP+EHpxnvBIxMT2BDpYbjtrpF4ZZPWkxPuAYyZt5EXsadt76/LZh6ifJNrFbCufFAKASwVcgDsgI8A5vtRQ62fQnSIzpo6NrOQCo4fuvYmj/hsG5RJpyDPoe/7AV3SE6CxhVABeh3FvwCh3rO1nHBQMHx3fCvNhKX/IAlp2EhZCbjKutZI/15adJad7vPxgzzmNEsmoEKFlSBLIIbTX1ShJQ4mFzKEkT2xlZSQu415ZLd50zgrAr2QSfI6VW4vF7VoBcnvEi/sYuIzj8LUpqQiAplrxYKd/bWf74Pt1oMnv5fQgJ51c4cHKwXQK/ch7hAem6rCPS+lhSpd4zAMQOkJvK8xxW94OAX9s00CaICUIpXQiHuazWtiUZe2Wz8/pxOzFC80D2t3YIYEB6sz5kWO5y5JSpCJsCORw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iD818ilAZSBqrrd8UKqiGogLQWPePZ4OfB8GbyS9algRzFPvmCXZWjipTXUmbmn5XpDs+30KiyAHQcqh2Wb7A2cPirZN5IAAJzIZnXluXtzqw0AIQhRxlqxgKjDpCrURNMe3+i5kG6eoTG5KcoxgpeNuIThO1z1KSKVXyMeXwC5PzvTDJxgJqtwU/rHOVYBxJhSXG3YNLdhbKm7oXgOqLZD1kZxqK/Vjwt4QoaNEbzfKsdx/92C9E9GBk/UbrQd5j/NP2C2SsTmgeJ0nF4Qhtxh32QPzl/G36zb1b7quo+YkVz+qdjIl8uVVzAja7LMn0JVN5OJfBhwi5NWlohlI2Vo60efi/0S4AfTMh8V2FlLOmNBafivrsMMVsdLd1RUeVMwRaXomrTs07PGDzz9ih+kGIBugjzhiFCvHOMyotUdSg8K9AkWW0hf45UzmFAEY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:43.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63db9bc4-b602-4328-b5ba-08de7dbf3c77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Rspamd-Queue-Id: CD40223653B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17760-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Introduce mlx5_lag_get_dev_seq() which returns a device's sequence
number within the LAG: master is always 0, remaining devices numbered
sequentially. This provides a stable index for peer flow tracking and
vport ordering without depending on native_port_num.

Replace mlx5_get_dev_index() usage in en_tc.c (peer flow array
indexing) and ib_rep.c (vport index ordering) with the new API.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c           |  4 ++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  9 ++---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 34 +++++++++++++++++++
 include/linux/mlx5/lag.h                      | 11 ++++++
 4 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/mlx5/lag.h

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 621834d75205..df8f049c5806 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 Mellanox Technologies. All rights reserved.
  */
 
+#include <linux/mlx5/lag.h>
 #include <linux/mlx5/vport.h>
 #include "ib_rep.h"
 #include "srq.h"
@@ -134,7 +135,8 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 				/* Only 1 ib port is the representor for all uplinks */
 					peer_n_ports--;
 
-				if (mlx5_get_dev_index(peer_dev) < mlx5_get_dev_index(dev))
+				if (mlx5_lag_get_dev_seq(peer_dev) <
+				    mlx5_lag_get_dev_seq(dev))
 					vport_index += peer_n_ports;
 			}
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 1434b65d4746..397a93584fd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -35,6 +35,7 @@
 #include <net/sch_generic.h>
 #include <net/pkt_cls.h>
 #include <linux/mlx5/fs.h>
+#include <linux/mlx5/lag.h>
 #include <linux/mlx5/device.h>
 #include <linux/rhashtable.h>
 #include <linux/refcount.h>
@@ -2131,7 +2132,7 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 	list_for_each_entry_safe(peer_flow, tmp, &flow->peer_flows, peer_flows) {
-		if (peer_index != mlx5_get_dev_index(peer_flow->priv->mdev))
+		if (peer_index != mlx5_lag_get_dev_seq(peer_flow->priv->mdev))
 			continue;
 
 		list_del(&peer_flow->peer_flows);
@@ -2154,7 +2155,7 @@ static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
 
 	devcom = flow->priv->mdev->priv.eswitch->devcom;
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
-		i = mlx5_get_dev_index(peer_esw->dev);
+		i = mlx5_lag_get_dev_seq(peer_esw->dev);
 		mlx5e_tc_del_fdb_peer_flow(flow, i);
 	}
 }
@@ -4584,7 +4585,7 @@ static int mlx5e_tc_add_fdb_peer_flow(struct flow_cls_offload *f,
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	struct mlx5_esw_flow_attr *attr = flow->attr->esw_attr;
 	struct mlx5e_tc_flow_parse_attr *parse_attr;
-	int i = mlx5_get_dev_index(peer_esw->dev);
+	int i = mlx5_lag_get_dev_seq(peer_esw->dev);
 	struct mlx5e_rep_priv *peer_urpriv;
 	struct mlx5e_tc_flow *peer_flow;
 	struct mlx5_core_dev *in_mdev;
@@ -5525,7 +5526,7 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
 	devcom = esw->devcom;
 
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
-		i = mlx5_get_dev_index(peer_esw->dev);
+		i = mlx5_lag_get_dev_seq(peer_esw->dev);
 		list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
 			mlx5e_tc_del_fdb_peers_flow(flow);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 4beee64c937a..51ec8f61ecbb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -35,6 +35,7 @@
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
+#include <linux/mlx5/lag.h>
 #include "lib/mlx5.h"
 #include "lib/devcom.h"
 #include "mlx5_core.h"
@@ -369,6 +370,39 @@ int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq)
 	return -ENOENT;
 }
 
+/* Reverse of mlx5_lag_get_dev_index_by_seq: given a device, return its
+ * sequence number in the LAG. Master is always 0, others numbered
+ * sequentially starting from 1.
+ */
+int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
+{
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+	int master_idx, i, num = 1;
+	struct lag_func *pf;
+
+	if (!ldev)
+		return -ENOENT;
+
+	master_idx = mlx5_lag_get_master_idx(ldev);
+	if (master_idx < 0)
+		return -ENOENT;
+
+	pf = mlx5_lag_pf(ldev, master_idx);
+	if (pf && pf->dev == dev)
+		return 0;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		if (i == master_idx)
+			continue;
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev)
+			return num;
+		num++;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL(mlx5_lag_get_dev_seq);
+
 /* Devcom events for LAG master marking */
 #define LAG_DEVCOM_PAIR		(0)
 #define LAG_DEVCOM_UNPAIR	(1)
diff --git a/include/linux/mlx5/lag.h b/include/linux/mlx5/lag.h
new file mode 100644
index 000000000000..d370dfd19055
--- /dev/null
+++ b/include/linux/mlx5/lag.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_LAG_API_H__
+#define __MLX5_LAG_API_H__
+
+struct mlx5_core_dev;
+
+int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_LAG_API_H__ */
-- 
2.44.0


