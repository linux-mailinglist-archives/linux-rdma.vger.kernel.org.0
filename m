Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341B472D11
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Dec 2021 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhLMNSd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 08:18:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:60600 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhLMNSc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Dec 2021 08:18:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="302109742"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="302109742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 05:18:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="517745960"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2021 05:18:30 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Date:   Tue, 14 Dec 2021 00:42:27 -0500
Message-Id: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
get the source udp port number for a QP based on the local QPN. This
provides a better spread of traffic across NIC RX queues.  The method in
the commit d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
scaling") is stable. So it is also adopted in this commit.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 102dc9342f2a..2697b40a539e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
 	return status ? -ENOMEM : 0;
 }
 
+static inline u16 irdma_get_src_port(struct irdma_qp *iwqp)
+{
+	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff);
+}
+
 static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 					       struct irdma_qp_host_ctx_info *ctx_info)
 {
@@ -703,7 +708,7 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 	udp_info->cwnd = iwdev->roce_cwnd;
 	udp_info->rexmit_thresh = 2;
 	udp_info->rnr_nak_thresh = 2;
-	udp_info->src_port = 0xc000;
+	udp_info->src_port = irdma_get_src_port(iwqp);
 	udp_info->dst_port = ROCE_V2_UDP_DPORT;
 	roce_info = &iwqp->roce_info;
 	ether_addr_copy(roce_info->mac_addr, iwdev->netdev->dev_addr);
-- 
2.27.0

