Return-Path: <linux-rdma+bounces-12770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF3B27ED8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E4B606E0
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6D301469;
	Fri, 15 Aug 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aWxTAEp8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7D28504D;
	Fri, 15 Aug 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256035; cv=fail; b=nnIi2/RzZT56vfow48qKaGXl6HkrQgTqw0aMflZlQlPJHHDAfwaw+6rrLvKpwP6Y/ealdCGCwcHZ8lZCo5xBoaVG9SlYGnhGbhhpyboY+SQpfzBSekxWbVhKA+v0nJyRz6tq16rx7TNLYZ7kYAf3QTAcDp5vXNTuE883fF4ftb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256035; c=relaxed/simple;
	bh=jfsmS9T99w2+ci2dy/ZkXSNqDsqEkEEq6QgNOk+9MRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDiPidStcqeeB74QwIP/WaJlra/SJ44Hb5EtSbXixQaK3UrIxZPhmfx14v89qRNbr/7pDx5GCPi+1xfLIYKB6UfIopco7JYfHAk0t6MQ72pBX59eNO7PpM5qBxa1KV/1bPDRYetpLZyh+VtVSVhINf6g80Q54+8HJqR2ukoRWkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aWxTAEp8; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdSDisuQW6BUrKp/6SLbRqCw6EWEiiW5nbMzvYqoVxWoUgMnSdaQEPq6SzvHhh+X4qpdu5FGK7U6E8rWaRsATYtmHAw+n3FRLCdaYEt3UGZ7nL82/OUJtIh+SEZsKDbEqqBD5sKakRl4n09KsOLCwu5EqkbjeNRSX/vME99XFqHAqMZfN39XHGUvMQaC+gSE0AKZEYWkU9ESWHkRb5MeYJbzcpM7BgJiHdBiyLXI8xz+POEMAheNvuKzC/xulUO4IheYlwNm0bBa3aH7A53b0NfEnq8jeRzKODaWy5rBAatqPc1RVX1H7DQMBMDQYjpilKWEX8VAHhyO+rTlkB/hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWzNWqyjdHnGY6e0zsVptgNWi3yBRfF3piwDAgvJf6I=;
 b=EfBpVRIGgGc9pzJye3NjcNFz8pxP8SpqHvRoS0W20sOYp39NcEu/mfFVOcZhM2cqhXu7OcbzoUeHE8Qcb9ewVPKboXKln8EVdCQYn7S8y6y/e8ZR4Tet5DqFkdAvFRhRNY5LJb2+UsNujNx6kBfMqob6Exxo+InarDS2SW/J7fnN6hvfrbR6zoC7b0HmJ4MvUSXdeYkuWrpAoK/8+bMg+C/dzI6KT4bywoaReTx1LfkHC9TAfdM12f49Vxsuh8rSSkD5BQlYaiKLDg6MCu9K+d99LH0vLTBWFHh4ZqTe4BX5v36R10Ng9Fj3QQNH7dpeatUEGHk6lakD4FWgEFbmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWzNWqyjdHnGY6e0zsVptgNWi3yBRfF3piwDAgvJf6I=;
 b=aWxTAEp8tj7GQ/CTInSx/Bf4leWzBAV5fEOcGIKfQPY31AATTi083UKS7RiZTTAaIaMEors/JnO4L0wI3lVNeiYG73XFt+HbcEyvTqH64IDponZPGrnjrfOkZVLjvSmOJg9NINwr0goynyRxJMb6kHyx+aP+eO058O2TdcBuT+jBBoVqV2j47BKmUetMQqZLpnUnywxdTCoXYE7ndEQ1GD9bOylyy2+8Ll/SI8270QmmsLg75FZcXWTj0/zvZvy/l4gt/KJOiI237mXFaAjRxX50NeLkz2Qjxq7+7xk7TjPZOcHYpAibsbDLKlQ17GEHB/pxaAXb9YagmIAPJoLP/g==
Received: from MN2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:208:15e::40)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 11:07:10 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:15e:cafe::d1) by MN2PR17CA0027.outlook.office365.com
 (2603:10b6:208:15e::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 11:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Fri, 15 Aug 2025 11:07:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:01 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 15
 Aug 2025 04:06:57 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC net-next v3 4/7] net/mlx5e: add op for getting netdev DMA device
