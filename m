Return-Path: <linux-rdma+bounces-3226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE190B496
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB861F29DD6
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19714D43E;
	Mon, 17 Jun 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rl5drVs5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3F14D2B4;
	Mon, 17 Jun 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636940; cv=fail; b=em1M7i6jImpNg/c1q8T+ZAKdvqaZAnPoAhQHReKjgz13lLb1zfKMPhUIlF5wvnUJ7lBwNEHCcx3rgzWIu1vmBXa623oPWcPBzfXzunrg4cz2pL4TjEhcTPGSK9P2tk++C1BZJMhtg/ildlbZynSiBfVqprAwdXkYKlcBk3gvh4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636940; c=relaxed/simple;
	bh=hVNa4vF72yG1FUVJhPDUH7dFuDGsiMSwmjO5E9JhiYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M1aDNEUY0NivF1p101wCIsKJnyUDtQ5YerHf3uVkkmBxsNsOIbA9/wBsUVK5WtvCJMzLRI8vhCfRqBzSRfTF2EA18l+iL+qOhNFJbwRPq2qwLwzYr1spMLWhKmiM7Kv03z1JG5mCYtMZ/hufLozce0ukHcf6d64/xmidk0znVjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rl5drVs5; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkpENA/OEXPuyTGkdWhzN+qnW8Qy0QfaCOtplBjDuAbNRd/72VOltCDzCo+oGyOFXspgKCeow5BSbYaTdk1/wk6DOxRpwbrTuJiXaciQKyKap5qSfnC7VTKHx/eUGItjTH5DiEVbZNyYiZioJ/oLbk3dGZiTsySa1bI3stDsVEZqtjUVRBcBPBBdgvihXJihzANpu8BYV5Xaoje27RYziMLHCs3qR/BNDuh70LaXncM7hdEr8971xgY09MbsMSbcFMOJ1bR/oYpUgapwjDpEzzLtbhqv5y8w4TTYKzzWMHjrzMBTwbDKwHRzyx1zDByVzAAbcwkAMGEhkuRcI+lITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+OGx9Y2GyoolpiEWe0mzcO1wPTtb2SlllQnKC1WFr0=;
 b=C7MEqk3QmST82DRf2Ghp2rQ9yZ2RWFV8p3EJ/F8N6zOFzkoaHdJ9HZQ5El0IF7O9coXXdvuzw6kou/gFJPUhxs/wklcc+U1rNvX9mFUhBy0vdakLEpi+y2LWEDKbw2oKow3/Zw+0lqn+gGaCEMT2Pf2Cmn57iNQuqNOSAR6L7/QOKdVEgjrvGU19/aIblFVFxpwXchPNM9LGZjxDRemz4HYfVk4tY81xri+Mggr8sRTvJHc4tNy3ELpkhMfTm0T9cAneE+1EDirH5sVtWRssrKo4uoA921YWbFblKJzZWT5F1T54cC4hHWvpINjKGsvsG8qiGXGOXSplXFc3UGLNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+OGx9Y2GyoolpiEWe0mzcO1wPTtb2SlllQnKC1WFr0=;
 b=rl5drVs50bjTEp7D6z/gvOJ7Kst0W/qqbJPSlCar/MmJ3wd8dz+U2IM0weqd/KusTqjVrfnM6XRVsA/Yq9WSftfbBduCDAP+ntt/wC2JxO2BqlU1O4LleXSkusmQtbEPQYJaaXNF4hZiZ3cDCI/zZPhDc8VqRXGM1yuVt9+8H+rS2tpbT0P/vIdBskTcGaFjDwAZ3MTgWAkkEWm59+QdC/Ip19wuOBvtFFSEWAXPrIdRy1ME9MkvhHWubzFlkkh4WnAlOtCz7GKWZ1JB8pFOtyHGgFoVpYz4vv2fhDwIUrDyg6lDOZkOsevAOWfpls8jPVRweGz+DWrQRQfLjwc6Ew==
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:08:55 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::b) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:35 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:31 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:46 +0300
Subject: [PATCH vhost 12/23] vdpa/mlx5: Start off rqt_size with max VQPs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-12-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: be6c5cf6-a924-42b3-e7d1-08dc8edf67ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmVHRzZhU1RoTW1hcmFGNVAxMWpCMXQwMnBpVFRWbmFPYmlXVGFrWWt1bWhn?=
 =?utf-8?B?ZWxxa0F0aEYyN21LZHl1UVM4VFEvcjEyRW90Z1UxSUdNK1dJK3pNc2FaOCtl?=
 =?utf-8?B?Y21qM2kyU2NJZFMxM2hIWlFWVGZVU1ZEa29ZVHRmVU1KTHJoSWZXTy9LQk5n?=
 =?utf-8?B?bjUyOHB1TnhTVjA3LzFzaWhZbTV6eW9IVUVaK3kyQ0w4ZXBZbzhjN241SnFi?=
 =?utf-8?B?QktKZTZnU2kwV2c4L3NhdlJ3R3dLWHc3VjFXUUNnc2E2MWpBUzh3Ums4aW1N?=
 =?utf-8?B?YjVLeGtUUXdqV3E5ZTRnQXlpSUcyZmkzbk01eEQ1UUpFUERaR0tVYXY1UlNv?=
 =?utf-8?B?N1RWSXpacVltK2tPcXRDQUF1a0E1Q3labjJSUFNid3lnK2NmbDU4QWpqakZn?=
 =?utf-8?B?T2tta1JKVkZkeHREbGdMZHNkK0dsK3Rsd2c3U2FNVld5Wi9tb01lYkNxa084?=
 =?utf-8?B?OUxFVExLS0t5TlZ0eVJ1TXNhV3ozVThkdmJjODYwTGYzUHRlRWtJMUUvM0pG?=
 =?utf-8?B?SU9VbU1tS2c1UC9KOUtZQmhQMHR0VDdPanN1UVhjY2ZNekw5aVE1RmFlNWs4?=
 =?utf-8?B?dzhaR04xSFlpSFBUYlBTVzNvWXJOZWxvcVY1WXMwMDFKenhXKzNjcmRXc2lB?=
 =?utf-8?B?YTg1N2tkS3RRcGVHQTNvb21oWWNMeVU5QUw2SnRmRVdlTHAzc1JuUkxvenY4?=
 =?utf-8?B?dW81ZDFYY2E0bGdDUk1zcnFRZUhwZ2swN0JhOEZrS01LbzhOaFhyc0ZlMEcr?=
 =?utf-8?B?STFIRkk4bG5LK08rWlAyMk1wWUhJNWp2ZEpKK0FxczQ2NFdRV25QNk9XMWlJ?=
 =?utf-8?B?R0I3TzA1ODRCcFRLTEUxNlV6dzNTWkZzYXV1RDRPRmZ2V3lCQzdxcFIxOHdX?=
 =?utf-8?B?cU9FclVWaHltKy93UFZSNXdMbWtnMXQ1Z09xNVBKdHQ1SUROcnNKUTA1V0Yz?=
 =?utf-8?B?WTZISUxyeVNvTzhPbTZOMUlkQ3B4NUl5eVRpUzA0UHlGZkxaMGh6VnZhZ3lY?=
 =?utf-8?B?aFJheXlTMlZ0Ky9UTG5XU3I2TXBDQ2pQMEFTbGNBZFAwbGc1TjNncWErRC8x?=
 =?utf-8?B?WnRXa01pYlZ4QmNwY1dkTGQ5ZEJhWVFCR21zeWdjNndHS2E4ZTVJWDJaZDIx?=
 =?utf-8?B?S1c2VnZUOFRJc1hkYU5XbFE3T2FFZTRBWU9mRzdZNWNBOSs2UVZLa1luVUpj?=
 =?utf-8?B?YW5nWWE1b2RiTkZDeUd4VEVIT3Bpc3J6R1Nhcm90cnpEaVIrOFltZzdTM1c4?=
 =?utf-8?B?cEVpWE9XS2NxM2dnQkhoQWVXMjQ5MUNBWGtPdEk2RDdjWkM2WU9KMW1tb2Iw?=
 =?utf-8?B?bk5QdlBJcnRTK1RtYUdvbGdSanBsTHNxTU1tcjJxQWtuOXZhQUdOcUpiS01q?=
 =?utf-8?B?dlNtSjB2djBBYkN3RHZOUm5JeHNzOTJVQWc3NDlZbFZUOEowVWhQMlNkRWVD?=
 =?utf-8?B?dERWai8rZEJ4MzhMN0EyZDRrTnRhK3JKZTBlWjFpVFI5cVNSUUIyM2RuakpY?=
 =?utf-8?B?NGlQOVlFMVpZaW1pMGZ0amNQYWlLL1l0aDJMQTQxdHpQWlcxdUhVcnpIY2dl?=
 =?utf-8?B?WHM1dWFCRE9mcHpNTFZVVTBRbWtxN3ozSnFXWTlMQTBlelVrM21CUjgyeU9p?=
 =?utf-8?B?MlJDMHFvdkZTbHpGL2tiR3JwNHF3cy95dGV5ekdWbFNzczlJMWorc1pLU3Ns?=
 =?utf-8?B?OGtZeEVicWczVVMxTk0zZVVBZ3ZTbWFZQlJycHNwTm4xeEl4MEM4aDd0Q0p0?=
 =?utf-8?B?cFo2aVdoU3NJeExJeHZzRXd0MWRHelorZmJjN1JMd2Uva3RPdUxDNVl1SFZ1?=
 =?utf-8?B?TDg1eEFtSXlEdFR2Y1pZU213WG5WV1l3QnNPdEE4MVR3bmNkZHBsSlZQb3pT?=
 =?utf-8?B?WkV3YlBEcWcwTUE5dnlsNjNUeGtiSE12SE1MdW1xZmFhckE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:55.1613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6c5cf6-a924-42b3-e7d1-08dc8edf67ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

Currently rqt_size is initialized during device flag configuration.
That's because it is the earliest moment when device knows if MQ
(multi queue) is on or off.

Shift this configuration earlier to device creation time. This implies
that non-MQ devices will have a larger RQT size. But the configuration
will still be correct.

This is done in preparation for the pre-creation of hardware virtqueues
at device add time. When that change will be added, RQT will be created
at device creation time so it needs to be initialized to its max size.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1181e0ac3671..0201c6fe61e1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2731,10 +2731,6 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 		return err;
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
-	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
-		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
-	else
-		ndev->rqt_size = 1;
 
 	/* Interested in changes of vq features only. */
 	if (get_features(old_features) != get_features(mvdev->actual_features)) {
@@ -3719,8 +3715,12 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_alloc;
 	}
 
-	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ))
+	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ)) {
 		config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
+		ndev->rqt_size = max_vqs / 2;
+	} else {
+		ndev->rqt_size = 1;
+	}
 
 	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;

-- 
2.45.1


