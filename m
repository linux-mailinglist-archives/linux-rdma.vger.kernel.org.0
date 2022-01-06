Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E8485E33
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 02:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbiAFBlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 20:41:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:62230 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344428AbiAFBlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 20:41:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266855327"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266855327"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513226713"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 17:41:16 -0800
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH v3 3/4] RDMA/irdma: Make the source udp port vary
Date:   Thu,  6 Jan 2022 13:03:58 -0500
Message-Id: <20220106180359.2915060-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
References: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Get the source udp port number for a QP based on the grh.flow_label or
lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
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

