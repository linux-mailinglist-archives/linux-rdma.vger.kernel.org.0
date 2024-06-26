Return-Path: <linux-rdma+bounces-3519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B8917E27
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6561F239FF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB518E75C;
	Wed, 26 Jun 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JE6mCmqs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38621802A8;
	Wed, 26 Jun 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397715; cv=fail; b=NJtzvOmuwYe+6uShKiByuNqV0HBjvFUWo464+LyzUw77F0HrV+lGnchniothKVu1LPx1kvCEkZ5JjeVZ2gEFxDNqcIu+k7Ugq+HNVXE+47n46JIE4s2r3mUZUFPOdsQUIuuMyeiX7TkIpcHeef3DPGT6IEztGHZvksKP4I+4sV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397715; c=relaxed/simple;
	bh=KzL0sixBvJIDy7Vhrh+Q/XWnayacEnpbH71aL6z58qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s2R3XnaV7/x/NioICY6Uk8J8W4CTHro9EHXR6+LlTbKSihZW4zJg08t8jnXrLxWd3Wnx9CkGUxWuFgQdtaVLh43uvThGiyMLXBIaGuRS5EGpYhdsnMMr8S1sSTMSzst+08Raz9w5qGjPIc+RS+9E8O7qq7NHPQN7k2h+rLZdEFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JE6mCmqs; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0PAdhdfnjHYyvUSISZrGzYcx1p5rOGeFsWaVKTtDhtcivK4w3qA58VLFAC6iHP63STXSYtB+QczAK0hXYKnZGE6Nk4u9HvYH27I7D6HaLrLemBuj2OycOI/UxlHWA9olplQ73XGI4lg3n3h5wwvAPcohkNDY4PIQRMzlJkGRuKgzNY8ttDNxwC+yJOdnlUQQnkO6KMKTfWeTZtrj5qDTc9iuPFfOuCT4Y6AlsxgFUxQRvmOfOSKUd7ixvGXQ2j4EZ2Q6bhCltdxF4MDfz04JmT2rA516/xA8wQ34HkDpk4VjkGHf8EHnrUJYokVb8y34Rhs6+mOmDefIjes2f4C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4OVsmkSdBXMoztHCW1W8j8xXFtTAXxAsGPZ5KvBk0I=;
 b=N9FvwtDMfZ68fhyNYTIxjHIt7GerkTim4kbaV3+u29l9W/flao+qIaJctQSR5+7JiXeXl+btW9MsQY3iJU6d3n8h1iCwkzgb3TQ/rJSCVrvydqrauVhmUReO0N0u+zlgrO9ewuzsMVtKGpJohTJpGPoyC9r1r1ESwXyeTJwHeR0nUYCv94g6f68hwM/GhgRa0v3HyVcDHU2oImj+pw7jqZnwtt17B9cvjC8ugvnS800MueUWo8WjjmSGlzLBlUoEIt0cC4zJWnWTQ7gRARHAz/ZNXA+synZe5qaj6srVzZg9TgEeJbnLpmBbLCMOQGq7SZ++hKo1OgkK9jFz2UTH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4OVsmkSdBXMoztHCW1W8j8xXFtTAXxAsGPZ5KvBk0I=;
 b=JE6mCmqsnSOTjD3qMhQodiFm2JLNcKLvcVZVr9vcZHqopb0C9TX+f0jcH+Scf3l7OCe2HCRkuXYqZW76l1DyZzt70GcmPr2hurBVkAfV0rPQxkPaNbDnFGx8Xiu3I0wOrjXRmtVL0og8orEAaRLhZAmNioBwINGCD24iSDzgg+OdyoPWTTLdlpbc5fVaw/yZwdLszKW44/qT/Nf6N3IblZfqHG7a2+TzcleBL9JUcxcZDCY2E7Vb3qXHw2VMzO8jNQfBL29OSaVjui8RyUxQ8Ym1ct3oqfjXbAJwE8lBovWYFPdOOGmS4nevdGUF1KkP5+rdscjOMnT99oYUbVbqgw==
