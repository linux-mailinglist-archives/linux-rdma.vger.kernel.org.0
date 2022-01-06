Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CFE485E34
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 02:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiAFBlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 20:41:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:62230 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344425AbiAFBlX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 20:41:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266855330"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266855330"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:41:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513226721"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 17:41:19 -0800
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH v3 4/4] RDMA/rxe: Use the standard method to produce udp source port
Date:   Thu,  6 Jan 2022 13:03:59 -0500
Message-Id: <20220106180359.2915060-5-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
References: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Use the standard method to produce udp source port.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0aa0d7e52773..42fa81b455de 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -469,6 +469,12 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (err)
 		goto err1;
 
+	if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))
+		qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
+						  qp->ibqp.qp_num,
+						  qp->attr.dest_qp_num);
+
+
 	return 0;
 
 err1:
-- 
2.27.0

