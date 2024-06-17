Return-Path: <linux-rdma+bounces-3223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B0390B48A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FB8281BA5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD81494B6;
	Mon, 17 Jun 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m8Zc68mo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DED146D5E;
	Mon, 17 Jun 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636927; cv=fail; b=Wxy5ds3/kGASjfwmJhk6trUfjC2vJ9QcNnjRgKAt/OrJg8yx0HDH2vr4zW1Uno7wOzCBzhBYMn6Rjpab0Iyy2QSdpK5W8R4OZWdfPAV7CUNO5IdXPKOXJE2287umpJngRxFhucQz1NbPhh8mOSmKrT6DnGWN8pftQWb6FqrjxC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636927; c=relaxed/simple;
	bh=iwGhZMh1OHw5bVe1fl0nsyatgiZFrD7PLgB6yeoDAug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c3DijDdRvuYh+MM0tW6RC+0yjy4125tg31HpPwBWcRqePEPR1KtiCSZn0kb+yRMUWTkG9C0x9yDVXrcywLH7mzIUyv8g6x+i3A6Vya+Q7pfqIPA82uUeX1wx+UqRWG4Xxl8+Ty1wtlFpKLwWf+huJcqfa10rIcKVQ5VCOaDVkhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m8Zc68mo; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPJiaixbmbKPKtulQCics6MeVSf+M9FW87VuSD2YfxldEtb90nm+CLtPUuHM5+Ej5mtd76ckFw7SE36x6etQQWTWNnFmnuAFHuVTEnN/5Me6Kn2tD1cqlpzxm6zWfqY+bfk/puhH3f+WHJQ0IGKAKwwjJaSll2DA7phG3/9x9IYwhHgeJq+An0vGNSr6M33oAHHqi4Rme05AClOewfd9ctmkEUqpNpramYz1j1cF+fMZxlbd/gDOwRWSrEb9dkgOtCH9Bbbdwq/sQP/hT3R8BW3Z0VamNFjW82wFBu3nh12z/nLaGmatgi/nJc5BQlT2OPkxQDLzznDEC6b6UCqU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDs3rH07IlW17NOLbrgcs9vPd0t32D7YqSbTvJWyRnA=;
 b=e/zFmHbr8COaNB6CySOB1ZCY8/x1n9HNzovscbNNoid8CoXW87YhpRXXuB3BUwqT6ES+TrqilB1aYmkilf6goDEB2RXuHxw8gvTIvJEKrI2tvopS9mkcxXVC3Caf0BvKFy6Gmlf4dNqIBA4nCiR74+KyGH+U16ePNLmW4UjTrjRPy3LaCKA/tXWH1zMtJWwidC2FFmX+iGsul3TmmJyPWt2nkNtulPfdb6pYUcJsYzlg0nhejpDcwe6nat9Uvu27/wLFI4HXXDcBTByPo86WDCCFBBQJuR2C6fnHAvhKQO3X8XFKKzkazmt0rBywgXV+6NOhtGt/rNRSEaUTCDssFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDs3rH07IlW17NOLbrgcs9vPd0t32D7YqSbTvJWyRnA=;
 b=m8Zc68mo3AIqdWtns8tm6LWMP7DeKZ64xCBR8EBlpb3Egk1fh0KqZYpYP/nFK+FTWa0CPf17KNHjghlDxhuJkrrin+pgP+w3gEu9QQwQ5ArTpgFAmuLt0HS9ctd9+X3ICYhGZw4cy1ld6ikJjn6lK9ghbRuyOZ4Fwq8FUN/tNcDDr8MIfb79qOQ5TPe4nCcMJbJMYRBryenbpkQDF5sZVb0h3fuyo49NNNlHqp3wqzZfktGgbOuZTV+a5AYhJWNDO0muasLC0JgqXnoNWNTA43Hb6uvXheEl7E1ve74ab/IPZfQDD/a2cM0apQIa8t3SD4MfVuUrIy04M0v41bMLcw==
