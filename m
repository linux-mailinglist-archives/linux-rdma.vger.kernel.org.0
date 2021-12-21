Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7547B6BE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 02:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhLUBPk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 20:15:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:36345 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhLUBPk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 20:15:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240108248"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="240108248"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="547776416"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2021 17:15:38 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
Date:   Tue, 21 Dec 2021 12:39:13 -0500
Message-Id: <20211221173913.1386261-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
get the source udp port number for a QP based on the grh.flow_label or
lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.
The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
source port when set path") is a standard way. So it is also adopted in
this commit.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V2->V3: Move to the block of IB_QP_AV in the mask and IB_AH_GRH in ah_flags
V1->V2: Adopt a standard method to get udp source port.
---
 drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8cd5f9261692..31039b295206 100644
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
@@ -1167,6 +1176,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
 		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
+			u32 fl = udp_info->flow_label;
+			u32 lqp = ibqp->qp_num;
+			u32 rqp = roce_info->dest_qp;
+
+			udp_info->src_port = irdma_get_udp_sport(fl, lqp, rqp);
 			udp_info->ttl = attr->ah_attr.grh.hop_limit;
 			udp_info->flow_label = attr->ah_attr.grh.flow_label;
 			udp_info->tos = attr->ah_attr.grh.traffic_class;
-- 
2.27.0

