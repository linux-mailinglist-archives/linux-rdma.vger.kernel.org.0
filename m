Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6691C202A1E
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgFUKrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKrq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:47:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3ACE248CE;
        Sun, 21 Jun 2020 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736466;
        bh=QZFdchRRc5hRswuHU70PN6GMXeSVBiKsoJidlfZoPDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYxufeC3yCnHeD/YrNAkp/up6f8CaghUrTtnmC9utrz0OTtRDL3vOr+vlZoG5V4hE
         Zx2zDHjg02XCtiY2ouKVChcBffWeUj2C04tPUB4z6KHGRhvgTggpQPXnkwPkmAGN3w
         VieSg8K7qVIuLQAQC0uMcAssSWD0Rnl/h66YnFzg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shay Drory <shayd@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: [PATCH rdma-next 1/4] IB/mad: Fix use after free when destroying MAD agent
Date:   Sun, 21 Jun 2020 13:47:35 +0300
Message-Id: <20200621104738.54850-2-leon@kernel.org>
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

Currently, when RMPP MADs are processed while the MAD agent is
destroyed, it could result in use after free of rmpp_recv, as
decribed below:

	cpu-0						cpu-1
	-----						-----
ib_mad_recv_done()
 ib_mad_complete_recv()
  ib_process_rmpp_recv_wc()
						unregister_mad_agent()
						 ib_cancel_rmpp_recvs()
						  cancel_delayed_work()
   process_rmpp_data()
    start_rmpp()
     queue_delayed_work(rmpp_recv->cleanup_work)
						  destroy_rmpp_recv()
						   free_rmpp_recv()
     cleanup_work()[1]
      spin_lock_irqsave(&rmpp_recv->agent->lock)->use after free

[1] cleanup_work() == recv_cleanup_handler

Fix it by waiting for the MAD agent reference count becoming zero before
calling to ib_cancel_rmpp_recvs().

Fixes: 9a41e38a467c ("IB/mad: Use IDR for agent IDs")
Signed-off-by: Shay Drory <shayd@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 186e0d652e8b..2da889f9b6b3 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -509,10 +509,10 @@ static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 	xa_erase(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
 
 	flush_workqueue(port_priv->wq);
-	ib_cancel_rmpp_recvs(mad_agent_priv);
 
 	deref_mad_agent(mad_agent_priv);
 	wait_for_completion(&mad_agent_priv->comp);
+	ib_cancel_rmpp_recvs(mad_agent_priv);
 
 	ib_mad_agent_security_cleanup(&mad_agent_priv->agent);
 
-- 
2.26.2

