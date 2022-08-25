Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462885A1C0B
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 00:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiHYWPL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 18:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiHYWPK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 18:15:10 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42323DF24
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 15:15:08 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso25560621fac.6
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ELMdtnU96nSGslv5n69wK7Yi1A/faHCFHHb1qBkgYEk=;
        b=ghzXAiKl3q2Fep8bUsPxM7CcW0prEqU7pU48NNGwt2YLIv6BwrlYK7z6ZvBYgY3Ebd
         zQgIvWQ1StEBqUXJtchqvEHtlrouNpS80FPYe/MdO9Klvp4UncLq2XkAy1v+cTpRubxr
         7LlTr8rTLiQKWJjva9ZzxlxNUJGJaH8C+wa5pu5aSWZj1+sUKxhNwldF+LwXNECaYxBW
         aIGgQXA5iR4cg4riFBGkbig2jxFkcoRacQ7lgZHpgHUkiz2H9hOJSB81m/7ZeA2LoZoP
         Yi7O71WfSnScSZMfVMgDUOp75r5FJmTloV4xUbtT29+LV3LFlP0FduAStFTmBTsO4ifB
         hr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ELMdtnU96nSGslv5n69wK7Yi1A/faHCFHHb1qBkgYEk=;
        b=sfj520horh3YdJ+X2WBdeWaV2yBDX22MruAPdqR/y6r71o8nz+W+JFtEG9c9xFRXUy
         koK+SNr0fETeiZk7W+ojqDnpPXznfmgVLMsv4mCcZFcTEjJGFdkomNWPDNvIG4nInt/X
         RsZAqpWCs6qjCVae+Gr7YmIbwlWWpSjTVsT6WbsxTlJlBa/W/8a2Yzn30f3jluPTqoHU
         JXWwISuiAnShnf+FFgKFE5j/H5/u3n34P8dysCBDuEeLWD4XOFkg+zf3AadxvYsN/f2W
         GcIXhqgTwVmPIBnni1pj3u3gsCd++Om/FOcidA6cJkmoaDEkFReH/idar2D8H5eDXqSs
         Sr8g==
X-Gm-Message-State: ACgBeo0eUDxYCkY5n2ZVld7+q9bZSnafluFVo5ccvjzjj390YUKUWrFd
        fm8Sgb4w8mfSlgzHHO3DhgR+20qTgEA=
X-Google-Smtp-Source: AA6agR5SC8bEARGNp9kay49HvXi2u1hGnraOdW6HYCnBf3odxQ4Y3HTJzA/6PJaY8ml8sCjfGd1Z8Q==
X-Received: by 2002:a05:6870:2402:b0:11c:eb96:77be with SMTP id n2-20020a056870240200b0011ceb9677bemr528721oap.67.1661465708194;
        Thu, 25 Aug 2022 15:15:08 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v18-20020a4ade92000000b0044b491ccf97sm250232oou.25.2022.08.25.15.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:15:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix resize_finish() in rxe_queue.c
Date:   Thu, 25 Aug 2022 17:14:47 -0500
Message-Id: <20220825221446.6512-1-rpearsonhpe@gmail.com>
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

Currently in resize_finish() in rxe_queue.c there is a loop which
copies the entries in the original queue into a newly allocated queue.
The termination logic for this loop is incorrect. The call to
queue_next_index() updates cons but has no effect on whether the
queue is empty. So if the queue starts out empty nothing is copied
but if it is not then the loop will run forever. This patch changes
the loop to compare the value of cons to the original producer index.

Fixes: ae6e843fe08d0 ("RDMA/rxe: Add memory barriers to kernel queues")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
   Fixed typo. Should have replaced all original 'prod' by 'new_prod'
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index dbd4971039c0..d6dbf5a0058d 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -112,23 +112,25 @@ static int resize_finish(struct rxe_queue *q, struct rxe_queue *new_q,
 			 unsigned int num_elem)
 {
 	enum queue_type type = q->type;
+	u32 new_prod;
 	u32 prod;
 	u32 cons;
 
 	if (!queue_empty(q, q->type) && (num_elem < queue_count(q, type)))
 		return -EINVAL;
 
-	prod = queue_get_producer(new_q, type);
+	new_prod = queue_get_producer(new_q, type);
+	prod = queue_get_producer(q, type);
 	cons = queue_get_consumer(q, type);
 
-	while (!queue_empty(q, type)) {
-		memcpy(queue_addr_from_index(new_q, prod),
+	while ((prod - cons) & q->index_mask) {
+		memcpy(queue_addr_from_index(new_q, new_prod),
 		       queue_addr_from_index(q, cons), new_q->elem_size);
-		prod = queue_next_index(new_q, prod);
+		new_prod = queue_next_index(new_q, new_prod);
 		cons = queue_next_index(q, cons);
 	}
 
-	new_q->buf->producer_index = prod;
+	new_q->buf->producer_index = new_prod;
 	q->buf->consumer_index = cons;
 
 	/* update private index copies */

base-commit: 2c34bb6dea481fa11048e26ffd1ce7400dbc2105
-- 
2.34.1

