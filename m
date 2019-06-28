Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9B59419
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF1GRn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 02:17:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:38939 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfF1GRn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 02:17:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 23:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,426,1557212400"; 
   d="scan'208";a="173385189"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2019 23:17:40 -0700
Date:   Fri, 28 Jun 2019 14:16:13 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     faisal.latif@intel.com, shiraz.saleem@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/i40iw: set queue pair state when being queried
Message-ID: <20190628061613.GA17802@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1. queue pair state should be clear when querying RDMA/i40iw state.
attr is allocated from kmalloc with unclear value. resp.qp_state
isn't clear if attr->qp_state isn't set.
2. attr->qp_state should be set to be iwqp->ibqp_state.
3. attr->cur_qp_state should be set to be attr->qp_state when querying
queue pair state.

Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>

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

