Return-Path: <linux-rdma+bounces-3738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C792A218
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57832B238EC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25682148308;
	Mon,  8 Jul 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9a7kq8i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B67145FED;
	Mon,  8 Jul 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440168; cv=fail; b=c9dSp1QToNMod6i7BUtm3Rm8XU08V4nPOmKIb2BUwfhXkJD1JR+1r4jay9HuV0GGirFjQgcBN4yLT1mmJOck9Dz1jeUV7Fpn3B5/mfmIt0MRnw/WmSoSjkfp6TpQb2NjhKv/n/fz1F/NFyOZ/jbTV/WEick+VbGwuZueDm4jTwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440168; c=relaxed/simple;
	bh=j56Q1R9+qKj3zimocNs/jwoXu30uxe1SwY3lWelE70w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GNeEiNycPdKG1dlniudYwAE5LKYBuCYrjmjY1c3x8qp7hpN/9PdvlOz1B1OXMTIddUR7v/ZeuemL0IpqoUWpkTMXZ69Io39h4IH5fD3j83TGmFtm3YN0+dlt8agRJQKDHiIfQ6gkqZVkuuRwEQjZykO4b/8jTvhRKKCuPuRoHd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9a7kq8i; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaW0tk7mnJBb2UirGCmKtFXGxky5b5MS8V61fZqm7Mlv6Bn/W6KJGisrBX8akfgUAbmAa5Ox1kfZhTvlK7/2v2DxTrXDJ/yL7mEgX9qYY0C+b0OwsfRczcW44q2RmeaZ3YMkCLLOFcVN5xIXfk4LXbHthLFonTPrmRozMsTXO0cShJeLCDPXdqFRkGTngZpcG16tnnUejO71ANK4kHDLgF6upfbo30tQDpl2hn9FjtEsDI1inI+5b8OV4br0dzr9HtJlw9OZfC6RCiJjEsgHBJm9eBA4aOpNg8mOs3LCnUQdI5YLdJt2Rd4yzYUmR1xx0IEmckdUSrkMP5T4JKgc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISitgdDRM/H1DcjihRHvzDRZcL8cihdnZd5QMX1uOCA=;
 b=RcrwTW6WprmozhM69o4h+pKjdMe6uGkVpWTZ1nFDXqDtQZ2DfxlXeFcGMxDdYNF9W7XNA8E66ZzUxyXu5iVyvUZRwxyr8tLiSxcTfvEaraW0eAKUqfaPZUGqzUkbgdIdvIIax31ieGJdgC53YHnCnBjvE/0LMo2etoAenpZxAe39t6XTQzoeESHQU//F0bV5Fna5Av1xTGq/F8E/TbesbHU3n39vFsXx68mhrCAm0c7tMPmrl6Nbpa5zjYfpEr2deqzQEYO8VMpWYT1XYUKfNCA9m+ntOMLNf7x1shZjFKnOeu/oxyXRlPfdZg9qJ6JkDW6sH/TqvFn8XhncTAOovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISitgdDRM/H1DcjihRHvzDRZcL8cihdnZd5QMX1uOCA=;
 b=R9a7kq8iqfi08w7Odyw7ambGsRZ2NqTWjIx+7WzOjgZR2K59hUvF44JPLLS773eSW0RNuW26gW/cKz5Msypb0kUqXtBN10j+y047SGZDo1bbisnM/z4pzEcvoJJEwwjzoRIYUkIic7vXVg18Qwgb26eoGTIaeCaeDMEOe6OaevPg4g5le9W7+50g8qlTlfUpfGWvRXkZzy4vFX29jNrvMT7/7ync+yQ6euqeOTQmz8V1Li83sQaDARMtgPRHM4NIFQGtT5oqer8HBPYRLevFJXdTG6f4Y/srIblsEhG3dbfxdVk7vmKN+yFJNbivTrDjL6C2EY3VA3BZh8UtGpD9qQ==
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:42 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::df) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:07 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:03 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:41 +0300
Subject: [PATCH vhost v3 17/24] vdpa/mlx5: Add error code for
 suspend/resume VQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-17-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: bd851a43-db8b-4e5c-fb95-08dc9f45df3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdTTGs4djdPZEdmRXU2bGVUMG1OMEhCVTFwOHhzc0dQSHJnTzZ1SnJnQWRi?=
 =?utf-8?B?S3BUQlNobThUb2Z5eFI0Szl6TkkvRWlyVjNHWjEzaFpFd0hqbHR6RmhXWVJM?=
 =?utf-8?B?TlZTMXA4MXFFVjlabWFRVzE2cWxDRXFrNG9ZbGI2MktzTG9RMm9zeUU1UjJU?=
 =?utf-8?B?dnhMbnErT25ScVBMSEtrQTdRQUtNM1BEdTN4KzNxZ1BsME1ENk0wZ0I1UFlm?=
 =?utf-8?B?cmlMNk5pb1FXQWt4TyswdEhHTitHeVUxU1BlU0l5eHFVL2wzOFAyZm5HanRJ?=
 =?utf-8?B?Q3B2TEZUOGdNQklod29VcFRMcVdIUFVrT3d1WGFqZEJXMmg2Kzl2RFlsSjE5?=
 =?utf-8?B?VGY3RFAzZW5tMC81LzlHOXZHWlpyYXAybG5FRklGcVBXcFlKYnM0VzFEMjhv?=
 =?utf-8?B?VGZBc0xKTFJ3RzEreDhyZDE3WEZYYWlXZDIxRHdxQTYvTHlrUWtLOXBpbU1h?=
 =?utf-8?B?R0dIbHJpTElWUFZpeUVQTXZGMXNvckExeVcyWHpPeUVtSXIra0tFQ0VXdi9U?=
 =?utf-8?B?K05PcGtxRXo4SE9QWk4zWkJoRDc0TXpiLzRpR0ROTk9wZ0dsRHEybjNzMkU4?=
 =?utf-8?B?RDI3eERsWTFKK0FLVzJhOWxVUExvZ0RvK2pLMkt4TzhCYjFXVXhNaDY3NTRL?=
 =?utf-8?B?UFVwQkJHNWVSYmE0UGhYK3lGT0xZUjFUaG83N2diRktSRDZvb1drZTdra1Vt?=
 =?utf-8?B?MlZuSnY3Y3ZIK0llYUhMU2NnRytSNmM5cnlHYnE0QS8zVFluM2NLdCtpV1B3?=
 =?utf-8?B?TmtNRU1KdnlJWFViSnlocUcwT2RmMkVHYy9DeEJYVHJwT1BTZkRoN0hGK3pB?=
 =?utf-8?B?ckV2SVhqUnQzaVl0bjhBK1o3bGQ1QldYS3JlRWw4QW1sUEswOCt3a1pWUC9O?=
 =?utf-8?B?Q3BMM0FteWY0YjZ3c3R1YjhwOVI4dHBoQUZsamtIYldSSzlXaUZITHRyZ0RR?=
 =?utf-8?B?aVMxUkprWUYrOHVaKzBESnhLaHN2Mm5keXFZR1JWVnRhT3FDOEdpYUIxc3VG?=
 =?utf-8?B?c0RHR3RVdCt0UThLZktsOWk1aXJyODhtazJOTlUwMXlXMElLT0t3aTFVeFB2?=
 =?utf-8?B?eHM3SDlRb2dJeDE2TUh3aE1wQVdaSE8zQ1dwQW5Pekpjb09GbDkwbzRpcWdt?=
 =?utf-8?B?LzB3L210UnNpTUphQVppcEIvaGZUbEp6TDh1aFBkQWpiNEtETTFTS05yY0JN?=
 =?utf-8?B?QUdCR0tHbUFjSWJjN2lCV09aU3BZTDMwQU1ZZHVGV2k2RDltRnBPbUdNbW9p?=
 =?utf-8?B?bWkvL25kMGpxMkNRNlJjT1FiN29ZZmhhcFJKTHM2S01iRG5NT1IxQ1NZeitw?=
 =?utf-8?B?SnE3b3c3UXhOcjd1ZGVnWVVCb1g5dmRYa3NOQklrNW1USXVGalZXOXU0M214?=
 =?utf-8?B?aW5XdUtYaGNMUldRKzVzNmpIc3g1ZkV3UXN5MGRZSnJqVUFRMmh0cDRUZ3pU?=
 =?utf-8?B?UUFHTFJKK1RUU2FaczdRYmZBemwzR0tacDh4YWJmYjI4UExXVnVYU1RSMTZF?=
 =?utf-8?B?RGZxajhBcHBiK0d2R2dvalY1Nk1kTUcvb1J4MmZ5bXg1emZscjFnVGpmTlZH?=
 =?utf-8?B?YXJ6WitwWEpmUE9RRnBQRG9Bb0d2Q2xHSlFuRnAvWGdSdVBaYXQ4ZWt1eG9y?=
 =?utf-8?B?Nm1IQTdFNDArUTZqN2I0QUc2bnVhVStOaUU4M0NjZUdwVUVFdnF3SGFuZFc1?=
 =?utf-8?B?SGlxMTZ3cWljelRZODVlMDBITXBBUUM5U1JMQ24wNG9vUEN6OXA5dWVxd09D?=
 =?utf-8?B?OFk2RUQyaDlNM1FWNklZTTJ6djlPT3IxY09xTytjMzQ2MUFsU0dVTTIrVS9M?=
 =?utf-8?B?emtOZlF5M2c4TWlNS0hRZFo3RWhDSHd4cnJQSFBsT2FGY1lsakJ3aW9iTWhk?=
 =?utf-8?B?SDVSeG5ZOVE0YXhLNGtCcUN1ZnVIRGFCNGl2SDdSUlFSd0hxa1pGazBLZ095?=
 =?utf-8?Q?bOnfl90S7aoicogBnuRQ+ATuKbYz0zGM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:42.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd851a43-db8b-4e5c-fb95-08dc9f45df3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

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
2.45.2


