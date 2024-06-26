Return-Path: <linux-rdma+bounces-3504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35C917DE6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2884BB22341
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529981822DC;
	Wed, 26 Jun 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FjOYvlJa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172217C7CD;
	Wed, 26 Jun 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397659; cv=fail; b=YuAEf+3ZXFWDL6QUUSso4XYcYAHjQqlYir+vQ1i/ZgOsS67/kYVuwdd7NJyOtsjYvcAqDOExOvc7k34WmpxpVLnbAmgeu89K2HZuC4zi9NyLvo5fDBhxAKBcA+wHHl6pF5MTwCbQP4WJP4u2dwmLW9vWErOSrsGYrHPobHpxN5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397659; c=relaxed/simple;
	bh=Cp7tAXzhQE+P7/IbjPuQwl+ySnyhMpGENFRwUNhHmmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TqboV/+p75614A+ddTaixVnLSbN40v5jiYy3vJoEK4JzUhr71KvHebrVRi+MkiR+OuJGDW9k6SehOYzpgiwL75CuAKQRPiamqSI5GiGykf6iICQYtQ7KzYkcW3fM/d59mTKbu1mCMmk44X7qlV22/skR58pZBwt0gZzdLSuWoeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FjOYvlJa; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9HWWI29AQpwYdU35V6opuPNL5pW8gghCyMu/dK9C6RJGOjPDQ5Iii3yWrZ/j/49FMXr0KSevvXm0cYqBLEkMSWRni6fALmR/a7VTf4BLav1DgKucC7wUhr4SMABNlQd+F8cexl7hZB2D8ntb78+WR8AeiLDINFeeK/C12AyHkfbTCSDz684A5Sx89nEUh6x6gvjvUADUxR6AhZ2ZfSUcf7wsoRrZUhGKtdXt1nEBo19xdauLUfSNPkJXR49MRvJdTm/KEaKvgmN0KOovoX9ENUKxQeKK2RBH+zzO4MP5Cvftkpsb/Ixf/NDOK3yf1a5+IKadorweG4Id9GMGyaSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQzmTX8odjQONLAa4OIO7L0KzlVkpAYTEX02Mc0whkQ=;
 b=a+oDdgs8EtvoytIJfKPTXRGccUnz4kAf+Y4sMmRW5Zbped/KzdMhugFWJ9Gtr54J1Skp99/bKPxbqqE4iQj7qiiX40JY7wIKLWVRqV0ojuLn9zQ5ksBLCkc6c0PKjHkhVy2NaE/MOPy0TA1DhIsl9kPu5v34HSRWhNliSo00dip5gqGbP7LD57mY220RhcJh5AaJr+9K8gJRiJpy0BR3sBRQdgZoFHzTdPO2A0Tdq/ZN1B/hBHCLb+ra1hNlI69narJxH3zYQpGZ+G7wEHJQCPQeLpmWJglLgBnnszYrHFGaaxof68nUB8kh8A4auPodRZIXwUgKYUjl9cLRgcXfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQzmTX8odjQONLAa4OIO7L0KzlVkpAYTEX02Mc0whkQ=;
 b=FjOYvlJabLR7exra4LGzVU7NrYmk0CATuwLVyJaIZMq14jGsUiCPKI8L5L+TrZZTK3F9lrNFnYAit1r8fE34R+eLZthrJLtK4+nHN5Q/oyxOvNBjR+EwSquBUZ8qaZ88rGCuATkbuzwTo32O1lWmuwVO49381GLFOuUNSmOdiDXBDYhu8bQx5W5zeKOkelRJVw4dElrf+s81zl+bs9yJvTzs6ofXkBiv9TXOYKij+o+mQIdjFjg0hOazgELRsVogplmm2rlD8a4krpjdq+Iojfz9Fa0jurP51zVbCgz+Mgsrvcs1a20/ih+Q5uEjEFcxQXqMlHJONHmnaaNVpuyacA==
