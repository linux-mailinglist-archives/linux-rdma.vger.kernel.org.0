Return-Path: <linux-rdma+bounces-3729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9492A1F3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AE4B22937
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840381204;
	Mon,  8 Jul 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7uwB9AV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4213B7BE;
	Mon,  8 Jul 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440129; cv=fail; b=JCFci6EzmratMaDe6bqXHTNmrjhDQyFaM7rGXgSFGuXrbFVKt66OjL6yYalNLqVwbiTO5ZDvBX86v+wDGv/U43BZKC78lOnCsL2MpqAKKsafn45GJWZMOQXxZn5biilDKcuvSHUODFgKQS7EtHNr0yIEdGNZOeA8T+cOanpsixY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440129; c=relaxed/simple;
	bh=OjyUVB+4r/eFu1fEK8AH6Azs1GAI2v2fms+1IuH27sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=C2OeJ1b/PZ6NqH3O1YNFIEzrbsc4hj517tJalZslGXJIrmpAXkhTcqyP8EsZLtM0/tWVZa8maVB9LB5uxr+geaJrQRNnJvEb1e38pMCJbwJjgTQSj0mpnu8uSnWR7Y8Hbt0S0WKyq/2RsnmkPt6fwfMKBCpjEjqG4VGPSGHbUYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7uwB9AV; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjFlF8N7zTdUaxk29Znfsrr3lXKY1EWIHf4ZOZE5ULe4JVZ1ZutRdz14DUlbWnDaRBArxNoHRhtXmsKRUrd8qVBXdoJL/ej3IobV16CrflCAo5RVVJzsPpvXR5QjXccFLoGS8q4Dk6t5EVFIDPUMim7cV1hMlsLeAW4+9FYetVS8cW5knHu2gmZtwZ52TDgrYO6oatGTWAKKpM49t2uYV91huZ91F9LfY/DoT/NiamJYUr5drzyrGS9S4OXvbwblWZdbYH3UfLFveSUdPJ2mLCqq5sCyE20LpH8vCZqunkomMWQJ36Zek7yObGzDD2o1bfIoT0Vq0CFP9byxeJYs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2+GDdoDDIsW2WxhTMKEG5z+UCDDh3rRjrNbH6PaeTY=;
 b=klS/qmdGIaZk3o21bBy+Kf83Mzv6af9rGm4juiEDAgM1IIge+vCwFOqGEMex0NYzDRI5hp0KgprgYYeQv6vPcQGzXGxUPNnvJGnUpZZJcWfJfpBlQZRiGDU5hjgydJhHT2nz2xDtBg0n+yiyh2BJ6N4hL75Hfx7KKFgYfTp2H/xC24ZJx1TP5M6bUXdX5sZuAWJlb1P4DELOrOdgVE6Lisqoemp+fPebM3hX3q+jlw59dUrGm6ibWn/qX5NNT3X8sHN8EXPxQSo+jSAsIr7pLijd42R8qY6ph0SKNmHs+WN0w8ez4qnoAu0hJ8RWMUpyILS45pScOctlnCRqIyiOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2+GDdoDDIsW2WxhTMKEG5z+UCDDh3rRjrNbH6PaeTY=;
 b=E7uwB9AVK7pjtha5LQsmjnX3+ZGlA0Vhaa+Q+G22/kPUbgDtP8r7DRVBiVuXqvxeNpUDfnhClgLNpYoiUELPjBmDOPGeRhDaq+vThu0hACEynL9eBhiAHq+P4+hBNmzS5RKuIpigJyRIW01bBizpFEy8HfD6rRgM3S/9ben00p6Q6ud4E3ewGbMH+qtPMOsHVYnFXDYUxFtfzrYZLRB6JDBdSbriilc60i3MQ+wU1ahAeFrpq5Yj2ItAiJ7mH9OPTKpCLTFxRoPjQs0Dw3AF2gqrgfz508iaCuWUoA1W8Z7tTjaCbYHSn07Msl/RXbr/Jw1PJ5bL95MpSvz9MJG6rA==
