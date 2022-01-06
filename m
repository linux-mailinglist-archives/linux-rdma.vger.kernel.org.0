Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF91485E30
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 02:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbiAFBlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 20:41:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:62226 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344412AbiAFBlP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 20:41:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266855319"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266855319"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:41:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513226692"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 17:41:12 -0800
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH v3 1/4] RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
Date:   Thu,  6 Jan 2022 13:03:56 -0500
Message-Id: <20220106180359.2915060-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
References: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Calculate and set UDP source port based on the flow label. If flow label
is not defined in GRH then calculate it based on lqpn/rqpn.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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

