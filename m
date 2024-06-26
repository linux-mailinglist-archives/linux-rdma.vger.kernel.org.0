Return-Path: <linux-rdma+bounces-3520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5D917E29
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0DE285049
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C718EFCF;
	Wed, 26 Jun 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEl1Arve"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC618E77A;
	Wed, 26 Jun 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397718; cv=fail; b=uzQw0n+2wg53ExQwmkBYHYdpPicT4yldeT/rDspAbmTbuDz05TBFuUZ6BOH8Rf25lH+LCtvz3aaH5YbptUpshyx+KJFbEiDiMO+BKcx5Gg/Ch5N959eIN7sj4pSdC3etZqCoi/fgTpXf2DDCfwhXD5x6/kmOA78sPomffCOTgSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397718; c=relaxed/simple;
	bh=SAlGeA4NcdI7csPgzuUnMI33fiJzfmgxQ7AnCOUiVYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uuS0W8V7MP1GxWAmhUze+xXI/r4z98XNgZhfFXEbdl9jSK29IbUR0urIANbYIrNJqijsG3l/ywjrNw1WhVEWTjB3Fr8xumWx/9BL2Z9aCQt0fqL75TwCPbYbRG0wLX/QM9sJRIpC8lAna8V7NmTqjB8n2TcuP6wIhzxOJTbg3BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEl1Arve; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiJk/h6bPoKO7NDD1dM4gF+hkfnqLNO2ZUk5RsTzSodz+fLQFkNxsVUVtkIrJ1KA5fj0t2uUhHWP1DDwi/v8HCQi2VeOxzCdVowx4LQcWjNOJXrAsRZBng8uCGc/DKIN3me2rVyx/XLpZUEn+02+xvviudUOo7+3Hlu9SOmhkbwZs6o10EeVGLN/6D/nz1oMf0s9SHq4hAbPHd0nnN3Q9j5PpnZ5nYvGWanCQOOD1siaqHZvWaLXcZUw2cn3X0VG3WYWadNFtcwt0jJcnjM3SxU2xOyuDcRXD2q4xj/8zHynhb4w9UDEfLNrLFxn1KZKneiYhoZ56VPLI6qzbocbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xRGfSa4sM66FZMcXMg8tLMPq9VnRrn2gFvkxeTUcVI=;
 b=Wti3mUZm2IJFx4FVemoiygvCEX9F70Yu9cFVmm8qrAAsJD+C8fCgh6A5HBLjhGWnXJ4q+ThTdfKJu7X+jrGKazII8JYRNgUsA/k/ncAwOJUmA2fhrB+Jm/dHuoz0u6L5kLWA/i9vEga8Mq8X4uS4YXVNvzACZ20elGgyjYUogLg85x38UsPW8Cal4nJ9OQ+RfxlHWXvyZrpxJgSKA3fnedll4U6wH3yXFpRsCDonT4BwOX86LTQHriBQKJqRCfK3Ht2/yrlIMwfcwaM0G162sO/yQ249/vXIvWub3tZ8Z7zwHXw5+qF7hh5/oplsDGfvzCE28+Xz0bg+by0QFLeIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xRGfSa4sM66FZMcXMg8tLMPq9VnRrn2gFvkxeTUcVI=;
 b=hEl1ArvetA2he3eU+2zSd7wHuMOCZxmjnYOYXIQhIJPOWEUWZEUF+pLXK9fS9eBHY8D2N+JTOHw706e7f9rcjJ+7315rTxOPOoKGu54P0ghnbp2qaDztkDVnpuKMMXKHe6E67vxM4rTipXKsFVAfv0pchImCwp0OpZOpWTXLUqqW3xOsrWyfGPhmH153MBj0OL5a4yOyYRwZ2wDvQCoKgakyW1UaxNoEoUpXiBoUOQuYacZn87gOXpqIe6m1BEXk/1M7nqcPyCExzWg+jhSV5yO240vkrmEhU/Llpv+lmgpACSBpzIF/TG29drR2Ux0F+k+SyVy4KTh29A8EXji33g==
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 10:28:33 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::a5) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:20 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:28:17 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:59 +0300
Subject: [PATCH vhost v2 23/24] vdpa/mlx5: Don't reset VQs more than
 necessary
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-23-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6f368a-d223-42ad-efa2-08dc95cabafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|1800799022|7416012|82310400024|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZNeTRVMXl3UDR1VEpOZm0rOEVjNU8wYVdFR2JaWkVrbGpYQlgrM0JVTXRN?=
 =?utf-8?B?anNUZkJlWnhEWHJwbjNKL0cyanIxYU1VTURzSVNQNWtzRlFsV2wrQXcrYzZq?=
 =?utf-8?B?NDArODVGOGlVUlF2eHZtODFOclpXWFdtQ3NzYjY5aHBrOEx3citDS0R2bDJM?=
 =?utf-8?B?TWFMb3N2K21ObTdRbGh4TXo3VEZ1OUhYWkVhdFBkS0hDVGE5alhTOGZlMUhx?=
 =?utf-8?B?NlRoUWVTNmFJOUx6MUhySndVVXpjYnpVcjVyVmxjZGJmaXViSERORk1TMnIv?=
 =?utf-8?B?Q2hCbGFJWWNlODFmeHlSWW9lTm5sdldFNjdPSFpzemxtV1lFUS9GUUg4Y0do?=
 =?utf-8?B?QnlNU0dvYjJqVEdORXJlSmhQOFlaR0tRNlhrNjRVYVN2M0xGOHRJM2p4Tmt2?=
 =?utf-8?B?eGlWS05mcVNicXhlWHJxLzhxakp6dWJhYTNldGVIUnU5UDNuaDJHZ3VLSXJH?=
 =?utf-8?B?ZVlnZ0tiM1BrQ0tEQWhub3g1ZEFMU3V6WDJ5bzF6cTBCdFltVXdIdTJHekNQ?=
 =?utf-8?B?bkJhNllCdGFibjNUVHdhYmRZUlJZSHF6UkxMckw1QnJMUFY1UmNuUzhmR3pu?=
 =?utf-8?B?d1BjbnJnV3RkTEd6VE5xNHd3M0RUSnFyWTlQMnVIeW80NDJ6bnA3dnRzeUxT?=
 =?utf-8?B?cDFiVEVPcEhFRGZybjBRRE5xTHA5QnNWN0RmcFlvNGJ0KzFsYUhQVXdlaVpG?=
 =?utf-8?B?Mmx0Zk80K096K1E5VURoL3lQR2ZzRjJZcFRxVnVybCtvRjk2L1ZvRWJ4anVa?=
 =?utf-8?B?UDNJNWpPVW5vRFpaSFFockU1MTdmTVEySVoxWElQOXQ2eDlESjdoK0Mzd1Zu?=
 =?utf-8?B?T04xNGhTVW5EOFhGNFJRMjhlanQycjhWbTViWmZUWmdkL3hRbmhrVHg5dTBR?=
 =?utf-8?B?Mmw3cUcwK1o4RmV0SXB5YVdZUzdTeWVCT2owRnF2Nmx4dDF0SWFTSi82MFpi?=
 =?utf-8?B?cW9QcjRXTGErdDQyZVF5bW9jSUcxNVVCQUtqOUlubEhJZkJjS0tWVEdUbGxp?=
 =?utf-8?B?TCtXU2Z1Rlh6eHBYc0pOUVhyR3c0Q1hXaWlJYkF6RnhBb21QMnNpQVQzN3Jv?=
 =?utf-8?B?S05Tc2pTWlVEUXdraFc2WGs0U0FOVVUyMko5NVRRaUpqU2lwd0lDWGliNmxs?=
 =?utf-8?B?ZWtQN0lBRlJDMUptWVVJdFhjZUk5elJaRStFWVZtRkY4azBickM5Nk9PS0RV?=
 =?utf-8?B?enZLUjZWaWJIRUdMMDN4RXYzdEFLRjlOUU8zZDJtTy9YZFdlTGFicC9TRlhW?=
 =?utf-8?B?b3dtdjRUYThqZGRNcTljYlpJZHFFZWlvaXJCR1o1RERKcCtBSFA4b1RiY21W?=
 =?utf-8?B?ZVQxR3czZUVncVN0YzMvY3kxQ1VVbXNnSm9BM3h3T0hGRndYRE5ZbzZJdVFS?=
 =?utf-8?B?TFIzSkJXdXUvK1JPcFZLa1c2VkhaOUxaZTVTTWxBQlBMRmxTRjNLKzk3YmZ6?=
 =?utf-8?B?OUwvN3Y4WVVvRktNK2hENnl5R1U2b25hcG56RzJTTVVxaFF2ZUl6c21zS3BD?=
 =?utf-8?B?eDlEQmpZaUV1dCt3RklsVWNJVEpwRUQ5VVNKVmJONkZmTWQrYWtROWpIQ2da?=
 =?utf-8?B?ZUhlKzhoVTdrRmI5dkY5OUtiWGE5TWdXUjFldW13a0h5VHNNOFp6aFRQa0xU?=
 =?utf-8?B?TFVNYWNZSE9DN1ZZSXl6RjVZZ2wvOFh0MUFnNVhmQy9vTGgvMEJCTUdQUEkw?=
 =?utf-8?B?bHM5dzZQV3YwWS9nSVF6YU9pUTByeGdSNVRtdXpudXVaOGQ0R2lPcVRkc3hm?=
 =?utf-8?B?RDJvcnBHR0dEOC9nSHNVZTRUSG1KdUVaZUZFUUVtaktHUXBjakR0QXdIZHA1?=
 =?utf-8?B?Wi82VXZ6aTNpWmxORmhGM1RyckhrYmhud3hxd1F4bUp1dUxzU0IzcmdFS2JV?=
 =?utf-8?B?cXc5MEpQdTZqQVRSNEVCRk9PQlR6b0lUcloxOTVHNWc4UUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(1800799022)(7416012)(82310400024)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:33.2057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6f368a-d223-42ad-efa2-08dc95cabafc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

