Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E56141E4
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfEESkz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 14:40:55 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:6905 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEESkz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 14:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557081654; x=1588617654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/Kte5c6hJCiY+tttlYg11Z8YOT4rlX0VvxCC1KoY/1o=;
  b=GyrhfCF7fHcPCVwPP//I9HfP2B3c+4NmZHuSFn0/sZe4UkOIoXT0ZaDc
   aZZdjMXutEaacRjzkgjDuJnz9ft6LsEZlM9E023YgLMYskeV3JSjdBLa0
   Vi3aCi1h79SyGm0TCBa0tFBKXOtfd9BMplq/96plRcufhEaEF3FijLGoR
   I=;
X-IronPort-AV: E=Sophos;i="5.60,434,1549929600"; 
   d="scan'208";a="395235667"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 18:40:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x45IeiT0040123
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 18:40:48 GMT
Received: from EX13D19UWC003.ant.amazon.com (10.43.162.184) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:48 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D19UWC003.ant.amazon.com (10.43.162.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:47 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.85.90.212) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 5 May 2019 18:40:43 +0000
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
Subject: [PATCH for-next v7 06/11] RDMA/efa: Add the ABI definitions
Date:   Sun, 5 May 2019 20:59:26 +0300
Message-ID: <1557079171-19329-7-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557079171-19329-1-git-send-email-galpress@amazon.com>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the EFA ABI file exposed to userspace.

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
---
 include/uapi/rdma/efa-abi.h | 101 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 include/uapi/rdma/efa-abi.h

diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
new file mode 100644
index 000000000000..9599a2a62be8
--- /dev/null
+++ b/include/uapi/rdma/efa-abi.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef EFA_ABI_USER_H
+#define EFA_ABI_USER_H
+
+#include <linux/types.h>
+
+/*
+ * Increment this value if any changes that break userspace ABI
+ * compatibility are made.
+ */
+#define EFA_UVERBS_ABI_VERSION 1
+
+/*
+ * Keep structs aligned to 8 bytes.
+ * Keep reserved fields as arrays of __u8 named reserved_XXX where XXX is the
+ * hex bit offset of the field.
+ */
+
+enum efa_ibv_user_cmds_supp_udata {
+	EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE = 1 << 0,
+	EFA_USER_CMDS_SUPP_UDATA_CREATE_AH    = 1 << 1,
+};
+
+struct efa_ibv_alloc_ucontext_resp {
+	__u32 comp_mask;
+	__u32 cmds_supp_udata_mask;
+	__u16 sub_cqs_per_cq;
+	__u16 inline_buf_size;
+	__u32 max_llq_size; /* bytes */
+};
+
+struct efa_ibv_alloc_pd_resp {
+	__u32 comp_mask;
+	__u16 pdn;
+	__u8 reserved_30[2];
+};
+
+struct efa_ibv_create_cq {
+	__u32 comp_mask;
+	__u32 cq_entry_size;
+	__u16 num_sub_cqs;
+	__u8 reserved_50[6];
+};
+
+struct efa_ibv_create_cq_resp {
+	__u32 comp_mask;
+	__u8 reserved_20[4];
+	__aligned_u64 q_mmap_key;
+	__aligned_u64 q_mmap_size;
+	__u16 cq_idx;
+	__u8 reserved_d0[6];
+};
+
+enum {
+	EFA_QP_DRIVER_TYPE_SRD = 0,
+};
+
+struct efa_ibv_create_qp {
+	__u32 comp_mask;
+	__u32 rq_ring_size; /* bytes */
+	__u32 sq_ring_size; /* bytes */
+	__u32 driver_qp_type;
+};
+
+struct efa_ibv_create_qp_resp {
+	__u32 comp_mask;
+	/* the offset inside the page of the rq db */
+	__u32 rq_db_offset;
+	/* the offset inside the page of the sq db */
+	__u32 sq_db_offset;
+	/* the offset inside the page of descriptors buffer */
+	__u32 llq_desc_offset;
+	__aligned_u64 rq_mmap_key;
+	__aligned_u64 rq_mmap_size;
+	__aligned_u64 rq_db_mmap_key;
+	__aligned_u64 sq_db_mmap_key;
+	__aligned_u64 llq_desc_mmap_key;
+	__u16 send_sub_cq_idx;
+	__u16 recv_sub_cq_idx;
+	__u8 reserved_1e0[4];
+};
+
+struct efa_ibv_create_ah_resp {
+	__u32 comp_mask;
+	__u16 efa_address_handle;
+	__u8 reserved_30[2];
+};
+
+struct efa_ibv_ex_query_device_resp {
+	__u32 comp_mask;
+	__u32 max_sq_wr;
+	__u32 max_rq_wr;
+	__u16 max_sq_sge;
+	__u16 max_rq_sge;
+};
+
+#endif /* EFA_ABI_USER_H */
-- 
2.7.4

