Return-Path: <linux-rdma+bounces-3224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EF90B48C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E8D285478
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19075149DE1;
	Mon, 17 Jun 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCWIL5Kc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C7147C87;
	Mon, 17 Jun 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636927; cv=fail; b=JfRafMk0wB59Nb4Ez3DghOlG/pU/LuxjoBQ5oGsdRw/05o4hv96w/pakhFGUbIvOJO3iZepDnuQzmHDCAsc/ohNBbACMZHYrNJmIQblbxOUPSFe1II1hTg9gmFwWR9euRQc/R+fbI9NFjYBK9aCdIzE1rWuBISundg3FsmBORDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636927; c=relaxed/simple;
	bh=sMgRsMZT1raUxCxekdYWtJ3SoPrRT93p2TOwNQT7H14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PC/nsugoj3HrZxIwtcV5GxL6oqg/xeCuQlFU8Azezobb6VpXO7F3zyHCVIULwe0A+bFCoVrE5LlCgftcxuVnlf/SIUbd9CUBn6FbKK/wsrAv7c03wkDtEFfYgHymQoiYUlyWbwVH9U2v41BU0yDJfhWHkiTJgUlzb2e+5MDebPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCWIL5Kc; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrOj93xubLgkdGFx1HChIf7VFgyJDYNM1eagFDVXEwSWGhOEukTD2lu4di7PBkpzHDqK92sZUDKaxhUSIAVZ8jiNo0RSi0NMWvsX43MITkPnnwtvt9cPNKEKOSCIcwOMrKE26iaC053eRb7gZr579fgDFM/o6fbS9FnvZFxszKZ4WOj5juNg2D6ug7RrEX1DEZPz3DPdAx9G6lwlGerIKlPTU+YC3ywB2c+fm8hKdU8okOL3P2t9kySAv5E3kOVclu2mkmbT7gQll7zY/oYvDNavL234+kQwghq58fDY4EqAincyWzngZyNev3QmqrsIMBQziN/JrxWXpuCsVCWQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfxcLzBTqAEXjl8/FvT3hDq3MdpZXjVqdr9JwKz0FkQ=;
 b=gCqsag+vcNSGFt+Qo/kH4+B93JMvl/LMQNjgnQZeCZ/gtJI6ymLAQBBJLuPQ5KuPEqSLKFkFmegilbYKLdIkhFEl7bzNk+egY3yMBa8xNZsZ7YE7Dl1kwuqL4NIKIjw+dAzKCzyN8zLrnkvOMAD38b+8MCW5l0kPx4r3QJjxYQHOgEzGjA9MorTrHTx726LYhgLMwHabMmNVLE2riExVqo5LtqcGPXWQTuwy3XRExTxEyMnnILC9XqOJzFzo/c/WhX/4McJ7g7pKTyQ2C5hoPl4YGDdsoS0rxNN3P3/YSNd1pp1nOP13kIPv3DW5n2lJ5jOsQf6MTI4fDoux3cga0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfxcLzBTqAEXjl8/FvT3hDq3MdpZXjVqdr9JwKz0FkQ=;
 b=mCWIL5KcSxjTxzdBLC/keIyD71n7XQucxOmCXLS/8yY8EHijLtseCnBNQj4ujXGCdzwIp+eek5wnd0h8/maaWok4PAzXMz+DicQmTL2PewS+e1YmC5uaE/494DCSbzsFwQB2Cb1xkZYbiy2p+iLNbMYAWW3lGTHv8iCdAzGK+LdrRj6NQ+DEhp9G8OEVUyDwNq7uzuHcfuf/Ely27png5TesHMxc30iMEd2VZ75+R+cRKvqt1/0CaCPInkGyd3l73CDRY5uxs+vmMOfI3SyxeFdq293xZWXNbWHtDBBwEVMHAUYnpMyxN2lNee/3xdRcofpp8PNZJIfUoB8Qvl90IQ==
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:08:42 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::e1) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:23 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:19 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:43 +0300
Subject: [PATCH vhost 09/23] vdpa/mlx5: Add support for modifying the
 virtio_version VQ field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-9-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c40a19-32c1-4e9a-32f7-08dc8edf604d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEw1QUlVa1VMNVpiMDg5UDhRNnpvZUt3TkV5Y3JscHBpVGVDUGc3NEpINjZP?=
 =?utf-8?B?TlV3cnIxVEVZTTE5aHpDSEViM3pNaUMvcXRuWUxXVXM4cG9tZmkzUk4ySWZ2?=
 =?utf-8?B?bTUzODFxTnRRMmpmUTE1ZlpLUldKZW1hVVRFdmdGUWQ4cEVKeHFHQzdXcU93?=
 =?utf-8?B?Z2pENDRnSHBFNHM4cXVlVHZzTkp0OVluZ1ZqdlVFblRsNWRQRjQvcVY4a2ZM?=
 =?utf-8?B?bWp5UEdFeWxRZE80Y3BRcDhkc3BHVDluS0pKbmxHTDRuczBkRDRyZGo5ckdh?=
 =?utf-8?B?MzdWaktrUmN1aWpyUnRYWmJ5TjUxak5DakVGNi93TlpocFJPVk1xVTlCWUtE?=
 =?utf-8?B?ZElLOFF6UWh0TEFDQ0hhREh1djhSQjVOT2RSZk9jTzRkdTBTS3JPbzlvcVFN?=
 =?utf-8?B?cWxPVWNac1htT0c4VFRkeXUvb0NxQzNpZEdEUjJ6QzgvRDJRUHVMSDRlRXUy?=
 =?utf-8?B?MDlxMHRzdUZLS2lHVUF1Mm84SjNoeC9ZNzBzMVVnT2VaK3R6V0diaDAra0FR?=
 =?utf-8?B?SjBZNCtEUU14R2RVQVY3MXZCSkNPZmxvWi9ZSzI3c2kyWU52OFJYZE96elJ0?=
 =?utf-8?B?MFRiV01BWHpnajJ4QmphYXpaSzZLTlB3VFpXczJuNmc3RU13NmxYWTRnYzk3?=
 =?utf-8?B?czNVcUJVQVNKUkRVaG1jeTFaMFJWSTBWVVJLanZycGZJSm1HK0RMRWw5Z1Ev?=
 =?utf-8?B?VW95bDVUNlFPaUthUG9sTzlPQkltdEZma3EzQjNiWVdkZnpRWnBzUFl6VWla?=
 =?utf-8?B?czVhVU04TkU1VW9xWWdVTEpyeE9EN056ckVYUytiZ3NuM0RXWnpScis3ejhI?=
 =?utf-8?B?Y3ZjVGtLLy85T2ZSclI3eWJMNzhIdzR4NFpEOW03MjhINS8vYzFMS2NJNEdI?=
 =?utf-8?B?QVpiVG9IVWJMVmV1UXFIRk5tdmZxaW5Pb1JpS3BkLzRnMThtSkJIQUZHeTFT?=
 =?utf-8?B?M1dYQm5heG13ZGR2WjFYSGdCYXFicnRDTFFUMW9aWFo1eEZhL0ZyTVBjODFV?=
 =?utf-8?B?amJDTjRHaE96Vk9kUE1JZXdTR2hTeVh3UkkxUXZkaDdoYURDd0VTbklYTlVP?=
 =?utf-8?B?Q1VwcldtaEFvRXhRTVhJOWYvRjNqT2R3RzNscVRZayt6cW9ydEZYTWdzRGZG?=
 =?utf-8?B?b2JNVTd4MDNQTlRYb0xxNjFERjdGbU9sUStkTUJBajN6UzdCTmJhOE9WYTBy?=
 =?utf-8?B?djBQbmdSa0VYR09TS1VXKyt0WDIwbEFwaDIzczFGa3gxeDZvRFYzVWtySFNX?=
 =?utf-8?B?VUlUdGFvbXJ1TjBUcmJmRVh5aTFaa1VLU1lGL3FUdTEyc2RtUjN6cndoS0pl?=
 =?utf-8?B?QS83S3hIeCtmSXlPZWQ0V1lGSWI3ZC9nUlpjVjR6aWdKNHNaT3JFRjYyNDFj?=
 =?utf-8?B?REFjcmFBQnhjRldiU1dJY2lrTEhZN0xkSlY3RWk4dU1ZRGpkdXZHQTdLcFgy?=
 =?utf-8?B?QXQ3RnFFS2dGQkpuOUMyaWptb2FNazl2UFkwN2pzQWFKa0pjc3JOSDgrUkJu?=
 =?utf-8?B?bk41UEJuVmlrM09NRHVBOFVkK1gzR1Izd0Y4allvYm9jaUsxNXBhT3VXU3RW?=
 =?utf-8?B?NU93cmxjS0EvYndZV29teFBFZjJUaTUvZUVTcXp1SzRWeGlQSStjZzN3b2wr?=
 =?utf-8?B?U2VadGNKT2ZyWmI3RjU1eE1XeTdvTmt3TEM1Rzl5S0NKc3Z5U3QyQmNlczF3?=
 =?utf-8?B?MlNnVEhHQ012R2M1SzB6bTU2Um1oR3ZtalpTQ0pLcnk1VmJndHloQ3RKTG90?=
 =?utf-8?B?K1BDSmNaNFUwM0pkSnFyWVlIZS9YWU9sd2t1dHMxd2pMZFV5WnVKNmw0bWZo?=
 =?utf-8?B?aDRyblR6bEZ2TXJxemRRdE9nR096elVoMlc3SnZSSERCUTdtT251MFo0MDA1?=
 =?utf-8?B?VWtyaWFmL2tTZDNyYk04aGpMUmJHYnZQdHJMdUF4VENxdkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:42.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c40a19-32c1-4e9a-32f7-08dc8edf604d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832

