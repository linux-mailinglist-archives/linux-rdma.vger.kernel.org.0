Return-Path: <linux-rdma+bounces-3513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90A917E0B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5977289BBE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09FF187544;
	Wed, 26 Jun 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYNVCgNv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B418413E;
	Wed, 26 Jun 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397693; cv=fail; b=Hsl99xfhVXhztKcrNWL85VG1a7DSmf07QJ1XHMMP95Rg8OA0ENKIgmyvtEm6D9I6DjGE6pC8UHUlQeSUko/v19rvjJaI7mLS7ncOSuX7CbEnpsrmcBzPV0TSP4BKjZ2/lH+kGEkHw6jh40wn/JqEHfAD2zMOx8avyMrZUwHTVBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397693; c=relaxed/simple;
	bh=OnhbBUM4j8aDXBgzuoLBxz26jcHMrodiq/7VI9qswgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aZFNLs+fDDm/bP0I60OaJjNWxT4yOF4R3kuOgL77Z3eeIjPSJwLwjVPFDdPK2/HeHq6bTthDOD3VFKXI5qDuq2vcmV47IWUdF2aQOaGmnCtBJZJtRsdxJGylGbzs4hWeCEC9tOUbzbbYI5+zyqu2oVPxa3cuMW30sUkOFtTUF0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kYNVCgNv; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcUhJg22Uqh2orm0dBzIvrBCTlZ60w1DBmwLmidNJrzrA4rzzgWP8aeZYtZCw2KIKUHUfzTcs8xxjTokzlVvoVYdOFw89BLUpvhkDIK/+iqW6KdOKVMy1aytHrAiS3RYT0uVgW/ilxeirvEBWF3TOUUD6nitFDnx6HU84wJLzjC53Xbh8zF2sCJKbn1sLlg9txSlVFfufSO9eZ3M7ij9ocF80Mwc9968pLbryFJ5fJgc7ZxhihPlQ3t6Yv/EBtN9WTK1YchPVVrePfAy7h2s7Vj4ogZEJfeFHJpVPTFwiT3es5CSsXpN2uJq/g0fnNiFhYZRrd17lHJbhjS+59xn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSU3olGtsSo9C3vI/96ytT5T5158dS5zwlVHlCsmjPc=;
 b=Vi+QvXLXspy1YYXda5JN+QeKMY/699vfh0T/UaHhQW+qCWQozC/BFBuwivzipNCxbT9h62VRSYiyhVLp2KNIMnkXjOe8pLEuDUajOvedJ/Bb4e2HzDG9CuRSLeayakWsriy7qAaAMNtfFuEIAe+30+CxbUBxQxlZ2SuKsIcTIT5pCI4oIQdqu8UjCKvZl7l23hyXGp/tbq6jZIcgup4qV6TUi75Gd3p2AhJZFuVNN5OQg4/rcWn73O/NSU7zpkDDT/JDPJgc4RHEyvrwZA95vFEEezThInrVJ270REPMY6H298lBpBzGX8fXS1P66u8kvajIsUu2wSvwyWqzXW96qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSU3olGtsSo9C3vI/96ytT5T5158dS5zwlVHlCsmjPc=;
 b=kYNVCgNvgZ58g3fMaq1DVckLAIbEKKFw+GrQq7NA8LFjCMfYImjG163ATAVlVEMOpzPUN1QwxPnXjmZCq4ld0wP14kFCzWMMiBwmQdz+NICf0HZDveWRP+i0t7lLwpB75VXXZ8XOXpqy6cU1U/Bz/FW6Uo5NVIZM8P8ujuxUsL99N4kaES02KnI0xovimLbI91kC9NNOMMegfW8Pr8V0vQes8f+U7lkh/UUyi4pI9CWB86pzibm3GCYfZLndkFxu+NzjKJ8je5QPq7YJysbSmu+Dfze7CJQYcFgG8q5Z/D4xmYtYdF4QSUkL2N/JQX611IbfE0NjSkAe+RPAmqOtzg==
