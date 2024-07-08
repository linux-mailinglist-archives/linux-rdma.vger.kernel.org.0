Return-Path: <linux-rdma+bounces-3741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA092A223
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E48B23FDC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29A14A4F0;
	Mon,  8 Jul 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8R879Ln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123A149DE1;
	Mon,  8 Jul 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440174; cv=fail; b=NJZPgxphCIZcPmpIFDMPonxs/imcb4rQmm13+LU7nGLtZTKdAxZFkeG8qN2o/rY0Pic3Lwor/IGK+iE4uLIe8Cgno8vpNZqB89qqao3Cm1p/wGatNcRB9WWViL4xDrJXTVAJ/wzzCvD9YMiczeCnApo7z04IGPqfWFHzb4U81qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440174; c=relaxed/simple;
	bh=VVba3WJNyqIgjvXf60/c2if3Q5Lp4uClbknO9ar1Qo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rIOr7y1djOhobteK/qhjgeZA188y9nO8/V4/7DrnSNXT2nygqqzDSlR6imxYa7G25j+tXa5jGv5ntfJF2XBO5z9dUapxjziVG2j5ELc4sf468qkiuiR0wNolxj6MtfpfwSiTDIbdWSa5xDZ3y4zxX8Rq2UeVY3uLtPC3AdsQuUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8R879Ln; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZrMBOHLtShs3+IwjY6rVRaFXZle59lhQwG7MIx0pS4Wk7XUbL0R2PpZRMABY5rqQTheE3+FT71MKiOdfxrYyboQdfNaB1y0BBKOqxoVW90ABxeCqC0lxlYzc6VoYcLXb4/4fHqSQRARmX3ak/sxfckbCTiHzR06ZcNCU4CjqX+EWRhBFKP6uSt5g+epzqV1Eo0SOwLdYZzo/I0skQ1jUPwi14DKOAZCufBQQoPX2qbJy5GkAf/Da1la3yi2U/A5l9wb7ZW8R7RjeEWcUVLAopG97z1tbcLGI91B4Fo1upWao758Dt26G2Bah4FnTE7Ciq/MQiu/k4Uy9VDwime7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d744AQIa8qD4HFaUiluJz+0c5xz0K4Odi0KHT3LCh3k=;
 b=d3Zyoe0J87T15Ze3bVtOh6W2GJQ47k5ZgF980/gO3wbTGzJPQHrpwh0bAgtUasH6D2JbxQzj6PqcoAWSGzKrYydy1+U5l4+6onXycSkAfvDmGI8Xi8ZHFfkH7aqn/noNqJ6PrgrpfbucGI68HQeAZLuB68PPfLK+xKfP8J7Q74VSXRAIMoPqoGkg2eFvVKbXT6yQgsmIYL7WNpwRn1rD6rNXZ8BG2Cc1oUrTCp4nWZBchegE9ez0c+s+pSOh1skeaNOiMKpwpYSW7Zb8ig3L7M+3NLBQ1ITvLehWdu81HpjiKKiMP/CIBsPf2y/WRd2z5XLmJMnvisC3oy4p5/k65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d744AQIa8qD4HFaUiluJz+0c5xz0K4Odi0KHT3LCh3k=;
 b=I8R879LnisQ5jL6b3K5WoQjAYCqt7r6cAqMcqiJnZ7XIEoAo7pQeOzXQEa7KsnlDGFwM3W5zu3isNuc3V0UWQsjYteksf4jyYSvkEFhWn/ve3SmuRgvenxumanIMCvHxdyDwznOJ61WHfPoKtkAnOxB1WFn8EvItPdjxvH8DG9iY1EGsJoCRGixNtr0PVmho1iTV4/jsCx/85c4dpkpOFm6j21LEu2KjvGVbBqtOAk8AdZLHJE5EPCq/qNJTpx0AkCgeWdhGwdnDilz86b3QXWTs04rnRW4Z7X1dNtgMpvjzpPVLQRgGZ5U4si5027fIKc3zQFDIcIh6rqTBIVV9mQ==
