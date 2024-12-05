Return-Path: <linux-rdma+bounces-6309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89819E57D8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9272A286D4B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF621A432;
	Thu,  5 Dec 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntLcNwwM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F421A42C
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406671; cv=none; b=F2oE/Wjv993qAjMjded8zqFv+Uubb90G8Q4Krv8eRqxKwTSBPRBIfgo6B4nXn9wWEfn0C18GQ/drtjoRhmX7SsHwf9Jp6wt8rZdQu46SyY/m52nkRJpPoAamD4LbW35trntu5SIQuL2/KkJq+Rcx2Jvlwo4FaeNQ0bQGQS+oiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406671; c=relaxed/simple;
	bh=kRqSU0RzZQS/L/t1ONQV1CkuInqx4FqFwHX0X0L5hUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCy278Z1Wx5OKbVRLB3BQ0DC/hyqLUYxqoIJgauf2BWLEBmkQjmAtrLBSeZ9KfbFQsiUQMMl5LkA/PoMbz9RrYUomQ8L0k9ZEp/InH3+vFfvOyXDyUZNUAh/vCd2o8vc3ySyc/2HarcG5GiH+qELe5f+lmuEqueeI4mW4E2oaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntLcNwwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73EDC4CEDD;
	Thu,  5 Dec 2024 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406671;
	bh=kRqSU0RzZQS/L/t1ONQV1CkuInqx4FqFwHX0X0L5hUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntLcNwwM8YPF8uFBRJ9y+jFZyJZy9L+rQo9k2yC8F2Pqk9j3TTEl/psnYYb3Yj7uU
	 eIEf2xiWNq0EhBri9F9/7wzfjanM4FxyEi1KF0Nz3hLfpk6mQgmbJtIgeTo4FhG8cF
	 VrZQd1NGDOenH3PFf+Rix3PdnGB+TJUpRhjiGBVPbEyCSxUSlvVFoxDKq21HL9+FHC
	 oN/I0h03Hdz62yoEGU6CP3cv+EnZWUvhY8PBcv1CAGZWHSM7DBipd0t32JVqjof/0R
	 pVZ8wAUwv3BbXJGzuRW0hmaHvgSVe5wr0q9vzgW6TBoP1gfu/cq4v84tJw//t+isGO
	 4LnUy6HBgOAGA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 8/9] RDMA/nldev: Add mad-linear-timeouts management attribute
Date: Thu,  5 Dec 2024 15:49:38 +0200
Message-ID: <5328045b50805d019606f724b439104bbef3ff69.1733405453.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733405453.git.leon@kernel.org>
References: <cover.1733405453.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

This attribute allows system admins to make a trade-off between speed
of recovery under transient loss and reducing congestion under
persistent loss or overload.

Set 15 as max value as it allows sys admins to effectively opt-out the
CM from exponential backoff.  CM is currently using CMA_MAX_CM_RETRIES
(15) constant to set retries.  Other MAD layer callers use different
values (e.g., sa_query uses 10, UMAD exposes the parameter to
userspace), but a max of 15 linear retries should be enough.

Example:
  # rdma management show rocep1s0f1/1
  1: rocep1s0f1: 1 mad-linear-timeouts 4 ...
  # rdma management set rocep1s0f1/1 mad-linear-timeouts 6
  # rdma management show
  0: rocep1s0f0: 1 mad-linear-timeouts 4 ...
  1: rocep1s0f1: 1 mad-linear-timeouts 6 ...

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 35 ++++++++++++++++++++++++++++++
 drivers/infiniband/core/mad_priv.h |  4 ++++
 drivers/infiniband/core/nldev.c    | 19 ++++++++++++++++
 include/uapi/rdma/rdma_netlink.h   |  2 ++
 4 files changed, 60 insertions(+)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index a3a8cf4bbc20..7c4ac8ae0a3f 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -54,7 +54,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ib_mad.h>
 
+#define IB_MAD_LINEAR_TIMEOUTS_MIN	1
 #define IB_MAD_LINEAR_TIMEOUTS_DEFAULT	4
+#define IB_MAD_LINEAR_TIMEOUTS_MAX	15
 #define IB_MAD_MAX_TIMEOUT_MS		(60 * MSEC_PER_SEC)
 #define IB_MAD_MAX_DEADLINE		(jiffies + msecs_to_jiffies(5 * 60 * 1000))
 
