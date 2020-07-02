Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D923B211ED0
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGBI3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgGBI3t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:29:49 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A188206A1;
        Thu,  2 Jul 2020 08:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593678589;
        bh=0GgkFvh9+fnSaV3Rm4coE9s7YPSP1L3DxbZAY0hchow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGqWl1bMUqZcxeoed7/xp3tzmQeQ0EixHy+VY/JzxehiSC85BnsMXT+8Uvzsa6V12
         UeEMa72j6TRYGKK4Z9y0TLPyrZndp5mTN9+M88zo3KQi3kuWEdDjbNT+WelMDrPvBT
         a52GkXrRVB5rUeM3pFwwBxZPEC26ku4RN+Ua0Lpw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 1/3] RDMA/counter: Add PID category support in auto mode
Date:   Thu,  2 Jul 2020 11:29:31 +0300
Message-Id: <20200702082933.424537-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702082933.424537-1-leon@kernel.org>
References: <20200702082933.424537-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

With the "PID" category QPs have same PID will be bound to same counter;
If this category is not set then QPs have different PIDs will be bound
to same counter.

This is implemented for 2 reasons:
1. The counter is a limited resource, while there may be dozens of
   applications, each of which creates several types of QPs, which means
   it may doesn't have enough counter.
2. The system administrator needs all QPs created by all applications
   with same type bound to one counter.

The counter name and PID is only make sense when "PID" category are
configured.

This category can also be used in combine with others, e.g. QP type.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 20 +++++---------------
 drivers/infiniband/core/nldev.c    |  8 ++++++--
 include/uapi/rdma/rdma_netlink.h   |  1 +
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 738d1faf4bba..9ec8631c3970 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -8,7 +8,7 @@
 #include "core_priv.h"
 #include "restrack.h"
 
-#define ALL_AUTO_MODE_MASKS (RDMA_COUNTER_MASK_QP_TYPE)
+#define ALL_AUTO_MODE_MASKS (RDMA_COUNTER_MASK_QP_TYPE | RDMA_COUNTER_MASK_PID)
 
 static int __counter_set_mode(struct rdma_counter_mode *curr,
 			      enum rdma_nl_counter_mode new_mode,
@@ -149,23 +149,13 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	struct auto_mode_param *param = &counter->mode.param;
 	bool match = true;
 
-	/*
-	 * Ensure that counter belongs to the right PID.  This operation can
-	 * race with user space which kills the process and leaves QP and
-	 * counters orphans.
-	 *
-	 * It is not a big deal because exitted task will leave both QP and
-	 * counter in the same bucket of zombie process. Just ensure that
-	 * process is still alive before procedding.
-	 *
-	 */
-	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task) ||
-	    !task_pid_nr(qp->res.task))
-		return false;
-
 	if (auto_mask & RDMA_COUNTER_MASK_QP_TYPE)
 		match &= (param->qp_type == qp->qp_type);
 
+	if (auto_mask & RDMA_COUNTER_MASK_PID)
+		match &= (task_pid_nr(counter->res.task) ==
+			  task_pid_nr(qp->res.task));
+
 	return match;
 }
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 1051b5622b62..76af7ea2875d 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -711,11 +711,16 @@ static int fill_stat_counter_mode(struct sk_buff *msg,
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_MODE, m->mode))
 		return -EMSGSIZE;
 
-	if (m->mode == RDMA_COUNTER_MODE_AUTO)
+	if (m->mode == RDMA_COUNTER_MODE_AUTO) {
 		if ((m->mask & RDMA_COUNTER_MASK_QP_TYPE) &&
 		    nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_TYPE, m->param.qp_type))
 			return -EMSGSIZE;
 
+		if ((m->mask & RDMA_COUNTER_MASK_PID) &&
+		    fill_res_name_pid(msg, &counter->res))
+			return -EMSGSIZE;
+	}
+
 	return 0;
 }
 
@@ -855,7 +860,6 @@ static int fill_res_counter_entry(struct sk_buff *msg, bool has_cap_net_admin,
 
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, counter->port) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_COUNTER_ID, counter->id) ||
-	    fill_res_name_pid(msg, &counter->res) ||
 	    fill_stat_counter_mode(msg, counter) ||
 	    fill_stat_counter_qps(msg, counter) ||
 	    fill_stat_counter_hwcounters(msg, counter))
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 3826143d420d..d2f5b8396243 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -569,5 +569,6 @@ enum rdma_nl_counter_mode {
  */
 enum rdma_nl_counter_mask {
 	RDMA_COUNTER_MASK_QP_TYPE = 1,
+	RDMA_COUNTER_MASK_PID = 1 << 1,
 };
 #endif /* _UAPI_RDMA_NETLINK_H */
-- 
2.26.2

