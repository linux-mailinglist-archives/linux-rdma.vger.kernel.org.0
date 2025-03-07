Return-Path: <linux-rdma+bounces-8481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AFA570D7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CF81799BC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CEA2475DD;
	Fri,  7 Mar 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n1FO8YnQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86621D3D6;
	Fri,  7 Mar 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373639; cv=fail; b=ehvuTc9UYDKpBtPILp94lkjEknfY4bWA/8XPmAYi7IDwAuZirbJXZNEN+4pmoLz7zdkDQw9tmoGjKYsO7NMVyNqGcLJ4Oy8/g/629pSPZwQXzkOdfhZVs+wUyUbUh+C+/UC4mYN8xi+BLe5ow0PY9b9ESH6c0c1QZzkoBn50oM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373639; c=relaxed/simple;
	bh=QEqDXUM00BHdKzoJJc4R3HjVW82X5rblrZg4+/AZM14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+25M+Ydmy5LRtktuHt2wzCU0kYLcA+DRtaQZz8h26BqT+5+gIkgh7d4fgfs4yzxXtuPseLyzo4+qPRxoeqgDNe8Edi0BdaEf1r82tY+aR4gSdbU22nwswLojtBVQPArehHZgE4e200PTTboJyQgrB8X7anyIU/nisZCQ3EsitQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n1FO8YnQ; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBjE4dNZDF9PTib434/4tfEVhs9PLwXSsRvs4bqaiv2R9hhWoGVYUDBcdlPZD63/kkyYOvnRUQ9uW/4NTV1IlJxV24UVqJ57l/wqywgHsuyZNyPFXzpauubK4gR2XWRxN+6v9Hm/ttLWgdN1rOf2HbvFW8mw4p8VmqfMVqy/RuoGJHNkRzUIxmjMy+imzfJLwjJjxdr9OOa9ng8FmL9iJ/OFpbjT+iVTXQbS2LDQ+blhc2QVufFsBZvcW+sU8e8psHkSQDYOU9Vyds5y3pk0Df7CbX2rX0TzZUHgUza5mDFEe6F4EoGoaucS8B96hLdIU18Eret+YdKM/diWh2FU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8MTXS/sBJpGa/ASf6hORjd9jiyw50jhY5B2WFJk/qU=;
 b=K1aUcxQdlND9JY15iDGRCPOZuZC1eXsvxgxkyVcWy5HW+0G7AU7emkdtCKXEN0hNkX2qxu8cSodI/5SHEK7ND3bDHhA2ohqwwV38v9S5H0TfpRvpSWWn9t4HYXYMS5z4NcRQwx7xl3XPuBCbpfGaU0SmmsI4HM7sAkzWnNTUcj40q4OKNn39nbAxwA2FmwHcH3mOcs3GBKh5HMR4r8uzamnigHrQsbGgkdnxAPWHLTbSwlPb+3CDU8DTFA9kbL8OpjRcBOtUKYgf1AAMNWHEWa30iPu6r+T8NTThNzduEo5F4C8n13bVd1wLOdkICvPLR7CyaMbL5iIf8DDFwb8Fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8MTXS/sBJpGa/ASf6hORjd9jiyw50jhY5B2WFJk/qU=;
 b=n1FO8YnQ0clYpVmMOl9Mp5DODv7YOOt5b1Mpq79GDJPPL86Xof52odYi7xceDglNh/s1yZbSw2wzUIGoW1S5ahi7VdGuWACeiwatHSEitd/qA4pjfl6v8at8uJ1e5EMJBIZ3hMc1LEvCfxsZtii5bqD9u5PF3Sjj2blCEapZI54=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 18:53:53 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::b6) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 18:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:53:53 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:51 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 1/6] pds_core: make pdsc_auxbus_dev_del() void
