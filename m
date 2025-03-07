Return-Path: <linux-rdma+bounces-8485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C2A570DF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE373B92CA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3624E011;
	Fri,  7 Mar 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y4OPvo04"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAE2459DD;
	Fri,  7 Mar 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373648; cv=fail; b=p1XIq1iNrQK+5Ig/s5Kjqq1SN1Qg3q4LNcQp9dkTXftatBAtb7qrRanZRwGrlmIWcDnuKXI1/phsfQjz4Z2lTNqJxo20PpnxHkAh46SXGezNFEydaulUCbQOHvWqt4YuX86Qmt2kDrIJuvdFt7vhhRv/JI0W29pqwlSdYj1WKgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373648; c=relaxed/simple;
	bh=So5wN5tvb4So2WCYJW8lWk+Jx6Fi0Yje/z3ftIldBrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjFLIlUmDclnHeeclPdGSGi9UC1tUEO9yGPnALGbxNxEYGGH9tDfKQaPMQ3ayf3qxkE4yaXLzNg5GAEbVTk0lBgy4+tzqYJ7O+FWYAtDeYvpLBvfui+otsBdtj8N2WglQ2i1U9UrJ+1B3pOIQWwgA1I4RGHS7VKSrojpeSGqfU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y4OPvo04; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBnTpn7aI21iu0qFcYqjX0tIdyewQOSOF52+HIblTMvTw2fHrqLzpfDuCjk5MNXlscIzGH5ehjpThAwU9we/ajfAjECqtiSC0RDIkoVp6dnkHtGmQETz0w3yP7hmUQR4dnnGecZBFZUSv2DaVUG6kKEcdhjyXWOkEo94d9zCEJh3dDvEK/qcrrQps6w250z1LB0ZiYSIqn8d1DKc4AFO3OZk7YuZSrsbt0oCLwCmwQ1aAy1Og9NXt6dC4skAX68ZHsxFuPbSPMjPUsIO3955Vk51/iRBrPfVdSY20xHH5XmjIYSlVRHmJAPD148BP7P01NAoMN75UAbl0g8OE4vlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwhDxHbxznDHqreGZ6VjhdiqokPdiP7RunSHHIAWIzA=;
 b=x1e8CfS0B7O8wFpFeZwjkRfougyhnL9ZiMP/fgdrirPB0NSVFybK1BwJ1wl95zL8os1P5AqBBYugyYZGFExPCQ5/BSphcukHLFBm4f7z/U6ZdkiQVddWuP+ko7SvlHO5cK35GgT5iVyqfnc9YKWH3uDKbtop/JtpLbbu8ZADk//u4arESfTb2VgZaQhLlTgBEMRGMU9uNyh1zZeS3Vi0/VRHbs8U1+KQEE/fTShxcsmltJLClGi+u8GhWE6e7SKmX/Axu1NiT9EyN+rT4B9YK1+qoz7WSKG/Nj6Nsfq6/79llyl867RJi9ezgH91dC4lNKWq9QIyJKJZROaGUn3PUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwhDxHbxznDHqreGZ6VjhdiqokPdiP7RunSHHIAWIzA=;
 b=Y4OPvo04UZCaOLRdaOUGrn+FB65OmngRVa5Pz6QPNySNTU2Sb7o3r7aSavASqXmHfZox8LcXCTCTbQ8oCkhyjRG8tqCxIdxXKyeFJuo4fqT8MM/SsdUPCGvvOT14F/FgIXeYVVsOociVb1SaT9qTira7bzouQuSpRaYmRi5v6HM=
Received: from BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::10)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 18:53:59 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2d) by BL1P221CA0023.outlook.office365.com
 (2603:10b6:208:2c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 18:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:53:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:57 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 5/6] pds_fwctl: add rpc and query support
