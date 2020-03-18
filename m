Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A863918988B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCRJxJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCRJxJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:53:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7630920770;
        Wed, 18 Mar 2020 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525189;
        bh=rrzBhZtjnluYyJt2O+tQlRicRBiWjdIGSvQQvk+FV1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpB43dMLHd6VWBPDKw5GjS8r41U9+jZXVdMBwOuacbbV77UPO8UgiHpQ3S001oYZT
         hARLZyWohcPZx34rR4ErkS/IZT77GPPNGonJHNmBdevgrAuq6LIKXMlVMrfbIRG6um
         pqy1jbBu+ET3ceo3PhMWXrXYgSoYPtTKwn9L+gvI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 2/6] RDMA/core: Add hash functions to calculate RoCEv2 flowlabel and UDP source port
Date:   Wed, 18 Mar 2020 11:52:56 +0200
Message-Id: <20200318095300.45574-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318095300.45574-1-leon@kernel.org>
References: <20200318095300.45574-1-leon@kernel.org>
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
index 60f9969b6d83..8763d4a06eb7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4703,4 +4703,48 @@ static inline struct ib_device *rdma_device_to_ibdev(struct device *device)
 
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
2.24.1

