Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042F2484503
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiADPor (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 10:44:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:35449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235064AbiADPoo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 10:44:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229062525"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229062525"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:44:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="526089404"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 07:44:42 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, liweihang@huawei.com, jgg@ziepe.ca,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
Date:   Wed,  5 Jan 2022 03:07:26 -0500
Message-Id: <20220105080727.2143737-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Get the source udp port number for a QP based on the grh.flow_label or
lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8cd5f9261692..09dba7ed5ab9 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1167,6 +1167,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
 		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
+			u32 fl = attr->ah_attr.grh.flow_label;
+			u32 lqp = ibqp->qp_num;
+			u32 rqp = roce_info->dest_qp;
+
+			udp_info->src_port = rdma_get_udp_sport(fl, lqp, rqp);
 			udp_info->ttl = attr->ah_attr.grh.hop_limit;
 			udp_info->flow_label = attr->ah_attr.grh.flow_label;
 			udp_info->tos = attr->ah_attr.grh.traffic_class;
-- 
2.27.0

