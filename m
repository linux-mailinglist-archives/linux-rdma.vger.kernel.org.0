Return-Path: <linux-rdma+bounces-13376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A5B57B6D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E8D7B10F2
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3030FC17;
	Mon, 15 Sep 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRi37FLb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2530EF6C;
	Mon, 15 Sep 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940147; cv=fail; b=RMouTj+OEL4lPFsJ/l2lFyoVhtNWCLU5iuN9lkJpK2jyG/qCCvFyahQvGPXZ8TOseX21cYT1o5V/AqCqgpzIwz32tJj6X/9iVRF0HvrB4Q1Yjb5TqCveKntvQaSXfIqXJkt8qUjjDDmMkitBxDamsaj8Iu1cxOWOYjkg2dBXc70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940147; c=relaxed/simple;
	bh=Hav/e1UtRHqanpR9gsy2Ag+8UGxEeONUT86Mgz2BLns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoS14QZGUkLzB/VsHez8nBjoLkUUh2N8HBL2oUBJ4Djwnv4C0wbIaNoNwG79gDVQQ6/MNBOXAURoM3Slq5jo4G+7gomYH2dyf1L4W8TgN2/3a7aUbP6PBWJPBSBuszGIxn62w8qmCP6+ADcERbmw3CYwblfU43i85hbc9FAN+54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRi37FLb; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+kKxEAqJestnb+WiY9HKnkT2fCtmXLRzuAlyK7gsZsE7/BdqSMTFCVqPx1Ah/L3h97DbnFBY/mIEQvnaaARXzTIyqAVMfODhZWs3Q+wtuQoz0QyX4uAw99JSLbasRP0CqGjNXtgjueROPK9a+nEFeyw8vg84l8cVvOAJamjoQx1WPgP+IkC+p/WzLtVZN5yLDnoEUFp6jEgm0lU6Mx6+bP21o1C5fdCKXeSkJdZ5C4atONKVRZ/gGxaw5v4PT+4u8JjF6lZsyRAzsyr/ELpKXYH66Jc1ePO5Q1wE1un+d9+L+nrA+HzfsKZauyyjbM2hETjmkqvB0tJPGHMSw4B4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM1w+Z8M1DtgAMBznfpy+bQI1QHrD1dqnm/3dm3TbE0=;
 b=yR7Fy6k+jtITxUvUdn6LGzqPYNBRX4JH+MDsgrsZ8gBzjCUo7BKLNDxd6Cnsnwzub4ksnbE0vdbIGCM8iXwI9WkgCbaVOCpBWYHxzjMJ7uFqdbql2WRPnE1Csi54+v6XRenkVzDq7e74VqUkZOByg0X1N8vj1FHE4//yVCTj/1zeUSBPEAG1sIw2ebC9Y590r9rhwjUVNBUZef5LwXCb5UVSJXMGAgp9cKxoWnbiciY2+308haYlC08h+mJ1WcIiRZl8i69hZ8IpFHETUqblI35A1dzvTbkchzen7TNGSM4pfvSB3Xk45gyZ8vxHdWHVxyDmuTSIvbHj3NpRmNpfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM1w+Z8M1DtgAMBznfpy+bQI1QHrD1dqnm/3dm3TbE0=;
 b=BRi37FLb5rNZSf+eIhrP11j+TmGP42wJPzj6nMd8oi+ZeiePTlaYhOlgxoGq+tTNMUOW3v7m+F/ydTkcbNGDARAeiTQJhGGzfcIOdpcG2GfEZ8KavQKF8nVDzqBHuviqs4MLxwuW7KH6qHv3fEif3c5/sRbcCftUp9hgqTME8/D9bs8dQLdBDWXtHnaL6WtjGnIYBKkSv+ERL9Tu7FY1nJTXiMeJOGbh1Rgdgs0cb3NgBM2R4MNVnWVtj3+3xkEc9OUHZyybF2ZmKNoKySnO7ap/EaTcn81f2TMbJZhtjEgZJzvoi1FJiqlN+x5s0hJAqrpxA0V5WCNsljOebPyeWw==
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 12:42:19 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::98) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 12:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:42:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:42:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 05:42:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 05:41:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next V2 3/4] net/mlx5: Add net namespace support to devcom
Date: Mon, 15 Sep 2025 15:41:09 +0300
Message-ID: <1757940070-618661-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
References: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9b30be-4fba-4828-3960-08ddf4554ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9Qe5nm5fEn6zpQiaAzRUr60TuuTox9KAiOrN/K/kZlpoygZVIkCl03YBQTJ?=
 =?us-ascii?Q?7dLHiSyRfm3CwV4bPj6KJEG0wmSbYSAkZ7GV4KTKWXPdGXDFFYIYISili+Uc?=
 =?us-ascii?Q?B6vxMAyQtVqnWadRePXoMY+HHjXUEb+dL9ulhDEVM0Uw/jyNyP/uGs0AXNO8?=
 =?us-ascii?Q?zFDJkalv9AWo7Z6/D+FFhWhxJDDhG+us+gcJgN1OlAaBeI2GJnhjcW12Urtr?=
 =?us-ascii?Q?zH4xKFjIc7TaK5B0ZBU5wRx7U0V/rfqVlL0w3DOiREKsu/hHq5iTL1o8824n?=
 =?us-ascii?Q?+OS2PESbn8yjW0D83dv+0D3gHJFce/4TLdTsBECnX6EobiQG2OHCX4CNjAsg?=
 =?us-ascii?Q?BoqCjUHTd4U+ldbRg8PfCHw4K8MdAr6G9ZoTXmZa1vbkV62F6ihMOmSWf0ZM?=
 =?us-ascii?Q?9oT1v/jhBBHpHtFQ4Hz/RXudQWdMiO0OhAeTl1jQ0d2uDd+mtxmQjEhdj9+D?=
 =?us-ascii?Q?fAFhNuCAyGHLVwshzb80C9IAwC1BdAuVSq0uZdgnteYnTd4QABvT0ZnIFW8Z?=
 =?us-ascii?Q?ULw4qvHdogeLfO/fZrWQb2FH3snjLlXwRkPQV1ZNjjt8mKxMF00T1UHMin0r?=
 =?us-ascii?Q?6GY6RwKHDy8xy6gFZoPdMb/OdKGwCrgdh9TVhNFQpJNJmJxiBfK3b8hWxHaZ?=
 =?us-ascii?Q?Fo4eaFnaIB2DbXt2Fpi1xD651iLTi0b/e7unQmxnFLeP3ZCG8bWG+o8uS7xV?=
 =?us-ascii?Q?Kpgz4gbCKUXRZFmbLyxpEDEPgPTpU2OeOBsPXvy+G5NkazXMEvMlmSN2lKlE?=
 =?us-ascii?Q?D3dHLyj0euMv+4KbR8N+6x0q+fzO88WhvTc7Rt4UF+TA69ubK8w1jkA/RMvr?=
 =?us-ascii?Q?XIYkgD96SViysUJCguMgod5cdYMwlRPJfnNLWH3WtaopboQqn0f4z74yv9/6?=
 =?us-ascii?Q?A2SOcno/8a3qV+xmnHlyJ4HQbvpg1Mov/5IoZvGgtdaD0eOvN4CNUBfpS7yW?=
 =?us-ascii?Q?e3gY90j1ZDmBYKWQS7YCf83297maIVJVkej5Zbwxl7D9v+6R1OwSpBG8xtpb?=
 =?us-ascii?Q?r8S89tL+nGXBL3e1s6ph5fY45X5AuRo66Et7+RrtGpqg2iWvhAOR0Rt/MrC9?=
 =?us-ascii?Q?UQIQpNeFgBCZHD/tpL8ZEbzbeHp+Qfv4e+/NYsxlpv5GsEHR8MNG+BQaROQl?=
 =?us-ascii?Q?l9v8AQCaU90oxiHeuDKnUhrY4Uafz9QJHIAR53xPMPWej1tUsQdeKYM/GkzB?=
 =?us-ascii?Q?nnMC1pgLbk8YgqZMOPhXlNOTmuP1mjkTDaxNaf3uzU4GTQkrzJ+puXXzwnqC?=
 =?us-ascii?Q?P6lmG+wqZy6zsethxzzPxM9nu1HND3zctJFzT5snwjNfUsozQrBZDXzIVH+o?=
 =?us-ascii?Q?cKZIdVtXuNin6xAdQUUcRNk9uUS4NQMu8X7m+zfk0nrxpDK8edaZlbmfNkxJ?=
 =?us-ascii?Q?Sr4nP2QhIL7/gnXDBLsCbK0SdaSYqG/DCDK2h4CPxdYZmsRtAla1PdvRGqVO?=
 =?us-ascii?Q?SHZxT1UYr4Z2N93jv077J/7f4bUrLgmT7RXsqIUCAoun87GsXXmlVp6RSy5B?=
 =?us-ascii?Q?HcLnNKILUpZHnTdldO/jP9UhNGIcQul7HluR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:42:18.7647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9b30be-4fba-4828-3960-08ddf4554ed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

