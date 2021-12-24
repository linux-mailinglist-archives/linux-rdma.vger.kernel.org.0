Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4947E9F7
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 02:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350488AbhLXBEL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 20:04:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:2299 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350464AbhLXBEL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Dec 2021 20:04:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="220918160"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="220918160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 17:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="617644999"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga004.jf.intel.com with ESMTP; 23 Dec 2021 17:04:08 -0800
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        leon@kernel.org
Subject: [PATCH 1/1] RDMA/rxe: Use the standard method to produce udp source port
Date:   Fri, 24 Dec 2021 12:27:35 -0500
Message-Id: <20211224172735.1450623-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Use the standard method to produce udp source port based on the
commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp source port
when set path").

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0aa0d7e52773..9a0748ad6417 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -451,6 +451,14 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return err;
 }
 
+static u16 rxe_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
+{
+	if (!fl)
+		fl = rdma_calc_flow_label(lqpn, rqpn);
+
+	return rdma_flow_label_to_udp_sport(fl);
+}
+
 static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			 int mask, struct ib_udata *udata)
 {
@@ -469,6 +477,16 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (err)
 		goto err1;
 
+	if (mask & IB_QP_AV) {
+		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
+			u32 fl = attr->ah_attr.grh.flow_label;
+			u32 lqp = qp->ibqp.qp_num;
+			u32 rqp = qp->attr.dest_qp_num;
+
+			qp->src_port = rxe_get_udp_sport(fl, lqp, rqp);
+		}
+	}
+
 	return 0;
 
 err1:
-- 
2.27.0

