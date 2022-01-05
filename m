Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7875484504
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiADPot (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 10:44:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:35449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233957AbiADPos (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 10:44:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229062539"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229062539"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="526089413"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 07:44:44 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, liweihang@huawei.com, jgg@ziepe.ca,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 4/4] RDMA/rxe: Use the standard method to produce udp source port
Date:   Wed,  5 Jan 2022 03:07:27 -0500
Message-Id: <20220105080727.2143737-5-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Use the standard method to produce udp source port.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0aa0d7e52773..f30d98ad13cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -469,6 +469,16 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (err)
 		goto err1;
 
+	if (mask & IB_QP_AV) {
+		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
+			u32 fl = attr->ah_attr.grh.flow_label;
+			u32 lqp = qp->ibqp.qp_num;
+			u32 rqp = qp->attr.dest_qp_num;
+
+			qp->src_port = rdma_get_udp_sport(fl, lqp, rqp);
+		}
+	}
+
 	return 0;
 
 err1:
-- 
2.27.0

