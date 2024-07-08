Return-Path: <linux-rdma+bounces-3739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E592A21D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DF228319A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9D1494CD;
	Mon,  8 Jul 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzdSRBel"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24D84A4E;
	Mon,  8 Jul 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440172; cv=fail; b=pXCjlpD2bcWfGxz+mNmcaQZqbQwXIrZAY54Aqhzbe0w1N5kQUgtWxt4ebfMRk74GOotPPTCIUlGD55LBpMNldyVMddf+hkgC9whzrN3Bw1YjP5F3be/Bp9ZRptpVtr4VOHCBpXFac3p31kGkBZh11CwaolRhKWjEpkSvaiav40g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440172; c=relaxed/simple;
	bh=hfGfT4tBrhoKQWnYYnEccOu3DrB2SgW2E7Hjm19C2mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KyGj1+NRjkbx/oQCEgVh5OK0tvRwsBLJ2oJ/ZsW8iPvYwRePb2LY9v568JAjGO/4XObCrKGrPzIr0M2rHDA1zfggYB0wEnSX+TA5yVzb09qawO9jeCpL1ba8+WwLMLMlDY3OlVDt2166hOguuniB9hdAjx6gumZsVYJ6ktzRRJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzdSRBel; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AryL+6PfQyjHMWczPc9BqkfmPS6ZvKlAO2Tk292QVIp/PcDrq7AUxAbCWq3k6ufjdhfZ93p1SOPksYOD6APX2lr7ITehmy6YEWKAxttEx7LoEjlcKGBVeJrrmbM9+euht/SkskB/jQlybJQsq5jcJDnuk0EQNV8OYuDRn4OTc4FZNcuCkHQQFZb5Ks6behTYigwdjQEwYsrz/e63bcYnDQyYDOaredh5hSmtxqsN8nZinczsS7AuqeCO63s/M286s5CO2k6S7rkRjRd188hXOXTflUwjSN54oA6ElO4O5q7YmV2sCSuslFp6VZyv6/dYdB76pE5QUX68g9iEB2mXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsHszw7V8zUzUADo6swexPMkyWLFXRkDDgfMbOPnoFA=;
 b=DUh2/L4gmXtmamltkmIRYzXixiSwfdnHEqnUuEK1yxugH/H6gNf61GUxupXy9qCM+rBAPuLXwZJLAmxvjPMoM1cXeUQvy+gHUpz6GNVOVmd//5z3Fa1HGDSoWFeDth3dPxLBG6FC53xZtkW5bES8Ny0+YEBtkfaLgLG15oPsgXQ+1IIln2C4pUvMvR0Nlt0s2rhF+p4T/WX3nb/q61c2uYl/gXSfLbdFy8QicTZpS84Tb8mq2LkmuioprhYPU2OVGrok1kdruVtQ4VDcQaoRzeT9sJUEuwhBJz+CxVRanub17me6wSvDDQHuehYrbyzWzdC1voDP365jNkovQYOiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsHszw7V8zUzUADo6swexPMkyWLFXRkDDgfMbOPnoFA=;
 b=lzdSRBelq1tPP7YW2Am7NjJanll3k4p1c/ulp4ochfVdWSc3cU7RVYFr9FCSbjxJ8tpWxEY2W01cYsTTxzABROszrBlOWEN/87wSZsIDAMLMSu17RZIOpu4L70fn7tk4mHMH24CIwmltghEdHoUCq+STwGiMfo27MagYc32iR70sVMCVohjRn1O9tkXp9Rqgrcfjz4GmTJp1AYV2xHqDFthm5hFzKO1kE7ScvXK803BY+CnXFstC92aEaZVEdn0RcLZkyAfhOu8if3z6gY0elTfteiEQiVuUdDRIkpHWz6rdlzfcaBa9ryf9UQc6y0jG9/skH2YO32BrG96VQepA0A==