Received: from MN2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:d4::39)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:28:09 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::5b) by MN2PR04CA0026.outlook.office365.com
 (2603:10b6:208:d4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:52 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:48 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:52 +0300
Subject: [PATCH vhost v2 16/24] vdpa/mlx5: Accept Init -> Ready VQ
 transition in resume_vq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc9a433-582d-448c-e172-08dc95caac56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|82310400024|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVV0QngzSS9TY2xRN2w4V2NEd0k5b3hFdnFXZFNFV3gyVlBHMGNRYUVtM25J?=
 =?utf-8?B?WmRFc25jS3UrejJpcldSM2pzYy9VeDluWm52V3Rscmpab0pDRll6aGRma21V?=
 =?utf-8?B?ZXlJY2Z0a1ZsNlhkZjhpSDF6RklsZU9US2J3M2FWcFAzT242ekI3OEgwaFUz?=
 =?utf-8?B?TDJSckcxckRsUkY0TysxK1R5NVQzRVRnbENvNEo1WTVNK0NJU1pvelRoUGRz?=
 =?utf-8?B?RGMxQ3NzRkViK2dseUZVVWFHemNtanR2SS9xM1l0eDYwdzhGTTA0M1VjTjBm?=
 =?utf-8?B?Rm9oRFI5T0VmbjJjTXpBc09tRG1RSlpQL3pva1NMak1pZEtpSFREa2Zpbnky?=
 =?utf-8?B?U0RkVkc2L3NXRGF0cGNXR2F6R3JiS1hVTkY1aFJOeFo4SnJZMnYyR3JuaUlu?=
 =?utf-8?B?ZTh1Ri9SYjB3dk1WOFVTZVZodUV6bWFMUTN0NCt0RFVraXZMcWF1TmRITElv?=
 =?utf-8?B?ZGxKMnZBdFF5cVhMV2poM3QzVi8wR1MzVU9NQ3dJOG9CN1M1QStjREJpTmRh?=
 =?utf-8?B?OWtMRHpQMFFxS3pPOHZGdkV1NGxiTS9COE1TNWlCeVgrK2dHOXFPWlFaVzBz?=
 =?utf-8?B?L0greVd3TFpRNHQ3YUhSK1VaRHZrQzlLRXJWUjVMUnF5WUMrL0hyOWtnWHNt?=
 =?utf-8?B?MlhUVW9sUzFKQWZpZDM1ZUl6c0JzNWdvdWpoQ2VGV1JEWjZUenZXaWxaWE1i?=
 =?utf-8?B?WENvdlNQV3ppSzFFRTJjMTQ5QnhKKzNCbVRraElTT3o4ejlNZkpZcmpjMjgx?=
 =?utf-8?B?ZW5kQkNrdjZIY3g1NzFoTVBqL3ZaTEl2bFBXTWUwcHhyNThzZzVybnowRWNl?=
 =?utf-8?B?OUoxbFdOSU9BSG1JY0VUNWhEZE9CM1JrdEVSN1A2NUpjUHJDV0lNTktQK2ZN?=
 =?utf-8?B?NUNMM3pJNVVVRlRaaGRSQmw2UUs4MEx4S1dQWi8zY0Vvc0hQNlplVUdJaC9N?=
 =?utf-8?B?SlRObkNBejJ4WlBjdGVqNENudTBFV0RXYXdUL0VtdThoTVRoYlBRSzVobTk3?=
 =?utf-8?B?UXdSZXN4alZyb0xJVzVxakdYZXBCRWU3UGV3bkdkeWVBTU44ZStLUWI3VWJ2?=
 =?utf-8?B?MTJQeWk0KzNWSWhxK1dkRFNYZ0dOR2tYejhZOVZFM0dselFRVlpMVDk1QndG?=
 =?utf-8?B?OHRBZkVpTUYvR0tFcU91c0JMZjlMMmVZbXZJeFRKY255L1RHL3NXQkhiemxR?=
 =?utf-8?B?aWVIUmI1SUVNQzlrSENmNlFPVHZ6Qk15QmkwL3JJUVBrUFExeDQ5NXZWTm1p?=
 =?utf-8?B?bC80TFJpRHE3ME5aV0ZsZXFSdHNoMzFNVHZMejgyUWkxTlFxUENETHR1VnlT?=
 =?utf-8?B?clJwM3NrajMyVFhmL2J3Y29ZUkFwNFlNalNMU2VRV0FSTlBFRmE4K3diSjJi?=
 =?utf-8?B?dUZZWFZXTWFweGhSOU1EVzRodytQdHliMDFLWDJ1Vm12eVR2REhRZjBkdWM2?=
 =?utf-8?B?cHVPdlB3UzQxRDZRUG1uMXF5RHFucVJqM1krZFUxSnB1WTh6c1ZKZEtPdnFQ?=
 =?utf-8?B?NUpDVXlyWWVWUy9YT05ScURCcmQyUmFiUDlkeXNqeSt6M2hsV2gyUkxobHE0?=
 =?utf-8?B?YUZwVXlXRkFVdDNyZDRkVjhKMnMrd2FnaVBPTVhSUFhrMVNxdDA1SUVReDFm?=
 =?utf-8?B?SER3dEVKL2s4MFZTK0Fzd01kL0FsK3FEbmN5Y1JVQ2FYREhxL1FvbVhleVNX?=
 =?utf-8?B?bitFRTVWRjM4Q0cyU0pYdHZXZUJjT1B2MWZ4YW12TXFjM1p5cjQ3MURGak1n?=
 =?utf-8?B?azlkdGFFeEc2dVgxMFp3SW9TZWV6L0FEUzVGTkltSGpYT1ZrTTk0OS93Q0t2?=
 =?utf-8?B?amFjdko3YzBOUU1uWGNlOHBsYjlPTi9wSmdnbVFESU52a2JDL1Y1MElHNC9O?=
 =?utf-8?B?VCtZbktUWkFndlBhZUF2dTV4S2FZdVBvWW9vL3djWGFZNHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(82310400024)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:08.5512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc9a433-582d-448c-e172-08dc95caac56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

Until now resume_vq() was used only for the suspend/resume scenario.
This change also allows calling resume_vq() to bring it from Init to
Ready state (VQ initialization).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0a62ce0b4af8..adcc4d63cf83 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
 
 static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
-	if (!mvq->initialized || !is_resumable(ndev))
+	if (!mvq->initialized)
 		return;
 
-	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
+	switch (mvq->fw_state) {
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
+		/* Due to a FW quirk we need to modify the VQ fields first then change state.
+		 * This should be fixed soon. After that, a single command can be used.
+		 */
+		if (modify_virtqueue(ndev, mvq, 0))
+			mlx5_vdpa_warn(&ndev->mvdev,
+				"modify vq properties failed for vq %u\n", mvq->index);
+		break;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
+		if (!is_resumable(ndev)) {
+			mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resumable\n", mvq->index);
+			return;
+		}
+		break;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
 		return;
+	default:
+		mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from bad state %d\n",
+			       mvq->index, mvq->fw_state);
+		return;
+	}
 
 	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY))
 		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u\n", mvq->index);

-- 
2.45.1


