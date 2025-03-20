Return-Path: <linux-rdma+bounces-8878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1BA6AEB6
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9112C9818E7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E722A1D5;
	Thu, 20 Mar 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ietxn+sX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86F2288EA;
	Thu, 20 Mar 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499880; cv=fail; b=bY4tzqHfcXCl0HXWWQSCb5tga+SWlimZy/17lQAsHbCmMuwJo3cIpwz5o1MpPBT1e0W/b058smDjOD04FYrZ+YF5LNAS8gFOXAoucup9irpNod9wZVlzmUiBb5uB9VaEAZLz7xK3+TMoLBXffdfIrDYFZe7qjeC2TIkfUALLsto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499880; c=relaxed/simple;
	bh=XrinpZ7brHowkz2zlp4plByre6rAXB0huImZjJHlpP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMUdKnwr4CZCViYzC7yMZTo6ONIdnjwP53BXndQUjOchZAh/AaX9TTD0SFXL6QxxX0vYBqEneG9Je6EwcdCHXQMCSKZiZUB2zH4U50W1T66H6mjwp/3HHueLAVo1bjg8tEiqZ692thuhYP0uTyGgWRwHrVCMh4R003cNlJ03+EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ietxn+sX; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmOG+POmSpwmKyMRDLVC4V3IH3a95fsnflXKgP96Vtba7JkT/wwSaZlz8XnFVtpwzJVYYG9MrDvthSjmGZnAimlW0XXPkeYQ131PQcdTIo1hYrH0tnq7LM2uSatoxSubwUwBo59I6c+SQpK1sTlGv6RSmNqiFd8tsEP/wkfPermO5SqFtKyCNQCODSeOGUeBXDP2STAH0mLUO+n4gsIy/hAI94tyoNuQu8GJPd4pTJZzYkYbpVqR0CWUagkFMC0hX5cdOz/xkfm0MZg0bA0cpWV82Vmn25Kr5IbiWBUNXWBlVMkJrAvJg5uNi1PCXX8KSXIfCTUBvSqt5paaL4XVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnRRu19yhsWwwteAaz18hb2Kxe9GT2EwCoHgOwAKBuM=;
 b=LfXy3zvtB81Qfb5y+T3atAK64c6mieAq08Q+wDMDIYYepp4tDMf3QVi/elACHw4rzHUvucu97wkIa94l6gtSBRZ+Atfpg1ayDFB/Ak0VxxRq0zjvE8/BU2oZUAcW3t3XPW0JCJbiWIe5OCg/A2NQyDHk9UjzubtK0KyFWigPpbo8mnGH/pAJm5Y2hVxqBMoHNZt6VCbkIQKpu5LsX8HZLWgVC0UMCOWJC0Yj6+RvOHw21JI2zxNvjN+LrKyK4hXX4MbLg54X1wrGP6pZnQR8RUELXPq1m4iXrZfn9xUMpJ3gHCNhvr+RxtQOzXDeM7dV26fN5q4dlyRWZ0uBK8mPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnRRu19yhsWwwteAaz18hb2Kxe9GT2EwCoHgOwAKBuM=;
 b=Ietxn+sXnF+wnx9cE2zXwfKfKIajj0SvAf8VhlI0L/KyVksFl/bpCqjrQfh9IWgsDeKeM5Otle7zoHhj5T+NAYno7Yaua2l/fBQ1An/ckWXFD/KMHEpNPLVfYnQ56eLqBpa+V7YoxQ4DiVfjnjMJ3z+jRTI1IHmWf3Cw8RK+4l0=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 19:44:33 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::18) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 19:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:44:33 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 14:44:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 2/6] pds_core: specify auxiliary_device to be created
