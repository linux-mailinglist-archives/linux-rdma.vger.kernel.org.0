Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6DB736DFA
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjFTN4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFTN4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 09:56:04 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FE7D7
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:56:02 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55e34b2bb03so2081468eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687269362; x=1689861362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Im+3MK0C7jPJtSSraG4P3xy8ObrSvzftiKSqCw5rH8=;
        b=G3im3x5t8zZ0wiOB4fCu+ygeMy463KhofnusA8de74Z7aub96iHBKDRNwdqSmmHPA/
         /wz5ifVu37Anmc+7e3wcgn82nM9uAwu04fFaWVeOWLf8DES5Q1qzZRccFfwG51eM2qNN
         erx90fq+b/SQ8lDfEOllnKUiuu4wUx22kncllgpuC7RHI/FsO7/zwWtEk9AuUODshHPA
         cKfdrOfiCAeFNHoCLtpmwWHODII63h4NL/JTBsLSk0Qa+9VZpAPQ2WXAly+9DMHg3hEE
         85pNSJClwkYna+2nBhZGenNcFc6XxDuk6/Em5C7JLAS12ODAxFIfSmdh44YoWzhUDA+w
         /7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687269362; x=1689861362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Im+3MK0C7jPJtSSraG4P3xy8ObrSvzftiKSqCw5rH8=;
        b=jWYBimSelLDfC41XiD/hnRHOmR4ffdOdjzBdH6IW5DqNEryScwkPkQqYF8AVfD40KB
         +GOeqBjG5xpJ6AhCaJCmPvdu5jSTuAhwth+h5d884rWfIeg+0roW3VYOTTvYI06TyiEc
         8JYqN+5pL3pcr+zOpwVVb1tlufkQ52qnMWTQz4xCnytWXvN0u8enZFdP+ZiPJSlkal/G
         Q3BBuVqulZtxarcj3hMuZzyZrj/FwEgGRuXzt4H56l5YL2ubhW/mCzd+5PH8SmTrT1uV
         bxwj4XSzBYFX1etPYdekgA5ijJrpxI2ca9s/CV0IiKucA5pf3vxm8u6C3dfRPN9nKC9o
         fkQQ==
X-Gm-Message-State: AC+VfDylNZKxF2A5q+nzcIruy69SbDLkcszsYBY9O3f5x7XAqAJKTRyC
        BSK1gpwB527R1jAlP5XA7qG46arUdDI=
X-Google-Smtp-Source: ACHHUZ6PZ8hRKpwD/B4nE7pQxc4fzr37vBZA5Yo3HRpFS1niphgkLthNB/1hscPfG83MLh9/3G/I7Q==
X-Received: by 2002:a4a:e2da:0:b0:55e:45ce:f272 with SMTP id l26-20020a4ae2da000000b0055e45cef272mr5976160oot.7.1687269361854;
        Tue, 20 Jun 2023 06:56:01 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ba53-355d-2a89-4598.res6.spectrum.com. [2603:8081:140c:1a00:ba53:355d:2a89:4598])
        by smtp.gmail.com with ESMTPSA id bm9-20020a0568081a8900b003a03481094csm1091010oib.19.2023.06.20.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:56:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Subject: [PATCH for-next v2 2/3] RDMA/rxe: Fix unsafe drain work queue code
Date:   Tue, 20 Jun 2023 08:55:21 -0500
Message-Id: <20230620135519.9365-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620135519.9365-1-rpearsonhpe@gmail.com>
References: <20230620135519.9365-1-rpearsonhpe@gmail.com>
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

If create_qp does not fully succeed it is possible for qp cleanup
code to attempt to drain the send or recv work queues before the
queues have been created causing a seg fault. This patch checks
to see if the queues exist before attempting to drain them.

Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@google.com/raw
Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 ++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 0c0ae214c3a9..c2a53418a9ce 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -594,6 +594,10 @@ static void flush_send_queue(struct rxe_qp *qp, bool notify)
 	struct rxe_queue *q = qp->sq.queue;
 	int err;
 
+	/* send queue never got created. nothing to do. */
+	if (!qp->sq.queue)
+		return;
+
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
 			err = flush_send_wqe(qp, wqe);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8a3c9c2c5a2d..9b4f95820b40 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1467,6 +1467,10 @@ static void flush_recv_queue(struct rxe_qp *qp, bool notify)
 		return;
 	}
 
+	/* recv queue not created. nothing to do. */
+	if (!qp->rq.queue)
+		return;
+
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
 			err = flush_recv_wqe(qp, wqe);
-- 
2.39.2

