Return-Path: <linux-rdma+bounces-3507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0EF917DF1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F911F2340F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A7C185081;
	Wed, 26 Jun 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rF91A+dB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E6184124;
	Wed, 26 Jun 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397664; cv=fail; b=htEHiQfHsWUG4B0/tDm2WrZZ+YExYByX/0C2zSSUxaCf6Ie/VXcog8QeKq8qKbejaGUfVJGLCI3HhB5rSTHpe4N2+xVz631IoNcpOs17eAGGAr8BaOzjdK2hnQfbmIR4iYhoZ3S9WaKeQiJ5qKdDhanAoLusl/hxa77I2zXRNf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397664; c=relaxed/simple;
	bh=uZvmrWO/j45vltG/Nhcg7pY6TIaM60oqJNJMuTNAtUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LGr3rzIrdVzwL+cq22Bmh+guEolKYcpwOvFvlRj3UiWfhBxwfnUOSEF7yBsAYD4kAsUq70/ivRTfjUejcH6UV6QylNw/w2hM+l7Q7l5WPvsvMlzTlwAXcQR++jtGyIfzBnYi7jVWzV2DPWwkEDS3YzDSKYWzSkK5RZN4UzjXJIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rF91A+dB; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrWckY95RFQASu/zbrCPniw3hHYEOr7r0ZmMNovGrxicT8fd2b8Ig+jb3jEFT2msDS2rhk7vPh9FgtJoXr5MhFak1TBb5iWK82aOEiSc1IlcQrDdK2TZS51t+fG4nx5NP9SbpXxXnV3sDjW5IFpFiMA36W75exiKd70xrPUWLwQT4FXofEtCA7GgRyN/a2/WjQ4Ozn98gg1O5E1tb5XOoFYo3+Fk+ERQ0CWzAw6AVUjjLEP5/hntb2flTvj1FurTI86+yF3keGgaKwhkByoJrLWGQ13uwqEAzrTE4wfPjVVfxfru5GtmUM720m+JD8m5pi9jVF3Iw5Z9I/qPIPJgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WENTZBLDblOHFvxqPw/a/sE2ap9DMHK/kXfx3y8FtaA=;
 b=HFnHuIWbhJmdaJXR8A/y8UnpKd+fjZLbInC6/o2MTq5+wH6Yo4G3wle0uHxYYdUq+RiBK2ApSuTVI2uyvZNdCBF8ETmJuH/yAG7w7BkyfhIx1r6xir6CkQa4uolP9WyOIxAsUHrWYs6PXYS4OFFK0HMMUvceyuv37fTsBujjOymDW8VxECeJ0tHITN6z1d+yhn/5UWc01dZKfsVj2YjOGLKLXPg14jyasZvqAchFYVmeExt9Qdf7bvcnDjeiXQpI4iljIdIO5BWIOLsx99EiSQywrTPIpIcUws/iA1W7FAmxn7B5Ze2NKPYyH9G0MAko/wQoH6lUeCQiUqKx5aE6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WENTZBLDblOHFvxqPw/a/sE2ap9DMHK/kXfx3y8FtaA=;
 b=rF91A+dBkgfgJfyJuPjOoWgOMdsexESef3wcfEjVYRthfge8NRtUqYgF9JnSjDAdvcScKIOfPRnELHqhJnFxf4afsWjJecc/xXLA0z5kSrqq1ZMWqp+YtoJriYGXPh6OH3NCdrd4GAAuUFQzWRFI1qlzRBaz7yW3w7v/VVciKTmd4imN7yjJCHnWZe5kbzXb3vnWdlM/crtFL2aWoKFwZNXDndrZ9CgZf2FyEfRqFAR3lA35MUV3A4mRHuFkTzvtEBb5Pwp/S9GSx356sXKuSRKntGHQslieouS8a6e8J7GoNFhbs8LbuA74xqeKow0z1mjO43gJGk02+3YAvjR+Rw==
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:39 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::5c) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:27 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:23 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:46 +0300
Subject: [PATCH vhost v2 10/24] vdpa/mlx5: Add support for modifying the
 virtio_version VQ field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-10-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: bdefe25e-b6b9-4796-b0b6-08dc95ca9aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGVNZ1F4TVBUSVVRa2lKVDM5M2tudWtPYmJ3WTF0MmxFWk5xNkNyc3lKOEJD?=
 =?utf-8?B?ZHFVRnJONWdRS3lOWWg4ZGp1bU0vc1dBYlpuYmR1UzlXOVVOaWgwLzZEQXY5?=
 =?utf-8?B?VW5oTUZTM0lUbFdQZDNXNHorZXN3Q2plcWp6N1NpNWI2MU5vd3llWW4wTHQw?=
 =?utf-8?B?TTJpMkZvcEJVWDFjcTBNN1B1QWM1dFBwcDI3MktkYytoclBOWGY0aWswaTJF?=
 =?utf-8?B?NTRiZEd6cGFEMTR2d2o4QThsTHE4R3ZPWlhWSFVIczk5WU9RVm5XYm8xRUlF?=
 =?utf-8?B?cm1OQ2RKeC9SbUpzSXFLVndWU250eUJ4K1dKY3hoeDBGK1JURjJac3lHcUs3?=
 =?utf-8?B?MktweExkWTNYOWFvV0VnT2t4MW9UYVZUMEdJQnVKWFdFZVBPcEJ5L05hZEdB?=
 =?utf-8?B?bWhqK2NvcU5GdERydmdsVVhkRUt0NGJkYXYxOVBQNEh2WEhuTkdtNmMwenN2?=
 =?utf-8?B?RUEyN1g4L09wVDlZTm9KbTExeDJXb1pYWG9sVmtpY0FqMTRNMEVDQTB6NzN5?=
 =?utf-8?B?UGtkY3ZES2hhaDdEaVhJVmp5dkE4YW1kS3dsNUt1RDlrSWF5WlpWTjh0TnVU?=
 =?utf-8?B?NDBidXNnUDJSRSt4YWtYU3pydnRKT1M1S2dPUkdUMEJUYzczWDVneERuN0hG?=
 =?utf-8?B?ald1bzNwZ3NiSlR1dktkOVl6Ni9rTS9jS0VOUS9vSThzd1piOXE4S1JHcVdZ?=
 =?utf-8?B?NW93aDJST1dpVDBnMWg1SjRDV2gxTGhLMlg4K0hvdTVNbXA2ZHk1VTNlSEtk?=
 =?utf-8?B?M2VWbitYMDMraWgrTWtRekZDUHhjZjltcmdUdTJmK1BXNGE1OHNkSDhyZnBU?=
 =?utf-8?B?YWpFRmx2OTdvc0ZIOGVsOUpFemZEeXVwODU1eVdMQnJwcm9LRlpXZjFKMzZK?=
 =?utf-8?B?bHZ5N09NY2Z0UitPV1JYTS9qVGtIeGwxV29uYWp5SFVWc1I3bFZWZG5VSmdN?=
 =?utf-8?B?VWI2VVYyZlNyV3JCbTFaVzJ3MXI5WDEyQ3NwYWRORDZBNXZSK3RGZFAvUUFG?=
 =?utf-8?B?VVhBNC96WFJJaHJMb2xQT2J0M2ZOYVM2eXZqTDJUSUV2TzJwbys4L1RaVmVS?=
 =?utf-8?B?WmlOQmJNZWpUUFVjK2FJMzFlMC9vMUo5NGlvalRscmNhd0t3OVhGcTFvVUxw?=
 =?utf-8?B?MzFYcnowSjltdHJEZXc0QkZZdFEvcWZMVDlCWTg2NWN2Mk5xSmZJYXpPdFps?=
 =?utf-8?B?T3I1K0FyRVEvQ055MnFUd3UwVGFWM0hja0x4WktaL3Rra3UwOXZLcFIzWnFX?=
 =?utf-8?B?cThONHllR0hKYmlYZXEzTm9YOEY2eVE0NktNV0VmYURWbFJDT1kyc052NDh3?=
 =?utf-8?B?WUwrVGRvSkNMMjF5czE2NDc5NHlHRUt2blg2RXYyQzl5SXJBU3BZczhyYmZV?=
 =?utf-8?B?bE1iY3NGRnBkNlMzeUFxOWlPdWwvQjFVdHg0VnAzQ25Cd0pjdXZETEFIZld3?=
 =?utf-8?B?cy9FTFBjTUVVcDIwUGNMOGUrZ0R2YnpodmJ3ZjBDS29aR1oxUjNDbXRIV0ha?=
 =?utf-8?B?eFowUGV3T2F6aWxDOXBic1EwUjgxSnJYNWZlV3NyNUFDZnhMWjRRWlJjSzJr?=
 =?utf-8?B?THEvL2FiM053RHdnM1ZzV0hQREx5bG9tZ0sxYjNZYVBWdk5Vc0ZHT3JaRUxO?=
 =?utf-8?B?TzRtdndMZ1RmeHZxMmd2dkhaME9TQmt0bTVZTXVRRWFGT3lrbmloTUR0Tnlh?=
 =?utf-8?B?VEZlc2tzMllwZDJudFBUWGtmM2Y5VlRUM09tN2FPL3dURHkwbDhKTGFNRGRD?=
 =?utf-8?B?bDZMZVh3LzBTeEd0OHJ4YUJtalpGVWk1QTJoTStHY2F6dVRPSmpkRUt6SkFo?=
 =?utf-8?B?clNHdG9YNDdxZjEzQzFZeWpxbjdaTHZrR2VydTFMWXNtMlU5OGJocWJpRDY5?=
 =?utf-8?B?dThEVlY0VEVEMnlQTDZVSWNaRWZmejZGSk9pMlM1Q1dVZnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:39.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdefe25e-b6b9-4796-b0b6-08dc95ca9aea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

This is done in preparation for the pre-creation of hardware virtqueues
at device add time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 16 ++++++++++++++++
 include/linux/mlx5/mlx5_ifc_vdpa.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 739c2886fc33..b104849f8477 100644
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


