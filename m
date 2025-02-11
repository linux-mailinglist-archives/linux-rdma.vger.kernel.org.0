Return-Path: <linux-rdma+bounces-7663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4841A319EB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D243A8C98
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E33226B96B;
	Tue, 11 Feb 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Luh4Qir"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795626A08F;
	Tue, 11 Feb 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317767; cv=fail; b=VJylKxkasyS6tBRkvuOYw+638TONRwrs4g60mc7Fl9t2XlJZmKPdJGzWCfgnO99F6A95v6J545O+q+Ng3FdTiDiJQ/upNj+tkwsJa2sPwe7Z4v9HpK2NrUVYPRRs1AqupnbtpqTLB60z3jcoqeBcclYF8OowvFxKjOSuxju2gMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317767; c=relaxed/simple;
	bh=6gokwYo/qIJ+5iXK3wCe2DdKHN0/HdtbHlNOgc+WG94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxbI4MDvDGdHQAZAFtBW1l4abkkKS7Nhr8xPZRIv53QiBHOFd7F2t8d4maZYxo0UpauuP010Jy8ybTHvEhoaFTL5wegnFIUIYLP6EKeJDpjH4jaD1KkI4QHhXrgPhEk/t8MfCsALupnYzi0HMajISnBguuGPuHHpYy1PWe0e1QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Luh4Qir; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyRdY/CavFcp33JMsVvnCzLRYWbikFmoivwPbj0wU7ux9eOvdjEuLWGnmJQ1D2YU2Cpe5K++kESxFrEU9iMEXM90x42OmMKbLqyXqHPbu9VKrw0CH1J43WNSS24zZStbIiVdfXkTyNe/L44W8Nf4HvEHhLc6OoF8W1y8lOX4UutrfmpqQ7nW/fGn4NZffxzYzEM7mDovCBgGoqvYZdS93hZ5rOWEZ7k7YKYSNmntaauUB21dOq1XTFKI7JdkvC2jcXuUGzwtVU3x85BJ7EKa6wxLoYI/AUpP1yA8TxJ+8YMOEW6PgQ0d2nEu8YO/wBo4RPe5a5ntPZBFf1yYut8A1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbh4Zdd2Ig7frew6Bt92q5FnJIMBMex3hWxhmQKjSmk=;
 b=GD873zfbcz1NCJq8bIyCyC0ieebK1Je5PN+9G+hf3hHvek7F84I9jAOxLRJSFw019SaZ96PxS1Zi1SLt3u3SMtuNYIx0cglMWCzrVh+I0nfVqFKW63V14IMZsezBlAbGC8VB3z1TIlhxuI7VI586jRhkEcr3ApunI0Ny2uYi6FQ1HpciDeIaxd99YHdyVVhaC/DTcOLXzeTb6iGYXOnFF3RWUddNU/ckQ4sJBj6RQgWESHNMde5cU9erwVyVZlK2Q49Z+6so1SMjW2NrAXN9LMBmEECBRGVEwXhwfIUAWaORQczcOcvjWhK+Uk9smiKihkok5X4OMeCztSli7aZGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbh4Zdd2Ig7frew6Bt92q5FnJIMBMex3hWxhmQKjSmk=;
 b=0Luh4QirGJ1uA7TqXnNqbuCiCrUFpP5VdkankSLYS8sPXmkpnM6IJCCxdyVAaVGpkN1JQMAOcmva52AWxRs5DoFkt/oSIT4x/vTiCmCL6IrxGHeJge7So5YGgzMUkXGm5m0D+uM2Z+sGx0bymg5OPyRBvwjuLK1DJk8S1MZNHkc=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Tue, 11 Feb
 2025 23:49:18 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::fd) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Tue,
 11 Feb 2025 23:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 23:49:18 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:15 -0600
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
Subject: [RFC PATCH fwctl 4/5] pds_fwctl: add rpc and query support
Date: Tue, 11 Feb 2025 15:48:53 -0800
Message-ID: <20250211234854.52277-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 59312965-721d-4baf-ab4b-08dd4af6b30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLJN6UVDAf83uTN8TGa0j/0Pkp7q0H2Vo7S+YQHpNnZxv/PVgk8B2ZaK9RKm?=
 =?us-ascii?Q?2ncqSMB+/JJc0dnWB+AuW3iQNKWqXvQ964oXDaYkbVd6oiHIwXUluBvTQJl1?=
 =?us-ascii?Q?TwZOr3iXFfpcNhYVON84vOF0H2fqoem/BjTps17+r6EBKDqTAPZY2hexzE5j?=
 =?us-ascii?Q?3wnmDA64vSA4hZ2Jt4Gc0vi28lOcSc38Y52us8VgGHjr1kI0vY+tYe2TklvK?=
 =?us-ascii?Q?ZbAttQ8DuNrJ+WOFH8jOIDqIiz/r64cLkGIt3002gSXfN099wjeZtkxud/K5?=
 =?us-ascii?Q?0gPONUezWAPVUwEKJocyT14c/3+2GUUir1971bQ9MkHFci528eqiOQ7teSlA?=
 =?us-ascii?Q?Ea0R1+dULLKAMg2RrbMkgHcg8PAOzXvtrgDw6eII5YO1IPtLEoDC4tRxE0s8?=
 =?us-ascii?Q?aRPeWUHPuqVRtovUJuZEEizVG+UFcnubBkzsSBrlWDX0G7BA5j8HoMefMl22?=
 =?us-ascii?Q?8Fo222ijjOu67eU2H/p5x9RXjlwiJoNquWOtALreIvSlHP48xdAGXr427F4D?=
 =?us-ascii?Q?9t+UXHJsHKPBiLHjSupaG6ijFjKbFbQ4AN418+YUwyUgesz5A/QOInsVO+Mz?=
 =?us-ascii?Q?a4wM/5GK9UBCstT5nCv6dAd3o596V8Ro6DGDFoi+WQ4aDUSYVDoF5mXjabmt?=
 =?us-ascii?Q?F6+VpQlPVXaN+lpRlZmIRWo7ymkRaNYDVsgbZNdUm9qkxiW6KSmAqp6YQZSW?=
 =?us-ascii?Q?9X9V266cXl553MW4hCbj5v/YIAGmaoWtEZdBIXdQQr2E1Zr1EfC4/0h+uXlD?=
 =?us-ascii?Q?mVqBcTY50iHSJjaOy5ZmHgIgagj4KbmVSebrpiYNIqXnI5ymB6emfIYF76XB?=
 =?us-ascii?Q?UiM75LWUSLdsCG5uovuR6YuKaRSXhR/+goVF2ac7uaOiJCp4XHbZ7RzN+MdC?=
 =?us-ascii?Q?UY6LK2F12qIm7K/X1wbO4lRx8KYyl99/YlzzZpc1JsS0mCbxtoi+cbP0iMjn?=
 =?us-ascii?Q?SxY+2bME5f58QeO9iqDG6Z+UmeZraaB5UXd8OB4IZaRq9JApu+zPVSJKewp2?=
 =?us-ascii?Q?75r831A5XHb8J/4uUEOtGljM+h+DLaY4Km86x94KhUblBlmYIFWy2h+iYUGS?=
 =?us-ascii?Q?f/FXxvQOX+1s6ui4STOLEWuWVxYKMKfXSN8dXyyOW/mXbJ1vbMa1xclaUfvu?=
 =?us-ascii?Q?ntpxxRfu4Ho4Ujgfj/Hq7+0ZtOmKpQ17RXOyjOuY8Qb9XW9J5LJU+I3WmJkf?=
 =?us-ascii?Q?AKpGXm7nQYFWzZl4D79Hh1Jp+g5mNXQzJPQ/N5EqYbkYU1gil3e5R3cncpZ+?=
 =?us-ascii?Q?FQSFxt5Yx7KrHdl3dpQuIbcDv5L6Wz3DVUKXnQsgzQXeAiloRb5etcymofTf?=
 =?us-ascii?Q?5am+FZ87Oi8O5L7iwTy6RozifZMCBihKVFGqp+Z+xlvN3D6v0/KIGHZSrUEf?=
 =?us-ascii?Q?pxNrgeJoEfpwU4pgdPycYbglGQQFAYc6yRA+9QNdixYd52nXpzYx0GU7rkeo?=
 =?us-ascii?Q?HkfrU9kAQFhLvbbfUa4Laqm7nnt4YQmnwo+qIpwrflaMhnjtA6SrmEfoT/LB?=
 =?us-ascii?Q?OLKnuLAKXG50Ugs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:49:18.0990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59312965-721d-4baf-ab4b-08dd4af6b30a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

