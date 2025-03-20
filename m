Return-Path: <linux-rdma+bounces-8879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2DBA6AEB3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F8B189B11C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DAB22A4E7;
	Thu, 20 Mar 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="19j8vA2U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88E22A1E5;
	Thu, 20 Mar 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499882; cv=fail; b=hPOS3AtC/h/RWxwWioZzSgRICeZ5d0TAq2JEmg9ghGLV/+Fmyh5YRcePZLtgJ0NRfoHwrbCp46RZcq7WAXc+YYZmSiwRm+HrTsNoBdCxqDde513gUTtyHG+0qLdgc/x9saJVeP5j4wCWJ/yyjiGz25afjOAJOYyGSgwZ1O3NNEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499882; c=relaxed/simple;
	bh=0m+dMWzKBTtSpJry7Ix5dD+K6JoKdD58JHKFP+Bus7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOY6GOg4Ozlhm3jsvonBA6Fmt5Tls7hh9mzevJpTEP8/vIpzGt9wlfNMpi5hmy5teGhwfeemIUKWKM6vxwmthGW3H+iCthrfFSag/L6g/ZtY9duGz/XQ38w10V7zSDZnus+RriPkqcBY7a9KndoSKNDfrmzSejLRFCyXTw+EK0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=19j8vA2U; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM0TF0c6Q0+75NNPsSSausXsEYpzm7TOeFvEVjtByXdjw4gerlmhmQEBvjU3DZiLcowtcdUA4vv0xP7gJnYc7AbbCEl642hm4CaSu56kAtRTH+KKYVagDqiBj18RVxD8lPbp3qxfzwaiIclUGhRitFOBn3EmrvyvZrHxujFs+RDUQzqua7t6/e/SP0ybbASySNBFosWusPeQ+bXf4hhtayQs03j/qfbYVFW/PGr9SSK3DDU0c0GTlVpkfKNOPxqLC9099zbD4r6p2OdnnTHEgGYbmJvLLQ7OQX1YZGhaI1k6DsdfZrb1unv+BCbVBh18hUmAmXfv6oCu/+248oXgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daySA80Z3p1Sb5Pad7TNutgWookkgqX0yTGEBPCuGjg=;
 b=odu4Qdnil4SoXObdvC/jBz26Tsjo3kYZvUYgyXMZU/VjDg/3LKDUV4bM0oYBRDnYVbaLbmhZV4Zvvr6Km3XTcqR3OBFk74sIvsE4B6K+6iOidhiSBqZ7slf0ZYXVHVzeqHDy9W72JB6jRW4AYTDJH8DNrSZrle+4RwK81V1EFBIm/e6Mx8bU6qK8i82A+hucstpkuE3PisW5T/v2ZrROea+cCiu7MmTq+gj7yHKpYH1y/gvS9r504zpqMIk8ejPBW2NoUlW9mq2Cm+319Pu4T0gwQd8xu374cx6t/puUm8O2VZ4heF2DmqYH4FMmBcnCSmUd1K1CclxRa3KoC3TvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daySA80Z3p1Sb5Pad7TNutgWookkgqX0yTGEBPCuGjg=;
 b=19j8vA2UIkj0yaLo8riAQ3tpd9kRgfElQazXSeqb+rNQeyKmfI304OEh0fFMGd5Gav8FwITnBOf90zQJXhvW1i9vouCTqqpdHqXbSkL+b/7GLqKv9Cc3d7DObQ4XT4NvMJlQHN7F68noDwupjrnJpS5hEV1zhfFxhq/n2646aEo=
Received: from BL1PR13CA0428.namprd13.prod.outlook.com (2603:10b6:208:2c3::13)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 19:44:35 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::cc) by BL1PR13CA0428.outlook.office365.com
 (2603:10b6:208:2c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 19:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:44:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 14:44:33 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 3/6] pds_core: add new fwctl auxiliary_device
