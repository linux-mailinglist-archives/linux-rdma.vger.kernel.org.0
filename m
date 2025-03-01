Return-Path: <linux-rdma+bounces-8218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B56EA4A77F
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2ED189C899
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7041531E3;
	Sat,  1 Mar 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9hvHAPR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98E14F117;
	Sat,  1 Mar 2025 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793033; cv=fail; b=kRfJtMAhrFOmJgz2AYNYCbtaGtQPy/4Du31H2BQzft/oCcnd4Y6L1Gdi3GcbAdOwFo1ijwn+9KPgtmzffFM5RLlAx24rydYBRNdVE4CN0qrU4oRTI0R6X7e7QscSWAy51SftlQwHM5Esud5ppmbLXE37eOnmxZvuZ1CPFn/9BR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793033; c=relaxed/simple;
	bh=KqwarlUW7CLTDrhukmLJQujh8LLiTyO2N6CpUqNFfjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1DDkpWZFSB7bNLwB9+LHlrlzTwMSI9xavSNSXQLUXbBvYgI3KrwOxjMSc1w77xKngcISztxU4JCKXQckgvN770KVyu5fR2UXHcrC3tGVUlUS5BoppQPWQqDBiBvFV0zSWB110hVDSaJS1YnyXZJ/4X3OTK+tSChZQBtLEVrPRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9hvHAPR; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GM/XNFVv3Hwsq7/zHyqx6KCrYpqItME1yC2yyz3nAQ2O1ETvnbCJZ9QBuDK3OLGPKxfDj+Q1dCCyT0rs5B7DBGsunTh0efb0j+5WvJ3ncRLXoK6kjXWhnWWzUc/cmZs+8lt00kWt/+Axg0MeoY7PrzL6WJcdtUhEza8k//b+LPg1CJWXAU9sriDoGR0NDP031B+srW7tXgsDPS2K5FVVRW3th82E5FM+V9QXvWKQX6PyERBCS16+uVsA8BBVGsn9H94MMPDQZGoqNOOZthDZGcNvg04AW1yOcMVLJDVQ1mhjTq4C+wubxJLU/k6Yz+NFiHtDc2pKekX9cxlHL5edXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0aM42oLwKje/OoZGBOrj1A0HKwfxHx6V3QxAhkvm4c=;
 b=p52PXABo/ApGIHwK1ejOjfZOSkbdSQIwopQTRN7wbl4Jdmo88muhUnS+ORcFMYC7hahUvh7ha9nM77+rJYUXJT0SzLMstHEeb8NvRG+gGwmbT0F7OrW0lK3gmUocJs7c4LoXZvOuYDoiH9PJmkSJVhn0EpSWP78sj9NBsnhil/H0BZ55z8SCedbEE+0MU2f/8szV55TTgD6fAqvnFfzlZarebiJQXDamVk3paw7UjpCyHZlSvpbHW9XnpGjNRoWBQnwIsPQebQrp+yEwIbLdhnCwZKX+D8/G9NGs425OJNuimTYtR/3ksOb2wZhUdgx6c1mvozS5nLf94XAFj/rLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0aM42oLwKje/OoZGBOrj1A0HKwfxHx6V3QxAhkvm4c=;
 b=Y9hvHAPRvc+01zN2nwEd6HbaEBXDAXozBfET4ubiWgIROL5DttgwTcjcfPDn71iVaovNmzxvm5DdoEO0C4tT86QgBm4qWsljEygwY2urc8hGVbD8BFnCfQNUR3JzuOe0lCz0L/n4DYFCuNaynUov2EmYXm02qdYs1egHPIrhwtY=
Received: from BYAPR06CA0014.namprd06.prod.outlook.com (2603:10b6:a03:d4::27)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sat, 1 Mar
 2025 01:37:06 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::a5) by BYAPR06CA0014.outlook.office365.com
 (2603:10b6:a03:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Sat,
 1 Mar 2025 01:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:06 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:37:02 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 3/6] pds_core: add new fwctl auxiliary_device
