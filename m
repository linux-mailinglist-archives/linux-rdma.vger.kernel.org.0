Return-Path: <linux-rdma+bounces-11985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C941AFD98B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E957B7669
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D39250C07;
	Tue,  8 Jul 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frPDSrf0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50188248F51;
	Tue,  8 Jul 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009434; cv=fail; b=I8hVZq88tI+l6r+4OYfmDxwHrRq27imy9U5iVOk+SzZX+E2C9YNYG3HTz88jlEUvuo0uR/5DNfkd5sde6n4oh8zudNllM15d0h6XHMj641gnoCIZpk+PDLcqtGgTjer650lvD4Af7CGroo902mNNDpXPzZckJVlxtQQBzK8wlP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009434; c=relaxed/simple;
	bh=o04aJwUG6N9O5xfb6bIop4m1HhkSzkKSHZvNUCFDwLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvIPS3Ixi4kZwBCgFcTSVvQ/PfOgpEsrAVtzsH3SftDWFNrDwwQJkd/hTCJg/GzyiJwc2doHxo7TzjkpvpoZhE6RwpvCI4USzGW3ZctWIyF9Gl1ZDIWdXbSLP4zbnJZsXRwHvStxucbS0OIYs/CyWQ+RDcesoZbrYTUedtDas7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frPDSrf0; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLaWnxAm6+cYXBPEsIuCojpL7RI18Ydq59qfCgtqpThHFOx1x4LjS6h/ZLdg4OwERzigmMur1s15Kxd0GnB03WVrzyr0PipAQ3Pk84wePslpDGPUaxak62Atq3unBucAEFfYUj/fA1j9evenZT//4PBlfSUjfRJfvw6zpZeyl7w4J61PKkSNS/jPvlXXWJjw0WnWU/2ZRVzqdRZpF1HfRstBy5CnG3S7aLHD6b3Kbhd2tiiSPRT9tiDbRaxEYaAu19WWc658sKMd5ureO1SgmVUPcx78vNGSSZecnvxh6wYucPhwzru9scEXym7qTe5ZCFGZrOBU2v76PkjqOB8GMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqC3nJRfA3U1fbBzsw4eH5kcILbfNdkviuEi6eObJbI=;
 b=TKYvI1UQxfWFaSVvn24vM9nmvR0EmCS0LUHYAGwKBh4r8t0EdW2FPxAnBVQhqayMZWe7XDUDd5xCAhdfzMzobWjrp6n/kmOjOqBdR77uGcWPFblfidg0v2dKrUaf4Yuw6fYtO9KpMNFYno/dbvTkCGj7zYiwo/XrgAxnsPfsHPmI8GBNHAXpH40tvbz+pZZANk1T7RPZjpoZBM6/pdDLJjyVKjUcVtFE556wgT/QVd/dWU5ofOiWXOytJiD5OMHCCRiUA41hTcfIl/lhgSJ7FLmW5zsr/N1haiWCZv4hbhtYa4TRNyfa2bhCZ7IjJhQeE0gD8VnMbCAfGERdfNP02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqC3nJRfA3U1fbBzsw4eH5kcILbfNdkviuEi6eObJbI=;
 b=frPDSrf0tebI6W2QOSTceAzsfT17x7wD91mVTEBzv0lK43YqIjl7hadFgjL+J7+iFEchXcpXmh7AhUYFZGO/Avl2+BEG5lDS6JiUegpWp5bnD3ud8HEKhac39pouDnap9KtQ3nm8QIiHmREknG5hbJLtQ6zxNGN8MuxarH2kgq0A5ZKRlwelSEstIgoQpjdg1ZLp9nvVS+EQxpZIoy8K/tHQUoWb21eezgsji7qD5hdBOvVfi9w//jCR/aBcBw7D4Yi/kVNDrokZAPgMoZXYVqk5Gs5jsVmUNPaEjxUp5UVkQR6eMALsKqwWjXmokQhAS+Cg9AIuBnYsInZaKlnbng==
