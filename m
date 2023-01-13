Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4506689A1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 03:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjAMCfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 21:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjAMCfe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 21:35:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19A5D6AB;
        Thu, 12 Jan 2023 18:35:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q23-20020a17090a065700b002290913a521so3341029pje.5;
        Thu, 12 Jan 2023 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EUo+96zHD9QWNZE2rvaHJa5qXtxwOrFxMaVUnp2Nek=;
        b=TRZMzaXWlCfPXkjDYmGwMd6AgHwgMq8IJBUH2ssGfcRYwzG00936H7ndPT3MJ0ZP16
         S+vg0sEbL/ugGnqkdWahJmwIxLLkyn15cF3OX1B3BAzunZv41ZpUr2hixQdVZ/UIzAZy
         vwp9T/uQno6S0QoUkjDJQsi14crssOvH9mK+hnTu8QHzjjCuYqdihyCS/vHnfjtIpc9y
         G206HLoenA7BZpJfOE/Ike+R1vQIzdSG28HCGz67k+NtI3htGcU9n8roslpy01MnNeBo
         BozwL74Y4uu5nqcxR+8ZNtT+C3vaQwG5YaZFZW2QP37nHovc+NytBqHgUv0ipLSpCekP
         JUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EUo+96zHD9QWNZE2rvaHJa5qXtxwOrFxMaVUnp2Nek=;
        b=gyViv9cnOXbpaHRBwHWv4msAxiYJvNHL8EZk8DGbQvVaVmlkiszFvls/eGRVcYSSQ4
         qDWitCeE+74VJKmr/XZGqkHFM1X0dvo3nOcIznu69vkI8KxVfhx4L8JuW6EjsZsPFQLH
         50Hx9HAPw9uiCiSxVBFtzwXU+nnGw9EsCRzbZmY6sJGb+0kpaBSWH7P1JTPdEd2u9Atv
         cl7+joxixIfNBe6oO3qQa/+63ml/TFYwPxALA/vLmiTX8okjNYnoQ17kpf7ZmpCmX0M5
         v1yIBBCa0NBsvgUvTw6eqeSmLnbIAY/X1ZANJYqLcVmhsrlIhw36cHslRv/tIRRYqX/9
         DjQA==
X-Gm-Message-State: AFqh2kruJGaJDKnT1dQlIendYN+AEgdgBftYcCCf2xp2kDQAM64yZ+aD
        uP+ByI79egcuICfTyoltwTMMY4IbRDCoJSCm
X-Google-Smtp-Source: AMrXdXsIiM6oBXTzkubFP3SK5MYCdekJ74NCI+jdkv58gZ8LizIXwt3oZCfEcGzIVvnrCrAWA3JO0g==
X-Received: by 2002:a17:902:ab96:b0:192:8d52:45e6 with SMTP id f22-20020a170902ab9600b001928d5245e6mr8856985plr.11.1673577331943;
        Thu, 12 Jan 2023 18:35:31 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.142])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b00192b93a6ce4sm12949527plf.86.2023.01.12.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 18:35:31 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] infiniband: sw: rxe: Add NULL checks for qp->resp.mr
Date:   Fri, 13 Jan 2023 10:35:27 +0800
Message-Id: <20230113023527.728725-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In a previous commit 3282a549cf9b, qp->resp.mr could be NULL. Moreover,
in many functions, qp->resp.mr is checked before its dereferences.
However, in some functions, this variable is not checked, and thus NULL 
checks should be added.

These results are reported by a static tool written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 47 ++++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c74972244f08..2eafa1667a9e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -621,11 +621,13 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
-	if (err) {
-		rc = RESPST_ERR_RKEY_VIOLATION;
-		goto out;
+	if (qp->resp.mr) {
+		err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+				  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
+		if (err) {
+			rc = RESPST_ERR_RKEY_VIOLATION;
+			goto out;
+		}
 	}
 
 	qp->resp.va += data_len;
@@ -699,11 +701,13 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 		start = res->flush.va;
 		length = res->flush.length;
 	} else { /* level == IB_FLUSH_MR */
-		start = mr->ibmr.iova;
-		length = mr->ibmr.length;
+		if (mr) {
+			start = mr->ibmr.iova;
+			length = mr->ibmr.length;
+		}
 	}
 
-	if (res->flush.type & IB_FLUSH_PERSISTENT) {
+	if (mr && res->flush.type & IB_FLUSH_PERSISTENT) {
 		if (rxe_flush_pmem_iova(mr, start, length))
 			return RESPST_ERR_RKEY_VIOLATION;
 		/* Make data persistent. */
@@ -742,7 +746,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		qp->resp.res = res;
 	}
 
-	if (!res->replay) {
+	if (!res->replay && mr) {
 		if (mr->state != RXE_MR_STATE_VALID) {
 			ret = RESPST_ERR_RKEY_VIOLATION;
 			goto out;
@@ -793,15 +797,17 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
 	int payload = payload_size(pkt);
 	u64 src, *dst;
 
-	if (mr->state != RXE_MR_STATE_VALID)
+	if (mr && mr->state != RXE_MR_STATE_VALID)
 		return RESPST_ERR_RKEY_VIOLATION;
 
 	memcpy(&src, payload_addr(pkt), payload);
 
-	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
-	/* check vaddr is 8 bytes aligned. */
-	if (!dst || (uintptr_t)dst & 7)
-		return RESPST_ERR_MISALIGNED_ATOMIC;
+	if (mr) {
+		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
+		/* check vaddr is 8 bytes aligned. */
+		if (!dst || (uintptr_t)dst & 7)
+			return RESPST_ERR_MISALIGNED_ATOMIC;
+	}
 
 	/* Do atomic write after all prior operations have completed */
 	smp_store_release(dst, src);
@@ -1002,13 +1008,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 	}
 
-	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_FROM_MR_OBJ);
-	if (mr)
+	if (mr) {
+		err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+				  payload, RXE_FROM_MR_OBJ);
 		rxe_put(mr);
-	if (err) {
-		kfree_skb(skb);
-		return RESPST_ERR_RKEY_VIOLATION;
+		if (err) {
+			kfree_skb(skb);
+			return RESPST_ERR_RKEY_VIOLATION;
+		}
 	}
 
 	if (bth_pad(&ack_pkt)) {
-- 
2.34.1

