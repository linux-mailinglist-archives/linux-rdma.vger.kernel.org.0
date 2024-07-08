Return-Path: <linux-rdma+bounces-3728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1292A1EB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02F72840E9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFC13A405;
	Mon,  8 Jul 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suGpCmBb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4285137905;
	Mon,  8 Jul 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440125; cv=fail; b=o678P4lHIjssdl2GDAGZ77eDKuYTrQWp7Ud0wmEvV65jaJaGsU2aLjBM6/OVJNGOoY0dGeOOAjye6gezTLErFd7920Lc7Vf73mZufvIPOqZ4r/niBsPzqdYPV52qLaIOfwX3Te/sFLnU1HxRlOUfz8bTIctlySJ0/4Vnu+FzCjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440125; c=relaxed/simple;
	bh=zbvR064F158vGkW71AjcuFOO/I2BUq0oz2eUDxbT+08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DJwPMTfAeBscBaQK6cZviNstuKlhCua2cvBuyuVCoY5ocsWCv/xbGymOxqAYxIjEnA6sciPlDR7/QZWIf8rc20Y7p+2qt6J9c3tA37iRkBlcFryAoDUJVCM1aEOo++6g9N+u3y/LQUFSZBsHhbanJzmsS6t24SW3YHMQkVScr98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suGpCmBb; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usw8b+MpzurEVB777+oOmJWI+qZOrEs6/LrSITge46RJBbxpK2PXaQGmrWn1OsX2B++cTn7B+xpBpXhzfk+gHf30Gr6a020aJfAYo0usJ4TBd1ecsXfQkqIqMt1oQE9Osu2WxGf4dgoRDUvME9IdKA3CZ75ILXd25edIZS3YTk4X9IffUAj5szw/Tl89prY+FYTwqURpseQnoyekg/4HnNNzJ8m9P+Nzxn6k+3z9OWjzH4TnIvY/1kYnAT+gzSOtF3eB5ipp4YN84AmJOJECDHQ8j+tYaC7cEQjOY9tBEn4bj9esMcJYNCzXs5HISNWaiyZDgvAGENC/cnqLJhbIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49ogM+1PCvscEbo1kjuXz4sYCHgwi0TBWnBxosHTgS8=;
 b=C98JL7wYfRFsDCU6caVn6zMgJNOjh0xTzNoHrL5MULDOwe1QeTp0tV5br24W4zoflVT2ECLo5JXcw+nXZZJpZXAh8hQfkQ+gJNkPbxmmezFDji8NQnFMaPyEI5a5OFtpDs6jMdudlxlwlTNtCt+rAuTSX0Ve+nJFcAMxcd0JXaQ1uJ3vqi0Z+kX/wnjtUWqhcZktI1B3zvIr8OvG6PT5zPgyx37jg+aE+qlVTJTIht+jOkxJ2loDtJj7nNHfTQ7DIEHCjS1XV7l3hpGnM5d7p3oAVNBHyJjsFO8yvlodnbf7wxy8ZPZCKNJqGFA5IsSwHH4XPifVV/aSCsV8bXUqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49ogM+1PCvscEbo1kjuXz4sYCHgwi0TBWnBxosHTgS8=;
 b=suGpCmBbwjTmnsnNNGxuc5PD4PWV43u+OKIFkZi2Gafz+HNBe5pmJTfRH7IUZx+1cPYqkKqXENmtwRllBz8w/Dr6058U3iIiaYjRzUGyBZJ3KGdhj1HAmo9T4lhX9uZ3uwpXaDwLxjS61Psx8USpk9sIzeVkvPMenK9kSWvjnIRhJD0eykDUNjnWTwmfaq3hD3FsqTydm3atCa9Ubj4F3BE8Ss1vt3qrR7MIlaA1KEVRGJtaRah8XxpQrQ+/cIL+MHt/Zg/DytJ27GN6bLW1q+gLJVGSbGDC9kG/TByvydeHWAsMDigSU/fPi1pf36DiprLCfKzondXVigd4xgOuUw==
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:00 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::27) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:39 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:35 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:34 +0300
Subject: [PATCH vhost v3 10/24] vdpa/mlx5: Add support for modifying the
 virtio_version VQ field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-10-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a759f1-a5f5-4a46-00a7-08dc9f45c5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0o4WWhjZ25lQlZyQVRFYmpyeFQ1azVvZ2lRQXRncEVKQU82NzdRT0dsOGV3?=
 =?utf-8?B?WEk5U3FqaW5wdWRzWkphSzQzY0xKb29TV3FpZHZMOUsyUm13anJJWlpKa3Fz?=
 =?utf-8?B?M2lJaDFiRE5LemVad3dtTWpsdFgvOGNXSHhrTm0wNzIrQzZ0NFVXeDRHWG90?=
 =?utf-8?B?QytRSWZablhOb0VxQ1I3NzcyRWVibGhvS2xCMVF4ZWt6LzhUV1FkbUFYaXVu?=
 =?utf-8?B?eTJFc0F4bEJNNkt0UTh5SWE1ZU0rb1haYlJvWTR0SmZzMTU4dDB5RlM4b1dn?=
 =?utf-8?B?NlRQaHIzSXF1eU4wb3d2YjRIcDh1a2JUUFBBbEZZNm5hR20yemVoeHI1djJS?=
 =?utf-8?B?dUkxK1NHbTVzbVc1TFhRZTl5anJzejRZSzlRSWlvbUc0OG12SmI0UnlPWkti?=
 =?utf-8?B?ZW41cGJUTjdDQnRuT3FFUWx6aitSZWlTeWNFMnBVQ25nZWlnRE9jOEFKcUFk?=
 =?utf-8?B?REtmSE84dFo5RWo3bWx6Tjg4S0xiQU1USkhKZGN1dUV5TjVuS29ZVWNoSmlE?=
 =?utf-8?B?QjgzL0pLM2pSNmFoTjc2cHk2dXA3eGpYWDNtMDJHQTA0TmVJeGxWYk5JVlVh?=
 =?utf-8?B?NlZqOURVZWhaMHBtWGFmWTg3dVpNNmxHaWRJalB3QlFKdDIxNGlReXJDdVhX?=
 =?utf-8?B?OVZvRU9tTkZqY3NjWnVLOEhpcHdkUktWRHFQSlZSNS9kMGZJdmFBVlZWRFdy?=
 =?utf-8?B?Rzl0V3pseFRkVVowcXVEamVDam5tRysvTGY3OWV3SkJBSFdaRHRLRVphSjZQ?=
 =?utf-8?B?aVl2TnY0bWJQNU5waEVQaSsvbXIxM3BGY3hLTU9rUWlhbjBSZzNpMHEwMkZB?=
 =?utf-8?B?K1AwTkJkdXZXM0tTS2IvMHV4Y0JUNDgxdEVoMmMwRFpvQXpxL0toMllwZmNF?=
 =?utf-8?B?KytaWU0rS3o0NG5abG1DemZtcFNCU1pGcURZTHhQTE9lN09kY2FMU3dFdmhV?=
 =?utf-8?B?cmluVFFjV2V6eStNWUZwOHUvTStTdU5BVVg4RG93ZVpuZlM4SGtIQUFFYXk3?=
 =?utf-8?B?Q09RTWk5SjJzZGE4cmwwN3ZVQk9SQ1hHMVBDMm83MDdzeXlvYTBVcFV5Z2hu?=
 =?utf-8?B?ZXRQd2ZrM1FIN09LK2tuZml0bUJlcWY5R0hycHJLT0ZDZThKeEw1NUFtUVRU?=
 =?utf-8?B?SmZZNUw1OU1tK0NSVXpnNzB0bEhpc21Fek92SXVLUGlWTnEwUVhBVHdJZGgx?=
 =?utf-8?B?UG4yZ1ZrQ3JORkRlOU4rWit1NmlKOFA0MU1lVFVKQkR5MHhXaktIZDEybStB?=
 =?utf-8?B?SDFHbWdLN25ROC83UXRhRGc5WHZlMHBGZU1aYUZPUHlTcVBYRVZrQWlOMHJE?=
 =?utf-8?B?TzA2NEdZVnFuRkNkY0I4a2RYSGoxc3BMTDhObUxmWWtHUllXRHdVNENvTFZB?=
 =?utf-8?B?aVo2K0I2aWcvdDlrUlhreEhTVFRGZ2l2SndONmxPV3RVbWRrOGRlNTZaUGhC?=
 =?utf-8?B?bk5acDZrMGdjQUgyczhsbXY5bjhqUVJOZng0L25YNU11b0lkTit3N25Xdzgz?=
 =?utf-8?B?TWJSZXlCRTEwQmpPaFRlc1ZWL2J1YVpYS0xhVmwwVFAralRnR0ppdDNIVUQ4?=
 =?utf-8?B?R1QvbjNoc3VJejdmSE9DUUxMUzh0UEw0aC9xMW1WV3hjZ29pOEQ4R2tJK2NB?=
 =?utf-8?B?aWJtWDBLcXVOK2ZiUEZEQnZJTWJ5TWpZUm95YXNFaWF4TElZQ08vMkdWWkha?=
 =?utf-8?B?UFNZVUhlbnoxMnR0UlhscFM4dUduMHpkUVhlKy96SnpsaUhLSlY5T1dtc284?=
 =?utf-8?B?NGdUbTI2bkZWU3RsNWFPOTc5RHZUeW9VeFg4S29ZNFpySkRhY3hYRElXUmUr?=
 =?utf-8?B?WUhNcEVLcHJEQTRtN1k2K3QxcnRzVEFwMmc1aFlwd3daUUEyRGRZK2dHN1ZF?=
 =?utf-8?B?TEc1WGRoWVlZei9XQmVCOEJIUDM2UVkyQklSVzRzQXFySXc3NE1GWHVUazVT?=
 =?utf-8?Q?XeN/DooR8zzZH/EeyCFCSvXI3n0G01tp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:59.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a759f1-a5f5-4a46-00a7-08dc9f45c5e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

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
2.45.2


