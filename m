Return-Path: <linux-rdma+bounces-3515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733BB917E14
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11F0B23D8E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CE2188CBE;
	Wed, 26 Jun 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLE5oozF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A7187564;
	Wed, 26 Jun 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397698; cv=fail; b=TmUhndl3S6HQAXuosGa1KkWTt8SyGGuiNNBda4kAWH/XbNqybXPYx0vYjzp35wfdH74Oer7NR+ib4EqPcIlr/zkrf90RmaeElhP6v8hRaNrldAgKFHlZjrTYT2jucc1YeDv3CTnhu9byVgZCCHC9+ISkEmJ+Rrq+fXvmEsS7hnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397698; c=relaxed/simple;
	bh=gBLMxEbyo+AjXzJedZb+UeAlN9ZzXN9HJNGJC20iaHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cBAhqKeW9c59LBYU9iIKMLjt++W5qe5QSD9IfSQYrd4Kx4F1q85VPeFhxNfTVyNrzyGot0O4GCrrjrr9oEP6a5ktng8YM3Ncze3G05iRbuhJdfQ/1F8mL3TbqRVFz7BrCOlFX+JW3LWN2uaT3hnFTNRYHS62moL5v80D/iffUaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uLE5oozF; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C208pU2sK+hExO6RYUvFlxFdwE/otWPhOGGkbUnNwntNg8sOD9ci+//CG4iadm0q9mZGfCyNMdrV641bPV/QU790iSzvBLPEujGkkBm0SRDAxSSc3NGmc3sVb3ywGNbaB1Y0imJI8Xvvh0I/Yaa2UfDrKd53BIj5LzIaqWYGMvqGvlGM/ZISIhPJT/dKSCM/4HlB4gFTiac0x3UEZ9axG1USETPVaFdHMnKt9Sd4EVf8/feLBVAdOghpl0cuC8sD4gaiE2jjbH76vl+9LlW8En/0px3u6JLF8JH3uqHdsmaTS7IxQufxYF1YbjH+det2NNLpqFnpkmM6JSHeJY5qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyJ9GytNsv+ncxwwEyPP0fedd6ujHBMzMq3fxV9BgNA=;
 b=MSgz5XFAdBBNW5ucHPgpNEsonBhEdI4CGeJMVzfgRGU1GLjBfnhiDflh003W/DvYToAczm209aIEUtobYj35kVzez8PEbK+TJmOUAAjXrRAy8cgRJx6dTTedIah/A3/XfI7YJMc+OpgIs6cwZDQ0CyX1OCJpA6bNZnuAY1eA2nUYcntbB9VPvOFzzQVASD2zow9RNaZOZzjG0WzoOksn78n0JA83/+BUewuVqaIgQ64YEBdL197q6iJbgxRSGaOAbFVek3I307WRT/y0hyXL8h8DZjRFHbRjLq6IsnteBzte5SnqqKDZKBbNx2S9nCK1LKeNjepxUHZ6GRmK5gYvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyJ9GytNsv+ncxwwEyPP0fedd6ujHBMzMq3fxV9BgNA=;
 b=uLE5oozF8QQAnLtLd/WnfNTvTZ8QrLgb6pAaBo6vLRi0eBTESnNGhEXhygObhfDNPMqOY1juQB4bW8prQyw2ylLFynndWVYSqD8dwhql6jgvytnGZYopAe719rXaFPb5fYXqOzndRV8+8BP/09lpsnDcbgWuc+R+Jpsq3knFudlz/6LOFTq/LAata+SAB7+u2nw6UMfmVQb8dTKHz0/DrSa9jfSqexAiI/fp2GeHoYkKqsmb+5mmmMbqsjdRcxr1kz5BUDziPVD443497TbXtus1LLi5fuRcKMeacdz7J7EYMXRo9A5oSoUC4SSjX4yJ+1Dm89ntNAQNsw0WYB+FkA==
