Return-Path: <linux-rdma+bounces-3732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257A92A201
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967CA1F22E76
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635AE140E37;
	Mon,  8 Jul 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baJeHqVs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031B13E3E3;
	Mon,  8 Jul 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440138; cv=fail; b=axi2YH2pDwo2mvq0FwkLze2ak+fgNgIRVkFUkvYwCOXo4UlMilfUimYW00PmJ/HwDQBIkVAvyv3t+QRLQ2t7yphLITxGzThJZcYTUB3a80vEFxkQc+1kqi7u7kDBRyjMEzRp+VmubmoWGv+eD003DUNIbUwtunuXxUYuwcXwITM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440138; c=relaxed/simple;
	bh=TVHfjxmSt5akHn4s/rVliwdUCFm+KTHasMQySnLZlTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OPcOvviWIssFfwLmaVgVCwdOdLITHyphW6+L0ywQc+rJdBmJxLH+suSQStGcUWONt0t6VUH4cG0p66zWSVGbSE1zeYaar4l7zz5hlz/Rb54ehESoAklRCgVQBGQdgNqVY2fjbI3KhRsqQju0BbeVMJMoPOELHeZQQpOoi8WwcVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baJeHqVs; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAyRg0InXuJXyQll0Iz4EidK+42ElrIpAd0TSXj7azXfXe+K1uksFjLEzeEdQcrZhZuJM7pXGwC+GaDolNBXWGVCzOVbhPx/W8BqV4f7WzydYEnB7bFIwQcKxxluazMWAxd4HxlOs2/tlRONXroOT8NaTQ/blzLp8Ex0MM8tzypRk1qXc0PL2cXP6yIwAZEUS8Q79zuL0bJi2PhaBaemLvsvMhG1uB+Mh9FgPspSy4fLgBNBJ/N1f8GIuqvik3Cq8Q5B6SDqsDQ0TtW74tWBaJUdgN7zfF/W5qvA1tgnYFdVfXLcfKurLDJECEvqD2Al4cb8imxmNdnzxGhWrabUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi29vWT4QU7y52dtIFY8mr1iiukNC8OZ2PeGectkxR8=;
 b=jPOglGwkDEWd02De37Rp7wxhJtyWY7udL7sVZheNKg9X8Zki5J7YmGluTLE1K45npo3psqcSpswQU6LJ47BY1j7R9I8a/pgkciPhkJFdXAWcc3IgFPdx4Fv+AnfAKdykk6uXAqZB8DGOoGY+e+z7R/SShZ1RNsCH8+8to0s8JH/tst7s3UJlRcp3JN6uwgbp1BdTZkBNqUWNppwN1OF3PsAbl5nhYPObCpEREdEYOqny2a8sFHmkdKFewiutnuKLunhn9eSSBlM6Zxs9r3zLuakd+AkepD4/F1cEaY6Ks+QMiAmGDCgXx8ug2kfmqgH5wANRueKN4z7MpNaBNJeSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi29vWT4QU7y52dtIFY8mr1iiukNC8OZ2PeGectkxR8=;
 b=baJeHqVsNDSpG4s3ZULSxUmJA9IZa1FsCP6cm68gMY4Tc9Mmvso9kkl2e8eOTUMzwnebTfHCazugdgryWQ7e6ybnsRHK8JmwGYQRLFEde+aZ+FvbZUjP3pBbtZma0ul7+inTaYVAPNotCqJdrDt2yDfV8ujUfrX7JvQDb5Z0FMxbyjS348bcTmISPLA+F64VsufCoWsH9LLpKMOXGDH58UFIRQ0D9y8V0787M5Au/AU7e+Zn64zfDf0QYgsZylaxyNJ8227ajxgTH/w6BjGQLzYLUEJtLpmvk0d2LaxZ8Q1BR5LfGs91uIxL5GaaAvJ3YKB4DUd/2UrsE2cvBj4h1w==
