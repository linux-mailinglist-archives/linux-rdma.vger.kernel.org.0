Return-Path: <linux-rdma+bounces-8849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E411CA69AED
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 22:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65438462904
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29B21B8E7;
	Wed, 19 Mar 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eehW4pXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE8158538;
	Wed, 19 Mar 2025 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419986; cv=fail; b=Zfipc7ayCSaiUaWUDSOGqFNZjuf5AGPtncFt+H9lZUOlKtsbDQNfoUAwR3sNwJkDkKJHStK3aD6jDL1bfdeGK2zjCu5lwnzCe+oINOOeUWXG+5eCRL116zK2/7HDcGQSa9IwPo/44ovG3GOz4dw9aMIV+0iL/Y2hR5ZEBVHFwyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419986; c=relaxed/simple;
	bh=XrinpZ7brHowkz2zlp4plByre6rAXB0huImZjJHlpP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n43mO4pJgKWCRwfzDXjhRHCzP+Mdm+Op7pzS6Ycle14RKIAA/l2HPvzWOQDml7oQMXM6i5DEg0y+QXjvqYlPutXGxwfHglqnMgXG0TakbtpMuwnFq8+gLYzDLinoLVVKjFTgANp54PuQI6jRH09BHa+LfSDIX5taXt89O3c/uEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eehW4pXI; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiccVvHsQPcmPKi4+WHxexpvFFZMAIg/lh7ws+baEyqZlCRLrdhGOvDZIIE0imeMDyTViMWZdTGWUdjZ0j6T9ZPoDUnqwhm1PX3gxLCK+JMST/NmI586OgvlElnJRBGKnQBiB/QKhueo04jKQKCiYPPCj+rCNBllRuBQoVWXGX8w09/tPxkN6lTvCPO4D77kit1dxj2SO3L1euBD0XA0wTjHjzoA/SVTnyCu/6sNxeQQaaCTN7amjFnq0JridSSvRUPqQXSLPUr2H+heiwrIFZTnfVqAJTmwX2n3G8kMyTc59QgFSdpweMnQuS/Nz9S1CvkRL/JhrN4xSEPN3Qfz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnRRu19yhsWwwteAaz18hb2Kxe9GT2EwCoHgOwAKBuM=;
 b=L5dSoeyp8tCv0lR/RRecoZt92DyXGeUUc6GO0QjS7GXb71HzuQNkhRkvbh/84dVvys7bR1y0Z7zx0B5t4eGFA0UIKajOMU4lczJbznOwVx65yrA/61PxSyPL2xEiyUTmi5nCzRHZT01uww2W1hQAbWJ+ma2SyXdj1eq1KZlagwKp4zCJrqB4PUh0MguM2ZH4UwgxTDpqRRBBMN69rg5vyd93gpYDms6gdIX4lkVOu64A/A2rZnylHTadInbWM7nQeGSbqyC0i31d+MpQU98UnSKJCByetzqOSrU1D7y/j5n11K53sigKZjFmdOiDmTDj9Iix7ZYdB7QAurGTCHK31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnRRu19yhsWwwteAaz18hb2Kxe9GT2EwCoHgOwAKBuM=;
 b=eehW4pXIK670HXHMkapZE97/UHxaduRZY9E3fzoW7+XoMvB9YU9EhTSks9OBFE6diOaDI/75X+W1KW+nn32eRZrHACqvncBH2MfDnJR2Jq6s6M+UVsp3JBtf9oZtcXppWQ0rovES9iOdDmSz01IeGW4pqe5Kq1aYxCiX4vrnCRw=
Received: from PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::10)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 21:32:57 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::f7) by PH0P220CA0027.outlook.office365.com
 (2603:10b6:510:d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 21:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 21:32:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 16:32:54 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 2/6] pds_core: specify auxiliary_device to be created
