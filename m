Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC5A31FC
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfH3IQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 04:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfH3IQf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 04:16:35 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE8C21726;
        Fri, 30 Aug 2019 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567152994;
        bh=ksp7FJCn1goh0PL+SVSVHMzM1wb3kcDVKowd6mXDSyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxIbChhbCkR1j351sT91myMpgOXBW6BSx0ZmVzUUMhsIAuxaOTbPsr6ENTdzPIXxs
         hI8Kz1Fr5qU0O45FjfbVoMnKRHDwsH6+XNUjkB1tmHyp4xpJQdEPXgGg5HOu4dXb1p
         lPYFwoXYPl8u1ogerpAbIVnpBtaJ3YikQo3XEUBA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v1 2/4] RDMA/nldev: Allow different fill function per resource
Date:   Fri, 30 Aug 2019 11:16:10 +0300
Message-Id: <20190830081612.2611-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830081612.2611-1-leon@kernel.org>
References: <20190830081612.2611-1-leon@kernel.org>
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

If a NULL value is passed, it will be using the default
fill function that was defined in 'fill_entries' for a
given resource type.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 42 +++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index cc08218f1ef7..47f7fe5432db 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1181,7 +1181,10 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 
 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			       struct netlink_ext_ack *extack,
-			       enum rdma_restrack_type res_type)
+			       enum rdma_restrack_type res_type,
+			       int (*fill_func)(struct sk_buff*, bool,
+						struct rdma_restrack_entry*,
+						uint32_t))
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1244,7 +1247,12 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
-	ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
+
+	if (fill_func)
+		ret = fill_func(msg, has_cap_net_admin, res, port);
+	else
+		ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
+
 	rdma_restrack_put(res);
 	if (ret)
 		goto err_free;
@@ -1264,7 +1272,10 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static int res_get_common_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb,
-				 enum rdma_restrack_type res_type)
+				 enum rdma_restrack_type res_type,
+				 int (*fill_func)(struct sk_buff*, bool,
+						  struct rdma_restrack_entry*,
+						  uint32_t))
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1352,7 +1363,12 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 			goto msg_full;
 		}
 
-		ret = fe->fill_res_func(skb, has_cap_net_admin, res, port);
+		if (fill_func)
+			ret = fill_func(skb, has_cap_net_admin, res, port);
+		else
+			ret = fe->fill_res_func(skb, has_cap_net_admin,
+						res, port);
+
 		rdma_restrack_put(res);
 
 		if (ret) {
@@ -1395,17 +1411,17 @@ next:		idx++;
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
+		return res_get_common_dumpit(skb, cb, type, NULL);	       \
+	}								       \
+	static int nldev_res_get_##name##_doit(struct sk_buff *skb,	       \
+					       struct nlmsghdr *nlh,	       \
 					       struct netlink_ext_ack *extack) \
-	{                                                                      \
-		return res_get_common_doit(skb, nlh, extack, type);            \
+	{								       \
+		return res_get_common_doit(skb, nlh, extack, type, NULL);      \
 	}
 
 RES_GET_FUNCS(qp, RDMA_RESTRACK_QP);
-- 
2.20.1

