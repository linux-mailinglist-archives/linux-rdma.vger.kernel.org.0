Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200E41CCAA7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgEJL7p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 07:59:45 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:26520 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgEJL7o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 07:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589111983; x=1620647983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GruYQ561st+SKw+gJ4yF/sXUDVMTVs5afuozd38AIqw=;
  b=YDlBT8A88VQImNAI9E7vUf1oMIvDmh2HLZn7qzSmy40iREbTi80wDual
   nu09MjRZFNgyrDd6EYBwxwQpzzttGF8EGWlB6nsD6CWuTmzzOND9USMip
   mx7Ko0zxS7Fn46NJHytouC/MywuOD7oh6xwez4h89BuD+RyRnYybivZzF
   U=;
IronPort-SDR: p61aF56GgGRQtpvXgDvM0RvCb0ok+6dJYgmKB9uyNyZXwP39GbK1WncMHLJy9tbSphiIe6lWSI
 V0G647uLPb6A==
X-IronPort-AV: E=Sophos;i="5.73,375,1583193600"; 
   d="scan'208";a="29667159"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 May 2020 11:59:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 8D298A1F57;
        Sun, 10 May 2020 11:59:29 +0000 (UTC)
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 11:59:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02EUB004.ant.amazon.com (10.43.166.221) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 11:59:27 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 10 May 2020 11:59:25 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Guy Tzalik" <gtzalik@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Report host information to the device
Date:   Sun, 10 May 2020 14:59:18 +0300
Message-ID: <20200510115918.46246-3-galpress@amazon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510115918.46246-1-galpress@amazon.com>
References: <20200510115918.46246-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The host info feature allows the driver to infrom the EFA device
firmware with system configuration for debugging and troubleshooting
purposes.

The host info buffer is passed as an admin command DMA mapped control
buffer, and is unmapped and freed once the command CQE is consumed.

Currently, the setting of host info is done for each device on its
probe. Failing to set the host info for the device shall not disturb the
probe flow, any errors will be discarded.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Guy Tzalik <gtzalik@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 64 ++++++++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 14 ++--
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 11 +++-
 drivers/infiniband/hw/efa/efa_main.c          | 46 ++++++++++++-
 4 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 96b104ab5415..efdeebc9ea9b 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -37,7 +37,7 @@ enum efa_admin_aq_feature_id {
 	EFA_ADMIN_NETWORK_ATTR                      = 3,
 	EFA_ADMIN_QUEUE_ATTR                        = 4,
 	EFA_ADMIN_HW_HINTS                          = 5,
-	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
+	EFA_ADMIN_HOST_INFO                         = 6,
 };
 
 /* QP transport type */
@@ -799,6 +799,55 @@ struct efa_admin_mmio_req_read_less_resp {
 	u32 reg_val;
 };
 
+enum efa_admin_os_type {
+	EFA_ADMIN_OS_LINUX                          = 0,
+	EFA_ADMIN_OS_WINDOWS                        = 1,
+};
+
+struct efa_admin_host_info {
+	/* OS distribution string format */
+	u8 os_dist_str[128];
+
+	/* Defined in enum efa_admin_os_type */
+	u32 os_type;
+
+	/* Kernel version string format */
+	u8 kernel_ver_str[32];
+
+	/* Kernel version numeric format */
+	u32 kernel_ver;
+
+	/*
+	 * 7:0 : driver_module_type
+	 * 15:8 : driver_sub_minor
+	 * 23:16 : driver_minor
+	 * 31:24 : driver_major
+	 */
+	u32 driver_ver;
+
+	/*
+	 * Device's Bus, Device and Function
+	 * 2:0 : function
+	 * 7:3 : device
+	 * 15:8 : bus
+	 */
+	u16 bdf;
+
+	/*
+	 * Spec version
+	 * 7:0 : spec_minor
+	 * 15:8 : spec_major
+	 */
+	u16 spec_ver;
+
+	/*
+	 * 0 : intree - Intree driver
+	 * 1 : gdr - GPUDirect RDMA supported
+	 * 31:2 : reserved2
+	 */
+	u32 flags;
+};
+
 /* create_qp_cmd */
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
@@ -820,4 +869,17 @@ struct efa_admin_mmio_req_read_less_resp {
 /* feature_device_attr_desc */
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
 
+/* host_info */
+#define EFA_ADMIN_HOST_INFO_DRIVER_MODULE_TYPE_MASK         GENMASK(7, 0)
+#define EFA_ADMIN_HOST_INFO_DRIVER_SUB_MINOR_MASK           GENMASK(15, 8)
+#define EFA_ADMIN_HOST_INFO_DRIVER_MINOR_MASK               GENMASK(23, 16)
+#define EFA_ADMIN_HOST_INFO_DRIVER_MAJOR_MASK               GENMASK(31, 24)
+#define EFA_ADMIN_HOST_INFO_FUNCTION_MASK                   GENMASK(2, 0)
+#define EFA_ADMIN_HOST_INFO_DEVICE_MASK                     GENMASK(7, 3)
+#define EFA_ADMIN_HOST_INFO_BUS_MASK                        GENMASK(15, 8)
+#define EFA_ADMIN_HOST_INFO_SPEC_MINOR_MASK                 GENMASK(7, 0)
+#define EFA_ADMIN_HOST_INFO_SPEC_MAJOR_MASK                 GENMASK(15, 8)
+#define EFA_ADMIN_HOST_INFO_INTREE_MASK                     BIT(0)
+#define EFA_ADMIN_HOST_INFO_GDR_MASK                        BIT(1)
+
 #endif /* _EFA_ADMIN_CMDS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 69f842c92ff6..fabd8df2e78f 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -351,7 +351,7 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 	return 0;
 }
 
