Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96968403929
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbhIHLvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 07:51:52 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:37306 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349231AbhIHLvv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 07:51:51 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2021 07:51:51 EDT
Received: by gentwo.de (Postfix, from userid 1001)
        id 89D6EB0027D; Wed,  8 Sep 2021 13:43:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 85464B00058;
        Wed,  8 Sep 2021 13:43:28 +0200 (CEST)
Date:   Wed, 8 Sep 2021 13:43:28 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     linux-rdma@vger.kernel.org
cc:     Leon Romanovsky <leon@kernel.org>
Subject: [PATCH][FIX] ROCE Multicast: Do not send IGMP leaves for sendonly
 Multicast groups
Message-ID: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ROCE uses IGMP for Multicast instead of the native Infiniband system where
joins are required in order to post messages on the Multicast group.
On Ethernet one can send Multicast messages to arbitrary addresses
without the need to subscribe to a group.

So ROCE correctly does not send IGMP joins during rdma_join_multicast().

F.e. in cma_iboe_join_multicast() we see:

   if (addr->sa_family == AF_INET) {
                if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
                        ib.rec.hop_limit = IPV6_DEFAULT_HOPLIMIT;
                        if (!send_only) {
                                err = cma_igmp_send(ndev, &ib.rec.mgid,
                                                    true);
                        }
                }
        } else {

So the IGMP join is suppressed as it is unnecessary.

However no such check is done in destroy_mc(). And therefore leaving a
sendonly multicast group will send an IGMP leave.

This means that the following scenario can lead to a multicast receiver
unexpectedly being unsubscribed from a MC group:


1. Sender thread does a sendonly join on MC group X. No IGMP join
   is sent.

2. Receiver thread does a regular join on the same MC Group x.
   IGMP join is sent and the receiver begins to get messages.

3. Sender thread terminates and destroys MC group X.
   IGMP leave is sent and the receiver no longer receives data.

This patch adds the same logic for sendonly joins to destroy_mc()
that is also used in cma_iboe_join_multicast().

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/drivers/infiniband/core/cma.c
===================================================================
--- linux.orig/drivers/infiniband/core/cma.c	2021-09-08 12:59:51.602754272 +0200
+++ linux/drivers/infiniband/core/cma.c	2021-09-08 13:05:20.269838488 +0200
@@ -1810,6 +1810,8 @@ static void cma_release_port(struct rdma
 static void destroy_mc(struct rdma_id_private *id_priv,
 		       struct cma_multicast *mc)
 {
+	bool send_only = mc->join_state == BIT(SENDONLY_FULLMEMBER_JOIN);
+
 	if (rdma_cap_ib_mcast(id_priv->id.device, id_priv->id.port_num))
 		ib_sa_free_multicast(mc->sa_mc);

@@ -1826,7 +1828,10 @@ static void destroy_mc(struct rdma_id_pr

 			cma_set_mgid(id_priv, (struct sockaddr *)&mc->addr,
 				     &mgid);
-			cma_igmp_send(ndev, &mgid, false);
+
+			if (!send_only)
+				cma_igmp_send(ndev, &mgid, false);
+
 			dev_put(ndev);
 		}