Received: from BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:03 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::1e) by BL1PR13CA0258.outlook.office365.com
 (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:43 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:39 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:35 +0300
Subject: [PATCH vhost v3 11/24] vdpa/mlx5: Add support for modifying the VQ
 features field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-11-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9e7f7b-2181-4ed9-b1c3-08dc9f45c7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmIwcGM3QThENnZHYVNGZys3b2JBTHl0SldxUWZIWU9pdHE2TlZ0Sk1wdDRN?=
 =?utf-8?B?RE9tbnVkcFZTaWJOZWw3N05GdzFmUVR1S3pTQTVNYzZNTmFBZHN3bU41aEtN?=
 =?utf-8?B?TmoraDU4a1JMaHJuL0FuU3dlU1lGRFdkN0tyTDNEUmVFYjVpc05INzR6UXg2?=
 =?utf-8?B?ZlpndWlUQWxpS1I3b3pTbVFZYUdvRzFUUjdCMjhvL0p6cTY3eGt2NHlibWZI?=
 =?utf-8?B?MmxqaVpabHB4SjFuRFBOM0N2WHFWRXU4dDk2Q0kwYmZFTGEwczJZT1l5aEpR?=
 =?utf-8?B?eEgzT3JSbHo4Skt0NjhZMlRPL3QzTTVvK2F3cDA3b09JT292V3NQVDI3TTRF?=
 =?utf-8?B?ODNYU0pQY29rYkVZNHlsVTBQZVpSRWg3VHU1Yk05L2l2SHRaSGQ4NDlDWVRV?=
 =?utf-8?B?eHVlc1NWcnFEUzNnTVZsTDBkS3hQYlVkMXRuSTlyNFRrVEc5ZE9qRzlEV0VT?=
 =?utf-8?B?VVZTN0RWWkdMT1ZNK3pyZk9LWU1BaDgwMnkxWXlncU1wbXhJYnRFYlVGcVdW?=
 =?utf-8?B?NmVSZkZMKzYwYzR3TjJQYmtwMk5oMzk4ZTR5N1E0aGkxY2I5d3ZRWW1kUFNM?=
 =?utf-8?B?dVpJTFFuNDdBUFBaYjJyeS9SbXRHZmNkUDFQUmpUVjdJYTVGeFBVMHFsc3Fm?=
 =?utf-8?B?TkwyMVQ3Rlh0K1NMMmpYSzJSR2ViZHlydEhxSUZYNlUrMVo5YVZCdXFzM0tF?=
 =?utf-8?B?ZXE1MFBMNTdiUnZJTlMvMDZVY04yNGI2eHJGdk1mQXFlQTVjZG9Xd0V2L0lC?=
 =?utf-8?B?eXZpTnNqWkJWRitqMVF1eHUxcXFIN0FEMXN6blZXYjV3d082SjNWV1d1OEo4?=
 =?utf-8?B?K251NHUra2pEQW12aGxOcEVNaWNXcDdlWDl4aEVnZzdnNWxBVDBkdEs5Mm1s?=
 =?utf-8?B?ckJSdEQ3VTJKcjZzaG56SnpCWE9zbm1XckJ3SWtMcVdndzRRSEN3U1VBTVIv?=
 =?utf-8?B?ZmpXNVlwTktSbGg5L1A2U1RIOHdKUm9iejJEZ0x2WGt1ZktOaGl5TXM3dFYw?=
 =?utf-8?B?eEYwVFUvN1IxQ3JINkV2RzNyK25LTTJ1NDliRnNNVDZmamNpSldJWWFWODFS?=
 =?utf-8?B?bzVkNTF1cy90YytKSUpXQ2haNmN4Nmt0ZXJJb1VuSlFQZUhBQXhKcFdVSnhm?=
 =?utf-8?B?cVJxdG81d09MdE1NakFKVlJtUXBOWmt0ZkNNUGdvMTI4QmZBeTR4SWxzN1VB?=
 =?utf-8?B?ZkxNKzQrNlZCdDNJMlJkMkxsQXhWR0hjN0RQZnJ6QzZ1OURFdXdqRUZPdVE5?=
 =?utf-8?B?LzdVSVI1Njhyc1QzUlcyb2VQVDdBa2VER0FpaWdYN0RicEtzcVVicVFCODVh?=
 =?utf-8?B?azVlclRrZVUyS1BjdHFjSlZKOEZxME5wZDkrVlJUcVRib1pMNHdMakVpVzdt?=
 =?utf-8?B?ME9LR0wwM3gxUzY4SUlTWU5wN0dSTWlZQUxzODQvTTZadGVWbHBYUkhhYVYy?=
 =?utf-8?B?ejBkdDVNVEVFN2pYYjFBdnlOTEJSQjMvVWkwbmtMRUE4K0FIWVM4ZlhCTEh2?=
 =?utf-8?B?VmJMSU1zYkQ0a1VnQlpZdHRvQTUrUVMwN1dlYlpnb3BzUGdiQ2ZxbUlZMGlV?=
 =?utf-8?B?MVc1Z2doVHJxM2xOU0htYXQwMlFuWXVBeFVTNFJUSUpyNSsxQndoNGx6QzZJ?=
 =?utf-8?B?bkUyRk1FclR1djBtM1JNeVFhRnQyTFB5N3RhOUt5My9hbCtQRFd2Y2I1bVBn?=
 =?utf-8?B?eG9peXFBdG5ZR3ZzZnlLVWRXQWhyNjZkckd6WkgyQVlNQWRMRVRBOG1MbVBQ?=
 =?utf-8?B?cnl1ZUszenpWMklTaUJuaHZqTFU4WlNNaXhGVjJ6TEdZWEVWM1pnbWlncThR?=
 =?utf-8?B?Tm1sbUw2VW1yUWtwa3ZlMGYzcGsxbzhkR085MkFWeWNnUWN1aFhpQ3FSZEdp?=
 =?utf-8?B?aU4weXlsY041dWJoMmpTTXFSWVc5VFpZUnlibUVYbkhtWlJyamRGYWNIV0lT?=
 =?utf-8?Q?hCUojsO0ftcqWPSMKfmJ3aDL1dAH+YQQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:02.9869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9e7f7b-2181-4ed9-b1c3-08dc9f45c7b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

This is done in preparation for the pre-creation of hardware virtqueues
at device add time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 +++++++++++-
 include/linux/mlx5/mlx5_ifc_vdpa.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b104849f8477..db86e541b788 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1287,6 +1287,15 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
 		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
 			!!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
 
+	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_QUEUE_FEATURES) {
+		u16 mlx_features = get_features(ndev->mvdev.actual_features);
+
+		MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_12_3,
+			 mlx_features >> 3);
+		MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_2_0,
+			 mlx_features & 7);
+	}
+
 	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) {
 		vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
 
@@ -2734,7 +2743,8 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 			struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[i];
 
 			mvq->modified_fields |= (
-				MLX5_VIRTQ_MODIFY_MASK_QUEUE_VIRTIO_VERSION
+				MLX5_VIRTQ_MODIFY_MASK_QUEUE_VIRTIO_VERSION |
+				MLX5_VIRTQ_MODIFY_MASK_QUEUE_FEATURES
 			);
 		}
 	}
diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
index 34f27c01cec9..58dfa2ee7c83 100644
--- a/include/linux/mlx5/mlx5_ifc_vdpa.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -150,6 +150,7 @@ enum {
 	MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX        = (u64)1 << 8,
 	MLX5_VIRTQ_MODIFY_MASK_QUEUE_VIRTIO_VERSION	= (u64)1 << 10,
 	MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY            = (u64)1 << 11,
+	MLX5_VIRTQ_MODIFY_MASK_QUEUE_FEATURES		= (u64)1 << 12,
 	MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          = (u64)1 << 14,
 };
 

-- 
2.45.2


