Return-Path: <linux-rdma+bounces-8217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17691A4A77E
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B4816E5CB
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898E13DBB1;
	Sat,  1 Mar 2025 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iFfbl4uj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350253EA83;
	Sat,  1 Mar 2025 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793030; cv=fail; b=SqxEe5XH/qGbKDOx4m6gaxQJMHdgivEbK23kkEqlapeCgzkUNRe3gxpKh9kDgHVAmHYW2wb80hxFEfQhCBVFdY48Z9b+tfwa97ZXKzF57e3fHQlnuk7AbH1oNoL2o+5RJMDeLMH/ATnWumCi4tvdIvpMbj2dhq/ZKpbZYHr57PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793030; c=relaxed/simple;
	bh=kPcqmdqYVZiHfGRts1Jq0/rtxjzGObBRWganL6IYEic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8nLxTf9Br0WWQHtDwX1RHeUeRaysEUFaJqE4zaib2wH2UiKllr9gvNP5U6b4B4K9fOWGpBp7suIv1aWtnljZWQq/b0VfqpOvqwcBY6LKUYVVQmg5cUqzu3Y+3n8dFra9La0FpPv4EDjiNLkRM4S0IhjZqgPLvv0o7QPR9l3gLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iFfbl4uj; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciq7omZZBUKV8zwmT78i6Eqp6AvCH5rNFDJXTvWY+TAIAKLpmmgr3qtRHFVO+Z2PagQeCp9A/41MoczNuPOWutOGbzGNkfqBvCadaEXlydKps4KMyZMnt/jbigOdDByeZT4YDVtlKrJTI0Gw/IU7I91M0N+91iGVp5FxVzC0lCDnFHSwE9MED52POIGdmlJgJXMmp96mqqP+6GsRpYWCoAYt6HZcy5dd90IfyH34cDNM9+9bhTUuKapjyCR5igrvbH6BUrWZWu8eBDIsfX6ywdysxLwYdKHC+RuABK9Tjd7OQgmFxefYFm0a5j3gewo/YQzCVXP1mob+XWL3XXru1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8kk36rj6OwE+deFnJBKav+O7cx8pClWxkagblUyr7A=;
 b=cniUtZpBEmZmgAaHvzBoTQJ6RFecu3KfrCl8tRU27CTY9EN70bHf9/uQxgo7F5jsgbFdSjk9KQqAxHYT2UX69PnBPi3+fOgw01bexy9mOI7z6Xu6rYb77I487LtsEiA+soOOtTmD+42V3M2i4pN3DQm+Spd3mfP1b2pjFq3s5jMIHPLkEzP/lD62p8wVfiAXztlIEggxI8KpjfUkbKlYx2Y+GA8BY6mUcw3jylaLPLLPIJXknn+VGOjCX1oM3PliQx4f2JPcY5p+tKQPyWSECIqJr5NoD7OSSl6HNOp/bwanyg/Xf4IxMRqYpv/mxKI7fQuLec2KrE80S8F+UNUn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8kk36rj6OwE+deFnJBKav+O7cx8pClWxkagblUyr7A=;
 b=iFfbl4ujM9gQfxieLQwo/Eg31tu7xdS03mQCtaCEIN64IhWuzprR5lxr+MeayIOXYXteMuytP25yrMV8ofpjrtyvYCvOFr7EQqLcj9gy9qprhVyeIEBj9SyGaxB6oZenBL30cdmLoBv7Mw16uNnjRxIWU6DQxPXlzR9yboUpchU=
Received: from BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22) by
 SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sat, 1 Mar 2025 01:37:04 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::e) by BYAPR01CA0045.outlook.office365.com
 (2603:10b6:a03:94::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Sat,
 1 Mar 2025 01:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:03 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:37:01 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 2/6] pds_core: specify auxiliary_device to be created