This is done in preparation for the pre-creation of hardware virtqueues
at device add time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 16 ++++++++++++++++
 include/linux/mlx5/mlx5_ifc_vdpa.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index de013b5a2815..b60e8897717b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1283,6 +1283,10 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
 	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX)
 		MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->used_idx);
 
+	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_QUEUE_VIRTIO_VERSION)
+		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
+			!!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
+
 	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) {
 		vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
 
@@ -2709,6 +2713,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	u64 old_features = mvdev->actual_features;
 	int err;
 
 	print_features(mvdev, features, true);
@@ -2723,6 +2728,17 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	else
 		ndev->rqt_size = 1;
 
+	/* Interested in changes of vq features only. */
+	if (get_features(old_features) != get_features(mvdev->actual_features)) {
+		for (int i = 0; i < mvdev->max_vqs; ++i) {
+			struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[i];
+
+			mvq->modified_fields |= (
+				MLX5_VIRTQ_MODIFY_MASK_QUEUE_VIRTIO_VERSION
+			);
+		}
+	}
+
 	update_cvq_info(mvdev);
 	return err;
 }
diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
index 40371c916cf9..34f27c01cec9 100644
--- a/include/linux/mlx5/mlx5_ifc_vdpa.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -148,6 +148,7 @@ enum {
 	MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           = (u64)1 << 6,
 	MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX       = (u64)1 << 7,
 	MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX        = (u64)1 << 8,
+	MLX5_VIRTQ_MODIFY_MASK_QUEUE_VIRTIO_VERSION	= (u64)1 << 10,
 	MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY            = (u64)1 << 11,
 	MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          = (u64)1 << 14,
 };

-- 
2.45.1