Date: Fri, 7 Mar 2025 10:53:24 -0800
Message-ID: <20250307185329.35034-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5351cb-f529-4de6-eca6-08dd5da9680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKohF8AvaC2tg3EX7XRKnqIilEx9RCJOGSKwJHpGOGMMsp/V6tfReKnK0bEs?=
 =?us-ascii?Q?w+cV7VMnRit/MS32bF65M3ydqyeIhNyNzXEcNXejYZ6LZ3oujAZpV5EHyVPo?=
 =?us-ascii?Q?DSUJUof7pjbfaktBx98Z30nv6dy4ClK569hmuVEyRBLFbnIFKw28rvCY/6kt?=
 =?us-ascii?Q?APeTqZHbjqASArvMqXyZGovzw9VuQ71mRfjxjAuj3cDiTrKKBqXwAM60HjXa?=
 =?us-ascii?Q?/tPFuvwiZAPuzjDwG6zm4h8bWb3ioNJ20nVB/P1LL4PafvGXlQpGdM0LGjFJ?=
 =?us-ascii?Q?tYm/y5icMW/tsoYnnHxXtoFhOfMNAsi1nbUxC25QFl+kDBlr2dPMg8AS4Eh1?=
 =?us-ascii?Q?yzwEmttgLtFAvGidE+9fIagUSRsqvCHQzobC7xESPs08WDusuJ2Gz0ybUvT8?=
 =?us-ascii?Q?fYvX7uGWf7EqoDXo8rmy33OiG1ImW1YxLqZZQDfyKoQIaXj9MwuIVI6E19C1?=
 =?us-ascii?Q?auhEZuyGLkTKPjMSM5HP8yB9jqVUXfYzCdzn8WfLnRQpT0I2hr4iYBSRESq9?=
 =?us-ascii?Q?y88/G34LGXSvaAV2OvaeCmx/kuCas7c8NrvsOVDZaxND+gETh9P9XPdgCbQB?=
 =?us-ascii?Q?K8HK6eF108M9QbKVNNJCMJxnlHzfnq9Ox4Sv24/Nm3Bg9TfLUJS54Oo3q8E/?=
 =?us-ascii?Q?Dg9aXypxCiyiIIenzF7IVVr1qe7u/T2X+h8SrZNKCcL2gSeNuqPNr761d3PM?=
 =?us-ascii?Q?rQlyIlZIfFcoLaFSYGA/54c4yS2dg2l+VqcfiHY62ULBy+kntgKU9f7rr7Le?=
 =?us-ascii?Q?l7KMN9XJHH1HmqdzyMy0Rs076KAqNYW4WxIIVzwKPTDIpOugj2T2Qr1AKFnH?=
 =?us-ascii?Q?TI3wIAOWRi+ggiffYoDg4mtNtMz/0fwFVLsB2SgtKgaD9yOob43aAHUen746?=
 =?us-ascii?Q?y919QVr4H+9+AyFQm1Z1sCtfd/zezHkijURXKwrmoIxGMoAhIK0Iuc7mFlYE?=
 =?us-ascii?Q?3lgMDn1XSrDRA1BJVid6QLS84YrMNRxOBNSxFEZwWFTh8XmnykLQkj9u4ZS0?=
 =?us-ascii?Q?RpuOjQyGgmcd1tHNLyXvRp4QiwDYC4ZA2fM0D3Yo/Run7VPFqYPww4JEBqq8?=
 =?us-ascii?Q?wnEhNMOv0leWd00CCGOOMB4Bhgl42gDsqKqjiP0TYR1Vkc+rjaP8YEGAKuqg?=
 =?us-ascii?Q?jya4KGOr2zF5FLr8w0i8MuDyB+ZRrvcRWQAau7T/1abh5n7uag+TJsVIVwpF?=
 =?us-ascii?Q?2qwmPZU43+4jg1tY1V5LjIeWS3ed0SggJOJI0mdgi+egzEHamNEUnxQvTH9h?=
 =?us-ascii?Q?CbjwS7iywRc80Rif3VTiiuGJA9bQLANKofZlm/31L5vuc50mOfWHsN7OQyyL?=
 =?us-ascii?Q?C5tjyhp3CbErliP0TrFCTs+8KKNBf0TdF4gRVqqmJu/V8iUV4MoJaM5lQECt?=
 =?us-ascii?Q?OITZoyG7RMDwP0dC2+nRXxAxUZkREalphHjIzfU6awF0hbKiS4KBbGQsIXFo?=
 =?us-ascii?Q?+VTZsFEFicl6RElgpAVxxbJD2zGXZIBne1IBuaiQ6kbA0z+24DWWS29DM+RG?=
 =?us-ascii?Q?+FTSOQ1NIvN1DAgWzvLMknhymHL8maZQLGI2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:53.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5351cb-f529-4de6-eca6-08dd5da9680a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

Since there really is no useful return, advertising a return value
is rather misleading.  Make pdsc_auxbus_dev_del() a void function.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
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


