Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF95F6C7D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJFRFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJFRFQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 13:05:16 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C7844C9
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 10:05:15 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so1843302oop.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Oct 2022 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z45VfjuZ/sh/T8R5wU37N6e0izY6PnUo0QVO/d5HDI=;
        b=pbxwMkO3hthEaJ0cRF09gC5RYVxTKIvVCWwIOT2b6bIJ0NNEVYxsSjqr1KJRw8eWQS
         2Hot2v5kBr4hPqs4YRK/cEpT1Xnxga4S8JKOYhqBVy33/NyhqWDj3h7e+S+nSZ1euCMi
         APzaS4vtH9X9zkTVEAJdwl8nfgcJSwKC1iNL4H5XraWuifJmV6iIgMBQo9rR6dp/I/Kr
         rgbH8QRAqPFgNj/HsKxySx/YL2WUV2TVEgk1JzzBrsqcOPzRWE3YmNxhMi22zpZO5kMZ
         dlwEI0MoCVOMU0DJ29OWyQJT+be2pNlTbwBPlwRcVxhtX6p1x8fwBVwBpboCTQoqiRo8
         WVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Z45VfjuZ/sh/T8R5wU37N6e0izY6PnUo0QVO/d5HDI=;
        b=UPgTTqLJ1fuUzsROLq3giIs1FNdNB3c1nklevE59hLqY8Doa5nfmWP5AZFopK6Kd6k
         ngulyxihVnUuHsEovDCcgn3C2r3MTa1VA/sUMKLw7TEI+jfdj8pdIB6VHkcd12OLDbIl
         T6u/93pA9SmoWk1GWqf9mhTo8Xz/xJbBoz5p5nbwYlFSz+zQUplyXXeL+W9nUFH+kbNk
         Q80wyx3gor6b+24Cd01qQ58ihwHQGDQoP4silyfThfecmVFSfeahEJWotQ2Yu5pp6rbY
         LAIngTEKErWarEFFGP4U/xo5WSw7KRv4ra9YA87BRM63DLaiGFI7D2C73y6QBqN+HagP
         P/JA==
X-Gm-Message-State: ACrzQf3MPCaIYLzTXo0Lt64EhX5icDQgGMrcTr1WLMXTDdXHldIvGVgD
        2PNJc16pEQ7dAdt0SSCybkE=
X-Google-Smtp-Source: AMsMyM78V9FCQ0V5RnlsCwW7AATH2d3uF7hHFxFa9NjBEGpNmVzqqicoVC3tLKbgIljAHaOKlR4BuA==
X-Received: by 2002:a9d:5f05:0:b0:638:9ae3:59e with SMTP id f5-20020a9d5f05000000b006389ae3059emr349172oti.271.1665075914768;
        Thu, 06 Oct 2022 10:05:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-4f1a-4f5a-81c0-34f5.res6.spectrum.com. [2603:8081:140c:1a00:4f1a:4f5a:81c0:34f5])
        by smtp.googlemail.com with ESMTPSA id f26-20020a9d6c1a000000b006370c0e5be0sm28609otq.48.2022.10.06.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:05:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Convert spin_lock_irqsave to spin_lock
Date:   Thu,  6 Oct 2022 12:04:55 -0500
Message-Id: <20221006170454.89903-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently the rxe driver uses a spin_lock_irqsave call to protect
the producer end of a completion queue from multiple QPs which may
be sharing the cq. Since all accesses to the cq are from tasklets
this is overkill and a simple spin_lock will be sufficient.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 76534bc66cb6..408ffe2e6f14 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -104,13 +104,12 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	struct ib_event ev;
 	int full;
 	void *addr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cq->cq_lock, flags);
+	spin_lock(&cq->cq_lock);
 
 	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	if (unlikely(full)) {
-		spin_unlock_irqrestore(&cq->cq_lock, flags);
+		spin_unlock(&cq->cq_lock);
 		if (cq->ibcq.event_handler) {
 			ev.device = cq->ibcq.device;
 			ev.element.cq = &cq->ibcq;
@@ -126,7 +125,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
+	spin_unlock(&cq->cq_lock);
 
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {

base-commit: cbdae01d8b517b81ed271981395fee8ebd08ba7d
-- 
2.34.1

