Return-Path: <linux-rdma+bounces-3236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A590B4C2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B231C21369
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C781741E6;
	Mon, 17 Jun 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2O88Rms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645671741D2;
	Mon, 17 Jun 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636975; cv=fail; b=FkyGP9GlcYLLLVc5yjR7WJKglvEG5ZafgXCPHHRwWFqBVYd9702bJFsrB5LIx+CmzwABGpnhpadvWUPVucRcA5PT1OUnQCC8NMmDvdWN+kaqYyZOamTrHYD/eRnAtvrFhdHj9HAe0U8MhrGftijqU1uV2JteRa7R9zWgN8sAE7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636975; c=relaxed/simple;
	bh=+VBdGMxn/rBdO2GAbI92QfqGAXTZEbLJD3LmtxOBV04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=puUjoCel63BUlCsdedObajZsxZeH42k9v2KNZZj244CzPRrJRndfOo/DX00szDc2uZ7n9v8PJCbuZxAYI662pFlhzWeyN0/JL+sqT6Xm+lAieWrUURi73MFGXwucsWuRwogmn1Rf7iz62Gjjx1Cgz241uJkXxxrY+mQzgZp3mzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2O88Rms; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs+0iCsaArkZSPQiPcLCF6bagQU/mn0yzbdQcekHjS2jArtm5pH0uOD5sYW2P78Z+mg7/laQ8pktfkc4h7962nPufI0MlZDnId74qfpknidsGT2f2KlUBOn+crUHdR/YjMz5J00io4ByalPVFVfRlKI2dtfpiZCsd3Jw2Tdvrsoq4xLDvjRqGWZD4eOhjtTVoEExIbYbhx+LMnqim1XnR8OjryG2Ou7Q6YvHLmnOFKXWlFKg/3aW3WctHDto2b9mZI7/eZHPerbfFOET1BMtsot9xflOXrxz9Mw4onGvW0MdvCEPfc7oXfxZXwYhcMKmIQLJCpEb0It9VZzk7uShfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARe1GYtbXbk/p6QVycKLEeBPZAEGn+VV6msIbmlUYAo=;
 b=O9gxYzlXwBni/CrDFGwnoeczUyvdcA/lXUf9/F2iRvgLny9j1whRH8rnBtoPgKekf7Un5jkKwiIVVvuEVr6A3Fbdqz0Ws8vYOO5psjMPby0HTpiXsC2Uua6YT7e7BnOoP7N9xBvj7XZNZ1wN3enZ5QlAFjwkCfM7iKp7VX68UQsgTLzO1GispoP36Ill+HDSR7n3LFGeHIh7cKTB1/Nii3n3MSb2aJ9k5xl4Ods0DmGI7yy985inJs1TPlnU5nFPc3sXYo+wwQMvjWw6cLslXdzjTmztX1CuqccuH8rF/GTJ3npQL1PxOzkKTY3RAp3lV4bc+4IZZDNWy6sgRwvL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARe1GYtbXbk/p6QVycKLEeBPZAEGn+VV6msIbmlUYAo=;
 b=s2O88Rmsctj1iqLweTye7XvYbXjKKM1eC/Dnd2b1JQ6A4BTh5Hn6L+Qos6POXY5ZH5DYx3l7PqN40HtThOOOebN7Tni37SY2CyE7ZFTBdJesXnyMImBGXUHwVOYxIjXzd2mW5x0GGzaLCpYjuOnm7KS0PmU2L4cnzG5+Hg9tv4R7ed9AcDieG7GrESq8q5DrM5KZqD/M7il3j3vSG41INUVUoFvR70x5YGbUxw2uvmJ6+42LC58Fu0Nn121DsOgseMMwmU17VNH6Fkc2KH/zGRULLdReF+PJaDqdSoYZ0JJhPSYPwncV6KOkkHJYQjY41IhwkMWkNk4GFY67AqTSMg==
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:30 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::f3) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:09:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:09:14 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:09:10 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:56 +0300
Subject: [PATCH vhost 22/23] vdpa/mlx5: Don't reset VQs more than necessary
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-22-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: bbeef19e-ced2-490c-0601-08dc8edf7c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|7416011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUNWNkl0bDdvQ3V2RWpBWEdoUkw1ajZqc3BDSmJPT1ZpejVpYUR4ZUdqNTQr?=
 =?utf-8?B?Q1orWnFPYS9JYWdRZThJNDVQb0VpQTJLd21nbTFXbGQ1MkI4NTF5VFYrRnV1?=
 =?utf-8?B?dlE1bEVrNHNMeUVFcFZ3V1c5Ull3MkRIbUQrZ1Z2QWprVklUaGdMNUU3di82?=
 =?utf-8?B?WWtkZlhaV0xnTGJKWVN0Q1AzSmZHSVprNDVjVHh2OURseTNVU2piQzh4dldv?=
 =?utf-8?B?cktUdUxPcEdIOU9YaGxOM3l3TWFWbWVRNWtTZkxxbUN4VTN6Z0IxTS8rNHc4?=
 =?utf-8?B?a3pVKzFGa0RiZ3U0TU52U0VWRzViV0QyQTVSV1ZoYkswa3pPOWk5STlSVjB1?=
 =?utf-8?B?UHZzMUJEME1nTmRkSFlITDZIeHdVMlBQak1wUHhUVWQ0eGN0MlRHZG9Ud09r?=
 =?utf-8?B?eFJ4UEJzaVFidmJTMThlU3YvRkh4UnRDZFczWFZqWHJ2ZlRaTHRmZTYzSnBN?=
 =?utf-8?B?V1Q0c05velRTbmhtdWVBSjN2YlkremppRklvaGNhZmJQVUdma1BFZVdCRCt3?=
 =?utf-8?B?NzJNUnZVZm5NTzBMN2x0TUlTMHlPZGdkY3IyOVpGQTdCRlcrSjM0dlIvaVhi?=
 =?utf-8?B?akdCa3YyMERzakZSeHBHZUthajlKbDJXMDgwUjFBaDZRaFU4V01BSnBPY0ZK?=
 =?utf-8?B?RjFQYlJwWW52M0ZTZzQ2TVBSOGw0akJCS3Nzd2tPZ2ErV2kyYi84Q09ka2N1?=
 =?utf-8?B?VFMxY1paNFZOTGRGZHFOQTlKNHdzdEI2K1NvNUxXM3JoWTVrbndlME9vUWZn?=
 =?utf-8?B?TGpPZVplN0hwVDFHY0YvcTlYVUp4WkpQNjlWcXdWNFJHUUVWRlFTcDdvODc2?=
 =?utf-8?B?RGEzbWRvRURFd1BLUnlLT1BYams2UzY5SEpwaGlsWGczWWlHWEdGM2NaZVZH?=
 =?utf-8?B?REFhNEE0N3hYTmUyUjgwU0lQQk9JMkNoc3h4U3VQTVdyZlg0bDArM0J0OUJH?=
 =?utf-8?B?MVh1WllFU3V1aTFsUXhTREtjRWVyNWFoRHpDd0RLVXZ1WTFGS1JZaEtjY29k?=
 =?utf-8?B?MnFvTkh4Q2ZOOUdNK25xQ3Ftc2UvbmdpSEtzckg2NGI2eEoxS1haZ0JBVGo4?=
 =?utf-8?B?S2Y0MGJpdzVKZkRLWWlMQU5CV21OaTZpMnRGSlVZK0t4ZEFjRXNKRFJYekl5?=
 =?utf-8?B?YTZlL2Fub011SEh2M2p5NWJpYWtiZXdKOE1IWWYydE95WmRuQTBzSEdkYlRH?=
 =?utf-8?B?VU1YNWpEaVpSZ1AxRmJnZVpMMXdkSW1WOHFPanVjKzAyK1NsRFdrdVNQZUZP?=
 =?utf-8?B?VDdxZWd5T2Znc0oyeGpEQmtDdU83OVdkL0Z5eXo0NGZsaUhTUFh4RkNvV29p?=
 =?utf-8?B?aXFjT09qanA1WURxRTg0a3daSHV3S2dRQ2pTUUIvUFRaOENDeElMZ3p3cmp0?=
 =?utf-8?B?NzBrS053Q1V3cWdPRnlSTVY2aGY5NnFkeVZseFRMcm8wSzJYYm9oZTNqWWZW?=
 =?utf-8?B?bjZuYUhieS9nc3U0dDZYNUZsTkoyYWpMbW5yeVhYUUtZZzd0ZnNCbDkyR2ZN?=
 =?utf-8?B?QlRRblVjcExnWUtuVUxLSGJmTmJVSUYralRVWkVIL0xYZ2VBd2ViZmZLVGdF?=
 =?utf-8?B?NzRKTEZCdFpuUFhUQjNOaEF5K2dSUGtWQllabng4eE5NcmJ0MmJQNjZJM0R1?=
 =?utf-8?B?WUozcU9TQVpwM29kdkRsaGVKSjd4a1pLU3M5dkxqaTFHZXZEaUtvcXQ0Smtj?=
 =?utf-8?B?MG1uWDBRWTB2TnNCcThWWXhocjIzVmRxQUJZaWNSUlBPS3NwRitOdnpidlhz?=
 =?utf-8?B?RE9oVDZsTnZFZWdvdFBubU5ZRm54WnVmaGJyd0NiNE1iR1F5MmQyM2FkalU2?=
 =?utf-8?B?TVlqUUdVSWFhRVE1emJ0MEhCbVh0czh3QXozcG5SNGswNkhFZnBuSFRUWVhm?=
 =?utf-8?B?bkU3YlNidEpxdUh0ZEdsVTEyL2hJcFgzQW9EZUtVTG12QWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:29.7489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeef19e-ced2-490c-0601-08dc8edf7c84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

