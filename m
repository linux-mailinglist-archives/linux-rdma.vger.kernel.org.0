Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D662E78CC
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgL3ND1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Dec 2020 08:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgL3ND1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 08:03:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68B37221FA;
        Wed, 30 Dec 2020 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609333366;
        bh=dnIapniSnrSJvRvKvbPovrOAk7eoj3FAHcT78Qmbu8A=;
        h=From:To:Cc:Subject:Date:From;
        b=MCp+fQuncKHgczBcEHDAhMrC29obyRU0tW7eAOwOgUDsycq7eoXfBw+97/vKV2waz
         Jiy8PGjl4OrdlZ7UwH9NmQhcbNkN7a5YJFJqSjyNGn5aOLB56w8723HlEd8caZl67H
         SI2DeZon7+aNqla6m4XnDSiIgYBdE8oAROYSnHG/Q3zgzihoA530SW8Ojvt3mxqFBS
         tFSWW0NENhcXxf7lzh3bd+A8v+X4PR3xXmJ3q3TkUdVQFoUerKgcttCNRDGdZseD7/
         6iNorJbDtMikBimp89JBiTj2/9/6sFhCT9T1E3R9yHRv2+18zmz1x38fo/VZjqauG4
         te5azmDCE8B0w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/nldev: Return an error message on failure to turn auto mode
Date:   Wed, 30 Dec 2020 15:02:40 +0200
Message-Id: <20201230130240.180737-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

The bounded counter can't be reconfigured to be in auto mode,
in attempt to do it, the user will get an error, but without any
hint why. Update nldev interface to return an error message through
extack mechanism.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 62 ++++++++++++++++--------------
 drivers/infiniband/core/nldev.c    |  4 +-
 include/rdma/rdma_counter.h        |  3 +-
 3 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index b3954fa7bd4b..a2dea275bb0a 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -10,30 +10,35 @@
 
 #define ALL_AUTO_MODE_MASKS (RDMA_COUNTER_MASK_QP_TYPE | RDMA_COUNTER_MASK_PID)
 
-static int __counter_set_mode(struct rdma_counter_mode *curr,
+static int __counter_set_mode(struct rdma_port_counter *port_counter,
 			      enum rdma_nl_counter_mode new_mode,
 			      enum rdma_nl_counter_mask new_mask)
 {
-	if ((new_mode == RDMA_COUNTER_MODE_AUTO) &&
-	    ((new_mask & (~ALL_AUTO_MODE_MASKS)) ||
-	     (curr->mode != RDMA_COUNTER_MODE_NONE)))
-		return -EINVAL;
+	if (new_mode == RDMA_COUNTER_MODE_AUTO && port_counter->num_counters)
+		if (new_mask & ~ALL_AUTO_MODE_MASKS ||
+		    port_counter->mode.mode != RDMA_COUNTER_MODE_NONE)
+			return -EINVAL;
 
-	curr->mode = new_mode;
-	curr->mask = new_mask;
+	port_counter->mode.mode = new_mode;
+	port_counter->mode.mask = new_mask;
 	return 0;
 }
 
 /**
  * rdma_counter_set_auto_mode() - Turn on/off per-port auto mode
  *
- * When @on is true, the @mask must be set; When @on is false, it goes
- * into manual mode if there's any counter, so that the user is able to
- * manually access them.
+ * @dev: Device to operate
+ * @port: Port to use
+ * @mask: Mask to configure
+ * @extack: Message to the user
+ *
+ * Return 0 on success.
  */
 int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
-			       bool on, enum rdma_nl_counter_mask mask)
+			       enum rdma_nl_counter_mask mask,
+			       struct netlink_ext_ack *extack)
 {
+	enum rdma_nl_counter_mode mode = RDMA_COUNTER_MODE_AUTO;
 	struct rdma_port_counter *port_counter;
 	int ret;
 
@@ -42,23 +47,23 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&port_counter->lock);
-	if (on) {
-		ret = __counter_set_mode(&port_counter->mode,
-					 RDMA_COUNTER_MODE_AUTO, mask);
-	} else {
-		if (port_counter->mode.mode != RDMA_COUNTER_MODE_AUTO) {
-			ret = -EINVAL;
-			goto out;
-		}
+	if (mask) {
+		ret = __counter_set_mode(port_counter, mode, mask);
+		if (ret)
+			NL_SET_ERR_MSG(
+				extack,
+				"Turning on auto mode is not allowed when there is bound QP");
+		goto out;
+	}
 
-		if (port_counter->num_counters)
-			ret = __counter_set_mode(&port_counter->mode,
-						 RDMA_COUNTER_MODE_MANUAL, 0);
-		else
-			ret = __counter_set_mode(&port_counter->mode,
-						 RDMA_COUNTER_MODE_NONE, 0);
+	if (port_counter->mode.mode != RDMA_COUNTER_MODE_AUTO) {
+		ret = -EINVAL;
+		goto out;
 	}
 
+	mode = (port_counter->num_counters) ? RDMA_COUNTER_MODE_MANUAL :
+						    RDMA_COUNTER_MODE_NONE;
+	ret = __counter_set_mode(port_counter, mode, 0);
 out:
 	mutex_unlock(&port_counter->lock);
 	return ret;
@@ -137,8 +142,8 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u8 port,
 	mutex_lock(&port_counter->lock);
 	switch (mode) {
 	case RDMA_COUNTER_MODE_MANUAL:
-		ret = __counter_set_mode(&port_counter->mode,
-					 RDMA_COUNTER_MODE_MANUAL, 0);
+		ret = __counter_set_mode(port_counter, RDMA_COUNTER_MODE_MANUAL,
+					 0);
 		if (ret) {
 			mutex_unlock(&port_counter->lock);
 			goto err_mode;
@@ -190,8 +195,7 @@ static void rdma_counter_free(struct rdma_counter *counter)
 	port_counter->num_counters--;
 	if (!port_counter->num_counters &&
 	    (port_counter->mode.mode == RDMA_COUNTER_MODE_MANUAL))
-		__counter_set_mode(&port_counter->mode, RDMA_COUNTER_MODE_NONE,
-				   0);
+		__counter_set_mode(port_counter, RDMA_COUNTER_MODE_NONE, 0);
 
 	mutex_unlock(&port_counter->lock);
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 08366e254b1d..d306049c22a2 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1768,9 +1768,7 @@ static int nldev_stat_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK])
 			mask = nla_get_u32(
 				tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]);
-
-		ret = rdma_counter_set_auto_mode(device, port,
-						 mask ? true : false, mask);
+		ret = rdma_counter_set_auto_mode(device, port, mask, extack);
 		if (ret)
 			goto err_msg;
 	} else {
diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index eb99856e8b30..e75cf9742e04 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -46,7 +46,8 @@ struct rdma_counter {
 void rdma_counter_init(struct ib_device *dev);
 void rdma_counter_release(struct ib_device *dev);
 int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
-			       bool on, enum rdma_nl_counter_mask mask);
+			       enum rdma_nl_counter_mask mask,
+			       struct netlink_ext_ack *extack);
 int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port);
 int rdma_counter_unbind_qp(struct ib_qp *qp, bool force);
 
-- 
2.29.2

