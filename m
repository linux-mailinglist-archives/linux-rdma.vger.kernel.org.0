Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EAD8891
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfJPGXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 02:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfJPGXY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 02:23:24 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC49620873;
        Wed, 16 Oct 2019 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571207002;
        bh=jC3sdtn3A5+rtMuVhfvoDmUx9Vc1tAcaQFKUOdJMPhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4Ye81jSMwByoYmgsgYG/eDy5TOLaceO/fHscBvmmb3fmCjnKLgDIrs9jYBRjhCa5
         SBZBctTDrM0diJP+8WMRxcvBrsgLlSBYzTWdj9t5VRq2tAvbWdIECwOQ4osl5XADPB
         OiqZQSzCZXU87D+5N1fJpouHsZa/lsN25Ui2FsM0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v3 2/4] RDMA/nldev: Allow different fill function per resource
Date:   Wed, 16 Oct 2019 09:23:06 +0300
Message-Id: <20191016062308.11886-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016062308.11886-1-leon@kernel.org>
References: <20191016062308.11886-1-leon@kernel.org>
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
index 0ebe95c79ae0..01851467914a 100644
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
@@ -1128,8 +1131,6 @@ static int nldev_res_get_dumpit(struct sk_buff *skb,
 }

 struct nldev_fill_res_entry {
-	int (*fill_res_func)(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, u32 port);
 	enum rdma_nldev_attr nldev_attr;
 	enum rdma_nldev_command nldev_cmd;
 	u8 flags;
@@ -1143,21 +1144,18 @@ enum nldev_res_flags {

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
@@ -1165,7 +1163,6 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.id = RDMA_NLDEV_ATTR_RES_CQN,
 	},
 	[RDMA_RESTRACK_MR] = {
-		.fill_res_func = fill_res_mr_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_MR_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_MR,
 		.flags = NLDEV_PER_DEV,
@@ -1173,7 +1170,6 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.id = RDMA_NLDEV_ATTR_RES_MRN,
 	},
 	[RDMA_RESTRACK_PD] = {
-		.fill_res_func = fill_res_pd_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_PD_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_PD,
 		.flags = NLDEV_PER_DEV,
@@ -1181,7 +1177,6 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.id = RDMA_NLDEV_ATTR_RES_PDN,
 	},
 	[RDMA_RESTRACK_COUNTER] = {
-		.fill_res_func = fill_res_counter_entry,
 		.nldev_cmd = RDMA_NLDEV_CMD_STAT_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_STAT_COUNTER,
 		.entry = RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,
@@ -1191,7 +1186,8 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {

 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			       struct netlink_ext_ack *extack,
-			       enum rdma_restrack_type res_type)
+			       enum rdma_restrack_type res_type,
+			       res_fill_func_t fill_func)
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1249,7 +1245,9 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}

 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
-	ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
+
+	ret = fill_func(msg, has_cap_net_admin, res, port);
+
 	rdma_restrack_put(res);
 	if (ret)
 		goto err_free;
@@ -1269,7 +1267,8 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,

 static int res_get_common_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb,
-				 enum rdma_restrack_type res_type)
+				 enum rdma_restrack_type res_type,
+				 res_fill_func_t fill_func)
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1354,7 +1353,8 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 			goto msg_full;
 		}

-		ret = fe->fill_res_func(skb, has_cap_net_admin, res, port);
+		ret = fill_func(skb, has_cap_net_admin, res, port);
+
 		rdma_restrack_put(res);

 		if (ret) {
@@ -1397,17 +1397,19 @@ next:		idx++;
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