Received: from SA1PR02CA0001.namprd02.prod.outlook.com (2603:10b6:806:2cf::7)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Mon, 17 Jun
 2024 15:08:41 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a3) by SA1PR02CA0001.outlook.office365.com
 (2603:10b6:806:2cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:27 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:24 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:44 +0300
Subject: [PATCH vhost 10/23] vdpa/mlx5: Add support for modifying the VQ
 features field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-10-8c0483f0ca2a@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 344cd847-2a62-4020-0bb1-08dc8edf5f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHRHOUgzclYrV3g3S1Z2WnV6cU5lcEdaTGZSSkkzbjJvYWtTelp2UFRxTU4z?=
 =?utf-8?B?VzJnMkUxSmxVbXR5all5Rk1nUFo2MThJaWxUTXBRbEZUdmprY09GamM0MmNT?=
 =?utf-8?B?T2tDa200WkRKbnRFSjh0RG9nQXJIUHZrcW5tNDZRalZkZ2RBeUo4djZiMG43?=
 =?utf-8?B?OWt0OW8rZGJmenlWMTFPNU85S1d5TGN2V1JMU05hU2dueHl4ZzQzU0xqSlNo?=
 =?utf-8?B?K00yZkRkU1VhZTZrUTVYWHpOdmhrMllSS051OEVTM2lZY05FTDdJMDlwc0lV?=
 =?utf-8?B?Um5qWjZOOEUvdEJuQWVIbUlJdEQ1R0JnYlkzS0RvVDdEN2VQZmVRY0RHdjYx?=
 =?utf-8?B?L0FHU0xGQ3phL2pDV3hpNTZNRDhtU0lZY0dVM01UYXo4UXJKV3pSWWlLSjlG?=
 =?utf-8?B?TlpXMVhJZ1FDRTB3cmhLYXF4V241bzlaZmNQTkhzRno3UStZZnBKZWMxSFZT?=
 =?utf-8?B?WHlXcnVZQUg2eWNvQ0N6dVJoU21CbklXZVo0MjhFZGx1WWlwWmVueFUvZzhB?=
 =?utf-8?B?djkzaFJ5WStpOUg1SlNnTWNnUGF1M29UdGVtTkI4cnBnYzBOTG1ySktjVklK?=
 =?utf-8?B?U1Jac0dGY1VpYTJvRndXZFZMQmVBYVYxbmVTVXgyNnlPbnhNbUh3aCtiYlNV?=
 =?utf-8?B?czZ0TFdtbjZQOUhjc3pHeEpkUk5OcnBMdVVuYkFEUmFYVGQwQytZWjlCSGdV?=
 =?utf-8?B?WUxNd3o5SENwL29FQzlEcTBrbXRQUW5lTC8rcFA0VUtiRU8zdThSQ3RPSVda?=
 =?utf-8?B?NTFuYWh2Z1BkMHVDNk1SR3FaZnJIK0NvR3hPNy9takVhazl6T1ZUdnc4Rmd3?=
 =?utf-8?B?RGRTUkMvNVNIb3Mwb3BERkFDRnBoNml1RURCRW9rcUdjaGFOZVdTMkYxTDJj?=
 =?utf-8?B?b0dCNUNDNVFLcGFqWXZXazRKOFR1VnZJVmE2RjQyc1E5a2ZlcDRTV2Ywd0c4?=
 =?utf-8?B?cmVkOEhvV0xEV08xRXl0UU01QTRPQnpza1V0SytzL3BncDZIb3k5RG9vd2Jh?=
 =?utf-8?B?YXZXTnVvWmJGbEdJUkgrdjBGRGJhejN2WndpQ1hnWTRCN3B5RkllaDRzTnJk?=
 =?utf-8?B?dVgyaDZyczdqSWJTMU1nQ2ZKRkUrellPclV5T1BOWi9Ca2ErWVdQaVFPVGhv?=
 =?utf-8?B?eWpxQS8vLzRJT1pqeGpWeitVbnNhSFNNMWpYUW80NERUMzV0VEhKdnpHMERI?=
 =?utf-8?B?U0E5bU8xMElxUEpETFMzRVR0TU9IaHljTVRjSGhUOTJiMWZSeW53ZXZ2ZzNw?=
 =?utf-8?B?V0NFb0xoNlNCdTY4VjYyYzJCUHFWZW9rWUdSTTZYeVpFa3YvLzRyeVZ0eFA5?=
 =?utf-8?B?RTRmemZBMmpiUTRIcTkvZXlnWE1EM2N1Qk9jeGlPYVA2Rko2YXdrRHJ1bmlR?=
 =?utf-8?B?Zy9Id0NpUnN4b2NKQVhSU2lYK2xuVHRySzB2Mys4d2MxdmRJajJtWjRRNlZR?=
 =?utf-8?B?OVllZzNhVVBWQ25NOTFaL1R4VXpFT0k0M09TakFjZVhVTnNiQXd6SVhIaXlL?=
 =?utf-8?B?anVENFJCOVRBcWVLdkJoeVo1cUtHa0UzL3FQZVVuaEZNeDlsa1pkM3k0Mi9L?=
 =?utf-8?B?NGswam9MZnh2b2hhSi90cm9pcWtoL2JPQW9Gek1GNy9UbkEzTEl3SFVmb1Az?=
 =?utf-8?B?S1FMcGZBZEpGenh6QXdYSmowQ0o1OXYveDFYa1lGMlhmcGZkWk5iRmdnbjZ5?=
 =?utf-8?B?WUJLTkhBVjZmbTE1TVZCNkR1Uk04QldTWWYwM0E5akRybG1jQ1FRWHhiOFlG?=
 =?utf-8?B?V2hnZEZzVzRna2pvWVlnV0NhbkhDc2t4MHhiUTdMS3hzN1hTeTMvYTNMVkpI?=
 =?utf-8?B?ZW5nQThmYkVZNFRsN29kVXA4VklXUlJXaFFNY1Q4aUx5RWY2WXh1Ym1HcjN1?=
 =?utf-8?B?VUphRlZ0N3NVbHp6S05UUkh3TFNacWFUdlZ5bFRPRUtMRkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:40.9465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 344cd847-2a62-4020-0bb1-08dc8edf5f7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

This is done in preparation for the pre-creation of hardware virtqueues
at device add time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 +++++++++++-
 include/linux/mlx5/mlx5_ifc_vdpa.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b60e8897717b..245b5dac98d3 100644
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


