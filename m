Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724D2735E6C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjFSUWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSUWP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 16:22:15 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854719C
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:22:14 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1a9ae7cc01dso2475886fac.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206134; x=1689798134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Im+3MK0C7jPJtSSraG4P3xy8ObrSvzftiKSqCw5rH8=;
        b=EdhTrlTPEx/E3f1OIQ+uHcUpZy8axmcn5zuiVuLP9GRShsjGtvvGB/Inztv14wzgvV
         DNlwE/fLgZ93FzHuiVg4q9PsLpX39KzQvdoo5s/yrqCXaVHYskTSH2YuwINcvmSg61rC
         tuYZ0ga0EhqNVbEPKWqA27RYEmP/Ad866gTsZNRFSc/8AEi+ojpPi2JfarABt4vg9vss
         Ho7zuf4Rdpnb8V68+zfwQTQzEh41Og0Ulug/oDjShO2mbT8LUkSgag0EeulBks4kEUyT
         hzhJJZip/vACch1re76S8rYC5iKk+yPFO5hIBPo1igY4sAM73u99ZTbN1e9GcMhkYJWt
         GCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206134; x=1689798134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Im+3MK0C7jPJtSSraG4P3xy8ObrSvzftiKSqCw5rH8=;
        b=OocAZZ3sY/5/fymNAfOBKtTvZhzSeBgmejPFnfQ03hH87hU1qtqeFwIJzaYXbBByBF
         epRNT/WPNw2NkgpKOw9I5Pd7SL4NqNHMhb5R1/PNJ1NCtGJXJDr2+tA04pW1nFXABrxp
         zZht4oONpe4xzxRm1jzf1seIN7IsI1JM6X9NbdudeCk4pTRde8vp2OMEGRCSpMKnOkE3
         Ly5T/Fjf/MxdHINS11TTLlIocXySmLzEpHe49kYKmQWVi+xKGiixzuDTxI3XsDWXVNwT
         1sqwNNVs7Wx4bY7bDVdO3ENi6ldnI0TZFhJuXjAN4PGWvRjjuuWjtxGkTwaDDtoMr93W
         odkA==
X-Gm-Message-State: AC+VfDxjfq2VQpZsHKghEmeykfdkJRKhK9TMQTq3OblunuVPUmCEd5Lz
        xWBDU932a38rUx5ee6VtX3xhxhNNhPU=
X-Google-Smtp-Source: ACHHUZ6BSrHDg3nfnCuwjfxtwGnyp8/MQCAuUVYsNuFlZuj+vhfpchEtWNVV3AnpCkcxP7U5+87KKA==
X-Received: by 2002:a05:6871:6aa2:b0:1a9:a004:fda8 with SMTP id zf34-20020a0568716aa200b001a9a004fda8mr5201385oab.5.1687206133771;
        Mon, 19 Jun 2023 13:22:13 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-773b-851f-3075-b82a.res6.spectrum.com. [2603:8081:140c:1a00:773b:851f:3075:b82a])
        by smtp.gmail.com with ESMTPSA id kw41-20020a056870ac2900b001a6a3f99691sm311368oab.27.2023.06.19.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:22:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Subject: [PATCH for-next 2/3] RDMA/rxe: Fix unsafe drain work queue code
Date:   Mon, 19 Jun 2023 15:21:12 -0500
Message-Id: <20230619202110.45680-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619202110.45680-1-rpearsonhpe@gmail.com>
References: <20230619202110.45680-1-rpearsonhpe@gmail.com>
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

