Return-Path: <linux-rdma+bounces-15450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE0D11951
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C91311C599
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5887F34D4C9;
	Mon, 12 Jan 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aF3J+lwW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DB34AB09;
	Mon, 12 Jan 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210880; cv=fail; b=JEJ6cP6pw9urld1cfL/KEQvqF1DmxM4rGvkZgyO3DZdY2PRJdU99HhZHp1YOyrywG7SgasmO1c8V0qgzM/UkVoEBe83xcaHL7plgxbDyrQXeEVU5Lf6jlTVlSueya5WjpMKYpAAmRJsVq6E1oLKHgSW51EmuwAE64V6cZBdPdbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210880; c=relaxed/simple;
	bh=M0dC8ftDo2ys1vt7Cl/ni4LEncLNXRMoo4qs/zB83WA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgiqbkQGc29zxafVt8DostgA2LaKurfuewnws9QnfmJ54fD6m9AD8IvMSIBHMe/8BburXWvsW7FW820A3vKLLl89StTYtZNarHxxI0gNNqMZ6NgfgmHwyPH7d5kefxB2G+8JNW2RFLdhPpmch4KESBpoiKJS/E0w0oEsz7nJVSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aF3J+lwW; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWgKb9GA1G6bjyDbjK+itjau7H+dHP4X7yKxPz2FGin4Sh8Al6VaTrsJIjNqPVmFMaKUn3TURml4wGczvejaTOLqRt2j2qVXYJ9QVutbcQLNndNfS1K9Ub7c9CkAVNppjaqaGP7gFCRYOCS7HjYfX3Bs0dm6O7xs22CRW463x8AimNpC+fyGsGZXk8a9yjU7SGtEVvJXQ3MKwxxzyOQ02lxEFOChuN5aSmMA1EnVWXwbqfy46Cuya+r05aDer7FLvUE+3jt/kKnYWFieI9WbReegWZzw7l3e7AbXna9yxI/dgMzIkIwGoGrC3aoUzRj5hIaSenXDox47FPXydWarzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANjacQbri3PxJY8MiZJSO5BRqI0rp0n5/6XuLJyCEKU=;
 b=RZFVKzmhKDFeK91sTaxFgooZkkKLc+zcZMP8zDYP3SV1M+GY0sP0Z47Pm82taPVHBQR5WLVJzdJu4vwB1xRYPhpw94kmoQWDDQ+1v+J6xD2bYN/NNMm9cdWR5VnXVrFKYWcWzk8jYe3ZQAXHFYTZg3RgrhpGiXduDkpke41iUUQyyrIjYp7sX2tLqoIBr4i3pgoyWJFmFs7KSQeT1APdVsiGrstvyjw0H2/6BEyTll+UTBHR5hfJgS5f7gc4JUOLHsBA115DeHIa66DL/ZzGYlY8UkK/+d+OkKM9/oWSW+Ysm95gRnoXRe/KFV5GBZG/7e5DG7k/lcgO9GJvjUP3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANjacQbri3PxJY8MiZJSO5BRqI0rp0n5/6XuLJyCEKU=;
 b=aF3J+lwWbb9SXX14UVvlpY73Ils4UX+cR4RgCSSIKOLsrYsRq7+jcp/0+MyB7hzbCbjgNWKIHlBKzv8A0KC0glCZuSCUvMtmMNprHe6NERHLY8fkkpSx4d+omLQEbzP6mej+6b7S+eaHWCeGgidG42hhcKeY5idAOzUe0crkkM6gXNr7KQWNhrOySI9MHusIcmlW1wkgeFrRUAvbQ1aLyGMNQ6MsGFRFDUKvV1MPz96sZ7c6QWLhyrSe0aRrZdML3RCJqX4y++JzbvYq41mAwWDiFyP1Pzp7xHIn4D6zuVNYKJtNYAykmkYng1iwo8idJApUAQfcRimitlVDKw7Alw==
