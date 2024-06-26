Return-Path: <linux-rdma+bounces-3512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E771917E07
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B7F1C21620
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93728187344;
	Wed, 26 Jun 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4d8mtEs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF83187336;
	Wed, 26 Jun 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397689; cv=fail; b=IWV6pspF0VXvKCrXSQBRvAKlVntQdv7+rFQRKqUyvTOr/bdNCp26S9vZ4mI9+IBSeyEgs14VVANSnl0wZ9l1lt3+5zNS1Pzo1ZqN9JQZIvc5FzJGJtOeFDhUEjFtsGdN7HKuplGwkEZ3MGh1HOvWOCgIyeOC57uIW//YD34Phng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397689; c=relaxed/simple;
	bh=zD1JS5qpDjfRhCGqDqJ96tApJVDyDoIj9pmIj89HbZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W1AHtWdBrapVAOk03JWxZnAnpvSmOTaxAvxPewHTxW0OteJPOiDq6MtHyrfss0tLgKMazLW/Kr1XL3GYyAM2I64XVIIc3J3gpqwIoCDdKzkZ96e55tFfwR2qTuJxr67wdZzAU25sEKTP0Q1CLtm4kA4kTgqsKsqbrXo021FNt94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4d8mtEs; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO3EB9q18ZbMp4qDZVS8rjYPoLXIXKB2ToiP6TqJxqN36SAuZoOHB2qa7L4+PazR2BKM+G9bVU3FEL9d3pdTvBbBzyzrzSGZ+siAfPihflC2nyqS5fyvd1D6pCNqh3leppPPbfx7Nunm/knxsz0KquxgvOTO/fljFJmcGUBguxD+3F6ARbwAZJvnHnyUjWWS7cVYDiBVlvwljj6S3sicEALubSpMZvU2KeWRSCjOY4EpLU45JzjPSLb/qPIxTY7xdM9ZIFO12Yv9ZlBUoNtjQjZEx7vBY0ACTQgr6ngPFSYA1hibxnrlBTlZayYyvk7a+ozun0WgFnBTGg+s6PQuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylifz/+whgGM+aCNwV/XbxB+ECSKL2WEabWtDI/CXS0=;
 b=n+6RkYopG/kh8GRSLtlfeymSPU55lCvTBKZnfzKX9AlNkE4p/pDkHvCiRpukV34QW8sYMyJR3ahS0q3t7hHC4kwq6bj5ShIVByMKql8rWs8JdrCmlErG9G6tioHaGdemttnttabAnMGNCZ/o7PbjzX8jo3NgL+YnZm3FQvV3w4lpgzGvxN4z+Ivlk+I8QsPREOFwmvEOHYWdNhzPoInNVgH73p0ISf0gJMKmfLtRUyQVoRWoUUTwHV4QKLV20fk255/QGjfbnL7r4Gwyz999+p5Unsu5X2ywm3FskOtXNaQZUKWmbB9RlXrEflT/6/JPcVfFRs/KCzMqrfC8juU+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylifz/+whgGM+aCNwV/XbxB+ECSKL2WEabWtDI/CXS0=;
 b=J4d8mtEswdB1wnLljAwd0O4C6Em8oE2EXqzNdXjmgNe0IUy8tciyGn6zmAIm77oz9OpGAByrgF8Lek5WYh8aE77ZxxGet6yRZAqUdyCkNrWmlvTRJbvOg2hP7lCAx6Hf5IKGKbtprJ9MI7UtkXqRCsE6m5GWBhJNyUDZrHXEnB3LwUKR9l8bHN0bQpMnF4p7FXyuxEeDz73elMVPnykNgRmtWwbv7DD9i+8qTIS0nbgKAFgGxsF2YwgnVuBY7TY/JtU2WXyytaFozXVZndt9hXAfSrd/34BFpeBOe19lTTALanWo7mmuO6tjYuxtouaIh+Lrb++1WPM/0BNcmQFjyA==
