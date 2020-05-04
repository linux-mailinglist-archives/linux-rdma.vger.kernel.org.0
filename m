Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074E51C3227
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 07:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgEDFTl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 01:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEDFTl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 01:19:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54AD206D7;
        Mon,  4 May 2020 05:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588569580;
        bh=HfViCBZy9L9gObz4ejTkIoVW6bs20K5E8lvTC0XpXJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkhtT7d3+qZvJpQJlxJOCVIW1JDuIjJVOkHgKfMc6Abl/U9IjoCWGueQHc2zrJ3cM
         F0LnFYRM2kSXhElSwy7lpEmFHE3+c+riShiGOyWzRdeVMUlhSZKSgv5shT7xmolE6q
         ZeIrmfuQqyxiBfDQl5yBrM738tH3yutjxVyBZ1IQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v3 1/5] RDMA/core: Add hash functions to calculate RoCEv2 flowlabel and UDP source port
Date:   Mon,  4 May 2020 08:19:31 +0300
Message-Id: <20200504051935.269708-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504051935.269708-1-leon@kernel.org>
References: <20200504051935.269708-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Add two hash functions to distribute RoCE v2 UDP source and Flowlabel
symmetrically. These are user visible API and any change in the
implementation needs to be tested for inter-operability between old and
new variant.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/rdma/ib_verbs.h | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8d29f2f79da8..f44b76a43c6d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4709,4 +4709,48 @@ static inline struct ib_device *rdma_device_to_ibdev(struct device *device)
 
 bool rdma_dev_access_netns(const struct ib_device *device,
 			   const struct net *net);
+
+#define IB_ROCE_UDP_ENCAP_VALID_PORT_MIN (0xC000)
+#define IB_GRH_FLOWLABEL_MASK (0x000FFFFF)
+
+/**
+ * rdma_flow_label_to_udp_sport - generate a RoCE v2 UDP src port value based
+ *                               on the flow_label
+ *
+ * This function will convert the 20 bit flow_label input to a valid RoCE v2
+ * UDP src port 14 bit value. All RoCE V2 drivers should use this same
+ * convention.
+ */
+static inline u16 rdma_flow_label_to_udp_sport(u32 fl)
+{
+	u32 fl_low = fl & 0x03fff, fl_high = fl & 0xFC000;
+
+	fl_low ^= fl_high >> 14;
+	return (u16)(fl_low | IB_ROCE_UDP_ENCAP_VALID_PORT_MIN);
+}
+
+/**
+ * rdma_calc_flow_label - generate a RDMA symmetric flow label value based on
+ *                        local and remote qpn values
+ *
+ * This function folded the multiplication results of two qpns, 24 bit each,
+ * fields, and converts it to a 20 bit results.
+ *
+ * This function will create symmetric flow_label value based on the local
+ * and remote qpn values. this will allow both the requester and responder
+ * to calculate the same flow_label for a given connection.
+ *
+ * This helper function should be used by driver in case the upper layer
+ * provide a zero flow_label value. This is to improve entropy of RDMA
+ * traffic in the network.
+ */
+static inline u32 rdma_calc_flow_label(u32 lqpn, u32 rqpn)
+{
+	u64 v = (u64)lqpn * rqpn;
+
+	v ^= v >> 20;
+	v ^= v >> 40;
+
+	return (u32)(v & IB_GRH_FLOWLABEL_MASK);
+}
 #endif /* IB_VERBS_H */
-- 
2.26.2