Received: from MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21) by
 SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:49 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::f4) by MN2PR01CA0008.outlook.office365.com
 (2603:10b6:208:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:27 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:24 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:46 +0300
Subject: [PATCH vhost v3 22/24] vdpa/mlx5: Re-create HW VQs under certain
 conditions
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-22-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bea8bc6-f8d8-4869-55f9-08dc9f45e351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3gzWWNpdXBGeTNwSWxlOUVCdWxTR3FaeERFYUlKOUhTaS9CQ29GalBWdG1I?=
 =?utf-8?B?R3dtS3ZVaHpXbFlyeWdpVi95Z1JrTjRWeEhtN3J4N2ZMRmhKZTlmY0Y2SjI5?=
 =?utf-8?B?V1BONEZUQkRsem1BWFhlbnBXRS9WYVFjZ1A4SG1FUW1lMTNzalpWM0p6ZU1s?=
 =?utf-8?B?Z2piTGxJeldzcUlyWDBPblovK0lib2tuS0ZqS1oyL05wTXVyZEV6T2lTc3JR?=
 =?utf-8?B?Q3pKcTZxdEIrdm1sbGJmNFRQU0w4cnpzb01ENGM4ZnBTR0IvYVJlcTRBdGkv?=
 =?utf-8?B?c3g2NEIxc1RPZkZMY3JibEtNVGhnUFh1eVFmU1VpVk5RNFhJNHRzZzFqdDh3?=
 =?utf-8?B?SHFUQnA1L0xKVFdZZTBTWFlUTmdmSzh5QkhxbkxBM3JCMnRWVkdPWE0xQms4?=
 =?utf-8?B?Tk9KR3NFT29FcDJ2YWRDWnh0MENXbXlBZWZWVkpoUmtnaXFVbGJnS0RWMy92?=
 =?utf-8?B?ZGZ1SENFYTI1R2VsN0UwOVphWVlTb0F2Sm5XTmpnYnQ1SExBY2I1bFFQaE1a?=
 =?utf-8?B?RFFDY09jUFVZUm5vSVVsM3JLbWl4cHNqWlhHelJrR2ZDN1psenQrenBZRlA0?=
 =?utf-8?B?S2k0OXNUbmlFY2FRNVhJWnRhTC9mUDNOeEtTWitWbzRhT2xzQ1pCTGNFSW93?=
 =?utf-8?B?UzdJeGNBVGl0dXA1YlFkdC8xbEpOclNZZ3dXWThiUEl2RWt2UTFTUmdsOXUx?=
 =?utf-8?B?d2ZiOUlkMUxud0NMMU1hbVQrZkplckFpekIrSDY4cEJHMGJ0dWtlWFlTSTJV?=
 =?utf-8?B?OUxmTWw0SGhUNEgraUZkNTMrR3haU0FjaUhiMVE3WGxvZHhEcXRmK082WXZj?=
 =?utf-8?B?MmlTVmo0NWMxaWVTWG96ZkNnMjBycmY1amtGczR6aGxGME80WEZ1WjRtNTYv?=
 =?utf-8?B?eEo4YStQTDJZSTU1QTFoeitKRkFwcUw4Q3hOQ1lRQzljUnplQ2ZHaFQybVQ3?=
 =?utf-8?B?RkczaUFzYmh1OEI3ZkJ6TTJpdjRLTi80L3U4citmR0FCT2MwTURZcWJrcjlt?=
 =?utf-8?B?QnFnMlBOTjEwWkVScW5qclBiNUZ1dmxnMDdiYTBiaDFnNDVSUjhjSUpRZlk5?=
 =?utf-8?B?dTF6NHVMZ3pibDlSM1d1ZnEwY252K25uNFN2T05xeVJkUFFhTWVLcjFHQ0Nj?=
 =?utf-8?B?Yy96MnJnSGdXR1BEekJNR2JGS2xwaUxrb01ZR3ZQeWw1QWg1cDRwVk1TWkJy?=
 =?utf-8?B?eVhobkN1Y1hDZmZwU29DRENOZ3ZYRW1WZWlJMndxNU0rZG43bHBIOTdxTmYw?=
 =?utf-8?B?NXV2VVJxUHQzTVBONG5vWXB2eGE1TG9ZeFFsUGFNK2pPRElGQ01GNTd0Z1Z1?=
 =?utf-8?B?b2FYVmVzdmxsSVBBQmdpMldUSFRiQWdKcGxIbU9NOWFheDJEVFRBMTFKY2Z3?=
 =?utf-8?B?Q0hjVXdXN2hxbHJJdFAxQ3hjNE9SOExsRGlCWHk3VloxVHZYaGpsbGJyYjk1?=
 =?utf-8?B?K0IvbmlKWGxFRm8vbVREd0NHZW1MYlhTdmZ6di9DcVNmMG5LZ1hPK083SlBl?=
 =?utf-8?B?K051cHRjbENXWWM0TlJ2ek9MUU45dFNPTGxEOVNJbTZpYzRaQmVVdVFOUUM0?=
 =?utf-8?B?bFJ4QW0rWFpIWjYzTGdZUUFNcTdLQVNXV2FudFBiaEhqUCtlcUU2QUoyOEdn?=
 =?utf-8?B?MVBDZWJWdUxPQzdqQWhMZEVobVQ5dldvRjVsQkV3QXl4Rmx2UXMzcElDVEZi?=
 =?utf-8?B?NW0xTmJsMm40SDdPaUR1eHB5TWV1alNuNmlaVm93Smp0RndFRU0zS0MwazNQ?=
 =?utf-8?B?akpVd1h1ZHNyTDhMN2t3bHJLUmsxZUdzR2dRMXFYWXVia1VFQXJCQ243elJR?=
 =?utf-8?B?alFEb3p4QmpWRDRhMHdNc3FzWU1ZTmN4K1dlNFpRVmdUS3FuVFluT2UydU5H?=
 =?utf-8?B?VndjRDc5NDFEOGNucFdBa2ZsdlRkcThIajVpNnpCTHlWdHNtR3hSRXdTZGM3?=
 =?utf-8?Q?tu62xNRKaXxQFjC3UvTHcvlqxnYp6jea?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:49.3211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bea8bc6-f8d8-4869-55f9-08dc9f45e351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006

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
index 1747f5607838..f2af0ba82dd2 100644
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
2.45.2


