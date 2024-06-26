Return-Path: <linux-rdma+bounces-3508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07ED917DF6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37811C23614
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FC185E70;
	Wed, 26 Jun 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aoTM0wy4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B717A922;
	Wed, 26 Jun 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397672; cv=fail; b=RGnDk30p2/u3iIpOv4UmVT7yLSj/WDNZDP+wN6jSdzPnFO5y7YR8B2bKr4su7GU39pbt4rAmtkDwR4KotS4NyM8fVmlU0awOPnkSKIeLWRdR//nz+a/AXMhmSWbex4e/aieT2jrOdelwfP5SKKgihfU+9uYatuNCiByfdKi4b4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397672; c=relaxed/simple;
	bh=Junoj/eHIKvapg6Wl8A4l8G6C2hqJZH79AFaHdqxkvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nC/TR1QcfEmcTMaxDo3ZVXH/2OlnpuD7F/Z97mkXeBQxp4qOdV1HfqIRxhu3xzRa3oLEk3t3XN8Hbp5rjsuiCbDn5R9DRlCHMTOlnXzmkxofRX710umqD1aL0NN07Ir/T788ChWuS+6hFNf4yvPXbVhw8VpsEpXfYmmCOhBE/48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aoTM0wy4; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2yvOW6kijSadhA5tdXXCszHbxgzz8LSomPSx6vFNiFlC4nlfabe7rkY178PXlFerNeO+1pXoTPZLVjgnWp5edHPIHB3coQl2EohJtywbkp629Bco9qEvIZwT28RamchLxo/DmE5SYog/nvYg/uhkVHIirVWnPpk21wvS/NUGfvoXXY9DIvIX48BP4NVclBYjJulae/BHy2a9+o30tQzEH3lF67h0R1yPEGopcPlhvjYBsx5qHiHfYyfSHH5yd9ACEJWujpL4Gx3FezBVICe/cfPmrbQPEcEmd8qg14tIpxrN6RSq8iMyHDxMsYF0Gp6qCUMRm96oeg93aeaAS0OHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaydSwgc0k9jXa1Ih1usqRxk9t9E5YQR+NHM4Xk+R5U=;
 b=dQIpxAAZN7JH695PIlo2HL53BmdEfCFbp5sO6SoBxnlWWLc7TFQyTltFBAg1TLaVHmhAj0pi6YyAELPq96ZdQ9+3aqDcPhaH2/Ozr/pYRu2jxp2w93kuV3Q3ZvMH3Bx3Tz4LUugMduf1UKA4g8CY+2UiTam5wsPwHQ3WWTj8pncwcGATKa0zGAggJbAtLoWJhPI658DpTvBqPfVNq1XYPbbwE+qeZQr4fVmCgoKX5zYG3kczm8J8o7cLDfM8fDjus4T9q6joVLoe9PZJPt0yVVOaEr+YLEWVrUQw06aF9bM9uyvd1g7EedYZjj8QNXeWfwTOwizsguLwH99RQHPCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaydSwgc0k9jXa1Ih1usqRxk9t9E5YQR+NHM4Xk+R5U=;
 b=aoTM0wy4LmV/I+XNc1p7ednNV7X0tMZpTvcWlSwa4+u1miwqsKLjcBNOE72KiLz3l5pPMaYHZZ1pUBHeTMVrUMRcOmPaXcI6UvArlqaELsTg33pJ6nymrudYhaAuQdsSIxwqmzYuqQQVQVuQr+Qg995+iMPyK9Vb04TCz1ogAsOrpe+d8efKpBgQNwfGI1+jx4UfSi4QtY0a9/Sj+RRM0S8RTVpi/G3rJnwzo8tOSF+L47YklRz70tyKAmNCFpBmqmu5AU4gYUPYq8jljzsO/I1+RI/9jKKFx1HEPvTBZafoMVYMQMyWf8FUYTdaUoAYhoomsuZ54bFfpzpAlLqxaw==
