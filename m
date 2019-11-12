Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95EF8B90
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLJSC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 04:18:02 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:60500 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKLJSC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 04:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573550282; x=1605086282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqQ5xP6NO0QA4+GKKuxWUcHLDt6y/hBz/GCQXZXujMc=;
  b=bcNGIimBMZ+RGLMWt8jyeTzRMCL35dpd4RFwdrtQwGdRkDqAo07Yw4IW
   HJPYOV9SY+v+aeTpoEN8aBnwpNxmzfSfhf5It4tzqggrsZB1en5K3tF9z
   3QT0qUlYAYYz61F6eN+7AGX0M8hVE0b86acZGI/9CTVNrsIHj6AqahGtw
   k=;
IronPort-SDR: 1jZlGnevxkcKF0rOEB41eFW2TVe7SqyuKZyiTpIzkRE7kOH1h9hTwyA+THkcfLlBcYt7rE3fGX
 NiWisXNaVkYg==
X-IronPort-AV: E=Sophos;i="5.68,295,1569283200"; 
   d="scan'208";a="6368926"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Nov 2019 09:18:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 4DE3DA1CFC;
        Tue, 12 Nov 2019 09:17:59 +0000 (UTC)
Received: from EX13D22EUB002.ant.amazon.com (10.43.166.131) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:58 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D22EUB002.ant.amazon.com (10.43.166.131) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:57 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 12 Nov 2019 09:17:54 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 3/3] RDMA/efa: Expose RDMA read related attributes
Date:   Tue, 12 Nov 2019 11:17:37 +0200
Message-ID: <20191112091737.40204-4-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112091737.40204-1-galpress@amazon.com>
References: <20191112091737.40204-1-galpress@amazon.com>
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
 include/uapi/rdma/efa-abi.h                   |  9 ++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)

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
index e5008de89ef0..aa25ae9cd589 100644
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
 
@@ -207,6 +209,11 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rq_sge = dev_attr->max_rq_sge;
 		resp.max_sq_wr = dev_attr->max_sq_depth;
 		resp.max_rq_wr = dev_attr->max_rq_depth;
+		resp.max_rdma_size = dev_attr->max_rdma_size;
+		resp.max_wr_rdma_sge = dev_attr->max_wr_rdma_sge;
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
index 9599a2a62be8..442804572118 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -90,12 +90,21 @@ struct efa_ibv_create_ah_resp {
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
+	__u16 max_wr_rdma_sge;
+	__u8 reserved_b0[2];
+	__u32 device_caps;
+	__u8 reserved_e0[4];
 };
 
 #endif /* EFA_ABI_USER_H */
-- 
2.23.0

