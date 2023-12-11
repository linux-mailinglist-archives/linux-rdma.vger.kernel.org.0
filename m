Return-Path: <linux-rdma+bounces-374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB980D460
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 18:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7FB1F21A15
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2AE4EB20;
	Mon, 11 Dec 2023 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fSyfPg2F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44CC8
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702316843; x=1733852843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=thC8WoEMwnQKwx4Raln/gQLZ0eRZ1zokwKn9I5gAHcI=;
  b=fSyfPg2FJmKmm93dvJBzXIVAyrigP6k4N9uSPuVm2KnMsluu463Yfh1H
   3hwr3oPc+eaT0J5X1n7KOdq3EHhnPW0EQfNUQGIc6kb57JITM29ZPCmat
   93R0P+j5DfqStLUcb+2BMT+SsMxXbK0caCPhW07Izie2KJwxqvmd/POC/
   c=;
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="367810334"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:47:20 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 907CBA43F6;
	Mon, 11 Dec 2023 17:47:19 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:52879]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.100:2525] with esmtp (Farcaster)
 id aba99d19-6979-42f9-88ed-84c22171cf9e; Mon, 11 Dec 2023 17:47:18 +0000 (UTC)
X-Farcaster-Flow-ID: aba99d19-6979-42f9-88ed-84c22171cf9e
Received: from EX19D019EUA001.ant.amazon.com (10.252.50.210) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 17:47:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D019EUA001.ant.amazon.com (10.252.50.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 17:47:17 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 11 Dec 2023 17:47:15
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Anas
 Mousa" <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Date: Mon, 11 Dec 2023 17:47:15 +0000
Message-ID: <20231211174715.7369-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add EFA driver uapi definitions and register a new query MR method that
currently returns the physical PCI buses' IDs the device is using to
reach the MR. Update admin definitions and efa-abi accordingly.

Reviewed-by: Anas Mousa <anasmous@amazon.com>
Reviewed-by: Firas Jahjah <firasj@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h               | 12 +++-
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 31 +++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  9 +++
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 10 +++
 drivers/infiniband/hw/efa/efa_main.c          |  5 ++
 drivers/infiniband/hw/efa/efa_verbs.c         | 69 +++++++++++++++++++
 include/uapi/rdma/efa-abi.h                   | 19 +++++
 7 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 7352a1f5d811..81f5aaf07091 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
@@ -80,9 +80,19 @@ struct efa_pd {
 	u16 pdn;
 };
 
+struct efa_mr_pci_info {
+	u16 recv_pci_bus_id;
+	u16 rdma_read_pci_bus_id;
+	u16 rdma_recv_pci_bus_id;
+	u8 recv_pci_bus_id_valid : 1;
+	u8 rdma_read_pci_bus_id_valid : 1;
+	u8 rdma_recv_pci_bus_id_valid : 1;
+};
+
 struct efa_mr {
 	struct ib_mr ibmr;
 	struct ib_umem *umem;
+	struct efa_mr_pci_info pci_info;
 };
 
 struct efa_cq {
diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 9c65bd27bae0..597f7ca6f31d 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
 	 * memory region
 	 */
 	u32 r_key;
+
+	/*
+	 * Mask indicating which fields have valid values
+	 * 0 : recv_pci_bus_id
+	 * 1 : rdma_read_pci_bus_id
+	 * 2 : rdma_recv_pci_bus_id
+	 */
+	u8 validity;
+
+	/*
+	 * Physical PCIe bus used by the device to reach the MR for receive
+	 * operation
+	 */
+	u8 recv_pci_bus_id;
+
+	/*
+	 * Physical PCIe bus used by the device to reach the MR for RDMA read
+	 * operation
+	 */
+	u8 rdma_read_pci_bus_id;
+
+	/*
+	 * Physical PCIe bus used by the device to reach the MR for RDMA write
+	 * receive
+	 */
+	u8 rdma_recv_pci_bus_id;
 };
 
 struct efa_admin_dereg_mr_cmd {
@@ -999,6 +1025,11 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_WRITE_ENABLE_MASK       BIT(1)
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_MASK        BIT(2)
 
+/* reg_mr_resp */
+#define EFA_ADMIN_REG_MR_RESP_RECV_PCI_BUS_ID_MASK          BIT(0)
+#define EFA_ADMIN_REG_MR_RESP_RDMA_READ_PCI_BUS_ID_MASK     BIT(1)
+#define EFA_ADMIN_REG_MR_RESP_RDMA_RECV_PCI_BUS_ID_MASK     BIT(2)
+
 /* create_cq_cmd */
 #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 576811885d59..4801640f9f4f 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -270,6 +270,15 @@ int efa_com_register_mr(struct efa_com_dev *edev,
 
 	result->l_key = cmd_completion.l_key;
 	result->r_key = cmd_completion.r_key;
+	result->pci_info.recv_pci_bus_id = cmd_completion.recv_pci_bus_id;
+	result->pci_info.rdma_read_pci_bus_id = cmd_completion.rdma_read_pci_bus_id;
+	result->pci_info.rdma_recv_pci_bus_id = cmd_completion.rdma_recv_pci_bus_id;
+	result->pci_info.recv_pci_bus_id_valid = EFA_GET(&cmd_completion.validity,
+							 EFA_ADMIN_REG_MR_RESP_RECV_PCI_BUS_ID);
+	result->pci_info.rdma_read_pci_bus_id_valid = EFA_GET(&cmd_completion.validity,
+							      EFA_ADMIN_REG_MR_RESP_RDMA_READ_PCI_BUS_ID);
+	result->pci_info.rdma_recv_pci_bus_id_valid = EFA_GET(&cmd_completion.validity,
+							      EFA_ADMIN_REG_MR_RESP_RDMA_RECV_PCI_BUS_ID);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index fc97f37bb39b..00635575c3b0 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -199,6 +199,15 @@ struct efa_com_reg_mr_params {
 	u8 indirect;
 };
 
+struct efa_com_mr_pci_info {
+	u16 recv_pci_bus_id;
+	u16 rdma_read_pci_bus_id;
+	u16 rdma_recv_pci_bus_id;
+	u8 recv_pci_bus_id_valid : 1;
+	u8 rdma_read_pci_bus_id_valid : 1;
+	u8 rdma_recv_pci_bus_id_valid : 1;
+};
+
 struct efa_com_reg_mr_result {
 	/*
 	 * To be used in conjunction with local buffers references in SQ and
@@ -210,6 +219,7 @@ struct efa_com_reg_mr_result {
 	 * accessed memory region
 	 */
 	u32 r_key;
+	struct efa_com_mr_pci_info pci_info;
 };
 
 struct efa_com_dereg_mr_params {
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 15ee92081118..da4f378c7c16 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -9,6 +9,7 @@
 #include <linux/version.h>
 
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "efa.h"
 
@@ -36,6 +37,8 @@ MODULE_DEVICE_TABLE(pci, efa_pci_tbl);
 	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
 	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
 
+extern const struct uapi_definition efa_uapi_defs[];
+
 /* This handler will called for unknown event group or unimplemented handlers */
 static void unimplemented_aenq_handler(void *data,
 				       struct efa_admin_aenq_entry *aenq_e)
@@ -432,6 +435,8 @@ static int efa_ib_device_add(struct efa_dev *dev)
 
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
 
+	dev->ibdev.driver_def = efa_uapi_defs;
+
 	err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
 	if (err)
 		goto err_destroy_eqs;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0f8ca99d0827..408dc7fa3a4a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -13,6 +13,9 @@
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/uverbs_ioctl.h>
+#define UVERBS_MODULE_NAME efa_ib
+#include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_user_ioctl_cmds.h>
 
 #include "efa.h"
 #include "efa_io_defs.h"
@@ -1653,6 +1656,12 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
 	mr->ibmr.lkey = result.l_key;
 	mr->ibmr.rkey = result.r_key;
 	mr->ibmr.length = length;
+	mr->pci_info.recv_pci_bus_id = result.pci_info.recv_pci_bus_id;
+	mr->pci_info.rdma_read_pci_bus_id = result.pci_info.rdma_read_pci_bus_id;
+	mr->pci_info.rdma_recv_pci_bus_id = result.pci_info.rdma_recv_pci_bus_id;
+	mr->pci_info.recv_pci_bus_id_valid = result.pci_info.recv_pci_bus_id_valid;
+	mr->pci_info.rdma_read_pci_bus_id_valid = result.pci_info.rdma_read_pci_bus_id_valid;
+	mr->pci_info.rdma_recv_pci_bus_id_valid = result.pci_info.rdma_recv_pci_bus_id_valid;
 	ibdev_dbg(&dev->ibdev, "Registered mr[%d]\n", mr->ibmr.lkey);
 
 	return 0;
@@ -1735,6 +1744,39 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	return ERR_PTR(err);
 }
 
+static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_mr *ibmr = uverbs_attr_get_obj(attrs, EFA_IB_ATTR_QUERY_MR_HANDLE);
+	struct efa_mr *mr = to_emr(ibmr);
+	u16 pci_bus_id_validity;
+	int ret;
+
+	ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_PCI_BUS_ID,
+			     &mr->pci_info.recv_pci_bus_id, sizeof(mr->pci_info.recv_pci_bus_id));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_PCI_BUS_ID,
+			     &mr->pci_info.rdma_read_pci_bus_id, sizeof(mr->pci_info.rdma_read_pci_bus_id));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_PCI_BUS_ID,
+			     &mr->pci_info.rdma_recv_pci_bus_id, sizeof(mr->pci_info.rdma_recv_pci_bus_id));
+	if (ret)
+		return ret;
+
+	pci_bus_id_validity = (mr->pci_info.recv_pci_bus_id_valid ?
+			       EFA_QUERY_MR_VALIDITY_RECV_PCI_BUS_ID : 0) |
+			      (mr->pci_info.rdma_read_pci_bus_id_valid ?
+			       EFA_QUERY_MR_VALIDITY_RDMA_READ_PCI_BUS_ID : 0) |
+			      (mr->pci_info.rdma_recv_pci_bus_id_valid ?
+			       EFA_QUERY_MR_VALIDITY_RDMA_RECV_PCI_BUS_ID : 0);
+
+	return uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
+			      &pci_bus_id_validity, sizeof(pci_bus_id_validity));
+}
+
 int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibmr->device);
