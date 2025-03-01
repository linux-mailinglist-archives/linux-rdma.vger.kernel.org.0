Return-Path: <linux-rdma+bounces-8216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7AA4A77B
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F474189C8F7
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE77082E;
	Sat,  1 Mar 2025 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x/JM0p5C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CAB676;
	Sat,  1 Mar 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793029; cv=fail; b=Rs6YAYCvN9nRgMAgX689EeK4FRERe1XHgM5IqfTxOhcN5gUKaU4ksbmebm8D2SWkQcAIxuIrSQnVVk63XqjTVL85w+4EajthDb3jLhw1VwPNyMSTtnG5/aG86Y5cCVLewI8YKRjOJniKiL0X7jUAerFunqHXFZ485wvlbtYifuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793029; c=relaxed/simple;
	bh=KzbuNZ/0Za0zdLRZCLKpXE0+zihQIgNbkJ2CHAIInXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRSWA5jlytWfVb8skGvh2BrOF7+Y9oT85AAJqvD2Kd4UtmAi2tOAoOZUVE6/rZ/+ZyoQ2uxsCK3xdeXH3fZI6AKQ1i+il8pztpBnv58Hwr8rZsw1TOCphQE3Wp4k2RO9wWENYmZazizQHgxd7a8/zHqujGLxS3t3Iv9xivRgsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x/JM0p5C; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYzbt6vCZno5PwQv5UPfs9//Y6VEgETjPUCzQCnUDTHXrhEaLIG5cH8v2RBO4V1QgdOC4bs7o6Jxd4PbXyhoXii6EkMDVb2nbkKAQmuSiUugqw2Zdkz1dmurOhVc8Lnllfq8PuRFD9Be5mX30Y4z8P0fGP/Rx2ioDfGQZOOGDYDiCvlGfXF2mYOcl0qRnCksmWuC/FWgneCJ5kYlsPmCw1lZgVBJAv6PzOY44Oe4KJMN9PwtkBdxvOpZnEvmizPKeOSZ9D4wtAsSJODXBOUJwC6ceJQLAMnrMEbw+oE+3NaEjRQdeeFNcUdlPx/HzzkkQqxHLF+3Aat16VJzymW4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgMcuvs5RUw5JjOTIa4NKzWNtTbTXgjyDUbajiUwinA=;
 b=OnYK4OxRbRCdNmIAQmxzCCwtniEiRh+FNxkq4oJRRPW/aJcn+/wIUXl8hwcmFa4gi45cleSTlmswU1u2CdIisTRTNJ2KTp6p51WfsGuuWSqcRHe1X+Jvypv4N+beRMR06MHO9VcxBkrsE7AK8rsNAnhmCTUceC8JBxDOTtdhXceiFCoe8RyxFJwsP7ghmyLhjDJM3PlWTENhXCLR2xEp3GMRh+Kaa2EsZqE/K+pVj0v8GZaa9mEGPUjXFmJDgfUfGUL46EJnfXUkmtN0PJpQZfvv1vf07agdJuwUiQCcPn77ontpHNnoNPL4MVyD/PWCfllSZ+xNNJEl5uUrdX7qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgMcuvs5RUw5JjOTIa4NKzWNtTbTXgjyDUbajiUwinA=;
 b=x/JM0p5CZvrMtQ1ynOUSYXiv3qIm1l1VY6NX1YIQCbxO5NSnASIZF3BY78cUIauQF1KmQ2wPC6g2wX2G9ANGIOoR7muIKuiLv/fyIBJe4mZQyjkhrElRO1nTcD3tKK8iODxqUgny1eqvTnctCNJSAtNTaQff8lNboXW6i99lkzk=
Received: from SJ0PR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:334::21)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sat, 1 Mar
 2025 01:37:02 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::cb) by SJ0PR05CA0106.outlook.office365.com
 (2603:10b6:a03:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Sat,
 1 Mar 2025 01:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:36:59 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 1/6] pds_core: make pdsc_auxbus_dev_del() void
