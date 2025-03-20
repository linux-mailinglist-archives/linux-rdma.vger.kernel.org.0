Return-Path: <linux-rdma+bounces-8876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A68A6AEB2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E581D3A7908
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7422837F;
	Thu, 20 Mar 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mRMY88VE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93B339A1;
	Thu, 20 Mar 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499878; cv=fail; b=TwKv2a7Hm+QIJgFE6DfZ32MjvrJfnJGLvcmNSFzcrAI6RfyfrHQpZXpzRZNX6J+L+ZvXa3LuzeralnW30pk+9HuSJKiDtohmT0/TVEU7y3zVgZ9cK1OMoys9kTYacxH6kT1f138PyFNyaToqMMdMvdX9esMccDqPQAhqn29zerY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499878; c=relaxed/simple;
	bh=g6fcp/8gwBh2NWzsXTXt7qYyqff63v09pKfCnNC5M7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERPFxj3sUWjGtoIc8rJIuoGwsMtYh3Rv6+2PvjwB5Qw2kzEXbWXHUSrXTjerPn1Agw82cP4KYsIVJ01s3uvnV0WmqgUhNA0OeAXOW8jhyihL9Sri5rRhHNBTLfw7p+qeikdTZjiguBp2OxA4lMVdL37JEddXH4mmym+jrPialMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mRMY88VE; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBestN5kLRFQSJDBjDP33yYwAIeo5KLimfYgzmiNQlYRqoLU0zb0A/ex66L4nJRR2lkQoUleWn+cI6CUo0c57BbafRKVoXXtOAAeSqRwpi3q9bCTr1RULumuDbW7GEXzorxXTgJrFTLuqWBYcaHTxvf++Z7y3nQNe0SykaGjfDOOiFo0u7L50hGf6+qwMrEvVLUXfYZLncvmjWUnFdZ7hgcRPhV2uA7OrH1S1Yy7hxUJKWrYcazcn5iK2ZaO7aAcVO0yd/sTB0NzwvAwsdqm4lrxjQn0MOoGkjOEmPB07iL2+2YX0uChnyRHpa8SJyoJR5IFLBprPOu2E9s9CbWjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFtX6E5XI+YwAwgcmjPaW6YAjJHcCZ2+4iRbhvB5dKE=;
 b=wKcfBtY6y3xB+KrjkggJm5daEwQPDUVsfzXiMljPsg4my8HfZbKBgr1uQ8cnmoJs34dD9ESagaYeg2sG1BaVSadqw0PKbgiHga5eV6YSQ6wQOekFp2SBuSOBXcQN4Gb67wqL8V+lW5ZvlAS+v4kxtMMt0w4r7fftsZoaJtZiXF0hETbekWeLoIDgdBSdYKEKG90ENPrNPvlP3NwwQlegVOTwjH+O6Uanojebp9TYwQgngR4ScBlVVMiPBkXGZReS2f0S/AvDbSHGxUuDUjQnk8CZnQRuz9Hl6RYiWA31oZBHr1GZYVAfSvziU7SFlMEjdi3JcMSBW4jWWWeL6tW9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFtX6E5XI+YwAwgcmjPaW6YAjJHcCZ2+4iRbhvB5dKE=;
 b=mRMY88VESIpraWWcNmYoa8x83tBwvAXxQ5694Gv5Y0AvHvLeaE31kuY8+L8UMJyt6UsE/hnC0/nIdeCbLBumk/ov3lTFT2iehYzQa3wFMLRGcryRYfXXMuNeTXdbFuyaca8RhyBRRwCu+awdlN8vfjnWwNSizT8aPC+KGBCr1m4=
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 19:44:33 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::a6) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 19:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:44:32 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 14:44:30 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 1/6] pds_core: make pdsc_auxbus_dev_del() void
Date: Thu, 20 Mar 2025 12:44:07 -0700
Message-ID: <20250320194412.67983-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 296999a4-0479-4095-7356-08dd67e7a2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q9iqf0SQM9tjiZLQmdC+/7rGtlFO/9FcYy+S0fOQIZskVJtuwjGL2IIRG6Wb?=
 =?us-ascii?Q?A3bQOk27e5Dc18Hc2u4BjrswWqk29RedwENjmVK0TUlD7HbJ0lOiZm9omzBE?=
 =?us-ascii?Q?7evwMaKxHHBCiNq8n0hRFxzhMJylxseLWZghppehEcw+Fucqq9UtJTVrOavf?=
 =?us-ascii?Q?2DRR4W/5sxcMWExaUZYR/KINwa7RPd/pybAH8qWfiQi+EEopqaovfGnE8DNx?=
 =?us-ascii?Q?xmsoOePv8mZ+h9OmBEcdoUKSzxEZbZ04D++mqMwzN5G6e88exLYm/UJ7a/fw?=
 =?us-ascii?Q?XTWHSYAarsO4LEKa7GrfZoXDPYZwBMR8WBvNbUWefkX49KuRDUK/CRNfMfFH?=
 =?us-ascii?Q?ncPunWa/zX89w93/utv8xk4A5n+ZS1AoEGFFrdVx7FZNny9UTUE5YQN2hD4l?=
 =?us-ascii?Q?tf85JcdcZIjbyq6ml9YGZu9/3k3C0jE5VG1XqEgLXlb7rUiBadlxCGbweDJo?=
 =?us-ascii?Q?Ib8K1ky6w28CVusz+3KfSpS9nhcAnhWnCWpPuBn4pNuS/dG2wOrFCUW5UJyc?=
 =?us-ascii?Q?u0WXmI9K/brZ9eene6uGlK7lZA9nKs3tyKiR7uuzjnLyuHLZadxnKR5zMl6v?=
 =?us-ascii?Q?ei/gTB8mC4yIukvhrSqNhk1yw/5zmnPenmujmb+lfid5PbWbHcrgWjtHOMr+?=
 =?us-ascii?Q?vmuVMjC7rSaWGgwc0a+vMFuJ46jKyiOEZGr17V8tqwYxgm+dYL/II4o1KEeH?=
 =?us-ascii?Q?gHHEOO/E3djKxJcekneu76mOYMSJu8EU1N/YCT9SJxpV0jtpck93w+oEBwfD?=
 =?us-ascii?Q?XLrRsVAJHrK2iPtzBAsUWmsGCqjX5+gHdN3Y2SLoO2OcjTUJzbUQD2ohP1eg?=
 =?us-ascii?Q?98MdYFNnJjK0g+ZI69GLmfDzZB9v03lby4Paf0syGlsN/wqeYIOZ7VUdUXld?=
 =?us-ascii?Q?NvWIIE9CnVQo6b3XcPZtlKzjimLQI2ZNPOcaWy5X2CcyYy4sq/8rJlSM8AD+?=
 =?us-ascii?Q?VNS+pwhpc4aBsCauG5ISpl+k8sxM52ONU9MvIujBi1A3uV2nCBTpX+aUJmlo?=
 =?us-ascii?Q?YGbfpWb9XvnbdZw5HPA9wak1LS2V0gpXZu8KBbSPWDADzKxqlVOIhNM/ec2Y?=
 =?us-ascii?Q?ijMzJe7q1W64wW8vrYmXGit1OI+pYZ1ou6nVnvyFcn97vMk5+RuYjXBNzz/q?=
 =?us-ascii?Q?3vT2ILwhPT+Q6u3Y6de2PHM4Xx5N7HicGHQK8V8m0yhWG8t1UvYsOKUTBO/L?=
 =?us-ascii?Q?KRRG1KHQvcQ6xn3GZ8A71cKam8xI4T1ZU/kyOZfbGhO2QYufD842p4+9ODnG?=
 =?us-ascii?Q?bL+oqiTLyp+ezvSk6DZLTYXNNE138olJgK8NPjMx/wV3xmMZqPFReR83F2NF?=
 =?us-ascii?Q?4bST5CdY5LRGvEmeJut8lprCFnlvcEcv6nbXhSjobiz3LaAqJfBeGIriUZWG?=
 =?us-ascii?Q?dMLhqvizQJ0X+ZJLA5BQLBM5FStQIrO/X2A8T6Stip7Z8jvJGOOsBhqDDjP1?=
 =?us-ascii?Q?NVV+SwBuK3FrKN6054mqoNBtNm/VFt856J7V/JRBCCLa7DcSjIibHYN5xHoF?=
 =?us-ascii?Q?fsRArA73GbgMmdHcxEmqtIbpdfU0GVL73oCO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:44:32.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296999a4-0479-4095-7356-08dd67e7a2b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575

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


