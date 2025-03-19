Return-Path: <linux-rdma+bounces-8844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA168A69935
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC6E8A674A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B4219312;
	Wed, 19 Mar 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJxBFzNK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BF2139A2;
	Wed, 19 Mar 2025 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412291; cv=fail; b=HIsen8kWiDN94gKphHg8NscBTISBRwC8uJz7st/0GjqcxIZlxltezyqEalzMv2m0BcdSv3sHQORL35vssp/J87ZcNhdpQ+m4ZaKRv5V9qzUeSLb+lSSHh6Arexw/F63WCwPpFHmE2b6T9uFQuyGhS9I8WM7rAxjf91GH3v84JUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412291; c=relaxed/simple;
	bh=AnLvlxCC/Xp9RbX+VHOANOBz9cgEgZ38H9XY25AWnVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMAPGbGQQyhj1sfDZ9NXBe562lqw02t4qRU6nwhleFb8JGmQh7QeAzRtHuXod+uTajmUgDaHSX82ilUjdKuzEyY4PazWti93YcBdDb5aoSNh74QEEF4lXHj/eRU54dxIMh+QYM4malKJqcDyXeIxBVONIO450IynHApL8FJ/Xyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJxBFzNK; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaGbOwYnQ+IAPgRpYHjuEUtooLxSsJzRV+1qb6lUfMfBmzShM/2tT7OdHlReLaYeHTzMc6pqxFExAhZayTxJgzKwHAz2u3ZswtYVmtoYkcDKMr7C3730rf4sgjadMko8Dh9236JUtKfllBu7STd7xaELWziDwV9xbsiEWckzuyx4smDGLtEcKF86yoNI5vR5H4sGgnDNuYPMH1VmR/D+ExTrtKnvDmcJL3XrSYngYp5OzF5CvX5BwTz+d+3eeBs6v1O5C634rbSOnUUKHip+0NFy/CBe2W12yzgF5YAtJyKcnaWXVApJAc98VYMtX9IL/4PQW6gBSQKlDa0BW2EuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2o27uP9884Jv9qilaajTKhlOLjqSJl9iJR48t2rjZw=;
 b=sxXDQy4DZKWz3vWjbuwq0GQYMoUkMlo9J2L/IvrX5GTk48mU4ytQxhcONV6H49VdApmM4K87+BLgyCxhFfm7AnWpxnNavwW77Gl13Lgx0BmHL5v+++KHklsIfQfmCREw/FQffZd5Bnkt/hS6OSI8U4c5Zx9KMS833s6FSDshvcKVa/HnRRE4+LVjKPR/eLlyUjxl4Jvj1TJIuArp+MdlVWnZLYkhJi1YxXrZdzQCUtZi6l/NLLXIQAEnfFrUaeGSJ+J3Tg6zn/33/pocbWK8l16sJeN6BBw6NhdV+Uzw8DWoxZ8669eiDQmxtbw/vCRlgrXwBWqr3zlD+8C0xPjsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2o27uP9884Jv9qilaajTKhlOLjqSJl9iJR48t2rjZw=;
 b=GJxBFzNKBOAZL2wlSMgwHT/+4tzDzcOBcSq8O7gxpMjcFl/1gEss8nlIhwqZ4hiF3GZk3dhnf0RAXrMu7r9S3d6RoqDaHIamGzSud5j9Crs4onl1phSzp1gwVKuIUoG4vdtDTs7VBU05LpC8lDFNk0lKM/c3tkGXJ2LqbPBoAOHi/hp1zrt2gyxBextIth+maw4cMh0aZlh7LuHWo540VkbVXqAZMQC5Z7kzKDccDD0dD3abNWRJbijsps0tGFIi4bEI6X2T9xYh7mkLR/NyAT4NrV2hDbBm0n6c+J9nsMIsh653bY+g4iBHdazlsBGEyYgitlglD8I4fR1lhg81Qg==