Date: Thu, 20 Mar 2025 12:44:08 -0700
Message-ID: <20250320194412.67983-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 797fc27d-40b5-45ba-5584-08dd67e7a39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fWT2po1ssLWXpddOG/i6dVr4mXqH7fo3qH0Cnxnoi0mC/aG/Jqf/tvdIbwgE?=
 =?us-ascii?Q?lolbAkS8BcdFl+W0PA/QI4NZ7XWusvRidGv9FDK/e7k84HnZcbkk6mJ9sG+y?=
 =?us-ascii?Q?e5je8E0Mh1baKk/MLEK5hhH006UACzGlTXpf/IiFCKDcPXhBOnj07HaeHQLC?=
 =?us-ascii?Q?sknBe6TpQMGtTj/AN9CeHyJN2tAl6gWyT8mr7KD669kluehemtpeyDx+KLvB?=
 =?us-ascii?Q?77rflHoSk1R4bWzQgTcH90rCRcVqJXltL5nOxbdRVjvRvV6/6KDn+mAbfZ4o?=
 =?us-ascii?Q?RkkM1BpB52fnlotuTQTOqhXRQhD6yZTn+RVdXUaSFZnM/8bL8hqHiLVSopFE?=
 =?us-ascii?Q?ci5YV/kkEPkYm/NTaTThZzmZX6cDCllO2JVP9UX807hVoV8Vz3QX6QecRafp?=
 =?us-ascii?Q?s38R+7B4kEDSFzHwFul0Mzkhr9fREUdekIoxxTa1okVsgB7thylv4cfyJJ3M?=
 =?us-ascii?Q?tlkUgDxt3aby5jIlhWjuD3ul41Cf3rGfVPJTFfnhXWdY9cOa6oYsrq4iyL4/?=
 =?us-ascii?Q?39aJC5tgqIrs7r1hTmGegAGZmFv+gQLO4wkXjSBta7puceIflBTIswXgEXVO?=
 =?us-ascii?Q?5agjNk4Ro7AOEakXO+iFTH1V7eRKEVuiWWNWJwGJFUo5GZatcX0GFJ0HA8/t?=
 =?us-ascii?Q?esVvuhcZnRyyHaoRPQ4UES4Q0vM7htv+JN4WAj3UsKDixQLx/vbIifNAQKvv?=
 =?us-ascii?Q?+f1UT8zy4rz1ldWRsYtzPC6iVbePDm5ahTULNVXP1YvaUK+dqIS5/UGVXZmB?=
 =?us-ascii?Q?hwHCrV2QHdvYDR1HwWINbBbsLvSINI19vufhULsQ9l86E9cih5kxlddloz7u?=
 =?us-ascii?Q?b4m8AiLTtzC+DP3UwfDfDGLtazv7uoaZ8VW5c6bW1cO2btLz87oKTTqrD2b3?=
 =?us-ascii?Q?qsQLFeR5uwMa54OV3Pr+YqD6yYZPxVngxnOiACgIroyKDDoFkoVhzTbaWKq2?=
 =?us-ascii?Q?SvGo+qkYEs8Hyxz+Deue8PM1ZOm8IKeY9kUVM8TEOHNPoUV6dDGQnHNJUc82?=
 =?us-ascii?Q?yXbwm/zRO6StzLVqrhqJxk6xHjgK2LTEGF8DdUV8GSpJTlzNBQkcs0vUCW0L?=
 =?us-ascii?Q?FC5+tidmIm2pfMESNNCWEdrTPrWpuhPNnh/oaJ9Tr4Snubb7RRMs5xbaLCrb?=
 =?us-ascii?Q?GDUO9FdmUoYQhH1TcxBJg18Eib+IcsFSgI/EOQK4Nm6nkCTyioX8tTFpqbLk?=
 =?us-ascii?Q?v8CULKbVRyAWvyO8/V7vKUXHyR+LCpYds2GjG8IkeMmZZjyuLbcpLYJ4//6b?=
 =?us-ascii?Q?6RwdS33yRmfWxluxDQgHZ/49iV+VeCZ4//4BmQ34xTt4BbbZQCHV6FPc6XfL?=
 =?us-ascii?Q?2+kq8WWM0hC+GbcpQJAS8S5Wo55UA5f+oT0NNZAc6r6MnlinQSI2QJaHz7E3?=
 =?us-ascii?Q?K5skn/XBRe8a9gnpHWpIZgPBNxnI02v4ogp3Qh3KTMcRvJe31hVD9srVLMJh?=
 =?us-ascii?Q?879iQFe+eYqKtgsceo5c6Ip/g6v36W24WHOGw2fJs74hOui/a45kvluXy88J?=
 =?us-ascii?Q?Czu9IfJCD5PyQ70=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:44:33.5982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797fc27d-40b5-45ba-5584-08dd67e7a39b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

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