Date: Wed, 19 Mar 2025 14:32:33 -0700
Message-ID: <20250319213237.63463-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: b41d25b7-4023-4bd8-26bb-08dd672d9da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GxFrruzy6eFTjTZ1p3FMiMtVm08pFAVB2is0ihJguzfDZGfXc2C5MUidnXix?=
 =?us-ascii?Q?nF2JhdrDbWPuWzzSEnog9A0RPV7+1rj7idjhW/CBRYg7LpeHgwEKd1/P+4yr?=
 =?us-ascii?Q?rxyGZZ4ZU9mZNCowFRL8aInjEmzESORp/uDzPWhrxv2Xz4Lk60v3o5ws7AyG?=
 =?us-ascii?Q?aoYA1QK8fZ3MivaqoFsfkAABaNBSFA4b2pe/flMRpX09SebYmfw1Z0FZlC0E?=
 =?us-ascii?Q?5TmXXS09mCvFq7yYS26UmBooP+bgYby2WpUkDdXdL7agEXDxTnuPLa58N+xX?=
 =?us-ascii?Q?MxP2m0NNGsvRggOgZO03wB+82Of5wpc4os10v8FUvW3doviHzABrm6q4r3xu?=
 =?us-ascii?Q?i6MgAIK7064tT663hUjdmNJpb1H0/lKpSvUD4QDZKeHU2UCznY2MeUZ45RB1?=
 =?us-ascii?Q?8r3fCjKv+xXpe+22H7bBD8M/KyFqWluUqBusjZ8AXW3Fr860NU5WSBKLPGsx?=
 =?us-ascii?Q?x6JZo35yhLCPCm3Tjri/GGM5VEah4i8SXDjYbldKi8ZPIovuu1yaJQIC7AIk?=
 =?us-ascii?Q?rLP1EYaT+CPqTBMmzxL8WzFeeAL+xtQxvVxnNVaxTeZbsKzcQnD55XJkdip8?=
 =?us-ascii?Q?Opw/DJlKKqyLMRk0IDLJMCRZiuJdSh/E7N91d57ZVz3oidxw3mkuYmaxS2Ff?=
 =?us-ascii?Q?Wxjtf3jB4wyBl+O8FWtWErl2QiZX0Sq2YFWT/B8/ZXQxUXFtQExVYm6/vLE2?=
 =?us-ascii?Q?9Nleq4r5JPGpPRHU+8hAgtNF9lQO4uyKfvtcjqVsEGL0LpvPLwZiGU3gUBbO?=
 =?us-ascii?Q?yZT8sGvikS5/IYpPiV70OPefoo0MZSXNLkHQwRCWuLaIeV8sDxQcUCvZxSdQ?=
 =?us-ascii?Q?BfQvFVjxy+heBFrUe1jlLLkuTFRiFGSnTxerDqP/iwPRU03BeidlYuIFgCZN?=
 =?us-ascii?Q?F3dTpnGbhyopmXMJ3t2LjQs1dwaFvWmuKYddnXvYq8fBAzGA42TDhbBfYwjq?=
 =?us-ascii?Q?O3g+8TpBTN4qdnTIqhLvjZcSSoFT0YWqywqqhmPWckjPzr199B5/cRdAI8zB?=
 =?us-ascii?Q?aLzED/LIPtsut+ADlbKUHIVkAiMEAtWSh38SCru7GDzV6M8OpdfBxx5IjH0Q?=
 =?us-ascii?Q?RaU4X1cMgk4ZPf4r+ZWybc0WZeYRo3lwrvJ0n0bBWcWCJdY70NyYOeebkPqa?=
 =?us-ascii?Q?3CMu13ZElc/69m6+WyphJ1+ElDFCK52gDqYdEMNdMGCnVU4QQa2TagEodBSF?=
 =?us-ascii?Q?ue2rpnV7kYgZPSlDdYzrgA8FUQbS83sMNtIdY0VHj6fFBBZndKi9P/ECBSvT?=
 =?us-ascii?Q?srFtuZAih70RDBLEe4B8NRRXrfy5W/17hGadJKJ90/HFQTpRC821hnr1ID/E?=
 =?us-ascii?Q?dxjGD88ezJL/DtwIB75GSd5S31pXzJLId/TwvXQdIExxdusl6R+V+svzS0eX?=
 =?us-ascii?Q?WmVwYgCVINCrvDNboVZIxGPMFR4ib2bUgJjPTHBYMF+xYdZ6jguw5ao4ONQl?=
 =?us-ascii?Q?f+Wqvdhp1UjlPERtcHziXSnhQsBk+DuJdtFIkg0k3eU9uVzKu6zAKoRm3o0C?=
 =?us-ascii?Q?r4TFFd3NM+Fupyo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 21:32:57.0976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d25b7-4023-4bd8-26bb-08dd672d9da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337

In preparation for adding a new auxiliary_device for the PF,
make the vif type an argument to pdsc_auxbus_dev_add().  Pass in
the address of the padev pointer so that the caller can specify
where to save it and keep the mutex usage within the function.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c  | 37 ++++++++++-----------
 drivers/net/ethernet/amd/pds_core/core.h    |  7 ++--
 drivers/net/ethernet/amd/pds_core/devlink.c |  5 +--
 drivers/net/ethernet/amd/pds_core/main.c    | 11 +++---
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 78fba368e797..563de9e7ce0a 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -175,29 +175,32 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	return padev;
 }
 