Received: from CY5PR22CA0025.namprd22.prod.outlook.com (2603:10b6:930:16::13)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:28:29 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::68) by CY5PR22CA0025.outlook.office365.com
 (2603:10b6:930:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:16 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:28:13 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:58 +0300
Subject: [PATCH vhost v2 22/24] vdpa/mlx5: Re-create HW VQs under certain
 conditions
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-22-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: b23490ed-89d9-4fbe-6f6f-08dc95cab8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|7416012|376012|36860700011|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVM5TFZGaVJVVnZuTnRCRm4rV3BZMlRQWXJHMVlTTDUzUllmSDNUNFBGbDJh?=
 =?utf-8?B?dk9TUEZDWTNUMm5XblVHM3dpZ0tzajM2TFJFWXB6ajhRNm5aNmUyTng2eWI0?=
 =?utf-8?B?SE9lYTZyMEVCdTQrbHJ4ZWhlSU1xeWEwVUZVQUxRRno0aW00MmkxcitOdnM2?=
 =?utf-8?B?WERRek00K2VYdlkxelRPTFUzRklxTmZFdzR6QnZtWHVjYjdaTjU2Y1hwc2VW?=
 =?utf-8?B?QUxzaW9abzdHakdOSlFDKzV6dXpJeXZ3a0dRbmRzYzN6L2tpOWZWR2Q3U2Iv?=
 =?utf-8?B?YWxQUGdWRHhNcDUwakpkUENWeVRCWFJONGpHVXhJaG10TUsxaExJL3gvUUJs?=
 =?utf-8?B?NXQvSGZPeG03Nm9wbUdUZG9oNjVsSzJnN1FtUW1UQTJkQVNhdUxUZ2pneEJ2?=
 =?utf-8?B?VnJyZ09mUVIyT0dXdE5MT3BrOFdtSHBhOFZQblpuT0l1NlVHa3FFaFpTbjdh?=
 =?utf-8?B?akMxRFNTSkxEQStBNTh6ZVFOWmhQaUJrT253V2pkSG4wYjVBa2t0M0ZvNEtD?=
 =?utf-8?B?ZVZwUkJoNEhPMWF2QjIyaWlac1lnYVdPL0k0VzRyK01SdWR3RWlrbnNZUG84?=
 =?utf-8?B?bFFaVGpyNTNiVEVIaHZlVzFSdEkrd0lpd0xSaHlYd0xlbU85VlliR1FoN1d0?=
 =?utf-8?B?djVGZGdsOU9DcnVWU3h0OVZjOW9sbnhITmVmZ3lmOTQrUmtoOTlnRUxieFhQ?=
 =?utf-8?B?QTZod2lESUJMN1pWTDhVRUw4RXlXRVpTd1NWSHVKZ29ORUxPZWxKMHdqbHVt?=
 =?utf-8?B?cHJUYnVQenNKbHkrM2FjS2hGWm4xQ2NLKzdYRnBFblJuK3k2MThCbDlUQUNW?=
 =?utf-8?B?WDdGb3Q3Tm9HeEJjY0xRSHB0OHg4TGVnNnVVRVZpRVJCeEZuU3hYaDFXN1Uw?=
 =?utf-8?B?bXh3Y0pZZ28wMXlVbkN0eHVabmRuMmZRSFRxanRVY2xVc2NkY1lMUFhEZmhx?=
 =?utf-8?B?UXQ5K3pwcTB1ODV5OFN6WXY2dWJIdUdraGhXRmE5bTZXcjh2Mi8wTHNMZVF4?=
 =?utf-8?B?N0hrbHk3WnZ2N3pxVm40YjRseitMVHdIbzhYZVlZZDVYZjhpUVhYRGdvaHl4?=
 =?utf-8?B?azNFYjd2TmxXeHo1MGgvcnF2TnhQY2VmZEJSbVNsYWJoRnJQeU1CTCtvRFRQ?=
 =?utf-8?B?YW9ldW10VFdYUU1NbmJaVTUrYmRNRXVmYWxXVW5XaEVzbkpZVVRtWFVpU0U5?=
 =?utf-8?B?REltYmdReHYwc1FlVDV4YVNYZHVwYXV4ZzlpL3FjTFZWUVNyS2lsNVNtT3ZM?=
 =?utf-8?B?dTA5V2ZTNkRESGhDVWJrajdVOTZaZFQ3YVduejlYYjNMS01mVlZxMEkxYXpE?=
 =?utf-8?B?S01HK0RvWkdraHB0aWhyaU5uOXkrWkFBY2N1NVBBLzBCTkp2MTVOMU4yanJF?=
 =?utf-8?B?QktjM1h1REhZcDdKY05KeFJFdHJTUWhndDVSRHo2aUlhaTFJa0JIcnhyRWRL?=
 =?utf-8?B?WUkwTG5mNmlVSFhyejBmTnRITUVKZExGc0RKcGRRbFdCNWdtdXhSdVY1RXJG?=
 =?utf-8?B?Y24xVDluaEw4OUVwTjNvVkJ4TWh5emNxdnREWWwwTHhoSFZSbEZxR1VOOU9u?=
 =?utf-8?B?cEp2VjBWK0ptRDhhTUduTWpXQ2doNlBwZm82Y2xxeUtxaVRhS0hMNitmSDlv?=
 =?utf-8?B?WURYVWgxZUMxYTZydjl1V2pucitBUktyWDArRmYydHIrdzJDRW12MFpncE1t?=
 =?utf-8?B?cFM0a2FZRU1jcEU2b1JnczV4aU52WGMwenJOL2ZjUUJQVm5icEJ4OEtrRmk4?=
 =?utf-8?B?MytYSHUxU25RRzRZczE4eVIwVTYzUVhUcFRkY0RxTExHWkNLcHNYWXdIQWow?=
 =?utf-8?B?UDg2NGxlMnBqNHIyQ1NXRTU2UmE4eDE2eGQxd1lXRGRndlh6cHZCY2M0VW5i?=
 =?utf-8?B?NVZUM2xTNlVTSWFqMkhlTSswaVp3enFsTlN0NGNxODZVNndHbEZJc3hlUkNJ?=
 =?utf-8?Q?MSifUAbqpDVcM0d3GTqt2Nr3+etbndSI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(82310400024)(7416012)(376012)(36860700011)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:29.4881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23490ed-89d9-4fbe-6f6f-08dc95cab8ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

There are a few conditions under which the hardware VQs need a full
teardown and setup:

- VQ size changed to something else than default value. Hardware VQ size
  modification is not supported.

- User turns off certain device features: mergeable buffers, checksum
  virtio 1.0 compliance. In these cases, the TIR and RQT need to be
  re-created.

Add a needs_teardown configuration variable and set it when detecting
the above scenarios. On next DRIVER_OK, the resources will be torn down
first.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 8ef703f4c23d..ea4bfd9afce9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2390,6 +2390,7 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
         }
 
 	mvq = &ndev->vqs[idx];
