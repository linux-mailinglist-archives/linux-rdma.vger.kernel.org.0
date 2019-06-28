Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0410B5A35D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF1SWC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:22:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:28309 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1SWC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:22:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="156643741"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2019 11:22:01 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SIM0ND061068;
        Fri, 28 Jun 2019 11:22:00 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SILw5h067923;
        Fri, 28 Jun 2019 14:21:59 -0400
Subject: [PATCH for-next v2 2/9] IB/rdmavt: Set QP allowed opcodes after QP
 allocation
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 28 Jun 2019 14:21:58 -0400
Message-ID: <20190628182158.67786.91722.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
References: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

Currently QP allowed_ops is set after the QP is completely
initialized.  This curtails the use of this optimization for any
initialization before allowed_ops is set.

Fix by adding a helper to determine the correct allowed_ops and
moving the setting of the allowed_ops to just after QP allocation.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/sw/rdmavt/qp.c |   35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 17e192a..b9035d9 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2016 - 2018 Intel Corporation.
+ * Copyright(c) 2016 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -969,6 +969,16 @@ static void rvt_free_qpn(struct rvt_qpn_table *qpt, u32 qpn)
 }
 
 /**
+ * get_allowed_ops - Given a QP type return the appropriate allowed OP
+ * @type: valid, supported, QP type
+ */
+static u8 get_allowed_ops(enum ib_qp_type type)
+{
+	return type == IB_QPT_RC ? IB_OPCODE_RC : type == IB_QPT_UC ?
+		IB_OPCODE_UC : IB_OPCODE_UD;
+}
+
+/**
  * rvt_create_qp - create a queue pair for a device
  * @ibpd: the protection domain who's device we create the queue pair for
  * @init_attr: the attributes of the queue pair
@@ -1050,6 +1060,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 				  rdi->dparms.node);
 		if (!qp)
 			goto bail_swq;
+		qp->allowed_ops = get_allowed_ops(init_attr->qp_type);
 
 		RCU_INIT_POINTER(qp->next, NULL);
 		if (init_attr->qp_type == IB_QPT_RC) {
@@ -1205,28 +1216,6 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 
 	ret = &qp->ibqp;
 
-	/*
-	 * We have our QP and its good, now keep track of what types of opcodes
-	 * can be processed on this QP. We do this by keeping track of what the
-	 * 3 high order bits of the opcode are.
-	 */
-	switch (init_attr->qp_type) {
-	case IB_QPT_SMI:
-	case IB_QPT_GSI:
-	case IB_QPT_UD:
-		qp->allowed_ops = IB_OPCODE_UD;
-		break;
-	case IB_QPT_RC:
-		qp->allowed_ops = IB_OPCODE_RC;
-		break;
-	case IB_QPT_UC:
-		qp->allowed_ops = IB_OPCODE_UC;
-		break;
-	default:
-		ret = ERR_PTR(-EINVAL);
-		goto bail_ip;
-	}
-
 	return ret;
 
 bail_ip:

