Return-Path: <linux-rdma+bounces-3742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E792A229
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F55F1F25C34
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C217149DE1;
	Mon,  8 Jul 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hj6cEIMJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50474429;
	Mon,  8 Jul 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440180; cv=fail; b=GpzpCtOSiBllKbvQuaVMWbjDazMGPt9vvm4bDjn8UwR/cOry6UKwSy7IdkZhB85/TZGgrjpTP97WKRB+sWrvMPh7VZXs3tAZh1cI9U+ajHmqbyr6nIVGgIlxUqta3R9UxiGc52VF92ZhFve1x7i77M9rJ8aV9cCmvG+U+NDirbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440180; c=relaxed/simple;
	bh=BHmnNoIXC1Qy96RQ9ZZX2ifiZIPZGAazrmIbRO1aaLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RoQzSbvTPhexRd2zIHJ1lqXPMCYXCaxP7E/UnkohncFzhofjUJUS3UvBqyLksqTZ5cZK9i3pZY5Vq8Km7nvHto1A2+MBrwn/jsFXjx8XV2N6HQtroY1Cyolx7eMecf0AuoYzZxmuvSLjpevyuDTVwD/705jcOo0aglJk9lJZPE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hj6cEIMJ; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7FG0XB4h5ooYijGjGs6gIoX5t2l7DanMcWTK4AByV50P9jSk+tGrEnJ/4OmDNETJosKkkD8EYQMKK6AslDWY4RHslfgY5Utm1jxbVOn4bdJYQnzsxByt5E0TIYxLtuE7MOPjy1dJGYCch/aReTFRJUjv2fvr9j4H6sFQfukGcHqlUmh8iHJWiUkppRx+SdcuHuE6JspkVX/P5DCPC86GUM/szlmqFGxWTMrN8gvR41RKnrdK/p/b2JLlbRTeQxzdGY0Bts5H9nIhxzQol9XZmK6d8TE3nMaif3ZSL+8cSHv87UHTUJ9zz8ZLHU2DFW1Lvrk2UDc5VkRa+xsNNlOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIURNVv3dR2eq9wrfd7hzmvuWSQTDsVM8Uz/wDQoWmw=;
 b=XB7EgKaHOsK9L32s84zfLHDFrSPNj9PyuFdNWeCXe92XFnNrsBF0g4d+lTj7Qcv9Qqg5wi6Z2Iril4fPWnEk+lElHn4AqvuRB6V0ttSGr/2E4Nlejh3qo7JFKFjugZdo8EkeFDibdnD4zlE3OJH5X25mmBxbXK0PqftP3oOZE6ZqonD5xnZ6N9U7zqQMO1GSOZCskAqOKscU9AzdCJGnr7lGMQdTmgO8EsXG74VuSyFqnF0Kv5/Jl+wTPTQrz4pB7TlYDNQ4+/YxolKNWzNcfjjP+QEjnD56Og/aKalYfByGRAd+2XX8eKVEtrYGJDOusjfVhgySCYwbURi8Ngl8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIURNVv3dR2eq9wrfd7hzmvuWSQTDsVM8Uz/wDQoWmw=;
 b=hj6cEIMJi9VCGm1dEFY8f0gC0Yi/gsCrDD4P1ob/laSCTwjMW87zEiEAYYwPVBv4Wx5BF25B4sQasH1Q6oePAkJ6fU3fK8YvaSC0pTH+J3DMyAvC8UzEdBl6yvRr60QAgyqRwy1jZ/7iKmyJ2xqp+BkHckmGw+Re+4zqp2JNS++XClBC+kkZj++2KdvYJ4jpt2jRnLXshh371yrkCIhKnF1K/DI1+ftE+tj1Jb3rj5x/zpt4GRpyOqE7QiY9cxA+zRVCboOPeJK2IPlAGTF3/chKAozO4KAQSjrfS4GABCEmCifANNzqGnGsXPs7PLlt9FPF4R/n698WC9vK13Fcmg==
Received: from BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) by CH2PR12MB4310.namprd12.prod.outlook.com
 (2603:10b6:610:a9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 12:02:55 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2a01:111:f403:c901::1) by BL6PEPF00016418.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:15 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:11 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:43 +0300
