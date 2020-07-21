Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED12227CBB
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 12:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgGUKSZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 06:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgGUKSZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 06:18:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E72C061794
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 03:18:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so2303317wmi.4
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVMAF1dptRPrPp19iX6LOEOzwnGMpaX19bqJ5tHPxzg=;
        b=NfU2KONWTZf4NHU83IqJFIDskEqX04+BfTwK+FX5BlwRqytc61945k1/+Oprs37Uv0
         I+8VqQvkCMEXUB5dLtaHnyN6CAXzu5LNBgDyiLE1lb0YLCDSg7QxZclAIfPeLSRTYRJO
         D0q2KWYN9MCk//27WnUPnLV6W0Mw5QEgeeS4Xyyls8kg1XI/Vv+6avQhxiNwMmxS3Xaj
         q4ebcv1Jw1Q7FyWfopWsm3ahwv2MQ7JAHK7q0yq7HmBCfN7CfoqEPYbOxslXpFcYWF+I
         yRQeFEXOrAwb7WFhIx2Nqr0XfcOQoPPaDfS1nRxn5NbnM9BmExfmKKBIIJMAThflgaTz
         jgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVMAF1dptRPrPp19iX6LOEOzwnGMpaX19bqJ5tHPxzg=;
        b=SWjuLpTvS7fw+8Jwl3sU3EmGrz17Prcl7WEunYArYmgoiYIhTeDMtOpvQK07S2tyyS
         6UJiQXPrUnHYQcP/1I1QKHd6ZTTet4YT/CH02l0IHm2vmz6vXJIMUG3S3VIamPMj4POc
         rsT6Sv1rAa3MS6KcJRZUPslM3fDO3Tg1s+0lcB4gThNTgzbnuJECBhjuxtQazJVKa3g4
         D44h15mZ+ZKhFuWlZ0aPReWcneK2ikHk6oW2eUYbGaP5lShxq2xycqhb772jJxLwOoxd
         PQqKLYA8J5yjIJQn49+6GaupNAPZPFZROI/43K6dMK/RVvkmQJonBJsS8Xf9yLHpKrEG
         QwmQ==
X-Gm-Message-State: AOAM5313cIJ8kO1aE5ZRyJJ2UAYbsYlp8G/4ggTLQ7f3U7A216e0e0q3
        DTHNCUDOkly2RYJdOrj3Le3F7kyPnOc=
X-Google-Smtp-Source: ABdhPJxgRtAGEMF0X4Hcw8XcNs0CK4FGui1QsbxuuGP7tNJ+pn2UQpDn5g4Linj9fqwQtCOC3brXPQ==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr3403789wmg.153.1595326703205;
        Tue, 21 Jul 2020 03:18:23 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id m4sm2723363wmi.48.2020.07.21.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:18:22 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
Date:   Tue, 21 Jul 2020 13:16:18 +0300
Message-Id: <20200721101618.686110-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The RoCE spec require from RoCE devices to support only the defualt pkey,
While the rxe driver maintain a 64 enties pkey table and use only the
first entry. With that said remove the maintaing of the pkey table and
used the default pkey when needed.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 34 +++------------------------
 drivers/infiniband/sw/rxe/rxe_param.h |  4 ++--
 drivers/infiniband/sw/rxe/rxe_recv.c  | 29 ++++-------------------
 drivers/infiniband/sw/rxe/rxe_req.c   |  5 +---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 17 +++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 6 files changed, 13 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index efcb72c92be6..907203afbd99 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -40,14 +40,6 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
-/* free resources for all ports on a device */
-static void rxe_cleanup_ports(struct rxe_dev *rxe)
-{
-	kfree(rxe->port.pkey_tbl);
-	rxe->port.pkey_tbl = NULL;
-
-}
-
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
@@ -66,8 +58,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mc_grp_pool);
 	rxe_pool_cleanup(&rxe->mc_elem_pool);
 
-	rxe_cleanup_ports(rxe);
-
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
 }
@@ -139,25 +129,14 @@ static void rxe_init_port_param(struct rxe_port *port)
 /* initialize port state, note IB convention that HCA ports are always
  * numbered from 1
  */
-static int rxe_init_ports(struct rxe_dev *rxe)
+static void rxe_init_ports(struct rxe_dev *rxe)
 {
 	struct rxe_port *port = &rxe->port;
 
 	rxe_init_port_param(port);
-
-	port->pkey_tbl = kcalloc(port->attr.pkey_tbl_len,
-			sizeof(*port->pkey_tbl), GFP_KERNEL);
-
-	if (!port->pkey_tbl)
-		return -ENOMEM;
-
-	port->pkey_tbl[0] = 0xffff;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
 			    rxe->ndev->dev_addr);
-
 	spin_lock_init(&port->port_lock);
-
-	return 0;
 }
 
 /* init pools of managed objects */
@@ -247,13 +226,11 @@ static int rxe_init(struct rxe_dev *rxe)
 	/* init default device parameters */
 	rxe_init_device_param(rxe);
 
