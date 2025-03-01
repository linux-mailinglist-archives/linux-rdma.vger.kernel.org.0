Return-Path: <linux-rdma+bounces-8221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEAA4A784
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C7F16D90C
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9951A7264;
	Sat,  1 Mar 2025 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G5AlhSOQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02D18DB24;
	Sat,  1 Mar 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793037; cv=fail; b=fPtYxOLiGX5gUzYVBZbp7nM0EJYx+CarLzAbB2U8+z3m0Av7Gs0ew5tfm36HIqG1n4U2H9Vwrez05nyBnPsRqO4HpzfC+ZkGUso4QtuDK8Ta+yiMPD6xpHBAaz/pg01bQcO/l8jqM/RYadzF0jir2ze9uhdLWzHHtM2m25Q79qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793037; c=relaxed/simple;
	bh=Q64pr+JiltuWlwnDW85+vBt1FeGkuI27mJ0Ey94yZSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozZIlRXraawbu0FzEHJ8TrrWc1R6pwvqNRyqQxWwYcBcni+dfZhiobf7GhiGjVK7BbQDlbedrujYRe97Y7SPWY2ng8PRQJbd7Sd2y1OU1U4fYRNox18AZeuMOOy+vAeSwwTDepPCBj7aHqKfw9eEzFPxDcWYac6L56rRPC0a+BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G5AlhSOQ; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUAAKmSi2veAf3RE3lyc15kHvQNuRTSflUbWHz5vnRZ0R5RW8nc/QCnxtbjAqtTBjArL9g9Hmwdv+4T7nPaIhImM8Jo5stcFw7lxphvr81z6keVixcmcP3vaX/DJ++GO3p+uRyTZJwOc+s1Ab4nolgV2eVoEmGDVoKSQPu4+SJpHfbts72eXMjCu8pCsbQ/wlgq3qV2VbLjSo1vOcMKOgPJ3Qjql92vKY5+vzPsAXfocgZl2coXEDuya2HGRGth+sDuS7XYPl6qiHqiDVvdrFT7KcU9T1y2+WVsICWhcbwycJ72BlOqbq0upQHPQhtQQLJtG1ImPsogQPGDBtfJ+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGuegh5toK3BdGPMRHTxXMojx1MfXCaGLC24/108eEo=;
 b=tSF1WijwxXo+XjJ+WjvkLjF8xfkE3acg15/ns+8MfifVo6DvsPPgeHyY/Y0qpWc79LTqjEwyEGfbC4aKM6zbjX1VKlX7mHByx8QZB57cVC7694CNAh5nEod+G5IdqkpmDwcNONna8sXDmh92u8EHhlTcUoUSSzEqjVOvZrhv+/zzJNt+Ea4GT6ogkwcYtJtndwpWFsVJ8aSS07FF0ft86a1AEdD1a4lAqOOE786oQxCc+4ZwcVnCVVsBigrciCDnKEHwehhA3LROfMQx4dEigiieGULb/wxdJuKWx68L3IdrRT6LA2xvhadCwmO1VWdf129f1OI4s+AlIXKZrZbmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGuegh5toK3BdGPMRHTxXMojx1MfXCaGLC24/108eEo=;
 b=G5AlhSOQGdvGrSBz3ANkK+C+Q1d3RabQBRc8tnTgfIddFiimHzNqK33LLs7Zr9DgjJra69NsMvKat6siB9bi3JoZ+IBK5W2yrVqu5WaB+ngeIvl+u/401c/Hb4q3OLhZLSm7r19UMR5gDBV2zUnwi6nZzkT7SXTL5Tt++euxczs=
Received: from BYAPR06CA0017.namprd06.prod.outlook.com (2603:10b6:a03:d4::30)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 01:37:08 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::44) by BYAPR06CA0017.outlook.office365.com
 (2603:10b6:a03:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Sat,
 1 Mar 2025 01:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:08 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:37:06 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 5/6] pds_fwctl: add rpc and query support
