Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2E2FD569
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 17:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbhATQUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 11:20:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:34644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbhATQUX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 11:20:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611159576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UOH7Ec+aDNcIiLpdnO2JXblExs2YHw4xgGL+1cbd7R0=;
        b=Yh3hhDO48VV+rMOjVxg4YT+RbL+5by/4nLZdqcZD5PJRX/uVThI3Ho00gHurk9Tl8TN6TL
        wMT8SA5Kt+IoxCWm6ClhV9JbA9zfMsv36jtFWrTygods1GYI+Sec4zs3v3RDTDOqBwQ8XF
        BEdVbS8QgPt8X+vOF9xZTNorIG/FubA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E236AB7F;
        Wed, 20 Jan 2021 16:19:36 +0000 (UTC)
From:   mwilck@suse.com
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Mohammad Heib <goody698@gmail.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH v2] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
Date:   Wed, 20 Jan 2021 17:19:13 +0100
Message-Id: <20210120161913.7347-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

This reverts commit b2d2440430c0fdd5e0cad3efd6d1c9e3d3d02e5b.

It's true that creating rxe on top of 802.1q interfaces doesn't work.
Thus, commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top of vlan interface")
was absolutely correct.

But b2d2440430c0 was incorrect assuming that with this change,
RDMA and VLAN don't work togehter at all. It just has to be
set up differently. Rather than creating rxe on top of the VLAN
interface, rxe must be created on top of the physical interface.
RDMA then works just fine through VLAN interfaces on top of that
physical interface, via the "upper device" logic.

I've tested this mainly with NVMe over RDMA and rping, but I don't
see why it wouldn't work just as well for other protocols. If there
are real issues, I'd like to know.

b2d2440430c0 broke this setup deliberately and should thus be
reverted. Also, b2d2440430c0 removed rxe_dma_device() (which is
indeed not necessary), but not its declaration in rxe_loc.h.

Fixes: b2d2440430c0 ("RDMA/rxe: Remove VLAN code leftovers from RXE")

Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Mohammad Heib <goody698@gmail.com>
Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 1 -
 drivers/infiniband/sw/rxe/rxe_net.c  | 6 ++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0d758760b9ae..8adcef54e4b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -116,7 +116,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
-struct device *rxe_dma_device(struct rxe_dev *rxe);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c4b06ced30a7..943914c2a50c 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -8,6 +8,7 @@
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <linux/if.h>
+#include <linux/if_vlan.h>
 #include <net/udp_tunnel.h>
 #include <net/sch_generic.h>
 #include <linux/netfilter.h>
@@ -153,9 +154,14 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct udphdr *udph;
 	struct net_device *ndev = skb->dev;
+	struct net_device *rdev = ndev;
 	struct rxe_dev *rxe = rxe_get_dev_from_net(ndev);
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 
+	if (!rxe && is_vlan_dev(rdev)) {
+		rdev = vlan_dev_real_dev(ndev);
+		rxe = rxe_get_dev_from_net(rdev);
+	}
 	if (!rxe)
 		goto drop;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5a098083a9d2..c7e3b6a4af38 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -872,6 +872,11 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			else
 				wc->network_hdr_type = RDMA_NETWORK_IPV6;
 
+			if (is_vlan_dev(skb->dev)) {
+				wc->wc_flags |= IB_WC_WITH_VLAN;
+				wc->vlan_id = vlan_dev_vlan_id(skb->dev);
+			}
+
 			if (pkt->mask & RXE_IMMDT_MASK) {
 				wc->wc_flags |= IB_WC_WITH_IMM;
 				wc->ex.imm_data = immdt_imm(pkt);
-- 
2.29.2

