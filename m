Return-Path: <linux-rdma+bounces-3231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418090B608
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 18:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5EEB385EF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691CA152524;
	Mon, 17 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfXWKI6N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2711514D9;
	Mon, 17 Jun 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636954; cv=fail; b=jTcY3Q7sn4jVrapvJmcmxh5/wpts97uVnHUzfAWh/8ePlOuVfQwjrcT7YkoiTcvJyCtNcolRG1E21uu9COp3A+08EWzTXYZ2sedKwogkwqk9h+JoyyQzeAiD3OHDQ6YFyj5Ge5DV0zHOrwZQOEuimS39QRxPVuFtWjG015iBoKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636954; c=relaxed/simple;
	bh=z9TCsTdrf2VFvSxFHjghukPWXU3S1DWzNpUAVVqiwzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TPpQfYtHHGRYT6VOPvmqClEovIUcucjq6NN5zrNwAw272Z31drYlIStqg1A/iK8MMhpWtYivtow6ufTjvetF2yf19eQo8MWZwA/78tqYTEg3MmfYTgP13t3PiJHwdpBmts2gtrRpmBmDuJA4fay947iWy8bIJSZfhvQRqdsvwMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfXWKI6N; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLq6Z+0C8XrREXVJ3SeW80oe+GXC8C5sUgq2ZIdgxWgyzS8UYNBrjALfJzGJJAaIvZVLxhO9ZO2phzdQcwWIYzAVUyz1j9vUW3Wv/LTGYCj/u5i8MbGw7K3qp1f8E8IEkKsDZnhewbmAbTEthChXV+8Evsn6el7KXg0XwyksnLEuyxQsmwwYcpRPhBqF4nkH+Jo5J8McFIepxEPDpjZ0LyIgp5SJagMleoOMp7G2qvUo4UOT1owiRNPSxl0xXvehfR4dqvc9RFD0QD6vXkvXnLJ7hqkTHphQfHxNJ5yaj3Vgtnk1tQfF+yEImx9By50aweJwgprDUm3Si5njMfulvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFIk8nZcVeK5tEVFyzj174gG68kaG0VSXmODuw3FFWM=;
 b=giP4+EtMgYwK9vBNwhcD+C8w92Dgm3G0vy11Hm9LbALIlUmk/uG/GFHXPqBxOQ/itFNfvXhc+DQzvxDPSBtQ+G+dzWkVyVNMYfGEhjdadRczDUILmy5rsp7OZiS1Sv657JR8hVkfbjdM5f3f8N13abED+c6xWMBMZZZvdBhgM8ZZu/NuFfjML+To4ifhzsINdpwp44fR/G1ayX2xkfhinofHn2k8eo+Q0XAlaoXSNrPEoN5aFG6GY4+t0wfIYA18EbRDPMpWQrQ6GzyJCoikTW2idL0c5CRPv/cPWC5cPzRYNAcx2lnj3jtIzYj8SRKaqnC5Bm29tvTiqJwc2VDhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFIk8nZcVeK5tEVFyzj174gG68kaG0VSXmODuw3FFWM=;
 b=lfXWKI6N02kYun7GQbHCtgYjz2mfHKQ8/9efTOCk4rjnZuyUUmnUk8KuAUCFYC5cMSfBolEVfGIYp+cF1aSf/hr12L2RWXnZDrFhH3YZ4GB02aoffLOoxqaihGG5X9fqHYHU3TLndKnEpsq+khqX4d7BMOUF5kHTWtcZbYCBcRTPtHwzp7RMZ4uw7NHO/RVcE6+iVfAtQXEkJ0ubQ9VYDJd8DptY+OxznxqrFcBlL9S6lxld0YgWlq01rC/ak8ZqdTYlXg/mG0fYB6yFMFyFQz4kXc4c8fAGulL88vyNcYrVyGfY6+/8+E4Z7xqYk/ALh8HIduBuUiYYGwB+QAvnvg==