Received: from SJ0PR13CA0099.namprd13.prod.outlook.com (2603:10b6:a03:2c5::14)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:27:47 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::45) by SJ0PR13CA0099.outlook.office365.com
 (2603:10b6:a03:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:31 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:28 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:47 +0300
Subject: [PATCH vhost v2 11/24] vdpa/mlx5: Add support for modifying the VQ
 features field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-11-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bdc33a-989b-4787-f46a-08dc95ca9fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTd1YVRwVHNVd0ZaeVNwWUxnVkJGY1Z0QkR5TXlFWlFvaTFIeS8vV0lyc0U0?=
 =?utf-8?B?Q0pPdHI5SGFVNVpGNURKU3VwaDQ1TkFLZklKWlVremFJSmFVSE1UdXoxZVhp?=
 =?utf-8?B?YklOQ09TVS9acDBkZFF6cE16M09Qa0cyMmdnNjF2V3VsVUk5V3Q5ekJ6WUJy?=
 =?utf-8?B?L0NtWUJEUFpNZFV3Y0U4d3JYUUE4dmhZL2hva2FPV29uMDhVUExqVGlMQTk3?=
 =?utf-8?B?VVBYZ3ZCNDR5MkVPRTRPNHJaK1AyenpKaENrQ0g5LzdlRmhBZ0IxUElSODh6?=
 =?utf-8?B?S2V3OFBBSW1kL1NodWtldFBuaGkwNmQ3cWRGNXU5OWlVNzF3L0RETkhPWmM4?=
 =?utf-8?B?TXp4ci8yZkE1MlBxeGZjN0Z1OTh6NGlnUE45NGdBSVNDQ1prUjF5VDR0WHVQ?=
 =?utf-8?B?UGJpTEZJV3FvWm9iNmlBQmJOUGNhWTNUa21ucUpmTC9SU1R0YnRHL0lzY1lI?=
 =?utf-8?B?T0M1OTBOeTNMbmUwUUZnTUJiRWp1U3g2QzQrSE1LdzFEanNKRGVxbThGUEFq?=
 =?utf-8?B?QWdybndmcWpRNHdMNGE4R2p6bWEyZHNQdUsrRW1uekdNSDRKSlZsanZqeTJa?=
 =?utf-8?B?YlVYOG1BaEp0N2pWT0N5WlVoWVRjcnFabzZMeFY5VTZDVTVGelhyd3RIeVd0?=
 =?utf-8?B?YnNrR3N0Q1kvMEkxa2gyV1hFR1lFZ1VqV2ZNeCsxNm1MVEpPOFlQcGJSM1lw?=
 =?utf-8?B?Smc3ZzlxN2JROUswcnpYZlRmYUZWSmpJaVpGdno2ek5RMEovTldXSGdJRGtz?=
 =?utf-8?B?aEN3QnFwTzZicm5NaXdIbDRjNnZPaWNWVU9EMjE3MTIxSmpqbi8wZmtQT094?=
 =?utf-8?B?bnZHK3NoTVR2SUJwM0JZYzFLcU5zaWJHYTdOcFJCVmZIS0hUdUgwVXd6d2Iy?=
 =?utf-8?B?ZVFvVncxMktNa3g1T3NJZGVQdUhVVFo3eklQU0ZwZUVqTVhIRTNaYS9sOEF4?=
 =?utf-8?B?U205QXhwWG92V3RQWW5EOHdVRE1LSEYrb2NWWllqZkpuZ2xyRUdQclNRcFB1?=
 =?utf-8?B?eDMyMWJqVXZ1U0Y2ZWN4eWUvRWlydEFVcGJyV2hoWE9ma2ZnbjNKbkRjRnNE?=
 =?utf-8?B?cWRrQVNTUUdxa3pQMXN6Y2Qxd2xPMGxSaFlvYmE4SnZqNmNydWd3Vzc5akM0?=
 =?utf-8?B?ZFpLbVRXNWpxRTd1Sm4yQ0lLcW52Nm5nUXNvU0VHS1BQN2ZSY2RGSi80Tzl2?=
 =?utf-8?B?U1ljTE5IUXhNNVQyWmNvc3FhN0dKeVpzWWttQ2U3RXRXcDZINERBMm5pRmly?=
 =?utf-8?B?RUN6Y3h3cHVjTU15QUZINVAxVXFSVGNkanEwd1dZUFFhVXJXWHZnaEJZVkh4?=
 =?utf-8?B?ZzZmczVVS0Y5Z0ZTcGtpU0JWVHlrTzNsYUhYbVg4amRid0ErYW1Jcjl6UU4r?=
 =?utf-8?B?d1QvbTB4ekpEMEgwQnRMUWdLeTdnV0VrNyt4OWVrb0ZsZlRhNWxjVVo1bS9F?=
 =?utf-8?B?cEtoOG1GOVJDbU9YRmVuWkJRNzFnVTlwK1h3Yy9sMkRpR3ZPN3Zvd0lSclFj?=
 =?utf-8?B?ZXJuV3BmU0g3VUJwTnY5ZGhwTmk1TEN4Ui94cE5DU1FkSDZQVE9pWGpoSFRo?=
 =?utf-8?B?cGtXbFcydTlhVElCZEduT3NKL1VOcmkrZCsxTnRzVUZocW9vc1h0MDM4NDEv?=
 =?utf-8?B?ZzhtcS9ybC8xNjUwRWhSM1RGaWFKQWlHMWxUSFh6akpldlM0T29ja0NYTzdN?=
 =?utf-8?B?UEZOSE00MUdRaWdEcWJZekxKaXl2OTU0NVFXZWszellKTTZ2SHhSNmxHU3g3?=
 =?utf-8?B?VUtUTHdpY2ttUE5BeHdNQTIzUWppSE0wZWFHbGcvell5WDdKVWx0dTVwbmhh?=
 =?utf-8?B?YXRlbzlDamNJRjdZUVJhUldiTUV1aGRGNHpmM1daMFVxZ2tvd21Ob25XblUy?=
 =?utf-8?B?Z0dIYXN4RTNoK2E4SVJYOEZqUFNKQ2wzZ1cxWEtERmU0STZ6Z3M2U0x2aUFZ?=
 =?utf-8?Q?tXFhWHx5Dhxg5QCRBYl0mUeoBnrS+bOH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:47.3453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bdc33a-989b-4787-f46a-08dc95ca9fab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

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
2.45.1