Received: from BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 10:28:04 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::71) by BL1PR13CA0288.outlook.office365.com
 (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:47 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:44 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:51 +0300
Subject: [PATCH vhost v2 15/24] vdpa/mlx5: Allow creation of blank VQs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-15-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: bef2b2c9-2538-4c96-ffae-08dc95caa9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG5zaHVQeTlJS3JGSUtxWFR2amEvWC9HeXdwZlBEOThLNlpYVWNpRW1EUStB?=
 =?utf-8?B?T1Z5emhKakk2N0ovekV4N3ZYT1BJZHE2dWtHZVliUGZSY3BjOHVhaGpWdXFh?=
 =?utf-8?B?NGJlZ3krSVJQbTMvZkdlcVMrOXVOZjRici84ZGJpREh2TTd2KzE1R0FHSlE4?=
 =?utf-8?B?U3RkRHloWWowbVdwTlhreC9mVjRYN1N5WWY1SFkxaEp2Wjh2bXZrT3BlM0Jj?=
 =?utf-8?B?MHZPWUo0Uk5oU1FaU3VlN1Z5WVdLSzhNeEJ3bmpySmhud0t3RkNSYTRKSUJ2?=
 =?utf-8?B?NHZ2UzBkbFhxMTN2VzkrTXVFNElvRVU0M2I0Ym05VFVNdjNCK0N3RllTeUcv?=
 =?utf-8?B?WUlMZTNUWmxWM1RSWjR6TFQ5STkzK1ZjdmFmWU1qOThDdU92cWpGSGdCaEo0?=
 =?utf-8?B?dXVTdTVTNXY2alVLUnZ1SEFVbWZDcE1qd2F1cm1XQWdOdVhCaVhWMFZvNWZQ?=
 =?utf-8?B?VTMwQ1Zmejc3UVNtNkJ5MEYralh6Sk14NG5rTG9xQTc3K2xFWGkwaWVvM3Nj?=
 =?utf-8?B?aFBDV2JmMlVwMDViN0REbTVWQnNwMVRSYUs1Z2gzeWprUitUMkFyREt1RTBX?=
 =?utf-8?B?bWZRb280aGVFdXRuUUFzdFo5c2RKQUhBY1N5aW5qeGFyQ2FmSnRVYStyWGlS?=
 =?utf-8?B?elNONGx6TDV6Yk4xU0I5SU9zL3k4TldJSHZXb3RKVE5qMnBpeE0waStmZDV4?=
 =?utf-8?B?UUFXWnRaSU5BUmtUR0hsRzlXZlZGdnFHQTZvaFdmTGVVQUJhVmFCY1RFWlFi?=
 =?utf-8?B?VkJOdStsTTU3OTNXYlNLdnM0Ly9uSUkwVklGOWVEN2plQmpwOWhPcGZpSkI1?=
 =?utf-8?B?QXdrYjhzMFJaOVdCUlZXcEJUOUpxUzRqRVMyazdMWkRSRlZLRVdOSUsxdGNY?=
 =?utf-8?B?L2pWVTZTeWxCVVZlWmhOOXRxbWxKbU0vNUJ0TC9RdnpPV1ZXNGxSRGZ5b0tx?=
 =?utf-8?B?aTJ1TnJDTTZqUExMQW1xcURLZEszckNqUmJOZW4rODdOSGdPZWw5dy9RVkp1?=
 =?utf-8?B?ejlYL0ttbk0yT0JqanpHakhqNlNodmlkM1ZKQkczemlZc2o1K2tid0NpWVFR?=
 =?utf-8?B?QWpvU2szZW9XTk9mdnpFZEY0Y3BBWVVuc213ZGNjb2RlR08wb3M3Szd0TkRI?=
 =?utf-8?B?cHFlUmNUQUFIS2ZOc21oYmk2OHp4NnFVYVR1TVkydURoK3dJS0hXL0pCRnNo?=
 =?utf-8?B?TVYyZmxtK1p0ZDdxRzAvTXJXeUNlVTUydWFvbEhDQU03TlA4Uzk2WklPRjJw?=
 =?utf-8?B?QVJjbmJ4ci9kY2gvYk9mdXRJY3FtSFUrcHVTYVhwbHBIVTdNclFsWVNMSTlI?=
 =?utf-8?B?anhsMmNDZ3JyY05uVFhCbWJJcWVCSEZ6N0J1K3B6N0hvWFdhblh4Rll1dDY4?=
 =?utf-8?B?aXRveWVYRm8vdkt4U0RpeGN3eU5uZFNKVkw1MEY5elpLK25vazUyMzRzVnMx?=
 =?utf-8?B?WEF0blF5d1k5UnFQWTNrOUd5d21zSmdzSFVxUng2SmtrQkVFMllsQ09kTE91?=
 =?utf-8?B?YThKMlZ4MlZCc0xhZ2tZbEZtS0hXNW9XUEhBZ2xWRkViSS9qd293U2dZeTk0?=
 =?utf-8?B?eTlWMVhwb1BjSFFPK0Y5MXE0TGR5Tzc3T3k3enRTSXhTQURjYm5KWnhmbElT?=
 =?utf-8?B?MFpUejlwZGplaU13Q2pyZmZSTmFTNTYyTDZGeHh2cit1YkE0UlBFVmJMM1NE?=
 =?utf-8?B?MkFyQkI3TUR3ZndNckxZS1ZMLzRKbmV5cGVFY05FRk5COEIyUVpUbldwSStF?=
 =?utf-8?B?Nm56OWI5dWJMb2pscW4zcUp3UVNmYmlTdXliSzZUSTNTWEV6dFJYU0N5TllV?=
 =?utf-8?B?OHJQbkhOVWRDM1F1U05pVUR0c2ZHRThtZnBrZGxlTU9tQ0VKYXBNSFNEeUFB?=
 =?utf-8?B?QkhpS3RoeDhxbVp6QnptVjRUK1AvdXJ5RHFyUTUvcXNWMFlhV1pYVWxuenly?=
 =?utf-8?Q?VPrCrUYuXX/b1nIWUhi9wKo2kqA0NZ7l?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:04.0855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef2b2c9-2538-4c96-ffae-08dc95caa9b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504

Based on the filled flag, create VQs that are filled or blank.
Blank VQs will be filled in later through VQ modify.

Downstream patches will make use of this to pre-create blank VQs at
vdpa device creation.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 85 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index a8ac542f30f7..0a62ce0b4af8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -158,7 +158,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 
 static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
-static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
@@ -874,13 +874,16 @@ static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
 		pci_msix_can_alloc_dyn(mvdev->mdev->pdev);
 }
 
