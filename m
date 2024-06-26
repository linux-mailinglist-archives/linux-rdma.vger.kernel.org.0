Return-Path: <linux-rdma+bounces-3516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E374F917E19
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9984F286562
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF821891DE;
	Wed, 26 Jun 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJ54YFpk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF71891B3;
	Wed, 26 Jun 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397702; cv=fail; b=pdECgMV/fXTMGPNxy1YKCuA9UEigho84uOFxDNyOKgI0W7FY/gJunpaNAY13FRjKf7V/czJ+7WwQqY0820xesuMYJJf94yCqJ8rP2IDm+//Jz5vNdLadxJsF+V1qGsrziz/Fes9G6ft4xgZfiwlNAHs7fmI9yscu4Htu/AdJPag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397702; c=relaxed/simple;
	bh=whQRwMurwR7+5xmqkko0RXDfBCTnvyZor1nUs9Pfldk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y2Z3Vy5gpKm3Tm99aw5LycJ/DHpJMR//md01NzsKCwYwZ0ZAXYCdG99cMW+khLMF8Mw/1UTRsqVW+ByseoQkNxOsEWkMw64gJJaSFKDi7TwtzXbZqAdmgvLydVKloe/I1ouf0lfpyL37w05zoz+ivRWGhVRefR5GZwonTTkwsT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJ54YFpk; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw7ikQwrOQkeRTb4vyrdtd8nV5a/kENHR60D2sGQ6RCWbvWWSVsBK5KWsaLpMjAXL4vQZD3TwEyE9PSTSO7GyNXKJ/VSJ68or9gxHExETuEjhRN/uW9r1GZZjKlCLU0T3ggz/DvIJfUmfCn6kowximgXkrqnJIOa7f3TJinil8q1IMcwQ7rLD0MTqpbTDR+veQIwcjhAX3oFTuj/VumEjdqpdJ1LmrkYCOoO2l8BKGmEd2U9BPxX4nPYubG1ZWasvqO5xCgFfmayzzdy3sYpx3kPH7bczk+n89GyIO2Njhbs8MDnOM/8MNwpfhn7rB7hia/FtcFXMufHGx+KeqRkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC3s7q91jMMJangr3DqIrBQXO49/MF0PtoKsocV6JwM=;
 b=ETgOOfE8u2MZUQ0mFOltf7xctG3/lhNlR/fwfXirxHDCL4mKAUA33y2gI9AtRJEIcNSjUs0TVd/mxLb35RRFvcryD0/8vc2kCL9H3v3GVWNos3GoyDnFgGnKiCvVUtoMd5FG8WfP9DFKPFpy8GbqiMdkkssa2Lo2nbCuaolvKYcnuEiI2JORs+koO/8j3rNgRhSY7N1eT5wh3bYpMFCIBqLg8NJCg3a4UDThsXZ2LBXHZAHjeNTxvszTKJcIQUwA83gt6soIIQIxO6y878YwzujToHdYjyfdqLP9do8oqVH2TlKhWAd6eAGWfIinG2R2EibfgY4Hc03C9vrx83Ld3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC3s7q91jMMJangr3DqIrBQXO49/MF0PtoKsocV6JwM=;
 b=DJ54YFpkykr0+nAhx5dedInVU11Il0flu9ZJEez90hCwEd8zU2htxHK/GB9mmE+QKiO73BQKmWTp8CC9/lzN3HGFXxTGUnME+sxlTDk/+cHD5oReGvvEjuwgCiPNLR2ykKyqcJascdpqWvjGkg7XgO7Z2Z1Poeha8NWkYZiccGIPqPkMm2B051taJmsd1M5hBObwdcc4vkE+u1v3yMc8acgkNWmxsa5uQXrShEEnUO9KvSt2Mfsvk0AnU1caSe+VTTp4nAO89vyG6co1Axn7H7aMFuTfE7SRyJOU+h8AkrGM3fObg5c4wH9ZP5quT+SnWo3TNQnVknqlKHvlnloAfA==
