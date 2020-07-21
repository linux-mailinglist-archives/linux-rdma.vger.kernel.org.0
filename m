Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD62280F2
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgGUNbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 09:31:19 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57976 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgGUNbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 09:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595338278; x=1626874278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCD+SaI/Zc2qPh/Zx+uAq6cQgp/p2lIgcDYvudjBgMg=;
  b=njn4x1nxxFrye4dVVcvawmCCyzLRh/xmHfIwAbtORv8At8NFm2+pNzWP
   0aFRsupjnFpeVhfcHG10YytPihH0iOrbBQeuHEKW/nSO16OCTtnusV1or
   9u07YRBPwawKCI+h3gei3jH9xP6/6/l15/+x+Kkc45GgSAgDefPDbm7zF
   k=;
IronPort-SDR: y2xXFj/MhoVfSDBoz4MB5bc1o6+9NiNyoEVgLSshOnuroufHn7Edm1hqoAwyKpVB5IhcPX6OgF
 lQSzZlZwj2+Q==
X-IronPort-AV: E=Sophos;i="5.75,378,1589241600"; 
   d="scan'208";a="61579101"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Jul 2020 13:31:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id EA313A27CA;
        Tue, 21 Jul 2020 13:31:12 +0000 (UTC)
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:11 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.11) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 21 Jul 2020 13:31:07 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-next v3 1/4] RDMA/efa: Expose maximum TX doorbell batch
Date:   Tue, 21 Jul 2020 16:30:46 +0300
Message-ID: <20200721133049.74349-2-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721133049.74349-1-galpress@amazon.com>
References: <20200721133049.74349-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The device reports the maximum number of bytes to be written before
ringing the doorbell (zero means unlimited).

This patch queries the max batch size and reports it back to the
userspace library.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 11 +++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.c         |  1 +
 drivers/infiniband/hw/efa/efa_com_cmd.h         |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
 include/uapi/rdma/efa-abi.h                     |  4 +++-
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index bef2bd291054..03e7388af06e 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -632,6 +632,17 @@ struct efa_admin_feature_queue_attr_desc {
 
 	/* Maximum number of SGEs for a single RDMA read WQE */
 	u16 max_wr_rdma_sges;
+
+	/*
+	 * Maximum number of bytes that can be written to SQ between two
+	 * consecutive doorbells (in units of 64B). Driver must ensure that only
+	 * complete WQEs are written to queue before issuing a doorbell.
+	 * Examples: max_tx_batch=16 and WQE size = 64B, means up to 16 WQEs can
+	 * be written to SQ between two consecutive doorbells. max_tx_batch=11
+	 * and WQE size = 128B, means up to 5 WQEs can be written to SQ between
+	 * two consecutive doorbells. Zero means unlimited.
+	 */
+	u16 max_tx_batch;
 };
 
 struct efa_admin_feature_aenq_desc {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index fabd8df2e78f..53cfde5c43d8 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -480,6 +480,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->max_llq_size = resp.u.queue_attr.max_llq_size;
 	result->sub_cqs_per_cq = resp.u.queue_attr.sub_cqs_per_cq;
 	result->max_wr_rdma_sge = resp.u.queue_attr.max_wr_rdma_sges;
+	result->max_tx_batch = resp.u.queue_attr.max_tx_batch;
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 41ce4a476ee6..8df2a26d57d4 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -127,6 +127,7 @@ struct efa_com_get_device_attr_result {
 	u16 max_sq_sge;
 	u16 max_rq_sge;
 	u16 max_wr_rdma_sge;
+	u16 max_tx_batch;
 	u8 db_bar;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 08313f7c73bc..f49d14cebe4a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1525,6 +1525,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	resp.sub_cqs_per_cq = dev->dev_attr.sub_cqs_per_cq;
 	resp.inline_buf_size = dev->dev_attr.inline_buf_size;
 	resp.max_llq_size = dev->dev_attr.max_llq_size;
+	resp.max_tx_batch = dev->dev_attr.max_tx_batch;
 
 	if (udata && udata->outlen) {
 		err = ib_copy_to_udata(udata, &resp,
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 53b6e2036a9b..10781763da37 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -31,6 +31,8 @@ struct efa_ibv_alloc_ucontext_resp {
 	__u16 sub_cqs_per_cq;
 	__u16 inline_buf_size;
 	__u32 max_llq_size; /* bytes */
+	__u16 max_tx_batch; /* units of 64 bytes */
+	__u8 reserved_90[6];
 };
 
 struct efa_ibv_alloc_pd_resp {
-- 
2.27.0