@@ -2157,3 +2199,30 @@ enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 	return IB_LINK_LAYER_UNSPECIFIED;
 }
 
+DECLARE_UVERBS_NAMED_METHOD(EFA_IB_METHOD_MR_QUERY,
+			    UVERBS_ATTR_IDR(EFA_IB_ATTR_QUERY_MR_HANDLE,
+					    UVERBS_OBJECT_MR,
+					    UVERBS_ACCESS_READ,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
+						UVERBS_ATTR_TYPE(u16),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_RECV_PCI_BUS_ID,
+						UVERBS_ATTR_TYPE(u16),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_PCI_BUS_ID,
+						UVERBS_ATTR_TYPE(u16),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_PCI_BUS_ID,
+						UVERBS_ATTR_TYPE(u16),
+						UA_MANDATORY));
+
+ADD_UVERBS_METHODS(efa_mr,
+		   UVERBS_OBJECT_MR,
+		   &UVERBS_METHOD(EFA_IB_METHOD_MR_QUERY));
+
+const struct uapi_definition efa_uapi_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_MR,
+				&efa_mr),
+	{},
+};
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index d94c32f28804..7ced04ca2ad9 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -7,6 +7,7 @@
 #define EFA_ABI_USER_H
 
 #include <linux/types.h>
+#include <rdma/ib_user_ioctl_cmds.h>
 
 /*
  * Increment this value if any changes that break userspace ABI
@@ -134,4 +135,22 @@ struct efa_ibv_ex_query_device_resp {
 	__u32 device_caps;
 };
 
+enum {
+	EFA_QUERY_MR_VALIDITY_RECV_PCI_BUS_ID = 1 << 0,
+	EFA_QUERY_MR_VALIDITY_RDMA_READ_PCI_BUS_ID = 1 << 1,
+	EFA_QUERY_MR_VALIDITY_RDMA_RECV_PCI_BUS_ID = 1 << 2,
+};
+
+enum efa_query_mr_attrs {
+	EFA_IB_ATTR_QUERY_MR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
+	EFA_IB_ATTR_QUERY_MR_RESP_RECV_PCI_BUS_ID,
+	EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_PCI_BUS_ID,
+	EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_PCI_BUS_ID,
+};
+
+enum efa_mr_methods {
+	EFA_IB_METHOD_MR_QUERY = (1U << UVERBS_ID_NS_SHIFT),
+};
+
 #endif /* EFA_ABI_USER_H */
-- 
2.40.1


