Return-Path: <linux-rdma+bounces-8848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7AA69AEA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EA417AE78
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F6321ABA8;
	Wed, 19 Mar 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oKe9TPaq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A46219A8E;
	Wed, 19 Mar 2025 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419985; cv=fail; b=tlzVxvM9Cq8sEpKGx4cXXiD5duteeR8dyVouwrT9ZO396yxEv/AjmG4Njx+cnq0FPSB8pTJLUJY+jjyYxVNK9indft0pHntk3zEVYrXMTnyu0UK/9o1Zp7xtm3dcTXnfKDYZmcFDnjLm/z+B9aj0wSZKl/lEWN8g3IUrmHE+Ig4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419985; c=relaxed/simple;
	bh=0m+dMWzKBTtSpJry7Ix5dD+K6JoKdD58JHKFP+Bus7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQ8woYSxfRi2rA4oJhBRyI0mvQe9JI2HEtVtiBRj1Zf3RoP+NTkctzpxNChrSmYWTcWv5jPCrY36k0osKjI2xTf42jYaupNgIvli9J6hy84afXDJYjcSwWpg5LGZPLwddyap9CZIj7VmPWTJUo4HoW0atIi+JvXqgCygXEQkI+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oKe9TPaq; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXQb12Fhmhl/0LTA+BPL9rBx8Cvt7/+MYXnystOeu5hwt2tFkTmSUjsXAkNqJHEfr03SuKrgZ4oqDfy1662bxm/KMRuvvf2uiNQLxRaTL7yEQF6yzVMupOhW6+q20sfwFGqdbT5XQ+v6wRQaKCqAIXTo6JfPZGQgiP89MmYaDVAhLKdEG+/r8AAE2/cjUhWhnAwfrlM8tACKih+AvZzHfx8ciIZfiCs9eq7re1xz0S0BVOyNyUm1VgeHaBA6b7YHrgEAystluqcdrknmvxP0YWttQWi17PP5gGhrWTmW2lSRTSmSKgTlXUOE4NPZPO/q55EnzJiQgfnBr88piky/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daySA80Z3p1Sb5Pad7TNutgWookkgqX0yTGEBPCuGjg=;
 b=hiUy9fUCuGo3w7uyzzn9DfBpkPZJagy7aXtf2mlxzBzsAO/vqFHyG5z6Q8u8kunYpoaDL+tzdveqYtb7h0EgXvETQegc6Q+LVkXdpIKF/0wPq8zr5dDbb9oS+vObmA6jk+tHweHHrcoZWZxA4DZt0izSgEcpZtxKoqK4TIVxMONcxkBpcl16GjuwxauKoJJ6JgpulMr+SUuEV6CGG9o6x6kYcQD4Vwdc4xEf9ApAyJCk46l84qs8HVWqDO/IBRGwwdoWH81Ab+1wwVQIUFxaDN68pWkWU7Q/LedHpZJJh8GrI3FvCctomI9A54ecWNajOUQUC7tnTNfzWA109gu/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daySA80Z3p1Sb5Pad7TNutgWookkgqX0yTGEBPCuGjg=;
 b=oKe9TPaq2b+wtGBVrb2pg7KUtJnn8O2NyJxCvaBYXthQ1MdfF6FymVRYWmy6qDe+ZgTFaOS04SA4OcHJZLyS2c+FAUYR+rrioZyp92syEL7+KWA6KU5ADkidq/w7D8nbxFWhGL3t6T/o7Hi9Iy/YLJ8X7RuP8/ayCv/OmGoIjgY=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Wed, 19 Mar
 2025 21:32:58 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::2d) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Wed,
 19 Mar 2025 21:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 21:32:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 16:32:56 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 3/6] pds_core: add new fwctl auxiliary_device
