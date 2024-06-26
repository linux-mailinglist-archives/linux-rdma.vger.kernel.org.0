Return-Path: <linux-rdma+bounces-3514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA07917E0F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4339D289EA2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AE187572;
	Wed, 26 Jun 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pW0494Yd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC718754A;
	Wed, 26 Jun 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397696; cv=fail; b=g/TK7Q8b2ojOhLK2TwqtWTaOdl1c0CSiI69U/+tuNb/7boUbCkKIGVwVPPFGMZCRJymUizhRt/1U1DH+29pLUgzA4PUXOWAi3lXpGGuJRp8Y24Td9yOrWrMV97oOM094sqg3weI7bHZCGSPO4uIgcw3FmtpadsutAKzfywoPVh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397696; c=relaxed/simple;
	bh=0iWeBcz79/+AEQmAufvsbx8WFiZAwTIWu5VmPNkOuEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sccc0BMAKs1Qm+W94Ss7JLixwX4OEIiQQRfgmiuU+AMUG0Jb8TL2gLEJBMPQKEfnT/WStymwYGyl0zhi+4ZhHwkdF3Cz2+q/2dTrkM9iSEWpxeRR9iXMPmgr0HWpqMAdEN8kcI/Qxd6a4RgqC1t442a6/nwjLOlcYv/O3PtI1vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pW0494Yd; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNbtmlhQAU3PqC+BGFbJBuo18hB7021kyyYw3r/xle5+J3VdGhraBkf9nR5eM2kAXL3Y4fdz4QAogA/x49ufckbBZPAmWpnaSyEDktoqfZBnN7/dhpLf4eS3HpmAoxCqS1IlAHhca2BCUDBwt1iZMl6gf4WgpJtuJ4HpXdw+D/YHyhGHBMzuEbA8msCyujxQ4TPIGjWwldZ/DYEx7G2qLJftCPGGLJE9VUCJHTXe7m4y5Vp91xztiMKuN7Nn9cRj57yGh2QxTXJo+nhzLNQ2fjU9RyuHKOEKYUMEf/q/Fv9gB8zHT1gYQVcLwkFlqpipc4dfG4SPJ+1T/asCQXzLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vgNJQEUfZXYO77RacG1Z8OMNXfI8ewyE+OcrJZkbVc=;
 b=h7rvrxU4DRjVNMR5b7B7L47MJ0BY8mw6wBD5zwRVO7sScV+hEUg0N1LiQqIxqb0CrGYwX9KfHTiK1AkbT2GKTihSNSJ7AZwpaRoyAuJotbcAcvItG54dlFc6vXiGYFxRbJfdz3Y3U0EF7q5Len/3tZfHCUGGNI3esA1DD6Qi5+TRZMn6T1rjKcGJhjB2NMPAVq5KuX4sAsVpu6SfGpTp7ut2zKr4igIQmXWFGV3MLcF2txx46LYwHKrxMBjVDtX/9B4HENfk6JYnIdZwCTKTVUgk8DDKs7Xw1GYs0j7t/exlvXxA7Lnv2kE3PoLaKhrl051Chylm/rvsp5NlRSfEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vgNJQEUfZXYO77RacG1Z8OMNXfI8ewyE+OcrJZkbVc=;
 b=pW0494Ydi5VOJ+lC3WrEDIYfpEfv7ZzUCipAoqW33cGQ8h6s3+9uxxXrMPiKLm1h+zzgdyPvdHZp3Q4/5xf6hUe5YK3mioYeNxioOKUvEuE/XHCzB6VTWLFGg16y5IF+aPK78mSbsoKSqeZmWfhahnfDiBHateNGTkwPecW084eesTCBgXYWw9uHSKluIvEk2tvhp302TrpFDwJcuPuaJB9TA/wN78qBuqxTRx/SbLxHvMablrrP2ixSWPGfUueGjvto/xruvc/9fyKRDxIBj0bJHZI2DHR0z6x5jhxtPxBoPJJJdnjob8q7tfbpvp9RmQIkE+EQqIEPS/qXM9TwTA==
