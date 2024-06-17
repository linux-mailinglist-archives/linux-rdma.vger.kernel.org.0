Return-Path: <linux-rdma+bounces-3225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4824290B492
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71481F29D3B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E0147C87;
	Mon, 17 Jun 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRaluKd2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4D14BFB1;
	Mon, 17 Jun 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636936; cv=fail; b=pxFGRAblvFntByg6Wvuag8s/3DfAtYSfaB4mGN7tg5R8wyLJY7NuQpk/m+HaFRH1tADng8u27j30D24nkQSFaDg45qkDtbqoe+msmEBaD52pZDGbS4GxeUXMlWSfcIOic8E/hzEm8I6sbHg6/jQDjuv60xc6s7uE36OC7kgZL0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636936; c=relaxed/simple;
	bh=31Vz6oC2A6FECayBVpRNi7NwNchdYB4T0wlJotGXwNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XlnXLrbXuzlJAB0zjpy1DyQvRsHALSzIRxrKFbLng9vPIUeIdsdKyUxp9Yp45c3T1x9UGOuLUT2ecxaq3bp+Y1yuibpUeJ1thCO85wYPm24+mLLtdqFU9Kcu3T23LZXfo3aisjpExJQaBUswyBgcFR3f5yZZJ6FQR7v9qCzyOvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jRaluKd2; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LauUfucc2xfaT/zOPlTsQvjnnJsOSwdBqSD+ujn5UTBDsVNjrYM7ZU/eMas5auZfCTKSvVWjGvMMqJA7fH5lsAfRNzFgW+Mbp0oG9CK8HiS2d4ZjPKlQsFcWj74SM2+Seawx5pP5ko+wZUAfY3cPzukWBkV1ix8sqGPZobQEhYnbOWOJ6A2eywUUxKCZUvlK43W+xh39rgADhXSTEFA5LfZvaW6E8U3loZgzaUQ+VtD+kUEB6K0Qx6E0tsKoL+/6HgzxpMwHL4+5/WbIxBGUyNM/Jkitx0ExtQB5cvT4GhgKcSVytkmYW5GavfEzSX7k5lM2ypD1Yha2q5/OJITtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SXAbxEM0h4DShNV1azULSXFak2wE9vDIBnEma8DUYc=;
 b=LNMRqVTp828I91Uc9lSmu4JYALRA1sejNErFkTZPkG+of7RZP246v3OpRmzI7FPaJm7iG1p1lgKj1qaft87jzXvgo+J3f4eC62/SjuwbKsAldKcNrrpCrJLnlPsfZoMHCgexHqlY5zFp/9NifLMTxlXzVoTMhno2U54JeO376uEOkHXtCYKpzex4oO6Ucy+H24z4sKkSYCW7xf4NyLCttfi6l1HkToUGcfF6lylkqlKw3db6XqAtPXo5liE+KcZc6XPldB8e6B4DOv4loqgNkacjx0YprAWX1WYqlI+zwubGZ6dX9ny6+PVwzuQqVE3WWqvx2YfY9QRGcfoJCTwk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SXAbxEM0h4DShNV1azULSXFak2wE9vDIBnEma8DUYc=;
 b=jRaluKd25FVMmFprNR+M5n4JpENylNbhQkIQzLKoTpeBaMIgS9zLWYelvmPsZbZie3CBxgsAlyva4kRFklHUvkIWIen8WEOnpYr31V9h8+eMPOa2QOG6qsnpiwPD8mVLgNUzzR6MVu+qR2PqUTpQ3s9w/B2kAeLiSF0SVq3ppGLhFJG5U7iKzghsvbzD4LZbTdVMOw/GxrHIS0Cw9+Jr7OUoLfos9CF+gHb/Dr0HrPMoVjdwsAdjymWrXszD06IvULuCc0dc4FEGXuIuIDbSdnIt8vKZD/+NJL/rSsoX+upZ3qnAGWCzOmI84pvKNtJmc3t5+5Ar93Zir92r35nPZQ==
