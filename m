Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5775CB2B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjGUPNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjGUPNw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 11:13:52 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 08:13:43 PDT
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9DA30DB;
        Fri, 21 Jul 2023 08:13:43 -0700 (PDT)
Received: from tp-owlcat.intra.ispras.ru (unknown [10.10.165.6])
        by mail.ispras.ru (Postfix) with ESMTPSA id EB21640B27AF;
        Fri, 21 Jul 2023 15:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EB21640B27AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1689951958;
        bh=O0b5d9evA9lwBqNidYtPEYBZ7CVLeRcJ2bV1Mfo3SIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0i1WqiRtXiHhhkHUV6IlKrtQZAUvVRZe2S/M7HAqcGQgRINg/yP+yIxGj8NDuExT
         HcMpCxo3hW8I+RUP3qIk0iiZlFAaKzD7oZxLMLwymxhgd6UzhMKP3qolInJfOGDCU5
         7J0zU+X38yJMauQdaYJe2v5R7i2uN6fQrQ93EuIE=
From:   Anton Gusev <aagusev@ispras.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anton Gusev <aagusev@ispras.ru>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.10 1/1] RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests
Date:   Fri, 21 Jul 2023 18:05:33 +0300
Message-ID: <20230721150535.191318-2-aagusev@ispras.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721150535.191318-1-aagusev@ispras.ru>
References: <20230721150535.191318-1-aagusev@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

commit 305d568b72f17f674155a2a8275f865f207b3808 upstream.

The FSM can run in a circle allowing rdma_resolve_ip() to be called twice
on the same id_priv. While this cannot happen without going through the
work, it violates the invariant that the same address resolution
background request cannot be active twice.

       CPU 1                                  CPU 2

rdma_resolve_addr():
  RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
  rdma_resolve_ip(addr_handler)  #1

			 process_one_req(): for #1
                          addr_handler():
                            RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
                            mutex_unlock(&id_priv->handler_mutex);
                            [.. handler still running ..]

rdma_resolve_addr():
  RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
  rdma_resolve_ip(addr_handler)
    !! two requests are now on the req_list

rdma_destroy_id():
 destroy_id_handler_unlock():
  _destroy_id():
   cma_cancel_operation():
    rdma_addr_cancel()

                          // process_one_req() self removes it
		          spin_lock_bh(&lock);
                           cancel_delayed_work(&req->work);
	                   if (!list_empty(&req->list)) == true

      ! rdma_addr_cancel() returns after process_on_req #1 is done

   kfree(id_priv)

			 process_one_req(): for #2
                          addr_handler():
	                    mutex_lock(&id_priv->handler_mutex);
                            !! Use after free on id_priv

rdma_addr_cancel() expects there to be one req on the list and only
cancels the first one. The self-removal behavior of the work only happens
after the handler has returned. This yields a situations where the
req_list can have two reqs for the same "handle" but rdma_addr_cancel()
only cancels the first one.

The second req remains active beyond rdma_destroy_id() and will
use-after-free id_priv once it inevitably triggers.

Fix this by remembering if the id_priv has called rdma_resolve_ip() and
always cancel before calling it again. This ensures the req_list never
gets more than one item in it and doesn't cost anything in the normal flow
that never uses this strange error path.

Link: https://lore.kernel.org/r/0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: e51060f08a61 ("IB: IP address based RDMA connection manager")
Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Anton Gusev <aagusev@ispras.ru>
---
 drivers/infiniband/core/cma.c      | 23 +++++++++++++++++++++++
 drivers/infiniband/core/cma_priv.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index db24f7dfa00f..805678f6fe57 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1792,6 +1792,14 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
 {
 	switch (state) {
 	case RDMA_CM_ADDR_QUERY:
+		/*
+		 * We can avoid doing the rdma_addr_cancel() based on state,
+		 * only RDMA_CM_ADDR_QUERY has a work that could still execute.
+		 * Notice that the addr_handler work could still be exiting
+		 * outside this state, however due to the interaction with the
+		 * handler_mutex the work is guaranteed not to touch id_priv
+		 * during exit.
+		 */
 		rdma_addr_cancel(&id_priv->id.route.addr.dev_addr);
 		break;
 	case RDMA_CM_ROUTE_QUERY:
@@ -3401,6 +3409,21 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 		if (dst_addr->sa_family == AF_IB) {
 			ret = cma_resolve_ib_addr(id_priv);
 		} else {
+			/*
+			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
+			 * rdma_resolve_ip() is called, eg through the error
+			 * path in addr_handler(). If this happens the existing
+			 * request must be canceled before issuing a new one.
+			 * Since canceling a request is a bit slow and this
+			 * oddball path is rare, keep track once a request has
+			 * been issued. The track turns out to be a permanent
+			 * state since this is the only cancel as it is
+			 * immediately before rdma_resolve_ip().
+			 */
+			if (id_priv->used_resolve_ip)
+				rdma_addr_cancel(&id->route.addr.dev_addr);
+			else
+				id_priv->used_resolve_ip = 1;
 			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
 					      &id->route.addr.dev_addr,
 					      timeout_ms, addr_handler,
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index caece96ebcf5..b53f4fa5e3fb 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -89,6 +89,7 @@ struct rdma_id_private {
 	u8			reuseaddr;
 	u8			afonly;
 	u8			timeout;
+	u8 used_resolve_ip;
 	enum ib_gid_type	gid_type;
 
 	/*
-- 
2.41.0