Received: from BYAPR11CA0088.namprd11.prod.outlook.com (2603:10b6:a03:f4::29)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:28:11 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::f5) by BYAPR11CA0088.outlook.office365.com
 (2603:10b6:a03:f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:56 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:52 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:53 +0300
Subject: [PATCH vhost v2 17/24] vdpa/mlx5: Add error code for
 suspend/resume VQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-17-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d0cbf4-8767-4690-f60c-08dc95caada6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk9oWkhJUUlPT2hBcGxVZTdRcDZYRFcva1d4Zy84RFZzcFlmdXJrcFdtbm83?=
 =?utf-8?B?bkxZNEpUOW9oSm1QL21FNU9kRWV2bEdpajhUenV4Rk4yUjZ1MUNlRlZYQXZQ?=
 =?utf-8?B?MHRycEZLR0F1bmcvZlQvWVpTK0t2V0NxZUlkQ0JCaUNISld0cE1vdGszOWJV?=
 =?utf-8?B?M3RBSEtUdzk2Y1piRkVnOEtwYkJaSVZRSWRlenVIY1prWnl3YmpsaCtESWNv?=
 =?utf-8?B?bVdsa3NDdjhMcWZqekdkbUE1T0tKSGRmM2plRGtINUcxcytncEJ6YjI0Q2o0?=
 =?utf-8?B?ZER5b1ZHSHBzL3ZsSit5SEtvQ3J2TjhMUzNCWjJ2cTdFaS9PSnFEdEdCTTJy?=
 =?utf-8?B?NEV3M0Q3djQ4T0I0Yi81ZjVJNU5nSys4YW1oZzJLYlpGM3JaVWRLZkJTb0JN?=
 =?utf-8?B?dUhYR1JmUCtSZmFxOVBGeHFBeVZwOVVtOEMxSHBZeHNpMkZITlpSWFZwZTkx?=
 =?utf-8?B?eXArUW96akd0ZEZkcE5LWHZGYjREZkl5d0R3NldBZEhkamgvR2F3cVNHR01G?=
 =?utf-8?B?Zjc5b0w5MDlqQk16cjFja3dFV3Vva1M4bUJ6Vm9QZGV1ejNYT0hVZFhyRTJr?=
 =?utf-8?B?UkpRdzBaczdDQklLbFd6L21wbXBra2tQV0RNYkZjSjVibUUwbXNlSUpVTkRO?=
 =?utf-8?B?eFFmcG5ncjBOWlBCU3c5aDg0c2JzN3IzSjMralJabUxQVHVmcWNybXpyMEVk?=
 =?utf-8?B?M0doTkFyUW10T052VTlscUJod1hmNUFocjdxUFo1VGVIMkJKMlBTNW1vZXpU?=
 =?utf-8?B?TzRJQSttV0Z3cTNPVnYxVHhhUlhqVmxPS3Z1M0IySnlUNkRRMU41Umk3akw0?=
 =?utf-8?B?YmVrekk5dlR4NFhFVWJPdDhNd0ExMTgrcmJjY2E4MlNvUGxsQkNnVlBVTXVx?=
 =?utf-8?B?NGZYQTRETjRWWmVkcGdOZUhSYy9tcldMQnczS29pVVZmYXVxQmFDUU1zVjhV?=
 =?utf-8?B?TEVLcEduWWFUbzNsL3hYL0dtVEVrOEJyL21rdisybkh1L0tXVStIb1l6VUR0?=
 =?utf-8?B?aithanZ4OU1WcDVxZVdxaCtVVHB1bnpZTWYyZW1yekpQVkQrTk13S0xRS1JS?=
 =?utf-8?B?QkdBOEE4ZDFHVytBcEI2dW1yMnBCQ2lEblppamtlQXFEVTh5RVVuWmZSalls?=
 =?utf-8?B?SWRuK1kycUVFbHZlU2E3MGlXajQrTmdmYnExNlVuSTR5N0o2bWRPTWJBWFFQ?=
 =?utf-8?B?V25SSWJybXljRVAyRitWanI5Z2pnUGxNamk1RkJ3U1NFWVhodk5SeGNmZ29Q?=
 =?utf-8?B?cnJHeDRuWWVCRTIraG9ldEJWeXNXalZBWjd4UFJHM3JHb2VWQjIxYmFkYmtY?=
 =?utf-8?B?UjFXdmNZc243KzFsUE1tcHV6U2pYUGxONmxzNTRPeXBtZHZVcGNSb1ROQzQy?=
 =?utf-8?B?aHQvRTA2UE0rb1VkOGxnekFURzFKM2xCM0FpRDU1R1F0WU41aUY3ZXFVZERp?=
 =?utf-8?B?YysyRkFTWDlid2lrNVlEckRJRi8xT0JTT2NXcmtJc0NmOGNuVUxadW82Z0FT?=
 =?utf-8?B?b2MvOHI2eGEwUXhYMW9DMjRHN2pQU0JaM1F0dVBiUDJlN1JIeGJRQWY4TGw2?=
 =?utf-8?B?TmhBYmllY01KYk1mOGhvREZzSkNFNjNZcFRtOFJuQUkraWVrREg1WG5xMlBx?=
 =?utf-8?B?Tnp4MlJaVWtsWm5sSForZzU2dVA0VkhLSENLQnNZMFdGTE1tenY4U2dKckkr?=
 =?utf-8?B?WFQ0UHV4MEZEdjdNWXhzSDA5LzlwNFJLUDhFM0dURDlyWmNBTllMdUx1Qllw?=
 =?utf-8?B?OEg5QWo4OWMrWDdvUnd3bTNUd2kxL0lhcTllenJRYWgxMkkxVnVQLzBhUUFq?=
 =?utf-8?B?VkFDTmlkRW1kNWtuNUVIdzA5NFkwSFBxSHJhazFNclpZcDMvb1RHQzV3d1Jy?=
 =?utf-8?B?YWJWVGRqTUZhT0ZNdkEwcmFQeGNqNTNGNFhFU0IvTEJxbXB0QzFrSC9QUlZ3?=
 =?utf-8?Q?WJCtnkIvHESRIIVTb0LBwP60TOBkreFG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:10.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d0cbf4-8767-4690-f60c-08dc95caada6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

Instead of blindly calling suspend/resume_vqs(), make then return error
codes.

To keep compatibility, keep suspending or resuming VQs on error and
return the last error code. The assumption here is that the error code
would be the same.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 77 +++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index adcc4d63cf83..8ab5cf1bbc43 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1526,71 +1526,102 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
 	return err;
 }
 