Received: from BLAPR03CA0124.namprd03.prod.outlook.com (2603:10b6:208:32e::9)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:28:12 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::13) by BLAPR03CA0124.outlook.office365.com
 (2603:10b6:208:32e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.39 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:00 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:56 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:54 +0300
Subject: [PATCH vhost v2 18/24] vdpa/mlx5: Consolidate all VQ modify to
 Ready to use resume_vq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-18-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 410338ca-e137-46c1-a3c3-08dc95caaec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmNYSTVRRkJXcko4UlJxdFcwcy9ZbTBHWmRxUTBHRVlwQ1dBajVHRTduNXVN?=
 =?utf-8?B?YytFWVhDTEU3cE90RnZ2c0RuUlB1QkpucUJKNWk5VkRQcWVhUGQ5Nk5pNE5s?=
 =?utf-8?B?LytPcEJnbFpNSzNTUER6YTRuTXRZTTFxYnFrR2FrdFhtQURmV0RBNU9GMFZH?=
 =?utf-8?B?Um5QWlloY3VPRTI5U1dCQmx3TllXVEFKN1FrdmRmeVNabTYvRlVoaDhsLy8w?=
 =?utf-8?B?QjNzSERia1JmU0RWRGpEQ3p3ZFByZ1JhazdwSUFDSXVVSElpSlNhWUZaOTRv?=
 =?utf-8?B?Y0VqK21OODdnV1hsV2dSUW5tZ0VwckxNUTQrWHIwQ0FCa00vVk5TREVYSk9k?=
 =?utf-8?B?Q2N4ZDN3L1RraytZZThLR1JlcTVvS1Y0OG9BMXA2YnJjc1h6bjBYR1hVejMw?=
 =?utf-8?B?Y1g4SFhtQUZwM2lFemRSL3dZb1RTRkRCSWlBeHErNEhXZDdXUkZvN25ja2tI?=
 =?utf-8?B?R25iSWRSdUF4TWVqVlhkeUU5V1RBZWIrbjQvczNxWEhTVUNrNDFWNEM3b0RS?=
 =?utf-8?B?SnE0c2NoT1hqYU9Da3g1U1dBSjQ3ZWVEY3lNT2V4MGViZFNNVWVySGRiQ3FQ?=
 =?utf-8?B?cllnV0tKaUYyOXlVZmZ3bG1kRUJwZ0N6cFNxYitRNGhxOUNPVGNpMEMxTHkw?=
 =?utf-8?B?SitFVDVxc2ZkUktMSWZzZVUzUnlVTDFQdUhKVXJ1SkxONHFIOE81SGM1RFF2?=
 =?utf-8?B?YTJPazRINDFGY3l3T0o1YVN6em14MjZJQTg3T3VXOUcxeEkzUE0zZjAvTzYz?=
 =?utf-8?B?bU1wUVNFbnQ5RWxlekQ1aHlnc3NIWFpWZUNYT0l3eThmVHZaL2RaN3lTbm4y?=
 =?utf-8?B?SDIvdTNoRWNiWmVhdk05ZkUzSzQ1Mkt0RVhsK1dZLzFWOGtsK1NET0V3L25T?=
 =?utf-8?B?dG44R1FNZmxTOVF1aXpwSzJDMkpnK3BmY2xyTC9kRlhOUngzTkRoYjhkd2RZ?=
 =?utf-8?B?SnFwbkpGTEtLZmI4c25tMkRpem5WdXVweUVJSFkzVEJWUVJTRW1vcnJQWUNU?=
 =?utf-8?B?UzdBNzlrVUZxcG5hZFdBMVZXcE1sRjdsa3RKNEdRaldhUEJsMW9pSWVPdFlu?=
 =?utf-8?B?Yk03TGRwc0RkNHZQenl0am9mNmF6eWNUbkZSRDBmay9Fd1V0Q0ZzemdYdXkr?=
 =?utf-8?B?NER4TzQzd0V6SG5seGhDb0lYODhNRXRkUUxkZGk2S28vSzJMcm5jYlJZQ01q?=
 =?utf-8?B?VUVlYW9IZ3hUN1VSMEc2WDR5M0dyZk9mQ09maERjVEVjeHNZOHdmV2ZKSzFQ?=
 =?utf-8?B?cTdpR1dPWGp1QTdJdnF2RDlSYlZXM2tkK1hoNFRqdUZlMFoxdW1GRkFXanB5?=
 =?utf-8?B?QnhXSVVzOXdyVDJtcXA3NkRJRllNTVo1MmZ5QnQ5UlFvTFgxSWZhM0kxc3Jm?=
 =?utf-8?B?ZHFnc2pGVUZPaUl3d2NLdExzSmcxOWt0MmIyVWFmUEJPMkZhdFV0MW0zWFlx?=
 =?utf-8?B?LzZSNUc3WHRBbSszTzE0NjlMT1I3NWMzOWtaTDIyNVZpemE0cGFob1lFYlVs?=
 =?utf-8?B?elR3SFE1RUIrZmtBaHEyUUpDVmlzNUF4ZWVKVXBDdDdud3hPTnZaWTZucDJ6?=
 =?utf-8?B?cVQ2Q3BiVnlTTWNxU1RDOU0xcGFBZUVwZUNGQjdYZXg0VVN2RkoxNWVaRnNC?=
 =?utf-8?B?alpuQlJjaXIvZW92Q1ROd3RiZlJzL1ZkUFBUNTJNTG0vOGlrRmpnck9iMldu?=
 =?utf-8?B?NWg1aTFKcmFVTUV2MEUvWVU0bDd6NXpFanJKN3ZRRUdZNjVTcFZiMlV2R09D?=
 =?utf-8?B?ZjZwMDJDUUw5TUJUbXNsS1NuYmVPd2ROeForM09DSE9NWmhZR1NPVlBSWXhX?=
 =?utf-8?B?K3dzZjBjeGNJQkFjNDdYbStBRFZUL3BhWmlzc0tPalEzcHpXWExvS1ZWZXVW?=
 =?utf-8?B?UGp0SUR3R1pXb2swa1VwYzVLTlRMRDFvYVdsT0U2V0RPM2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:12.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410338ca-e137-46c1-a3c3-08dc95caaec6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

There are a few more places modifying the VQ to Ready directly. Let's
consolidate them into resume_vq().

The redundant warnings for resume_vq() errors can also be dropped.

There is one special case that needs to be handled for virtio-vdpa:
the initialized flag must be set to true earlier in setup_vq() so that
resume_vq() doesn't return early.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 8ab5cf1bbc43..e65d488f7a08 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -160,6 +160,7 @@ static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
 static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
+static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq);
 
 static bool mlx5_vdpa_debug;
 
@@ -1500,16 +1501,14 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
 	if (err)
 		goto err_vq;
 
+	mvq->initialized = true;
+
 	if (mvq->ready) {
-		err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
-		if (err) {
-			mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to ready vq idx %d(%d)\n",
-				       idx, err);
+		err = resume_vq(ndev, mvq);
+		if (err)
 			goto err_modify;
-		}
 	}
 
-	mvq->initialized = true;
 	return 0;
 
 err_modify:
@@ -2422,7 +2421,6 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
-	int err;
 
 	if (!mvdev->actual_features)
 		return;
@@ -2439,14 +2437,10 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	if (!ready) {
 		suspend_vq(ndev, mvq);
 	} else {
-		err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
-		if (err) {
-			mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
+		if (resume_vq(ndev, mvq))
 			ready = false;
-		}
 	}
 
-
 	mvq->ready = ready;
 }
 

-- 
2.45.1