@@ -145,6 +147,39 @@ ib_get_mad_port(struct ib_device *device, u32 port_num)
 	return entry;
 }
 
+int ib_mad_linear_timeouts_set(struct ib_device *dev, u32 port_num, u8 val,
+			       struct netlink_ext_ack *extack)
+{
+	struct ib_mad_port_private *port = ib_get_mad_port(dev, port_num);
+
+	if (!port)
+		return -ENODEV;
+
+	if (val > IB_MAD_LINEAR_TIMEOUTS_MAX ||
+	    val < IB_MAD_LINEAR_TIMEOUTS_MIN) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Valid range [%u-%u]",
+				       IB_MAD_LINEAR_TIMEOUTS_MIN,
+				       IB_MAD_LINEAR_TIMEOUTS_MAX);
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(port->linear_timeouts, val);
+
+	return 0;
+}
+
+int ib_mad_linear_timeouts_get(struct ib_device *dev, u32 port_num, u8 *val)
+{
+	struct ib_mad_port_private *port = ib_get_mad_port(dev, port_num);
+
+	if (!port)
+		return -ENODEV;
+
+	*val = READ_ONCE(port->linear_timeouts);
+
+	return 0;
+}
+
 static inline u8 convert_mgmt_class(u8 mgmt_class)
 {
 	/* Alias IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE to 0 */
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 076ebcea27b4..e6b362c054a6 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -241,4 +241,8 @@ void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr);
 void ib_reset_mad_timeout(struct ib_mad_send_wr_private *mad_send_wr,
 			  unsigned long timeout_ms);
 
+int ib_mad_linear_timeouts_set(struct ib_device *dev, u32 port_num, u8 val,
+			       struct netlink_ext_ack *extack);
+int ib_mad_linear_timeouts_get(struct ib_device *dev, u32 port_num, u8 *val);
+
 #endif	/* __IB_MAD_PRIV_H__ */
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 363742567dd2..acb02f8c87c0 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -172,6 +172,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_MGMT_ATTR_SA_MIN_TIMEOUT]	= { .type = NLA_U32 },
+	[RDMA_NLDEV_MGMT_ATTR_MAD_LINEAR_TIMEOUTS] = { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2627,6 +2628,7 @@ static int nldev_mgmt_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	struct ib_device *device;
+	u8 mad_linear_timeouts;
 	struct sk_buff *msg;
 	u32 index;
 	u32 port;
@@ -2657,6 +2659,10 @@ static int nldev_mgmt_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto err;
 	}
 
+	ret = ib_mad_linear_timeouts_get(device, port, &mad_linear_timeouts);
+	if (ret)
+		goto err;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -2680,6 +2686,11 @@ static int nldev_mgmt_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto err_msg;
 	}
 
+	ret = nla_put_u8(msg, RDMA_NLDEV_MGMT_ATTR_MAD_LINEAR_TIMEOUTS,
+			 mad_linear_timeouts);
+	if (ret)
+		goto err_msg;
+
 	nlmsg_end(msg, nlh);
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
 
@@ -2695,6 +2706,7 @@ static int nldev_set_mgmt_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	struct ib_device *device;
+	u8 mad_linear_timeouts;
 	u32 index;
 	u32 port;
 	u32 sa_min_timeout;
@@ -2723,6 +2735,13 @@ static int nldev_set_mgmt_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 					     extack);
 	}
 
+	if (tb[RDMA_NLDEV_MGMT_ATTR_MAD_LINEAR_TIMEOUTS]) {
+		mad_linear_timeouts = nla_get_u8(
+			tb[RDMA_NLDEV_MGMT_ATTR_MAD_LINEAR_TIMEOUTS]);
+		return ib_mad_linear_timeouts_set(device, port,
+						  mad_linear_timeouts, extack);
+	}
+
 err:
 	ib_device_put(device);
 	return -EINVAL;
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 2b1c4c55e51f..d209a5973c8e 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -585,6 +585,8 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_MGMT_ATTR_SA_MIN_TIMEOUT,	/* u32 */
+
+	RDMA_NLDEV_MGMT_ATTR_MAD_LINEAR_TIMEOUTS, /* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.47.0