Received: from PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::20)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Tue, 8 Jul 2025 21:17:09 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::95) by PH7P222CA0017.outlook.office365.com
 (2603:10b6:510:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 21:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 21:17:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:16:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 14:16:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:16:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/5] net/mlx5e: Replace recursive VLAN push handling with an iterative loop
Date: Wed, 9 Jul 2025 00:16:25 +0300
Message-ID: <1752009387-13300-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a366568-165c-47c0-266f-08ddbe64cc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8tlFdkXNzmEBlElplBdkBeZi/yoG4rE9rZcwcdxfkOTcneH4YYEFkl4162c?=
 =?us-ascii?Q?B3mnhvjhRxBgDQXxxYEV9WbWBpAljrsrdx2Yer3dyCNmZ2xUHIvtseYxYlau?=
 =?us-ascii?Q?Sx5+jNIwugjTvmKjlMETb+ubDPNnQqOmwILtfdtIzAbM42WtxuKDNbVs9y2a?=
 =?us-ascii?Q?j9VXHVXMOTLGXSPkAWfoit5bwaqGv34Tp4v+1Nk8V9TWbhvZKm40EmYPOy3r?=
 =?us-ascii?Q?a9HXgocl7AUQDlfQ0GB3jzebXhIEHdp9tTMXasYQ631BfcBylYgX49VN5M7g?=
 =?us-ascii?Q?3TUcCW/0ZPu9HTYzlUuKnLuB8IIyPmsiadi2kCf94tgfU/HQYO5JXVgIIslw?=
 =?us-ascii?Q?+8RcUeDXmyL2c/NXqgswVhVrgFIK7Vdx+OZgNKxWmfgAvlgeTjzMtCjvBp5l?=
 =?us-ascii?Q?1Oh5i+d/8vnhIqHRZYoWFoRVxygD/CUoEuaNxupE2qo3FtORmyotj9+WJCLY?=
 =?us-ascii?Q?hGJ8eiFGjfEoo8UdnnhhjcsP2sKqyw61yg8D5F8a2234oXK5NLpUUhKqK7Bo?=
 =?us-ascii?Q?cGlW3wFa8LjejMb9Ei4xTKUjrovgGzNSOrRDJEeP5A4+MAh0TWsG+cCqKq68?=
 =?us-ascii?Q?gYVlSyLtnYcl1H+Vtz5wMGr0jbQvBG3TKgPcqqZnWv472eMnAhH9lEsNspgn?=
 =?us-ascii?Q?S2gMSWtOt82aZtV/oOLpF6SZowkzk70SUOMUhnBOVg+qHC4IxVBzQhpyc1yE?=
 =?us-ascii?Q?V2XEYWBVhpma2dUVe2C25SxOukQ2XWkhE9sEzooh5os5p8hJURcyjjd+mBYd?=
 =?us-ascii?Q?hMv4CGRY+IaKpXPEblSp8RYTJzsyB/rNY2V1wmh746Hozzo35amu2Dx6TApJ?=
 =?us-ascii?Q?WTblRQ7NGrnZGQkP6GTG3StQlBinMGwb4Sx8ReB2Gy1T3ScmBiIcaCzwp07r?=
 =?us-ascii?Q?Fkw3gCC9r6kGFkNPzxo4XaH9+uuxHQgTDHVQz1yAa/xszrelCb9xDkXwGeeB?=
 =?us-ascii?Q?RwAZ4DmpDt5POoz7CmmR52rfK0Zb0KdsTHbIMZ6X2uLYktTrd2bc4/u8M27l?=
 =?us-ascii?Q?PyKHQRyIJG5oqU8AKKsxkOXccSzHh46RbMp9H66rYkTCqzjGr3pbhcy4dFz/?=
 =?us-ascii?Q?q+DuLC8ym4uGEum9H/dzu06Ms2h09NDA2A+ZN68Yz4V/NkzltZczx/Zf9+sJ?=
 =?us-ascii?Q?HTXdc6MF86vvOH5WHwFbs6n4+2YVGRZY5MrEVNGgVQ/HmqdB38DKaP0Nkq7S?=
 =?us-ascii?Q?WmN/xpPFGvo5DWpJuYknNMHBmeBAYAD7tjecrhYl8bPqau4IVswesF+i4FJD?=
 =?us-ascii?Q?oHCVv/5f1m5o7ztzi7YSkRt/u/BP/1pLrSvSj3agZNw6fFzoGHWhswmvuZf4?=
 =?us-ascii?Q?FsDH3AijOFBhsHRhCBiGdDp6S9GQUvdznc6/+ygVLzE6WRhtG/CS9LyfmYTK?=
 =?us-ascii?Q?NkVB0NmFW+L8bdEZwBj+a9cfONoL7sP7cVWSQw2Y4T1O2xumiiupUawx1Pmv?=
 =?us-ascii?Q?2rU1OVcHDWhuFgiF2rz1ORHj0gnoW4731TLz7nSYGIFiole/xz2XGSgfNpKN?=
 =?us-ascii?Q?7wanmr6BrlbxKe0lbXgqafz+VbDxG6ar0Mz5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:17:08.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a366568-165c-47c0-266f-08ddbe64cc18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