Received: from CH0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:76::25)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:41:03 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::3) by CH0PR04CA0020.outlook.office365.com
 (2603:10b6:610:76::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:41:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:47 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:40:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: fs, split bulk init
Date: Mon, 12 Jan 2026 11:40:24 +0200
Message-ID: <1768210825-1598472-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
References: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d248e3-2d72-4e4a-1aba-08de51beb3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ha7DwaZGNZolD5OXi4ZTLzrp5hCWecyOb9fwS4Sj0a7EJ2JZDf8RgEREp2rx?=
 =?us-ascii?Q?+AHUFOiejbTtScMR6uCgX2QR+nGqDD7NTV7OgsDWisE7Q2uC6mY363Z5VKa5?=
 =?us-ascii?Q?uCfEg7SD1sA2V1XPiGkFqTGhptbFKiJNyuNWmcuCRioQ522321/mKYdgXZ0w?=
 =?us-ascii?Q?bI69CcRy+nhFvxsfaHV2jlp+jBD9fjnREpbPPlZFV0EsPOcNtkF6ydZgeyAy?=
 =?us-ascii?Q?17XRldjYOypxwg1niypvnEeib0fE5j4FChsBE48XiRKnxRihDhcbZ7Q+oely?=
 =?us-ascii?Q?N0dE4uf8KV0J0NckrW8qe0bzVCrOh32idsLdL52BkOtSJnGU4JSg7pajtr6T?=
 =?us-ascii?Q?v5fEbqT0hzstXayHJp7mv0u46Hh7PgYCNaWgfvjHmtgJFARLpsJFObVD+auT?=
 =?us-ascii?Q?dMrpQBFZUl6pcqcqwVRJ5zE2GG9F6PX+aLGFwfIUr6yhk0q3Hl3k+z94CqF9?=
 =?us-ascii?Q?RgIq4vdSCDfN9IivUZ/85SuMYwOKW+mm1wB4aTPE+8tPweoXGSmIgZ6MutyO?=
 =?us-ascii?Q?7Z8S+qFQD8xvRrNeL859rV3lBL4Yc1xva10fCkZvj+027wtd+hCbCUiGcI/U?=
 =?us-ascii?Q?7vPou8PMNaLVUELzbOWKnoZ35YPv5sTy/JVB4sW0IbAZG6SJjRquAEUDkP40?=
 =?us-ascii?Q?QgOrP3UCNaL8ojf9t54qgICKmz9T7e7qk7K8EByAAMKRtiuJgXDh7/2wV/SD?=
 =?us-ascii?Q?XIUVauV8uJeVNdSANM1yVrKxZIlKS5dDNm6CZGTrRoLvfTAxscOKTeolx1yH?=
 =?us-ascii?Q?+QG4Zk0NjTi2lz7st4mlfjvY/lZZ7yaVzPRYBOURukqJOFgbnGmh+mup/s3A?=
 =?us-ascii?Q?KQpv6UBwYL2XS0HCcMgHpj/7nwQplmdyciprdPYIFa4Ks4z3Y9fITu6jdqLK?=
 =?us-ascii?Q?j5Kh4VL9LbNrIC1SMiovWErKiHp5lWojFfNkfP6WvefobPmRmQ95HLPDmkN1?=
 =?us-ascii?Q?wTvTxo/q1fopu7vngOQxksBEB+nw97YIzwp7EL9P/cFChO5x32PsVJC/bfZV?=
 =?us-ascii?Q?WvwnM8Ns5riYLD8u8v6wsjAIzTlzDGz1L6g2BPa6YrRyKu9A88E54ZO8CcER?=
 =?us-ascii?Q?uyNxIYVeV+/Hh7OqgX3J3XxMgplp3IBqnHsqsmehFgpagsNCXzKMx8KABYwk?=
 =?us-ascii?Q?FlrDz3l+P9gEpseRMYHD/kuI/bpjTzUv9Y3SlU+iDupLWTqN5CRskmK9OnEq?=
 =?us-ascii?Q?RksOWOsOvtSPA+wpuAmiR+vrd1DZ9oqLAEauAIySSLJ01oeKTkhVdgmtJIHp?=
 =?us-ascii?Q?6oWUYCsZyXMpzSXS1yOxjpU/sNn/ZYZBCPl5rGYADfnFw4lK9L1YOAQbDQql?=
 =?us-ascii?Q?7++dOzCgEzbOvEglK1+FhucdyRPqTokU0nlQphC+gQoJ/SWHHXNk5sLQdbec?=
 =?us-ascii?Q?/fL9AL7E3ycSkR2yOZlQcC55idLtgv91gIssTxBOXQ4gm5v9EVlD5oHL4rj/?=
 =?us-ascii?Q?nFFGzzq4y4I3P6aIzsaBJNAHBKnetiQrROxDZ4jCpngAH12ktEI3ho8Gt5HX?=
 =?us-ascii?Q?xuYlybYN1aojPixtuU/uCNDjzlOlOnk5HAGmcVLt18jhAf9HBJ5sXg+e/Q5x?=
 =?us-ascii?Q?N/WW1+aN0mlHDGls2qk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:41:03.0314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d248e3-2d72-4e4a-1aba-08de51beb3a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536

From: Mark Bloch <mbloch@nvidia.com>

Refactor mlx5_fs_bulk_init() by moving bitmap allocation logic into a
new helper function mlx5_fs_bulk_bitmap_alloc(). This change does not
alter any logic.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c    |  6 ++++--
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c    | 16 ++++++++++------
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h    |  5 +++--
 .../mlx5/core/steering/hws/fs_hws_pools.c        |  8 ++++++--
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index e14570a3d492..14539a20a60f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -449,7 +449,9 @@ static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
 	if (!fc_bulk)
 		return NULL;
 
-	if (mlx5_fs_bulk_init(dev, &fc_bulk->fs_bulk, bulk_len))
+	mlx5_fs_bulk_init(&fc_bulk->fs_bulk, bulk_len);
+
+	if (mlx5_fs_bulk_bitmap_alloc(dev, &fc_bulk->fs_bulk))
 		goto fc_bulk_free;
 
 	if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
@@ -566,7 +568,7 @@ mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 
 	counter->type = MLX5_FC_TYPE_LOCAL;
 	counter->id = counter_id;
-	fc_bulk->fs_bulk.bulk_len = bulk_size;
+	mlx5_fs_bulk_init(&fc_bulk->fs_bulk, bulk_size);
 	mlx5_fc_bulk_init(fc_bulk, counter_id - offset);
 	counter->bulk = fc_bulk;
 	refcount_set(&counter->fc_local_refcount, 1);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
index f6c226664602..faa519254316 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
@@ -4,23 +4,27 @@
 #include <mlx5_core.h>
 #include "fs_pool.h"
 
-int mlx5_fs_bulk_init(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk,
-		      int bulk_len)
+int mlx5_fs_bulk_bitmap_alloc(struct mlx5_core_dev *dev,
+			      struct mlx5_fs_bulk *fs_bulk)
 {
 	int i;
 
-	fs_bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), sizeof(unsigned long),
-				    GFP_KERNEL);
+	fs_bulk->bitmask = kvcalloc(BITS_TO_LONGS(fs_bulk->bulk_len),
+				    sizeof(unsigned long), GFP_KERNEL);
 	if (!fs_bulk->bitmask)
 		return -ENOMEM;
 
