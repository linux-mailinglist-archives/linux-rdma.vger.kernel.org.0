Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C22A2C56
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKBONy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 09:13:54 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48451 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725889AbgKBONy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 09:13:54 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yanjunz@mellanox.com)
        with SMTP; 2 Nov 2020 16:13:49 +0200
Received: from bc-vnc02.mtbc.labs.mlnx (bc-vnc02.mtbc.labs.mlnx [10.75.68.111])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0A2EDmvO004774;
        Mon, 2 Nov 2020 16:13:49 +0200
Received: from bc-vnc02.mtbc.labs.mlnx (localhost [127.0.0.1])
        by bc-vnc02.mtbc.labs.mlnx (8.14.4/8.14.4) with ESMTP id 0A2EDmkc018678;
        Mon, 2 Nov 2020 22:13:48 +0800
Received: (from yanjunz@localhost)
        by bc-vnc02.mtbc.labs.mlnx (8.14.4/8.14.4/Submit) id 0A2EDjhm018676;
        Mon, 2 Nov 2020 22:13:45 +0800
From:   Zhu Yanjun <yanjunz@nvidia.com>
To:     zyjzyj2000@gmail.com, yanjunz@nvidia.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: [PATCH 1/1] RDMA/rxe: Remove VLAN code leftovers from RXE
Date:   Mon,  2 Nov 2020 22:13:42 +0800
Message-Id: <1604326422-18625-1-git-send-email-yanjunz@nvidia.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since the commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on
top of vlan interface") does not permit rxe on top of vlan device,
all the stuff related with vlan should be removed.

Fixes: fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top of vlan interface")
Signed-off-by: Zhu Yanjun <yanjunz@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c  |    9 ---------
 drivers/infiniband/sw/rxe/rxe_resp.c |    5 -----
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 5731d9b..2e490e5 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -8,7 +8,6 @@
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <linux/if.h>
-#include <linux/if_vlan.h>
 #include <net/udp_tunnel.h>
 #include <net/sch_generic.h>
 #include <linux/netfilter.h>
@@ -26,9 +25,6 @@ struct device *rxe_dma_device(struct rxe_dev *rxe)
 
 	ndev = rxe->ndev;
 
-	if (is_vlan_dev(ndev))
-		ndev = vlan_dev_real_dev(ndev);
-
 	return ndev->dev.parent;
 }
 
@@ -58,14 +54,9 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct udphdr *udph;
 	struct net_device *ndev = skb->dev;
-	struct net_device *rdev = ndev;
 	struct rxe_dev *rxe = rxe_get_dev_from_net(ndev);
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 
-	if (!rxe && is_vlan_dev(rdev)) {
-		rdev = vlan_dev_real_dev(ndev);
-		rxe = rxe_get_dev_from_net(rdev);
-	}
 	if (!rxe)
 		goto drop;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c7e3b6a..5a09808 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -872,11 +872,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			else
 				wc->network_hdr_type = RDMA_NETWORK_IPV6;
 
-			if (is_vlan_dev(skb->dev)) {
-				wc->wc_flags |= IB_WC_WITH_VLAN;
-				wc->vlan_id = vlan_dev_vlan_id(skb->dev);
-			}
-
 			if (pkt->mask & RXE_IMMDT_MASK) {
 				wc->wc_flags |= IB_WC_WITH_IMM;
 				wc->ex.imm_data = immdt_imm(pkt);
-- 
1.7.1

