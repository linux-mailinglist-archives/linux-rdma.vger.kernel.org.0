Return-Path: <linux-rdma+bounces-8310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E166DA4E07E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035EF179DD3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6D2054E0;
	Tue,  4 Mar 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGluy4Hq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CB204F7F
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097759; cv=none; b=ahEr8PJW7Z1e9W5TRuFcWmiVPWXibeWfT1P3kAMnC0yQ2MB8Vzur4Dmz5X4Op3Hc4e4gN7jNR08/PNh7WjZl7HCQza2fKza1Y/kH62A6TVVCior1NqtIdWIqFAk971Yyive8HL9NUKvPr4XiJev1v+R10ZSAhw5y9vu5Jx9C8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097759; c=relaxed/simple;
	bh=pJkWPIN96OgWhizqGd20CsKU3gl0Qo4uGEqszfsdQJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qais7jkElXvTwyHE904ePLkOLWp9sZQNm0GM+Rbu7FH/joqNhxYLgJnJpv9MXORSiCPYu9JyY58uNFYXRc75CeeShFC1kCCFD57iu0u0ZonCHXrHKmG44KDKHUholp8Ve16zJnGhQ6MGNT7+WCOkzLkrSoVYzcRW3TcgfMexjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGluy4Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE80C4CEE5;
	Tue,  4 Mar 2025 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097758;
	bh=pJkWPIN96OgWhizqGd20CsKU3gl0Qo4uGEqszfsdQJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGluy4HqCusNKZahgshfNwYNj2jA+O0E8BWMXSBkRwx8a9Zkj68HNhPKoJhjjdPnD
	 AxT41+4rQkG6UoaHm2pFoThdmVbcfhlGYDB8liARbWPUoiSqSZvXDGpmNoRSAQhuKn
	 Z+qHX5MDVAcqqATVchntGvd8HYzhF2et+4WDf07EgYNAgwxXIm9eOj3164ARmi4m8p
	 9+gVX5h4J34ZEGrGerf5HEV69q6YlXN0hUb5GDUjiQr94ix/30vUXFJjQpxuS5Rq53
	 4IJdd+lm8B/ibD9ReOh182TEG1ZJpaB8hN2/E0qJ59lJr5sk1e1dWKQ4d4ZpZfL+73
	 h0IkXoDRygf2g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 3/5] RDMA/core: Add support to optional-counters binding configuration
Date: Tue,  4 Mar 2025 16:15:27 +0200
Message-ID: <cb118562cec3cd3ef5aa110495be580522eb7df3.1741097408.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741097408.git.leonro@nvidia.com>
References: <cover.1741097408.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Whenever a new counter is created, save inside it the user requested
configuration for optional-counters binding, for manual configuration it
is requested directly by the user and for the automatic configuration it
depends on if the automatic binding was enabled with or without
optional-counters binding.

This argument will later be used by the driver to determine if to bind the
optional-counters as well or not when trying to bind this counter to a QP.

