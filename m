Return-Path: <linux-rdma+bounces-3740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FBE92A220
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599561F253E9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988B14A0B6;
	Mon,  8 Jul 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMipdns2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED0149C77;
	Mon,  8 Jul 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440174; cv=fail; b=eX6fFLR570sasTpRa54Yw3jLV7BW/74T8dzykFvfyB8RewCBldCfTN/ldekvb/D52fF9U3DwO7OOfgcZ0u6VxE54lpDtW3ffM/i7CQL5Ns7Iogq+chupIAVpKk9qAiCHTJip7APReB8/KaTXx6m2XMIy7TUoqu4EtH5iQPXaEqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440174; c=relaxed/simple;
	bh=fO2LxXbQwK3zIdaoXW8DXBIgHadEd6bZLr2gSb4MzZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kWOT4czHRFkgoBV94XCTTUjUy9O6OihUHMyOrQoeAQUulGjOxws5WGeLhaTKQogP7VIXt/Tc/ZQYv3unPU9Zi9qHgX8A2rhqaORoyxHVU5QHMtYHL9eIJE5h5bgoL3SgIl/Rdk0xi/1VVd8L+jYBYn7MG9LJWkThsHmZw1B8RN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMipdns2; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrRLhN91V+a7edTOkCZ/psxVVJBOA3wk0c5xH2Mu6/zS6fgKVTHMjblTp7BAWsO4P1q8MVMc6tUePtSEXlWF3QY7ZQdo3NPXI6des006rKVOPn5HEwMwvOTJwTAKy9daeHXIYXZm1xmGcD2Xz12kRXkepKpLM3QKuzhK4U5H7oboNWI81+QgJNyAZblGHOiQkcnsdbFjmR2UU96Cr83C/sm/TA4FAzyGhDQJ19RFjGwMjhYLsNEWZoFms43Eay57M7Wg2HVTGSTCx2fZHNDN98J55/6SwFvkSv2Ds8felTuIGUN6ELIC++qfDtWaTHA7G/rNp1Fl6fznwc2cGfZHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IiD7p91QtFX2qpSYAmR2W15j/7v+yh/UZLfdd9xRPg=;
 b=hf8QyU+WBBTFf7vNyZIjtnPENWgmdIQmky3aqNvGLv5C2daEFEKhqX2fZH24sHtfDISp6acPyfqXD5t4ZI4HDYMtcA0gg8l5sebryTUB/dy/bFHYnFI9oP12LrSE76nInyDLFB8/O+RvSXYD97+42d9QH2NhP7WO2vIf+ATnE11rccjBh3B8mD1J82iE7oB1DjvvNxx2VcGp5vLKocr9qFO6quLo8piqyOgmpU33UFIz85M/sqkrvpK+np9kopRHjawfLd3ROvJmWTk+lrzY7CgMt131MYIZ6hO9yHNY9XTaiMYLx3iyyZN3FEJAXM9QVrkR859U8sUJZY8+oGIRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IiD7p91QtFX2qpSYAmR2W15j/7v+yh/UZLfdd9xRPg=;
 b=bMipdns2/MMiT7idi6+aed+Vwu7iEkBZTafw+uQt9Fe3GhRDg3KJZGZLOOVVUNN88AGbde73oBrvid1+/dByYjbR5jqwWczMnBP073bgb5CeYq2FKo1hy7V9D3a8p72ci6Y3lBe3D+NlVdpkjzRno+YHC5lT1spFumg+xxS9d/4qdhKUdp0jih1rngELnUJ+brZD6OToY4s50G2Hp5mlC+l0wOoi4fkCVbGjg8XxGYc/Vdj91IBZTJu0h2PDfCcDlXnNQpBvN1daenn6IrHyn79AxmMbnJMyxAFa60ZONyQ9LRvwor40ZnznoCYBs2Tf/cr4vnVqnpTk40L450S9ng==
