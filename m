Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008702299D1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgGVOJK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:09:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:18229 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGVOJK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595426950; x=1626962950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMKjB8xCfBzBCkKNfpgxia5k3f3wlJiB4oaoIdPpvAs=;
  b=YkbUXog3c7XIU9DkzetB0IB74QBbKl8N6zxu3g8KJ8EPYXUp5zlPWHgD
   FOQiIb2O84oVR8VXHvwoxnIJjlcF9Jv8FGA9CMQ0Fpjy9YKPQHwq67fR9
   D6bZd2+TfZ6i2ntSWa603iL6yDc6aOXrH/t5yrhA67IMkk0c/RwmZBPxV
   o=;
IronPort-SDR: aAUn9utsz3Wlo3hiWT9z3RoC4WVl8Ua8SYZ8lPFU7U8l6iXg1hLWjJk0AWBImtC4TBpxQ0sQwD
 efCmifwnIPyQ==
X-IronPort-AV: E=Sophos;i="5.75,383,1589241600"; 
   d="scan'208";a="60717745"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Jul 2020 14:03:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id B567D1A1146;
        Wed, 22 Jul 2020 14:03:34 +0000 (UTC)
Received: from EX13D19EUA002.ant.amazon.com (10.43.165.247) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:33 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.83.32) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 22 Jul 2020 14:03:29 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Shadi Ammouri" <sammouri@amazon.com>
Subject: [PATCH for-next v4 2/4] RDMA/efa: Expose minimum SQ size
Date:   Wed, 22 Jul 2020 17:03:10 +0300
Message-ID: <20200722140312.3651-3-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722140312.3651-1-galpress@amazon.com>
References: <20200722140312.3651-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The device reports the minimum SQ size required for creation.

This patch queries the min SQ size and reports it back to the
userspace library.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 4 ++--
 drivers/infiniband/hw/efa/efa_com_cmd.c         | 1 +
 drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
 drivers/infiniband/hw/efa/efa_verbs.c           | 1 +
 include/uapi/rdma/efa-abi.h                     | 3 ++-
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 03e7388af06e..5484b08bbc5d 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -606,8 +606,8 @@ struct efa_admin_feature_queue_attr_desc {
 	/* Number of sub-CQs to be created for each CQ */
 	u16 sub_cqs_per_cq;
 
-	/* MBZ */
-	u16 reserved;
+	/* Minimum number of WQEs per SQ */
+	u16 min_sq_depth;
 
 	/* Maximum number of SGEs (buffers) allowed for a single send WQE */
 	u16 max_wr_send_sges;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 53cfde5c43d8..6ac23627f65a 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -481,6 +481,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->sub_cqs_per_cq = resp.u.queue_attr.sub_cqs_per_cq;
 	result->max_wr_rdma_sge = resp.u.queue_attr.max_wr_rdma_sges;
 	result->max_tx_batch = resp.u.queue_attr.max_tx_batch;
+	result->min_sq_depth = resp.u.queue_attr.min_sq_depth;
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 8df2a26d57d4..190bac23f585 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -128,6 +128,7 @@ struct efa_com_get_device_attr_result {
 	u16 max_rq_sge;
 	u16 max_wr_rdma_sge;
 	u16 max_tx_batch;
+	u16 min_sq_depth;
 	u8 db_bar;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index f49d14cebe4a..26102ab333b2 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1526,6 +1526,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	resp.inline_buf_size = dev->dev_attr.inline_buf_size;
 	resp.max_llq_size = dev->dev_attr.max_llq_size;
 	resp.max_tx_batch = dev->dev_attr.max_tx_batch;
+	resp.min_sq_wr = dev->dev_attr.min_sq_depth;
 
 	if (udata && udata->outlen) {
 		err = ib_copy_to_udata(udata, &resp,
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 10781763da37..7ef2306f8dd4 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -32,7 +32,8 @@ struct efa_ibv_alloc_ucontext_resp {
 	__u16 inline_buf_size;
 	__u32 max_llq_size; /* bytes */
 	__u16 max_tx_batch; /* units of 64 bytes */
-	__u8 reserved_90[6];
+	__u16 min_sq_wr;
+	__u8 reserved_a0[4];
 };
 
 struct efa_ibv_alloc_pd_resp {
-- 
2.27.0

