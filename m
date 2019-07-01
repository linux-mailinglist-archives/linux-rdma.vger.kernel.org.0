Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90D35C189
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfGAQ6K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 12:58:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:55533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfGAQ6J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jul 2019 12:58:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="314940330"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2019 09:58:07 -0700
Date:   Tue, 2 Jul 2019 00:56:41 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     shiraz.saleem@intel.com, faisal.latif@intel.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH v2] RDMA/i40iw: Return the QP state when being queried
Message-ID: <20190701165641.GA14149@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

i40iw_query_qp does not return current QP state when QP attributes are
queried.
Return qp_state and cur_qp_state correctly in the QP attributes struct.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Changcheng Liu <changcheng.liu@intel.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
v1 -> v2:
   * Correct patch format with '---' under Signed-off-by.
   * Refine commit message with 1) why need the change 2) solution.
   * Add "Fixes" to show the original patch introduced the problem.
   * Change patch title.
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 5689d742bafb..4c88d6f72574 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -772,6 +772,8 @@ static int i40iw_query_qp(struct ib_qp *ibqp,
 	struct i40iw_qp *iwqp = to_iwqp(ibqp);
 	struct i40iw_sc_qp *qp = &iwqp->sc_qp;
 
+	attr->qp_state = iwqp->ibqp_state;
+	attr->cur_qp_state = attr->qp_state;
 	attr->qp_access_flags = 0;
 	attr->cap.max_send_wr = qp->qp_uk.sq_size;
 	attr->cap.max_recv_wr = qp->qp_uk.rq_size;
-- 
2.17.1

