Return-Path: <linux-rdma+bounces-12892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D0B3442E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E925418819C9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83973002A2;
	Mon, 25 Aug 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnKywy+L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB51F462C;
	Mon, 25 Aug 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132520; cv=fail; b=VSwA+vtnn4rl2R/g4lxYt4rWCX7GoMbeRmlPqFgDGSdHhOAMX5XvDeaX1zCVaXucJODpnEGmqFq7VYbk4UNZg3mQA2W3hcpr7IJXSFg5nncIIrsNV5VunJvtB+JY17sTgd/uq26lPGYawjn9P+zgrNInw242cPnIKnPCuSqQQBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132520; c=relaxed/simple;
	bh=BuZh93THeyQs5xqcYPmOlpgjuZGTV57DFBzRGiH5Ne8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtl9t4bn5wWMj1f86IuhRA6bt4/c+HOnqE8+6J8SFm6C0ZLbahu2Drq9VHoKe/ecjX3W25ncELO7qHxghE6wH/FFiud9tDOgooxOH/OAFCqJVZrz0J0HuK/t2WS2KKPdB/91lo0DV4OC2T5ROp6zwJf5LR8y6W5KYPF3xDFfQjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnKywy+L; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jovrEq72U171mo6PQ5qoy53F6mFxagMLOlZBzA43ixvQx85i/tIJf0qULHHnV5V2K8Uf56Bc+uLZDew0FGP2wzgbnCvxJfDjiuTjKRaGw0qsoHHTIWBe2Fm7gKYCISy+xDXpM/sWzYxprFxsDqNK8b9SCistmx4cMPDKUq2RGP1bUJHdMICDBOQRcoWwWplOm/FILTM9wUJx1c7QMmYBQVQA1RMMphXtrPoi4GBGdaUrO4U0xzKWzNbJ845KuBMleH3oJmVAAPseX5Iivs3p8q3YC3eH7b8qRYZP9D9nP5jr7lR8bLffDmNHIOgNZkrERgbIDQd4U4m0y2ddGOKOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu1Y+5QkdiK0Xoyelf4Nc6ETXfDa+kPiz86iUZo6ndk=;
 b=x1GPZzim4rVLpiSvzLNeV2iXzYTlxJrKy+n+B+P89/1muB49QrwSeZEGhJb/EryXRnpzuL5dlUkLUAc8DULavnpG2XXF4St65ez0z3xuTx31ssF9UqOER1GyWzZiGiizEwgY9KjfRo1CJbLKb7lP6hNEs1dZRmnF0KLDnEH+vWOClK+3zw0AN9mn+Qb9JdWavUgPhecxKJQJQRxohrCBLiJxZNAD4D4C7fooo8jnZ5dBEP1LDwxh7EzJciIvDWtLOisGI2T/KWoqeKNi3HVTWTD74KFzmY4a9CYs9QkCfQvXrMP68/EzCcYUpBnIGWSGEw0OwqvHSTMzaYt5tyZaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu1Y+5QkdiK0Xoyelf4Nc6ETXfDa+kPiz86iUZo6ndk=;
 b=dnKywy+LqlgS+nJlrFdeMBda9Hpqdvc6sfZbOZWwVHEC42Mxtn5sFOpfTp9VlBKJ3qP1KR/QCOLvDGLfXbjtDNKK++ro3RynGqZsYi8FI9KJfFlE3zEVlDew6vqgHOr9J+dbah7n6TE2iYSF6bZ/TFXlpPLKTIdGECH3y2X/7o4TRQ01XQefHBApfxEFOerBQTJRjNJijCF2HWbRVdSBFDxs/lWMfgCL6Huyxmc4TjOLIMiqy58vxzYfoig7HBBEAKc9igsKOjQxRRwc7pTMfcasWIOgEmtWKVR6ulq2decPIu5oZ0BA7w4YNCGxKGeLJ8TRscgYTt5B6xRx9WWEfQ==
Received: from MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:35:09 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::99) by MN2PR15CA0003.outlook.office365.com
 (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:34:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:34:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:34:46 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
Subject: [PATCH net V2 01/11] net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
Date: Mon, 25 Aug 2025 17:34:24 +0300
Message-ID: <20250825143435.598584-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7180ceb9-dfa4-4cdd-cec4-08dde3e4972b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8oHgUsor1ouvNv6/gpRSr/X9nlyewCBGtLfGalBW8NBMRh6vgvOXKOvOkxd?=
 =?us-ascii?Q?FzDzOf6sxFnNSAWTPhivf6lAwZtRByyg8yjm2G+jsFk67BpFIL0sAColIYoX?=
 =?us-ascii?Q?S2TJwLgzUWwAFMMh7hdyTwXEgvAvPyeEZjY2o6WaGNGd09tN6h3ZLb2iSLtt?=
 =?us-ascii?Q?jIyc3dAqaHab3AcMev/BYDvDKlRNbgH8oHYBO+8vb0tYAtLuoUqDDjo96tnK?=
 =?us-ascii?Q?FDmlwZEEaUu6BZfpd1PRak/OFmCHCT9n/DUgZndIWnaoEKfAgoGMouyQXIlU?=
 =?us-ascii?Q?AXMDE30wremMcuj8p98pyxEyV/NzWo+7RJ+UNulSsUKqbof8t2zUzRMZkWI5?=
 =?us-ascii?Q?FS/6yTMZjP2Kk1L0qAfjgCVseIgTlyEn9nZQmWg8bDQM5cYITUTn1gCMJpt4?=
 =?us-ascii?Q?PBYILKC5oFfOwM5/wkgOs5Y7SutaBIxatmbdaAyKZoLhCzr8hg8Lo1nGxDjD?=
 =?us-ascii?Q?s4mBUd4mt0wJwzcS9LyQAi/acLOR6S68TZmF2rRYapM+T4XMKexNQrlP/TIy?=
 =?us-ascii?Q?rJ50HzUIAJ0fIv3kQM2KmvrkQpjyXnuVLHiDcEefrPJbnK29psaVGHMCLBn3?=
 =?us-ascii?Q?JYhSCTQvLeMoHFg0+XkCK9dXtPEQSz/7PkQxN4ZrBBOFIn2QT0dxxdXm0rep?=
 =?us-ascii?Q?y1r/NQEPStKARl1QkV5mYOcuswHjIEeu4y9VKt3Lxtfedupq4fgMFPtKK25Y?=
 =?us-ascii?Q?qQ3ZhrYeWQ6f+nRQE8mSe5+rFM+dBeRfVgG11vn6YOfc/vMx4gedkzsEMMR1?=
 =?us-ascii?Q?7flA5Fpn5D4jV53Bpk5GpY6GJ4kGgfyAVmBaiWX8RSIDlh8V+23qHFPIEjGj?=
 =?us-ascii?Q?A5rsllSYFFay30yvQnHu3iSeiqb6fbbggXJB9G6nla7nZxTjr9IZ2hvHhJIq?=
 =?us-ascii?Q?74EgSFGJitgCwZoxYjHVw6nZ7uT4qZkPWCFO/8wrn6dn8hDCKBYbCBb3HYvV?=
 =?us-ascii?Q?BGSPXH1ZPV75vS8dLAK1nOIGkjGovNGBwD8SPTYG/MBwPaHv5gnr1GRjqJHG?=
 =?us-ascii?Q?aGrLo6bQP/VbMpq6m7EM5gjM58ZJsGn5FGejC6uniN2z4S0H4AtLz5yrwCrJ?=
 =?us-ascii?Q?ZNWXcj2N41bZYJvjhWi59uymfc6Yce4krCXUxwnRKf/cOKTdVzxaQtRLz4fU?=
 =?us-ascii?Q?LlEvIOyntrzhYMTYpEenHJXSnOqxtibFEcCC/fG504dxVJep3aCI+p2K7Bp+?=
 =?us-ascii?Q?3a+ZyXz2CzPgQdVDWZW050pHuWUZrja7pCtTDwAuEu4nYz9k4rwQXeXPNvm2?=
 =?us-ascii?Q?yrNAYjaQthxCGI4mLsvk904fvBrhXhtcDLWwhZSLZUsoz89T+WARHgO13KSu?=
 =?us-ascii?Q?HP6yonW3aV8PnZYDVKmwl4jZItlnuAmO4/IRjlUx7ILaTA67x62j8r1GvpdB?=
 =?us-ascii?Q?MziG3nSgzzo9otDMhZQUBisrevtPsZtVI06VrlnpKx/AhxajC9okalV3lZLY?=
 =?us-ascii?Q?JuB13LEMzGDlT5EK9KD43rBIOfU8qHBtIi0o2Ekd1wUav3gKdTViAvZWTBmM?=
 =?us-ascii?Q?8S3OWr5uRcvEXb/P88cvTJBWSs4hNSHDydri?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:08.2761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7180ceb9-dfa4-4cdd-cec4-08dde3e4972b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

From: Lama Kayal <lkayal@nvidia.com>

In the error path of hws_pool_buddy_init(), the buddy allocator cleanup
doesn't free the allocator structure itself, causing a memory leak.

Add the missing kfree() to properly release all allocated memory.

Fixes: c61afff94373 ("net/mlx5: HWS, added memory management handling")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 7e37d6e9eb83..7b5071c3df36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -124,6 +124,7 @@ static int hws_pool_buddy_init(struct mlx5hws_pool *pool)
 		mlx5hws_err(pool->ctx, "Failed to create resource type: %d size %zu\n",
 			    pool->type, pool->alloc_log_sz);
 		mlx5hws_buddy_cleanup(buddy);
+		kfree(buddy);
 		return -ENOMEM;
 	}
 
-- 
2.34.1


