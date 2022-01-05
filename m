Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C02484DCB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 06:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiAEFtw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 00:49:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:27100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237564AbiAEFtw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 00:49:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305725905"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="305725905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 21:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="760688615"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 21:49:50 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 2/5] RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
Date:   Wed,  5 Jan 2022 17:12:34 -0500
Message-Id: <20220105221237.2659462-3-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Several drivers have the same function xxx_get_udp_sport. So this
function is moved to ib_verbs.h.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
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