The vdpa device can be reset many times in sequence without any
significant state changes in between. Previously this was not a problem:
VQs were torn down only on first reset. But after VQ pre-creation was
introduced, each reset will delete and re-create the hardware VQs and
their associated resources.

To solve this problem, avoid resetting hardware VQs if the VQs are still
in a blank state.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ea4bfd9afce9..573dc01df8c3 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3134,18 +3134,41 @@ static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
 		mvdev->group2asid[i] = 0;
 }
 
+static bool needs_vqs_reset(const struct mlx5_vdpa_dev *mvdev)
+{
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[0];
+
+	if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK)
+		return true;
+
+	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT)
+		return true;
+
+	return mvq->modified_fields & (
+		MLX5_VIRTQ_MODIFY_MASK_STATE |
+		MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS |
+		MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX |
+		MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX
+	);
+}
+
 static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	bool vq_reset;
 
 	print_status(mvdev, 0, true);
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	teardown_vq_resources(ndev);
-	mvqs_set_defaults(ndev);
+	vq_reset = needs_vqs_reset(mvdev);
+	if (vq_reset) {
+		teardown_vq_resources(ndev);
+		mvqs_set_defaults(ndev);
+	}
 
 	if (flags & VDPA_RESET_F_CLEAN_MAP)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
@@ -3165,7 +3188,8 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 		if (mlx5_vdpa_create_dma_mr(mvdev))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
-	setup_vq_resources(ndev, false);
+	if (vq_reset)
+		setup_vq_resources(ndev, false);
 	up_write(&ndev->reslock);
 
 	return 0;

-- 
2.45.1