Date: Fri, 28 Feb 2025 17:35:49 -0800
Message-ID: <20250301013554.49511-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4b7bc1-c225-43df-6306-08dd586190e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0fS9s5diWRWPlMkIG6fHEjXm4KGcWZ14W1m7FqfaflXimqIhQqy+JXu8m38J?=
 =?us-ascii?Q?LfcyxG/cwBGn1uXymVgNkIRC3LJzN4AfTpBkQlK6b+/B/45gEkirIJ/F7D8y?=
 =?us-ascii?Q?c1q9f+qJnygKrDFud/FGYbNFK71LS5hryDoYnqa1brcxI+MZprGYgx24rLfq?=
 =?us-ascii?Q?HmGp3t4UyZt8evpMd/7VtgMnRkv0leK40FWZrBM9GIkBZAvc+jGQhbrNuRAD?=
 =?us-ascii?Q?9EWy2SvRZf26FRix2nUoED2L8L+ghnZEDyUAtuOyabciIskMv+Z6RkI4Y5s0?=
 =?us-ascii?Q?+33TggSfw7e7oO3xW5XpD7N5ShuVWkZi9XJQY9q0niV+cBA8BXfhZmn4oMju?=
 =?us-ascii?Q?0I/1zA3i9AoKleVnaA0j12SqJKu73OlCX5IlRFYBr0PgPpjch9CVq7t4ns8o?=
 =?us-ascii?Q?iZjft94c+UJTI/yEh5G2+MrnYymWDuDtvBvpPRETB86SM2oLiylmtc0/5nm1?=
 =?us-ascii?Q?LYrx90BhGCAmRYPjEH8p+TpOQxvrGYfoy7KFK1XSMYoa6G2N4A4quBmCXPMX?=
 =?us-ascii?Q?iNyjnIf+yxam50Mj8kCNPTqnEU0lZNyYO8x+vrHkrVX59ylANS0auH3ILDMy?=
 =?us-ascii?Q?eLYJUm53u0u87DMf5Cu7YtDh9tNzAHNUTywYdiMkg5jdXuHjs+cUOzDo8a9A?=
 =?us-ascii?Q?JFHvimVPopbVbU60dlmVfCUn4cLKXOYvHcxI+nZxB63shwavAmpxQehjKCva?=
 =?us-ascii?Q?KQqSM+6jyy33YrGSrA2mUSVXQ48bFKCY+/EahJJM7U/UkawwW7xdpQmipBDv?=
 =?us-ascii?Q?A8UGuUe1uCtFIHTNcqeOmQBB3DwaeuaHYAuZunj/LrKllM5hIr/Xyc5UAL0M?=
 =?us-ascii?Q?qiGkGnX5IL7Srq42Qn2aRlJi7jXTArElNmBlVvirxlh+MwPBD1ecxUbdoSgE?=
 =?us-ascii?Q?t+4PhWnno6k1tbWfX6AbwR7lVQbwNqlslQqAsp6PQl2t/F5XfeWxMoGyrj6S?=
 =?us-ascii?Q?orvfcBG05FEeGbS4IfyTGBEco7rUnl828jbJsKhJVMCVo5I0eWopnQzjtX+E?=
 =?us-ascii?Q?RHoFfiqy+pGA7EcesS8PIdrfHfM8xDT+2z7qSsA2iQMETYlnanj9w2C7nRka?=
 =?us-ascii?Q?mk5tkoZ2ccNZ/S5mCvSCEff6attsJxJnY+WEt+ESoV8q461thxmFlxFWaPGh?=
 =?us-ascii?Q?ryrKLdPXPEOAA15NGympO+bwLQk+JR1nJ1dZNlH9lEOtgLY985c445OQbYp8?=
 =?us-ascii?Q?MelTVMyUNsKjxbQBSA48yW+x5jIF1FhBfD6dSYrawpLjMrau1qtErX9XQGcD?=
 =?us-ascii?Q?4pZEjNbu40Ceg7Pg+3bozfl+A9cVCcDdRZ/CqzEEM/jfK4vhQrTw3GIJNL3b?=
 =?us-ascii?Q?oyte3dO5yBV4EIDTYthhuo2SDfanIMuqcK6iEyp2bLxfFA1X3qlFCBfwZLzO?=
 =?us-ascii?Q?sl8f4HrAgnLOCZQ7MUa+EuH2ZDC/5vj0Fn/hKKsoP4VkqGNb0jpH9En8iESG?=
 =?us-ascii?Q?4z4eq6Dpe+ZKb0Ywd8UXZrEpaRK4dRFbs3QzVMFfEXUOgX5yVslz+AY/B+JD?=
 =?us-ascii?Q?a50sgf/Jc2D7Be+iqi1uwnanOZJEo4EMXXNz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:02.1004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4b7bc1-c225-43df-6306-08dd586190e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

Since there really is no useful return, advertising a return value
is rather misleading.  Make pdsc_auxbus_dev_del() a void function.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c  | 8 ++------
 drivers/net/ethernet/amd/pds_core/core.h    | 2 +-
 drivers/net/ethernet/amd/pds_core/devlink.c | 6 ++++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 2babea110991..b1fab95f7eeb 100644
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