-static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
 	struct mlx5_virtq_attr attr;
+	int err;
 
 	if (!mvq->initialized)
-		return;
+		return 0;
 
 	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
-		return;
+		return 0;
 
-	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND))
-		mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed\n");
+	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed, err: %d\n", err);
+		return err;
+	}
 
-	if (query_virtqueue(ndev, mvq, &attr)) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n");
-		return;
+	err = query_virtqueue(ndev, mvq, &attr);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue, err: %d\n", err);
+		return err;
 	}
+
 	mvq->avail_idx = attr.available_index;
 	mvq->used_idx = attr.used_index;
+
+	return 0;
 }
 
-static void suspend_vqs(struct mlx5_vdpa_net *ndev)
+static int suspend_vqs(struct mlx5_vdpa_net *ndev)
 {
+	int err = 0;
 	int i;
 
-	for (i = 0; i < ndev->cur_num_vqs; i++)
-		suspend_vq(ndev, &ndev->vqs[i]);
+	for (i = 0; i < ndev->cur_num_vqs; i++) {
+		int local_err = suspend_vq(ndev, &ndev->vqs[i]);
+
+		err = local_err ? local_err : err;
+	}
+
+	return err;
 }
 
-static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
+	int err;
+
 	if (!mvq->initialized)
-		return;
+		return 0;
 
 	switch (mvq->fw_state) {
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
 		/* Due to a FW quirk we need to modify the VQ fields first then change state.
 		 * This should be fixed soon. After that, a single command can be used.
 		 */
-		if (modify_virtqueue(ndev, mvq, 0))
+		err = modify_virtqueue(ndev, mvq, 0);
+		if (err) {
 			mlx5_vdpa_warn(&ndev->mvdev,
-				"modify vq properties failed for vq %u\n", mvq->index);
+				"modify vq properties failed for vq %u, err: %d\n",
+				mvq->index, err);
+			return err;
+		}
 		break;
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
 		if (!is_resumable(ndev)) {
 			mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resumable\n", mvq->index);
-			return;
+			return -EINVAL;
 		}
 		break;
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
-		return;
+		return 0;
 	default:
 		mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from bad state %d\n",
 			       mvq->index, mvq->fw_state);
-		return;
+		return -EINVAL;
 	}
 
-	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY))
-		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u\n", mvq->index);
+	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
+	if (err)
+		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u, err: %d\n",
+			       mvq->index, err);
+
+	return err;
 }
 
-static void resume_vqs(struct mlx5_vdpa_net *ndev)
+static int resume_vqs(struct mlx5_vdpa_net *ndev)
 {
-	for (int i = 0; i < ndev->cur_num_vqs; i++)
-		resume_vq(ndev, &ndev->vqs[i]);
+	int err = 0;
+
+	for (int i = 0; i < ndev->cur_num_vqs; i++) {
+		int local_err = resume_vq(ndev, &ndev->vqs[i]);
+
+		err = local_err ? local_err : err;
+	}
+
+	return err;
 }
 
 static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)

-- 
2.45.1