Date: Fri, 28 Feb 2025 17:35:51 -0800
Message-ID: <20250301013554.49511-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250301013554.49511-1-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e160bc-234e-45ec-80fc-08dd5861934a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbbbNlNpW0WuYFxZIBGqvxWOyOBk4Ma97P4QFKxPg41T3SJvJ97JW1bV79Tl?=
 =?us-ascii?Q?f++CCxIbSWhoJ6SZWm+bsHl5HijbrkqjOxDJJ9VtTWcDvMNZybHcw/h5FnSO?=
 =?us-ascii?Q?RyDjlCjSZfAQSAGM+C7fSaol7hRFRuPijz+Xs6D9toe0acpNTKhFXI2iTuwS?=
 =?us-ascii?Q?6uoeKpNyqMLCADBEppF57rIEW7VXoGQHvkHb+KVbZAjvJqb4pmLv/Gjpqmmz?=
 =?us-ascii?Q?56FhLbXL4qjL34j47L5sMsGIhW+ZW4ef26Q53tP9XyB2UplQqRSb6y1aljV7?=
 =?us-ascii?Q?RRRNbE5B1gDzytH4xncEOrGlMA6A41RlvXNHHCF35nzIS8d3w1DrOc8vZK+q?=
 =?us-ascii?Q?GeWVSjKllNgU4AC16ywPATvh770RGfKngKbsKtqtxYW66Qdpe6NuVx/ASuNG?=
 =?us-ascii?Q?gjnUSjU8DkaXC0S7hruLcJe10jpquvBPDWfw/sBWatpP2fS4ljqHcCuCj/XI?=
 =?us-ascii?Q?D0RS/gLUw4ih1fNwvrBUQlnRhzVCU9qVc3Q7zUh70NWGgfStp7evgYngY5os?=
 =?us-ascii?Q?LGQmx1bhaK6XvZ0di4f7Q44LtpqdUhnXsHXoJ+Lg9UDv4Zs1Aqi5vcXoVxpk?=
 =?us-ascii?Q?W9Cow8X3r9LuhDUkJttvmXye4w/l2fZ9O2s96ts2yqILPctgGBHnrV1t4wyi?=
 =?us-ascii?Q?7/Wd+9fJN6iy3jXqUo9xxelfhQe8BV3Ly4Ss+bJNo2uZ4hhqZwiFd6/hzO1q?=
 =?us-ascii?Q?R3jkrTu9imR7j235o+Kqt0S9ZgjDDZssEP52MDzMB7zw/S0MVgdMDnMpUB3C?=
 =?us-ascii?Q?au7zPI7UHq9V1/P8Y3t15WwlWCMeQjb9U6nCFHi+VHkEdPe7UUlTHr0D6WTj?=
 =?us-ascii?Q?x2a5M/7gVDIPXQqtpfqIKclmUYMAJwt0Ym+uTFPOsgCp9fHVnukQ5ucwyh63?=
 =?us-ascii?Q?qO0y5+nG62Ml/2lCifMNZ9LWbBPKaW/izoQELUtC3kkOSz61V9HijYJnOLRR?=
 =?us-ascii?Q?1jN1w4dgKnPrQkZBCyv9nsGeAip4AXAXMBMyY+tak6WIUq67ppSDrXkdJX7z?=
 =?us-ascii?Q?O/xdpQQZGlPPhli2QhXd2sdC7IDWjcFQ88Y7uGQ1cwEEx9V+XCGCE7tccOJM?=
 =?us-ascii?Q?Y6ZWBuYLkhvY0qrHJyCgTxtpygDJbyQnkNjrczCMXBCLz79zI7HBCz/9BX/8?=
 =?us-ascii?Q?gVLC+6+bya83Q3Wq/Y/LS5xB6H2DHenp55gUkgb6C/6w2saTCs0bQzldK8/C?=
 =?us-ascii?Q?/5jFjsQioi0ZaY96bQ5eVgTzzhca7xoqA2MPRcVDLeGw7jWNt27d8We3/wtM?=
 =?us-ascii?Q?uQQALcdXTGKGKSjZHiHIckdRwZL76qmQsgY42W9eEcK55BQOm7qgPz6KscmK?=
 =?us-ascii?Q?HDsDQmwMDCZrO6wDSrhq/TmJKpqZvvBI6lEtm1psboo5MVPkLQ+H1gGUoSDS?=
 =?us-ascii?Q?55g2GQ0gRXAfylozQMqTB3gVW/e1LYnAcC1heuegotWCK8jmKQH68mGPiON6?=
 =?us-ascii?Q?xOaZfGgTiGPfgK6LPbiNj9AtrlmkHTzIWTdn99olStQEinnnmilcnh5Yk0YG?=
 =?us-ascii?Q?L/iM+CrzfxW3u42eMgn+gT6TZlg6efvMdmfg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:06.0965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e160bc-234e-45ec-80fc-08dd5861934a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949

Add support for a new fwctl-based auxiliary_device for creating a
channel for fwctl support into the AMD/Pensando DSC.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
 drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
 drivers/net/ethernet/amd/pds_core/core.h   |  1 +
 drivers/net/ethernet/amd/pds_core/main.c   | 11 +++++++++++
 include/linux/pds/pds_common.h             |  2 ++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index db950a9c9d30..ac6f76c161f2 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -225,8 +225,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
 	}
 
 	/* Verify that the type is supported and enabled.  It is not
-	 * an error if there is no auxbus device support for this
-	 * VF, it just means something else needs to happen with it.
+	 * an error if there is no auxbus device support.
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
index a3a68889137b..41575c7a148d 100644
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
@@ -297,6 +301,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	devlink_params_unregister(dl, pdsc_dl_params,
 				  ARRAY_SIZE(pdsc_dl_params));
 err_out_stop:
+	pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 	pdsc_stop(pdsc);
 err_out_teardown:
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
@@ -427,6 +432,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		 * shut themselves down.
 		 */
 		pdsc_sriov_configure(pdev, 0);
+		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
 		if (pdsc->wq)
@@ -485,6 +491,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 		if (!IS_ERR(pf))
 			pdsc_auxbus_dev_del(pdsc, pf,
 					    &pf->vfs[pdsc->vf_id].padev);
+	} else {
+		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 	}
 
 	pdsc_unmap_bars(pdsc);
@@ -531,6 +539,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
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


