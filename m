Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF5485E32
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 02:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbiAFBlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 20:41:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:62230 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344425AbiAFBlR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 20:41:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266855324"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266855324"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513226702"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 17:41:14 -0800
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH v3 2/4] RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
Date:   Thu,  6 Jan 2022 13:03:57 -0500
Message-Id: <20220106180359.2915060-3-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
References: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Several drivers have the same function xxx_get_udp_sport. So this
function is moved to ib_verbs.h.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index eb0defa80d0d..cb795663b813 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4488,14 +4488,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	return 0;
 }
 
-static inline u16 get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
-{
-	if (!fl)
-		fl = rdma_calc_flow_label(lqpn, rqpn);
-
-	return rdma_flow_label_to_udp_sport(fl);
-}
-
 static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			   u32 *dip_idx)
 {
@@ -4712,8 +4704,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	}
 
 	hr_reg_write(context, QPC_UDPSPN,
-		     is_udp ? get_udp_sport(grh->flow_label, ibqp->qp_num,
-					    attr->dest_qp_num) : 0);
+		     is_udp ? rdma_get_udp_sport(grh->flow_label, ibqp->qp_num,
+						 attr->dest_qp_num) : 0);
 
 	hr_reg_clear(qpc_mask, QPC_UDPSPN);
 
-- 
2.27.0