-	err = rxe_init_ports(rxe);
-	if (err)
-		goto err1;
+	rxe_init_ports(rxe);
 
 	err = rxe_init_pools(rxe);
 	if (err)
-		goto err2;
+		return err;
 
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
@@ -263,11 +240,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	mutex_init(&rxe->usdev_lock);
 
 	return 0;
-
-err2:
-	rxe_cleanup_ports(rxe);
-err1:
-	return err;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 99e9d8ba9767..2f381aeafcb5 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -100,7 +100,7 @@ enum rxe_device_param {
 	RXE_MAX_SRQ_SGE			= 27,
 	RXE_MIN_SRQ_SGE			= 1,
 	RXE_MAX_FMR_PAGE_LIST_LEN	= 512,
-	RXE_MAX_PKEYS			= 64,
+	RXE_MAX_PKEYS			= 1,
 	RXE_LOCAL_CA_ACK_DELAY		= 15,
 
 	RXE_MAX_UCONTEXT		= 512,
@@ -148,7 +148,7 @@ enum rxe_port_param {
 	RXE_PORT_INIT_TYPE_REPLY	= 0,
 	RXE_PORT_ACTIVE_WIDTH		= IB_WIDTH_1X,
 	RXE_PORT_ACTIVE_SPEED		= 1,
-	RXE_PORT_PKEY_TBL_LEN		= 64,
+	RXE_PORT_PKEY_TBL_LEN		= 1,
 	RXE_PORT_PHYS_STATE		= IB_PORT_PHYS_STATE_POLLING,
 	RXE_PORT_SUBNET_PREFIX		= 0xfe80000000000000ULL,
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 46e111c218fd..7e123d3c4d09 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -101,36 +101,15 @@ static void set_qkey_viol_cntr(struct rxe_port *port)
 static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		      u32 qpn, struct rxe_qp *qp)
 {
-	int i;
-	int found_pkey = 0;
 	struct rxe_port *port = &rxe->port;
 	u16 pkey = bth_pkey(pkt);
 
 	pkt->pkey_index = 0;
 
-	if (qpn == 1) {
-		for (i = 0; i < port->attr.pkey_tbl_len; i++) {
-			if (pkey_match(pkey, port->pkey_tbl[i])) {
-				pkt->pkey_index = i;
-				found_pkey = 1;
-				break;
-			}
-		}
-
-		if (!found_pkey) {
-			pr_warn_ratelimited("bad pkey = 0x%x\n", pkey);
-			set_bad_pkey_cntr(port);
-			goto err1;
-		}
-	} else {
-		if (unlikely(!pkey_match(pkey,
-					 port->pkey_tbl[qp->attr.pkey_index]
-					))) {
-			pr_warn_ratelimited("bad pkey = 0x%0x\n", pkey);
-			set_bad_pkey_cntr(port);
-			goto err1;
-		}
-		pkt->pkey_index = qp->attr.pkey_index;
+	if (!pkey_match(pkey, IB_DEFAULT_PKEY_FULL)) {
+		pr_warn_ratelimited("bad pkey = 0x%x\n", pkey);
+		set_bad_pkey_cntr(port);
+		goto err1;
 	}
 
 	if ((qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) &&
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e5031172c019..34df2b55e650 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -381,7 +381,6 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
 	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
-	struct rxe_port		*port = &rxe->port;
 	struct sk_buff		*skb;
 	struct rxe_send_wr	*ibwr = &wqe->wr;
 	struct rxe_av		*av;
@@ -419,9 +418,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
 			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
 
-	pkey = (qp_type(qp) == IB_QPT_GSI) ?
-		 port->pkey_tbl[ibwr->wr.ud.pkey_index] :
-		 port->pkey_tbl[qp->attr.pkey_index];
+	pkey = IB_DEFAULT_PKEY_FULL;
 
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 74f071003690..779458ddd422 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -83,22 +83,11 @@ static int rxe_query_port(struct ib_device *dev,
 static int rxe_query_pkey(struct ib_device *device,
 			  u8 port_num, u16 index, u16 *pkey)
 {
-	struct rxe_dev *rxe = to_rdev(device);
-	struct rxe_port *port;
-
-	port = &rxe->port;
-
-	if (unlikely(index >= port->attr.pkey_tbl_len)) {
-		dev_warn(device->dev.parent, "invalid index = %d\n",
-			 index);
-		goto err1;
-	}
+	if (index > 0)
+		return -EINVAL;
 
-	*pkey = port->pkey_tbl[index];
+	*pkey = IB_DEFAULT_PKEY_FULL;
 	return 0;
-
-err1:
-	return -EINVAL;
 }
 
 static int rxe_modify_device(struct ib_device *dev,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 92de39c4a7c1..c664c7f36ab5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -371,7 +371,6 @@ struct rxe_mc_elem {
 
 struct rxe_port {
 	struct ib_port_attr	attr;
-	u16			*pkey_tbl;
 	__be64			port_guid;
 	__be64			subnet_prefix;
 	spinlock_t		port_lock; /* guard port */
-- 
2.25.4