Date: Fri, 7 Mar 2025 10:53:28 -0800
Message-ID: <20250307185329.35034-6-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e98016-f72f-4431-1ba2-08dd5da96be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pg1k38l3cqS9GUHu28tNvhHpM3+hhJZA1Mi0J9NXdf/Gt77TDdHJ64eUFtAH?=
 =?us-ascii?Q?rm+Mlxti2a/3IEr26IIozz70C1rOkKvfbstShXWZZKfs5mwk0a6KYJnJmWjo?=
 =?us-ascii?Q?N5lf/uijaa5xrk1DuXWz+cXF3k+iCSqhUuOYS4tbM9pSGUsp2VTlXVis/J+7?=
 =?us-ascii?Q?mKcqWc20zTp0NYZ2HuwEeU+tc5Ep12pCXTWg6oDg/+1SlT0Qe2Nyr8J/8R+n?=
 =?us-ascii?Q?6uqPD8pcqBvjqvKc+0JHaLDHcRlDoL0t3oX7kuPaTldt8TqllYLouAg9Z9WK?=
 =?us-ascii?Q?s6djInKRlL4Ngq/c8izAShWc4z2h2ffIY8PmlVUpArxU5u1y8wmgwxoDck0L?=
 =?us-ascii?Q?kvYdJ1lMO2FP5fzx9PX7/H1N3iGFsMDdiPSUfg/VFL0soVRPlrrCXgz9dyFs?=
 =?us-ascii?Q?8CC3O/PzU5EXUnsxzKHLv4jp8Rppr3Z4DoeP8aFI7R6YeT8frdxMMNnYzAsd?=
 =?us-ascii?Q?1oERI9S0aBn4km74sHg8rPYfBFuJunXISC+9z8MyYHOUYZU+Vh4oROf+H/IF?=
 =?us-ascii?Q?RkN1mPXMExlJj2kHiUlgKb9/PPJg6HpyGzGf+sCotUSJ+DcFrLTV+5FX/Bj5?=
 =?us-ascii?Q?aDcDjJLAYD+EvD+WkfklvViOaeQs4BPBtbkVsPjipZomNubcXeMYW148DML1?=
 =?us-ascii?Q?PtFzVRazcSGhUwL8n9LH+b3IKSue+vyOLwr/vdHCkjXNQyrdYq1j8I6m8TNR?=
 =?us-ascii?Q?Vg4yGKbKf7m0zfTZMNiWEIF/MB0qz2MsHL4nF/p1+lzYmJfseR3WQE46cO/H?=
 =?us-ascii?Q?obEU2wvTfrU1REQgeuYXHm6753Ej0L7xRNPsCRb7eQV/12GSBBPNsf9/bhGb?=
 =?us-ascii?Q?9kUmfMBn1ZlWUj+/cm0kCAXpOR56/aKJ2kz+TQY/4Z+xWSrirr0e5cYbd4TU?=
 =?us-ascii?Q?i6sxV4k/DkKsZgSwGX9Iz4b0PnZKECJF5X5YvGskr1mgS6U1VeDGoyOMOfZd?=
 =?us-ascii?Q?0qOwKZ89PzAf7O6PYAJzr6YSMSvFhvHDsIpIY8j4vHXYsQpmSP34qNcWapZS?=
 =?us-ascii?Q?sfPkUNGVJMMYem25kxfgyj4Codhv6zC0kJIivJmUCF9fN+Im5kd3UGoAMXkQ?=
 =?us-ascii?Q?SP4f1OKzj1CgcsUF/KN7YsD4AtdOKnuMkvIQnNBRoI8fotY1qfVddQhNWNp4?=
 =?us-ascii?Q?IOLtTEeBHl7xmN5nnxGiuaeUOr9oLqFYT8RW4c1Zx+wEH11xShYmshVImtrc?=
 =?us-ascii?Q?pbphEN3yub814SrbCD1b+B5YOUkQhjNP4lvqVFkwzEeK2zDU371qI5NXmCLi?=
 =?us-ascii?Q?crYWfaj/xcYmH88x19BFyEHmvPjE7fMb65xItH4b+S2tUIsfVlEgczpJ9W5K?=
 =?us-ascii?Q?kDK9d9HGX2oWw+Y3H5oc6Ci4PenmFOvnfjUNvP4YXrOy4aFLWQ+mJWdnljnf?=
 =?us-ascii?Q?AtQkS/SFYh+hIMG7HdShoMWWoORN/W/Kl4gDerTKnCSHSA/c3K+eUnWIQVjX?=
 =?us-ascii?Q?JWJpMHn4rOQglC9OBtA82DRJgtrilskGPR28wP61X8b7FE7Qx6a1G8elhCNO?=
 =?us-ascii?Q?nMhy6X8joxQ2fZmmZ3OjRXaJA6NT1dvMnMxE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:59.6846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e98016-f72f-4431-1ba2-08dd5da96be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235

From: Brett Creeley <brett.creeley@amd.com>

The pds_fwctl driver doesn't know what RPC operations are available
in the firmware, so also doesn't know what scope they might have.  The
userland utility supplies the firmware "endpoint" and "operation" id values
and this driver queries the firmware for endpoints and their available
operations.  The operation descriptions include the scope information
which the driver uses for scope testing.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/fwctl/pds/main.c       | 339 ++++++++++++++++++++++++++++++++-
 include/linux/pds/pds_adminq.h | 185 ++++++++++++++++++
 include/uapi/fwctl/pds.h       |  16 ++
 3 files changed, 539 insertions(+), 1 deletion(-)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 27942315a602..5b5e99ab1297 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -20,11 +20,21 @@ struct pdsfc_uctx {
 	u32 uctx_caps;
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
 	u32 caps;
 	struct pds_fwctl_ident ident;
+	dma_addr_t endpoints_pa;
+	struct pds_fwctl_query_data *endpoints;
+	struct pdsfc_rpc_endpoint_info *endpoint_info;
 };
 
 static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
