Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7C4FB227
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiDKDJc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiDKDJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 23:09:31 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121227B28
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 20:07:18 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d39f741ba0so15787756fac.13
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0bb1FEzZgjNavC57gvrjlnnIMlvCgAuDXZ4w//DEaI=;
        b=GZA7Tx24lk737bLy2qTVu47kcFqdrbwkCajLKizzd+raKHkq3yzaM4GK1CAgfsvvT2
         2SQNC4h73ecuYkYE4qL90blMZaj4k6tKivBf/D5DVx7lP4HAjU4lju1OQ6GGzfNg61NJ
         sTrvGkB87Nm4Bfn9du6QjVofNWqY+Bohd3xWwArLJ7rhHWYbbp4jo/+EDDiDC8kcZkM3
         cpfYuFEvyU56gkAJ+SVCfrZ3XhZxdc/3G1NLxri4v3zE5Ip7jWonFIpp8v+H9XooDvrY
         fzB3LJy7QbX6lgYyHdU4FNgxJtrGyuveqP+S5T8bokZKPwJ07EQ13H7AKBJjTHhEPbVk
         Uwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0bb1FEzZgjNavC57gvrjlnnIMlvCgAuDXZ4w//DEaI=;
        b=1TbgdI/V2kOy5IvqloUlQRuSgXdhpFsocClfzc7k6KmL6AjfPiUbZi0KUW5z5aPJ0n
         2P00/WPZStmQAVciRoiWGxhMZuoVjqS7LGSTuzmfg2PL4+25E3dX/ole+IWLMUJZ8LJs
         1h2I1lDdnP/tHvuXV6+cV+xK4cIwJroFaXyajJ9E55RnE8x35iPqCf0DtZXc57jMjQIt
         zn5MAbCZvB0thmlJe2HjvA7OfIRmbCwL71e7YWKxAFoCp9jioNDQ+SLCVaCNO+0ZTCjX
         UQt2y2RwTlSJbruwZcG5cMy/eQY/3xi9fJ7xqR7fLFEK3IRX+8I8+ImFAr4XOmrwMx9u
         gsHg==
X-Gm-Message-State: AOAM531pLkpN0MkKoqfeQWt5JjKLZnYKSGysuaVVoNtNHzbK5QaAEcjP
        baYnvAQ+K7iHLyjxMDM2iCE=
X-Google-Smtp-Source: ABdhPJzlhK1uAeWE8RYlccHG1VOrjtlzRwnCaYMQKzAujWBZzhtZH20rQB+VtybPGzM81DhuEyYrSA==
X-Received: by 2002:a05:6870:f109:b0:da:b3f:2b4c with SMTP id k9-20020a056870f10900b000da0b3f2b4cmr13381404oac.235.1649646436759;
        Sun, 10 Apr 2022 20:07:16 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-dc1d-a6ff-2878-e7c1.res6.spectrum.com. [2603:8081:140c:1a00:dc1d:a6ff:2878:e7c1])
        by smtp.googlemail.com with ESMTPSA id c37-20020a9d27a8000000b005b23cf22e23sm12027527otb.42.2022.04.10.20.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:07:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix "Replace mr by rkey in responder resources"
Date:   Sun, 10 Apr 2022 22:06:48 -0500
Message-Id: <20220411030647.20011-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

The referenced commit generates a reference counting error if
the the rkey has the same index but the wrong key. In this
case the reference taken by rxe_pool_get_index() is not dropped.

Drop the reference if the keys don't match in rxe_recheck_mr().
Check that the mw and mr are still valid.

Fixes: 8a1a0be894da0 ("RDMA/rxe: Replace mr by rkey in responder resources")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 16fc7ea1298d..1d95fab606da 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -680,6 +680,11 @@ static struct resp_res *rxe_prepare_read_res(struct rxe_qp *qp,
  * It is assumed that the access permissions if originally good
  * are OK and the mappings to be unchanged.
  *
+ * TODO: If someone reregisters an MR to change its size or
+ * access permissions during the processing of an RDMA read
+ * we should kill the responder resource and complete the
+ * operation with an error.
+ *
  * Return: mr on success else NULL
  */
 static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
@@ -690,23 +695,27 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 
 	if (rkey_is_mw(rkey)) {
 		mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
-		if (!mw || mw->rkey != rkey)
+		if (!mw)
 			return NULL;
 
-		if (mw->state != RXE_MW_STATE_VALID) {
+		mr = mw->mr;
+		if (mw->rkey != rkey || mw->state != RXE_MW_STATE_VALID ||
+		    !mr || mr->state != RXE_MR_STATE_VALID) {
 			rxe_put(mw);
 			return NULL;
 		}
 
-		mr = mw->mr;
+		rxe_get(mr);
 		rxe_put(mw);
-	} else {
-		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-		if (!mr || mr->rkey != rkey)
-			return NULL;
+
+		return mr;
 	}
 
-	if (mr->state != RXE_MR_STATE_VALID) {
+	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	if (!mr)
+		return NULL;
+
+	if (mr->rkey != rkey || mr->state != RXE_MR_STATE_VALID) {
 		rxe_put(mr);
 		return NULL;
 	}
-- 
2.32.0