Received: from MN0P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::18)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:24:42 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::c0) by MN0P221CA0013.outlook.office365.com
 (2603:10b6:208:52a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:24:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 12:24:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 12:24:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Mar 2025 12:24:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: Use right API to free bitmap memory
Date: Wed, 19 Mar 2025 21:23:18 +0200
Message-ID: <1742412199-159596-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
References: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c65e80-497d-4246-7258-08dd671bb31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2OHhY6H6cZmdBWHE7gtCApVp6PNUPFPmCipwJUo7Z7LqpWkcWGSC2Nw/EGa?=
 =?us-ascii?Q?hvhmgRD40t9R2slMlSsqLSObYvmySnfTUALmT/K/GYXvcJJlvQJ+5Yi7uPqm?=
 =?us-ascii?Q?f05sG6xIIGD2sIbBql1o6TUtIAQgXbRJ91J1A+0fyJQAvTvh8OMCtgoXXWog?=
 =?us-ascii?Q?kPIRV+5gJrd6XjKj4LAyGgLdNO/J8qtlGL86LHgnpcYqOdEHtOMf1oBi/HLQ?=
 =?us-ascii?Q?LyzeL1F4Gb6pipidalDwDqE76H69P1bWmw+GzjiCteH7ap6hXL+Zk+6Nr7Zz?=
 =?us-ascii?Q?YUxqurxPmldSVsziGQE2uIYm2/sONWLx1OknCUmM4nj2+IBQuLbi/YGL1m/K?=
 =?us-ascii?Q?Sh34h6mB+Oiei/e/NBZIF04roTvBUVX/ThBTbA6l3aWAAAKzoCCynSv1WotO?=
 =?us-ascii?Q?uilOnWk7WF18BsYAOU6nUhi5wmazudkR0kcXjeWkqihKX9Vhojc6Uc/NC7u8?=
 =?us-ascii?Q?5IOozVvMjDU0n6j9kW+CN6Mo2lXGIEQZLWLnxFKD1YJvs+RCv5wvOFBibG4C?=
 =?us-ascii?Q?perBrA7q8hQGDZ5thJR7VXgXWyVFNFjJ09KAv25Um1oIwjzEwEa6alJyCsJO?=
 =?us-ascii?Q?xdgRrON4PDvZ4sh/avV9jHRJGZREcKsOmCor5LT416sI3uYOjvhSvYHI3xZX?=
 =?us-ascii?Q?49GDOPMUZydtpjqCZha8rIkCc4aVBTwT/U1PK8tKxMrKv0otCcjc5T29bMtT?=
 =?us-ascii?Q?ZRuzhGjPAifPTh8BBwz9Cs8caHxmFWJwn1GRobMdinUHBI0VEX394Bz5+zuv?=
 =?us-ascii?Q?nposLL5JlMj2kC34TtMApuw77WwtmSvv48yTyrzBurBtLeqKIY5MF8d3xcqW?=
 =?us-ascii?Q?GwoERIb88pB4kci913f6cL8OwBwrDN8wnI+3SCaPR96fvmXFnVDMFMRhkENp?=
 =?us-ascii?Q?WVQVGVKloGtgbMghB/dpTLheuln039BzyfP+19AqE44kE4+pkOX4JE7+9EkB?=
 =?us-ascii?Q?kBKMOz5vU4UceuogJovEsx/5dnpkM+2v7OrK/Kq5ZCChffoB8w9oIAZSusoR?=
 =?us-ascii?Q?/T9eqKJhW4JprrQUBE8d1I308XS24/rtxq9m5n0dOssYfi5VKJ/zM+FDUePX?=
 =?us-ascii?Q?Prsf3HZQ31eRNvASnPKS6/vyxQ5etFFCNCFQgmC/knwxZDXXlesiw/pDYKv+?=
 =?us-ascii?Q?D3aFEp9nF7xQq9OqH282AOzGYJZ1MXxjGDF0HQcQJAex0FU8nnuQ5DGcPzIP?=
 =?us-ascii?Q?Hw5M3fxDYdxsmvm2VOsn8EK2f8u98w59SrSxxrMt6v2gsav3avJqkGRhTSE+?=
 =?us-ascii?Q?nIcfYTOKCWZJEf5U15HyFymTGQzwbTwiZsXqvQuCdJSGxt303ajqd2bKOhpN?=
 =?us-ascii?Q?qcZmc/JwpUVAEyYQRvCSTZioux3P8kOJNVOxXWIu1Y9KWxrfvdRlweJt7Aji?=
 =?us-ascii?Q?TJtFXG/WLsr7f2zjwEbr2OwdxExU13vmp4bn/jYjFLSmAEAxXBtg9y3crP5e?=
 =?us-ascii?Q?mIRVySYJxxNoK0Rr2HaV2ijAi4OFJPL3HGRUO3e8S3QEwNeojfW2LIzy6PQZ?=
 =?us-ascii?Q?DRr23LI7COE7yXI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:42.1145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c65e80-497d-4246-7258-08dd671bb31b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

From: Mark Zhang <markzhang@nvidia.com>

Use bitmap_free() to free memory allocated with bitmap_zalloc_node().
This fixes memtrack error:
  mtl rsc inconsistency: memtrack_free: .../drivers/net/ethernet/mellanox/mlx5/core/en_main.c::466: kfree for unknown address=0xFFFF0000CA3619E8, device=0x0

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2edc61328749..3506024c2453 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -359,7 +359,7 @@ static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
 	return 0;
 
 err_nomem:
-	kvfree(shampo->bitmap);
+	bitmap_free(shampo->bitmap);
 	kvfree(shampo->pages);
 
 	return -ENOMEM;
@@ -367,7 +367,7 @@ static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
 
 static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 {
-	kvfree(rq->mpwqe.shampo->bitmap);
+	bitmap_free(rq->mpwqe.shampo->bitmap);
 	kvfree(rq->mpwqe.shampo->pages);
 }
 
-- 
2.31.1


