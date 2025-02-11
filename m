Return-Path: <linux-rdma+bounces-7659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728FA319E2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F1D3A8D02
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BB26B973;
	Tue, 11 Feb 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t/Wamwli"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38B26A0FE;
	Tue, 11 Feb 2025 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317761; cv=fail; b=fJFdmA2jf4u1VtnzgK6iMryzWew2mvfVCKE9Wxu4G8IdCJ6jarrzOu9e9cMq4rVAWXXHuI8Qn5zQtZ2WyOG5qedjP3heOlsfB0w7sSbdjkot/fzP+axYyzxodredkz/PKKNPFpknNLQ5gAPYTrMZLUajbTzGyvOOs+LPykVJf9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317761; c=relaxed/simple;
	bh=zWxLyJYUytqR3M/H/4OTZ5sjFpKUaQ77Yo4La5KWvVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8gNqx9GH6eihRShHHgDvGVbaDrXyUgLsHhm2spIViXxaTWepsmvpZtMIuY9uDcROu2Z6/eJ/IcsbuAj6amkw5EwA3/ejz80IWKPR/Nbeha7cPQjc7BxJ+qS/jtYwhNCi2VWcIwApgNz6ULeD2+SZRkIJQjf1lEcEAx+U6BZJ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t/Wamwli; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elKafnlvnJFnj6HmLFae4jaAk7RiYwyuZvGufdNfupCmafEUPk0upLabwNrwCSgMHGdRtEmqZece7XAPCaZ+n8Ghyd8G/cuCnHNyPZ8KvA+Ho1z16mME2iWuHf8Ph8ULduWqtYMa8CmP1TvtcKuNSwsEzZcXxBziypAwztwpf5A4KW39aQz8UTWceAoHJ0zp80NjbwhZGocSoRQ2MjBgHARKuLhFaP279jC6RCukcfDSnszmKyGbE6oML3os2oXTG74P3CQDrKAxB2yLxoFp2bz0PQHH3+b5Dy3g44X595fy1SLzHRtD+3VaBD2Fi+X/87mNRZ/bFHJ9GPlFIQBHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k04YJA2JUTVGcQjyKQ5DjFgaK6vRSQ/rTLaSQBc7S5E=;
 b=l+UMhO9g1ebEiO+cZCtaERNEM/EGJALUyQKQ2EHpyjd5WQreKm5fE4+2kxvMr4wPSOywWBNZKV90my25vFBZWkuFtBr238KFvr4PISv55bwuVP1E5sNAbVIWHUZHQeGENqiYpj9pMQaNXs/szZFMHvq/QkLEMH6Q7yZhzuTM9lJsjixAxL1oUZqR8pbzjV3mxNFYYO77xrgNN3Lc1EqIhEmU7GGZcDgN1WpeDd3mae+HlElCbMnmSprnkciAHgqkQbNeOqFtFnbt1Yn6Bv9H6zbunjqObWHJXykHsiSYfcvrqWskMlrfks2Da2LbtUF+vRlI73KfJaufH3kJMwfAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k04YJA2JUTVGcQjyKQ5DjFgaK6vRSQ/rTLaSQBc7S5E=;
 b=t/WamwlivPu5O8ER6pO49f+CzeeGB4YdZDOSZPZCPlbs5ilreINkm18pQiKYWqPhkE1s94koaBwmD0NHs48XWCm2hVbh+3Waa1GhYzoznvR7vffft2OvLmBllRFBpOwDuJGHFQSf3PZGHfPhXme6p1Myne+FGd18Qb2/tTF7pnE=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 23:49:15 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::fd) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 23:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 23:49:14 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:12 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <saeedm@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
