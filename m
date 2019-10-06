Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DBCD339
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2019 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJFPvx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Oct 2019 11:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfJFPvx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Oct 2019 11:51:53 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F5520867;
        Sun,  6 Oct 2019 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570377111;
        bh=8vE5PAEKbH9XYa1SzyrlUv1nIj8mfBSfDNotyosN/Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve0SKQoL8xN/iXBgd3JgHfoQzta+4/wV0L4CPoWXpNxMBp8f255zmOFffBuOSuAVR
         BWlKKhw5DsfuQsEh3XCOHypBCQa5/5aS7Q979Cvu3w6Hm8Pr5XFu8xJnqDMY2L0mI1
         52PkZOS75gzKrtF4a7ur94ZKk+5YNgJMHyvXCkjU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v2 2/4] RDMA/nldev: Allow different fill function per resource
Date:   Sun,  6 Oct 2019 18:51:37 +0300
Message-Id: <20191006155139.30632-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191006155139.30632-1-leon@kernel.org>
References: <20191006155139.30632-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

So far res_get_common_{dumpit, doit} was using the default
resource fill function which was defined as part of the
nldev_fill_res_entry fill_entries.

Add a fill function pointer as an argument allows us to use
different fill function in case we want to dump different
values then 'rdma resource' flow do, but still use the same
existing general resources dumping flow.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index c6fe0c52f6dc..963956eeda3f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -42,6 +42,9 @@
 #include "cma_priv.h"
 #include "restrack.h"
 
+typedef int (*res_fill_func_t)(struct sk_buff*, bool,
+			       struct rdma_restrack_entry*, uint32_t);
+
 /*
  * Sort array elements by the netlink attribute name
  */
@@ -1129,8 +1132,6 @@ static int nldev_res_get_dumpit(struct sk_buff *skb,
 }
 
 struct nldev_fill_res_entry {
-	int (*fill_res_func)(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, u32 port);
 	enum rdma_nldev_attr nldev_attr;
 	enum rdma_nldev_command nldev_cmd;
 	u8 flags;
@@ -1144,21 +1145,18 @@ enum nldev_res_flags {
 
 static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 	[RDMA_RESTRACK_QP] = {
-		.fill_res_func = fill_res_qp_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_QP_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_QP,
 		.entry = RDMA_NLDEV_ATTR_RES_QP_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_LQPN,
 	},
 	[RDMA_RESTRACK_CM_ID] = {
-		.fill_res_func = fill_res_cm_id_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_CM_ID_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_CM_ID,
 		.entry = RDMA_NLDEV_ATTR_RES_CM_ID_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_CM_IDN,
 	},
 	[RDMA_RESTRACK_CQ] = {
-		.fill_res_func = fill_res_cq_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_CQ_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_CQ,
 		.flags = NLDEV_PER_DEV,
@@ -1166,7 +1164,6 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.id = RDMA_NLDEV_ATTR_RES_CQN,
 	},
 	[RDMA_RESTRACK_MR] = {
-		.fill_res_func = fill_res_mr_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_MR_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_MR,
 		.flags = NLDEV_PER_DEV,
@@ -1174,7 +1171,6 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.id = RDMA_NLDEV_ATTR_RES_MRN,
 	},
 	[RDMA_RESTRACK_PD] = {
-		.fill_res_func = fill_res_pd_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_PD_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_PD,
 		.flags = NLDEV_PER_DEV,
@@ -1182,7 +1178,6 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.id = RDMA_NLDEV_ATTR_RES_PDN,
 	},
 	[RDMA_RESTRACK_COUNTER] = {
-		.fill_res_func = fill_res_counter_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_STAT_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_STAT_COUNTER,
 		.entry = RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,
@@ -1192,7 +1187,8 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 
 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			       struct netlink_ext_ack *extack,
-			       enum rdma_restrack_type res_type)
+			       enum rdma_restrack_type res_type,
+			       res_fill_func_t fill_func)
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1250,7 +1246,9 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
-	ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
+
+	ret = fill_func(msg, has_cap_net_admin, res, port);
+
 	rdma_restrack_put(res);
 	if (ret)
 		goto err_free;
@@ -1270,7 +1268,8 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static int res_get_common_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb,
-				 enum rdma_restrack_type res_type)
+				 enum rdma_restrack_type res_type,
+				 res_fill_func_t fill_func)
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1355,7 +1354,8 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 			goto msg_full;
 		}
 
-		ret = fe->fill_res_func(skb, has_cap_net_admin, res, port);
+		ret = fill_func(skb, has_cap_net_admin, res, port);
+
 		rdma_restrack_put(res);
 
 		if (ret) {
@@ -1398,17 +1398,19 @@ next:		idx++;
 	return ret;
 }
 
-#define RES_GET_FUNCS(name, type)                                              \
-	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,          \
+#define RES_GET_FUNCS(name, type)					       \
+	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,	       \
 						 struct netlink_callback *cb)  \
-	{                                                                      \
-		return res_get_common_dumpit(skb, cb, type);                   \
-	}                                                                      \
-	static int nldev_res_get_##name##_doit(struct sk_buff *skb,            \
-					       struct nlmsghdr *nlh,           \
+	{								       \
+		return res_get_common_dumpit(skb, cb, type,		       \
+					     fill_res_##name##_entry);	       \
+	}								       \
+	static int nldev_res_get_##name##_doit(struct sk_buff *skb,	       \
+					       struct nlmsghdr *nlh,	       \
 					       struct netlink_ext_ack *extack) \
-	{                                                                      \
-		return res_get_common_doit(skb, nlh, extack, type);            \
+	{								       \
+		return res_get_common_doit(skb, nlh, extack, type,	       \
+					   fill_res_##name##_entry);	       \
 	}
 
 RES_GET_FUNCS(qp, RDMA_RESTRACK_QP);
-- 
2.20.1

