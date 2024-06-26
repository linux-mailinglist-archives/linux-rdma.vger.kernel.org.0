Return-Path: <linux-rdma+bounces-3510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF416917DFE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151C8B239EB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7017186E2F;
	Wed, 26 Jun 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G9I6mpqm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB217DE21;
	Wed, 26 Jun 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397681; cv=fail; b=gNg6oULG1sF+lrBBsZ8GpVMZdiSATaxduiiYIfgig4i6+iPdH/Rnxt32WdQhBJlNJ8a9iM9v9jUeNSqm70diBo7lU6FTYWX+uqC2eCBivaMXWm/yNC5MftoYBZuPtNrQ/pLqCyLDNjIFfL/p4wti0MGWUtdunctWErQAZMz0xNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397681; c=relaxed/simple;
	bh=wr6yC2AlBDadg7OfUZr2V7luOQlY9bjJ8Rca8V3nb6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PzX+NeoL4OZ6oCAtDSmMELPv2c619KvEz7nZRnp/dTbxFGtDSWk9JuGvSpWkAkrpDLkp0FkJiHxtqIbxoyNM8iDj267qgNHUTZ2fxVlF7tNmeoXCTePUvHsF50KAYlYnjbWlQ52E3J0KhOvQscyeRRD60bEvcCYtDH+07hJVIOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G9I6mpqm; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I68/buA5cGOD+zsn5tYAPKUyyR4sh5lq28/oYxaO2wlY40pmtmjXawB20rt58cSbW6zeqcO1jJmag6DxmFqhdL23zOFOLK6sG1i2VK+al9sL03u0Q9CLxJpG/gUrzP7m+i92+nllLYdyLjE/+2kKMV+QsC1EeytYZssAQ5tTxoKl+B/nPTkHrf9mlZkGgEq+hINCcs7rjnaLRTH+WHy7LrMrl306byFgurVRHUG+/gsZHOtfZ9I+LSslWxy7UjMwkRGFXdIQioNhWYT/6XCvUR51b7i7MLfixroDR7Yyn625Htev9LFbVDueCiYc4pdJuLChm+iwNcCiiLcV4IMpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLPFenIC4BLtDqOPEZBZgNq79p+V9Q+X1GrmfPJM8ZM=;
 b=gX0zmFxZ/PdN6LzXW8q4mgAKi3SkmsZPoEplz2pWnJg7SeIBbkly9xGlFWN2UxczHnClkR/GFlgjOOG1kganazLmq7Tiwfdu12Cq3GHFGnwrr2CGZucRWZy4YZQ4ZjCBSj+CNS26XGyf38szo3arvlS8VhTMBqHuSt+bEKfcNMmNpxVo9fGuXIYN0Fw2BrD34xNWmdI+RNe8un1CqIWQxFbjlCWejdbABuVwkcoBIZMZ3hsm/iXgfqSnA1bTmMBosVb3OVxgjLUCHdnSb+dQUZ31oUXEmSgVopiElr4OvWycFUs7WMpDz6sv7o8LhqiHM6M2mbk/yrXsQ35CCEk6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLPFenIC4BLtDqOPEZBZgNq79p+V9Q+X1GrmfPJM8ZM=;
 b=G9I6mpqmTMDBQ8d6rfqHn/ALwmgn4prfh6zfaBqlUSErBozooQ16xE4NLOmchuihKBpttAfwZusTNxPUzAB6g1RP6a0PTRSF0Vv+HPI0eQZW3AxbxQqj/JvSiEf8p0j5+tmFji8eOZO1IJAOA/yhGREoQRRGnFuYuxuvDpX+1XnZU25AS17k2QegbZKOrWvzptclsMo/2fEFCDArnIJt46EXVLLB0ZqlqnKZjZUEy17ruMoF+7G/pXdlim19ia2gAqqNikCsWRm5pCwc2PFscBmr2UjwKfo5OcO8jcj3Sdqux5tHPD1pm/V/2XjgZPJJD/NX8pjJv/jwxJNAUmC5Mg==
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:55 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:39 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:36 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:49 +0300
Subject: [PATCH vhost v2 13/24] vdpa/mlx5: Start off rqt_size with max VQPs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-13-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af08097-f8f0-4baf-85a7-08dc95caa469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVtR00zMXc2SHpqdDBHWEFiVzhZeVR1OWM3NWx1MGh3M0tJVVcwVFRZbUJE?=
 =?utf-8?B?YmlWVFM3d0tWUU1PRHFjVGdPdXhDV3BnRDhwWjlFZjBKT0NueEZUSC9MZm45?=
 =?utf-8?B?bjhSMFljdWhoU1lCNFdLNSs3MnZ2S2tVRXdPWS8xYlIyT0drY0VKMlQwSHUv?=
 =?utf-8?B?QkNOMWFIQitoMGx0UXRqby9qS2xKdzYzWldJemlsVFhSNjliSjFpd2ducGpD?=
 =?utf-8?B?UnplWWlCLzQwcU04QmFmdW93VHg4bWF4WkM3L0oxUU42cVd2Z1NmdWY2ODRU?=
 =?utf-8?B?ZGlzQmgvc0dHUksyVW5JSzNXbld2aGFDQVNOWWFnS25KMmxvNWp4RjA1ZkdW?=
 =?utf-8?B?NzRyRGdwTktGektqcml0SG9Ed0xTb2dFWFQ2Qmd3VVRLYnVQdjlPSFpSRWo1?=
 =?utf-8?B?SUxiZi9ITVQ5cmI1VEo5YWR2clZMYjd5a2VlYkswVmFOS2NwV0pyNFFCaWdL?=
 =?utf-8?B?SVU2NXVrd3RrelNRUUpONks4L3poYkxwVE5CcHRDU0lnNXNDbnBJd3hPSGJt?=
 =?utf-8?B?Kzl2QnlLLzJxNHFjZUt2Qm5rUU52Zm9Rb1BFUDNQMGpSQWlERjBZV29pa0th?=
 =?utf-8?B?dHhkRDZnU3FKb1hFZkdHSVczczlTclpxeFBGOENlT2wvMlZ1RE1Oc24rQ2lk?=
 =?utf-8?B?SFR0eE0vbGdqYWdoT25pcTFrRWJPOHlqdlp4YjlnUXhjdG1vbUpnMUJYL2p0?=
 =?utf-8?B?bkZuZk1HVWZYVnc0bXFjQzd2aVh6ZDVJbmpzZFJDU3o4VElZZ0RPVmxZbUhr?=
 =?utf-8?B?d0RudldHS3BMSS9IR0plYVZPYmkvb3BtWEtMVG9VMGM1c3E4KzN5OER2M3BF?=
 =?utf-8?B?dStTeW9uN1pkQXJIc3M2ekZEbXFWMzgwNnJqVHZBd0tPTXhCV0d6NkRkOVYy?=
 =?utf-8?B?Tk1DUUVFcWgxbytiZnhjVkU1NVowb2h0MDl3dHd6ZXpDQU82STRqWUluOUdS?=
 =?utf-8?B?R0lJY3FpM0NJWGpiM0pKTnBLVERhLzRSVzJrTnNTdzIwNmFyblF3a0NQWjUx?=
 =?utf-8?B?RDRwbzlnTlE1RHRVcHdGMG1kTkhPSU5FcHFqZDBYVi9CSXp4R21yTXBFY3Rm?=
 =?utf-8?B?bHdmRDhZdVc3aGZvS1VlWlE0T2x0VXljMFh2ZTd6REdKdUtIS0NLQjN4RUZw?=
 =?utf-8?B?L2hrY0VFZ0FIOHJRMGRQbm16SDhmR1phc1pOTzNtNC9nMU9oQ0VNZzVvU1Q5?=
 =?utf-8?B?S0VPcjczV2Y1K0trSUZDbDZQem82RWZVR2YyalN2TlpWamREN01nSVlQQTI2?=
 =?utf-8?B?TXM3WnpGUXcxRFF5UUNiRDhCeG9PTFM5YUxHV1piM1kxOWJXNHZ2cks1SWZB?=
 =?utf-8?B?UDhqL0N2UzVSZmIyUnBMVEZwNCtFWEE4bXpUNUU2M3FadFBHcWE1UjlZbHdN?=
 =?utf-8?B?L2tzMVI2Ti9EbTFqK0F6cDdPUVJXbDk0QkZWTXNaYU5nRmVSN2lmbzFlVTFN?=
 =?utf-8?B?b203VXpvZ0hqQ1FzV1A3bWFGYVZScXFWcUJDazZrMFNJMlhGYnlIeUdpM2pW?=
 =?utf-8?B?VEUrSm9qVG0veHE1eDVKc1Iwc2pCMStDdmRnTTdmeGc3L2ZHcTVjRmVHQ3FH?=
 =?utf-8?B?Z0pZdFlKZ0NSY0EyVm41YWF6aHFIc1VwR0NVbm41UjA0aVdyY3lZcGRNcVRM?=
 =?utf-8?B?UThoT3hSNE9QbjdKaVdnSTdNMHBtSGFaYmhOMi9xekV0ekdLODJaZllPQmJu?=
 =?utf-8?B?S2hUaUliMlpucTNoMk9qOHRoakoyZ3BQRU9GSUprcXB3QkM3eU9TZ3pWNXU2?=
 =?utf-8?B?VlRwU1hxOGk2czRCTExTMVp3MWRucXdzMHREZlVzMEQvMUhMSHphaGpoNVVD?=
 =?utf-8?B?d2I5MEk4Z0owaWZyb0h6S3JUQVdpOXBRc3RQRElQbHFpM3Y4Kzl6aEdJdDh5?=
 =?utf-8?B?WElJdytGVG4zSWMyVnl1cFIyWXRXcGppeWZYM1hUK1d2RXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:55.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af08097-f8f0-4baf-85a7-08dc95caa469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

Currently rqt_size is initialized during device flag configuration.
That's because it is the earliest moment when device knows if MQ
(multi queue) is on or off.

Shift this configuration earlier to device creation time. This implies
that non-MQ devices will have a larger RQT size. But the configuration
will still be correct.

This is done in preparation for the pre-creation of hardware virtqueues
at device add time. When that change will be added, RQT will be created
at device creation time so it needs to be initialized to its max size.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 406cc590fe42..7f1551aa1f78 100644
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
@@ -3718,8 +3714,12 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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