Date: Fri, 28 Feb 2025 17:35:53 -0800
Message-ID: <20250301013554.49511-6-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b789cf3-58c8-4d2a-c327-08dd5861946f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BeJPbIUYUn6ji/A3iSXGKcobqQUwXM4C4pdhJlM7osmAcHnKuSK5pP1158UY?=
 =?us-ascii?Q?bTk4cX+Rf8Bmw3xMhvITYfXgq5+3GPPYfsSSgstdUqDW9gQxDUwMwKdeeRG8?=
 =?us-ascii?Q?Qb0+U8lhhB7e7StuSZKntTxsFNXKIJsz/pVKE3R8vKmnQIwLKXA0eSN7NO6V?=
 =?us-ascii?Q?cQ+mKRsysfWIeJfd6FUOQAegXQRTYsRe7g257514VUDod5iURY0Eb6XKyUtj?=
 =?us-ascii?Q?R78J3XHHerItg1Hs8ZBwqr+g/UkOJjfFcC4dHCtulHVvcGYBPxD5bhlm+S0A?=
 =?us-ascii?Q?qkHkLUP22yO+8GhpBaiOmdXYiDUai+oYXtojHSQFB98GmF4psy/UoYZeXHa+?=
 =?us-ascii?Q?laGK7EYrHPCVJs2YrOnDAHLDqjjwLbXAv9RNB+My7c5Y5ymZ8rsvpBvVKrjh?=
 =?us-ascii?Q?Q2/5tWd681f5p+JRdjriiqqTPU14pe5+GZupBvm7ntcq6MDavGrIjFdjfWFd?=
 =?us-ascii?Q?5UQTfIm72RlVzITMtzVFweMaf7L98pxECrfrb6Lbbtwjmv2i5owsrZtRzP/N?=
 =?us-ascii?Q?+DT+G9A204j9IWqae/4BWVbAxGa8I86wsoTVTFJPg+LOmA3OwN20H8YOlalb?=
 =?us-ascii?Q?iDUqdGa+FMU0TY7/iquZvhJR68TiCk7PtqfWuFiyojciOh4cH9zHf7OO/zaY?=
 =?us-ascii?Q?nmh+EQ+VUryWfGLSgJ649kC20x7DJPRzveJrrJMlbqXM7R2VQFJd0MiQXqNI?=
 =?us-ascii?Q?SqyRvOIsH7dOfz2EvuVnpJgeJdhnsyAGFjLDInTEva4hgJcBfVzrH7KnLPEs?=
 =?us-ascii?Q?+mqj3E893qc5xmPAz28YF5sfX+oAeuuId3fnWBcEAvIhh5D9OuyECkR4jO4c?=
 =?us-ascii?Q?iX7fdpSNushrcTWEmZiyTZKjyzoqGNJjEME32QIpMHv7ojpHRxWs5toVCjvM?=
 =?us-ascii?Q?C1N/43m4N/KEgOzmeC76+NcBWTufjKP9a3WYa0imZgBwiJrPPnG2eEc6yCJX?=
 =?us-ascii?Q?sYl/MKSOhkY2oNtGUl8eW7Di5GpL58ryVrtp+l4NbED+IWuOm52jw0L682tE?=
 =?us-ascii?Q?pUq6uc6EPOqqXN8usChrxvqOUDng9Dil49d6q5wh8xOD4UB/ep0c0fIhnDxm?=
 =?us-ascii?Q?zl+/fAw2tpSu/jnr8GAuyUqrSnWF8SRuQV8ZAEg6UnOmRw07gIUNGc9wYZmt?=
 =?us-ascii?Q?CTvY/CrudUD1Wn4orM3XQY8tFd8Infmmv912ELYEVMWRN7MvI3pBYfVfgXMw?=
 =?us-ascii?Q?0IHJlUi0hpcC+Ej/Ck5sErK9W2hxiIiGmzOY0GkqKVSlMwAMyzUH6pqNgTtw?=
 =?us-ascii?Q?w49tcOl6psoJZV5dRgKSDkP91pPd97q+M30MFcz+ZlsCEM+MmrSg6FT2YPKd?=
 =?us-ascii?Q?dwjWQmKnSYeM5p3xid2BIbHkKyQ56N/j+WronL7Xa0uua8N6a2epDgniC1jB?=
 =?us-ascii?Q?glyghjCU842ANkMXx+gn3oRt6xQInfCF8KQLCtNkKEuW8PSyvdNnvDe8zJFA?=
 =?us-ascii?Q?bqEWWqyQkXwNng3XcKOecnhYoXHzkXhGrcGINkUQ/zf90jIuIAx0Sva8vTn0?=
 =?us-ascii?Q?hPsV3oIWM9ksorWSB4RAY5pqOTCqBdUSVmWp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:08.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b789cf3-58c8-4d2a-c327-08dd5861946f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

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
 drivers/fwctl/pds/main.c       | 343 ++++++++++++++++++++++++++++++++-
 include/linux/pds/pds_adminq.h | 187 ++++++++++++++++++
 include/uapi/fwctl/pds.h       |  16 ++
 3 files changed, 544 insertions(+), 2 deletions(-)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index afc7dc283ad5..bb2ac0ca3963 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -21,12 +21,22 @@ struct pdsfc_uctx {
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
 	struct pdsc *pdsc;
 	u32 caps;
 	struct pds_fwctl_ident ident;
+	dma_addr_t endpoints_pa;
+	struct pds_fwctl_query_data *endpoints;
+	struct pdsfc_rpc_endpoint_info *endpoint_info;
 };
 DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
 