-static bool
+bool
 efa_com_check_supported_feature_id(struct efa_com_dev *edev,
 				   enum efa_admin_aq_feature_id feature_id)
 {
@@ -517,12 +517,12 @@ int efa_com_get_hw_hints(struct efa_com_dev *edev,
 	return 0;
 }
 
-static int efa_com_set_feature_ex(struct efa_com_dev *edev,
-				  struct efa_admin_set_feature_resp *set_resp,
-				  struct efa_admin_set_feature_cmd *set_cmd,
-				  enum efa_admin_aq_feature_id feature_id,
-				  dma_addr_t control_buf_dma_addr,
-				  u32 control_buff_size)
+int efa_com_set_feature_ex(struct efa_com_dev *edev,
+			   struct efa_admin_set_feature_resp *set_resp,
+			   struct efa_admin_set_feature_cmd *set_cmd,
+			   enum efa_admin_aq_feature_id feature_id,
+			   dma_addr_t control_buf_dma_addr,
+			   u32 control_buff_size)
 {
 	struct efa_com_admin_queue *aq;
 	int err;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 31db5a0cbd5b..41ce4a476ee6 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_CMD_H_
@@ -270,6 +270,15 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 			    struct efa_com_get_device_attr_result *result);
 int efa_com_get_hw_hints(struct efa_com_dev *edev,
 			 struct efa_com_get_hw_hints_result *result);
+bool
+efa_com_check_supported_feature_id(struct efa_com_dev *edev,
+				   enum efa_admin_aq_feature_id feature_id);
+int efa_com_set_feature_ex(struct efa_com_dev *edev,
+			   struct efa_admin_set_feature_resp *set_resp,
+			   struct efa_admin_set_feature_cmd *set_cmd,
+			   enum efa_admin_aq_feature_id feature_id,
+			   dma_addr_t control_buf_dma_addr,
+			   u32 control_buff_size);
 int efa_com_set_aenq_config(struct efa_com_dev *edev, u32 groups);
 int efa_com_alloc_pd(struct efa_com_dev *edev,
 		     struct efa_com_alloc_pd_result *result);
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index faf3ff1bca2a..f5ef7262683d 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/utsname.h>
 
 #include <rdma/ib_user_verbs.h>
 
@@ -187,6 +188,47 @@ static void efa_stats_init(struct efa_dev *dev)
 		atomic64_set(s, 0);
 }
 
+static void efa_set_host_info(struct efa_dev *dev)
+{
+	struct efa_admin_set_feature_resp resp = {};
+	struct efa_admin_set_feature_cmd cmd = {};
+	struct efa_admin_host_info *hinf;
+	u32 bufsz = sizeof(*hinf);
+	dma_addr_t hinf_dma;
+
+	if (!efa_com_check_supported_feature_id(&dev->edev,
+						EFA_ADMIN_HOST_INFO))
+		return;
+
+	/* Failures in host info set shall not disturb probe */
+	hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
+				  GFP_KERNEL);
+	if (!hinf)
+		return;
+
+	strlcpy(hinf->os_dist_str, utsname()->release,
+		min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
+	hinf->os_type = EFA_ADMIN_OS_LINUX;
+	strlcpy(hinf->kernel_ver_str, utsname()->version,
+		min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
+	hinf->kernel_ver = LINUX_VERSION_CODE;
+	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
+	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
+		PCI_SLOT(dev->pdev->devfn));
+	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
+		PCI_FUNC(dev->pdev->devfn));
+	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
+		EFA_COMMON_SPEC_VERSION_MAJOR);
+	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
+		EFA_COMMON_SPEC_VERSION_MINOR);
+	EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
+
+	efa_com_set_feature_ex(&dev->edev, &resp, &cmd, EFA_ADMIN_HOST_INFO,
+			       hinf_dma, bufsz);
+
+	dma_free_coherent(&dev->pdev->dev, bufsz, hinf, hinf_dma);
+}
+
 static const struct ib_device_ops efa_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_EFA,
@@ -251,6 +293,8 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	if (err)
 		goto err_release_doorbell_bar;
 
+	efa_set_host_info(dev);
+
 	dev->ibdev.node_type = RDMA_NODE_UNSPECIFIED;
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = 1;
-- 
2.26.2

