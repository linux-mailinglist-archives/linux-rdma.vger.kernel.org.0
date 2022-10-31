Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40C613EF8
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJaU2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJaU2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:31 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A05DFBE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:30 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v81so5279712oie.5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ6dFnbpCBGzx2uSlsp27KdeIPoR+QwGNYkEiMDPy6A=;
        b=KlwQ3qruBnkXbzgKXqdyV3u+WSiePHk5wWhX/uStlIF0sE6N+yObUYfhpQZGTfJpiR
         IKQUKOiCbq5laBw+vy7H/DLmbUX1T+57R+s0LzWdjUBRl/IYS2/MfHtXmOuAs0K/tkkM
         rVBgIfP81PCB5PEcM8M51Dtdt2PIkgTNrp4N30Ri5OnnC09axd9NmAtigevegxbggtxv
         Kj0oScAT2nYICyhAWtcFyMmBKqj0V+bqWYIpM41FmLmW/vaFul1o5XUxpdr/i66ZoNsA
         y644pJU4gdS9dh0ct7Wfy9t9KACcKtjSo5pR0Wv4oA7OBpFq9iuK6HE3LQ3hAPmyNPDh
         stkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ6dFnbpCBGzx2uSlsp27KdeIPoR+QwGNYkEiMDPy6A=;
        b=wNCs7ANdgOdtUhA/c+J6+pMdaqCp6GzyhWFdXpW8fviesRrvWnkw4x3bvClupxRSnT
         MhmrmLBOMjVDugqz7IuDcmlnsu7ab+CURj8mhX2yUhobh4y+NGlAVOLoPxc4g5Mtz4An
         YQnHUnFB+pUpvIZTt4QySmXrVAWTQXcAuJ1BQnixIrVLCQ5ThkpGcghn8BpDSKuqrxMk
         F2mx55woJcUJB5S3zyjmi1EwFxQQXz/YOtVWrhZe/wpEmcUxBWTkN/8vbkSLvW2WZ9Oq
         PQrAbBquIgSQroxzdPsYTc2Hf6MWEPX3cBJ/5My/ICfVxYz/uWxfpm91WmIacMw4Pn3/
         6XZw==
X-Gm-Message-State: ACrzQf3YN0zfpzDYIowlETKflbOBKRGj8bCI4thTm8X+uLcybJEVSuI6
        JNcZCSt5/TG+ZuwcpuI9Ag8=
X-Google-Smtp-Source: AMsMyM4TR9M1T6CbODHeB8xbHJH6/DveaBJ+ImecvKNOA0DrXxx1547ZiPhNfXvkzM4GLHPihvNKdQ==
X-Received: by 2002:a05:6808:1408:b0:355:77b:b78c with SMTP id w8-20020a056808140800b00355077bb78cmr7354763oiv.169.1667248110345;
        Mon, 31 Oct 2022 13:28:30 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 03/18] RDMA/rxe: Remove paylen parameter from rxe_init_packet
Date:   Mon, 31 Oct 2022 15:27:52 -0500
Message-Id: <20221031202805.19138-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleanup rxe_init_paylen by removing paylen as a parameter since it
is already available in pkt.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 6 +++---
 drivers/infiniband/sw/rxe/rxe_req.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..574a6afc1199 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -92,7 +92,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt);
+				struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 35f327b9d4b8..1e4456f5cda2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -443,7 +443,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 }
 
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt)
+				struct rxe_pkt_info *pkt)
 {
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
@@ -468,7 +468,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		rcu_read_unlock();
 		goto out;
 	}
-	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
+	skb = alloc_skb(pkt->paylen + hdr_len + LL_RESERVED_SPACE(ndev),
 			GFP_ATOMIC);
 
 	if (unlikely(!skb)) {
@@ -489,7 +489,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	pkt->rxe	= rxe;
 	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put(skb, paylen);
+	pkt->hdr	= skb_put(skb, pkt->paylen);
 	pkt->mask	|= RXE_GRH_MASK;
 
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 10a75f4e3608..e9e865a5674f 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -472,7 +472,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	pkt->paylen = paylen;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, paylen, pkt);
+	skb = rxe_init_packet(rxe, av, pkt);
 	if (unlikely(!skb))
 		return NULL;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 95d372db934d..c7f60c7b361c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -670,15 +670,15 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	 */
 	pad = (-payload) & 0x3;
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
+	ack->paylen = paylen;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
 	if (!skb)
 		return NULL;
 
 	ack->qp = qp;
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
-	ack->paylen = paylen;
 	ack->psn = psn;
 
 	bth_init(ack, opcode, 0, 0, pad, IB_DEFAULT_PKEY_FULL,
-- 
2.34.1