Subject: [PATCH vhost v3 19/24] vdpa/mlx5: Forward error in suspend/resume
 device
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-19-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 638172a4-1fee-44a3-20af-08dc9f45e699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R21IUzY3SEdzZmRub3UyaHduTklxTUJSRkJDdWE2MTdOVWt2RldTdnRHeGpP?=
 =?utf-8?B?UmdpNDh1RGl4V1luYmJrVk1Ia3doYUNOZzZBVXVLUHdDR1R5VE1VOHEyUVRs?=
 =?utf-8?B?UUh5YUQ2KzAwcGdMRnRSY1R4LzBEM3VJcFFmQVoxeUcyK0NXc1FDOEl0Q0J6?=
 =?utf-8?B?VmdwdjZKKytBbGlDYXFwUGY0UGRXUlNvYlVlQlU4ci81QTh0UEFEekphRmw4?=
 =?utf-8?B?MFRPV1NHNUI0RnRIeHpkeUF3MVZmOGF0R2tVSzJ6ZkRTVGdISVpYVHF1RjZB?=
 =?utf-8?B?dnAraUhKMTFlYkVkNlJ3Z0Y3aktOL2FydlBFbGdab2V6RGo5QXRJRG9jaWtH?=
 =?utf-8?B?MkttK2ZTRmpad2tTY2xnMkYxVVJIWVYxUnJkZVRKd1p3b3hDMkRCblIrRm05?=
 =?utf-8?B?NVpnVnB1RVU1dTJCcEUvb3l6L2Nod1FjYmQrOGVycGJOM09CaWt0NzkwTVAy?=
 =?utf-8?B?MXUrV2pGZDhpbGpMVTJOd0x6RWpKYmxiZGFwZ1FhVU1CWWtBMkJkbHRxQnQw?=
 =?utf-8?B?M29KNFZDamluNXJ6U2phRG9rb3RseWovQWFRdUpBYSt5cjFXVGhUY0htL1pL?=
 =?utf-8?B?azZUMWoxbC9ObW9FOEZSMDFsY29CTm1sQStSa29ZNjVySVpUMWVES0Q0L3hz?=
 =?utf-8?B?RDBBeUdNV09iNytUOWRzaHVrWHp4WTlTbE1NeWRKeHFiNHgwWktmbXNCS1NT?=
 =?utf-8?B?V0pNa3k3N3NKMDhIek1XNFhFWTM4SHFvS0NsVi9QaFA3RFNDVTlVVEQ0Z0JJ?=
 =?utf-8?B?aVhvZmVWTEowWE1wSThRTzg5OVB6bTBTYUpJVGNGYWhuZ3FQRkZ2VXYzMFQ2?=
 =?utf-8?B?SDFVZWJ4cWNhT3BwWlYzYlNKdGNSLzNTSjhMY3Z2dkxkSS9jMGd0ZkozY2pF?=
 =?utf-8?B?cDVJVGhrUjJDYjNialV0VmNkUlcyaWdEOGZxUm5PUmpweDhmUExmUmVYRmFB?=
 =?utf-8?B?VUZESFp6U09CYVUxTGlLN2pyS1Mzbjl4b1liT25yQ2czY0tSOTBNbWYxQnNU?=
 =?utf-8?B?NUtRYjFJZGlnS096MmZ1aDlzdG5Zb1MrZWVUQk5SNjhnUHpWOHlPaWZNUVhq?=
 =?utf-8?B?SEhQd1NpRExzTVRDUXRFMFF0OFNvZC8wbnhlVGhQWnNWcCtxdTRXSFdRMW9P?=
 =?utf-8?B?U3U3Zjlja2VrdzVTTUxURDc0TFRRbEt5WUpxRkpWNncxTUt3L1ZRRUtnaktl?=
 =?utf-8?B?Y3RJQmZ4V3l5VGU0RTduajNlQXV1Szhobkcwam8wemcxS29WT1pLMTN2b052?=
 =?utf-8?B?U0ErYnFBcVBpWUM0ZGRIMlk3SzcwSDdVRjg1VThVSHRnRkNMeW1Mak9wOHdI?=
 =?utf-8?B?MUFlWE5hM3dPWVVBaWRYMnBjLzBPS3BzU1lFUndTdTVYb3c2cEtiVnVwcWZj?=
 =?utf-8?B?OFNsb0hHekJrdVJBSEhMa29PbkRvb2ljQjYrdG1paUVuTVZOeGg1cERhRS8y?=
 =?utf-8?B?c2E0dVZodFdnZlNxcERNSDhxUWhXNTN3d3VtUTVReDZmemNvZU9KamN5cThJ?=
 =?utf-8?B?dDBzakY0aEQwTXhKcUVNWTk2ZlhCTlVTQjQ3MWxiUjF1RWp5S0I0aTlFT1BJ?=
 =?utf-8?B?NkZzMnlqcm4zMkdqODJ4dVFCdjg1cjYrVVlYdWdqNkN3aEljUUFKZ3VlUnNa?=
 =?utf-8?B?NWNOT2tXaE9FTmxORkJ6dUJXOGxIaGFoV2FBSVlCNUI4UFpYMHhLcmF5UWdv?=
 =?utf-8?B?R3dJTzF4S1RkcjFwdFhGMTNhOURLZ1RlUThOcHdUUThsQTQrMEh6Ung1OFI1?=
 =?utf-8?B?RVg1dGNSYlBhcXk3dFhkU2ZRQkRMWW56Nm9XVEVkL3kzR0F5U3RFc2xUcVRV?=
 =?utf-8?B?YjBhQXd0NksrWitoL2RBWVdKdGRKTEU3VzNTOHptbEJCQ0lNSjMrSVhNYW1y?=
 =?utf-8?B?MUp6cmhPV21vNmVTbXMyRjhOQU9tM2lwcWdOSkMwb2l3OCtBVEZBMmNoYjMr?=
 =?utf-8?Q?tlvxsY+d/njGS0aVneehAHK4GBO2FzfY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:54.8560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638172a4-1fee-44a3-20af-08dc9f45e699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

Start using the suspend/resume_vq() error return codes previously added.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
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
2.45.2