Received: from MN2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:208:236::24)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:46 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::cc) by MN2PR05CA0055.outlook.office365.com
 (2603:10b6:208:236::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:23 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:20 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:45 +0300
Subject: [PATCH vhost v3 21/24] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-21-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2de525-6f1c-498b-4e4f-08dc9f45e031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFY0eXllbEJHUTU3VFB0dDF2UW5lMktTUWs0Umpuekw1Uk1kdGUzMXhPbWhU?=
 =?utf-8?B?UGlXRXBDQW5aN2FhVzVOcVNNeTlhdlplUmQzdUNXditZYmlCWUJIZXBRRndl?=
 =?utf-8?B?SG9wb1pRWFNqamE2SlRUTGtZczNwTEVwdTNxY0VNZmZGbmhVcElrZ2ZWQ2t1?=
 =?utf-8?B?Vi8zSnVzaUJnbjZURWI4RkgxZW40MUoxajFHcm5SeXMrQVpneDlBNm9IcmpI?=
 =?utf-8?B?bzJ3RlhFUDNJU2ZIN1djdGx5RlVDMnFYNUZxM2J3a1ZtdWw2SURWNVNLK3hn?=
 =?utf-8?B?aXBQckwxd2J2ejFyUWprbkRTMlloMjJsa2R3RWZ1TVdndWtzK3A0dU8vRCto?=
 =?utf-8?B?aWpRclc2M2crbWVkZGw5Wi83RUNGNUlCU2JVekV0cGR0U2ErY3I2MjhNaG1F?=
 =?utf-8?B?UWZvNlUvNlpseWVaaWRNUEpnSjl2ZHZqMnBWNjBaaXU2T1U0bW1pVjkvSk1R?=
 =?utf-8?B?U2lSZ3BmaWZmWU9iYnNST0tFTjZwK09yZ1d5eVJ2VUMrbG1yWjk2M0drZDRT?=
 =?utf-8?B?T2ZnalBMMWFpZnEvTEpVU2VYamdaUHdiS01MOWZhdGducFBUeVNacDgzWktt?=
 =?utf-8?B?WVhZNlFKNnNDeDJ4WjdzT3c4djJsMW8rRnMvRlhnejNsbmFCRmhPT2p5ZW43?=
 =?utf-8?B?M3JMbkJEd1VORUthZ05wUVArb2p1SWtSQjhJT0NQdlIwWHVaN3c3STRzclFD?=
 =?utf-8?B?MUQ1eTI4Q2xVZ052MDFhTTBMN1lEcU5GVitxVXpaUkdnNWp3TlA1VXRqZUg0?=
 =?utf-8?B?bnlBdXlKZ05wcnRXSnhvbmJSMC9WNGZBWnJjMTdKNHNWc245YWVPSGJNV2tV?=
 =?utf-8?B?Tnh5Mm9aRWFuVGlnb1FnVU5NUFRZOUVMOHRJSmxrNnMxN09hTG1EUmxDYjMy?=
 =?utf-8?B?QmJpMS92UTJzSEZUaktXV3hSU3NDT256MloyWGN3dmR0cEoxZ3hmdFZMK01Q?=
 =?utf-8?B?ZmxZOGNhMy9sdzFMc0NEQmtBQ0RHMmNIekh1RTBVQzRwZzFKOXluajZUYUZi?=
 =?utf-8?B?Y0w1UFFRUE1NNmtNbFJCMXVaVXlqWHd0aldDTjlhajU2MzdVVDVSUUw4cHFw?=
 =?utf-8?B?TERJdTRjWC83NzN0UWxEWFJZa1ZIdVJmTUNMTmxJRmhRYU9FVnU4RTNsdEdq?=
 =?utf-8?B?UTcyNkU3RG5pSjdzaTl6aTBkaEpiNU9ZTHlFdXhJSGovRXBaVVhLbms5T2tv?=
 =?utf-8?B?K0ZwTjVZcTZub05ScjJSemViL1ZyMWNCa0NUajdxVThGQlVBRmZQcWFRVEhu?=
 =?utf-8?B?R3lvQjdramNBZktKYmhuL0UzQWsvVnZwNXhPaEJ1N1U0NXpmM3J3Z2ZtMm1r?=
 =?utf-8?B?VlJ0REpaZ2VlM0UrNzRJOTlXSURtNDVLUWkxTjduUXhHV285c2lwdTBSWHNJ?=
 =?utf-8?B?SFFvY1pHUGxRazNnMFFGOVhBTnZReTA5dHpOUm8vTVg4UXY3QmNuZUs1WHFN?=
 =?utf-8?B?Z3NOazNSUjhiSGcvUG9RUHVZSDlIM012RkFRZkhHeS9nTzFoNFIyUU5WYmRn?=
 =?utf-8?B?N0JCRXZ5UDFUZzI2WUZBWnR3SG1aN1poazY1cTloVW5DVFlwa29pMC9EZFUy?=
 =?utf-8?B?dWF1cFp3V0VEYW43UjMySFc3WkFlaVJGLzhSM2s5ZDN3bG9tTy92d1pZVFlC?=
 =?utf-8?B?eDJIUCtDcjlvWmVMcmREdjJkeDVpcnpQTmg5Zmw5OFhyNm1BV0FKZUcySlYz?=
 =?utf-8?B?SjF2V1cyWHdFMkpBYm1QVWdLUXhZam9wU1F5NEVhVDZHVHpOSS9Dc0lzYzNM?=
 =?utf-8?B?ejhjVy9TMkNrRWhzVnN0dlJOem9nU1lZdmM1eHNWQVUvTmp5RkhERWwwMEo2?=
 =?utf-8?B?MGJ1UkNKVHVLMXEzR2VRQyt4ZjZXT1ZBMkFvYkRTMEtETG1RR3NQdzg4M0hC?=
 =?utf-8?B?UkdWRUZyK09zbm8rUWZRamxpYlBqdmtMWVZXdUVZdi9wYjl2TDlMdlRHYjky?=
 =?utf-8?Q?/N14gINaYi/TLQloSnAuMO678L1LKevs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:44.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2de525-6f1c-498b-4e4f-08dc9f45e031
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

Currently, hardware VQs are created right when the vdpa device gets into
DRIVER_OK state. That is easier because most of the VQ state is known by
then.

This patch switches to creating all VQs and their associated resources
at device creation time. The motivation is to reduce the vdpa device
live migration downtime by moving the expensive operation of creating
all the hardware VQs and their associated resources out of downtime on
the destination VM.

The VQs are now created in a blank state. The VQ configuration will
happen later, on DRIVER_OK. Then the configuration will be applied when
the VQs are moved to the Ready state.

When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
needed: now that the VQ is already created a resume_vq() will be
triggered too early when no mr has been configured yet. Skip calling
resume_vq() in this case, let it be handled during DRIVER_OK.

On a 64 CPU, 256 GB VM with 1 vDPA device of 16 VQps, the full VQ
resource creation + resume time was ~370ms. Now it's down to 60 ms
(only VQ config and resume). The measurements were done on a ConnectX6DX
based vDPA device.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 324604b16b91..1747f5607838 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
 	mvq = &ndev->vqs[idx];
 	if (!ready) {
 		suspend_vq(ndev, mvq);
-	} else {
+	} else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (resume_vq(ndev, mvq))
 			ready = false;
 	}
