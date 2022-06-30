Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC556229D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiF3TFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiF3TFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8023AA79
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:10 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10bab338f70so492922fac.7
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyjLX6ic4CHAm5vSjTY4RzmAKn5FQWP0TWCHfZ2cDvE=;
        b=pZRzuL+uqrxtoSqTFjyswvJnYHzQihNtfuUuzT8lTreRoyfT0ofAMg0Hz75nEbgefU
         22QVri6ph0d5xl5vuoyMqGiTlHLmsIoix9TOnGXAfx748FUH3YZDK72cXl7ZAapVyYVY
         paVaDzrLT/r929TAHDbIFXR6HVLvXghLLozoNawT/TIcmbB/bAKGsmiLJ7zuPcUtVrDQ
         p9wl50ddJbT+4f8L2YeFUk+WRd0J5K+GP6yotYiAbYbRLxHPBzT+Gu9gZYyJy3ZdFEgr
         56Y0U7Jta3YvKKQRxqziOw9NMBSUryxFXRbXKgHSKvHETjOa6r7TEjmfadVH8F6IeQ63
         sYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyjLX6ic4CHAm5vSjTY4RzmAKn5FQWP0TWCHfZ2cDvE=;
        b=bIFk1gQSo43ctn4xQA/rs4Ru4UTgdV7/2EeK5S45Sp9XIX00+vZcxRkc9lXg4isIyj
         JYQN5gUl2YtTlHG+SiOLGsre1hm1Hhv8KXrP+OVfy4UJljy62a7ZdatGPMhxiCX6Kyz/
         F6rbmFCspjB1BKu9Wc1TBs7AFIhqlwKtlKagc0pRCPS4DFZYdgOWK+LXkhE5yC3x8UgH
         grLzOPu4sU0g+EDVtPOs4OZuoB2tcx4ahLBPVSg5PH2zAq1ygONGwqvAoCos14k5SaTT
         Ys+a0ebz/lq/DtcII4+RkAYi7u2I5iLG0ejux5mz0VKjOUfef7f4rc4du8jAEZ09VZnk
         RCpg==
X-Gm-Message-State: AJIora/xOCXh30zbfifa48Kd3K4iDjD2z6h5C/R1h/n2aegKQBSUfqXr
        4UdsIUyhG06kfVtF+nYspss=
X-Google-Smtp-Source: AGRyM1smD0Z/WzwqAvg1Kf6obfh/lGaOQt/txZDOmvkR3LMqjBb+fkUelhrxiP5LPOODXaFPN9qGYw==
X-Received: by 2002:a05:6871:4705:b0:108:7537:d1ad with SMTP id py5-20020a056871470500b001087537d1admr6280910oab.5.1656615909183;
        Thu, 30 Jun 2022 12:05:09 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/9] RDMA/rxe: Convert pr_warn/err to pr_debug in pyverbs
Date:   Thu, 30 Jun 2022 14:04:19 -0500
Message-Id: <20220630190425.2251-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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

The pyverbs test suite generates a few dmesg traces from intentional
error tests. This patch replaces those messages with pr_debug()
calls which improves the usefullness of the tests.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c   | 8 ++++----
 drivers/infiniband/sw/rxe/rxe_resp.c | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 642b52539ac3..b1a0ab3cd4bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -19,16 +19,16 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	}
 
 	if (cqe > rxe->attr.max_cqe) {
-		pr_warn("cqe(%d) > max_cqe(%d)\n",
-			cqe, rxe->attr.max_cqe);
+		pr_debug("cqe(%d) > max_cqe(%d)\n",
+				cqe, rxe->attr.max_cqe);
 		goto err1;
 	}
 
 	if (cq) {
 		count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
 		if (cqe < count) {
-			pr_warn("cqe(%d) < current # elements in queue (%d)",
-				cqe, count);
+			pr_debug("cqe(%d) < current # elements in queue (%d)",
+					cqe, count);
 			goto err1;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c45c9d954931..7aea5f06d061 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -448,7 +448,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	if (rkey_is_mw(rkey)) {
 		mw = rxe_lookup_mw(qp, access, rkey);
 		if (!mw) {
-			pr_err("%s: no MW matches rkey %#x\n", __func__, rkey);
+			pr_debug("%s: no MW matches rkey %#x\n",
+					__func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -468,7 +469,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
-			pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
+			pr_debug("%s: no MR matches rkey %#x\n",
+					__func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -1434,7 +1436,7 @@ int rxe_responder(void *arg)
 
 		case RESPST_ERROR:
 			qp->resp.goto_error = 0;
-			pr_warn("qp#%d moved to error state\n", qp_num(qp));
+			pr_debug("qp#%d moved to error state\n", qp_num(qp));
 			rxe_qp_error(qp);
 			goto exit;
 
-- 
2.34.1

