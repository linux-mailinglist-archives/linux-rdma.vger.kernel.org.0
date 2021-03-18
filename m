Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B918F34042A
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhCRLFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 07:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhCRLFK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 07:05:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87B0D64D9A;
        Thu, 18 Mar 2021 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616065509;
        bh=6/FQcsth/588wh4iNselpitEl4VqGz+DGwJuwR2mdoE=;
        h=From:To:Cc:Subject:Date:From;
        b=UbD+wyz02qFoU+kIn7w+DpzIGLKyGuwgqL48jIdKCNa04KpO1bB+CTJheriBvYkOF
         /hxeDurPppB3O0aUc8E7FeQmxW7Ahxc0Tsv/nm9qhjbSIf6n20702u3ICoIn0PqmV4
         pXjWvPpNPfz2ncy8c/wmEu4n8IkjmiNlpZPFEhoGvEAaHPoQ7oc8o2jA1b241Y1u2v
         q+d8HXLmRbCPr1sPzv6b8V4B7C4TQbQOMrZs0rsHnXWNKGbTPcdV+y5LEtvaSe/U8t
         Vs0vgPibyapJ5e6ZOakqd8n2sm2LQvMkr6Jm63+KUgyrUP0LVsOnPApaTTkWbtP6rt
         xWNy7cNUDGMFA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next] RDMA/counters: Refactor rdma_counter_set_auto_mode and __counter_set_mode
Date:   Thu, 18 Mar 2021 13:05:02 +0200
Message-Id: <20210318110502.673676-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

The success is returned in the following flows:
 * New mode is the same as the current one.
 * Switched to new mode and there are no bound counters yet.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 42 +++++++++++++++++-------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index a284a358de51..9fa799327ff4 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -14,10 +14,12 @@ static int __counter_set_mode(struct rdma_port_counter *port_counter,
 			      enum rdma_nl_counter_mode new_mode,
 			      enum rdma_nl_counter_mask new_mask)
 {
-	if (new_mode == RDMA_COUNTER_MODE_AUTO && port_counter->num_counters)
-		if (new_mask & ~ALL_AUTO_MODE_MASKS ||
-		    port_counter->mode.mode != RDMA_COUNTER_MODE_NONE)
+	if (new_mode == RDMA_COUNTER_MODE_AUTO) {
+		if (new_mask & (~ALL_AUTO_MODE_MASKS))
 			return -EINVAL;
+		if (port_counter->num_counters)
+			return -EBUSY;
+	}
 
 	port_counter->mode.mode = new_mode;
 	port_counter->mode.mask = new_mask;
@@ -32,14 +34,17 @@ static int __counter_set_mode(struct rdma_port_counter *port_counter,
  * @mask: Mask to configure
  * @extack: Message to the user
  *
- * Return 0 on success.
+ * Return 0 on success. If counter mode wasn't changed then it is considered
+ * as success as well.
+ * Return -EBUSY when changing to auto mode while there are bounded counters.
+ *
  */
 int rdma_counter_set_auto_mode(struct ib_device *dev, u32 port,
 			       enum rdma_nl_counter_mask mask,
 			       struct netlink_ext_ack *extack)
 {
-	enum rdma_nl_counter_mode mode = RDMA_COUNTER_MODE_AUTO;
 	struct rdma_port_counter *port_counter;
+	enum rdma_nl_counter_mode mode;
 	int ret;
 
 	port_counter = &dev->port_data[port].port_counter;
@@ -47,25 +52,26 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u32 port,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&port_counter->lock);
-	if (mask) {
-		ret = __counter_set_mode(port_counter, mode, mask);
-		if (ret)
-			NL_SET_ERR_MSG(
-				extack,
-				"Turning on auto mode is not allowed when there is bound QP");
+	if (mask)
+		mode = RDMA_COUNTER_MODE_AUTO;
+	else
+		mode = (port_counter->num_counters) ? RDMA_COUNTER_MODE_MANUAL :
+						      RDMA_COUNTER_MODE_NONE;
+
+	if (port_counter->mode.mode == mode &&
+	    port_counter->mode.mask == mask) {
+		ret = 0;
 		goto out;
 	}
 
-	if (port_counter->mode.mode != RDMA_COUNTER_MODE_AUTO) {
-		ret = -EINVAL;
-		goto out;
-	}
+	ret = __counter_set_mode(port_counter, mode, mask);
 
-	mode = (port_counter->num_counters) ? RDMA_COUNTER_MODE_MANUAL :
-						    RDMA_COUNTER_MODE_NONE;
-	ret = __counter_set_mode(port_counter, mode, 0);
 out:
 	mutex_unlock(&port_counter->lock);
+	if (ret == -EBUSY)
+		NL_SET_ERR_MSG(
+			extack,
+			"Modifying auto mode is not allowed when there is bound QP");
 	return ret;
 }
 
-- 
2.30.2