Received: from BL1PR13CA0067.namprd13.prod.outlook.com (2603:10b6:208:2b8::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:50 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::56) by BL1PR13CA0067.outlook.office365.com
 (2603:10b6:208:2b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:11 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:11 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:07 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:42 +0300
Subject: [PATCH vhost v3 18/24] vdpa/mlx5: Consolidate all VQ modify to
 Ready to use resume_vq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-18-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7359ec-1993-4b50-6b52-08dc9f45e386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czU2T29uVXAyaXd1aEVJaXdZU0JSNFU1YWU4TmFWQy9BUm9UYzl5djd5R0RB?=
 =?utf-8?B?OFJXWStkTDJrR2JPQi9kbkFqblpzdHN2TFZsakZlVXhmOExHNVNOcG1TbGdr?=
 =?utf-8?B?WXpCTDRKWHVLZjkxT0plUjNxVEtnSkZCWmxCT0FlQVo3T0wyVmwxRUhsTTRm?=
 =?utf-8?B?N05ObmhjYUZ2Y3dPbi9wZER3ZzNXTmlJK0JTZ0RTZ2EzTmhCMGVUWEZqNFVR?=
 =?utf-8?B?Um53T0s1a1RZUkNCSis1Q2hscm9rRFFiWGRMa0VRaUNuY3poa3dXdUlNMFpv?=
 =?utf-8?B?RmZPQjVocWc0WXBXa0gzWXhsSndGNFF0SjF0aTVyZ2FaeG9YbUd5WFRLeFZJ?=
 =?utf-8?B?SDNnRnZKNzFIZ2NLVElkSTd6Q1FTRUFtVUxsV1BXR3pBTEVvc1FvZ0tQc3k1?=
 =?utf-8?B?c3RUVEUvZ1d3clg1a2Z4MzE2aU5uSENrcUhIY3hSVFNCdnZvR1hjMVN0ekR3?=
 =?utf-8?B?Q0MwSUxUdjRjb2QvRDl1VGxVdDYrOTFlRUt2d0dQNmFEcGFUS2RITklDdjIv?=
 =?utf-8?B?WTJMQ0J0b2NPWEZjaWdyZUNFNHhOS0I5T2c3SnR6MnJ1QlhtMlQrTlF6T3h1?=
 =?utf-8?B?VGpFWkxkY2hnVU9qdFVkakVnSGxHdkZWS3cwRlNTWGVaYjZ3WmJmSkMwOUhj?=
 =?utf-8?B?UHVzZGdoSnR4cWMvUmVGaWlvamhWL2VoaEwxMkFmeUdXUDVCcEpYdWVRc2E3?=
 =?utf-8?B?QUg1b0xRVWpnY2RvTHREbjFXT280MTB6M3htc0M4NWIvNjBGSEQvaVlHZDEz?=
 =?utf-8?B?T2liMzkrRTljUHBzeVhGNUhadHVlMnhUbWRtNHpFM09laDQxRWdzTTArd1Zk?=
 =?utf-8?B?Y3N3cXd2Q21rL0VqaGVrUkhPd25ZNHlSYzFOcWdrZVV0YWFwUzdrdzJmVG91?=
 =?utf-8?B?RXJtckhkVjNIZ3hDYk85ZmgvTml6K1Q3VEhlUytTRi9zY00wY2FFem43WXd5?=
 =?utf-8?B?V0lHYlhGclAxbDdjYnJJcXJNbUNqZ1FMZnhZQlV4aEdncHVubGFHUE5Vbzcx?=
 =?utf-8?B?ZEVENlpud3NvcVFzSU5zdDhQL1krOWRrMmFReG12K3FGaHJzeTBGSnd2OTVR?=
 =?utf-8?B?aUc0S0ZaK21vMFNaQkcrTG5LQjdPbDJsdDA3ZXQvYTMzcTlsczRXU2VkUXkx?=
 =?utf-8?B?NFNSWlplTDRRUVRDRzNrWmpqZWYyejFkdjF2WnBxWDdCT0JuYjhxNUxwRHZG?=
 =?utf-8?B?RjdlWmFaUEE2aVJiWm1jQmJSOVJhcHNMMEwzaDhVUmdlQzFmS2l5WDkrWEZz?=
 =?utf-8?B?ZVZ1STgwVDN0T2xFeDFPdFdwaWsrQzdHOTN5bHJDOUlScWtGU1BJMkw1MU9N?=
 =?utf-8?B?ZEJoTm1PdWxHZldJWVc2ZTNqckxFdm9mVWtOMUNFcHhMb05mVmxSeVg5UWRo?=
 =?utf-8?B?TWhENTBEQi9MM0VnaGFuWjdtaUZVclFDNEt1TURnUGFEUVRBdEhkejgvbXNT?=
 =?utf-8?B?NFFITlNiQXhTT3NMTFhVODhNbDA3MGN5QllUVDJmdzFpQ2dHMlpFbTVITTNm?=
 =?utf-8?B?ZE43OG1tOVp3eDJBWGpLYkhsd0tMRkYyNnNTNjdqMXJqMG1ZNkxZZHo2azJW?=
 =?utf-8?B?VVVGdmhYakRySGFlQ2dVNXA5T0VRdGFRZnBFVk1WSzNYM1lGK0E0cE1aOTd5?=
 =?utf-8?B?aDA1cmpVYVZ1c2QwZU96V0c2SSswdUNxR1QzRE54bXNPcVp1SytuNnhncjJY?=
 =?utf-8?B?N2RzakNVSktWLzdCaG1lUi9hbTN0c1hqVE85eWFJZzFROXY4bk4wMXEwcnhI?=
 =?utf-8?B?YmpKRjYwVTA5RDI1QjlvdlJYb05HUEkvNStrWmtaT1lXSGhiRDB3NU14VmlN?=
 =?utf-8?B?amJvdFJ5SVdYRGwrQ3NrSStXUGJTVnJGbDMwTTJRLzVuTW0yblJ6a1A0WFgr?=
 =?utf-8?B?eXZ5M0lZNGNKOUwyL09wWE5OdE5qRmoyRXVld3ZJYkZEK1JPSGNBZU5KVjZt?=
 =?utf-8?Q?GNrvy+Z/zTojyCcZ9vKY2vqVF8FPIJGn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:49.6689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7359ec-1993-4b50-6b52-08dc9f45e386
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

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
2.45.2


