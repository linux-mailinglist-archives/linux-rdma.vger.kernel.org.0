Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE647988D
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Dec 2021 05:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhLREU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Dec 2021 23:20:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:53608 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLREU6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Dec 2021 23:20:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="264062582"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="264062582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 20:20:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="520036638"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2021 20:20:56 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
Date:   Sat, 18 Dec 2021 15:44:38 -0500
Message-Id: <20211218204438.1345160-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
get the source udp port number for a QP based on the grh.flow_label or
lqpn/rqpn. This provides a better spread of traffic across NIC RX queues.
The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
source port when set path") is a standard way. So it is also adopted in
this commit.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Adopt a standard method to get udp source port.
---
 drivers/infiniband/hw/irdma/verbs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8cd5f9261692..9fe73d1db0d9 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
+
+static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
+{
+	if (!fl)
+		fl = rdma_calc_flow_label(lqpn, rqpn);
+
+	return rdma_flow_label_to_udp_sport(fl);
+}
+
 /**
  * irdma_modify_qp_roce - modify qp request
  * @ibqp: qp's pointer for modify
@@ -1159,6 +1168,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	ctx_info->roce_info->pd_id = iwpd->sc_pd.pd_id;
 
+	udp_info->src_port = irdma_get_udp_sport(udp_info->flow_label,
+						 ibqp->qp_num,
+						 roce_info->dest_qp);
+
 	if (attr_mask & IB_QP_AV) {
 		struct irdma_av *av = &iwqp->roce_ah.av;
 		const struct ib_gid_attr *sgid_attr;
-- 
2.27.0

