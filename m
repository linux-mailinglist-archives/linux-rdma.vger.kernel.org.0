Return-Path: <linux-rdma+bounces-14834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3BC94DA3
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8BB3A4AAF
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04D427A927;
	Sun, 30 Nov 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wbg7q09i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154B279358;
	Sun, 30 Nov 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764498392; cv=fail; b=MhtznB2OQmLEtESRur7+HED7ZY/tT28j1eE9OUcJpauaYKmtHJqqIf06SDPPXNCg0wGE0Q0hq0efnZu/mi8IM7C/F7G/YMiZz/s7TI9JuhR5WQECOQWtYbqRkKDMN9n/5WKvTn3liQ3UzN/gufzUZNNoyHTqK9zxzqueVxxNxkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764498392; c=relaxed/simple;
	bh=jHukrPf8WYbUW/CHyYFSOb4zbZImk3Eck+exlHwNcSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV1QmOF+fHbPLizAYCX3jbkbFVtZx7cCusxJbP0dPe6D504pZH9VrBF6jwVM5Dae8u4Xjgqu70MxwEbqUj+eUIfzvJHgwT42lE9tAkRQj1L+ZFHMkNJdDSyNtEmeTI0nRMqDHut6Fwj+H+N2zt5nw/QPe8Vp0kZ7fjjo4UJaS3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wbg7q09i; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft4LwfuDIL7Ns2QQ4vfn/vMpxkNYgN+peiphN354kKi3c/vFNDDIJKn/MWFzaZhVTv5RZajyY2DQ/5hRIeOjKfHzwJQSG9pPefv4SW0d0jN9anXzYSGlMt/oFslHjEGzHBhUE8Dq4iaMxXzdGbhPtz1a2G6umnX6EU0ktl0OhpAmvYPcioNTU5xYTf5a8PXq1+KwT+jZlnb++9nTNpLvWPp4x3FY9If5h5ceG4NflrJds2g6oQ7brjPo4Awe4aD2qkLho7JVOxaxMRFlGqc5WGaIq7CdZrV+puDfa3zA8LYBWEXHfDaa+8/+dOvNgQzlmEGMqromBgb8yqP9bPA8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lotUK8O6lnZ6aWTnRHt0FIuF7xfWLoUP/ZDPeszbnNY=;
 b=r2mBkDKtUHO/RxirZz2ubort+ywpMxxbG5koNdpM80LQavS/+7u4fJVOZnHWiJH1midvN3wHkqNifWwIM04JLUhB+u/k6rhUe6dMJs1YZqec84iwWpEOxTJzIQhRfp2w+ezcTITH2YAVlliTy6gMUsdBiEDGLAS+xzZOeP3YEkIUtF5h1T5iUmhLqL2ayibit/AvSSa2MsQMEFLxSxsdKwIAb/ItSw0fXYGblRzPFv6X5S6dvHjhinZfaYfCP5TcABJhJYjMTsLTQpgF+3l7KvRQTtuEfyy5Wt2w/nYp38ciUpJIX65qP0Ss3DIahJ4zU8nQZSOyAweb4UZTTlBBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lotUK8O6lnZ6aWTnRHt0FIuF7xfWLoUP/ZDPeszbnNY=;
 b=Wbg7q09i5nRALwqqNIPUF9UCIO8HRoac/6VNBRwoVgC9MlIwJon9mY35TUzHZzB3rmKqTCQoU33SCB9SyQrYb+WeOmyvFur18CNQrhLAoJj9mU35T7S3eXz62wjO30Vd7UYyXkCIZUse97MkinTOSelmPXBB8uXfkgZilGd2+dFQNAlqZiBsA0LPMQUQetLQpSVa5aWzzAwJMRnW2km71yF4NtbL8yulc8Oq++0HS/opXLpzO++ZtoC8akv7gY6jVOCpDhdku7zOjE2PzAeLwcMbXtsMO54JpFYH5hmBxuFuxmN7KRQl7VZho06C/2QvEy0CNuBMdgSl/SzAsAjxwg==
Received: from BY5PR17CA0012.namprd17.prod.outlook.com (2603:10b6:a03:1b8::25)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:26:25 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::95) by BY5PR17CA0012.outlook.office365.com
 (2603:10b6:a03:1b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:26:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:13 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:26:08 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH net-next 1/4] net/mlx5e: Use u64 instead of __u64 in ieee_setmaxrate