@@ -95,10 +105,331 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
 	return 0;
 }
 
+static void pdsfc_free_endpoints(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+	int i;
+
+	if (!pdsfc->endpoints)
+		return;
+
+	for (i = 0; pdsfc->endpoint_info && i < pdsfc->endpoints->num_entries; i++)
+		mutex_destroy(&pdsfc->endpoint_info[i].lock);
+	vfree(pdsfc->endpoint_info);
+	pdsfc->endpoint_info = NULL;
+	dma_free_coherent(dev->parent, PAGE_SIZE,
+			  pdsfc->endpoints, pdsfc->endpoints_pa);
+	pdsfc->endpoints = NULL;
+	pdsfc->endpoints_pa = DMA_MAPPING_ERROR;
+}
+
+static void pdsfc_free_operations(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+	u32 num_endpoints;
+	int i;
+
+	num_endpoints = le32_to_cpu(pdsfc->endpoints->num_entries);
+	for (i = 0; i < num_endpoints; i++) {
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
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	struct pds_fwctl_query_data *data;
+	union pds_core_adminq_cmd cmd;
+	dma_addr_t data_pa;
+	int err;
+
+	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev, data_pa);
+	if (err) {
+		dev_err(dev, "Failed to map endpoint list\n");
+		return ERR_PTR(err);
+	}
+
+	cmd = (union pds_core_adminq_cmd) {
+		.fwctl_query = {
+			.opcode = PDS_FWCTL_CMD_QUERY,
+			.entity = PDS_FWCTL_RPC_ROOT,
+			.version = 0,
+			.query_data_buf_len = cpu_to_le32(PAGE_SIZE),
+			.query_data_buf_pa = cpu_to_le64(data_pa),
+		}
+	};
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
+	return data;
+}
+
+static int pdsfc_init_endpoints(struct pdsfc_dev *pdsfc)
+{
+	struct pds_fwctl_query_data_endpoint *ep_entry;
+	u32 num_endpoints;
+	int i;
+
+	pdsfc->endpoints = pdsfc_get_endpoints(pdsfc, &pdsfc->endpoints_pa);
+	if (IS_ERR(pdsfc->endpoints))
+		return PTR_ERR(pdsfc->endpoints);
+
+	num_endpoints = le32_to_cpu(pdsfc->endpoints->num_entries);
+	pdsfc->endpoint_info = vcalloc(num_endpoints,
+				       sizeof(*pdsfc->endpoint_info));
+	if (!pdsfc->endpoint_info) {
+		pdsfc_free_endpoints(pdsfc);
+		return -ENOMEM;
+	}
+
+	ep_entry = (struct pds_fwctl_query_data_endpoint *)pdsfc->endpoints->entries;
+	for (i = 0; i < num_endpoints; i++) {
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
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	struct pds_fwctl_query_data *data;
+	union pds_core_adminq_cmd cmd;
+	dma_addr_t data_pa;
+	int err;
+
+	/* Query the operations list for the given endpoint */
+	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev->parent, data_pa);
+	if (err) {
+		dev_err(dev, "Failed to map operations list\n");
+		return ERR_PTR(err);
+	}
+
+	cmd = (union pds_core_adminq_cmd) {
+		.fwctl_query = {
+			.opcode = PDS_FWCTL_CMD_QUERY,
+			.entity = PDS_FWCTL_RPC_ENDPOINT,
+			.version = 0,
+			.query_data_buf_len = cpu_to_le32(PAGE_SIZE),
+			.query_data_buf_pa = cpu_to_le64(data_pa),
+			.ep = cpu_to_le32(ep),
+		}
+	};
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
+	return data;
+}
+
+static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
+			      struct fwctl_rpc_pds *rpc,
+			      enum fwctl_rpc_scope scope)
+{
+	struct pds_fwctl_query_data_operation *op_entry;
+	struct pdsfc_rpc_endpoint_info *ep_info = NULL;
+	struct device *dev = &pdsfc->fwctl.dev;
+	int i;
+
+	/* validate rpc in_len & out_len based
+	 * on ident.max_req_sz & max_resp_sz
+	 */
+	if (rpc->in.len > pdsfc->ident.max_req_sz) {
+		dev_err(dev, "Invalid request size %u, max %u\n",
+			rpc->in.len, pdsfc->ident.max_req_sz);
+		return -EINVAL;
+	}
+
+	if (rpc->out.len > pdsfc->ident.max_resp_sz) {
+		dev_err(dev, "Invalid response size %u, max %u\n",
+			rpc->out.len, pdsfc->ident.max_resp_sz);
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
+	struct device *dev = &uctx->fwctl->dev;
+	union pds_core_adminq_comp comp = {0};
+	dma_addr_t out_payload_dma_addr = 0;
+	dma_addr_t in_payload_dma_addr = 0;
+	union pds_core_adminq_cmd cmd;
+	void *out_payload = NULL;
+	void *in_payload = NULL;
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
+			in_payload_dma_addr = 0;
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
+			out_payload_dma_addr = 0;
+			out = ERR_PTR(err);
+			goto done;
+		}
+	}
+
+	cmd = (union pds_core_adminq_cmd) {
+		.fwctl_rpc = {
+			.opcode = PDS_FWCTL_CMD_RPC,
+			.flags = PDS_FWCTL_RPC_IND_REQ | PDS_FWCTL_RPC_IND_RESP,
+			.ep = cpu_to_le32(rpc->in.ep),
+			.op = cpu_to_le32(rpc->in.op),
+			.req_pa = cpu_to_le64(in_payload_dma_addr),
+			.req_sz = cpu_to_le32(rpc->in.len),
+			.resp_pa = cpu_to_le64(out_payload_dma_addr),
+			.resp_sz = cpu_to_le32(rpc->out.len),
+		}
+	};
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
+	kfree(in_payload);
+	kfree(out_payload);
+
+	return out;
 }
 
 static const struct fwctl_ops pdsfc_ops = {
@@ -131,9 +462,15 @@ static int pdsfc_probe(struct auxiliary_device *adev,
 	if (err)
 		return dev_err_probe(dev, err, "Failed to identify device\n");
 
-	err = fwctl_register(&pdsfc->fwctl);
+	err = pdsfc_init_endpoints(pdsfc);
 	if (err)
+		return dev_err_probe(dev, err, "Failed to init endpoints\n");
+
+	err = fwctl_register(&pdsfc->fwctl);
+	if (err) {
+		pdsfc_free_endpoints(pdsfc);
 		return dev_err_probe(dev, err, "Failed to register device\n");
+	}
 
 	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
 
@@ -145,6 +482,8 @@ static void pdsfc_remove(struct auxiliary_device *adev)
 	struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
 
 	fwctl_unregister(&pdsfc->fwctl);
+	pdsfc_free_operations(pdsfc);
+	pdsfc_free_endpoints(pdsfc);
 }
 
 static const struct auxiliary_device_id pdsfc_id_table[] = {
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index ae6886ebc841..03bca2d27de0 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1181,6 +1181,8 @@ struct pds_lm_host_vf_status_cmd {
 
 enum pds_fwctl_cmd_opcode {
 	PDS_FWCTL_CMD_IDENT = 70,
+	PDS_FWCTL_CMD_RPC   = 71,
+	PDS_FWCTL_CMD_QUERY = 72,
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


