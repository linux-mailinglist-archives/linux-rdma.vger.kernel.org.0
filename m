Return-Path: <linux-rdma+bounces-3745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4FC92A238
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31711F26113
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395C14F9FF;
	Mon,  8 Jul 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="anRLZWzu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97B80C13;
	Mon,  8 Jul 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440194; cv=fail; b=c8L/nr2l5cUTqlNrkrgfLCp61BNvESX3ZM7sEoFw87mnk+73VWfvxWY9kH/y4aNEOnu5szW/mjrkPRwCheRac8Pvjtx/p9sEnUdbFbP0WU700VJ8+RouGBxs09MchRZ8n7MurB8LmI4zjCWfi8CqLvlRC1J7enIXj+NTjL4cPjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440194; c=relaxed/simple;
	bh=WKsy69cp/tQAYU40famgaBl8AYbnVZi2GWGzRX/gcYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MuACevtMnXzKFK86Jo7z4rHXhOWiugYH4vR6KBgYFj9UhrqkWg/Ju1C/vC2qFTAl1HmLWX1a0/y9wAj06546q3ZC9fDrC2/EorkTcMqLe483BdJf8GiOyZ5E3PVQ3ATNOjx48hvNU69n9Rzazt+K7tFrXjMmvRDJSDvYUMfvALY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anRLZWzu; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc37Oxu3Q2EescVXwJ2jzxj//Z23H7aHBL9deEvvAQa5LYsfe5f7PWLCuu000DdBwO4+80KYGob7Af1VWGZuIK3kl2T89tL5HZUESjGtT+WRztEo0AdpE9dDL76jD0aIIITQ12ZNywK6oZ0dSQNvfKceu9+mvWhcsqsdpKFD20BtHpbzHk2QJXpUGoIyHdYYEc1Kwvip0JwM635Z+tG8ABYwgM5CJIxQP/R5kNoJzuKgizCRt3mKbSeGcDGFPt3oNq5lXTJWhZTjVHEUvEdRGhcmW4eGWyoUyjRZVXBAbU+sA+g85PY/HItoFZmt8SWK6+bF95mcIulsn2WAvycRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NHhb2gHTPrQWmX8OpgjYueGZ9a3Y81tCMO6jIeAeqg=;
 b=XfQX+EezGT7ADDWMxR2uYe6ASDEYXmEEz5oFW6O3ScAdWL4laaUlUUW4WdtKUjatlobSj/ETc/2nmyZsGgap7IgwvBgjBdIqpI8OdwA/UCc4cwyBRhACV750uz9zDLcYdkEFJi3Nn+xI5GlvLHXC0CrkOLqfG9LRqCHS0SKvxRPg+gxBDtlz/ApCjrNRdHhRCNDTiPWIk+ZlJu1ZnZKb/EW/6xQij2LNwQfBCJTxAXX/vcTd7/T01oTvRYKv+2tCVOTPWajmtRkHZ2nzlwVKsb2RP8/WIgygt2Q2F7Ih1Al3bFDGnro28FvpKYWOZ9h6vFNqqXElKXaUE7Q44qEv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NHhb2gHTPrQWmX8OpgjYueGZ9a3Y81tCMO6jIeAeqg=;
 b=anRLZWzuF9MJ+MidReERHWkQAJ2jI8rGJyte5yGG5hmoNLG9kfbEGGhL/Df+jEsm2tmvNJYGDD9eUPV1rfICbi+RnYvd24/CzTUnrSGcsGZUEx4QApU4TSzomeoIa/YGj082Re7M6ZfLEsJRnPvcA4fd5n8Bxpo/mcptD3iW8jV0iyrdXq+GfDValpPkL+4tnauit8gRDb9CgPPubnPvfZcSehSd/VE2R3nPLelhnPNS0VHYRcz8eUg6tSTAWiNxyDUGk85c44+mO861YS3AmJc6ZNU+GQBEZLudY6ZS10OsBGHz1me/duix/50n/2evwaaLMK8VdkupMkMa4BQGXw==