Received: from SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::21)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:08:45 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::a5) by SA9P221CA0016.outlook.office365.com
 (2603:10b6:806:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:31 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:27 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:45 +0300
Subject: [PATCH vhost 11/23] vdpa/mlx5: Set an initial size on the VQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-11-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac28832-ce0c-4239-1b88-08dc8edf6202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2x0NWRNaUNuR3JGWGZpL25qWndEVkJtblZTckxFdVM3eVZPcHdjSU1PVXl0?=
 =?utf-8?B?NzE1L1o2WjhGOFYwSzBJdThMTU9XN3J0Qzc1dU1HY0N0b1dKMHY1N3VQOHBR?=
 =?utf-8?B?NnNLZFhpbzk2NDZtS3pVcS9mTmJveXF5Y2tjR2k1QWRXUGdxQmJkUVc2cTlB?=
 =?utf-8?B?a3EvS1BQc1FFRjBzeXVkMzZMSW10Vnpad3VLY3Bqc0lyckVhTVpGUGhYTFpG?=
 =?utf-8?B?elpOUEFLUjhVUG9FT3VqZ3FVY3VRVHdXRzVOQWo0dmhqOW1ZYVpmbTJURWcw?=
 =?utf-8?B?cjRXVStSckg3S0M5cjFrRldVTjhsRlY0VTE5NHo1YTFQMXN1eGNuWGgwNk9W?=
 =?utf-8?B?MXFGWS9mTUpTRmZOUk5wNHlsT1V4ZHk2UStVMzZMbUJNb0hjYTh2R01pNDlM?=
 =?utf-8?B?d3REYWk2Y1Urd096eGozc2h4VkVoNmVzZlNJcFEycVJIUTVNV095WWZDaGtG?=
 =?utf-8?B?bmN1YTM3a09BcU5Wc0dYQ1JBNjdmL3orY2tyQTE4cnNBOWh1bHN6bDlsWFNU?=
 =?utf-8?B?b0hJN0tnU0Zyc3BOQ05mRDhGQUdjeDh3TXpVeXo0OGdHdHRTOXQrczNaNWEx?=
 =?utf-8?B?L2orUkZKUjBKaGk2OHc3Z1JteVp3NmZFYVRzN3AzWWEyNURGejFZYWQ5eVhy?=
 =?utf-8?B?N1dxeFJxYmgrREZUdTRocWxMUlBINkRsdE9qcUJIL0ptRmNUd2hXMTVSNGN5?=
 =?utf-8?B?ZVhjUk9neGpQdmJJTnp0QzVwQ0VuRnVOeWV5S2RUN2g0c3BadlZJZllhdm1j?=
 =?utf-8?B?VXlXalJPcW5lZEVrbzdTLzc2RTlQdExua2x1cTZhdy9BcEk3RTY3QUZGRXlV?=
 =?utf-8?B?MC9SdXFVQnJkcGhPRTRWRVZVZ3hWMWlXN09xNytyZUVDeWFZWVA5d3BkWFgx?=
 =?utf-8?B?Wmh0dkg2U3ZzUVM2K29rejFIRHdZRGhaVjFBekUwY2tZbExCRzFCSlUrSlQy?=
 =?utf-8?B?LzdXK3dIWEEyRVJtQjJTdmJ2TE5aaVFmeDRYL0RiWDdxbTExRVB3YjV5K3Fq?=
 =?utf-8?B?NXgyQnMzMy92TVo0a0dWNkVIeE5kQ05uRk5vOFJGTHpmY3ZxNW5jSWUyUmJl?=
 =?utf-8?B?UFc5NVF6bmJ6NS9wVVc2MFlGNS9mTTlwVHcvT1pOM2F4dStsZnJzRklUYlhw?=
 =?utf-8?B?b1dUaU1WNGpoNXhRcjZSWEM2OTdialBYc2lSL3o1bGo1dnI2OU9UQTYrQnlE?=
 =?utf-8?B?eWcyS0Rpem51dGdzV09RbjdGaVpDL2FvelBISFB5WnVZaVNBcExJSXlVY3E3?=
 =?utf-8?B?OXRuSWswRTNzRXJpRm5pU0lXSkcwSDZVdEZWZ3NmT0lNMEw5b3g1MCtrcWpk?=
 =?utf-8?B?UG9WSW5Ib0c2Mzl4RVhzL3c2SFVyd3NXcHBQZHlCRTRINkdzTkZ6VGkzNEZ3?=
 =?utf-8?B?bU44SEg1WFpwcHczS0NxRW9UQlR5QjdqNUc3YUkvNlFoWVZGa3BHOW10YmRn?=
 =?utf-8?B?QzBpSndacmx4UVNDRmQ2elQ2SEhyWTFlT00zMFFCZjd0ektpUFBkekVzWlZF?=
 =?utf-8?B?V2VxYVR1ajJKMk43MnhSMGxOcjBrZ1ZkVjRsbDJXUXNiQlJOdFFYY3pHc3pV?=
 =?utf-8?B?bTlrQUFUNjZWUTdYZ0VSdUVzak1pc3pMSlVQaGpHWTliMGRONGNzeVd0dEYv?=
 =?utf-8?B?RlFUa3BlY3c3NVdyOVFNRjN1REJ0aVVqVkR2R2lMRnp4ZSs4N3IxczhtYzV2?=
 =?utf-8?B?bTlXR3VYSnpqR21EYkZpaHhKeDhYWGRkZWNIb2NZYm1mUURDUTFQTThvYm8y?=
 =?utf-8?B?TmpwT1pzZVByaitwSHJwZ3p4QWRNN25kRm1NVlFiNVMrc2E0NlM1VHB4Zkl2?=
 =?utf-8?B?bzhTTU96QnU0OUwzVU1na3B1K1ovVGFCdjBnTVhPVzZOaDN0YnBqZHlRM3Nq?=
 =?utf-8?B?NlBoYjNncVlVL01IVDEvV3BVZjlmRWVvTU5HQlUwNXlTOGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:45.1674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac28832-ce0c-4239-1b88-08dc8edf6202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

The virtqueue size is a pre-requisite for setting up any virtqueue
resources. For the upcoming optimization of creating virtqueues at
device add, the virtqueue size has to be configured.

Store the default queue size in struct mlx5_vdpa_net to make it easy in
the future to pre-configure this default value via vdpa tool.

The queue size check in setup_vq() will always be false. So remove it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++---
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 245b5dac98d3..1181e0ac3671 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -58,6 +58,8 @@ MODULE_LICENSE("Dual BSD/GPL");
  */
 #define MLX5V_DEFAULT_VQ_COUNT 2
 
+#define MLX5V_DEFAULT_VQ_SIZE 256
+
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -1445,9 +1447,6 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	u16 idx = mvq->index;
 	int err;
 
-	if (!mvq->num_ent)
-		return 0;
-
 	if (mvq->initialized)
 		return 0;
 
@@ -3523,6 +3522,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 		mvq->ndev = ndev;
 		mvq->fwqp.fw = true;
 		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
+		mvq->num_ent = ndev->default_queue_size;
 	}
 }
 
@@ -3660,6 +3660,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_alloc;
 	}
 	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
+	ndev->default_queue_size = MLX5V_DEFAULT_VQ_SIZE;
 
 	init_mvqs(ndev);
 	allocate_irqs(ndev);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 90b556a57971..2ada29767cc5 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -58,6 +58,7 @@ struct mlx5_vdpa_net {
 	bool setup;
 	u32 cur_num_vqs;
 	u32 rqt_size;
+	u16 default_queue_size;
 	bool nb_registered;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;

-- 
2.45.1


