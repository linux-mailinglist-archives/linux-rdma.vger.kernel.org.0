Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05310728
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEAKtF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 06:49:05 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7192 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEAKtF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 06:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556707745; x=1588243745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3Vz04EjIJ1fx4Fi0eqtDEc3ZbEfyoBFQKq7zzPY/Ze8=;
  b=UIwP7jUVXZU7B+Jekh5jBh0Smhl03YF4PhcYHhRoGRHiWcl+O3z0wOMI
   HH/vW947UsTHfvQV6zQxwlWE4fgLG3b7nwG1ifDI+mhB2BpnfPloZAMUh
   hyLxoyB/yfAxw5L73c38ttfR30tzI+Dl5fd3zwo3w58pUdF+k8GXodJTm
   g=;
X-IronPort-AV: E=Sophos;i="5.60,417,1549929600"; 
   d="scan'208";a="797274142"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 10:49:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x41AmvsT058781
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 May 2019 10:49:00 GMT
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:53 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:52 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 1 May 2019 10:48:48 +0000
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
Subject: [PATCH for-next v6 05/12] RDMA/efa: Add the efa_com.h file
Date:   Wed, 1 May 2019 13:48:17 +0300
Message-ID: <1556707704-11192-6-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
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

