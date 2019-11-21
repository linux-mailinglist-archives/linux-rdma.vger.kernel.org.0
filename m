Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD95410542A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKUOPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 09:15:35 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26551 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKUOPf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 09:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1574345734; x=1605881734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qYZsorG8nb162XHBrupLWaC1HF/artP/auxQB+Eqono=;
  b=WvsvpWg9ZSGp3js0b/MFwQ3SJne9TIgMy/bYvTCdr07F/k6cr5clazYK
   A/Y87u/yIEMJCbHPHrrev9I/+5Vrs13anoGlBWXhWahatu5HcvF7iyZ8p
   jMnvbhFoiRYpAA5TRs0cceey6k3DE1bLGRY8uVQ6IIGIkh3n7KxWYgGgE
   E=;
IronPort-SDR: TPOGJyKlLdzgKD8CdzUR/0Fq9wM+9/VArg/Odu8aJatfxcqzh/N8Y/blgwxHXRGcVdJxFCe4iB
 fAoTtjo58WIw==
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="9057621"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Nov 2019 14:15:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 5B33CA1849;
        Thu, 21 Nov 2019 14:15:24 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 21 Nov 2019 14:15:23 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13EUB001.ant.amazon.com (10.43.166.101) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 21 Nov 2019 14:15:22 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.146) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 14:15:20 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 3/3] RDMA/efa: Expose RDMA read related attributes
Date:   Thu, 21 Nov 2019 16:15:09 +0200
Message-ID: <20191121141509.59297-4-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121141509.59297-1-galpress@amazon.com>
References: <20191121141509.59297-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daniel Kranzdorf <dkkranzd@amazon.com>