Date: Thu, 20 Mar 2025 12:44:09 -0700
Message-ID: <20250320194412.67983-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250320194412.67983-1-shannon.nelson@amd.com>
References: <20250320194412.67983-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcdc654-2c06-4b42-4a2c-08dd67e7a488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VlCRbhDoFgEAE0eT/YYNM8NuKsNQAS1jdXnaAbCggIqbThTqwgxRMz6M10fC?=
 =?us-ascii?Q?rqDeuN9bNfJX2O6aGKiY6Xj8tXx5A62YwhNJUNXf5+ru0CAfAzgG7drRVARv?=
 =?us-ascii?Q?e6zpZ8PHmMpc02wZBFY38Ama9EcDtIYqeUNQ+LRsVrsPwNg1A6EAJfDJhBBH?=
 =?us-ascii?Q?I0JJCNIxVadycMcz2dJ3cEGUmgukZggfWTs6HlBYt4gO/8QNsXYqY/R+j4Yb?=
 =?us-ascii?Q?tqncjDSp+sNfqg3FmAfNDVww9TO5o4L9LpvFkLqO9m2AxwfB2eSp+EoFKcap?=
 =?us-ascii?Q?dzXtTmYDP8M8niDEgoT3QskWwTP1/ygvVPM3n2pSO06Ol/uqEDdZJZ0xmY9l?=
 =?us-ascii?Q?IdPvPSfmn7eQWxMTN9Mc613l6MJBWcVbQ0+/Qo2jeq2JKMhJKYDKcgi4KXgu?=
 =?us-ascii?Q?HflBA8pmdwzfcuOlRDOiZrg3mWUGfsXF184W9b8BqGFehgLMhstYuVDdxIL+?=
 =?us-ascii?Q?M4mJWkD13N3lLLeNBVo29X0Mbvkd1SDYV1UdSsJIiqDFwwPNr9ZAsod3GyS3?=
 =?us-ascii?Q?rqLonV2H8IE9q4pf4be12DJu3bQq3N7jneJTRkay8ymQVxN8dK3gKi9ZNihh?=
 =?us-ascii?Q?8z+341isboT53VK80Gj5C3DBoS/Qj0vKb/WVzdDtMD1lpYdm/DGLHIDffCbX?=
 =?us-ascii?Q?K2OTEdNdmGpnvZsBFY9+HlLIW30FuOvpfOX/IaIxnEuKZWJ00nPY6qW6pYiF?=
 =?us-ascii?Q?aJaoio7jyA5j5LuWLP0PJmPW00VHhn5I56aqEwVzbJ4cl7pZjjFpTuJhBZfN?=
 =?us-ascii?Q?MrzwWY5QYpogsnTWbj/9hfc5USptR1jKKFhsaWxmJEET+vlLcBLcB1HJjBlZ?=
 =?us-ascii?Q?YFcxh9tJmD9+m5z8rwLYL/pdCJImsmDPMKlgJvpw64nBlwaGGjD3E8eJ1lNe?=
 =?us-ascii?Q?Wt2F50PGJqLLdRjzRdp7cNHMBihCtodnkNCHJEhlSFapjnb5/jTm1OwZLbZg?=
 =?us-ascii?Q?/yozI+iL4c1C39JsswCILnu+MI4X4Yv46LmTpqt1JmbAo/e5tJzjTqJFT+NB?=
 =?us-ascii?Q?SRe7sKy297KgazPdZzVbM/wy1JLep8mNTGZptDR3TCfjzwxmRIXt0sU6Hiqz?=
 =?us-ascii?Q?i3OmZIaRXdTucSs3xdI0DPqu6ui30awYFrqOlfYuY7RP6Ud/SwlRiYpXOUvv?=
 =?us-ascii?Q?NZQYx7PhNpWjKUrDjon/bE6ehOq7zi0PGDJN/XA9sJEhPWHNKSJlgfIIObrd?=
 =?us-ascii?Q?zWwo5swk75RbbfIOPUbS5x2H0L1KUAcvVjv4lWf8XVnpVy6TasPJh9N43UU3?=
 =?us-ascii?Q?c+54U8iz1ah6isr750ds8AxAD2ySS22LD1Fsr4tVSvIIa3znV/gCCau1n0Ci?=
 =?us-ascii?Q?acsutb2ipi3t4WCCY9RxBRWHhD1SICjpucISGv1fy/ZuVquOHAhIRTpNxlKy?=
 =?us-ascii?Q?KwPB7+ta5GneNbqPVuUoh3Hm7PoqQ5ZmEpBG/DtGMKvqvsCuQhpwOa6NexEj?=
 =?us-ascii?Q?UMIHcon0BI8cf+8ESQ+ZzdPKNnxg472dUqBnmYrHfJRE7YFML8M1B5/n+Xek?=
 =?us-ascii?Q?Wbg2TzHK6EAngyVHG1EpcsuEOVEfWuxtVhqX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:44:35.1511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcdc654-2c06-4b42-4a2c-08dd67e7a488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093

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


