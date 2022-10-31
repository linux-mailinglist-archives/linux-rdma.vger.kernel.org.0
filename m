Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB645613EFF
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJaU2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJaU2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF2913E33
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:43 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13bd19c3b68so14704471fac.7
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l30vVl9aiXBUKymiww2nBcsuZjeanYsTn+Oz+jhyI10=;
        b=Yk+X8y0VVzubVeVA9oJ6PTwxrcC0qFYF/4w8PMEOtABgeSOS3zmoWJIAjx9df1w/YU
         pxxmmHG77EQ8Myko0J5evdz/4SXIp3hEohF9/GVoup+0NFtgyUsLcJ61HPsf65UACxhl
         HtKZHfJno4aicG2AX+OYynV+vHq0XzrQEy55KBhjS5z5oJobJSv/9VzQivMu8TPNNKZa
         g0gKLqolYu3Hvi1b0sr+vf+N8wPE00m494RjTL1OoQyNq/tGGAncu0reEvGwXLHju+CD
         OcfDuV8U81yQPWG/bhIiWmqabQPWfcpi7cM+3AkES5JSQykFlWOEnAjHBQj1VWsKwCLy
         YBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l30vVl9aiXBUKymiww2nBcsuZjeanYsTn+Oz+jhyI10=;
        b=tzBJTGRvU1gL/D7BzcHtvQPxtJils+JZLPmim7sOv1DW9m4jum5QT2V2E8sVQ2p3wY
         FK4HGqY3nZld+fOM/NjG5fXK1SYRCYNSGFKFIeR3r98S2Kf/H3s9akahT510IN7BC6fq
         NXyH5z7Dz+tC9IQZGYaysTKRuphehwyi9bHmMdYJLejN+/IqYpukFxi3qawLZej0B0u+
         HsKmEmRaRkDE4LhfoREvYUl0Nuz7hZblbmGCMKEZJfaZdwX6OcdHb5DgmDeeK3sOJzUP
         XqNtN7+gzGRT8rVS8Q+cWQxOPQkw2nEPAWMka4w31oQB7jfq1/EHuMZLNxIg0LSlbTyy
         9OVw==
X-Gm-Message-State: ACrzQf377uWPAAPv2mA0/qTMAaspLxO0lJhVb8tzgnvalG9bk5NdgscL
        J82RyNGIKmVJ1AXZ8tXbEvrS0WVlOMU=
X-Google-Smtp-Source: AMsMyM46/SW+lfIPUPRrrHV7zDT7rayXlA/t3B2XuW75Yng+t75HtauCH8FDkFHbKZPn60ZYEy0xBQ==
X-Received: by 2002:a05:6870:a7a1:b0:137:2e20:97e0 with SMTP id x33-20020a056870a7a100b001372e2097e0mr18029896oao.133.1667248122825;
        Mon, 31 Oct 2022 13:28:42 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 11/18] RDMA/rxe: Replace rxe by qp as a parameter
Date:   Mon, 31 Oct 2022 15:28:00 -0500
Message-Id: <20221031202805.19138-11-rpearsonhpe@gmail.com>
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

Replace rxe as a parameter by qp in rxe_init_packet().
This will allow some simplification.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 3 ++-
 drivers/infiniband/sw/rxe/rxe_req.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index dbead759123d..4e5fbc33277d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -100,7 +100,7 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
-struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
+struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 				struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 1e4456f5cda2..faabc444d546 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -442,9 +442,10 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
+struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 				struct rxe_pkt_info *pkt)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
 	struct net_device *ndev;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ea0132797613..0a4b8825bd55 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -491,7 +491,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 						pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, pkt);
+	skb = rxe_init_packet(qp, av, pkt);
 	if (unlikely(!skb))
 		goto err_out;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 589306de7647..8503d22f9114 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -665,7 +665,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  u32 psn,
 					  u8 syndrome)
 {
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff *skb;
 	int paylen;
 	int pad;
@@ -680,7 +679,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->mask = rxe_opcode[opcode].mask;
 	ack->psn = psn;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
+	skb = rxe_init_packet(qp, &qp->pri_av, ack);
 	if (!skb)
 		return NULL;
 
-- 
2.34.1