-void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
+void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
+			 struct pds_auxiliary_dev **pd_ptr)
 {
 	struct pds_auxiliary_dev *padev;
 
+	if (!*pd_ptr)
+		return;
+
 	mutex_lock(&pf->config_lock);
 
-	padev = pf->vfs[cf->vf_id].padev;
-	if (padev) {
-		pds_client_unregister(pf, padev->client_id);
-		auxiliary_device_delete(&padev->aux_dev);
-		auxiliary_device_uninit(&padev->aux_dev);
-		padev->client_id = 0;
-	}
-	pf->vfs[cf->vf_id].padev = NULL;
+	padev = *pd_ptr;
+	pds_client_unregister(pf, padev->client_id);
+	auxiliary_device_delete(&padev->aux_dev);
+	auxiliary_device_uninit(&padev->aux_dev);
+	padev->client_id = 0;
+	*pd_ptr = NULL;
 
 	mutex_unlock(&pf->config_lock);
 }
 
-int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
+int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
+			enum pds_core_vif_types vt,
+			struct pds_auxiliary_dev **pd_ptr)
 {
 	struct pds_auxiliary_dev *padev;
 	char devname[PDS_DEVNAME_LEN];
-	enum pds_core_vif_types vt;
 	unsigned long mask;
 	u16 vt_support;
 	int client_id;
@@ -206,6 +209,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 	if (!cf)
 		return -ENODEV;
 
+	if (vt >= PDS_DEV_TYPE_MAX)
+		return -EINVAL;
+
 	mutex_lock(&pf->config_lock);
 
 	mask = BIT_ULL(PDSC_S_FW_DEAD) |
@@ -217,17 +223,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 		goto out_unlock;
 	}
 
-	/* We only support vDPA so far, so it is the only one to
-	 * be verified that it is available in the Core device and
-	 * enabled in the devlink param.  In the future this might
-	 * become a loop for several VIF types.
-	 */
-
 	/* Verify that the type is supported and enabled.  It is not
 	 * an error if there is no auxbus device support for this
 	 * VF, it just means something else needs to happen with it.
 	 */
-	vt = PDS_DEV_TYPE_VDPA;
 	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
 	if (!(vt_support &&
 	      pf->viftype_status[vt].supported &&
@@ -253,7 +252,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 		err = PTR_ERR(padev);
 		goto out_unlock;
 	}
-	pf->vfs[cf->vf_id].padev = padev;
+	*pd_ptr = padev;
 
 out_unlock:
 	mutex_unlock(&pf->config_lock);
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 631a59cfdd7e..f075e68c64db 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
 int pdsc_register_notify(struct notifier_block *nb);
 void pdsc_unregister_notify(struct notifier_block *nb);
 void pdsc_notify(unsigned long event, void *data);
-int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
-void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
+int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
+			enum pds_core_vif_types vt,
+			struct pds_auxiliary_dev **pd_ptr);
+void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
+			 struct pds_auxiliary_dev **pd_ptr);
 
 void pdsc_process_adminq(struct pdsc_qcq *qcq);
 void pdsc_work_thread(struct work_struct *work);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 4e2b92ddef6f..c5c787df61a4 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -57,9 +57,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 		struct pdsc *vf = pdsc->vfs[vf_id].vf;
 
 		if (ctx->val.vbool)
-			err = pdsc_auxbus_dev_add(vf, pdsc);
+			err = pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
+						  &pdsc->vfs[vf_id].padev);
 		else
-			pdsc_auxbus_dev_del(vf, pdsc);
+			pdsc_auxbus_dev_del(vf, pdsc, &pdsc->vfs[vf_id].padev);
 	}
 
 	return err;
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 660268ff9562..a3a68889137b 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -190,7 +190,8 @@ static int pdsc_init_vf(struct pdsc *vf)
 	devl_unlock(dl);
 
 	pf->vfs[vf->vf_id].vf = vf;
-	err = pdsc_auxbus_dev_add(vf, pf);
+	err = pdsc_auxbus_dev_add(vf, pf, PDS_DEV_TYPE_VDPA,
+				  &pf->vfs[vf->vf_id].padev);
 	if (err) {
 		devl_lock(dl);
 		devl_unregister(dl);
@@ -417,7 +418,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf)) {
-			pdsc_auxbus_dev_del(pdsc, pf);
+			pdsc_auxbus_dev_del(pdsc, pf, &pf->vfs[pdsc->vf_id].padev);
 			pf->vfs[pdsc->vf_id].vf = NULL;
 		}
 	} else {
@@ -482,7 +483,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf))
-			pdsc_auxbus_dev_del(pdsc, pf);
+			pdsc_auxbus_dev_del(pdsc, pf,
+					    &pf->vfs[pdsc->vf_id].padev);
 	}
 
 	pdsc_unmap_bars(pdsc);
@@ -527,7 +529,8 @@ static void pdsc_reset_done(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf))
-			pdsc_auxbus_dev_add(pdsc, pf);
+			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
+					    &pf->vfs[pdsc->vf_id].padev);
 	}
 }
 
-- 
2.17.1