Date: Tue, 11 Feb 2025 15:48:51 -0800
Message-ID: <20250211234854.52277-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211234854.52277-1-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: b92390fa-02cf-44de-c44c-08dd4af6b0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSntjaCUidlUXmipUoB13Z7/zC8hqbHMAIMnpBDPZh8yf3xMCf78YS7hj+U6?=
 =?us-ascii?Q?dGnwYlZmHgtAIC8d9d1bexWU2vms0oIyxQBRuy9owF9ijn6TLQpdiFzCPW7D?=
 =?us-ascii?Q?V09ef1L4P+ZmDUJsm0HpkbvcKdh1HmDNelQWRAXRUeNGKsVKD/hc+bjceQmB?=
 =?us-ascii?Q?XFXyFzMrRHafqMkb6L4oTvp3v4w6yPJ4jKYHNJPvVNeKaOF7Yw5BnSs2bBYL?=
 =?us-ascii?Q?pBO0RjGB7maTZpoZHpnjlYw4d5Jl8gWxda1ecHf7RVI7Kt4xfcxBI9QM3lDK?=
 =?us-ascii?Q?RspeN1zI/xBs/bHM9ZOLN9C/deKuI6jc4rSoCwZkUvPciHrw1gETolNgCTzP?=
 =?us-ascii?Q?aBwehhKJ/zi4FfabJZzmc1trFQvpA5X/zJZs9FnvuuMhEwopjSzpS++TGwRD?=
 =?us-ascii?Q?nYXs3cKM5Bdpsbtz5H+CMPHzhVR8dHLRmw+H/vl2hkqWfhLYpQkhii6hkEZx?=
 =?us-ascii?Q?RaGG3tRxYTbUSs2WROnhNRLwO2+/TJ8tKf2rncvGmTkYwk9ADp/2tWaeNp/j?=
 =?us-ascii?Q?0VxzUsFAMrrwa0LRBI9HceqPnJCtw6V+vIDmF2Mc/70uVJM0XHVt4AoQrkPh?=
 =?us-ascii?Q?vOFbHghxP8R4/+DVNEBl5OII5SSGCRlaoT5WUo7y7HX9J73+hgmKM4ug9wZj?=
 =?us-ascii?Q?OW90p9xvFrQyyMHKBHtW/yiSeOxqRPo3MrR6ncUQgtCp06Ueugp5sUaQd/Gh?=
 =?us-ascii?Q?47x9IeQveT6ZZTW6tX/7C8U2iRvwTdUCDSMgz9PpGOWgC34QLoFjVV6aAKM9?=
 =?us-ascii?Q?J89JBZzVPVsoz1FbFsMMm6w2PvoRUGUp879oaZV13upOBxt1d4VV//LuefA/?=
 =?us-ascii?Q?n+yfxMKKqnkZct+whnqFc/PVzWMcf/uDCZwuHmkESvnUS7q8MgZBA11gU8WV?=
 =?us-ascii?Q?77zOVRhpY9NrwMp5JvV1JwXYfEr2VF97kuvrrwGRlVg0JZ5Pe47K08lshprV?=
 =?us-ascii?Q?L1ToggFu8iPAwjiDAm2dtaq0Ts3E8Lxzj6eBAmn2uMyrgDxqgF2X6vT/EJO+?=
 =?us-ascii?Q?NKD4oRQ93jbW427WBBgcq98k56oKw/An/GLObRc9JfFTZRHX5U3MBVvCcwzN?=
 =?us-ascii?Q?oaXt1u5MkmJsCl1OsLoyDktoMEAEE8VAooeamVxD5iIPLeJKxbFTY9MZP66K?=
 =?us-ascii?Q?FuXisfoKE4k+JQGi0S3/UFZReg3c4eaM/nz+wSsbDBU3DVNjIMYEPBeF8u8v?=
 =?us-ascii?Q?bLwLnQQeF/YzBv2qqbechwAiFKo5Z1zdAQGaN0j7FiYmS1JOh2wejKB5iifU?=
 =?us-ascii?Q?23mHvmmjLv0ksl03naRtWp/cY1NVpia34zoPOaCG+19hiBC+EdmqlJvOjn7k?=
 =?us-ascii?Q?AhYTckGXiUdGhqQ6S4aRUxsVjVEx3uWy63NiS+MnY9R/c4EV1gjYMCUHYR3U?=
 =?us-ascii?Q?67Utk8EySpf1r+W2BKZij1hP+Z5JZdujfukEEtnauVJER0Vej0953h+J1Hxw?=
 =?us-ascii?Q?2BXb/wrzDcOJfsJpPOAUr/cn7ydciO+3jIrsKdbDHhaZbc+nT6ScPEjJIvQa?=
 =?us-ascii?Q?VGt1tohrKPZL1rENAxMy/x/Z6W4dJ+4elfNd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:49:14.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92390fa-02cf-44de-c44c-08dd4af6b0fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548

Add support for a new fwctl-based auxiliary_device for creating a
channel for fwctl support into the AMD/Pensando DSC.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
 drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
 drivers/net/ethernet/amd/pds_core/core.h   |  1 +
 drivers/net/ethernet/amd/pds_core/main.c   | 10 ++++++++++
 include/linux/pds/pds_common.h             |  2 ++
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 0a3035adda52..857697ae1e4b 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -229,8 +229,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
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
index 065031dd5af6..218bb9c4c780 100644
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
index a3a68889137b..7f20c3f5f349 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -265,6 +265,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 
 	mutex_unlock(&pdsc->config_lock);
 
+	err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
+	if (err)
+		goto err_out_teardown;
+
 	dl = priv_to_devlink(pdsc);
 	devl_lock(dl);
 	err = devl_params_register(dl, pdsc_dl_params,
@@ -427,6 +431,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		 * shut themselves down.
 		 */
 		pdsc_sriov_configure(pdev, 0);
+		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
 		if (pdsc->wq)
@@ -485,6 +490,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 		if (!IS_ERR(pf))
 			pdsc_auxbus_dev_del(pdsc, pf,
 					    &pf->vfs[pdsc->vf_id].padev);
+	} else {
+		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 	}
 
 	pdsc_unmap_bars(pdsc);
@@ -531,6 +538,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
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