Received: from PH8PR22CA0012.namprd22.prod.outlook.com (2603:10b6:510:2d1::8)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:03:09 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::9f) by PH8PR22CA0012.outlook.office365.com
 (2603:10b6:510:2d1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:03:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:31 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:28 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:47 +0300
Subject: [PATCH vhost v3 23/24] vdpa/mlx5: Don't reset VQs more than
 necessary
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-23-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: b3372913-68b5-4557-81b8-08dc9f45ef6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlZjYlN3bmFnVU9Jb1pacUtEeU9VMnJyUEdwS1VLdTJ1NTh1UHVXODFlZVhU?=
 =?utf-8?B?eHRiTC9KOVFCL1V6YXBWb1FlZ1B1dTlpbG1RUTZYa0xNYmtyREVidXZ2RGZZ?=
 =?utf-8?B?aXd6U1hPRGhCclJ0OTkxMUpjMkNWRWMvNGJUbGhnV2pJaVB6LzFXNXZVb0w1?=
 =?utf-8?B?VitoNUUvbGE4Vkk1M2lNellSQ2xSVmxRWU1jK3h1eElTSTRMRUV6TmpoZ3Z2?=
 =?utf-8?B?QWExSy9LRW1WRERDVkZ0dndhcVpBVjg0RGk4MkNmWW05Y21la05rd01BVU1N?=
 =?utf-8?B?dkl4bjdwNXpvdFU2NlhNMFNGdUN0WEtxamJpT1NJZE9rWGJYS09LMTlwQTJF?=
 =?utf-8?B?YXp0NENOaW45cXV3UGVYMTBlTTlqVFRON1NyUktVVWtTUTV4bWNSQXV4TUF1?=
 =?utf-8?B?dmVYVXVObWVyalNQRlIwdzBscnZWQ0RIUTdvaWl4L29pVEpDSUw0U2tJNTk4?=
 =?utf-8?B?OTNDdFJnQ2dycnJjakEvRzRJRWdSOWFYNUZqMlBFS2VCb1hhd2NJaXFPckYx?=
 =?utf-8?B?a0gxakszT0xrZ29GdDhseHowME1Nakd0bzh1aWF1NHR5aGtGVysxZkh1N3Ew?=
 =?utf-8?B?d21YSlMySlcvQjg4Z0FxU2MwMVlXb2tHcEJDeHFMNGFwK3plV2ZFYTZ6N3do?=
 =?utf-8?B?OUw0V2JyRHlvdTdTbkprdGF6bkY5MVZjNW02ZXE2em5VYTJSZ0NEZ2ZXV3ZN?=
 =?utf-8?B?ckRjYVFSQnMvb29tNlgrZDQ2VVZlNS8zQzNHL25qZG1IWTNOR2NrSk1Hd2Zj?=
 =?utf-8?B?elJ2bVRFUzBzd2E3QjRqbGlLWmhOaG1Fa2V6KzhYbWdVTGQ5LzJ3OVlQSmV2?=
 =?utf-8?B?aXdiVE5ZV2hXSjJGc0RmSXNKeThXQ0RMYm1mVmNmZHVveG5MZ2F2TGhja3Vs?=
 =?utf-8?B?eUVPWUoyU3kzOTJkQjdzU0VWNkdydUdtb2NPQVZkY3pvc1BzRVpwN21jSmFV?=
 =?utf-8?B?ZDlBL2ROSm80MnlxS3lweDJYY2JwSTBtNUZ0REJjNkxBb3FJTVB4WHVqcUhx?=
 =?utf-8?B?UkZqYU1CaVBBclBqR0xUSzVZNGZ6a1M1dFdJd3pPemU1R25JcVNoVlFUV2tw?=
 =?utf-8?B?dTVQdWJNZGZ3NFFwYkRZbVhqZDNSSXgrbWJydC9hSGtjVW5iT25BT2R6MTcy?=
 =?utf-8?B?SmlSV21QVWNwUUJteEZ2eDVUcFk0R0FpeXFaWU9SNWJ6WlBXNVFqN3I5bitE?=
 =?utf-8?B?NFNXZGd4Qmo2QXMzMW5Mc0gzWjNKWmZ2SWI0eHVBRVFnbytaaEVhZStqZzAy?=
 =?utf-8?B?Q0tQdVkyU1dFanFtMnZlY2o2RGJyQ2NpU1gySlpmOGc3TDExdWszRi9jZSs3?=
 =?utf-8?B?MXdydjVWclE4dFR4TmRvUUF6cjNmZEFIV3dsU0JYdkxMWHlzeTBYVzMrRlpR?=
 =?utf-8?B?c2hwSzNtK1QrRzc0bFB5dnBHT1hGTkpuSG4yMGZLR0NEa1ZOUE5qcFNUZTR4?=
 =?utf-8?B?M09iMHFVWisvdVlUMVQ2QjAvVHdEN25YT3F2a2c2S3NoRWdFa2RYR2VMd01S?=
 =?utf-8?B?a2lva3VMTmthdnQ1ZjZBaGdHWGJWVHo2cVh1TVVLNTNzL1BmZnFlTEZodUVN?=
 =?utf-8?B?ZlhmOXFqZnAvVHhXckUwdCtPakt0dXFLZ2RTeGhqUFpwT1lsLy9lMGRoQXBj?=
 =?utf-8?B?OW1nd1YzOGttRnp6RnhrNGE3enlPNWV2Sk92TDFwc09mN0dYQzdpb3BJcS9T?=
 =?utf-8?B?K1NLK2hPNjFUMThrbzFCOE5VWitsSUp5dGhLM3RJQ2dYS0g0ZVhSWGJKNEh5?=
 =?utf-8?B?UUZDWmxGSE1yT01CVGtiMFBSbGRkSk1YU3E0WGpROEtJcGZ1RTdvTTNxUDlE?=
 =?utf-8?B?NDliRGtpOHhxa3JMZk5kMHp5eG9lVUFJVkJPNWJJellsUjR6OWhhUHlyN2Vk?=
 =?utf-8?B?MGdrNjh0YzlBeTRBOW5wSDM1ODkvNEMxSUN0alFGZmQxRWtNMDE3THdWenhh?=
 =?utf-8?Q?4zolrV9GsFpu5wLwZguNfk5F2d37/+rT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:03:09.6852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3372913-68b5-4557-81b8-08dc9f45ef6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

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
index f2af0ba82dd2..4e464a22381b 100644
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
2.45.2