Date: Wed, 19 Mar 2025 14:32:34 -0700
Message-ID: <20250319213237.63463-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319213237.63463-1-shannon.nelson@amd.com>
References: <20250319213237.63463-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 477e9012-d09e-455e-6c04-08dd672d9e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXt3JgKVXtNfIBELYN13LP6N1OlHPj+6d9bH+Gjg261Dm/pAm0nl2vp2TliP?=
 =?us-ascii?Q?rFOgP0vJi5fbyRLCv+Iyov7Vm1vR8H/+ksifeLQN6rbbHOtWAzDIiFDl8n0X?=
 =?us-ascii?Q?F6IviXXNR3B4LJImwPbS0wXNOgynBaM6LubDdV0I6UldENUeQ1SfbTidGXpN?=
 =?us-ascii?Q?RTuS7pjJPL1e2PmWangzxuu54ibc+r8PM+usEGeGtkxK6Y8CtVCtgayqYu5z?=
 =?us-ascii?Q?FxIoWHxF6Munfb3DGjQBOcA89sU4KRIWg35ZAR65yG6ibJPXNB/j9RVsrROx?=
 =?us-ascii?Q?CzstD4JkHalTN2iOBng2Ln7meh+AgJaDmGKg9pdsS/coIeRhUSbN/mxaOMWI?=
 =?us-ascii?Q?zdA0dox3uiu+HkYGhKNpQlbqallNwc/Y0St2QshgjsnZRyotAAcJtAgH/Kw6?=
 =?us-ascii?Q?2ij5RuNWCNe8c3PMgj2dyGGuW07oZq15XS42wKcaTJ5j1wSr2tXvPpZDPYqC?=
 =?us-ascii?Q?xdb0+mnORaOMyJLGBG4o5zxO5k7hUlogXL4R41xnbUMFkrxTdApg7ohd/yn2?=
 =?us-ascii?Q?kAmVfrtoApTsC2lruREvpH8kSRVuJfQ6bBAHLmmLI3xmBKcdxismlvF/ajhf?=
 =?us-ascii?Q?Q3ixoz67tIUazxiGXaIZ0eO5gvHuwXr9ZpnJJ9jB8WS8xhHsQZ/ajQ0TtfyH?=
 =?us-ascii?Q?b33T/riHXHVBNGcQmIATt40Y6xc5XjKesp4DqqphrnOPGfrahxZGa54CgDAj?=
 =?us-ascii?Q?+jM6koqQwgLW1C5l7v5GBsDdrzEUSasgA0ye0U69Dsrw0tVGGASM+qraqKsJ?=
 =?us-ascii?Q?dIqTiF6UN4jjFSfzT9j9Eh9IJZeR7uaTUp6DrlR7putGrxKDdeNZ8Njy/5ZZ?=
 =?us-ascii?Q?2N1Z9IL9/Q9EHeouuhfHAuluUiR+66ImjanNcnfbc5iCD0GQCjweplc89HVQ?=
 =?us-ascii?Q?C/ZqjVw3nHykfWtaN4WmXrFyn4hhCDj8W9k6kpGp59rPrgL8xfC1va2ovzpE?=
 =?us-ascii?Q?3VWbfeSiZNUcNWKVRCAcXqzKeE2Yed6OAze5oi34dvMFcThY5sR7XwjAip/I?=
 =?us-ascii?Q?KcDPxsx1EBYiq7i9NfubJOYXVVqU3XujCJChHnyYw5lqNibzV6r7HYNSdTdO?=
 =?us-ascii?Q?eXgxyE0djVNmzI2kgfTrSmpyf+X8IpWWkmhoaFWA5Q7eoCUj2MtY7tafL2+Y?=
 =?us-ascii?Q?iyYGMmzm8mGiZhaYs7tprZRsxXRwTKaX9S9MBOnfS8FEdD6x26c2+m1RxeJB?=
 =?us-ascii?Q?902/60y6gVLBRz+eoTnasJjH6eX7/O/4wZuRBAdEx21se/I9II1JPmZZZmXD?=
 =?us-ascii?Q?KfgSq5f4QvfhNJYX9yx+eVBSFrnGiqhMHX7b6HYaWl2IxF1v2qt/9Ep/ZThU?=
 =?us-ascii?Q?fNkDAexdjLInKZf7BWZtWinr+qDWjtxlF9yue3/Hi3HfpiMZsBH0JirFf5af?=
 =?us-ascii?Q?tgyqyyQo4Yw5tydAkROOKVTkNJxS2KXldv04a6FsX6IftvoHcV3Hfz8ppIUQ?=
 =?us-ascii?Q?OcEj1YPg9VCLyDXs6IQgENFJ5tapqLI0MUPKsf5LQq47MeNzgQP9AKR9459P?=
 =?us-ascii?Q?uc9/52ZsSBjm0rH0Q4z6g1bQ2F7mCmDYfelT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 21:32:58.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477e9012-d09e-455e-6c04-08dd672d9e8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550