From: Gal Pressman <gal@nvidia.com>

mlx5e_tc_act_vlan_add_push_action() uses tail-recursion to walk through
a stack of VLAN devices.

There is no need for a complicated recursion with unnecessary stack
consumption and less obvious code flow, rewrite the function so that it
uses a do while loop instead.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/tc/act/vlan.c       | 43 ++++++++++---------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
index a13c5e707b83..9bdb5820c553 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
@@ -94,29 +94,30 @@ mlx5e_tc_act_vlan_add_push_action(struct mlx5e_priv *priv,
 				  struct net_device **out_dev,
 				  struct netlink_ext_ack *extack)
 {
-	struct net_device *vlan_dev = *out_dev;
-	struct flow_action_entry vlan_act = {
-		.id = FLOW_ACTION_VLAN_PUSH,
-		.vlan.vid = vlan_dev_vlan_id(vlan_dev),
-		.vlan.proto = vlan_dev_vlan_proto(vlan_dev),
-		.vlan.prio = 0,
-	};
-	int err;
-
-	err = parse_tc_vlan_action(priv, &vlan_act, attr->esw_attr, &attr->action, extack, NULL);
-	if (err)
-		return err;
-
-	rcu_read_lock();
-	*out_dev = dev_get_by_index_rcu(dev_net(vlan_dev), dev_get_iflink(vlan_dev));
-	rcu_read_unlock();
-	if (!*out_dev)
-		return -ENODEV;
+	do {
+		struct net_device *vlan_dev = *out_dev;
+		struct flow_action_entry vlan_act = {
+			.id = FLOW_ACTION_VLAN_PUSH,
+			.vlan.vid = vlan_dev_vlan_id(vlan_dev),
+			.vlan.proto = vlan_dev_vlan_proto(vlan_dev),
+			.vlan.prio = 0,
+		};
+		int err;
+
+		err = parse_tc_vlan_action(priv, &vlan_act, attr->esw_attr,
+					   &attr->action, extack, NULL);
+		if (err)
+			return err;
 
-	if (is_vlan_dev(*out_dev))
-		err = mlx5e_tc_act_vlan_add_push_action(priv, attr, out_dev, extack);
+		rcu_read_lock();
+		*out_dev = dev_get_by_index_rcu(dev_net(vlan_dev),
+						dev_get_iflink(vlan_dev));
+		rcu_read_unlock();
+		if (!*out_dev)
+			return -ENODEV;
+	} while (is_vlan_dev(*out_dev));
 
-	return err;
+	return 0;
 }
 
 int
-- 
2.31.1