It indicates that when binding counters to a QP we also want the
currently enabled link optional-counters to be bound as well.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 28 +++++++++++++++++++---------
 drivers/infiniband/core/nldev.c    | 18 ++++++++++++++++--
 include/rdma/rdma_counter.h        |  5 ++++-
 include/uapi/rdma/rdma_netlink.h   |  2 ++
 4 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 981d5a28614a..b270a208214e 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -12,7 +12,8 @@
 
 static int __counter_set_mode(struct rdma_port_counter *port_counter,
 			      enum rdma_nl_counter_mode new_mode,
-			      enum rdma_nl_counter_mask new_mask)
+			      enum rdma_nl_counter_mask new_mask,
+			      bool bind_opcnt)
 {
 	if (new_mode == RDMA_COUNTER_MODE_AUTO) {
 		if (new_mask & (~ALL_AUTO_MODE_MASKS))
@@ -23,6 +24,7 @@ static int __counter_set_mode(struct rdma_port_counter *port_counter,
 
 	port_counter->mode.mode = new_mode;
 	port_counter->mode.mask = new_mask;
+	port_counter->mode.bind_opcnt = bind_opcnt;
 	return 0;
 }
 
@@ -41,6 +43,7 @@ static int __counter_set_mode(struct rdma_port_counter *port_counter,
  */
 int rdma_counter_set_auto_mode(struct ib_device *dev, u32 port,
 			       enum rdma_nl_counter_mask mask,
+			       bool bind_opcnt,
 			       struct netlink_ext_ack *extack)
 {
 	struct rdma_port_counter *port_counter;
@@ -59,12 +62,13 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u32 port,
 						      RDMA_COUNTER_MODE_NONE;
 
 	if (port_counter->mode.mode == mode &&
-	    port_counter->mode.mask == mask) {
+	    port_counter->mode.mask == mask &&
+	    port_counter->mode.bind_opcnt == bind_opcnt) {
 		ret = 0;
 		goto out;
 	}
 
-	ret = __counter_set_mode(port_counter, mode, mask);
+	ret = __counter_set_mode(port_counter, mode, mask, bind_opcnt);
 
 out:
 	mutex_unlock(&port_counter->lock);
@@ -140,7 +144,8 @@ int rdma_counter_modify(struct ib_device *dev, u32 port,
 
 static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
 					   struct ib_qp *qp,
-					   enum rdma_nl_counter_mode mode)
+					   enum rdma_nl_counter_mode mode,
+					   bool bind_opcnt)
 {
 	struct rdma_port_counter *port_counter;
 	struct rdma_counter *counter;
@@ -168,7 +173,7 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
 	switch (mode) {
 	case RDMA_COUNTER_MODE_MANUAL:
 		ret = __counter_set_mode(port_counter, RDMA_COUNTER_MODE_MANUAL,
-					 0);
+					 0, bind_opcnt);
 		if (ret) {
 			mutex_unlock(&port_counter->lock);
 			goto err_mode;
@@ -187,6 +192,7 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
 	mutex_unlock(&port_counter->lock);
 
 	counter->mode.mode = mode;
+	counter->mode.bind_opcnt = bind_opcnt;
 	kref_init(&counter->kref);
 	mutex_init(&counter->lock);
 
@@ -215,7 +221,8 @@ static void rdma_counter_free(struct rdma_counter *counter)
 	port_counter->num_counters--;
 	if (!port_counter->num_counters &&
 	    (port_counter->mode.mode == RDMA_COUNTER_MODE_MANUAL))
-		__counter_set_mode(port_counter, RDMA_COUNTER_MODE_NONE, 0);
+		__counter_set_mode(port_counter, RDMA_COUNTER_MODE_NONE, 0,
+				   false);
 
 	mutex_unlock(&port_counter->lock);
 
@@ -347,7 +354,8 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u32 port)
 			return ret;
 		}
 	} else {
-		counter = alloc_and_bind(dev, port, qp, RDMA_COUNTER_MODE_AUTO);
+		counter = alloc_and_bind(dev, port, qp, RDMA_COUNTER_MODE_AUTO,
+					 port_counter->mode.bind_opcnt);
 		if (!counter)
 			return -ENOMEM;
 	}
@@ -560,7 +568,7 @@ int rdma_counter_bind_qpn_alloc(struct ib_device *dev, u32 port,
 		goto err;
 	}
 
-	counter = alloc_and_bind(dev, port, qp, RDMA_COUNTER_MODE_MANUAL);
+	counter = alloc_and_bind(dev, port, qp, RDMA_COUNTER_MODE_MANUAL, true);
 	if (!counter) {
 		ret = -ENOMEM;
 		goto err;
@@ -615,13 +623,15 @@ int rdma_counter_unbind_qpn(struct ib_device *dev, u32 port,
 
 int rdma_counter_get_mode(struct ib_device *dev, u32 port,
 			  enum rdma_nl_counter_mode *mode,
-			  enum rdma_nl_counter_mask *mask)
+			  enum rdma_nl_counter_mask *mask,
+			  bool *opcnt)
 {
 	struct rdma_port_counter *port_counter;
 
 	port_counter = &dev->port_data[port].port_counter;
 	*mode = port_counter->mode.mode;
 	*mask = port_counter->mode.mask;
+	*opcnt = port_counter->mode.bind_opcnt;
 
 	return 0;
 }
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index cb987ab0177c..a872643e8039 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -171,6 +171,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_PARENT_NAME]		= { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2028,6 +2029,7 @@ static int nldev_stat_set_mode_doit(struct sk_buff *msg,
 				    struct ib_device *device, u32 port)
 {
 	u32 mode, mask = 0, qpn, cntn = 0;
+	bool opcnt = false;
 	int ret;
 
 	/* Currently only counter for QP is supported */
@@ -2035,12 +2037,17 @@ static int nldev_stat_set_mode_doit(struct sk_buff *msg,
 	    nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_RES]) != RDMA_NLDEV_ATTR_RES_QP)
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED])
+		opcnt = !!nla_get_u8(
+			tb[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED]);
+
 	mode = nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_MODE]);
 	if (mode == RDMA_COUNTER_MODE_AUTO) {
 		if (tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK])
 			mask = nla_get_u32(
 				tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]);