From: Brett Creeley <brett.creeley@amd.com>

The pds_fwctl driver doesn't know what RPC operations are available
in the firmware, so also doesn't know what scope they might have.  The
userland utility supplies the firmware "endpoint" and "operation" id values
and this driver queries the firmware for endpoints and their available
operations.  The operation descriptions include the scope information
which the driver uses for scope testing.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/fwctl/pds/main.c       | 369 ++++++++++++++++++++++++++++++++-
 include/linux/pds/pds_adminq.h | 187 +++++++++++++++++
 include/uapi/fwctl/pds.h       |  16 ++
 3 files changed, 569 insertions(+), 3 deletions(-)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 24979fe0deea..b60a66ef1fac 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -15,12 +15,22 @@
 #include <linux/pds/pds_adminq.h>
 #include <linux/pds/pds_auxbus.h>
 
+DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
+DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
+
 struct pdsfc_uctx {
 	struct fwctl_uctx uctx;
 	u32 uctx_caps;
 	u32 uctx_uid;
 };
 
+struct pdsfc_rpc_endpoint_info {
+	u32 endpoint;
+	dma_addr_t operations_pa;
+	struct pds_fwctl_query_data *operations;
+	struct mutex lock;	/* lock for endpoint info management */
+};
+
 struct pdsfc_dev {
 	struct fwctl_device fwctl;
 	struct pds_auxiliary_dev *padev;
@@ -28,6 +38,9 @@ struct pdsfc_dev {
 	u32 caps;
 	dma_addr_t ident_pa;
 	struct pds_fwctl_ident *ident;
+	dma_addr_t endpoints_pa;
+	struct pds_fwctl_query_data *endpoints;
+	struct pdsfc_rpc_endpoint_info *endpoint_info;
 };
 DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
 
@@ -112,10 +125,351 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
 	return 0;
 }
 
