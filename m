Return-Path: <linux-rdma+bounces-3221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529890B72F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43C6B3A57C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73375143C74;
	Mon, 17 Jun 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e5q4Gh6w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0E140380;
	Mon, 17 Jun 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636922; cv=fail; b=m2B+7boKRRWEI05+BVTmfTvQIUwX7N+VBTuzEps5kKx3oxJBBTX2GepKXnOgqn/NkVqawfiB21WGW7HbHYIJ7RSK0nKsWe+vWRnww/oozkXNor/O8jIHhGbdj+AzUpRSorcsAojJrh0fwM2ewWO658rOwjRtgeXyTtFjIKm3pIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636922; c=relaxed/simple;
	bh=Cp7tAXzhQE+P7/IbjPuQwl+ySnyhMpGENFRwUNhHmmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g2d6R48ceATNiSyhI4jHZE68jPgwZkc/vP/EUiYnHBcy8K6dHxwRH+BDiyl8/fJ+zIERUUOgfsvCcY5O287+iHczLLC9tKyrTWmw//83kfCJ9ePkh1MqIq4Vma9BNNoiQ/eptxVDkpA3O+4xnXb7mKCeVYEMMnCc8YLIBNqDMJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e5q4Gh6w; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS1CZoIOngjufaoPzUHALUUdiQevdTHI3ubNGqacwah3tdktbUcbwAd78rq6AZxtSFXejzbV7yY1z/MITYPMXzQ6bH9inaGApRR0IETtzmyWmaWE0nOXkB4sfho7AgZTt1bxFBtciUvfmEqtnMigraa8KI5aTkhUHbIkoN4pdQ08UcnDlVeENjHOBd5otSTiqH37LjlzA/jWi7L3VZsVLleXDvd95oiBJQa0OtHJFpRBPQVvsxOXEJnC19cEBHISQMOR5itVRHC1MHoYwM3Ury+f4eibEIHuYKU08z3xeLP1y0skGjykC50miwkI1uTKcdig5NDwQcYfdaNeiY9s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQzmTX8odjQONLAa4OIO7L0KzlVkpAYTEX02Mc0whkQ=;
 b=h9fmkFh8JD90UM+9i5mAZRt7Saj0R8Pyd9h/0XiyHqAgissd5SwxyIW01j7k8Q5Aj9/jQ6NT8pufrTm/iz4IQ45KniVtXL3s5IxX09nWcjTC4OgHL44H1grnACb8b252xdGVo705PZfqSDSV2NuuvOaiy7woyQ698uhz3ABe2ejy54r2yhghSkjnqzW8yMimcPuVTFtOkQNdKn5W/UaU6euWIacZiA73/vaWrEWk5geG5UdxzSQ71ZW8q7J9s/J+ZO00FcoZFV2CmF60NfcFSB2rje9MkdO+JnCAyoUG3/rrc6Vc3JymQDcgkKg3tXo+NzXXwNf+nv6uHSHWdVqb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQzmTX8odjQONLAa4OIO7L0KzlVkpAYTEX02Mc0whkQ=;
 b=e5q4Gh6wWFxyXQVBExTVB9lR30h0XeLMRFXiv62dBJFyo8dOJoAwHUF0upUz0QiFVYjf6IZz/6SE76romUnsovKwuNeyIyto9sUKnWJV5Qe02nXCneYyj2iZmECzpGjy0rkfOyqfugGl4AbZ7inSIxf3R+UYaGWiB8qLzZitSKqL1d3J5YZkXHLNT2wJT/DgbSSocmRklFjgy9vm7bq0GGVf1JoRAFb1/uAd3N+uQAN9gW0tm0t7tEXbZiPzdVoStC2ZYggdyWFZ/2I2J1/4DiDCRiMP4xqI0ESSk6ssrHMpaAL8uzV/GLF536pBhTRkF60dEkJQLiDN1214temhhg==
