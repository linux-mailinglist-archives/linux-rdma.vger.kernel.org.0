Return-Path: <linux-rdma+bounces-8846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F7A69AE5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 22:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5FD3B3F9F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DF214A77;
	Wed, 19 Mar 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F21gZ2sT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC20158538;
	Wed, 19 Mar 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419981; cv=fail; b=m15XxnX5uHY9j2elBYCO00RGOhNVyXGlD/PBNtJGRrXVVj3evtKOpoiLUQwQGJ10oRSX6/UoqllzGgNCWdZWcEL/oAhMYtk7UIjzsBaNeYGog0m/Z0idYHxLoR+1ojVBB13FSq+6tAxU+mY4Wpfre+x8WlZomu/NLrBlawx8odE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419981; c=relaxed/simple;
	bh=g6fcp/8gwBh2NWzsXTXt7qYyqff63v09pKfCnNC5M7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhbGHWvjij71zOqkJJYIdjvOZc9pJAms10R2MO+36uvtDi/X8zHM5uBvOgjt799yNFC4C3zmQZBQmwA2X6tFQHiMdtz71TQBv+FfWmCSBCSdwB+GCSoKgxBZ67boVMIH/Zg8bdtl6nmvwO42GJLK88x8vre0iq9YaJf3A7d/Ens=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F21gZ2sT; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrfQp+OzjR7IowIFswVPNfyGCYy6PPN6GE0jCKFc5rGvbcYvY++sNvenmWlYiD+6VLEksE3WjOw+BjdXMDTPuFmGmV+XCN+rnRC8mxd4fQQBqH2vev/Wm8JP7ICqJv2zod0Bs7So8EsraiKQDkvrX1rOtEECnUs7UTTYnju4i5VGsKkHYFw1bV0/mPkHiVE+ZJGHgkb5FZMsFB2C416ft7e+HGJQoya5iykA9BLH/2zFqUCKbOUKw5G/k1zjAXzMKa6D1Mh3IEvKvibShE5TJAGcbVrx4nSAV7SCxtezJc7FSvNhrdsmd49VXgNyi0LXptMar233BYjC2GNJHeb0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFtX6E5XI+YwAwgcmjPaW6YAjJHcCZ2+4iRbhvB5dKE=;
 b=PtT8Qx3oBconi0P3XSUO+vjOieXunepQ4s6CwHvakBjtyJMuhFE3QQCx0XXOAObzc9XPYCa4zbYJ+Z7mFDUkk/3COvTdH+lTT38RVqSaJDSNXugZboCJF8DtGB7IocWt49ixeQ3fxdAQN+g7j1Aviy+D7zvL39fnfY89vFdXVHCEwAwqM77jJZAPuWeCOnwCI1IGRpdqyU4gfLiTAcWlY5K0rmSa5uFvE2/y5nQo/A7h2nn0oN4JGu74PlIbarL+Kwtf0eMA1dRLchag8Q/BcolOQgTlkoSOSlr2BMmxDS8kyt3ZOXihJOdG7J0KGioCNWSsElAYMi4hXwbzCrjVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFtX6E5XI+YwAwgcmjPaW6YAjJHcCZ2+4iRbhvB5dKE=;
 b=F21gZ2sTEMWJecvQ6H2X/JOn5KyivzfsRtkFtz298kKPdQx0kSNAmtbWVPdkD2C8fAcGY4ZqVoEgKUr1/HgMULtkRJdbvSlSLTpIWeD7V63f3yuptvA3EBWBmQfKFtXk9iATPsgGp1xofQYmiA/e10CvWmRt3V9Ym4uyi1j8e1k=
Received: from SJ0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:a03:2c2::20)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 21:32:55 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::fc) by SJ0PR13CA0045.outlook.office365.com
 (2603:10b6:a03:2c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 21:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 21:32:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 16:32:53 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 1/6] pds_core: make pdsc_auxbus_dev_del() void