@@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_vq_resources(ndev, true);
-			if (err) {
-				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
-				goto err_driver;
+			if (ndev->setup) {
+				err = resume_vqs(ndev);
+				if (err) {
+					mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
+					goto err_driver;
+				}
+			} else {
+				err = setup_vq_resources(ndev, true);
+				if (err) {
+					mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
+					goto err_driver;
+				}
 			}
 		} else {
 			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
@@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 		if (mlx5_vdpa_create_dma_mr(mvdev))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
+	setup_vq_resources(ndev, false);
 	up_write(&ndev->reslock);
 
 	return 0;
@@ -3835,8 +3844,23 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_reg;
 
 	mgtdev->ndev = ndev;
+
+	/* The VQs might have been pre-created during device register.
+	 * This happens when virtio_vdpa is loaded before the vdpa device is added.
+	 */
+	if (!ndev->setup)
+		return 0;
+
+	down_write(&ndev->reslock);
+	err = setup_vq_resources(ndev, false);
+	up_write(&ndev->reslock);
+	if (err)
+		goto err_setup_vq_res;
+
 	return 0;
 
+err_setup_vq_res:
+	_vdpa_unregister_device(&mvdev->vdev);
 err_reg:
 	destroy_workqueue(mvdev->wq);
 err_res2:
@@ -3862,6 +3886,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 
 	unregister_link_notifier(ndev);
 	_vdpa_unregister_device(dev);
+
+	down_write(&ndev->reslock);
+	teardown_vq_resources(ndev);
+	up_write(&ndev->reslock);
+
 	wq = mvdev->wq;
 	mvdev->wq = NULL;
 	destroy_workqueue(wq);

-- 
2.45.2


