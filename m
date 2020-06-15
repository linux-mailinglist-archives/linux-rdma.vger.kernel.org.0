Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDAC1F90DF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFOH7f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 03:59:35 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:17450 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOH7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jun 2020 03:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592207973; x=1623743973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8gRzcZdZxOifiUg2ZlIhXK0X9+vVaabD868Pf7514is=;
  b=Qx5GYXVfLH7OrzsSd+4rI+vfFqju1SZKWNX6VE1771aXsIqXway/vdwZ
   wu49c1fO1dVnLns7FXST+85MoecO3H4dLMb4h7f0r6ecHinjk2DfQPrhP
   TMs4MNLXx9ZajgVYwsjl7SZGHipAzXTeGHRSQpSkOucKvkqx0AkV/n+PC
   Q=;
IronPort-SDR: ucL1tlWvTPMVZqQKL+IEDJYBnimw1AIbgDEcIdEBbIP15ModwzXKR68IbFqH1FkspyogDXaHUj
 PFM6laOFnyOQ==
X-IronPort-AV: E=Sophos;i="5.73,514,1583193600"; 
   d="scan'208";a="36259990"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 15 Jun 2020 07:59:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 42742A04EA;
        Mon, 15 Jun 2020 07:59:32 +0000 (UTC)
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 15 Jun 2020 07:59:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 15 Jun 2020 07:59:30 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.14) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 15 Jun 2020 07:59:27 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Move provider specific attributes to ucontext allocation response
Date:   Mon, 15 Jun 2020 10:59:20 +0300
Message-ID: <20200615075920.58936-1-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Provider specific attributes which are necessary for the userspace
functionality should be part of the alloc ucontext response, not query
device. This way a userspace provider could work without issuing a query
device verb call. However, the fields will remain in the query device
ABI in order to maintain backwards compatibility.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
PR was sent:
https://github.com/linux-rdma/rdma-core/pull/775
---
 drivers/infiniband/hw/efa/efa_verbs.c | 10 ++++++++++
 include/uapi/rdma/efa-abi.h           | 23 ++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 08313f7c73bc..519cc959acfe 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1520,11 +1520,21 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 
 	ucontext->uarn = result.uarn;
 
+	resp.comp_mask |= EFA_ALLOC_UCONTEXT_RESP_DEV_ATTR;
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
 	resp.sub_cqs_per_cq = dev->dev_attr.sub_cqs_per_cq;
 	resp.inline_buf_size = dev->dev_attr.inline_buf_size;
 	resp.max_llq_size = dev->dev_attr.max_llq_size;
+	resp.max_sq_sge = dev->dev_attr.max_sq_sge;
+	resp.max_rq_sge = dev->dev_attr.max_rq_sge;
+	resp.max_sq_wr = dev->dev_attr.max_sq_depth;
+	resp.max_rq_wr = dev->dev_attr.max_rq_depth;
+	resp.max_rdma_size = dev->dev_attr.max_rdma_size;
+	resp.max_wr_rdma_sge = dev->dev_attr.max_wr_rdma_sge;
+
+	if (is_rdma_read_cap(dev))
+		resp.device_caps |= EFA_ALLOC_UCONTEXT_DEVICE_CAPS_RDMA_READ;
 
 	if (udata && udata->outlen) {
 		err = ib_copy_to_udata(udata, &resp,
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 53b6e2036a9b..12df5c1659b6 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -20,6 +20,14 @@
  * hex bit offset of the field.
  */
 
+enum {
+	EFA_ALLOC_UCONTEXT_RESP_DEV_ATTR = 1 << 0,
+};
+
+enum {
+	EFA_ALLOC_UCONTEXT_DEVICE_CAPS_RDMA_READ = 1 << 0,
+};
+
 enum efa_ibv_user_cmds_supp_udata {
 	EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE = 1 << 0,
 	EFA_USER_CMDS_SUPP_UDATA_CREATE_AH    = 1 << 1,
@@ -31,6 +39,14 @@ struct efa_ibv_alloc_ucontext_resp {
 	__u16 sub_cqs_per_cq;
 	__u16 inline_buf_size;
 	__u32 max_llq_size; /* bytes */
+	__u32 max_sq_wr;
+	__u32 max_rq_wr;
+	__u16 max_sq_sge;
+	__u16 max_rq_sge;
+	__u32 max_rdma_size;
+	__u32 device_caps;
+	__u16 max_wr_rdma_sge;
+	__u8 reserved_130[2];
 };
 
 struct efa_ibv_alloc_pd_resp {
@@ -96,6 +112,11 @@ enum {
 
 struct efa_ibv_ex_query_device_resp {
 	__u32 comp_mask;
+	/*
+	 * Attributes which are required for userspace provider functionality
+	 * should be in alloc ucontext response, the following fields have been
+	 * moved.
+	 */
 	__u32 max_sq_wr;
 	__u32 max_rq_wr;
 	__u16 max_sq_sge;

base-commit: fba97dc7fc76b2c9a909fa0b3786d30a9899f5cf
-- 
2.27.0

