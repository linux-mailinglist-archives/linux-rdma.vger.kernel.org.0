Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C025A1B0A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiHYV2Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHYV2X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 17:28:23 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60539B9FB2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:28:22 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11c59785966so26586734fac.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/sMKdQJFQgr6IsLwFpuWCqFzkWbU3+jaXUVXarnMmio=;
        b=So8JlOiETB/zcg8ZkqcuodGzUQdce3TfUKICWTnoBd0Tsi9b2SVvl8zewlf0Km/FiB
         4oCDCIkE7QT6Jo/l+tYfxZ5h27Kit8VGixS1avaG6yiv4k7i2EUiDxxEDFu196/KYvW+
         Jh6Zw7FWCUEcKXNgeeOdKau7lLNAW07HjUCVLyligtj6DGuglsZygdVDR+QwOw+kMvoq
         EXyG4/VHom3kkDb8Cv46KRXzol08MFWfJq+D8h4gOnuSUPDDu1a6ppEofXl/9SZwOOkh
         Yk9+rjCE5u6z2rGEsO/IDomc//K7XkPIFSvBTUfmZtJcX0j+KMn7CgoNAUWQcmeir2kM
         pNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/sMKdQJFQgr6IsLwFpuWCqFzkWbU3+jaXUVXarnMmio=;
        b=SUUw/diUrl3znRZ8FGrMRkVgIA1b/VjWrnEaWu6JM77kGc7EiuC6LaYZ05/EpgSoDO
         zdztz28qzUm8SJlMCpCjQMu5OAav51dArfczR77VyYhDCE0zKW7q3dJ7wLdmR3vZfVPg
         v1wncd820wg51C3TIQUj/lRyMNBWMKQYJxiIVZlf5CqMTGTzNBcTmQFyRX27QIlxbdEP
         Jl9VmM4BzJwsgWwmOYzNtVXXhFMw6+EwZBdkiwvP+ut9R2gOENMqzWnTVRzTuyJyr2hr
         jOmBeqcfhhLQXCgSw1Adu2dgIC/K7BanUAJCCSJnOYl7YVUBA1OfyryjGDsXA2AtZovi
         DgJQ==
X-Gm-Message-State: ACgBeo35Ow31WMXA592JT6BNVdeuw3iJ+upwoPO4gFAriSADn+0mopn2
        qK00zplAmMb+RcRHR5eCn/A=
X-Google-Smtp-Source: AA6agR67Yp40kST9lXy4K5855Pp3VuTvKRC/kR9uZ3jkzH0347pWu2fTHI9eBoMnIBc0iQ7BsrlP9A==
X-Received: by 2002:a05:6870:609a:b0:10b:f9f1:2745 with SMTP id t26-20020a056870609a00b0010bf9f12745mr440405oae.124.1661462901787;
        Thu, 25 Aug 2022 14:28:21 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id s24-20020a056808009800b00342e8bd2299sm225985oic.6.2022.08.25.14.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:28:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix resize_finish() in rxe_queue.c
Date:   Thu, 25 Aug 2022 16:27:43 -0500
Message-Id: <20220825212742.5213-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_queue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index dbd4971039c0..06121a455a19 100644
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
+	while ((prod - cons) & q->index_mask) {
 		memcpy(queue_addr_from_index(new_q, prod),
 		       queue_addr_from_index(q, cons), new_q->elem_size);
-		prod = queue_next_index(new_q, prod);
+		new_prod = queue_next_index(new_q, prod);
 		cons = queue_next_index(q, cons);
 	}
 
-	new_q->buf->producer_index = prod;
+	new_q->buf->producer_index = new_prod;
 	q->buf->consumer_index = cons;
 
 	/* update private index copies */

base-commit: 2c34bb6dea481fa11048e26ffd1ce7400dbc2105
-- 
2.34.1