Query the device attributes for RDMA operations, including maximum
transfer size and maximum number of SGEs per RDMA WR, and report them
back to the userspace library.

Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 17 ++++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  3 +++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  3 +++
 drivers/infiniband/hw/efa/efa_verbs.c         | 22 ++++++++++++++-----
 include/uapi/rdma/efa-abi.h                   |  6 +++++
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 7fa9d532db61..e96bcb16bd2b 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -562,6 +562,16 @@ struct efa_admin_feature_device_attr_desc {
 
 	/* Indicates how many bits are used virtual address access */
 	u8 virt_addr_width;
+
+	/*
+	 * 0 : rdma_read - If set, RDMA Read is supported on
+	 *    TX queues
+	 * 31:1 : reserved - MBZ
+	 */
+	u32 device_caps;
+
+	/* Max RDMA transfer size in bytes */
+	u32 max_rdma_size;
 };
 
 struct efa_admin_feature_queue_attr_desc {
@@ -608,6 +618,9 @@ struct efa_admin_feature_queue_attr_desc {
 
 	/* The maximum size of LLQ in bytes */
 	u32 max_llq_size;
+
+	/* Maximum number of SGEs for a single RDMA read WQE */
+	u16 max_wr_rdma_sges;
 };
 
 struct efa_admin_feature_aenq_desc {
@@ -622,6 +635,7 @@ struct efa_admin_feature_network_attr_desc {
 	/* Raw address data in network byte order */
 	u8 addr[16];
 
+	/* max packet payload size in bytes */
 	u32 mtu;
 };
 
@@ -797,4 +811,7 @@ struct efa_admin_mmio_req_read_less_resp {
 /* get_set_feature_common_desc */
 #define EFA_ADMIN_GET_SET_FEATURE_COMMON_DESC_SELECT_MASK   GENMASK(1, 0)
 
+/* feature_device_attr_desc */
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
+
 #endif /* _EFA_ADMIN_CMDS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 520c9d920f9e..e20bd84a1014 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -444,6 +444,8 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->phys_addr_width = resp.u.device_attr.phys_addr_width;
 	result->virt_addr_width = resp.u.device_attr.virt_addr_width;
 	result->db_bar = resp.u.device_attr.db_bar;
+	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
+	result->device_caps = resp.u.device_attr.device_caps;
 
 	if (result->admin_api_version < 1) {
 		ibdev_err_ratelimited(
@@ -477,6 +479,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->max_ah = resp.u.queue_attr.max_ah;
 	result->max_llq_size = resp.u.queue_attr.max_llq_size;
 	result->sub_cqs_per_cq = resp.u.queue_attr.sub_cqs_per_cq;
+	result->max_wr_rdma_sge = resp.u.queue_attr.max_wr_rdma_sges;
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index d119186c41d0..31db5a0cbd5b 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -121,9 +121,12 @@ struct efa_com_get_device_attr_result {
 	u32 max_pd;
 	u32 max_ah;
 	u32 max_llq_size;
+	u32 max_rdma_size;
+	u32 device_caps;
 	u16 sub_cqs_per_cq;
 	u16 max_sq_sge;
 	u16 max_rq_sge;
+	u16 max_wr_rdma_sge;
 	u8 db_bar;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 9701f8e52c71..c9d294caa27a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -70,9 +70,6 @@ static const char *const efa_stats_names[] = {
 #define EFA_CHUNK_USED_SIZE \
 	((EFA_PTRS_PER_CHUNK * EFA_CHUNK_PAYLOAD_PTR_SIZE) + EFA_CHUNK_PTR_SIZE)
 
-#define EFA_SUPPORTED_ACCESS_FLAGS \
-	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ)
-
 struct pbl_chunk {
 	dma_addr_t dma_addr;
 	u64 *buf;
@@ -142,6 +139,11 @@ to_emmap(struct rdma_user_mmap_entry *rdma_entry)
 	return container_of(rdma_entry, struct efa_user_mmap_entry, rdma_entry);
 }
 
+static inline bool is_rdma_read_cap(struct efa_dev *dev)
+{
+	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
+}
+
 #define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
 				 FIELD_SIZEOF(typeof(x), fld) <= (sz))
 
@@ -201,12 +203,17 @@ int efa_query_device(struct ib_device *ibdev,
 				 dev_attr->max_rq_depth);
 	props->max_send_sge = dev_attr->max_sq_sge;
 	props->max_recv_sge = dev_attr->max_rq_sge;
+	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
 
 	if (udata && udata->outlen) {
 		resp.max_sq_sge = dev_attr->max_sq_sge;
 		resp.max_rq_sge = dev_attr->max_rq_sge;
 		resp.max_sq_wr = dev_attr->max_sq_depth;
 		resp.max_rq_wr = dev_attr->max_rq_depth;
+		resp.max_rdma_size = dev_attr->max_rdma_size;
+
+		if (is_rdma_read_cap(dev))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_READ;
 
 		err = ib_copy_to_udata(udata, &resp,
 				       min(sizeof(resp), udata->outlen));
@@ -1345,6 +1352,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	struct efa_com_reg_mr_params params = {};
 	struct efa_com_reg_mr_result result = {};
 	struct pbl_context pbl;
+	int supp_access_flags;
 	unsigned int pg_sz;
 	struct efa_mr *mr;
 	int inline_size;
@@ -1358,10 +1366,14 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_out;
 	}
 
-	if (access_flags & ~EFA_SUPPORTED_ACCESS_FLAGS) {
+	supp_access_flags =
+		IB_ACCESS_LOCAL_WRITE |
+		(is_rdma_read_cap(dev) ? IB_ACCESS_REMOTE_READ : 0);
+
+	if (access_flags & ~supp_access_flags) {
 		ibdev_dbg(&dev->ibdev,
 			  "Unsupported access flags[%#x], supported[%#x]\n",
-			  access_flags, EFA_SUPPORTED_ACCESS_FLAGS);
+			  access_flags, supp_access_flags);
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 9599a2a62be8..53b6e2036a9b 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -90,12 +90,18 @@ struct efa_ibv_create_ah_resp {
 	__u8 reserved_30[2];
 };
 
+enum {
+	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
+};
+
 struct efa_ibv_ex_query_device_resp {
 	__u32 comp_mask;
 	__u32 max_sq_wr;
 	__u32 max_rq_wr;
 	__u16 max_sq_sge;
 	__u16 max_rq_sge;
+	__u32 max_rdma_size;
+	__u32 device_caps;
 };
 
 #endif /* EFA_ABI_USER_H */
-- 
2.24.0