From: Shay Drory <shayd@nvidia.com>

Extend the devcom framework to support namespace-aware components.

The existing devcom matching logic was based solely on numeric keys,
limiting its use to the global (init_net) scope or requiring clients to
ignore namespaces altogether, both of which are incorrect in
multi-namespace environments.

This patch introduces namespace support by allowing devcom clients to
provide a namespace match attribute. The devcom pairing mechanism is
updated to compare the namespace, enabling proper isolation and
interaction of components across different net namespaces.

With this change, components that require namespace aware pairing, such
as SD groups or LAG, can now work correctly in multi-namespace
scenarios. In particular, this opens the way to support hardware LAG
within a net namespace.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c     |  3 +++
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c    | 13 +++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h    |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c    |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9874a15c6fba..09c3eecb836d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -66,6 +66,7 @@
 #include "lib/devcom.h"
 #include "lib/geneve.h"
 #include "lib/fs_chains.h"
+#include "lib/mlx5.h"
 #include "diag/en_tc_tracepoint.h"
 #include <asm/div64.h>
 #include "lag/lag.h"
@@ -5450,6 +5451,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
 		memcpy(&attr.key.val, &ppid.id, sizeof(attr.key.val));
+		attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
+		attr.net = mlx5_core_net(esw->dev);
 		mlx5_esw_offloads_devcom_init(esw, &attr);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 1ab9de316deb..faa2833602c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -4,6 +4,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/list.h>
 #include "lib/devcom.h"
