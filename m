Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9371707E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjE3WNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjE3WNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:53 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE07BE5
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:52 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-557ca32515eso2478251eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484832; x=1688076832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM7bB/GOM7i6f1ZOjOjhI1OP8ejWKH7xFDVU2suPgaU=;
        b=I3A9ZTjrHeEesmIhz3NSLZL3tEW7fAbcMvO7wXMZyE4mgfcH3wrPixT0cAOnBQxFNQ
         LVRRusL42VP0hl4ltWBL3CTr1U0zI4HbPdwyVKB+SsMwkU9BnW6jgOaopHp6K1/QSub9
         ywqjcepp/AxE0HHhSjJdpRKDEt97offaD4hJ6MHHp6aNAQ8QG8zwRP0exUJbh3JWUvfY
         GyiKcxudYfxwqcSGN6TMFVM9InBjUq1mzyEdQRMnfNSon/lcVqueSg3bm47im/urbbie
         2tuan8dMP1VmNyoIw4UysWype/o4qFeDlxVGu1qJ4qKPMXrcWeuHy/a9vHty4BsgFNwC
         ID8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484832; x=1688076832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM7bB/GOM7i6f1ZOjOjhI1OP8ejWKH7xFDVU2suPgaU=;
        b=lzjEYpDzuZRQQaYl75bddJJoKbLvRLUY24+PTcHXUfUXmLpOeP+WWzZlaZdwRBaO7H
         kSkwnboKa+Imk/uYpj1hABnks6LxcfktKUGZ6lXOFmHVrO6DZGFyEEG402z58qBeaEqm
         DkXjf+hH6Q4jVNQhhh9cANm/8HF5zazEM8XwknOesWG+nDvFgj4UlLXJmW32slrBf8I0
         BMMc51yzg8d2z01tXgEr7azNYrS3FFBF1ays+fjAKH5C0/UMlv1515KT9kFNNhjVH+/m
         XKu5BfZjtBF3+acqXDXNqb/7xdwAjL5h+YWADKkV+IeAFgYiBRTZU5S/R3K94ndnnlkk
         C1uA==
X-Gm-Message-State: AC+VfDz1YKphH3/ADAd/JR/sHejMYz10J+rRZQrc//bzt3dOAuZ9FAh5
        8B88dGispCGEUDiKev7NT3ary75lI38=
X-Google-Smtp-Source: ACHHUZ6+7AFWZQ5I7nHqry+WDLi5B0Y4MS/FfklFelpD91kxtx4Vfpok2R8lXiB6Txbj3I6lcwQjPQ==
X-Received: by 2002:a4a:8c05:0:b0:555:50bb:2e2c with SMTP id u5-20020a4a8c05000000b0055550bb2e2cmr1352166ooj.4.1685484831864;
        Tue, 30 May 2023 15:13:51 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/6] RDMA/rxe: Fix access checks in rxe_check_bind_mw
Date:   Tue, 30 May 2023 17:13:32 -0500
Message-Id: <20230530221334.89432-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530221334.89432-1-rpearsonhpe@gmail.com>
References: <20230530221334.89432-1-rpearsonhpe@gmail.com>
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

The subroutine rxe_check_bind_mw() in rxe_mw.c performs checks
on the mw access flags before they are set so they always succeed.
This patch instead checks the access flags passed in the send wqe.

Fixes: 32a577b4c3a9 ("RDMA/rxe: Add support for bind MW work requests")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index afa5ce1a7116..a7ec57ab8fad 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -48,7 +48,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 }
 
 static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-			 struct rxe_mw *mw, struct rxe_mr *mr)
+			 struct rxe_mw *mw, struct rxe_mr *mr, int access)
 {
 	if (mw->ibmw.type == IB_MW_TYPE_1) {
 		if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
@@ -58,7 +58,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 
 		/* o10-36.2.2 */
-		if (unlikely((mw->access & IB_ZERO_BASED))) {
+		if (unlikely((access & IB_ZERO_BASED))) {
 			rxe_dbg_mw(mw, "attempt to bind a zero based type 1 MW\n");
 			return -EINVAL;
 		}
@@ -104,7 +104,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 
 	/* C10-74 */
-	if (unlikely((mw->access &
+	if (unlikely((access &
 		      (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
 		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
 		rxe_dbg_mw(mw,
@@ -113,7 +113,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 
 	/* C10-75 */
-	if (mw->access & IB_ZERO_BASED) {
+	if (access & IB_ZERO_BASED) {
 		if (unlikely(wqe->wr.wr.mw.length > mr->ibmr.length)) {
 			rxe_dbg_mw(mw,
 				"attempt to bind a ZB MW outside of the MR\n");
@@ -133,12 +133,12 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 }
 
 static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-		      struct rxe_mw *mw, struct rxe_mr *mr)
+		      struct rxe_mw *mw, struct rxe_mr *mr, int access)
 {
 	u32 key = wqe->wr.wr.mw.rkey & 0xff;
 
 	mw->rkey = (mw->rkey & ~0xff) | key;
-	mw->access = wqe->wr.wr.mw.access;
+	mw->access = access;
 	mw->state = RXE_MW_STATE_VALID;
 	mw->addr = wqe->wr.wr.mw.addr;
 	mw->length = wqe->wr.wr.mw.length;
@@ -169,6 +169,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 mw_rkey = wqe->wr.wr.mw.mw_rkey;
 	u32 mr_lkey = wqe->wr.wr.mw.mr_lkey;
+	int access = wqe->wr.wr.mw.access;
 
 	mw = rxe_pool_get_index(&rxe->mw_pool, mw_rkey >> 8);
 	if (unlikely(!mw)) {
@@ -198,11 +199,11 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	spin_lock_bh(&mw->lock);
 
-	ret = rxe_check_bind_mw(qp, wqe, mw, mr);
+	ret = rxe_check_bind_mw(qp, wqe, mw, mr, access);
 	if (ret)
 		goto err_unlock;
 
-	rxe_do_bind_mw(qp, wqe, mw, mr);
+	rxe_do_bind_mw(qp, wqe, mw, mr, access);
 err_unlock:
 	spin_unlock_bh(&mw->lock);
 err_drop_mr:
-- 
2.39.2