+static void pdsfc_free_endpoints(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+
+	if (pdsfc->endpoints) {
+		int i;
+
+		for (i = 0; pdsfc->endpoint_info && i < pdsfc->endpoints->num_entries; i++)
+			mutex_destroy(&pdsfc->endpoint_info[i].lock);
+		vfree(pdsfc->endpoint_info);
+		pdsfc->endpoint_info = NULL;
+		dma_free_coherent(dev->parent, PAGE_SIZE,
+				  pdsfc->endpoints, pdsfc->endpoints_pa);
+		pdsfc->endpoints = NULL;
+		pdsfc->endpoints_pa = DMA_MAPPING_ERROR;
+	}
+}
+
+static void pdsfc_free_operations(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+	int i;
+
+	for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
+		struct pdsfc_rpc_endpoint_info *ei = &pdsfc->endpoint_info[i];
+
+		if (ei->operations) {
+			dma_free_coherent(dev->parent, PAGE_SIZE,
+					  ei->operations, ei->operations_pa);
+			ei->operations = NULL;
+			ei->operations_pa = DMA_MAPPING_ERROR;
+		}
+	}
+}
+
+static struct pds_fwctl_query_data *pdsfc_get_endpoints(struct pdsfc_dev *pdsfc,
+							dma_addr_t *pa)
+{
+	struct pds_fwctl_query_data_endpoint *entries = NULL;
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	union pds_core_adminq_cmd cmd = {0};
+	struct pds_fwctl_query_data *data;
+	dma_addr_t data_pa;
+	int err;
+	int i;
+
+	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev, data_pa);
+	if (err) {
+		dev_err(dev, "Failed to map endpoint list\n");
+		return ERR_PTR(err);
+	}
+
+	cmd.fwctl_query.opcode = PDS_FWCTL_CMD_QUERY;
+	cmd.fwctl_query.entity = PDS_FWCTL_RPC_ROOT;
+	cmd.fwctl_query.version = 0;
+	cmd.fwctl_query.query_data_buf_len = cpu_to_le32(PAGE_SIZE);
+	cmd.fwctl_query.query_data_buf_pa = cpu_to_le64(data_pa);
+
+	dev_dbg(dev, "cmd: opcode %d entity %d version %d query_data_buf_len %d query_data_buf_pa %llx\n",
+		cmd.fwctl_query.opcode, cmd.fwctl_query.entity, cmd.fwctl_query.version,
+		le32_to_cpu(cmd.fwctl_query.query_data_buf_len),
+		le64_to_cpu(cmd.fwctl_query.query_data_buf_pa));
+
+	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
+	if (err) {
+		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
+			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
+		dma_free_coherent(dev->parent, PAGE_SIZE, data, data_pa);
+		return ERR_PTR(err);
+	}
+
+	*pa = data_pa;
+
+	entries = (struct pds_fwctl_query_data_endpoint *)data->entries;
+	dev_dbg(dev, "num_entries %d\n", data->num_entries);
+	for (i = 0; i < data->num_entries; i++)
+		dev_dbg(dev, "endpoint: id %d\n", entries[i].id);
+
+	return data;
+}
+
+static int pdsfc_init_endpoints(struct pdsfc_dev *pdsfc)
+{
+	struct pds_fwctl_query_data_endpoint *ep_entry;
+	struct device *dev = &pdsfc->fwctl.dev;
+	int i;
+
+	pdsfc->endpoints = pdsfc_get_endpoints(pdsfc, &pdsfc->endpoints_pa);
+	if (IS_ERR(pdsfc->endpoints)) {
+		dev_err(dev, "Failed to query endpoints\n");
+		return PTR_ERR(pdsfc->endpoints);
+	}
+
+	pdsfc->endpoint_info = vcalloc(pdsfc->endpoints->num_entries,
+				       sizeof(*pdsfc->endpoint_info));
+	if (!pdsfc->endpoint_info) {
+		dev_err(dev, "Failed to allocate endpoint_info array\n");
+		pdsfc_free_endpoints(pdsfc);
+		return -ENOMEM;
+	}
+
+	ep_entry = (struct pds_fwctl_query_data_endpoint *)pdsfc->endpoints->entries;
+	for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
+		mutex_init(&pdsfc->endpoint_info[i].lock);
+		pdsfc->endpoint_info[i].endpoint = ep_entry[i].id;
+	}
+
+	return 0;
+}
+
+static struct pds_fwctl_query_data *pdsfc_get_operations(struct pdsfc_dev *pdsfc,
+							 dma_addr_t *pa, u32 ep)
+{
+	struct pds_fwctl_query_data_operation *entries = NULL;
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	union pds_core_adminq_cmd cmd = {0};
+	struct pds_fwctl_query_data *data;
+	dma_addr_t data_pa;
+	int err;
+	int i;
+
+	/* Query the operations list for the given endpoint */
+	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev->parent, data_pa);
+	if (err) {
+		dev_err(dev, "Failed to map operations list\n");
+		return ERR_PTR(err);
+	}
+
+	cmd.fwctl_query.opcode = PDS_FWCTL_CMD_QUERY;
+	cmd.fwctl_query.entity = PDS_FWCTL_RPC_ENDPOINT;
+	cmd.fwctl_query.version = 0;
+	cmd.fwctl_query.query_data_buf_len = cpu_to_le32(PAGE_SIZE);
+	cmd.fwctl_query.query_data_buf_pa = cpu_to_le64(data_pa);
+	cmd.fwctl_query.ep = cpu_to_le32(ep);
+
+	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
+	if (err) {
+		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
+			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
+		dma_free_coherent(dev->parent, PAGE_SIZE, data, data_pa);
+		return ERR_PTR(err);
+	}
+
+	*pa = data_pa;
+
+	entries = (struct pds_fwctl_query_data_operation *)data->entries;
+	dev_dbg(dev, "num_entries %d\n", data->num_entries);
+	for (i = 0; i < data->num_entries; i++)
+		dev_dbg(dev, "endpoint %d operation: id %x scope %d\n",
+			ep, entries[i].id, entries[i].scope);
+
+	return data;
+}
+
+static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
+			      struct fwctl_rpc_pds *rpc,
+			      enum fwctl_rpc_scope scope)
+{
+	struct pds_fwctl_query_data_operation *op_entry = NULL;
+	struct pdsfc_rpc_endpoint_info *ep_info = NULL;
+	struct device *dev = &pdsfc->fwctl.dev;
+	int i;
+
+	if (!pdsfc->ident) {
+		dev_err(dev, "Ident not available\n");
+		return -EINVAL;
+	}
+
+	/* validate rpc in_len & out_len based
+	 * on ident->max_req_sz & max_resp_sz
+	 */
+	if (rpc->in.len > pdsfc->ident->max_req_sz) {
+		dev_err(dev, "Invalid request size %u, max %u\n",
+			rpc->in.len, pdsfc->ident->max_req_sz);
+		return -EINVAL;
+	}
+
+	if (rpc->out.len > pdsfc->ident->max_resp_sz) {
+		dev_err(dev, "Invalid response size %u, max %u\n",
+			rpc->out.len, pdsfc->ident->max_resp_sz);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
+		if (pdsfc->endpoint_info[i].endpoint == rpc->in.ep) {
+			ep_info = &pdsfc->endpoint_info[i];
+			break;
+		}
+	}
+	if (!ep_info) {
+		dev_err(dev, "Invalid endpoint %d\n", rpc->in.ep);
+		return -EINVAL;
+	}
+
+	/* query and cache this endpoint's operations */
+	mutex_lock(&ep_info->lock);
+	if (!ep_info->operations) {
+		ep_info->operations = pdsfc_get_operations(pdsfc,
+							   &ep_info->operations_pa,
+							   rpc->in.ep);
+		if (!ep_info->operations) {
+			mutex_unlock(&ep_info->lock);
+			dev_err(dev, "Failed to allocate operations list\n");
+			return -ENOMEM;
+		}
+	}
+	mutex_unlock(&ep_info->lock);
+
+	/* reject unsupported and/or out of scope commands */
+	op_entry = (struct pds_fwctl_query_data_operation *)ep_info->operations->entries;
+	for (i = 0; i < ep_info->operations->num_entries; i++) {
+		if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {
+			if (scope < op_entry[i].scope)
+				return -EPERM;
+			return 0;
+		}
+	}
+
+	dev_err(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
+
+	return -EINVAL;
+}
+
 static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 			  void *in, size_t in_len, size_t *out_len)
 {
-	return NULL;
+	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
+	struct fwctl_rpc_pds *rpc = (struct fwctl_rpc_pds *)in;
+	void *out_payload __free(kfree_errptr) = NULL;
+	void *in_payload __free(kfree_errptr) = NULL;
+	struct device *dev = &uctx->fwctl->dev;
+	union pds_core_adminq_comp comp = {0};
+	dma_addr_t out_payload_dma_addr = 0;
+	union pds_core_adminq_cmd cmd = {0};
+	dma_addr_t in_payload_dma_addr = 0;
+	void *out = NULL;
+	int err;
+
+	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
+	if (err) {
+		dev_err(dev, "Invalid RPC request\n");
+		return ERR_PTR(err);
+	}
+
+	if (rpc->in.len > 0) {
+		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
+		if (!in_payload) {
+			dev_err(dev, "Failed to allocate in_payload\n");
+			out = ERR_PTR(-ENOMEM);
+			goto done;
+		}
+
+		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
+				   rpc->in.len)) {
+			dev_err(dev, "Failed to copy in_payload from user\n");
+			out = ERR_PTR(-EFAULT);
+			goto done;
+		}
+
+		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
+						     rpc->in.len, DMA_TO_DEVICE);
+		err = dma_mapping_error(dev->parent, in_payload_dma_addr);
+		if (err) {
+			dev_err(dev, "Failed to map in_payload\n");
+			out = ERR_PTR(err);
+			goto done;
+		}
+	}
+
+	if (rpc->out.len > 0) {
+		out_payload = kzalloc(rpc->out.len, GFP_KERNEL);
+		if (!out_payload) {
+			dev_err(dev, "Failed to allocate out_payload\n");
+			out = ERR_PTR(-ENOMEM);
+			goto done;
+		}
+
+		out_payload_dma_addr = dma_map_single(dev->parent, out_payload,
+						      rpc->out.len, DMA_FROM_DEVICE);
+		err = dma_mapping_error(dev->parent, out_payload_dma_addr);
+		if (err) {
+			dev_err(dev, "Failed to map out_payload\n");
+			out = ERR_PTR(err);
+			goto done;
+		}
+	}
+
+	cmd.fwctl_rpc.opcode = PDS_FWCTL_CMD_RPC;
+	cmd.fwctl_rpc.flags = PDS_FWCTL_RPC_IND_REQ | PDS_FWCTL_RPC_IND_RESP;
+	cmd.fwctl_rpc.ep = cpu_to_le32(rpc->in.ep);
+	cmd.fwctl_rpc.op = cpu_to_le32(rpc->in.op);
+	cmd.fwctl_rpc.req_pa = cpu_to_le64(in_payload_dma_addr);
+	cmd.fwctl_rpc.req_sz = cpu_to_le32(rpc->in.len);
+	cmd.fwctl_rpc.resp_pa = cpu_to_le64(out_payload_dma_addr);
+	cmd.fwctl_rpc.resp_sz = cpu_to_le32(rpc->out.len);
+
+	dev_dbg(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d\n",
+		__func__, rpc->in.ep, rpc->in.op,
+		cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
+		cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems);
+
+	dynamic_hex_dump("in ", DUMP_PREFIX_OFFSET, 16, 1, in_payload, rpc->in.len, true);
+
+	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
+	if (err) {
+		dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
+			__func__, rpc->in.ep, rpc->in.op,
+			cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
+			cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
+			err);
+		out = ERR_PTR(err);
+		goto done;
+	}
+
+	dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
+
+	dev_dbg(dev, "%s: status %d comp_index %d err %d resp_sz %d color %d\n",
+		__func__, comp.fwctl_rpc.status, comp.fwctl_rpc.comp_index,
+		comp.fwctl_rpc.err, comp.fwctl_rpc.resp_sz,
+		comp.fwctl_rpc.color);
+
+	if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
+		dev_err(dev, "Failed to copy out_payload to user\n");
+		out = ERR_PTR(-EFAULT);
+		goto done;
+	}
+
+	rpc->out.retval = le32_to_cpu(comp.fwctl_rpc.err);
+	*out_len = in_len;
+	out = in;
+
+done:
+	if (in_payload_dma_addr)
+		dma_unmap_single(dev->parent, in_payload_dma_addr,
+				 rpc->in.len, DMA_TO_DEVICE);
+
+	if (out_payload_dma_addr)
+		dma_unmap_single(dev->parent, out_payload_dma_addr,
+				 rpc->out.len, DMA_FROM_DEVICE);
+
+	return out;
 }
 
 static const struct fwctl_ops pdsfc_ops = {
@@ -150,16 +504,23 @@ static int pdsfc_probe(struct auxiliary_device *adev,
 		return err;
 	}
 
+	err = pdsfc_init_endpoints(pdsfc);
+	if (err) {
+		dev_err(dev, "Failed to init endpoints, err %d\n", err);
+		goto free_ident;
+	}
+
 	err = fwctl_register(&pdsfc->fwctl);
 	if (err) {
 		dev_err(dev, "Failed to register device, err %d\n", err);
-		return err;
+		goto free_endpoints;
 	}
-
 	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
 
 	return 0;
 
+free_endpoints:
+	pdsfc_free_endpoints(pdsfc);
 free_ident:
 	pdsfc_free_ident(pdsfc);
 	return err;
@@ -170,6 +531,8 @@ static void pdsfc_remove(struct auxiliary_device *adev)
 	struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
 
 	fwctl_unregister(&pdsfc->fwctl);
+	pdsfc_free_operations(pdsfc);
+	pdsfc_free_endpoints(pdsfc);
 	pdsfc_free_ident(pdsfc);
 }
 
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 7fc353b63353..33cd03388b15 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1181,6 +1181,8 @@ struct pds_lm_host_vf_status_cmd {
 
 enum pds_fwctl_cmd_opcode {
 	PDS_FWCTL_CMD_IDENT		= 70,
+	PDS_FWCTL_CMD_RPC		= 71,
+	PDS_FWCTL_CMD_QUERY		= 72,
 };
 
 /**
@@ -1251,6 +1253,187 @@ struct pds_fwctl_ident {
 	u8     max_resp_sg_elems;
 } __packed;
 
+enum pds_fwctl_query_entity {
+	PDS_FWCTL_RPC_ROOT	= 0,
+	PDS_FWCTL_RPC_ENDPOINT	= 1,
+	PDS_FWCTL_RPC_OPERATION	= 2,
+};
+
+#define PDS_FWCTL_RPC_OPCODE_CMD_SHIFT	0
+#define PDS_FWCTL_RPC_OPCODE_CMD_MASK	GENMASK(15, PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
+#define PDS_FWCTL_RPC_OPCODE_VER_SHIFT	16
+#define PDS_FWCTL_RPC_OPCODE_VER_MASK	GENMASK(23, PDS_FWCTL_RPC_OPCODE_VER_SHIFT)
+
+#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)	\
+	(((op) & PDS_FWCTL_RPC_OPCODE_CMD_MASK) >> PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
+#define PDS_FWCTL_RPC_OPCODE_GET_VER(op)	\
+	(((op) & PDS_FWCTL_RPC_OPCODE_VER_MASK) >> PDS_FWCTL_RPC_OPCODE_VER_SHIFT)
+
+#define PDS_FWCTL_RPC_OPCODE_CMP(op1, op2) \
+	(PDS_FWCTL_RPC_OPCODE_GET_CMD(op1) == PDS_FWCTL_RPC_OPCODE_GET_CMD(op2) && \
+	 PDS_FWCTL_RPC_OPCODE_GET_VER(op1) <= PDS_FWCTL_RPC_OPCODE_GET_VER(op2))
+
+/**
+ * struct pds_fwctl_query_cmd - Firmware control query command structure
+ * @opcode: Operation code for the command
+ * @entity:  Entity type to query (enum pds_fwctl_query_entity)
+ * @version: Version of the query data structure supported by the driver
+ * @rsvd:    Word boundary padding
+ * @query_data_buf_len: Length of the query data buffer
+ * @query_data_buf_pa:  Physical address of the query data buffer
+ * @ep:      Endpoint identifier to query  (when entity is PDS_FWCTL_RPC_ENDPOINT)
+ * @op:      Operation identifier to query (when entity is PDS_FWCTL_RPC_OPERATION)
+ *
+ * This structure is used to send a query command to the firmware control
+ * interface. The structure is packed to ensure there is no padding between
+ * the fields.
+ */
+struct pds_fwctl_query_cmd {
+	u8     opcode;
+	u8     entity;
+	u8     version;
+	u8     rsvd;
+	__le32 query_data_buf_len;
+	__le64 query_data_buf_pa;
+	union {
+		__le32 ep;
+		__le32 op;
+	};
+} __packed;
+
+/**
+ * struct pds_fwctl_query_comp - Firmware control query completion structure
+ * @status:     Status of the query command
+ * @rsvd:       Word boundary padding
+ * @comp_index: Completion index in little-endian format
+ * @version:    Version of the query data structure returned by firmware. This
+ *		 should be less than or equal to the version supported by the driver.
+ * @rsvd2:      Word boundary padding
+ * @color:      Color bit indicating the state of the completion
+ */
+struct pds_fwctl_query_comp {
+	u8     status;
+	u8     rsvd;
+	__le16 comp_index;
+	u8     version;
+	u8     rsvd2[2];
+	u8     color;
+} __packed;
+
+/**
+ * struct pds_fwctl_query_data_endpoint - query data for entity PDS_FWCTL_RPC_ROOT
+ * @id: The identifier for the data endpoint.
+ */
+struct pds_fwctl_query_data_endpoint {
+	__le32 id;
+} __packed;
+
+/**
+ * struct pds_fwctl_query_data_operation - query data for entity PDS_FWCTL_RPC_ENDPOINT
+ * @id:    Operation identifier.
+ * @scope: Scope of the operation (enum fwctl_rpc_scope).
+ * @rsvd:  Word boundary padding
+ */
+struct pds_fwctl_query_data_operation {
+	__le32 id;
+	u8     scope;
+	u8     rsvd[3];
+} __packed;
+
+/**
+ * struct pds_fwctl_query_data - query data structure
+ * @version:     Version of the query data structure
+ * @rsvd:        Word boundary padding
+ * @num_entries: Number of entries in the union
+ * @entries:     Array of query data entries, depending on the entity type.
+ */
+struct pds_fwctl_query_data {
+	u8      version;
+	u8      rsvd[3];
+	__le32  num_entries;
+	uint8_t entries[];
+} __packed;
+
+/**
+ * struct pds_fwctl_rpc_cmd - Firmware control RPC command.
+ * @opcode:        opcode PDS_FWCTL_CMD_RPC
+ * @rsvd:          Word boundary padding
+ * @flags:         Indicates indirect request and/or response handling
+ * @ep:            Endpoint identifier.
+ * @op:            Operation identifier.
+ * @inline_req0:   Buffer for inline request
+ * @inline_req1:   Buffer for inline request
+ * @req_pa:        Physical address of request data.
+ * @req_sz:        Size of the request.
+ * @req_sg_elems:  Number of request SGs
+ * @req_rsvd:      Word boundary padding
+ * @inline_req2:   Buffer for inline request
+ * @resp_pa:       Physical address of response data.
+ * @resp_sz:       Size of the response.
+ * @resp_sg_elems: Number of response SGs
+ * @resp_rsvd:     Word boundary padding
+ */
+struct pds_fwctl_rpc_cmd {
+	u8     opcode;
+	u8     rsvd;
+	__le16 flags;
+#define PDS_FWCTL_RPC_IND_REQ		0x1
+#define PDS_FWCTL_RPC_IND_RESP		0x2
+	__le32 ep;
+	__le32 op;
+	u8 inline_req0[16];
+	union {
+		u8 inline_req1[16];
+		struct {
+			__le64 req_pa;
+			__le32 req_sz;
+			u8     req_sg_elems;
+			u8     req_rsvd[3];
+		};
+	};
+	union {
+		u8 inline_req2[16];
+		struct {
+			__le64 resp_pa;
+			__le32 resp_sz;
+			u8     resp_sg_elems;
+			u8     resp_rsvd[3];
+		};
+	};
+} __packed;
+
+/**
+ * struct pds_sg_elem - Transmit scatter-gather (SG) descriptor element
+ * @addr:	DMA address of SG element data buffer
+ * @len:	Length of SG element data buffer, in bytes
+ * @rsvd:	Word boundary padding
+ */
+struct pds_sg_elem {
+	__le64 addr;
+	__le32 len;
+	__le16 rsvd[2];
+} __packed;
+
+/**
+ * struct pds_fwctl_rpc_comp - Completion of a firmware control RPC.
+ * @status:     Status of the command
+ * @rsvd:       Word boundary padding
+ * @comp_index: Completion index of the command
+ * @err:        Error code, if any, from the RPC.
+ * @resp_sz:    Size of the response.
+ * @rsvd2:      Word boundary padding
+ * @color:      Color bit indicating the state of the completion.
+ */
+struct pds_fwctl_rpc_comp {
+	u8     status;
+	u8     rsvd;
+	__le16 comp_index;
+	__le32 err;
+	__le32 resp_sz;
+	u8     rsvd2[3];
+	u8     color;
+} __packed;
+
 union pds_core_adminq_cmd {
 	u8     opcode;
 	u8     bytes[64];
@@ -1291,6 +1474,8 @@ union pds_core_adminq_cmd {
 
 	struct pds_fwctl_cmd		  fwctl;
 	struct pds_fwctl_ident_cmd	  fwctl_ident;
+	struct pds_fwctl_rpc_cmd	  fwctl_rpc;
+	struct pds_fwctl_query_cmd	  fwctl_query;
 };
 
 union pds_core_adminq_comp {
@@ -1320,6 +1505,8 @@ union pds_core_adminq_comp {
 	struct pds_lm_dirty_status_comp	  lm_dirty_status;
 
 	struct pds_fwctl_comp		  fwctl;
+	struct pds_fwctl_rpc_comp	  fwctl_rpc;
+	struct pds_fwctl_query_comp	  fwctl_query;
 };
 
 #ifndef __CHECKER__
diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
index a01b032cbdb1..da6cd2d1c6fa 100644
--- a/include/uapi/fwctl/pds.h
+++ b/include/uapi/fwctl/pds.h
@@ -24,4 +24,20 @@ enum pds_fwctl_capabilities {
 	PDS_FWCTL_QUERY_CAP = 0,
 	PDS_FWCTL_SEND_CAP,
 };
+
+struct fwctl_rpc_pds {
+	struct {
+		__u32 op;
+		__u32 ep;
+		__u32 rsvd;
+		__u32 len;
+		__u64 payload;
+	} in;
+	struct {
+		__u32 retval;
+		__u32 rsvd[2];
+		__u32 len;
+		__u64 payload;
+	} out;
+};
 #endif /* _UAPI_FWCTL_PDS_H_ */
-- 
2.17.1


