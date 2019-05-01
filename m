Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADCA1072A
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEAKtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 06:49:18 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56431 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAKtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 06:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556707755; x=1588243755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OynV9FLVmkrDVOWwJk0YkzHa/IPGo2lSYw0XY/7Ggk0=;
  b=NXXSKJ1276Pe+11ww5Kmdbt/idzFkVgJWhWePFaIAq6wqIgeM2BR38SE
   X/Dyf8JkK2aYLFscgPxTrYTtYTqc3y0rPlpypjXCMTU+Z9ghSLQZhF866
   E0bCM2ROmh0TIDHGye5FifPeab3kZcaok87GzEzVTg9pvVALc7W6pPmbR
   0=;
X-IronPort-AV: E=Sophos;i="5.60,417,1549929600"; 
   d="scan'208";a="731333129"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 10:49:04 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x41An051009566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 May 2019 10:49:01 GMT
Received: from EX13D19UWA002.ant.amazon.com (10.43.160.204) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:57 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D19UWA002.ant.amazon.com (10.43.160.204) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:56 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 1 May 2019 10:48:52 +0000
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
Subject: [PATCH for-next v6 06/12] RDMA/efa: Add the com service API definitions
Date:   Wed, 1 May 2019 13:48:18 +0300
Message-ID: <1556707704-11192-7-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Header file for the various commands that can be sent through admin queue.
This includes queue create/modify/destroy, setting up and remove protection
domains, address handlers, and memory registration, etc.

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.h | 270 ++++++++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)
 create mode 100644 drivers/infiniband/hw/efa/efa_com_cmd.h

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
new file mode 100644
index 000000000000..a1174380462c
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_COM_CMD_H_
+#define _EFA_COM_CMD_H_
+
+#include "efa_com.h"
+
+#define EFA_GID_SIZE 16
+
+struct efa_com_create_qp_params {
+	u64 rq_base_addr;
+	u32 send_cq_idx;
+	u32 recv_cq_idx;
+	/*
+	 * Send descriptor ring size in bytes,
+	 * sufficient for user-provided number of WQEs and SGL size
+	 */
+	u32 sq_ring_size_in_bytes;
+	/* Max number of WQEs that will be posted on send queue */
+	u32 sq_depth;
+	/* Recv descriptor ring size in bytes */
+	u32 rq_ring_size_in_bytes;
+	u32 rq_depth;
+	u16 pd;
+	u16 uarn;
+	u8 qp_type;
+};
+
+struct efa_com_create_qp_result {
+	u32 qp_handle;
+	u32 qp_num;
+	u32 sq_db_offset;
+	u32 rq_db_offset;
+	u32 llq_descriptors_offset;
+	u16 send_sub_cq_idx;
+	u16 recv_sub_cq_idx;
+};
+
+struct efa_com_modify_qp_params {
+	u32 modify_mask;
+	u32 qp_handle;
+	u32 qp_state;
+	u32 cur_qp_state;
+	u32 qkey;
+	u32 sq_psn;
+	u8 sq_drained_async_notify;
+};
+
+struct efa_com_query_qp_params {
+	u32 qp_handle;
+};
+
+struct efa_com_query_qp_result {
+	u32 qp_state;
+	u32 qkey;
+	u32 sq_draining;
+	u32 sq_psn;
+};
+
+struct efa_com_destroy_qp_params {
+	u32 qp_handle;
+};
+
+struct efa_com_create_cq_params {
+	/* cq physical base address in OS memory */
+	dma_addr_t dma_addr;
+	/* completion queue depth in # of entries */
+	u16 cq_depth;
+	u16 num_sub_cqs;
+	u16 uarn;
+	u8 entry_size_in_bytes;
+};
+
+struct efa_com_create_cq_result {
+	/* cq identifier */
+	u16 cq_idx;
+	/* actual cq depth in # of entries */
+	u16 actual_depth;
+};
+
+struct efa_com_destroy_cq_params {
+	u16 cq_idx;
+};
+
+struct efa_com_create_ah_params {
+	u16 pdn;
+	/* Destination address in network byte order */
+	u8 dest_addr[EFA_GID_SIZE];
+};
+
+struct efa_com_create_ah_result {
+	u16 ah;
+};
+
+struct efa_com_destroy_ah_params {
+	u16 ah;
+	u16 pdn;
+};
+
+struct efa_com_get_network_attr_result {
+	u8 addr[EFA_GID_SIZE];
+	u32 mtu;
+};
+
+struct efa_com_get_device_attr_result {
+	u64 page_size_cap;
+	u64 max_mr_pages;
+	u32 fw_version;
+	u32 admin_api_version;
+	u32 device_version;
+	u32 supported_features;
+	u32 phys_addr_width;
+	u32 virt_addr_width;
+	u32 max_qp;
+	u32 max_sq_depth; /* wqes */
+	u32 max_rq_depth; /* wqes */
+	u32 max_cq;
+	u32 max_cq_depth; /* cqes */
+	u32 inline_buf_size;
+	u32 max_mr;
+	u32 max_pd;
+	u32 max_ah;
+	u32 max_llq_size;
+	u16 sub_cqs_per_cq;
+	u16 max_sq_sge;
+	u16 max_rq_sge;
+	u8 db_bar;
+};
+
+struct efa_com_get_hw_hints_result {
+	u16 mmio_read_timeout;
+	u16 driver_watchdog_timeout;
+	u16 admin_completion_timeout;
+	u16 poll_interval;
+	u32 reserved[4];
+};
+
+struct efa_com_mem_addr {
+	u32 mem_addr_low;
+	u32 mem_addr_high;
+};
+
+/* Used at indirect mode page list chunks for chaining */
+struct efa_com_ctrl_buff_info {
+	/* indicates length of the buffer pointed by control_buffer_address. */
+	u32 length;
+	/* points to control buffer (direct or indirect) */
+	struct efa_com_mem_addr address;
+};
+
+struct efa_com_reg_mr_params {
+	/* Memory region length, in bytes. */
+	u64 mr_length_in_bytes;
+	/* IO Virtual Address associated with this MR. */
+	u64 iova;
+	/* words 8:15: Physical Buffer List, each element is page-aligned. */
+	union {
+		/*
+		 * Inline array of physical addresses of app pages
+		 * (optimization for short region reservations)
+		 */
+		u64 inline_pbl_array[4];
+		/*
+		 * Describes the next physically contiguous chunk of indirect
+		 * page list. A page list contains physical addresses of command
+		 * data pages. Data pages are 4KB; page list chunks are
+		 * variable-sized.
+		 */
+		struct efa_com_ctrl_buff_info pbl;
+	} pbl;
+	/* number of pages in PBL (redundant, could be calculated) */
+	u32 page_num;
+	/* Protection Domain */
+	u16 pd;
+	/*
+	 * phys_page_size_shift - page size is (1 << phys_page_size_shift)
+	 * Page size is used for building the Virtual to Physical
+	 * address mapping
+	 */
+	u8 page_shift;
+	/*
+	 * permissions
+	 * 0: local_write_enable - Write permissions: value of 1 needed
+	 * for RQ buffers and for RDMA write:1: reserved1 - remote
+	 * access flags, etc
+	 */
+	u8 permissions;
+	u8 inline_pbl;
+	u8 indirect;
+};
+
+struct efa_com_reg_mr_result {
+	/*
+	 * To be used in conjunction with local buffers references in SQ and
+	 * RQ WQE
+	 */
+	u32 l_key;
+	/*
+	 * To be used in incoming RDMA semantics messages to refer to remotely
+	 * accessed memory region
+	 */
+	u32 r_key;
+};
+
+struct efa_com_dereg_mr_params {
+	u32 l_key;
+};
+
+struct efa_com_alloc_pd_result {
+	u16 pdn;
+};
+
+struct efa_com_dealloc_pd_params {
+	u16 pdn;
+};
+
+struct efa_com_alloc_uar_result {
+	u16 uarn;
+};
+
+struct efa_com_dealloc_uar_params {
+	u16 uarn;
+};
+
+void efa_com_set_dma_addr(dma_addr_t addr, u32 *addr_high, u32 *addr_low);
+int efa_com_create_qp(struct efa_com_dev *edev,
+		      struct efa_com_create_qp_params *params,
+		      struct efa_com_create_qp_result *res);
+int efa_com_modify_qp(struct efa_com_dev *edev,
+		      struct efa_com_modify_qp_params *params);
+int efa_com_query_qp(struct efa_com_dev *edev,
+		     struct efa_com_query_qp_params *params,
+		     struct efa_com_query_qp_result *result);
+int efa_com_destroy_qp(struct efa_com_dev *edev,
+		       struct efa_com_destroy_qp_params *params);
+int efa_com_create_cq(struct efa_com_dev *edev,
+		      struct efa_com_create_cq_params *params,
+		      struct efa_com_create_cq_result *result);
+int efa_com_destroy_cq(struct efa_com_dev *edev,
+		       struct efa_com_destroy_cq_params *params);
+int efa_com_register_mr(struct efa_com_dev *edev,
+			struct efa_com_reg_mr_params *params,
+			struct efa_com_reg_mr_result *result);
+int efa_com_dereg_mr(struct efa_com_dev *edev,
+		     struct efa_com_dereg_mr_params *params);
+int efa_com_create_ah(struct efa_com_dev *edev,
+		      struct efa_com_create_ah_params *params,
+		      struct efa_com_create_ah_result *result);
+int efa_com_destroy_ah(struct efa_com_dev *edev,
+		       struct efa_com_destroy_ah_params *params);
+int efa_com_get_network_attr(struct efa_com_dev *edev,
+			     struct efa_com_get_network_attr_result *result);
+int efa_com_get_device_attr(struct efa_com_dev *edev,
+			    struct efa_com_get_device_attr_result *result);
+int efa_com_get_hw_hints(struct efa_com_dev *edev,
+			 struct efa_com_get_hw_hints_result *result);
+int efa_com_set_aenq_config(struct efa_com_dev *edev, u32 groups);
+int efa_com_alloc_pd(struct efa_com_dev *edev,
+		     struct efa_com_alloc_pd_result *result);
+int efa_com_dealloc_pd(struct efa_com_dev *edev,
+		       struct efa_com_dealloc_pd_params *params);
+int efa_com_alloc_uar(struct efa_com_dev *edev,
+		      struct efa_com_alloc_uar_result *result);
+int efa_com_dealloc_uar(struct efa_com_dev *edev,
+			struct efa_com_dealloc_uar_params *params);
+
+#endif /* _EFA_COM_CMD_H_ */
-- 
2.7.4