Received: from BYAPR06CA0061.namprd06.prod.outlook.com (2603:10b6:a03:14b::38)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:34 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::c1) by BYAPR06CA0061.outlook.office365.com
 (2603:10b6:a03:14b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:15 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:12 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:43 +0300
Subject: [PATCH vhost v2 07/24] vdpa/mlx5: Initialize and reset device with
 one queue pair
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-7-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b52adba-f165-475e-9d2b-08dc95ca97e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|376012|7416012|36860700011|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UisvMXZmVDU2YU9xK2tpaFIwNndyYnpvY1dJUWFQNUFBSkwvVUIva2Q0a2Fl?=
 =?utf-8?B?UWh4N1dLNGppTkUvK3YvNXVhMVdzNG9nM1NRNDNUOC9uWHY3MVk2dDArL2du?=
 =?utf-8?B?OUxCNms1a1FMU1JrSWovZE9aek1YVDU2bCs0VFE2aFYrQ3B5MU1KaFNOcHZ3?=
 =?utf-8?B?eThMdUNQRnhIVFJMWUVmZFlZbHJzVkdUWlJkSFNtNncxSnlEMmVDWXlyc01y?=
 =?utf-8?B?dTYwcFhPNU5MY3lPZzlaYlNGdTFlMVJQQjYxR1ZWTGpwditzR3BSM2tHZENn?=
 =?utf-8?B?ZTNEWG54anRpaXhCYlRhejNoTldkL0owN1I4Um5obGxoODgzeUJEa05Ec3Bv?=
 =?utf-8?B?M1NLQXg4eHZjMzJhcUVibmdpUHh0TTkrd1kxT0RkV0xlN3ovdG8yYzAyTlpy?=
 =?utf-8?B?V1hPN20wN3NYSWQxb1ovRi9kSVJMVVRnVWV2M0JRczJ1Z3pUZG01OU5SQlR2?=
 =?utf-8?B?MTJSMUdUaWI1MFdvMTV3Vnl6RXdPSDlTK0xyMGlRWTZJMVNJcHh1OTZudStp?=
 =?utf-8?B?aGJ2Q3NYS28xcGZOV2tYbFdNZFE4WWxxendGdGMydmx6cGRnc1VUdXdSSFdU?=
 =?utf-8?B?SEpUSVhtWXVqWWpWNWw2SmY5cmFwTHN0OFdmOHJVK2NBaTFjU1Q3eW0xZmUw?=
 =?utf-8?B?WWFDMUpVSVBQVmdmdzJPdDJqM2JuSndHc3hYeGk3MTQ2bUdVVitYTUpNTDZE?=
 =?utf-8?B?K1o4M0JqZUM5cVdxV09KTCtQR2IvclU4b0hGQ241Qkl2TGRkak0yT0lVc0pK?=
 =?utf-8?B?aFV2SGFuQWUvMWxxcWRSK3lHSy9VQ1BPRXd0UWFNWndmZmRxSVIxK0ZPUURC?=
 =?utf-8?B?RzczTnp5NHhPc1JqdDhIUWsyQStkVitCY3Z1cFNFcnJBUWZBTDd2di93YTVU?=
 =?utf-8?B?ZzFwdHY4eWprSlduWjBMc09TeW8vaUdFT2lENlpZeVRHY2RTcnN2WDRocEN4?=
 =?utf-8?B?ZFpJYjc2bUJHa2c5cERnVXh6QVA2YWhIQWxrZ1dsYnA1SWRmQmdtUlNHYmEz?=
 =?utf-8?B?WEFCVDR3NytNbFNiRUdOYjZSWkQweUtsTjllaDBIUGQ2TGEwNlVENEJ6bDE3?=
 =?utf-8?B?cUd6Ry9pc1FKNkdzMWdzYVphMjd0U2x3ZElXRjU4Yjc0V2l6cmxQQ1UrWUxI?=
 =?utf-8?B?dHY1TU9tMm9OOERUcGk5UkRUOVM2bmZnZDBtY28zdlBSdUpLSnE5ODU3V0NS?=
 =?utf-8?B?ZW9zL1pHYWhHV3RiZmM0S2JjQlAvdUFoaDN0bUhVWkhVUE1tQUt4SDA3STd1?=
 =?utf-8?B?NitUS0dwdGRJcFpwNmVITFdZdlh0T2N3UW8wMnVReENXM3ZkdWdGRHI0bk9m?=
 =?utf-8?B?TThsRUZjczlBZzZ5K0Y5SldGKzFrTzdweUhZWTNXd1hFWk00azlPRmN3c056?=
 =?utf-8?B?OXViVVc1S245Q3pwV2RsNjE5K0FUejFxTGVDL21NamtjdzJDaG5QamE1QlpE?=
 =?utf-8?B?V25BSkllbEVRaVZZR1NoeUpEU3pVSm9pajUvWGllcmVNWHlwUGVNdW92dXFl?=
 =?utf-8?B?dWVnbk9PZnpjZmhPd0dMZG52UHhoK0c0ZkFJa1QrbzRZY3dBWjVtd3FaMlNj?=
 =?utf-8?B?T3FFVHpwUUZPeDNOMVg0L2pHRWR5Vi9HN2dSbEdqN3ZieHRoTmRlUU51TDlr?=
 =?utf-8?B?b2xnQ3RMU1FXRm9QcCtkeFVacUhDcktYM3BTUHNQdVcvR2lhemRhSkJQSjNW?=
 =?utf-8?B?MVgyZlpUWFNEa0Z2MzNCSllOL20yc0RvWDBjOURmZlFaSy9nS2lxTFVKeUtR?=
 =?utf-8?B?WWowOENSdDZGdzBPMnpKMEpObHNpSlNpRy9ibUppUXpHemwxZXZUTktmRzBY?=
 =?utf-8?B?WitKTy9ua0QrcDBScHhENmRKY3NpTWd1bHVabEx2K2V5eldVNWxUaDQ1dTVa?=
 =?utf-8?B?NUsveGcrMGhzYmJmZnlUVElGeUxTSzNid0ZRWS9USjV2Y1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(82310400024)(376012)(7416012)(36860700011)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:34.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b52adba-f165-475e-9d2b-08dc95ca97e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

The virtio spec says that a vdpa device should start off with one queue
pair. The driver is already compliant.

This patch moves the initialization to device add and reset times. This
is done in preparation for the pre-creation of hardware virtqueues at
device add time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index eca6f68c2eda..c8b5c87f001d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -48,6 +48,16 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define MLX5V_UNTAGGED 0x1000
 
+/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
+ * 5.1.6.5.5 "Device operation in multiqueue mode":
+ *
+ * Multiqueue is disabled by default.
+ * The driver enables multiqueue by sending a command using class
+ * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
+ * operation, as follows: ...
+ */
+#define MLX5V_DEFAULT_VQ_COUNT 2
+
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -2713,16 +2723,6 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	else
 		ndev->rqt_size = 1;
 
-	/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
-	 * 5.1.6.5.5 "Device operation in multiqueue mode":
-	 *
-	 * Multiqueue is disabled by default.
-	 * The driver enables multiqueue by sending a command using class
-	 * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
-	 * operation, as follows: ...
-	 */
-	ndev->cur_num_vqs = 2;
-
 	update_cvq_info(mvdev);
 	return err;
 }
@@ -3040,7 +3040,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
-	ndev->cur_num_vqs = 0;
+	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
@@ -3643,6 +3643,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		err = -ENOMEM;
 		goto err_alloc;
 	}
+	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
 
 	init_mvqs(ndev);
 	allocate_irqs(ndev);

-- 
2.45.1


