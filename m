Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC865B7D0B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Sep 2022 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIMW1q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIMW1p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 18:27:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA81D59273
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:27:44 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12b542cb1d3so26349585fac.13
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PDPAKoP1R68fU5RGlPXkyXEqnKkcTgJ84pnAPXc9IIw=;
        b=nGNG1UQwStLBzjVYch85CMGFjQG2ESjyCCCSHzMUQzte9a9Fr10hE785XDZWL6egQE
         um+slb1GG0oMeTjikYn8uKVAcaMNizX6rAgYN5nMxDN0L8K12YZLUDYNO4HPiCKSMhH5
         XE479DBXJvncLtuf3VqINeBblyNrLVykFz6/v39AAW/rOpNGeUggJwegM7FwgHi8VVO4
         lx6M7nkmkCrCogquBv4rg002GrDsNT6tlss0yBb/h0k7WaCpR+nC17nXe/F4OPjqo18F
         JpbMarSyGgjuLPZm1nk+xMoN7QIA7CLzjlmvQ4BLULsHnmGXHS7EA4leJjjjnhLCKfYT
         03hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PDPAKoP1R68fU5RGlPXkyXEqnKkcTgJ84pnAPXc9IIw=;
        b=MbxXUH4hdhBD2fj7+7tgJHT1DSHsEfi0uH+kpv8JMqfQrLKkSSOL+0lvRNyIDgRd+e
         HULwyw/wxgI+ob7mVbcrgdMXiFHi8n327V98IeQ3VxjAJk/9lSmRniFM/WlzxlxOI44p
         piSHbAVNT5/TCvyWpBBCM6T4VBmTJ6d1gbNqJvs0UAKl9YpBn7i3Sj8QLsyiFGD4CKst
         73W9Iekyjgy14hQZE/EFDY6fGfPb3zshKAQZn5LsjXwz7IARGwpklgy13XgWOjvnTPKq
         kj3scI5nECoGUr2LzwVJxxrNEJqMll3MtMca6YGuMgpgSss6Xnwd++sKlu4lm7qJNlZl
         BSkw==
X-Gm-Message-State: ACgBeo18QakjSnWrFLsr9eWjLaYx6CE+QkZ2uiwNV8Gx0588O6InKFCU
        kESIyjJ8kgGCfEj7CtZ2UJ0m9bNDQX0=
X-Google-Smtp-Source: AA6agR4+LTqoNcS69tJDdNgOUHyX4l44wqGxdWkU0YWSe3UP0FCZkl/Tpwg+6knYIUCIGRdMOhAmcQ==
X-Received: by 2002:a05:6870:430b:b0:101:3d98:ba41 with SMTP id w11-20020a056870430b00b001013d98ba41mr809807oah.46.1663108064104;
        Tue, 13 Sep 2022 15:27:44 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-d098-9475-e37c-b40b.res6.spectrum.com. [2603:8081:140c:1a00:d098:9475:e37c:b40b])
        by smtp.googlemail.com with ESMTPSA id d23-20020a9d4f17000000b00655f24330easm1447308otl.77.2022.09.13.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:27:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove redundant num_sge fields
Date:   Tue, 13 Sep 2022 17:27:17 -0500
Message-Id: <20220913222716.18335-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In include/uapi/rdma/rdma_user_rxe.h there are redundant copies of
num_sge in the rxe_send_wr, rxe_recv_wqe, and rxe_dma_info. Only the
ones in rxe_dma_info are actually used by the rxe driver. This patch
replaces the ones in rxe_send_wr and rxe_recv_wqe by reserved. This
patch matches a user space change to the rxe provider driver in
rdma-core. This change has no affect on the current ABI and new or old
versions of rdma-core operate correctly with new or old versions of
the kernel rxe driver.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 --
 include/uapi/rdma/rdma_user_rxe.h     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9ebe9decad34..7073a0a0adf4 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -262,7 +262,6 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 
 	recv_wqe = queue_producer_addr(rq->queue, QUEUE_TYPE_TO_DRIVER);
 	recv_wqe->wr_id = ibwr->wr_id;
-	recv_wqe->num_sge = num_sge;
 
 	memcpy(recv_wqe->dma.sge, ibwr->sg_list,
 	       num_sge * sizeof(struct ib_sge));
@@ -526,7 +525,6 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			 const struct ib_send_wr *ibwr)
 {
 	wr->wr_id = ibwr->wr_id;
-	wr->num_sge = ibwr->num_sge;
 	wr->opcode = ibwr->opcode;
 	wr->send_flags = ibwr->send_flags;
 
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index f09c5c9e3dd5..73f679dfd2df 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -74,7 +74,7 @@ struct rxe_av {
 
 struct rxe_send_wr {
 	__aligned_u64		wr_id;
-	__u32			num_sge;
+	__u32			reserved;
 	__u32			opcode;
 	__u32			send_flags;
 	union {
@@ -166,7 +166,7 @@ struct rxe_send_wqe {
 
 struct rxe_recv_wqe {
 	__aligned_u64		wr_id;
-	__u32			num_sge;
+	__u32			reserved;
 	__u32			padding;
 	struct rxe_dma_info	dma;
 };

base-commit: db77d84cfe3608eac938302f8f7178e44415bcba
-- 
2.34.1