+	ndev->needs_teardown = num != mvq->num_ent;
 	mvq->num_ent = num;
 }
 
@@ -2800,6 +2801,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	u64 old_features = mvdev->actual_features;
+	u64 diff_features;
 	int err;
 
 	print_features(mvdev, features, true);
@@ -2822,6 +2824,14 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 		}
 	}
 
+	/* When below features diverge from initial device features, VQs need a full teardown. */
+#define NEEDS_TEARDOWN_MASK (BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | \
+			     BIT_ULL(VIRTIO_NET_F_CSUM) | \
+			     BIT_ULL(VIRTIO_F_VERSION_1))
+
+	diff_features = mvdev->mlx_features ^ mvdev->actual_features;
+	ndev->needs_teardown = !!(diff_features & NEEDS_TEARDOWN_MASK);
+
 	update_cvq_info(mvdev);
 	return err;
 }
@@ -3038,6 +3048,7 @@ static void teardown_vq_resources(struct mlx5_vdpa_net *ndev)
 	destroy_rqt(ndev);
 	teardown_virtqueues(ndev);
 	ndev->setup = false;
+	ndev->needs_teardown = false;
 }
 
 static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
@@ -3078,6 +3089,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
+
+			if (ndev->needs_teardown)
+				teardown_vq_resources(ndev);
+
 			if (ndev->setup) {
 				err = resume_vqs(ndev);
 				if (err) {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 90b556a57971..00e79a7d0be8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -56,6 +56,7 @@ struct mlx5_vdpa_net {
 	struct dentry *rx_dent;
 	struct dentry *rx_table_dent;
 	bool setup;
+	bool needs_teardown;
 	u32 cur_num_vqs;
 	u32 rqt_size;
 	bool nb_registered;

-- 
2.45.1