Date: Fri, 28 Feb 2025 17:35:50 -0800
Message-ID: <20250301013554.49511-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aa4081-5173-4e98-0c99-08dd586191d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?64oEQ5OSYzdEMnxnKSUbSBr6fgLFVklMa2ev6DAY5tLbJzkI0nZk+WI0NvCL?=
 =?us-ascii?Q?JFBNwdG1NQ8wbIDWeiI2hm6fcf84OPRM7vg5+homqL/MxSLoNU8PwJ001Gt5?=
 =?us-ascii?Q?itkM3CHiL2fUaD/8Xs6OZ13Pg50wUp1ab7PQCr4/Zso95EdWgV63fC1XAYrC?=
 =?us-ascii?Q?+fiE3ixRw5wYWrldrTCbXcytNX3JXJk3Vd29F9ioWnDac0JDwWNgrH7QWbzs?=
 =?us-ascii?Q?xe8TrRPLIpmCFYJOaGC5KwIVRv6P2+Hs/6SiNalqWi7idFX5rmFOaFpWEGAn?=
 =?us-ascii?Q?E1Cw0Pn777htDvOkD4mk7C4f5H0ueEef3PIwOmTGU3QStBRt+WoeLDWit4dc?=
 =?us-ascii?Q?99lC96RBZHK2ZlhcLkLmEdKuYNlalC+L5ukb1H9skYIglQhpiNU7WGVqko6x?=
 =?us-ascii?Q?aA1zneXvx4eyypMFqG0k7yV2DaMCebfaI+iX3ebZWm4ikCUKzEDNCY5yMiWy?=
 =?us-ascii?Q?cZP8Cb4PKQCotWvmHed6VzqTHgUjapd6Kh5DI80d5d/nMoUwQAvmywpFK34D?=
 =?us-ascii?Q?fqGv4zWwg6ux/svqKEpNkYZLWGIOfrNefU9Ss38sLXQNonwfa19KUIqlFSi+?=
 =?us-ascii?Q?i5aYtiwoCZFSfn0BrDYY6dVIgjJDnliXSmBOuC/0aOCFulQdin4Ge6+/qxu3?=
 =?us-ascii?Q?OULpNQ5qkcCbCggLEw/UyL5rh7mpQ29DR65c3Os0TodtC1RR++nX1qfbTOdm?=
 =?us-ascii?Q?6sQnryz/KWfjkKCErveVNjaEk2y0EKPGEgz1FmLU+PghQIpHrl/u4kVD3YjW?=
 =?us-ascii?Q?1muvdY2arIRSz7ZdTYuIhGCBp3TJhyGvOWsv1yizWsQltemh2SicQ9oOUdKb?=
 =?us-ascii?Q?Eghbc8UobhBcXN/Q2xziCcMp6/gPaPYcQ2QsGaibCec2ixuof5B1Dk38HYuS?=
 =?us-ascii?Q?3EyQhovOVHVtSQfEwm1WVP7JjpjBb6eomcZifiJH3RSASBb+vLzkHOkHEofW?=
 =?us-ascii?Q?FGDmr6fkRoDjxSPotfQVCT8ZeWwvpj7f/KriQWFR2HTls4oM9naGLD1rXjpp?=
 =?us-ascii?Q?hjWKppa3s7f8JYwHFN3UkbP98cv9RygI+hHA/Ol4zrvGrQssfgyD5g3gT4J4?=
 =?us-ascii?Q?XW1AcGtKohNLr/6Qt6WNLQwU2tAtcYXVwqoasYvyJIuz/CbbJNR5jNSm22Er?=
 =?us-ascii?Q?0nhCuJqcBBb1/2Nkwuti9XWK+jBSM9l+VQxmynIFIYCUHcm5a/RLXx75yM/S?=
 =?us-ascii?Q?ve3VVlJ/ZM2K1VQ2KytLkcIbAlQuvayzvqLUsz7MlBzOtk4D6/PIaS9wpxSh?=
 =?us-ascii?Q?hqsVDIND5LA1aWfdtLsLyFyMwIx4gve7+2BISNjtMw4Vs3CgLmzIVoJ3VlTK?=
 =?us-ascii?Q?XcgdLYvkfGyH/9QeBFN7Inhxx+moYeKQtKF+b8qvWVhXV61qvNnTyl+H5U1v?=
 =?us-ascii?Q?6YOsWC4jVF59YMd4oSS1ueZ2lkYOqSuSq6o71xWlUiPMPnCwVssEOBQcZdby?=
 =?us-ascii?Q?O+7F8zxWKEVMJK3FsSaOXiCH2NhHWAeNMBzWIBRZO03Hn0eTZw6Pz87ywu27?=
 =?us-ascii?Q?8ZAmlDfG5Ip1tMk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:03.6687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa4081-5173-4e98-0c99-08dd586191d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

In preparation for adding a new auxiliary_device for the
PF, make the vif type an argument to pdsc_auxbus_dev_add().
We also now pass in the address to where we'll keep the new
padev pointer so that the caller can specify where to save it
but we can still change it under the mutex and keep the mutex
usage within the function.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c  | 37 ++++++++++-----------
 drivers/net/ethernet/amd/pds_core/core.h    |  7 ++--
 drivers/net/ethernet/amd/pds_core/devlink.c |  5 +--
 drivers/net/ethernet/amd/pds_core/main.c    | 11 +++---
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index b1fab95f7eeb..db950a9c9d30 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -175,30 +175,33 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
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
 	return;
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
@@ -207,6 +210,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 	if (!cf)
 		return -ENODEV;
 
+	if (vt >= PDS_DEV_TYPE_MAX)
+		return -EINVAL;
+
 	mutex_lock(&pf->config_lock);
 
 	mask = BIT_ULL(PDSC_S_FW_DEAD) |
@@ -218,17 +224,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
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
@@ -254,7 +253,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
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


