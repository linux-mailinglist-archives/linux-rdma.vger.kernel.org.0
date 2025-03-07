Return-Path: <linux-rdma+bounces-8483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB6A570DA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9694D1795EF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353D24C09D;
	Fri,  7 Mar 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oxS4dLtO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38B19DF4A;
	Fri,  7 Mar 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373643; cv=fail; b=A8P+OWRIZfEBUEuZSyZV6wwbt+N+/h6375R+5t/j5GkA2uz0bMmlCVZZBzdVQST49nxiBiV2MOnQlQMRlraJbaG9XAD+K2J9wI+gb2ZFPjGmn4WpSmGOJKLYjTP+Kl+nZi/tKaR+7/dHdAPEAplE3Yc4axGKeDcUoDKzlYMQ0Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373643; c=relaxed/simple;
	bh=HUmG5jBpYUqqnnnYaEtEgVbORElVSTlQKaNzsRbK68M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsQAcJSAnBvKhXuiyur1UzVx1Dsi3UDqL4dLK/6g70lSWLZjG5ZrZEHwI7Llo5mQ1OCsePi3aCrtYTQPdZethz0cyWQgjHIiwPuU7In2HNGqWPrRukNwHeamlJclmNo+ZIl1zZjEmsbMEtPYSUe9OThVeYpkeI8DErP5HUfa1Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oxS4dLtO; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPo9Dmch56ktbWaY4tpDA7K1F5kjCo+gPYbSp2ppzXWDf8/PLdSwpkPJWxBiQNWluYw3yK7QhqJ6hmfN4Slr8larJ6zhWxeU20x2xSUteNro4InZ3BIlfPlKpOI5jv0kovI7ehcmAG3HxtBRm7kUG0UEEHR7vZji4Fwlk8pQjND2eO8f8inHkjaJFdn/lyteiaJwFxDSVeVIPlJQEj5zMLUtNHWFti5lSTUwcOykExx0rrjQT4IlzmkTJoMdZGlHIzxZDMpQfCyU0CHEqVZIzFlfOLaTMd/Ts8nqKdNv4TkmTzIsuk96CHePmLzdqmNKWJ2j60hCpoeiJlRJsggjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDpbiwJ4sG+N9KK/7+neznSI6pdNzU1UR4wNsdxgDeM=;
 b=zEUS5QHEa466lA+05/J1h4cfJHQs9hvKNgT8Uy5E6udSFqVibWlkWDgNLvHa529UAMuAO1Vkc63vruj7vF0Gauevo5GncjDWUdZgYdohfoAhVa1ougXGNA/d065ePWgmZeY7KorjUD+xK0zPegcOvjTpRwizmXWOQn8/xgDlgMwO5mbFQY7prEkaZqD+3XAvh6OzHgREt/o4nI0MLOetm7Pi9hsr/exNOePWzk0d5MgFy36IItkShzrrSazZ/0r1lvKseFx6fG8oEgxGC7QhEq4j4S4UiHnlZh8CYRebDhLiSd0rHoPH4rSqSZNOP3uRXuISKiFVuNg24melOB13mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDpbiwJ4sG+N9KK/7+neznSI6pdNzU1UR4wNsdxgDeM=;
 b=oxS4dLtO1E0RMab9S2hOX5S5pAc1qw7iz69I6lNtQuwUdoGl17GN1XYzVJTAHZK4IE6EkSXlhdXY/j4P2NEO6vpWmdteoy5MkWvlW2UIHGc6TzUZhhlGXtCdjIg2xzY+iEip4/P9qjMNF5joKsi3YZt9OqB9G139HS7jpQOLHUg=
Received: from MN0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:52c::17)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 18:53:56 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::8) by MN0PR05CA0011.outlook.office365.com
 (2603:10b6:208:52c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.14 via Frontend Transport; Fri,
 7 Mar 2025 18:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:53:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:54 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 3/6] pds_core: add new fwctl auxiliary_device
