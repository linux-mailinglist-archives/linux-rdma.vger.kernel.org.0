Return-Path: <linux-rdma+bounces-3518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D226917E22
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C871B28A30C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC918C355;
	Wed, 26 Jun 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxVMEOaK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EB17FAD9;
	Wed, 26 Jun 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397713; cv=fail; b=ZWcrkpXX0hExKixwoiykIvf4mR1QWormZN4kbELxdwECiDd5Rd3yimOq6V/cZS9/ulNM/kSH0gVgPBo4/yoEiuEy2rQXome3z4wbbQtlIMLKJpR4zvFNHW0cGgcJSJbdLd0a/b9PKgRayhzu6XFfvWpd1EzbANYXhpxR7HKbeb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397713; c=relaxed/simple;
	bh=Ip6lief/IjZaAxpA6NoTwmejSF6l9Cf0d3YXtQAlKKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ku27cPmC/F4Yu2Wjk0uInS/hfytpeyTzm9ZwUr98Ma2mdz5+4OGLEsMN/DksJwJNC+ZGQd8eGrmSYw0YB95XdFqs9/wQZczFw4AhG3goYqw2mMKkT3MNoNovADYdaWP6FpHLdzEB07lZpW8Aw72D6JkVP5yjQy0lD/yN2q/vjz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxVMEOaK; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/Tnek7rFs6fEq7VhXxYhnNfZsQc0JKdufvtMn1s/aYS2SIkc7iR18pTjdQ5Y9AQSbC1xYvaRvJSXWbZHyHhKYlyLha0LlFSbnBmyPZf8PCkfigT/CzJ/+FXbLZj9qcUtFiguiJ2iIZtKyPA9DAKE+zrKL9inZ4lHJaXD6AhLhbdf4xdwxZxBao5pZlorDJAaUPj30eoswEbLFIBDH6jsB81zyZfdAVA22q+1u1QD5w2vDUZ1rFtgOinev+9xpWuDEd9qnFYrRrh9OKrpYQOHNdDjwEBSdTz4oxrzN4teNMOm7HuVcxsvQx215H32UNpllXkIIXRqFzMqFXlbgLyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSP82BZ8rmGH49UVoXZTv8/d8H+Ejf4fhvU3E1V68Ls=;
 b=KvVmfy2IV6MBObFr8ZS+UaAkRMomBM4rPqgXiRhlEgllc6L8dchEXDpZO7DNtymqyP+DtUlkhBmgoKSlj7eOiTpe+g1B6bKsNRb7Cngwkj5XWe/hXO5SS9RFVL+fN76JBjDmpgLhIW46BTRA9pUDRM5nbwqtsWcjWuxbQhGSa2HDZXCz5QJOngFlMLhpp+umpFyB8KY35cfjX3jVDbOAqrYcScFNeynmldQn0oLBlnIOBiZqVliEA3RWsJSx+BOT6OaX6kMvPoEwSPMx4tiqiZNM7p/z7CaBn/qohciSStZb0kpBkbIqUyNgiGaW0oOvF4cPQxAAc2idQoqREhZ5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSP82BZ8rmGH49UVoXZTv8/d8H+Ejf4fhvU3E1V68Ls=;
 b=lxVMEOaKnNOMcVNRU+bd5JaEMbBUA4JHNB780hFploswS+YAE85pgRh/xIuSGk5ea+hiRblxrgIIGmlV31eNv6E1mvBzkJmGPZgGLiQszeOE+vU7s6E6zB+vbhSKJAF0dChZTxA5AR/snAs1jwMLr+r3L+0vt+lqNqI0C5f3bMYnMOCUU/6ZuzqMRCYuCWvl/7yVRJk+qH2oCg+CD/hYXYvDEFhMwkfJz5lFYgrFItri21IrwUwC3gj0FLzJhWmonlTCvvLfyfoE3snTw0IpjaPU3lmN8r3B+GAmXTpIl1HBtGELj3SYfz67YlVVhdzR8ZmYmZv1mVwfu3FcYE/8ZQ==