Date: Fri, 15 Aug 2025 14:03:45 +0300
Message-ID: <20250815110401.2254214-6-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815110401.2254214-2-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c3388816-e48f-4453-98ae-08dddbebe1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+teRZeYYkt4Tpv2485W1BLZmeVAnNypqyvDYXR77VagVhpql5C8a9uQiJTW7?=
 =?us-ascii?Q?PbGAl+23rPmAoDfszpwsYTYDK3oaEiPbYJB7TJbAUzP11MsmLT5ZLUho01Ec?=
 =?us-ascii?Q?SRa3GLmmp3cdlBKRP9HzZAv3vllKtFk729qFS4b4CuTRtoTXvAqbGK/7ovxv?=
 =?us-ascii?Q?EY2bcYjfA1Y/yOg1fvSJXrAB+f9zIs2LFhYoFYWrPFL+PEf2fiO0CdUzfzAy?=
 =?us-ascii?Q?1q5mZXv240tf0R67N3wegZAVBT3IUWfzi8eSo6b/MBtQ3tpOt7orPpSN8iI/?=
 =?us-ascii?Q?+6YD9RDq4KSb7FwMTyDt8hjo+XlJHv53ZId9Y0JqptFQvHtCzy0I/raSMc7z?=
 =?us-ascii?Q?FViaY6Uv7iaz57qrMIWfGUsXoqheGzMMUY8MEPb3Ve/DoOVAdW+Y8fdTecMU?=
 =?us-ascii?Q?n/KHwy2a/y9Iegjfkcv9UENaRPx//zlCzuLiNScd//6HQbvXR+vOBP81BOAX?=
 =?us-ascii?Q?Ox9jLWAWm0eUawl/xllZ/CGXboQKiNKFFSkkom3ZNBM3F0kh28Kvh77koXpA?=
 =?us-ascii?Q?LgyLTaNwTDh3jI8OoXEwYA4nLWNlNSg0zcyqJhp7Ag7Pan8ovp09UGrD05+1?=
 =?us-ascii?Q?zQA3MDg8QAmXBDQRPHrCeDl9jQHuxdKunEm7w7ksl6jhVujWzfX1fRCiMf2e?=
 =?us-ascii?Q?+KC6h8C/YgGa3L1UofWX4U8tWvMS8f2jAugJM6p+7vKcyuoOwwQCM5hUvuNg?=
 =?us-ascii?Q?gIjQGBtyqwmRgq0g2YSYu28GEbZnxRzRy+PW+BGnragfVg/ZxLFWMJInRoas?=
 =?us-ascii?Q?Uoxw8A4tHe0JCFddOtBA1Fzi3VdQ0c5aAyI4IrwqwucfZ0MK2TTPlEgCDUfc?=
 =?us-ascii?Q?hwsMQa4vTKsa9j/WpdcO0FBgCtf5omNkESA0NC8ebvUoZC8ka+LjtM4UbKHD?=
 =?us-ascii?Q?rsX6IZPCc3VbIjZ05oW4+B5+dKyvaF7YgwfK28LBX+o2P4DYvNCn0fMkc003?=
 =?us-ascii?Q?cjK2z0VDd8bk1Is91B8skKiEU610heR8X8aRrsnfoxZKVMwoJ0276wXC1iP4?=
 =?us-ascii?Q?nuQgoNOCS64aWt9EFA/bEf8lD5r3/UjGsUdFL8lmAlmsYSE0co/SgPrO3kUU?=
 =?us-ascii?Q?C2zhl2msC+wLaEg0etjxJOy9Y7AFnq0HuLVVhRp98APOwor51WGVFgfgpzqF?=
 =?us-ascii?Q?wHsFVFvVOLdFoqoO49N7NvjeAgyLcsw7kAd7KdtvL41Ed2m3HmC11DF2vBoI?=
 =?us-ascii?Q?YU4MWMX9EWBi7HGPy/KlxtEJom/i7LkjQROPGoFptOYAK6ar1Y8aqOjt3sAQ?=
 =?us-ascii?Q?rxD+00l+KBGvYT5qn/BXOZR4xMM3z+VpDB2qsKZW4iplyz2SS7IuIhG+iEZQ?=
 =?us-ascii?Q?QJlhewTyCu6ROycCvdVTnjGh7oFci5Q7Mldv/aRQeonWbyvByIugYyumD2lc?=
 =?us-ascii?Q?N4D5xsGJCXg4blFLrfCyHQIuqOnqYxCw8eFjJsqSeUtCV37LfS/ioQP6HMts?=
 =?us-ascii?Q?jjB5sOMm9Ega7Q8JtplFmsp99KCZGClE1zXGXI4oJCPoEiSC/7ekTbIqWn/+?=
 =?us-ascii?Q?0nI+hL+OPEVJfoeVe2NO7XonkBRGe56ZBRQycCm7q3JxJdgZZrLrltDreA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:07:10.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3388816-e48f-4453-98ae-08dddbebe1a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

For zero-copy (devmem, io_uring), the netdev DMA device used
is the parent device of the net device. However that is not
always accurate for mlx5 devices:
- SFs: The parent device is an auxdev.
- Multi-PF netdevs: The DMA device should be determined by
  the queue.

This change implements the DMA device queue API that returns the DMA
device appropriately for all cases.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..0e48065a46eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5625,12 +5625,36 @@ static int mlx5e_queue_start(struct net_device *dev, void *newq,
 	return 0;
 }
 
+static struct device *mlx5e_queue_get_dma_dev(struct net_device *dev,
+					      int queue_index)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channels *channels;
+	struct device *pdev = NULL;
+	struct mlx5e_channel *ch;
+
+	channels = &priv->channels;
+
+	mutex_lock(&priv->state_lock);
+
+	if (queue_index >= channels->num)
+		goto out;
+
+	ch = channels->c[queue_index];
+	pdev = ch->pdev;
+out:
+	mutex_unlock(&priv->state_lock);
+
+	return pdev;
+}
+
 static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
 	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
 	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
 	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
 	.ndo_queue_start	=	mlx5e_queue_start,
 	.ndo_queue_stop		=	mlx5e_queue_stop,
+	.ndo_queue_get_dma_dev	=	mlx5e_queue_get_dma_dev,
 };
 
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
-- 
2.50.1