Date: Fri, 7 Mar 2025 10:53:26 -0800
Message-ID: <20250307185329.35034-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250307185329.35034-1-shannon.nelson@amd.com>
References: <20250307185329.35034-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ee0670-6d4d-4332-ecc9-08dd5da969da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NxjjNGoS6T1Ij7bblZVBRcToah9zrsc+a2UWG4cipTBtDuEUvRmheOHyVWT8?=
 =?us-ascii?Q?cLGWOBixfNB4StoBJnDVp87f32LifEbiRlP/bI2ELOa41FLpS5VSmVwInX6b?=
 =?us-ascii?Q?kKS22sroQ+iFQeLt8yxQje5k64JfmSmXwde9ItpuAG00kU1V9idp5+PE/osF?=
 =?us-ascii?Q?4g1wVBoXyqWkefhf1SwdzjRd1qaxiQ68m97VRR3M5RZ9XmDTVcODIzc6Yo3M?=
 =?us-ascii?Q?Zk7+wUHRnaKzK/KuQJL3SdfGvFyKx/OX1p65asVBKVhYqN/Oc3NFnmPQSrNd?=
 =?us-ascii?Q?T7/TuTQ2D9QC2VB4f3WpuaHirTtK8UPqnrVuAKoLna4Rq7IfcRTXBBmT51DN?=
 =?us-ascii?Q?u5iEpl1jqRKOxjXlSOeMXm622ryzWHNs6h9K8ugzizuR5NPZirrgYaM+jZSV?=
 =?us-ascii?Q?irbqTWSjzc4LFyg5w9cmWTYa3JivAyQHtMXv9sFghW1ouLAGlb1dJF6hCGAp?=
 =?us-ascii?Q?xzJ5wImgNgFSoibcgjjUDb5WQt2tXuHft1hH9YeboovqhAgPvCkosRbOcRZN?=
 =?us-ascii?Q?S3SGzjAyGLK2V5PbsFRLcXzQjhPl8d1HMK7ZFGZBW9LSoawwHd/aHp5j2t1T?=
 =?us-ascii?Q?sZ3M7e//v3z3PddTIzKxRF4WQdI0IcjT+4Y5LVAOYrGu5ZfY0DEeK5INdRIQ?=
 =?us-ascii?Q?/szMGlCJV0gAmHJHwq+9zqRTtnrEnT1T+TMRQRTq9qJ+fFKJ2UGHnBr29Ycq?=
 =?us-ascii?Q?EMvR+stjbMUq4xSKrsdAsKwc9IeirF1d+XBxJOV0wuJXOym9nM3NKyNlz0Pg?=
 =?us-ascii?Q?0GU6vpz1SrC0c6JQfQrGonqo2RQvbCOEP/j2V1cbwjIcYVtzas5lsD+VQ8pW?=
 =?us-ascii?Q?5Ba1DbexahAcJ/SJI5zVxDQ961DM2uNdR5AbM42P3KLHTWx/ZWrtg5qxUehC?=
 =?us-ascii?Q?WKafyomhGGV4lCZsGKV2Xn3hpq6YItApoea0qGCjwNRxLZgJkJwhFvKBPgFi?=
 =?us-ascii?Q?qDoBoTWOSYJ/2REC+WMIv0ZGGgvbemh00KuHzp+DKJ3TijlOzhTJGuYIgbup?=
 =?us-ascii?Q?4soT3oW0l/EAKodyGVvtATh14miUQIyrT0DoiFfliCXmaTW9qnzOj9FioCpW?=
 =?us-ascii?Q?iOjRxGJRxy7QpjserMh374HRdXw4Fyd28Ik5FOuAfdO+5qDsYjxnRmyGV1Dy?=
 =?us-ascii?Q?3QqcSYkR0BrhEMgbbxFlKj+GsgNeoM9VAwST1UN3rMrTR6hEOkfj7WME4vOX?=
 =?us-ascii?Q?fgeBimTpj4Q5OrT5aS7wXzcthSMmhWR0TxYFQMXFyQcNDhQfXUpLxhk4TQWr?=
 =?us-ascii?Q?QbiohKsXXNEkpGqieaEGEIOTb9Lq11Q7s/B4FDAs+NVsnu/qNzaKcnv4uZFG?=
 =?us-ascii?Q?ZiaKge8v5Ab28FBgLqneOudwOFxxYq2wxm5+wMCyma+BGcMTFblLbcpN1kbU?=
 =?us-ascii?Q?0ijFOLTncioVuijwMnI+hxtPxlqk551G27E83de77R5RqoR40G4Ve5vD7Yuq?=
 =?us-ascii?Q?KS4t1fZENA7EkRLA9Hv0/frxohMHFB8Q411d+JwJUhkiPJyMWzIY7TtYTLw0?=
 =?us-ascii?Q?vG72HRQxvWvgVckotQbfhY4ZNpUv+fiJWFTy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:56.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ee0670-6d4d-4332-ecc9-08dd5da969da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677

Add support for a new fwctl-based auxiliary_device for creating a
channel for fwctl support into the AMD/Pensando DSC.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c |  4 ++--
 drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
 drivers/net/ethernet/amd/pds_core/core.h   |  1 +
 drivers/net/ethernet/amd/pds_core/main.c   | 14 +++++++++++++-
 include/linux/pds/pds_common.h             |  2 ++
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 563de9e7ce0a..c9aeb56e8174 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -224,8 +224,8 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
 	}
 
 	/* Verify that the type is supported and enabled.  It is not
-	 * an error if there is no auxbus device support for this
-	 * VF, it just means something else needs to happen with it.
+	 * an error if the firmware doesn't support the feature, we
+	 * just won't set up an auxiliary_device for it.
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