-static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int create_virtqueue(struct mlx5_vdpa_net *ndev,
+			    struct mlx5_vdpa_virtqueue *mvq,
+			    bool filled)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
 	u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] = {};
 	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	struct mlx5_vdpa_mr *vq_mr;
 	struct mlx5_vdpa_mr *vq_desc_mr;
+	u64 features = filled ? mvdev->actual_features : mvdev->mlx_features;
 	void *obj_context;
 	u16 mlx_features;
 	void *cmd_hdr;
@@ -898,7 +901,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 		goto err_alloc;
 	}
 
-	mlx_features = get_features(ndev->mvdev.actual_features);
+	mlx_features = get_features(features);
 	cmd_hdr = MLX5_ADDR_OF(create_virtio_net_q_in, in, general_obj_in_cmd_hdr);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
@@ -906,8 +909,6 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
 
 	obj_context = MLX5_ADDR_OF(create_virtio_net_q_in, in, obj_context);
-	MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mvq->avail_idx);
-	MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->used_idx);
 	MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_12_3,
 		 mlx_features >> 3);
 	MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_2_0,
@@ -929,17 +930,36 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
 	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
 	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
-		 !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
-	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
-	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
-	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
-	vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
-	if (vq_mr)
-		MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
-
-	vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
-	if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported))
-		MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->mkey);
+		 !!(features & BIT_ULL(VIRTIO_F_VERSION_1)));
+
+	if (filled) {
+		MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mvq->avail_idx);
+		MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->used_idx);
+
+		MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
+		MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
+		MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
+
+		vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
+		if (vq_mr)
+			MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
+
+		vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
+		if (vq_desc_mr &&
+		    MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported))
+			MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->mkey);
+	} else {
+		/* If there is no mr update, make sure that the existing ones are set
+		 * modify to ready.
+		 */
+		vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
+		if (vq_mr)
+			mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY;
+
+		vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
+		if (vq_desc_mr)
+			mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
+	}
 
 	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
@@ -959,12 +979,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	kfree(in);
 	mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
 
-	mlx5_vdpa_get_mr(mvdev, vq_mr);
-	mvq->vq_mr = vq_mr;
+	if (filled) {
+		mlx5_vdpa_get_mr(mvdev, vq_mr);
+		mvq->vq_mr = vq_mr;
 
-	if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported)) {
-		mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
-		mvq->desc_mr = vq_desc_mr;
+		if (vq_desc_mr &&
+		    MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported)) {
+			mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
+			mvq->desc_mr = vq_desc_mr;
+		}
 	}
 
 	return 0;
@@ -1442,7 +1465,9 @@ static void dealloc_vector(struct mlx5_vdpa_net *ndev,
 		}
 }
 
-static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int setup_vq(struct mlx5_vdpa_net *ndev,
+		    struct mlx5_vdpa_virtqueue *mvq,
+		    bool filled)
 {
 	u16 idx = mvq->index;
 	int err;
@@ -1471,7 +1496,7 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 		goto err_connect;
 
 	alloc_vector(ndev, mvq);
-	err = create_virtqueue(ndev, mvq);
+	err = create_virtqueue(ndev, mvq, filled);
 	if (err)
 		goto err_vq;
 
@@ -2062,7 +2087,7 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
 	} else {
 		ndev->cur_num_vqs = 2 * newqps;
 		for (i = cur_qps * 2; i < 2 * newqps; i++) {
-			err = setup_vq(ndev, &ndev->vqs[i]);
+			err = setup_vq(ndev, &ndev->vqs[i], true);
 			if (err)
 				goto clean_added;
 		}
@@ -2558,14 +2583,14 @@ static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
 	return 0;
 }
 
-static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
+static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev, bool filled)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
 	int i;
 
 	for (i = 0; i < mvdev->max_vqs; i++) {
-		err = setup_vq(ndev, &ndev->vqs[i]);
+		err = setup_vq(ndev, &ndev->vqs[i], filled);
 		if (err)
 			goto err_vq;
 	}
@@ -2877,7 +2902,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	if (teardown) {
 		restore_channels_info(ndev);
-		err = setup_vq_resources(ndev);
+		err = setup_vq_resources(ndev, true);
 		if (err)
 			return err;
 	}
@@ -2888,7 +2913,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 }
 
 /* reslock must be held for this function */
-static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled)
 {
 	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	int err;
@@ -2906,7 +2931,7 @@ static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
 	if (err)
 		goto err_setup;
 
-	err = setup_virtqueues(mvdev);
+	err = setup_virtqueues(mvdev, filled);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
 		goto err_setup;
@@ -3000,7 +3025,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_vq_resources(ndev);
+			err = setup_vq_resources(ndev, true);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
 				goto err_driver;

-- 
2.45.1


