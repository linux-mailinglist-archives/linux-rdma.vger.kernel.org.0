Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD85AEBCE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfIJNnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 09:43:46 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:34715 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJNnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568123024; x=1599659024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxuqAqMvJWJWS17szILIegghue3QFm65G5LNRbzTc+Y=;
  b=I1uJQU/LB1RpgAlnBTOij4VwosxTQCe+JJIRb623pNvO3ofOHlNQXaqm
   D108PMCqZ6eS01DjN7oH0WcYJixIzq7ub5m3AEVBDSohFKZhG/8ByyWed
   2d8pIIRBfFb8MRLAS/bZ2ZRzSq4EA0xL7BS1J54O+EMRrSppGKAsNAaFc
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="829822139"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Sep 2019 13:43:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 5C469A1C68;
        Tue, 10 Sep 2019 13:43:32 +0000 (UTC)
Received: from EX13D22EUA001.ant.amazon.com (10.43.165.37) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:31 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D22EUA001.ant.amazon.com (10.43.165.37) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:30 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.79.108) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Sep 2019 13:43:27 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 4/4] RDMA/efa: Expose RDMA read related attributes
Date:   Tue, 10 Sep 2019 14:43:01 +0100
Message-ID: <20190910134301.4194-5-galpress@amazon.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910134301.4194-1-galpress@amazon.com>
References: <20190910134301.4194-1-galpress@amazon.com>
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
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 17 +++++++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.c         |  2 ++
 drivers/infiniband/hw/efa/efa_com_cmd.h         |  2 ++
 drivers/infiniband/hw/efa/efa_verbs.c           |  2 ++
 include/uapi/rdma/efa-abi.h                     |  3 +++
 5 files changed, 26 insertions(+)

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
index 520c9d920f9e..0e6796f11e52 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -444,6 +444,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->phys_addr_width = resp.u.device_attr.phys_addr_width;
 	result->virt_addr_width = resp.u.device_attr.virt_addr_width;
 	result->db_bar = resp.u.device_attr.db_bar;
+	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
 
 	if (result->admin_api_version < 1) {
 		ibdev_err_ratelimited(
@@ -477,6 +478,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->max_ah = resp.u.queue_attr.max_ah;
 	result->max_llq_size = resp.u.queue_attr.max_llq_size;
 	result->sub_cqs_per_cq = resp.u.queue_attr.sub_cqs_per_cq;
+	result->max_wr_rdma_sge = resp.u.queue_attr.max_wr_rdma_sges;
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index d119186c41d0..4dd3452d0b41 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -121,9 +121,11 @@ struct efa_com_get_device_attr_result {
 	u32 max_pd;
 	u32 max_ah;
 	u32 max_llq_size;
+	u32 max_rdma_size;
 	u16 sub_cqs_per_cq;
 	u16 max_sq_sge;
 	u16 max_rq_sge;
+	u16 max_wr_rdma_sge;
 	u8 db_bar;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0011e2c1c8a6..188fcb41218d 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -313,6 +313,8 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rq_sge = dev_attr->max_rq_sge;
 		resp.max_sq_wr = dev_attr->max_sq_depth;
 		resp.max_rq_wr = dev_attr->max_rq_depth;
+		resp.max_rdma_size = dev_attr->max_rdma_size;
+		resp.max_wr_rdma_sge = dev_attr->max_wr_rdma_sge;
 
 		err = ib_copy_to_udata(udata, &resp,
 				       min(sizeof(resp), udata->outlen));
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 9599a2a62be8..269424c2a8a7 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -96,6 +96,9 @@ struct efa_ibv_ex_query_device_resp {
 	__u32 max_rq_wr;
 	__u16 max_sq_sge;
 	__u16 max_rq_sge;
+	__u32 max_rdma_size;
+	__u16 max_wr_rdma_sge;
+	__u8 reserved_b0[2];
 };
 
 #endif /* EFA_ABI_USER_H */
-- 
2.23.0

