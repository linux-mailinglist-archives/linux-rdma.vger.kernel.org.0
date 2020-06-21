Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318D4202A20
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgFUKry (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKry (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:47:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAEFC248CA;
        Sun, 21 Jun 2020 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736473;
        bh=2a9c8SJdlx0QHaIQyjcRpcfi42a01HiHLspJy+ptzrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygIR1e5QeVs81wYcBHznND17G+dCetCWGjJqoyWmkDqIHRxXmaUU6+qk1hyDQUYeR
         E2hnGrkZ1rrJ/KT5e4hn0Sy2d0KsbcsfPNxy5vXYqNhoZB8LLzw+oPpLLME9YfIbGh
         VUDIZrjiKv0YczggK+x50iozgySrg4JmaQiOqges=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shay Drory <shayd@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/4] IB/mad: Delete RMPP_STATE_CANCELING state
Date:   Sun, 21 Jun 2020 13:47:38 +0300
Message-Id: <20200621104738.54850-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200621104738.54850-1-leon@kernel.org>
References: <20200621104738.54850-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@mellanox.com>

The cancel_delayed_work can be called under lock since it doesn't sleep.
This makes the RMPP_STATE_CANCELING state is not needed anymore.

Signed-off-by: Shay Drory <shayd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad_rmpp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 1bc9dfecae70..e0573e4d0404 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -40,8 +40,7 @@
 enum rmpp_state {
 	RMPP_STATE_ACTIVE,
 	RMPP_STATE_TIMEOUT,
-	RMPP_STATE_COMPLETE,
-	RMPP_STATE_CANCELING
+	RMPP_STATE_COMPLETE
 };
 
 struct mad_rmpp_recv {
@@ -91,23 +90,19 @@ void ib_cancel_rmpp_recvs(struct ib_mad_agent_private *agent)
 	unsigned long flags;
 
 	spin_lock_irqsave(&agent->lock, flags);
-	list_for_each_entry(rmpp_recv, &agent->rmpp_list, list) {
-		if (rmpp_recv->state != RMPP_STATE_COMPLETE)
-			ib_free_recv_mad(rmpp_recv->rmpp_wc);
-		rmpp_recv->state = RMPP_STATE_CANCELING;
-	}
-	spin_unlock_irqrestore(&agent->lock, flags);
-
 	list_for_each_entry(rmpp_recv, &agent->rmpp_list, list) {
 		cancel_delayed_work(&rmpp_recv->timeout_work);
 		cancel_delayed_work(&rmpp_recv->cleanup_work);
 	}
+	spin_unlock_irqrestore(&agent->lock, flags);
 
 	flush_workqueue(agent->qp_info->port_priv->wq);
 
 	list_for_each_entry_safe(rmpp_recv, temp_rmpp_recv,
 				 &agent->rmpp_list, list) {
 		list_del(&rmpp_recv->list);
+		if (rmpp_recv->state != RMPP_STATE_COMPLETE)
+			ib_free_recv_mad(rmpp_recv->rmpp_wc);
 		destroy_rmpp_recv(rmpp_recv);
 	}
 }
@@ -272,10 +267,6 @@ static void recv_cleanup_handler(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&rmpp_recv->agent->lock, flags);
-	if (rmpp_recv->state == RMPP_STATE_CANCELING) {
-		spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
-		return;
-	}
 	list_del(&rmpp_recv->list);
 	spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
 	destroy_rmpp_recv(rmpp_recv);
-- 
2.26.2

