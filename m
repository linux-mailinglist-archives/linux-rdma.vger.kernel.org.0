Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD4484DCA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 06:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiAEFtu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 00:49:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:27100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236188AbiAEFtu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 00:49:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305725903"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="305725903"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 21:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="760688607"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 21:49:48 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 1/5] RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
Date:   Wed,  5 Jan 2022 17:12:33 -0500
Message-Id: <20220105221237.2659462-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Calculate and set UDP source port based on the flow label. If flow label
is not defined in GRH then calculate it based on lqpn/rqpn.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 include/rdma/ib_verbs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6e9ad656ecb7..69d883f7fb41 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4749,6 +4749,23 @@ static inline u32 rdma_calc_flow_label(u32 lqpn, u32 rqpn)
 	return (u32)(v & IB_GRH_FLOWLABEL_MASK);
 }
 
+/**
+ * rdma_get_udp_sport - Calculate and set UDP source port based on the flow
+ *                      label. If flow label is not defined in GRH then
+ *                      calculate it based on lqpn/rqpn.
+ *
+ * @fl:                 flow label from GRH
+ * @lqpn:               local qp number
+ * @rqpn:               remote qp number
+ */
+static inline u16 rdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
+{
+	if (!fl)
+		fl = rdma_calc_flow_label(lqpn, rqpn);
+
+	return rdma_flow_label_to_udp_sport(fl);
+}
+
 const struct ib_port_immutable*
 ib_port_immutable_read(struct ib_device *dev, unsigned int port);
 #endif /* IB_VERBS_H */
-- 
2.27.0