-	fs_bulk->bulk_len = bulk_len;
-	for (i = 0; i < bulk_len; i++)
+	for (i = 0; i < fs_bulk->bulk_len; i++)
 		set_bit(i, fs_bulk->bitmask);
 
 	return 0;
 }
 
+void mlx5_fs_bulk_init(struct mlx5_fs_bulk *fs_bulk, int bulk_len)
+{
+	fs_bulk->bulk_len = bulk_len;
+}
+
 void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk)
 {
 	kvfree(fs_bulk->bitmask);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
index f04ec3107498..4deb66479d16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
@@ -39,8 +39,9 @@ struct mlx5_fs_pool {
 	int threshold;
 };
 
-int mlx5_fs_bulk_init(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk,
-		      int bulk_len);
+void mlx5_fs_bulk_init(struct mlx5_fs_bulk *fs_bulk, int bulk_len);
+int mlx5_fs_bulk_bitmap_alloc(struct mlx5_core_dev *dev,
+			      struct mlx5_fs_bulk *fs_bulk);
 void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk);
 int mlx5_fs_bulk_get_free_amount(struct mlx5_fs_bulk *bulk);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index 839d71bd4216..5bc8e97ecf1c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -121,7 +121,9 @@ mlx5_fs_hws_pr_bulk_create(struct mlx5_core_dev *dev, void *pool_ctx)
 	if (!pr_bulk)
 		return NULL;
 
-	if (mlx5_fs_bulk_init(dev, &pr_bulk->fs_bulk, bulk_len))
+	mlx5_fs_bulk_init(&pr_bulk->fs_bulk, bulk_len);
+
+	if (mlx5_fs_bulk_bitmap_alloc(dev, &pr_bulk->fs_bulk))
 		goto free_pr_bulk;
 
 	for (i = 0; i < bulk_len; i++) {
@@ -275,7 +277,9 @@ mlx5_fs_hws_mh_bulk_create(struct mlx5_core_dev *dev, void *pool_ctx)
 	if (!mh_bulk)
 		return NULL;
 
-	if (mlx5_fs_bulk_init(dev, &mh_bulk->fs_bulk, bulk_len))
+	mlx5_fs_bulk_init(&mh_bulk->fs_bulk, bulk_len);
+
+	if (mlx5_fs_bulk_bitmap_alloc(dev, &mh_bulk->fs_bulk))
 		goto free_mh_bulk;
 
 	for (int i = 0; i < bulk_len; i++) {
-- 
2.31.1


