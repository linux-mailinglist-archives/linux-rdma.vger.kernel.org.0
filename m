Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA110727
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfEAKtB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 06:49:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:32512 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEAKtB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556707739; x=1588243739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W42wm8mM/6EQWajWFOBvwPJT9+uYgpcKqWXZp3GneH0=;
  b=Bun/bHM8F/1d9hgd2Tl697O8FLK5I1TViQcItdmYnHCpuoKvy3844aPt
   OpwKIdUYZBk83DfNKqzbgP5ULLD+xVQPhAXd60FNBK8VMhatdo32JeGl5
   e2vJ8V0qiwbQOOPIIGVVeogRij5NTTxR89K2aTmpKHGYw3n1L9hZy7ZXc
   c=;
X-IronPort-AV: E=Sophos;i="5.60,417,1549929600"; 
   d="scan'208";a="672042651"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 10:48:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x41AmsYL009532
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 May 2019 10:48:54 GMT
Received: from EX13D03EUC003.ant.amazon.com (10.43.164.192) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:49 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D03EUC003.ant.amazon.com (10.43.164.192) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:47 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 1 May 2019 10:48:44 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next v6 04/12] RDMA/efa: Add the efa.h header file
Date:   Wed, 1 May 2019 13:48:16 +0300
Message-ID: <1556707704-11192-5-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add EFA driver generic header file defining driver's device independent
internal data structures and definitions.

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
---
 drivers/infiniband/hw/efa/efa.h | 162 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 drivers/infiniband/hw/efa/efa.h

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
new file mode 100644
index 000000000000..0061e6257d1c
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_H_
+#define _EFA_H_
+
+#include <linux/bitops.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/sched.h>
+
+#include <rdma/efa-abi.h>
+#include <rdma/ib_verbs.h>
+
+#include "efa_com_cmd.h"
+
+#define DRV_MODULE_NAME         "efa"
+#define DEVICE_NAME             "Elastic Fabric Adapter (EFA)"
+
+#define EFA_IRQNAME_SIZE        40
+
+/* 1 for AENQ + ADMIN */
+#define EFA_NUM_MSIX_VEC                  1
+#define EFA_MGMNT_MSIX_VEC_IDX            0
+
+struct efa_irq {
+	irq_handler_t handler;
+	void *data;
+	int cpu;
+	u32 vector;
+	cpumask_t affinity_hint_mask;
+	char name[EFA_IRQNAME_SIZE];
+};
+
+struct efa_sw_stats {
+	atomic64_t alloc_pd_err;
+	atomic64_t create_qp_err;
+	atomic64_t create_cq_err;
+	atomic64_t reg_mr_err;
+	atomic64_t alloc_ucontext_err;
+	atomic64_t create_ah_err;
+};
+
+/* Don't use anything other than atomic64 */
+struct efa_stats {
+	struct efa_sw_stats sw_stats;
+	atomic64_t keep_alive_rcvd;
+};
+
+struct efa_dev {
+	struct ib_device ibdev;
+	struct efa_com_dev edev;
+	struct pci_dev *pdev;
+	struct efa_com_get_device_attr_result dev_attr;
+
+	u64 reg_bar_addr;
+	u64 reg_bar_len;
+	u64 mem_bar_addr;
+	u64 mem_bar_len;
+	u64 db_bar_addr;
+	u64 db_bar_len;
+	u8 addr[EFA_GID_SIZE];
+	u32 mtu;
+
+	int admin_msix_vector_idx;
+	struct efa_irq admin_irq;
+
+	struct efa_stats stats;
+};
+
+struct efa_ucontext {
+	struct ib_ucontext ibucontext;
+	struct xarray mmap_xa;
+	u16 uarn;
+};
+
+struct efa_pd {
+	struct ib_pd ibpd;
+	u16 pdn;
+};
+
+struct efa_mr {
+	struct ib_mr ibmr;
+	struct ib_umem *umem;
+};
+
+struct efa_cq {
+	struct ib_cq ibcq;
+	struct efa_ucontext *ucontext;
+	dma_addr_t dma_addr;
+	void *cpu_addr;
+	size_t size;
+	u16 cq_idx;
+};
+
+struct efa_qp {
+	struct ib_qp ibqp;
+	dma_addr_t rq_dma_addr;
+	void *rq_cpu_addr;
+	size_t rq_size;
+	enum ib_qp_state state;
+	u32 qp_handle;
+	u32 max_send_wr;
+	u32 max_recv_wr;
+	u32 max_send_sge;
+	u32 max_recv_sge;
+	u32 max_inline_data;
+};
+
+struct efa_ah {
+	struct ib_ah ibah;
+	u16 ah;
+	/* dest_addr */
+	u8 id[EFA_GID_SIZE];
+};
+
+int efa_query_device(struct ib_device *ibdev,
+		     struct ib_device_attr *props,
+		     struct ib_udata *udata);
+int efa_query_port(struct ib_device *ibdev, u8 port,
+		   struct ib_port_attr *props);
+int efa_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
+		 int qp_attr_mask,
+		 struct ib_qp_init_attr *qp_init_attr);
+int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
+		  union ib_gid *gid);
+int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
+		   u16 *pkey);
+int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
+struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
+			    struct ib_qp_init_attr *init_attr,
+			    struct ib_udata *udata);
+int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+struct ib_cq *efa_create_cq(struct ib_device *ibdev,
+			    const struct ib_cq_init_attr *attr,
+			    struct ib_udata *udata);
+struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
+			 u64 virt_addr, int access_flags,
+			 struct ib_udata *udata);
+int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
+int efa_get_port_immutable(struct ib_device *ibdev, u8 port_num,
+			   struct ib_port_immutable *immutable);
+int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata);
+void efa_dealloc_ucontext(struct ib_ucontext *ibucontext);
+int efa_mmap(struct ib_ucontext *ibucontext,
+	     struct vm_area_struct *vma);
+int efa_create_ah(struct ib_ah *ibah,
+		  struct rdma_ah_attr *ah_attr,
+		  u32 flags,
+		  struct ib_udata *udata);
+void efa_destroy_ah(struct ib_ah *ibah, u32 flags);
+int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
+		  int qp_attr_mask, struct ib_udata *udata);
+enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
+					 u8 port_num);
+
+#endif /* _EFA_H_ */
-- 
2.7.4

