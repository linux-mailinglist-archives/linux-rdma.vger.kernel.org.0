Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4584DD29B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiCRB45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiCRB44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:56 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C8241A2A
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w127so7495953oig.10
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzyw0G+X5gEzfm3C8WMHFqx+zJvFjMkDqLfBwb9Xil8=;
        b=Uk2KJChsXoYk0CionU+czhOb8THcjG/qHD8nqklzPRIntD49CVZyG0kf3Q0VnxOrOP
         h+0SRKiNdzZSP6guW7SK6FgN+23ElVTySkvb9RH4+HUYpnIo8sHAkDfDdwgIwRqGsGyO
         0I18L6VENfvBZ6knR8cNTo6F6aXoTExOY5w8mWayDA3OQm4gIYtHCVRCva+6CbnVY4gu
         cJX8HXf70eadhE1/s12KxXPrtzvE+8JghHkI0NxfSeJowOPtAEDwT6EnJ3NkX1Ay09V2
         +o/EsXmIV0d5K/FuiMijtwqTJRuZV1Eye7nANFqxZo24lYC7mrThlzesKIN144EYxJUF
         uZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzyw0G+X5gEzfm3C8WMHFqx+zJvFjMkDqLfBwb9Xil8=;
        b=g1IA+Q0nzWqJnLxdd1Wgu5w9qnzfgt1OPpjb7Z+K5qyVH33CAxL2ko23tm/XApgoMy
         dWURouAd9VkkIRpmXN6CCcoxXJhslsCYlEer/dzUH7jAMAFuNIFdW7RmZAzPnJnxM4oe
         tsOF1m3cIb2Xw3zLDa+HVBufW/ntZYCr2pUrXxtVMn4o3NwqLB9anRraIpHiiPsm4rb9
         x9oDkRBIjwQUogEx5/OwmAf0mK8hgacqAmQqwrfT7LoErLGLG8Hadiw2g4Az7Kbjwupu
         nPryXpYlq4MAhyrhNDLgXBXxfKxQt3GaTF/d/IHaxEvQDxEXdSworqMqTrScIHUGo1K1
         qdQQ==
X-Gm-Message-State: AOAM530JvxjviwsO9TTuBJMeubioKS32fHhPvsN1TwmkhkqF7f8doR8h
        OfuzodNng2zr/CfmNXEPAil3VWBw23I=
X-Google-Smtp-Source: ABdhPJxxIsxRE04DqMMkW7u1APjSk+VeePrK97aB8slgLs8765D2bVel8Bw7UCcd39+fDW444b1KbA==
X-Received: by 2002:aca:1901:0:b0:2ec:b7d0:1207 with SMTP id l1-20020aca1901000000b002ecb7d01207mr7388585oii.30.1647568532018;
        Thu, 17 Mar 2022 18:55:32 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 04/11] RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
Date:   Thu, 17 Mar 2022 20:55:07 -0500
Message-Id: <20220318015514.231621-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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
index 300c702f432a..ddf91d3d5527 100644
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
index 62acf890af6c..f5200777399c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -777,9 +777,11 @@ int rxe_qp_chk_destroy(struct rxe_qp *qp)
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
@@ -798,12 +800,6 @@ void rxe_qp_destroy(struct rxe_qp *qp)
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
index 89f4f30f7247..9a3c33dad979 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -491,7 +491,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	rxe_qp_destroy(qp);
 	rxe_put(qp);
 	return 0;
 }
-- 
2.32.0