Received: from BYAPR11CA0081.namprd11.prod.outlook.com (2603:10b6:a03:f4::22)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:28:18 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::88) by BYAPR11CA0081.outlook.office365.com
 (2603:10b6:a03:f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:04 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:28:00 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:55 +0300
Subject: [PATCH vhost v2 19/24] vdpa/mlx5: Forward error in suspend/resume
 device
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>, Dragos Tatulea
	<dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a213df-99c1-479c-9736-08dc95cab1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU5GYzNOSEVqRmtDR29MTFUwWDNVc29LUzc1Tjk4bmg5dHFkNFBBQ3dIK2hM?=
 =?utf-8?B?bGZ6UUFybHRZdzJKWEtwUndSUUdQazVPZUJ6WUh6d0wrYnkyMnZUWm52Zmk5?=
 =?utf-8?B?SFkrVlgzUE9oS3Qrb2dWRGJVdENkaXlodGhsZjk4eEZZZ09PNk4vT1k1Y2Zo?=
 =?utf-8?B?Rm1CaHdRSTVYUGM0eVhxRVlKcVhtVVQyL3o2dUdvclliemVGRGlTWU5JczQ1?=
 =?utf-8?B?MjlpL1h1Ly9zMTFxMEdERVhUT2NIeWVGa25XZlV0RU5mRGJ1ZnJnSnU4RHY4?=
 =?utf-8?B?Qzh1UUI1MUFibkR4cmdvVldrWkMwNUFnaEdEWHRodTFkVWxxbVNkYTIzSEpP?=
 =?utf-8?B?UWVMYXhjNUtDejZGbnZSK0xibGhZdGx1UjRmK294V3BJaGtBYWZxVUtUdGlo?=
 =?utf-8?B?dDRHcUtvUmhCZTNLWHl6N2k5WThSM3hqaGdaamp0bDRmM3pQanU2TjFmcFR4?=
 =?utf-8?B?elpoUXh5ajdoYnhOQkdxeXFPdFZWVHRmMDFacFpjQWZDdmEwcFNpQjdpa1BE?=
 =?utf-8?B?NDJmazhxbVh3cHRBU2JPYWpjeElRYVM5azRydXpUQitPN2MwRGdtRHltVVo1?=
 =?utf-8?B?Tm1NbUZadWdLaVJvOTlxUFJrVWQ2NG1JQVBJam56NEFMcmNpNEp6eVp5Y2NR?=
 =?utf-8?B?Y2NjVUtYRURJL0RMdGZWQXVyb2RtV2YwWWFSQ04yU1Aybm1Cbnd0dTFub3Ba?=
 =?utf-8?B?NU84NWVmZkVVSy9DZzZBNFllenhJaGxiUXV5WDZJTHZlaHBxRjdpRGp0a0NH?=
 =?utf-8?B?aWhkSlE4U1FnVzRac1RCK0w2bHhLTTZuc3o0dWV3a3dpd0IzS20zRFJ1MTM1?=
 =?utf-8?B?MW9nZzNsM3ZCME40L1BqWWwwVklpTHc3YXphSXBjTHFKR0NNcDF5VzJwZ2p3?=
 =?utf-8?B?ekJaK0gyV2tUL2hScEVRcDlodVhLOWJsM3FrcFRhTCtVemFCV0Z3ZG5NZUNm?=
 =?utf-8?B?RWxFVUxKUHR6U04wcHV3cFR1cXpTazVBOEsvakNEMTdjV2FQTGxvc0ovRUh1?=
 =?utf-8?B?TFU3UjRWc1J3S21XR3hOdlhtVUpybkZVUFppTHBQRDh1Z2p3L1pGMmdlY1dM?=
 =?utf-8?B?MWEvdGFUV0E3VjBJTlZtMGhVL0dJNXA1dlhwMXFjS21mcmxMTmpQaDFFTU14?=
 =?utf-8?B?MTRuSHVBSEp2NTJsdlZFdE0yc2dHMnZOTTI2WU1URXpOK3FnTlp1czNuN1dD?=
 =?utf-8?B?SG1MWWRFUTM1WGlqK2pBY0twcE81MHk1Sk1sK1FZT2FydENLZDVMbUlpZ0hO?=
 =?utf-8?B?c3o0MUZVa21zUGhVSDV1MG9GdmdPM3Fja3grUXVtN0hiRytvMUt1NWZvMkcw?=
 =?utf-8?B?VVVKNU1sNHVxdFVXUExQWitYeXdHdjJzaHcrdVVzNTFCbUtseEkyeTFaZ3l0?=
 =?utf-8?B?WFB6ZG5Ea1lLampVZVVNcjJnQ3VPTzQ1bUt4UW8xcHpSYlBOTHgxQ21JOWdk?=
 =?utf-8?B?YlM4MCtYQ2lTVXJJb2NKd29FWG8za0JrYTVmTzExWWJrU2hZeFhRaWhGL0g5?=
 =?utf-8?B?UDRMN1V0bGhqckE3Q2N0OGdpemdOb29ub3pUT21tWFp4UlRNdU4vUzVGWWtC?=
 =?utf-8?B?T2FoS1FkdzY5MjhGY0lZTXFyNm5HeXZmTmRlV1d0L05rTGRFUlJhSzdZN1ZH?=
 =?utf-8?B?ZlJKRE5lK0swbnRYOVZPcFNOaUdzQjk3WnFxMDN0L3JiYXJrbm9ObW9WRzY1?=
 =?utf-8?B?ajdkVHNJWndRNTB5REFrZmhhZXV2WGNtSmY4YmhhVVd2NjJwdmxkNjhGZ3Vm?=
 =?utf-8?B?ODY2ZE5pY0ZwdjhOd2ZyUzhCRGJkcHJpREpoTVQ1LytMdVQ4OGhLRlFPbUdx?=
 =?utf-8?B?YmVzOEVMU0pvVTBoT1N6aXEyNFc4dmVsRnNTQWFaakFXUzVJTzJ1YXJwb0My?=
 =?utf-8?B?Zmg3WjhOeWVubDdTZG5leXI1N3QvV1FuZkIvcGtWa01sa0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:17.7566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a213df-99c1-479c-9736-08dc95cab1c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

Start using the suspend/resume_vq() error return codes previously added.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e65d488f7a08..ce1f6a1f36cd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	int err;
 
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	suspend_vqs(ndev);
+	err = suspend_vqs(ndev);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
 	up_write(&ndev->reslock);
-	return 0;
+
+	return err;
 }
 
 static int mlx5_vdpa_resume(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev;
+	int err;
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
@@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *vdev)
 
 	down_write(&ndev->reslock);
 	mvdev->suspended = false;
-	resume_vqs(ndev);
+	err = resume_vqs(ndev);
 	register_link_notifier(ndev);
 	up_write(&ndev->reslock);
-	return 0;
+
+	return err;
 }
 
 static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,

-- 
2.45.1


