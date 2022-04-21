Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08785094B7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383665AbiDUBoB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383666AbiDUBoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C0765E
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t15so4125095oie.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTnTJfIpwuT3RU2jftWC9N4Q9ke/sywAPWG0nuID1Pg=;
        b=FkyjChHglPo89zHC9juKPH+x/2SbLRUgh0AVcXpaillH18dlAp2bhmWu8DVrgXrilB
         UeBA/PYfTyQ9fLjnKAVDQWcnFRD0WyhEtdrB4RmU4rwSbEg8roPNB1m/9U7PyeO5Knu3
         yHQblIKCeRISHxUE7ihqSb2qPQNRMXg5FqaIFEnR5aDyg+q8KRN7fFbC9pFbpG7cDE1S
         FbbgX3TVQyryKskcGavMRU0opz6lPAhOlsozMAMwJbqt5NaAFm3aP2nvas6gYe2iqS+n
         Bq6/pPLILiymAafFGxcDG5bbO4S+jFGtaBzGusvwNnFPrPCmdD5crAFVrwzqwmzb1ItV
         yEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTnTJfIpwuT3RU2jftWC9N4Q9ke/sywAPWG0nuID1Pg=;
        b=f7kSPlCuXAZHKeVY+ruvjHKyVbnsPxkSmbcB5VG7YB62CgKpfjwj5q556Fg8hqPBqT
         FQWy33Pz+9E83G69XnxrtzFb9UqexcJU+pjy9+Q8NwiYfM+ycMjVZI8vXFzPZ2aVgjP1
         dWpHos/9rqxw2vgZav/8bfn35Wl/f5jva0nkJKMiGtGlpdaUgOW4ml+h9uQd00ZkRMLT
         X4kG97kzD4JhY6q3maOTAeT9VtZDzGbYpFmou8GMuzJYY9K3+pmoDv6gGSeOjbvjWQSs
         hR/F5NCSuqdDkBsh+VNQ9PGZpA3+WmPEQgO+zSZetq8DyetugBN+g95iF0keoIzesvHl
         vQXg==
X-Gm-Message-State: AOAM531U4wwJO0+am24nIVbBXTu5RJ6N6KqXn6Q4KREE5REgcfI99Ca4
        w1l+Os/3piVBbmxnMnKoj74=
X-Google-Smtp-Source: ABdhPJxASKaP2N3UCCmNL00F+R49mkvIGWKsUjT0i/OZ23H3+BjX5dOCaDyOwORTRWQrh+07dmPdSQ==
X-Received: by 2002:a05:6808:188e:b0:322:f5b5:d907 with SMTP id bi14-20020a056808188e00b00322f5b5d907mr1938990oib.294.1650505271685;
        Wed, 20 Apr 2022 18:41:11 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 04/10] RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
Date:   Wed, 20 Apr 2022 20:40:37 -0500
Message-Id: <20220421014042.26985-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
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

Move the code from rxe_qp_destroy() to rxe_qp_do_cleanup().
This allows flows holding references to qp to complete before
the qp object is torn down.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 -
 drivers/infiniband/sw/rxe/rxe_qp.c    | 12 ++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 18f3c5dac381..0e022ae1b8a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -114,7 +114,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr,
 int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask);
 void rxe_qp_error(struct rxe_qp *qp);
 int rxe_qp_chk_destroy(struct rxe_qp *qp);
-void rxe_qp_destroy(struct rxe_qp *qp);
 void rxe_qp_cleanup(struct rxe_pool_elem *elem);
 
 static inline int qp_num(struct rxe_qp *qp)
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ff58f76347c9..a8011757784e 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -765,9 +765,11 @@ int rxe_qp_chk_destroy(struct rxe_qp *qp)
 	return 0;
 }
 
-/* called by the destroy qp verb */
-void rxe_qp_destroy(struct rxe_qp *qp)
+/* called when the last reference to the qp is dropped */
+static void rxe_qp_do_cleanup(struct work_struct *work)
 {
+	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
+
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
@@ -786,12 +788,6 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 		__rxe_do_task(&qp->comp.task);
 		__rxe_do_task(&qp->req.task);
 	}
-}
-
-/* called when the last reference to the qp is dropped */
-static void rxe_qp_do_cleanup(struct work_struct *work)
-{
-	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 30491b976d39..8585b1096538 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -490,7 +490,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	rxe_qp_destroy(qp);
 	rxe_put(qp);
 	return 0;
 }
-- 
2.32.0