Received: from BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) by
 PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:12 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::ea) by BL0PR0102CA0005.outlook.office365.com
 (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:27 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:24 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:31 +0300
Subject: [PATCH vhost v3 07/24] vdpa/mlx5: Initialize and reset device with
 one queue pair
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-7-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: b527ada5-177b-4513-a74d-08dc9f45cca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmUyeHBpNjJKMW1SV3htN0dVL01ZU3U4MnRicWNJUTR1MGUzczZFYkx1Q2pj?=
 =?utf-8?B?RUUrangzK2hBLzlYUGZYellQY2xLZlZnckROdFA5RDRTRGhqSEc3WnUrNFV1?=
 =?utf-8?B?Y2lzNHJlc045OFVOc2hBVENOaFBIbUpsYk0yWmxCd2lpRFdMME54VEw2YUpO?=
 =?utf-8?B?cUJVcjhMTXU3YjVzN2JmenIxT2pXTzJmSytnbU5BdVNQYjFLQ2RtVklRSXgr?=
 =?utf-8?B?SHhZRUR3U2VraTAvTEZIaloxblA4MEZkMTArb2Uyam1iUEQ1UWdIRWdiM2lw?=
 =?utf-8?B?dC9hNHFwRkpoWnE2VThTOXNpZFNCclNVTXptK1BoMjBkMjRHaWcxbFI2ZDV5?=
 =?utf-8?B?NWZ0UVRJcUpmMEE2WU80d0o5NlBMVkU2NjBHZ1hrZ0MxRk5VUWs4N0h3YVpw?=
 =?utf-8?B?S01GWjd0VkxZNVIrUlNqNngxRkJua2RCbmU5V0tBL1Z5RVVpamVoRzk5QnU4?=
 =?utf-8?B?UXFKc2lsYk0zT3VtSXhlOWRHd1BFMFVIc0wvSEFWYmJIanpBUzBkK1Mrdm9L?=
 =?utf-8?B?UHZncnVrUFhDczRCUk5hbEZXa0Y5NkhuNVdVMXJuS1d5NkQ2eDdnbzFxTmww?=
 =?utf-8?B?a0daWFVqSThMQkJETmtwMTJXaEdKWUtTQnQyQUpOZGVQTHJ5dUt4MUYrc0dY?=
 =?utf-8?B?aCtaalhiRzY0UEpTOHVrZm1QSVVIZGFaL0JnT05SUzlwWlVhUmRUTlN1MDdj?=
 =?utf-8?B?VTd6M3hXL0Rqd08xTGJiUmZvYTFoZ3QwRW1xS1d4MnBMVW9kdXF2SFFYMVJx?=
 =?utf-8?B?VjdmWm5MdU5WVUJ4ZUgzVVYzWk94ZXhuREl2Q3Foeml1Z2VpYU91OWorbmVx?=
 =?utf-8?B?NEtzUmJqV3hCWFVTT3V6Vk4rUkIydnRhQXhFdVAxWGN0ZGhQeEpxZ1AxNFpx?=
 =?utf-8?B?LzU5cWZxcUtNdy9tTDBQaUNMN3dER01NeHpvV1lBbGcvdkxwWmUyTHJaQ3NJ?=
 =?utf-8?B?MFFrZUZkRGFPSUJKU1Q1eTRDb09pMVRrUFlrYjV0bGRKWmUwVjVxbHFnUnli?=
 =?utf-8?B?RHg3TDRqdEJPTG81RENCSUd4V0dPdWd1T25hb1VUckFneWpqNUZnUUh2RTJR?=
 =?utf-8?B?c0F3WXJldWRVNzFGMlBtUFVZRE8zVExLc3lWZjVUaFdKWlh6ZEVzS1kvcVdx?=
 =?utf-8?B?Z3BWaTJxMlhIV1JFeXlxV2pJMytOdDVBNnFScFVCL3JNZmFsYWM3N1lxM3dE?=
 =?utf-8?B?UTRhdlM2NTRvUG4xOGEvcTFQZ1Q1MTlET2N1WUxKWjFwcjA0dDdnWE5CcmMz?=
 =?utf-8?B?Vys0cDRsYjJkUDVrQTR0eWVDZ0JZSjBwRVJLaXExeFBFY0dtWEJzRWFIeTRB?=
 =?utf-8?B?UmZFZUtMSGFWOFdvb3VGZmpUUkJCYm02N3BTS1JYby8vYzhGUVJRK0NQZUFB?=
 =?utf-8?B?dFhEcmdHZkRSdHpyOWNSYTZLdTFCeVZCSmV6OWpNZW1UekZlZzIxVWFiQzVq?=
 =?utf-8?B?aklkYlB1MUJuTHBuQjZtL1BLbGtWZm04MndwSTlHeHVVMTVQczBvaG1HK3JJ?=
 =?utf-8?B?NlJYdGpNTUZUYlRGUzREK0pKMlJ3L1Yyak1mWHNZQmZZMllNd0pRU2E5K0hW?=
 =?utf-8?B?RHlaeG54RGhrTTNoWXdmOEhqQ1JOaFh4Sld6M3RxSlBnSWUzM3ZjQjByUmVP?=
 =?utf-8?B?Q3pleE9rOVF5TVFBODBLbXNDcnRFcU1QNURoQmhYbGtYaitVZ29PUWJ6VVhl?=
 =?utf-8?B?QmhBODZ4dEplMEpmNmdlWm5yenZYR054Z1JwQkpzelMrUjd5NmJ4dmZlNkhZ?=
 =?utf-8?B?QTdsT0tETENQaStYekhQZDdWS3NVZE1nWVEwK1ROSUlZSEdTWDkva01jc3JW?=
 =?utf-8?B?Z0hpaHpSR0dINFhPYXNaV3Y2YWoyN0pUaTRybXBiVjFwUVNUTWRzS3JiUTUx?=
 =?utf-8?B?V3hmVlovM0Y1akFRUkxxV1cwOUdISHlaSGdGNml1MnlSZUVFYTNaQS9YUk4z?=
 =?utf-8?Q?gcknJVvz3Ey4V2irxOr8fbhc6KPVcjWK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:11.1595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b527ada5-177b-4513-a74d-08dc9f45cca0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668

The virtio spec says that a vdpa device should start off with one queue
pair. The driver is already compliant.

This patch moves the initialization to device add and reset times. This
is done in preparation for the pre-creation of hardware virtqueues at
device add time.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
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
2.45.2