Received: from BN9PR03CA0370.namprd03.prod.outlook.com (2603:10b6:408:f7::15)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 15:08:36 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::26) by BN9PR03CA0370.outlook.office365.com
 (2603:10b6:408:f7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:15 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:12 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:41 +0300
Subject: [PATCH vhost 07/23] vdpa/mlx5: Initialize and reset device with
 one queue pair
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-7-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: faa67e76-75a3-40be-124c-08dc8edf5c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXhzVTJ6K0c0enJFMzNhOXZoYS84UG92NU5Va0l3RHY0UGI2T2ZqUTNMSkpJ?=
 =?utf-8?B?VXphclJEdlJmaXBrUEF1Y25wRW5YRGoyMy9JK2NLWXdJT2xaTHlyRnBSaVQ5?=
 =?utf-8?B?T3EwZzk5NDZUTjRXWnFJSlpZR3VZVVpiSWJ2REF6OTJVNkZ3UnovYzJIUE5l?=
 =?utf-8?B?UzcwNlRlY29QZGhVclIrQThjcy9UWk15N0hvT3NaR2RPUktUM2NPcHZPSzNi?=
 =?utf-8?B?UVZVdlFyTDVGbVR3b3NZQU1CM2lCK21iOVFXOUNGRVhDb1dPRUIzTzQ4WWhr?=
 =?utf-8?B?YW5QSnZPeU5RenBlbkpnNHlzSE1xK3JkaGNFMzVqSklUNHhDVEZMVGd6cWJT?=
 =?utf-8?B?a3pQNkRyUU1xUjVvNEttOU9JR05QcVl1c3FaaVpBTm5UUVFCK2dkcUZYSldJ?=
 =?utf-8?B?bDBJQTg4TkE3eHc4UnJVR2xXa1ZUTDlRU3NrRU5BU0pJNmdmRmNmQlVQODdt?=
 =?utf-8?B?eVRnNWVLNWJaTUw3dlVyazBQU3l2Tk0rTVJDZDhYOFZwQllXWTNhVG4xd0hi?=
 =?utf-8?B?L1FieUc1ZTBWV3AzbmwzQXpxa2w1K2h0bU4yTG53eUVGWi9JZlVqREhBbU0w?=
 =?utf-8?B?eVFUYlFqQ2lsblQyMnI1SEtPYUgycEZKRnlxVC9jM0tvdlUzcTVjaWx3QWpT?=
 =?utf-8?B?SkRyQ3FyOWlQTnVJRUpYZUYwMEdTekZqcitzMmtaYnpoM3BWVmtBVzFJMHpR?=
 =?utf-8?B?dERHdE1kbHQrY1M2Vm4ySkIxQkdkdGpGYi9jejJPOFlLUE54NWRlL3J6cGY2?=
 =?utf-8?B?eTlsQmhiaThGZW5pak9WM0w0M3pMaG9NM3FVRlI2VmEyQjUzNHRjZkY0aVBQ?=
 =?utf-8?B?a0JCNjl4a1dYVU1sU3Nib3NyZ0Y5RW9peUhtN2U4cm9INTBFLzEzdjdYUzB6?=
 =?utf-8?B?eUk5UmxkQnBzenBxbUxBbkorOHlRQWxsamJoMmJYaTJORUx2UC9GV3RnMkJo?=
 =?utf-8?B?OGVCMXBYNENyYVJpQVpQSEYyeHo4dFNxa1NzeTJHK1ZGWVZpR0dlVEt2QjAy?=
 =?utf-8?B?a2ZMT0hPYXhxNHR5V3gzenlHaDNOQW1iVXFBZmNoLzZBR3lRQWNmSDRHdm1J?=
 =?utf-8?B?RFBZL1A5MjMxRytUOGZSRGxVY3plYkQ2OCtwSklIYUVEM3FyNDFJcjBWY1E0?=
 =?utf-8?B?OFU3SWg1Zk9yQVJ6UDdKQm95c0pYa3dMcjhVWEFhbFZacER5NzRlUDRWU1N3?=
 =?utf-8?B?NWRuVHpDc0NkaGlEU2UxR0VteXBzRE1QTmZiUVNFcnRmbzgrY3BYOTYwT2lS?=
 =?utf-8?B?ZEFXdGZLSG9hVUZhaEtqdGdrWjNQRUhTQjA4bndsZHhZNmRFTkZFQzNtOFc4?=
 =?utf-8?B?TGMrc0dyN0xvWjFRTnJLVFNJOE5JcW1HQVZzMytVLzUvN29OVTc5Z01Qamdu?=
 =?utf-8?B?TVNnZEU0U3kvUEZsL2hnaVhYYlQrNzJDY3Yra2ZWZUJZdWtsdUw2MTUwSWl0?=
 =?utf-8?B?VjNaRW5xVzJHM3E0aGswUlRQdHk2UElZVks5NWlQbDZDSXJZK05sZlNUZXdm?=
 =?utf-8?B?RGZtNFRZRTM5bnl2Q21xck5QYkZnZVBzbXQzcFN4M3NpNmpOVGlZRDZBZjU5?=
 =?utf-8?B?VzEyRnNKQ0ExSXVzK04rV2swaWREMUY3Nlc0MmVnNVZiSno3MEI5a1FmclVZ?=
 =?utf-8?B?L0Q4TWl3M2orU2VaL2RkUVg0WHVDc1krMTJQM1JHeklJZVF0Wng3dW9BWThK?=
 =?utf-8?B?MCszMC9nWE44OCsyZnlZb1BhNElMejZ5cGFTcC9qNDU2Ym40ZE5uWW9ubS9E?=
 =?utf-8?B?eURMMGJrd1BXWGpBQ2MvRjZIaE1Xc0N3ZjhzdVF3ZlZuS1BCK1Ird1diRUdZ?=
 =?utf-8?B?dzZGSWFwNk5vNXJFWGZyR2NUYzNodGNDN1l3T3pBUEs1SlJRWWRBTXZxdlpk?=
 =?utf-8?B?bFNIbmVUSm9jdS9oSHl4NTVQaEtidm9vU01IREVTNzVFSnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:35.8510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa67e76-75a3-40be-124c-08dc8edf5c7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

The virtio spec says that a vdpa device should start off with one queue
pair. The driver is already compliant.

This patch moves the initialization to device add and reset times. This
is done in preparation for the pre-creation of hardware virtqueues at
device add time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index eca6f68c2eda..c8b5c87f001d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -48,6 +48,16 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define MLX5V_UNTAGGED 0x1000
 
+/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
+ * 5.1.6.5.5 "Device operation in multiqueue mode":
+ *
+ * Multiqueue is disabled by default.
+ * The driver enables multiqueue by sending a command using class
+ * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
+ * operation, as follows: ...
+ */
+#define MLX5V_DEFAULT_VQ_COUNT 2
+
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -2713,16 +2723,6 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	else
 		ndev->rqt_size = 1;
 
-	/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
-	 * 5.1.6.5.5 "Device operation in multiqueue mode":
-	 *
-	 * Multiqueue is disabled by default.
-	 * The driver enables multiqueue by sending a command using class
-	 * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
-	 * operation, as follows: ...
-	 */
-	ndev->cur_num_vqs = 2;
-
 	update_cvq_info(mvdev);
 	return err;
 }
@@ -3040,7 +3040,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
-	ndev->cur_num_vqs = 0;
+	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
@@ -3643,6 +3643,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		err = -ENOMEM;
 		goto err_alloc;
 	}
+	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
 
 	init_mvqs(ndev);
 	allocate_irqs(ndev);

-- 
2.45.1


