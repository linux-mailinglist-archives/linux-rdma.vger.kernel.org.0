Return-Path: <linux-rdma+bounces-8482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9976A570D8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B0D179A43
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCA24BBFD;
	Fri,  7 Mar 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VR/pJGAb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C724A063;
	Fri,  7 Mar 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373642; cv=fail; b=oVkS7zX2ZcLV0ilygeyVVcwU/Ii8w81g9ghj2gz/kc5T5o1DDn5jXcElRoqXS1zDYwP7Cztmgx28KlI8WEo3iYasx0yx8oEc8n+d1n87CZ3EC9ZM1knl84ccuA8nhJC+Ea7TbmLYKyf8yiiWgZU0lIPczVPvPoWFvOXLwWJLh2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373642; c=relaxed/simple;
	bh=NscgivkNAsiJONGs/0n1EXKJqyCbUpJDPjegZSzggGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFT+XIk31E9Fu2YfgV178qymqWcwI5VX6BvSGgXhbaN8vOF9LbFZm4eW95qF/GlkUkWvGQmyXqcHYkl0774AUe+lYyrRSpuUkdQ/1v+3Ip38WLhXFcRb/1bsCVVMioMXcd3FpaP24vSliXo3lKkJ+J1KxIS9HOcM2kegnYde0Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VR/pJGAb; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCdehpzc4dQbmgSEF3c7wuMbJSx7b4gLBnVxKwHhGRh8kn0nhgPdRLMNdnimacpfVY30eS7B9L8bk0X/CFxczYlDZswez4+LAVE//Bz0x7QpLuCeq/Kms2C3GKViHKpYOx5Q8N/EJ2/1j4Bil8VgeEfkdfHodL1rNX7l5jGxJ0/2P0fsXgYs11D9xVYI9jiNLA2/ndjFPE54mp4/gh2W4cd36QoV1z2wYSRpd1sG5nZP1NyeBuKpgnUdXejnn5Icnh8WUOk7PSzT5/DAhjaNQh2+v4kOnjmW5BtsGCfEF/6LunBmKmifXK2FX8RELbuJFbNuyKQOiytIpy4fsnoudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7iu5XnvjWCi8h2zD43xkCQMZGSevUvBuW/kGYaIk9A=;
 b=QJvMChO2An+lxsUcrXNVwwMGSXJlvMPo/+ycCATwQ9tTRqDeZW/nc8oTA2Yb4yLTv6wp2sr00d16gqhnEojLelW+YmZUaBD81dQQXjBkyZFSr+btJ09vXc8JPlgeM/7Eb3fCvBN3Nd4r6p7P8su5Rc6I3TuqNaDFWEcwg/jV0X+gnF7vJs94x6V2UT573BJ+Yu/zbfEzpykHfjhGex1c+ntr9oXfEltvKpHp9GyC1BUKRNLm4u5wMqV2W1Ck34zBMfBeQSGytFgLCTOtJ7F/Xk9RKHzJJT7rdaLnwIXqT36BFemjbzVmmPTlyqMVoxK8qchg3P+76xU0qFFBMTJrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7iu5XnvjWCi8h2zD43xkCQMZGSevUvBuW/kGYaIk9A=;
 b=VR/pJGAb5P380jtwGU/Rv0RA2X4rEj8R+Jgl2A9ToyMSKIk5/YN+K7rzSozQMif9ATc1soxzculzLmbN0/scn/SGJ5wazVHZ5iiGfd4Q/E+xirnoIFf0c5EZkL7y4dWi5sN59Svb9axPYueqxERvooWadn+YUMpM7gtz4eFYB7Q=
Received: from MN0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:52c::34)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 18:53:56 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::b2) by MN0PR05CA0020.outlook.office365.com
 (2603:10b6:208:52c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.15 via Frontend Transport; Fri,
 7 Mar 2025 18:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:53:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:53 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 2/6] pds_core: specify auxiliary_device to be created