Received: from SA9PR10CA0014.namprd10.prod.outlook.com (2603:10b6:806:a7::19)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:09 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::c2) by SA9PR10CA0014.outlook.office365.com
 (2603:10b6:806:a7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:54 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:51 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:51 +0300
Subject: [PATCH vhost 17/23] vdpa/mlx5: Consolidate all VQ modify to Ready
 to use resume_vq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-17-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 625df858-0de4-4796-d7ad-08dc8edf7039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2tYay9hcjF1S0dVbThBREJLMzFZL3dSbUh3TEFBSHhiaUVmMzRxS01xNUJG?=
 =?utf-8?B?ZDRJZm5aRSs0Y2ZSdVFkM2plWXhYYmRnVEozMXIyZlFxcUlDbkdIVnRidmxh?=
 =?utf-8?B?SmpxaXhXcVlhVm45RTlPbSt0NDUyNkZsYWN6Mi9xQVF4aDllL2lzdU5MY2xY?=
 =?utf-8?B?S1VmVkhGaHpZU1M1cUxScUVHWGVnN1VYREFQRU1iK0NRVlp2Y3FBS0FacEdW?=
 =?utf-8?B?Y2tIWWxsUCtsajF4Z0VZNE1wZ1RZSkRxaHI3SUFadnIzWjYwVGdZUjBvNDNw?=
 =?utf-8?B?M1JiTGtTalhQYU5wRzJMSXd3OWluTnlhV2JtK1JHUW9CR0hWNmFxdUxTZ3p1?=
 =?utf-8?B?cVVSaVBFdG9MSitsVzZVOHgxY2JLOWplcTl4aTVFMWtobDNoUm1NQWdLR1JI?=
 =?utf-8?B?bzlzSVg4cjRqdW1aWWw3RjdjYXpVQ2FkYUtHeEdFaThnMVMybWVsdVIxREcw?=
 =?utf-8?B?TlZHWEU5N3lXYytjNDVTWTFHSCtoY1o4RXF2aHBrb2xxSEpGbkNlM2l0NXNt?=
 =?utf-8?B?QVhkajhtMnl2SFhFaDU4cjhnbFFYZ1hiZ1RlYzRpeWZwNjlESDVDRDdrSlRz?=
 =?utf-8?B?ZFdWQ3FkR20xQTY1L21PekNJa1g3WEhGTmF2ODB6SU9DeUU4RndUc0RKZDVm?=
 =?utf-8?B?NThnditvSVZZZFFQUm1SWlM1OE1nRUZKNnV0b0N6QUZ4WHV3NGNlbTBkendX?=
 =?utf-8?B?VVVHcHZ3Z2pUYjdWTjAvZ2lsd2JjZ0hUcjEzaTZ2Y0t4NXZoZHdWM3oxNWRq?=
 =?utf-8?B?UUQrdm4xUzFsbGdKUTBGSFk4RnFDRGgreU9oQloyeXUwanR1bWc2bzQxK0xQ?=
 =?utf-8?B?ZmJYYURlVzFxanlmYUtCMlUxaDV1bE9KdWRsbGkzRHpYeVNncUYzakZFcXRp?=
 =?utf-8?B?ck1lV2c5ZG1LSWozMi95QjByTWZzYnU4L3VUT29TSGFHMHV6UUVSbU9XSFVj?=
 =?utf-8?B?TUF6WTk5R2t1TzVPVStKQlJOWklsL051emFheWlzblJWQ1BlRGZPYlNLSjQw?=
 =?utf-8?B?NnZQUU1Dd2xPOGRxRVQzUktJcXI1M25KZzFKQ0hxTm1QT1JxMmc1VzFWd2h3?=
 =?utf-8?B?c2NQbittWnloQWl5SjVWQXJ4UjNDanFpd1ZTYmVkRmIzUzR5VkZMZW5pZlFN?=
 =?utf-8?B?ZFNvOTI4NkovK1V4OVcwamNPTU1HaTJKdytnMWFtNmJmODdHNGg5SWhyZGRE?=
 =?utf-8?B?NE5JeVczUFNJbVJYMGl6NWVDd1d0d0pMajhPSDdjZXpaNlI0QUt5QUNJMXkv?=
 =?utf-8?B?bjVSdDBTamo4N2RweW5pK0J6dkoxTDBQSUlrZmlDZEhPM2g1MHl5S0J0UVRv?=
 =?utf-8?B?WG5jeXVCOWxmY1JFYnNpbWJuUnplbzZaeEgzKzBjWVBieXBqQUxEM0l4dllh?=
 =?utf-8?B?YlZabldUK2N1UzI4blNacmJ4ejEzbDRaM2lweWdYakNVK1dEdmNRcSsrVGJj?=
 =?utf-8?B?ek9XZVE3TEJLQmd6Q2o0OHlHbXdTSlhQdFdOOStrMEJQMlNmTVZYMDZ4cEsx?=
 =?utf-8?B?UE9PNTNGTTlWNGJycVp6dW9EcS9oUmJiVHR6Y0lQdmZaR3NWY0c3NU1EbGxy?=
 =?utf-8?B?STRWWjFDVEdHUkU1N0tMWDVWVEhsNVhGb3IxMkx5ZkFpY2xldjQvU0x3UC8z?=
 =?utf-8?B?anZSYUFDeTI0Qlh3VGNkYk5sQ0YrUktvMVVRYXJkTUhFSUlVdzRkM2FCUmxR?=
 =?utf-8?B?SmJXdGJOZ2lEZ1E4Vjc1L1NyQVEvR3Q1WWdZMmFlYndtbVFyMmhaYSsxdE1G?=
 =?utf-8?B?dmJFdGRaaGF4aEsyMkM3RnBXUVk3eHE4NU0zTjVvWVZzb0pReFRHRHUzdmFP?=
 =?utf-8?B?dzE3bWdmc1ZGcTkwbFp4NkhBVVdzanBlMDdIMzBKazZNU1dtOTJUUk5uMjJJ?=
 =?utf-8?B?dTkrL0hacGtpZ1haSEdBUnJFMU1wSTdJcG9RUWQ4NnVuNFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:09.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625df858-0de4-4796-d7ad-08dc8edf7039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021

There are a few more places modifying the VQ to Ready directly. Let's
consolidate them into resume_vq().

The redundant warnings for resume_vq() errors can also be dropped.

There is one special case that needs to be handled for virtio-vdpa:
the initialized flag must be set to true earlier in setup_vq() so that
resume_vq() doesn't return early.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e3a82c43b44e..f5d5b25cdb01 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -160,6 +160,7 @@ static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
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