Date: Sun, 30 Nov 2025 12:25:31 +0200
Message-ID: <1764498334-1327918-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
References: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: c277ceb8-60d6-43c1-9121-08de2ffaea76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12aOuUDXq2ty871GKIM7ZOT8HiFpbnMEhiqDK1y/gTD3l3WeyBaGZ1RcsVBN?=
 =?us-ascii?Q?vi7MCkzHtGkr39aTqLR1JwPuz8XL9zO2sZTZ1ZEUOfgJnC8RM7sWxa8jkWRD?=
 =?us-ascii?Q?fyh2CZ6BuSmTPI06p7YV+9r6DbrGOx4SADgJpshv86S2FbzL54BtNe1Xzjtu?=
 =?us-ascii?Q?Nw23hsFKV3jI1WQ4e5YD14YY9W0+XbLW/Qw4hRaYG2UK58I1VqnZ81LFPdWd?=
 =?us-ascii?Q?szaeQwr4Lo8+/aBFuPv0n/DP8uCmS9mCfPPBGPx8KSMm4DYVDzv/4jcu39oV?=
 =?us-ascii?Q?+tZrhdvuMLgclo9vbu9n9hI+1VcbJbxLvGVuwbR5B7s1j1OoQy5BeiAmt53I?=
 =?us-ascii?Q?5CggD+NckYo/jlaJBLgV5AqdxDpi55YQX4Jkea2Mj1//k9lB4QWRc9NK9bm6?=
 =?us-ascii?Q?q70WervuERH5Bzh+RFmEtHJJyC9J5/MdjUSm88JN1Qfb2t4jZt8ljOfPJOwe?=
 =?us-ascii?Q?Z6HfS5QDpRTiPuqAgVep5jqK9lNHdPdqIMnQ+ng8wCTmhkSrL1Gla/FDv2Ot?=
 =?us-ascii?Q?Vl8dbayfkuNyajSjmCdJ5jITNxvtbPYA4kQXsgODhvYIUB9kb8pc3RFM7uLA?=
 =?us-ascii?Q?1IlUkwfZh/omTxv/RWKxxJFI9TDO7lSKPOuviwaHIn7CQM2bdVSrSTitLs5j?=
 =?us-ascii?Q?KGr3lXC7ir3AqT1mNSeOCo0w9f2rPwaHhZyvwGmnTvOiDUCQRYhIgqBnhyig?=
 =?us-ascii?Q?IFeNPwsJT2ICyTfARZlDIyYqSm6UHSvvaVWNIcj+v9wUAh/Vz4/TqXsjTmW6?=
 =?us-ascii?Q?56JgTyCBPKrSp4lf07heyRy4cppcjawN4SpiSECioLXqCrfOa21v/EhbWTJL?=
 =?us-ascii?Q?RhH+5ZsrWdXYi9cOu8crVjyQo4HhUBIeWr+kRMJNkYq6nTTpzx68QikPvXzV?=
 =?us-ascii?Q?VvUAVhZ8aYqPv7c5wriXoKnyI1ShgHoDs4DS4I27QdMwlPx5aSjedyUA2/ZY?=
 =?us-ascii?Q?6IJuz+2IDnmKsyhVCSaTdWnUCoNdDj9UTWzv6GvgPqbaak1kMnfiQfvcuXbj?=
 =?us-ascii?Q?/roJb1cUUr0GxhDAXMAONdWnosVHtGdTmiZa3f6BzP0aosFOgzZdKo1T2R8M?=
 =?us-ascii?Q?JOd1MVGc4SIchAJxP5seet5jSKO0msB2285X5B0ttTG0oXgFu4uRn6TO+0f/?=
 =?us-ascii?Q?fW2zz+0tYQOHS3a+iv+69ojGm8pmrMprDP7uI7lCFVfZEBYF40FwUzcB/4JV?=
 =?us-ascii?Q?fKizL5y36Z7MNciTyC7ZIWVji4zItOLMSj95xHxVjs+cUA3xZBeYcyd17PP8?=
 =?us-ascii?Q?3VXoh7lO6jEuyVZnwEV+zSnXZMq4ISEnLtmTFXAIzbpi7gv/qyufRzun8e9h?=
 =?us-ascii?Q?sXprYrektTj6iAKqsWikUhI+kdMPpJM6iGDke5p7ZLUz3yd3KLdZNR1Ye25o?=
 =?us-ascii?Q?O06ckd13JIscb48RcNsUc0xTVEx/CKZBKw0AVMi7pIEuCYWT12LhG4uludBI?=
 =?us-ascii?Q?cNNN1+YZ7CafBRM5iBA19ECTzQpggxXapAksw0MNg7j6l1oNamScz6BiA/MD?=
 =?us-ascii?Q?vH9fXBjVA4Rb+jlkmiLgXe2AUv/Hn0mPwhGwmqHptJW6Si+W7Anz4zg8BE74?=
 =?us-ascii?Q?Dl9i01ICb20PshD3gUc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:26:25.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c277ceb8-60d6-43c1-9121-08de2ffaea76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

From: Gal Pressman <gal@nvidia.com>

Change upper_limit_mbps/gbps from __u64 to u64 to follow kernel coding
conventions.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index cf8f14ce4cd5..dd491fd8162b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -595,8 +595,8 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
-	__u64 upper_limit_mbps;
-	__u64 upper_limit_gbps;
+	u64 upper_limit_mbps;
+	u64 upper_limit_gbps;
 	int i;
 	struct {
 		int scale;
-- 
2.31.1