The vdpa device can be reset many times in sequence without any
significant state changes in between. Previously this was not a problem:
VQs were torn down only on first reset. But after VQ pre-creation was
introduced, each reset will delete and re-create the hardware VQs and
their associated resources.

To solve this problem, avoid resetting hardware VQs if the VQs are still
in a blank state.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index d80d6b47da61..1a5ee0d2b47f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3134,18 +3134,41 @@ static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
 		mvdev->group2asid[i] = 0;
 }
 
+static bool needs_vqs_reset(const struct mlx5_vdpa_dev *mvdev)
+{
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[0];
+
+	if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK)
+		return true;
+
+	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT)
+		return true;
+
+	return mvq->modified_fields & (
+		MLX5_VIRTQ_MODIFY_MASK_STATE |
+		MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS |
+		MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX |
+		MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX
+	);
+}
+
 static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	bool vq_reset;
 
 	print_status(mvdev, 0, true);
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	teardown_vq_resources(ndev);
-	init_mvqs(ndev);
+	vq_reset = needs_vqs_reset(mvdev);
+	if (vq_reset) {
+		teardown_vq_resources(ndev);
+		init_mvqs(ndev);
+	}
 
 	if (flags & VDPA_RESET_F_CLEAN_MAP)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
@@ -3165,7 +3188,8 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 		if (mlx5_vdpa_create_dma_mr(mvdev))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
-	setup_vq_resources(ndev, false);
+	if (vq_reset)
+		setup_vq_resources(ndev, false);
 	up_write(&ndev->reslock);
 
 	return 0;

-- 
2.45.1