+#include "lib/mlx5.h"
 #include "mlx5_core.h"
 
 static LIST_HEAD(devcom_dev_list);
@@ -23,7 +24,9 @@ struct mlx5_devcom_dev {
 };
 
 struct mlx5_devcom_key {
+	u32 flags;
 	union mlx5_devcom_match_key key;
+	possible_net_t net;
 };
 
 struct mlx5_devcom_comp {
@@ -123,6 +126,9 @@ mlx5_devcom_comp_alloc(u64 id, const struct mlx5_devcom_match_attr *attr,
 
 	comp->id = id;
 	comp->key.key = attr->key;
+	comp->key.flags = attr->flags;
+	if (attr->flags & MLX5_DEVCOM_MATCH_FLAGS_NS)
+		write_pnet(&comp->key.net, attr->net);
 	comp->handler = handler;
 	init_rwsem(&comp->sem);
 	lockdep_register_key(&comp->lock_key);
@@ -190,9 +196,16 @@ devcom_component_equal(struct mlx5_devcom_comp *devcom,
 	if (devcom->id != id)
 		return false;
 
+	if (devcom->key.flags != attr->flags)
+		return false;
+
 	if (memcmp(&devcom->key.key, &attr->key, sizeof(devcom->key.key)))
 		return false;
 
+	if (devcom->key.flags & MLX5_DEVCOM_MATCH_FLAGS_NS &&
+	    !net_eq(read_pnet(&devcom->key.net), attr->net))
+		return false;
+
 	return true;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index f350d2395707..609c85f47917 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,12 +6,18 @@
 
 #include <linux/mlx5/driver.h>
 
+enum mlx5_devom_match_flags {
+	MLX5_DEVCOM_MATCH_FLAGS_NS = BIT(0),
+};
+
 union mlx5_devcom_match_key {
 	u64 val;
 };
 
 struct mlx5_devcom_match_attr {
+	u32 flags;
 	union mlx5_devcom_match_key key;
+	struct net *net;
 };
 
 enum mlx5_devcom_component {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index d4015328ba65..f5c2701f6e87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -217,6 +217,8 @@ static int sd_register(struct mlx5_core_dev *dev)
 
 	sd = mlx5_get_sd(dev);
 	attr.key.val = sd->group_id;
+	attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
+	attr.net = mlx5_core_net(dev);
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
 						&attr, NULL, dev);
 	if (IS_ERR(devcom))
-- 
2.31.1