Date: Wed, 19 Mar 2025 14:32:32 -0700
Message-ID: <20250319213237.63463-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ebc0cb-763e-483f-326a-08dd672d9cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXnrmtWcUrcu2tk6zapeoGrARU03lJlYvEP8dwAomSRs/3u6GWy3aCaqxchl?=
 =?us-ascii?Q?L63Tj0188mZitL7MOSk8BeNWkaQyw9Du02ad4p7ZXtJmJ9aTeY5UrNhK5Wk4?=
 =?us-ascii?Q?EB6gtqV8BB3TwdOQ2wGAbiuPwlALxViqYAAmiFsLY9GoNmEW2IzNfLh+ok2G?=
 =?us-ascii?Q?ZUdFsqJOpRSvJZkKv8OGohnHlkrB3gS1lMSNO1eF5dA4bpaWzhC9FyzN3bLD?=
 =?us-ascii?Q?mC5vGvzR9WMesPF/MLvKOsW6IcGfH1qFPzjCjL/049Y0sBlWz52WHzsCCeqJ?=
 =?us-ascii?Q?hjPdXWiswzme6V/LLchBnI/WOE4N/IjD0sGc12UiCQpv/DLSfo4Wr6CP2Ryv?=
 =?us-ascii?Q?cuf/DNKbk++FE2bs4fM5n7siPoiYaMVzGOK4gTTmOU6QD3bJVxk9aiPuzAYm?=
 =?us-ascii?Q?pGRb5nCmIFpkbPmEoppo5FjPawtNZH2kDAk/zk0HckTfBAa7+hocyFAhB9k8?=
 =?us-ascii?Q?pKb5KHtZFP6+AYzWgfPZuUN84A8agYR7O/LIqF5TgqdiflTTnOt4ObfAwirT?=
 =?us-ascii?Q?UG8RPZ9AiJzk0tTauWIJkEGX+1nc/QXqJZErbI8bCyL+eKb+vNBFDZVITNfo?=
 =?us-ascii?Q?HUg3hOy8Q8Ke+eWYWCNT3+Ws17zpUNnxr6KL8iVnYLtdVFnWMyi+W9+vVszG?=
 =?us-ascii?Q?1/Y/N6Ct1qyb8rPwb9PbJdIqkkL63puFwh7DvNUMPPAptGkxIJa5X50jnFbv?=
 =?us-ascii?Q?L7wLR8p1GhesL8P9dkHPZkNBpxG4IFHg+n3NvjjoqrFsG4JMQwHwnrzaAAUx?=
 =?us-ascii?Q?EnSQwE/iQGLmujQhCp+0a9sNGqxY9gEgxdhn9ZHtIDhadDacYgNgmfK+4Ho0?=
 =?us-ascii?Q?deG89ddHZ75Asrl/prGoZkUcPbpIwBs5DajX74ZpRctSCW2HqPmTmF8ZTk5f?=
 =?us-ascii?Q?2cPrEHeK53Qm3DqRCcH6T1RFAtLL1SyFvVfZWqGOmr9N4Yu+hg5FoR899TUV?=
 =?us-ascii?Q?kbdhZvrXpfukB5O+t6LIDNv3cCiqanadyVOmYiXypX9zTbnbRwnrH3u3rkJr?=
 =?us-ascii?Q?HBQyRxRGpIZ3dST0OiYH3D/NGdiPgTcJkiC33Et1ZLgd4JvD3RvZxkh7fHX3?=
 =?us-ascii?Q?9oXvXxU2YXhP4ebOqkvy4bGlAWVy/CxQ8Uv8kTYfAcRjSMHt6T67cnoR0pyh?=
 =?us-ascii?Q?TPwbyqPXLzaUs4tx170U8l7N7JpxwJONnYaR3how16r3q9m/QW/swB1NUk5S?=
 =?us-ascii?Q?MPwiQSCcdKOQdKUSgHeBfiTlucUcZb1UHMjOi4bCJzKN4tjrS/urFkVMA+In?=
 =?us-ascii?Q?FgN/BKhlbKD0ebvgK6g/F22gAap8gr98HYcVgyIyuDQnASydNrGlCL30AN7v?=
 =?us-ascii?Q?PXDfiqXxjhemZuMeKNjcZtLbbAE4zNhk5tS6tWtgCttTu1n5OgVclFnY/frO?=
 =?us-ascii?Q?IECGy5KGlENiiedEqag8UfU616YU2MouThO0ryQ8gv+yV9e1EYRHmcvZ7Pkl?=
 =?us-ascii?Q?oncwPZ0w9TXvCq6ZlkxIoLXg7OVgRIHGhRrlystuyvfftR3Rs0dZjUWrBwct?=
 =?us-ascii?Q?hfj15e4fI0WDJXgUCIG5n5ASA6GYJmqWiYHY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 21:32:55.5578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ebc0cb-763e-483f-326a-08dd672d9cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652

Since there really is no useful return, advertising a return value
is rather misleading.  Make pdsc_auxbus_dev_del() a void function.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c  | 7 +------
 drivers/net/ethernet/amd/pds_core/core.h    | 2 +-
 drivers/net/ethernet/amd/pds_core/devlink.c | 6 ++++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 2babea110991..78fba368e797 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -175,13 +175,9 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	return padev;
 }
 
-int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
+void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
 {
 	struct pds_auxiliary_dev *padev;
-	int err = 0;
-
-	if (!cf)
-		return -ENODEV;
 
 	mutex_lock(&pf->config_lock);
 
@@ -195,7 +191,6 @@ int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
 	pf->vfs[cf->vf_id].padev = NULL;
 
 	mutex_unlock(&pf->config_lock);
-	return err;
 }
 
 int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 14522d6d5f86..631a59cfdd7e 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -304,7 +304,7 @@ int pdsc_register_notify(struct notifier_block *nb);
 void pdsc_unregister_notify(struct notifier_block *nb);
 void pdsc_notify(unsigned long event, void *data);
 int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
-int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
+void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
 
 void pdsc_process_adminq(struct pdsc_qcq *qcq);
 void pdsc_work_thread(struct work_struct *work);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 44971e71991f..4e2b92ddef6f 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -56,8 +56,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 	for (vf_id = 0; vf_id < pdsc->num_vfs; vf_id++) {
 		struct pdsc *vf = pdsc->vfs[vf_id].vf;
 
-		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc) :
-				       pdsc_auxbus_dev_del(vf, pdsc);
+		if (ctx->val.vbool)
+			err = pdsc_auxbus_dev_add(vf, pdsc);
+		else
+			pdsc_auxbus_dev_del(vf, pdsc);
 	}
 
 	return err;
-- 
2.17.1