@@ -92,10 +102,327 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
 	return err;
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
+		dev_dbg(dev, "Invalid request size %u, max %u\n",
+			rpc->in.len, pdsfc->ident.max_req_sz);
+		return -EINVAL;
+	}
+
+	if (rpc->out.len > pdsfc->ident.max_resp_sz) {
+		dev_dbg(dev, "Invalid response size %u, max %u\n",
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
+		dev_dbg(dev, "Invalid endpoint %d\n", rpc->in.ep);
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
+	dev_dbg(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
+
+	return -EINVAL;
+}
+
 static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 			  void *in, size_t in_len, size_t *out_len)
 {
-	return NULL;
+	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
+	struct device *dev = &uctx->fwctl->dev;
+	union pds_core_adminq_comp comp = {0};
+	dma_addr_t out_payload_dma_addr = 0;
+	dma_addr_t in_payload_dma_addr = 0;
+	struct fwctl_rpc_pds *rpc = in;
+	union pds_core_adminq_cmd cmd;
+	void *out_payload = NULL;
+	void *in_payload = NULL;
+	void *out = NULL;
+	int err;
+
+	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
+	if (err)
+		return ERR_PTR(err);
+
+	if (rpc->in.len > 0) {
+		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
+		if (!in_payload) {
+			dev_err(dev, "Failed to allocate in_payload\n");
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
+				   rpc->in.len)) {
+			dev_dbg(dev, "Failed to copy in_payload from user\n");
+			err = -EFAULT;
+			goto err_in_payload;
+		}
+
+		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
+						     rpc->in.len, DMA_TO_DEVICE);
+		err = dma_mapping_error(dev->parent, in_payload_dma_addr);
+		if (err) {
+			dev_dbg(dev, "Failed to map in_payload\n");
+			goto err_in_payload;
+		}
+	}
+
+	if (rpc->out.len > 0) {
+		out_payload = kzalloc(rpc->out.len, GFP_KERNEL);
+		if (!out_payload) {
+			dev_dbg(dev, "Failed to allocate out_payload\n");
+			err = -ENOMEM;
+			goto err_out_payload;
+		}
+
+		out_payload_dma_addr = dma_map_single(dev->parent, out_payload,
+						      rpc->out.len, DMA_FROM_DEVICE);
+		err = dma_mapping_error(dev->parent, out_payload_dma_addr);
+		if (err) {
+			dev_dbg(dev, "Failed to map out_payload\n");
+			goto err_out_payload;
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
+		dev_dbg(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
+			__func__, rpc->in.ep, rpc->in.op,
+			cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
+			cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
+			err);
+		goto done;
+	}
+
+	dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
+
+	if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
+		dev_dbg(dev, "Failed to copy out_payload to user\n");
+		out = ERR_PTR(-EFAULT);
+		goto done;
+	}
+
+	rpc->out.retval = le32_to_cpu(comp.fwctl_rpc.err);
+	*out_len = in_len;
+	out = in;
+
+done:
+	if (out_payload_dma_addr)
+		dma_unmap_single(dev->parent, out_payload_dma_addr,
+				 rpc->out.len, DMA_FROM_DEVICE);
+err_out_payload:
+	kfree(out_payload);
+
+	if (in_payload_dma_addr)
+		dma_unmap_single(dev->parent, in_payload_dma_addr,
+				 rpc->in.len, DMA_TO_DEVICE);
+err_in_payload:
+	kfree(in_payload);
+err_out:
+	if (err)
+		return ERR_PTR(err);
+
+	return out;
 }
 
 static const struct fwctl_ops pdsfc_ops = {
@@ -128,8 +455,15 @@ static int pdsfc_probe(struct auxiliary_device *adev,
 		return dev_err_probe(dev, err, "Failed to identify device\n");
 	}
 
+	err = pdsfc_init_endpoints(pdsfc);
+	if (err) {
+		fwctl_put(&pdsfc->fwctl);
+		return dev_err_probe(dev, err, "Failed to init endpoints\n");
+	}
+
 	err = fwctl_register(&pdsfc->fwctl);
 	if (err) {
+		pdsfc_free_endpoints(pdsfc);
 		fwctl_put(&pdsfc->fwctl);
 		return dev_err_probe(dev, err, "Failed to register device\n");
 	}
@@ -144,6 +478,9 @@ static void pdsfc_remove(struct auxiliary_device *adev)
 	struct pdsfc_dev *pdsfc = auxiliary_get_drvdata(adev);
 
 	fwctl_unregister(&pdsfc->fwctl);
+	pdsfc_free_operations(pdsfc);
+	pdsfc_free_endpoints(pdsfc);
+
 	fwctl_put(&pdsfc->fwctl);
 }
 
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 22c6d77b3dcb..b7f6a1c04957 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1181,6 +1181,8 @@ struct pds_lm_host_vf_status_cmd {
 
 enum pds_fwctl_cmd_opcode {
 	PDS_FWCTL_CMD_IDENT = 70,
+	PDS_FWCTL_CMD_RPC   = 71,
+	PDS_FWCTL_CMD_QUERY = 72,
 };
 
 /**
@@ -1257,6 +1259,185 @@ struct pds_fwctl_ident {
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
+#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)  FIELD_GET(PDS_FWCTL_RPC_OPCODE_CMD_MASK, op)
+#define PDS_FWCTL_RPC_OPCODE_GET_VER(op)  FIELD_GET(PDS_FWCTL_RPC_OPCODE_VER_MASK, op)
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
+ * @rsvd:    Reserved
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
+ * @rsvd:       Reserved
+ * @comp_index: Completion index in little-endian format
+ * @version:    Version of the query data structure returned by firmware. This
+ *		 should be less than or equal to the version supported by the driver
+ * @rsvd2:      Reserved
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
+ * @id: The identifier for the data endpoint
+ */
+struct pds_fwctl_query_data_endpoint {
+	__le32 id;
+} __packed;
+
+/**
+ * struct pds_fwctl_query_data_operation - query data for entity PDS_FWCTL_RPC_ENDPOINT
+ * @id:    Operation identifier
+ * @scope: Scope of the operation (enum fwctl_rpc_scope)
+ * @rsvd:  Reserved
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
+ * @rsvd:        Reserved
+ * @num_entries: Number of entries in the union
+ * @entries:     Array of query data entries, depending on the entity type
+ */
+struct pds_fwctl_query_data {
+	u8      version;
+	u8      rsvd[3];
+	__le32  num_entries;
+	u8      entries[] __counted_by_le(num_entries);
+} __packed;
+
+/**
+ * struct pds_fwctl_rpc_cmd - Firmware control RPC command
+ * @opcode:        opcode PDS_FWCTL_CMD_RPC
+ * @rsvd:          Reserved
+ * @flags:         Indicates indirect request and/or response handling
+ * @ep:            Endpoint identifier
+ * @op:            Operation identifier
+ * @inline_req0:   Buffer for inline request
+ * @inline_req1:   Buffer for inline request
+ * @req_pa:        Physical address of request data
+ * @req_sz:        Size of the request
+ * @req_sg_elems:  Number of request SGs
+ * @req_rsvd:      Reserved
+ * @inline_req2:   Buffer for inline request
+ * @resp_pa:       Physical address of response data
+ * @resp_sz:       Size of the response
+ * @resp_sg_elems: Number of response SGs
+ * @resp_rsvd:     Reserved
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
+ * @rsvd:	Reserved
+ */
+struct pds_sg_elem {
+	__le64 addr;
+	__le32 len;
+	u8     rsvd[4];
+} __packed;
+
+/**
+ * struct pds_fwctl_rpc_comp - Completion of a firmware control RPC
+ * @status:     Status of the command
+ * @rsvd:       Reserved
+ * @comp_index: Completion index of the command
+ * @err:        Error code, if any, from the RPC
+ * @resp_sz:    Size of the response
+ * @rsvd2:      Reserved
+ * @color:      Color bit indicating the state of the completion
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
@@ -1297,6 +1478,8 @@ union pds_core_adminq_cmd {
 
 	struct pds_fwctl_cmd		  fwctl;
 	struct pds_fwctl_ident_cmd	  fwctl_ident;
+	struct pds_fwctl_rpc_cmd	  fwctl_rpc;
+	struct pds_fwctl_query_cmd	  fwctl_query;
 };
 
 union pds_core_adminq_comp {
@@ -1326,6 +1509,8 @@ union pds_core_adminq_comp {
 	struct pds_lm_dirty_status_comp	  lm_dirty_status;
 
 	struct pds_fwctl_comp		  fwctl;
+	struct pds_fwctl_rpc_comp	  fwctl_rpc;
+	struct pds_fwctl_query_comp	  fwctl_query;
 };
 
 #ifndef __CHECKER__
diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
index 558e030b7583..68e68eeab3ae 100644
--- a/include/uapi/fwctl/pds.h
+++ b/include/uapi/fwctl/pds.h
@@ -23,4 +23,20 @@ enum pds_fwctl_capabilities {
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
+		__aligned_u64 payload;
+	} in;
+	struct {
+		__u32 retval;
+		__u32 rsvd[2];
+		__u32 len;
+		__aligned_u64 payload;
+	} out;
+};
 #endif /* _UAPI_FWCTL_PDS_H_ */
-- 
2.17.1