-		return rdma_counter_set_auto_mode(device, port, mask, extack);
+		return rdma_counter_set_auto_mode(device, port, mask, opcnt,
+						  extack);
 	}
 
 	if (!tb[RDMA_NLDEV_ATTR_RES_LQPN])
@@ -2358,6 +2365,7 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct ib_device *device;
 	struct sk_buff *msg;
 	u32 index, port;
+	bool opcnt;
 	int ret;
 
 	if (tb[RDMA_NLDEV_ATTR_STAT_COUNTER_ID])
@@ -2393,7 +2401,7 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err_msg;
 	}
 
-	ret = rdma_counter_get_mode(device, port, &mode, &mask);
+	ret = rdma_counter_get_mode(device, port, &mode, &mask, &opcnt);
 	if (ret)
 		goto err_msg;
 
@@ -2410,6 +2418,12 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err_msg;
 	}
 
+	if ((mode == RDMA_COUNTER_MODE_AUTO) &&
+	    nla_put_u8(msg, RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED, opcnt)) {
+		ret = -EMSGSIZE;
+		goto err_msg;
+	}
+
 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 45d5481a7846..74e635409ff7 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -23,6 +23,7 @@ struct rdma_counter_mode {
 	enum rdma_nl_counter_mode mode;
 	enum rdma_nl_counter_mask mask;
 	struct auto_mode_param param;
+	bool bind_opcnt;
 };
 
 struct rdma_port_counter {
@@ -47,6 +48,7 @@ void rdma_counter_init(struct ib_device *dev);
 void rdma_counter_release(struct ib_device *dev);
 int rdma_counter_set_auto_mode(struct ib_device *dev, u32 port,
 			       enum rdma_nl_counter_mask mask,
+			       bool bind_opcnt,
 			       struct netlink_ext_ack *extack);
 int rdma_counter_bind_qp_auto(struct ib_qp *qp, u32 port);
 int rdma_counter_unbind_qp(struct ib_qp *qp, bool force);
@@ -61,7 +63,8 @@ int rdma_counter_unbind_qpn(struct ib_device *dev, u32 port,
 			    u32 qp_num, u32 counter_id);
 int rdma_counter_get_mode(struct ib_device *dev, u32 port,
 			  enum rdma_nl_counter_mode *mode,
-			  enum rdma_nl_counter_mask *mask);
+			  enum rdma_nl_counter_mask *mask,
+			  bool *opcnt);
 
 int rdma_counter_modify(struct ib_device *dev, u32 port,
 			unsigned int index, bool enable);
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 9f9cf20c1cd8..f41f0228fcd0 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -580,6 +580,8 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
 
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
+
+	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.48.1