Received: from BYAPR11CA0075.namprd11.prod.outlook.com (2603:10b6:a03:f4::16)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:28:25 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::2f) by BYAPR11CA0075.outlook.office365.com
 (2603:10b6:a03:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:12 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:28:09 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:57 +0300
Subject: [PATCH vhost v2 21/24] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-21-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: f55e93d6-11a9-4267-a025-08dc95cab5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFdzMVk0dFlnNklZMWZYYzl4TXVna2J4cDZlRU5FQ3BuOE9ycHJxTitETzRw?=
 =?utf-8?B?MG5NYWswNnVPUWhRU2lLbDgvOC9jS25UVVJDM05FMFEzQ2p3TmtWVmhYLzBh?=
 =?utf-8?B?cURsNHFHYUJ1NjFVTFRldWxjYlE5Q1FnNXZUQ1dmWnhKMlEyelVISWFXYWpK?=
 =?utf-8?B?ODFGcHVjb2VBNDU0ZHNLTmlyY2FNV0l5ZTllcG50MHVDM04zaVh5SlJsckhO?=
 =?utf-8?B?OGlwVzFFbXczZDRuRFdpWGtaN1V5dkF0ZEdSQlczd21GZlgwaU9xQllOVWZF?=
 =?utf-8?B?ak84R3hONUs2bjg2cUU5eHpnRStnRTcxeERtT0dhSENwL09wbmk0NDJiQit0?=
 =?utf-8?B?MFduQjF2ZU9IaUZpN0VsQ2RvM2hRKzB1dlpIV0Z2T0xqcGJkZXRMWHd4VEx0?=
 =?utf-8?B?WlNSL2ZWbmEzdHhBalY4TzNvRG9CLzAvM3hWdDkzNHVKVk82YkZSc0pBZ1Fw?=
 =?utf-8?B?cUFYcHVZVHRUUk5LRk8rbXhXb1UxUnlqUGQ0Z0RhRXpLRFpOSURJOGRHcVR1?=
 =?utf-8?B?MGtNVzZ4VnFjYTkvckJIaGE5YVBpUHVQSG55RmFva0IvMTlDQnkwaDJxbGhT?=
 =?utf-8?B?Uk40Q1RWaUhITkdCQ0xIVEZYWFRjVG9nUDJRaUxGdTArS1pYQ0lyakk5Zkhq?=
 =?utf-8?B?MjIzTzdKM1FuVStTL1ZZZFI2TE4xMzVkeVdkR3NkSE1MUkxvbklVT2dEUUFu?=
 =?utf-8?B?Q21qYnFXNTIrZVFuSW5LVGZPSEZHYnU4K0NwY2JKWXpTeEtEVWxCemtDT1Yv?=
 =?utf-8?B?U2VPM1ZYSHVBbXVIRFhaYkpWUVpFdTRvUHA4cmE4ZnB6SDhRS2VLRTIxQzNp?=
 =?utf-8?B?dW1Pc3huajdXZW5PaStXa1JYbklTYmI0MHJwUmMzd05lMVN2TXJDTDg0K2xk?=
 =?utf-8?B?clpOaS9PYnpSZ01FN3E1MEVGWUxURFdOYzBQWjBPUFBzRnlZMnRJbVBZRnJ2?=
 =?utf-8?B?S1RLeUZaRWpSQlJUbTNTSkFaeG9aU2FPa3Z4Q0k1U3ZXeFpmVU5nUENTNlAw?=
 =?utf-8?B?VFJLS1kvTjZsREdYRVhyVjU2dVF2OFVIQ2RGUUR4Z0xzYmlhQWtyTTB6Tm1h?=
 =?utf-8?B?bTU2UXMvc2tjclZ0MVF0RitTQXIrSmU2U1RmYjdoaXJEZTdkaFVYWUhoRkk5?=
 =?utf-8?B?cWl0cXlRWnBNSHZsSGhES2YxMldFUzdZZnVsZ242dldWSnVGV0F6VysrR01M?=
 =?utf-8?B?MWc2WVJlNmJWWW5EMHlUNnJsWVpOMzdEaHQ1ZjhrZ1RqY3BiNWowbEJEYUsr?=
 =?utf-8?B?Q1VCNGJzRUpyLzNYeHdVZEs2SGdHdXRNRFl4ekRLQUQ4VFRKTy9rVWxTVm41?=
 =?utf-8?B?Ymc2a2ZjYnA1dGRLMzV3bFg1TGtVamFvbHUwTEt6ZDVKRGh1dVdnK0crajhN?=
 =?utf-8?B?UEhySGNtT3cvVnJpOGVLWlBHcUdaaFEzNVJwM1QwUCs0RFkxZWY5ZUFPQjBT?=
 =?utf-8?B?TU92dFBueTc4U3lPNnhWbEhlVU45ckNnME1JSit1dU1EY0U2MzJORmZHa3VT?=
 =?utf-8?B?TTg4T01ITXFNdCtmaWlwZ2JtK0NQNUNFcXlvU2ZIbkk2YXdlaUZHM0Z6TWlB?=
 =?utf-8?B?d2RJdWY1OTNCUXRDaGtPZmpmdUIrS2o1YTFuVi96Y2NTdnBxaysySXpFcnVj?=
 =?utf-8?B?VitYK25BSG81Z3NDUEdkakYwaU5mR0U1TkQ3RElhTkRMZ3VRSnBXN0E3emxp?=
 =?utf-8?B?OWEwS1dMN1VYUDlXLzFBby9SOXVhTEVjZDZ5SjdwRGxzek82ak9XY05VdXVw?=
 =?utf-8?B?VmVtVUo5RDhWeHZPbGJZY01ESzV2VUFLU21Da3pVc2hzZUZmMXMvQjNZUVcz?=
 =?utf-8?B?dHpiNHlCUDNwTVBSbTJraWhZZ0c4dm1MSWtOU0MvUHU1aFMwSFhwUUNNNGs5?=
 =?utf-8?B?K1VMVlZqSUlYblJXTStWRCthdkRLRnJVWUl4bVM0UThCWVZ3dlNEZkg5K01S?=
 =?utf-8?Q?hlxaLFShviQTfbbGXu31jhaYi78T8Vb5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:24.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55e93d6-11a9-4267-a025-08dc95cab5ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

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

For virtio-vdpa, the device configuration is done earlier during
.vdpa_dev_add() by vdpa_register_device(). Avoid calling
setup_vq_resources() a second time in that case.

On a 64 CPU, 256 GB VM with 1 vDPA device of 16 VQps, the full VQ
resource creation + resume time was ~370ms. Now it's down to 60 ms
(only VQ config and resume). The measurements were done on a ConnectX6DX
based vDPA device.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 324604b16b91..8ef703f4c23d 100644
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
@@ -3835,8 +3844,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_reg;
 
 	mgtdev->ndev = ndev;
+
+	/* For virtio-vdpa, the device was set up during device register. */
+	if (ndev->setup)
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
@@ -3862,6 +3884,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 
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
2.45.1


