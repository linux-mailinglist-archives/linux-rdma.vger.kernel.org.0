Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B14C526F63
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiENDI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 23:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiENDI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 23:08:28 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A1322799
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:08:23 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f16a3e0529so2448434fac.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqPXfeaRqfxlpT8MOv9ifZh9DcX4RBWAPF+Dv9bYlVY=;
        b=TxzfEV/F7k+EYfztg/YK9tp6MFWlQQzN9rfaRju++3/iuYx6ou2NhCwfS64aEEDCms
         DnDXECjuHTPapTOrZTbubqhst6wPGU7zSD1jRCHcfK8CP0f4bWbk6E5WLaeRxvRU4Kvq
         SDCzYqW2w53cviIdPDu0Agtpi743ckg1zwiHRvfvfC/VJMJpAgVGzOAToHRaUtcEmM1y
         cVQao4A3OXFrSQEii0XTe8xrI+xAAEQycD9DGz9F+J+KxkkuYshnsCxKGBclcgw0ECr4
         UrVqhTdjs2nWoxRxzDsNRmZH4YxPReDCCeB/ensv2vn0MBC0L7tY00j3gOI6lYKh8y4Y
         cn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqPXfeaRqfxlpT8MOv9ifZh9DcX4RBWAPF+Dv9bYlVY=;
        b=ZAUhxHA96ykkKQ1Rr9GBpIsSDS8KuQlvRXuFvGc6C8GZFLIhCuXhCnOSMep5dVDs1Y
         lwmQuWx5hl/TuJgzTDZsGiru4w15F3mGBVKe+BsmJ4hT+6p0J1kzPIa8EoSVSOsgnXJ0
         feSAbl5s6aEG6NSCuqm4fAac6X+Zu0XqpMl9aaXBVgAb7JDLZ3DPy94Oh7J8368kiZ5D
         KePTY/8EkBeldSThte/Pb9PUuW5vtbvKr1gKLVOEfSxXNfzetzuCn3hraZkPoc23AT0G
         6RFtmFWgQlDIRQ/wEdNzNu0OBfnWA8VC1mBWXgye9sd/rWNYT9KJQozCbBbVs17FO7e7
         xUxQ==
X-Gm-Message-State: AOAM530yaduiiLqgR3BqMQYftdH635rEb/ndWH+xIx0c/4928y5m16xd
        NpZdojE8IJk8QQgihf0SqeE=
X-Google-Smtp-Source: ABdhPJwrBGm3/YRwFWKt6u5IUl49YonWLRJS9BdjNT3gqPPTa/RWB0fLKMfcl2Od7w4/ztmcX8hC2g==
X-Received: by 2002:a05:6870:240a:b0:de:7fcb:56c0 with SMTP id n10-20020a056870240a00b000de7fcb56c0mr4178137oap.8.1652497702686;
        Fri, 13 May 2022 20:08:22 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-0642-4ec7-2b63-14d6.res6.spectrum.com. [2603:8081:140c:1a00:642:4ec7:2b63:14d6])
        by smtp.googlemail.com with ESMTPSA id h64-20020a9d2f46000000b0060603221262sm1691176otb.50.2022.05.13.20.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:08:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, tom@talpey.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v2 2/4] RDMA/rxe: Add a pkt->mask bit for ack_req
Date:   Fri, 13 May 2022 22:04:36 -0500
Message-Id: <20220514030435.91155-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220514030435.91155-1-rpearsonhpe@gmail.com>
References: <20220514030435.91155-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a bit to pkt->mask indicating that the ackreq bit has been
set in the current packet. Use this bit to condition setting
the retransmit timer since a packet without the ackreq bit set
will not generate a response.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.h |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..629504245e98 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -80,6 +80,7 @@ enum rxe_hdr_mask {
 	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 10),
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
+	RXE_ACK_REQ_MASK	= BIT(NUM_HDR_TYPES + 13),
 
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 1884e3a64310..d15165e9319c 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -394,11 +394,13 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	ack_req = ((pkt->mask & RXE_END_MASK) ||
 		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
-	if (ack_req)
+	if (ack_req) {
 		qp->req.noack_pkts = 0;
+		pkt->mask |= RXE_ACK_REQ_MASK;
+	}
 
-	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL, qp_num,
-		 ack_req, pkt->psn);
+	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL,
+		 qp_num, ack_req, pkt->psn);
 
 	/* init optional headers */
 	if (pkt->mask & RXE_RETH_MASK) {
@@ -539,7 +541,8 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	qp->need_req_skb = 0;
 
-	if (qp->timeout_jiffies && !timer_pending(&qp->retrans_timer))
+	if ((pkt->mask & RXE_ACK_REQ_MASK) && qp->timeout_jiffies &&
+	    !timer_pending(&qp->retrans_timer))
 		mod_timer(&qp->retrans_timer,
 			  jiffies + qp->timeout_jiffies);
 }
-- 
2.34.1

