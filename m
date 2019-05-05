Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183D1141E5
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEESk4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 14:40:56 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39166 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfEESk4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 14:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557081654; x=1588617654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3Vz04EjIJ1fx4Fi0eqtDEc3ZbEfyoBFQKq7zzPY/Ze8=;
  b=qWTi10aCuUKX1SBtGrPR3BG+Irc4FBBev7AZUZRVat4Q7AqmG2+qYYFk
   0MsMKopcosx8s0tuKG+1VAXG1tOq79Cp/BbWjXhOHF+GxxvLm/8QIAKdi
   1EENowV1qknBLiRtI5odQdXnEC6UsPiQzVqn+Y9jByUZjZNND75DQ4Thl
   E=;
X-IronPort-AV: E=Sophos;i="5.60,434,1549929600"; 
   d="scan'208";a="731832829"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 18:40:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x45Iel27056141
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 18:40:51 GMT
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:40 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:38 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.85.90.212) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 5 May 2019 18:40:35 +0000
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
Subject: [PATCH for-next v7 04/11] RDMA/efa: Add the efa_com.h file
Date:   Sun, 5 May 2019 20:59:24 +0300
Message-ID: <1557079171-19329-5-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557079171-19329-1-git-send-email-galpress@amazon.com>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A helper header file for EFA admin queue, admin queue completion, asynchronous
notification queue, and various hardware configuration data structures and
functions.

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
---
 drivers/infiniband/hw/efa/efa_com.h | 144 ++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 drivers/infiniband/hw/efa/efa_com.h

diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
new file mode 100644
index 000000000000..84d96724a74b
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_com.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_COM_H_
+#define _EFA_COM_H_
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/semaphore.h>
+#include <linux/sched.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "efa_common_defs.h"
+#include "efa_admin_defs.h"
+#include "efa_admin_cmds_defs.h"
+#include "efa_regs_defs.h"
+
+#define EFA_MAX_HANDLERS 256
+
+struct efa_com_admin_cq {
+	struct efa_admin_acq_entry *entries;
+	dma_addr_t dma_addr;
+	spinlock_t lock; /* Protects ACQ */
+
+	u16 cc; /* consumer counter */
+	u8 phase;
+};
+
+struct efa_com_admin_sq {
+	struct efa_admin_aq_entry *entries;
+	dma_addr_t dma_addr;
+	spinlock_t lock; /* Protects ASQ */
+
+	u32 __iomem *db_addr;
+
+	u16 cc; /* consumer counter */
+	u16 pc; /* producer counter */
+	u8 phase;
+
+};
+
+/* Don't use anything other than atomic64 */
+struct efa_com_stats_admin {
+	atomic64_t aborted_cmd;
+	atomic64_t submitted_cmd;
+	atomic64_t completed_cmd;
+	atomic64_t no_completion;
+};
+
+enum {
+	EFA_AQ_STATE_RUNNING_BIT = 0,
+	EFA_AQ_STATE_POLLING_BIT = 1,
+};
+
+struct efa_com_admin_queue {
+	void *dmadev;
+	void *efa_dev;
+	struct efa_comp_ctx *comp_ctx;
+	u32 completion_timeout; /* usecs */
+	u16 poll_interval; /* msecs */
+	u16 depth;
+	struct efa_com_admin_cq cq;
+	struct efa_com_admin_sq sq;
+	u16 msix_vector_idx;
+
+	unsigned long state;
+
+	/* Count the number of available admin commands */
+	struct semaphore avail_cmds;
+
+	struct efa_com_stats_admin stats;
+
+	spinlock_t comp_ctx_lock; /* Protects completion context pool */
+	u32 *comp_ctx_pool;
+	u16 comp_ctx_pool_next;
+};
+
+struct efa_aenq_handlers;
+
+struct efa_com_aenq {
+	struct efa_admin_aenq_entry *entries;
+	struct efa_aenq_handlers *aenq_handlers;
+	dma_addr_t dma_addr;
+	u32 cc; /* consumer counter */
+	u16 msix_vector_idx;
+	u16 depth;
+	u8 phase;
+};
+
+struct efa_com_mmio_read {
+	struct efa_admin_mmio_req_read_less_resp *read_resp;
+	dma_addr_t read_resp_dma_addr;
+	u16 seq_num;
+	u16 mmio_read_timeout; /* usecs */
+	/* serializes mmio reads */
+	spinlock_t lock;
+};
+
+struct efa_com_dev {
+	struct efa_com_admin_queue aq;
+	struct efa_com_aenq aenq;
+	u8 __iomem *reg_bar;
+	void *dmadev;
+	void *efa_dev;
+	u32 supported_features;
+	u32 dma_addr_bits;
+
+	struct efa_com_mmio_read mmio_read;
+};
+
+typedef void (*efa_aenq_handler)(void *data,
+	      struct efa_admin_aenq_entry *aenq_e);
+
+/* Holds aenq handlers. Indexed by AENQ event group */
+struct efa_aenq_handlers {
+	efa_aenq_handler handlers[EFA_MAX_HANDLERS];
+	efa_aenq_handler unimplemented_handler;
+};
+
+int efa_com_admin_init(struct efa_com_dev *edev,
+		       struct efa_aenq_handlers *aenq_handlers);
+void efa_com_admin_destroy(struct efa_com_dev *edev);
+int efa_com_dev_reset(struct efa_com_dev *edev,
+		      enum efa_regs_reset_reason_types reset_reason);
+void efa_com_set_admin_polling_mode(struct efa_com_dev *edev, bool polling);
+void efa_com_admin_q_comp_intr_handler(struct efa_com_dev *edev);
+int efa_com_mmio_reg_read_init(struct efa_com_dev *edev);
+void efa_com_mmio_reg_read_destroy(struct efa_com_dev *edev);
+
+int efa_com_validate_version(struct efa_com_dev *edev);
+int efa_com_get_dma_width(struct efa_com_dev *edev);
+
+int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
+		     struct efa_admin_aq_entry *cmd,
+		     size_t cmd_size,
+		     struct efa_admin_acq_entry *comp,
+		     size_t comp_size);
+void efa_com_aenq_intr_handler(struct efa_com_dev *edev, void *data);
+
+#endif /* _EFA_COM_H_ */
-- 
2.7.4