Add support for a new fwctl-based auxiliary_device for creating a
channel for fwctl support into the AMD/Pensando DSC.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c |  4 ++--
 drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
 drivers/net/ethernet/amd/pds_core/core.h   |  1 +
 drivers/net/ethernet/amd/pds_core/main.c   | 14 +++++++++++++-
 include/linux/pds/pds_common.h             |  2 ++
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 563de9e7ce0a..eeb72b1809ea 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -224,8 +224,8 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
 	}
 
 	/* Verify that the type is supported and enabled.  It is not
-	 * an error if there is no auxbus device support for this
-	 * VF, it just means something else needs to happen with it.
+	 * an error if the firmware doesn't support the feature, the
+	 * driver just won't set up an auxiliary_device for it.
 	 */
 	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
 	if (!(vt_support &&
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 536635e57727..1eb0d92786f7 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -402,6 +402,9 @@ static int pdsc_core_init(struct pdsc *pdsc)
 }
 
 static struct pdsc_viftype pdsc_viftype_defaults[] = {
+	[PDS_DEV_TYPE_FWCTL] = { .name = PDS_DEV_TYPE_FWCTL_STR,
+				 .vif_id = PDS_DEV_TYPE_FWCTL,
+				 .dl_id = -1 },
 	[PDS_DEV_TYPE_VDPA] = { .name = PDS_DEV_TYPE_VDPA_STR,
 				.vif_id = PDS_DEV_TYPE_VDPA,
 				.dl_id = DEVLINK_PARAM_GENERIC_ID_ENABLE_VNET },
@@ -428,6 +431,10 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
 
 		/* See what the Core device has for support */
 		vt_support = !!le16_to_cpu(pdsc->dev_ident.vif_types[vt]);
+
+		if (vt == PDS_DEV_TYPE_FWCTL)
+			pdsc->viftype_status[vt].enabled = true;
+
 		dev_dbg(pdsc->dev, "VIF %s is %ssupported\n",
 			pdsc->viftype_status[vt].name,
 			vt_support ? "" : "not ");
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index f075e68c64db..0bf320c43083 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -156,6 +156,7 @@ struct pdsc {
 	struct dentry *dentry;
 	struct device *dev;
 	struct pdsc_dev_bar bars[PDS_CORE_BARS_MAX];
+	struct pds_auxiliary_dev *padev;
 	struct pdsc_vf *vfs;
 	int num_vfs;
 	int vf_id;
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index a3a68889137b..4843f9249a31 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -265,6 +265,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 
 	mutex_unlock(&pdsc->config_lock);
 
+	err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
+	if (err)
+		goto err_out_stop;
+
 	dl = priv_to_devlink(pdsc);
 	devl_lock(dl);
 	err = devl_params_register(dl, pdsc_dl_params,
@@ -273,7 +277,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 		devl_unlock(dl);
 		dev_warn(pdsc->dev, "Failed to register devlink params: %pe\n",
 			 ERR_PTR(err));
-		goto err_out_stop;
+		goto err_out_del_dev;
 	}
 
 	hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, 0, pdsc);
@@ -296,6 +300,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 err_out_unreg_params:
 	devlink_params_unregister(dl, pdsc_dl_params,
 				  ARRAY_SIZE(pdsc_dl_params));
+err_out_del_dev:
+	pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 err_out_stop:
 	pdsc_stop(pdsc);
 err_out_teardown:
@@ -427,6 +433,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		 * shut themselves down.
 		 */
 		pdsc_sriov_configure(pdev, 0);
+		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
 		if (pdsc->wq)
@@ -485,6 +492,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 		if (!IS_ERR(pf))
 			pdsc_auxbus_dev_del(pdsc, pf,
 					    &pf->vfs[pdsc->vf_id].padev);
+	} else {
+		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 	}
 
 	pdsc_unmap_bars(pdsc);
@@ -531,6 +540,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
 		if (!IS_ERR(pf))
 			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
 					    &pf->vfs[pdsc->vf_id].padev);
+	} else {
+		pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL,
+				    &pdsc->padev);
 	}
 }
 
diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
index 5802e1deef24..b193adbe7cc3 100644
--- a/include/linux/pds/pds_common.h
+++ b/include/linux/pds/pds_common.h
@@ -29,6 +29,7 @@ enum pds_core_vif_types {
 	PDS_DEV_TYPE_ETH	= 3,
 	PDS_DEV_TYPE_RDMA	= 4,
 	PDS_DEV_TYPE_LM		= 5,
+	PDS_DEV_TYPE_FWCTL	= 6,
 
 	/* new ones added before this line */
 	PDS_DEV_TYPE_MAX	= 16   /* don't change - used in struct size */
@@ -40,6 +41,7 @@ enum pds_core_vif_types {
 #define PDS_DEV_TYPE_ETH_STR	"Eth"
 #define PDS_DEV_TYPE_RDMA_STR	"RDMA"
 #define PDS_DEV_TYPE_LM_STR	"LM"
+#define PDS_DEV_TYPE_FWCTL_STR	"fwctl"
 
 #define PDS_VDPA_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
 #define PDS_VFIO_LM_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_LM_STR "." PDS_DEV_TYPE_VFIO_STR
-- 
2.17.1