Date: Fri, 7 Mar 2025 10:53:25 -0800
Message-ID: <20250307185329.35034-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 49174857-0adc-467b-6dd1-08dd5da968f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3/Uo149eExavbedk9BB3BE+7bS3I5uwavWm90EIhouw4rh32qMm+g8iwVW+?=
 =?us-ascii?Q?KWjE9Xh1TrQPJg4zKuJ7qOrmEf0C1Y6uJZaRVdoLkuK06Ay1KHDE5OfT5xau?=
 =?us-ascii?Q?jHqu7BLDTThj8eug35U1lOjnLNQB+vHSSybLAcjwndCJrimmMSAjjBe5nUwq?=
 =?us-ascii?Q?58ZHR+DmadtcAtabHwL5Dki09X+KLX12ZlNWm7tJ+AWbaa5r/IF0c6AlPaKv?=
 =?us-ascii?Q?0FNrwWxExs1M51RDritDY8JRA9hnjf4ZDHGUyh2BiK9Y+Dld1lQdd6PFZYED?=
 =?us-ascii?Q?GEqr4MnFpVSX4jJzaNADfZdU6Kr7Tfs0IDy7cWUwPviSfpuDa2arTnlRSO6+?=
 =?us-ascii?Q?VjSD10IYiTocNumoKKWpsz880gXNYArqpdUZj43EiURgIs4HVcBafMJFvnlw?=
 =?us-ascii?Q?BzIlFyUYMes+alJyeI+hi9RjwoIadFLgpE+tCK0CL8ux2TCqrzoIkcm6yfIj?=
 =?us-ascii?Q?OWrusdZxfXJ6+m0O/L8EdXvDkqxRxxz9+xXjEilRPjYlF0gViG5YU0utr8T7?=
 =?us-ascii?Q?3rjyNmpHfm+Cshohy6+8f7Lceu9yBMZ47TSFt5aThuq/hVNyaVurVSNkAGax?=
 =?us-ascii?Q?hPrkTcHcdTizBVAxrLPr+aNhooyuSz9V1caJA/JxsirPcdsbw6xGFUckbX+I?=
 =?us-ascii?Q?MMREh4tBtH3DGKb/ZzK41X7Zq14Aa9LhcEnGUplao5xlgcM26dWY+gC7HljM?=
 =?us-ascii?Q?2MMGScJfqgTgEo5d6ywLKr25Td+UvLQu/NGsDtkxdf76txZ0HSjK9wcsSybK?=
 =?us-ascii?Q?BdlZ3kVS3RV+0q9E35vaZ1H6K1JkSq/RQLLWt9hcUyl60m4TP3towNCn9bfC?=
 =?us-ascii?Q?+X/o5u/qGSxzpP6c0nV0IxFzznaXl/GjbrFW9795f1sHeEc+Mfw6U6dgR2cn?=
 =?us-ascii?Q?hyso0Ou2xRNdAyZ7+da0OhcWpP2pH7RJg72jG3i9To/JatbQLMP/F/9hk891?=
 =?us-ascii?Q?bCZL1HDfUSuZBaCAeVLtpsr2ZDYVD4/rbI3QeIAsRBcoUyG3q9+BGONWzYH5?=
 =?us-ascii?Q?jlRjiHwy0Y46DCQvl3G8ZPnEOkMSiWCJPmEsWUMdM39bcPDjsDZy8YDGC7df?=
 =?us-ascii?Q?bYco/KfehANAsjXA8t1gm/LqcFZ12GkaM6F2ES4EVhyp79nIPlRyr7clsIMv?=
 =?us-ascii?Q?QS8K7SWcMAvnNAFrsD+kfi0xfMhCwLGqvv35mcrCWho4GdreONfg+mjfsouQ?=
 =?us-ascii?Q?hAj6oI0fiMHuSKjCNnKxr7sg9Zd6m8bapySoLs1sOxa2LTpSJXpZ1jst0B2d?=
 =?us-ascii?Q?KOeHjtCrNSpNMIyRn5BT8nh52H9qEPeNaIyjY44ynVkBin3gdSF2wgVR2dUK?=
 =?us-ascii?Q?cAeyBbY5B2SLRt3krfZclyFJTSQJxzlk7jXY6dBEqfnqORYZn3Hmnp7Zkmr3?=
 =?us-ascii?Q?vy+gnn8eUjDM7jZbyT6/+8FPxqHbrw7sChwuuSMtL8JKaKiBHGQEOVynLV1z?=
 =?us-ascii?Q?WOBQvq++VIZ6BIZ770N+NcdISRvrjgDNFP+GZLgwFKR1ivyaafU8KpZSIOen?=
 =?us-ascii?Q?n+rPuVUOzlkuv3g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:54.7977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49174857-0adc-467b-6dd1-08dd5da968f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290

In preparation for adding a new auxiliary_device for the
PF, make the vif type an argument to pdsc_auxbus_dev_add().
We also now pass in the address to where we'll keep the new
padev pointer so that the caller can specify where to save it
but we can still change it under the mutex and keep the mutex
usage within the function.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


