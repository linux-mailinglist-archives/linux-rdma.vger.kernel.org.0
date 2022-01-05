Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A91484DCC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 06:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiAEFty (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 00:49:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:27100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237564AbiAEFty (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 00:49:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305725914"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="305725914"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 21:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="760688622"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 21:49:52 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 3/5] RDMA/irdma: Make the source udp port vary
Date:   Wed,  5 Jan 2022 17:12:35 -0500
Message-Id: <20220105221237.2659462-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
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
 drivers/infiniband/hw/irdma/verbs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8cd5f9261692..8234a101e752 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1170,6 +1170,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			udp_info->ttl = attr->ah_attr.grh.hop_limit;
 			udp_info->flow_label = attr->ah_attr.grh.flow_label;
 			udp_info->tos = attr->ah_attr.grh.traffic_class;
+			udp_info->src_port = rdma_get_udp_sport(
+						udp_info->flow_label,
+						ibqp->qp_num,
+						roce_info->dest_qp);
 			irdma_qp_rem_qos(&iwqp->sc_qp);
 			dev->ws_remove(iwqp->sc_qp.vsi, ctx_info->user_pri);
 			ctx_info->user_pri = rt_tos2priority(udp_info->tos);
-- 
2.27.0

