Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BC717080
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjE3WN6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjE3WNy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:54 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBA93
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:53 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-55564892accso2567876eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484833; x=1688076833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RROA+UCxw4Q5NEPetgrpyXLK0oTWWTCIDqOiKpL19pk=;
        b=HQyuAJW1gMpW3B+RiopZOee08bApkhpL/uN+m/XOGljziTNLIEixIyIlCDM2Cyuymn
         pzrdeGUyZfqJtOLUb4BI6dolbkPj3Vdb7RwhnF2406lsfP7OqLmmos11DQ+fgH8/s3sO
         QWUOxe5f3ksh+OE2ZwCF0QXPMILxrdElLFFu/EusY+lafKnSJbezR/iiTIRPqo8ZRN54
         WPudIINuTVoXR9xbYwZxtRFBNL7oJj9sZ5FC2Lmx7N48MZT7FUF/j69hShQ1EPapIwvk
         6tcS5goL4aWPPjon1TuI5WyfpMPSXOXuF2l66WXbU6UyV2GxyCbRtigB6TRuHH2Ir1fy
         8ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484833; x=1688076833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RROA+UCxw4Q5NEPetgrpyXLK0oTWWTCIDqOiKpL19pk=;
        b=jF+wA0F0XA4lDx1moPRoEwP5RNc35Poh0fnBMd0zGaGGKifo/lrdGhOsrKgC+Xzvyv
         r59qJMAJgsml4mbJJ/Jq9Qhiyw0jP0F8Ow1JQyV6PzF2EsBBPEnVGnjU/NCH2NLev+Bl
         kVPcqzoyJUb+mNg0o8jha8T7/+gSkZoIhWxyExs/NqKVCCZCVGjq2TJeTePlWiGNpADD
         Ako8EvngZhCseqjEFcFufFNYvPAhR8Fzx4mo/IATEsOx8DAoh6xNhSAqB1kcNFjTIhlH
         hu41Wu/pR4iPgAEhaT+SWyZSt0fccHXYYxBFdklGJ3rhh8mnoxUv7KOQmaPwMt4Ulz2x
         Gccg==
X-Gm-Message-State: AC+VfDzhjjZtiAx6tFsM3yGoG1ofbzdMIRIioSWpeGBu3wiLCHkIPHz/
        P7wUbd1ypO2lFYrvnqUcmHM=
X-Google-Smtp-Source: ACHHUZ6DP6FwAMu8C8P30BRR/tjwTheNDO07eJ1ARS8CXVQGIExmQDunwWBv31qoEpW22sV3dEcd2A==
X-Received: by 2002:a05:6808:218d:b0:398:1c55:82bd with SMTP id be13-20020a056808218d00b003981c5582bdmr2955341oib.45.1685484833235;
        Tue, 30 May 2023 15:13:53 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/6] RDMA/rxe: Let rkey == lkey for local access
Date:   Tue, 30 May 2023 17:13:34 -0500
Message-Id: <20230530221334.89432-6-rpearsonhpe@gmail.com>
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

In order to conform to other drivers stop using rkey == 0
as an indication that there are no remote access flags set.
Set rkey == lkey by default for all MRs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b3bc4ac5fedd..f54042e9aeb2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -47,16 +47,15 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
-	u32 rkey = (access & RXE_ACCESS_REMOTE) ? lkey : 0;
+	u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
 
 	/* set ibmr->l/rkey and also copy into private l/rkey
 	 * for user MRs these will always be the same
 	 * for cases where caller 'owns' the key portion
 	 * they may be different until REG_MR WQE is executed.
 	 */
-	mr->lkey = mr->ibmr.lkey = lkey;
-	mr->rkey = mr->ibmr.rkey = rkey;
+	mr->lkey = mr->ibmr.lkey = key;
+	mr->rkey = mr->ibmr.rkey = key;
 
 	mr->access = access;
 	mr->ibmr.page_size = PAGE_SIZE;
@@ -640,6 +639,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
+	int remote;
 	int ret;
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
@@ -649,9 +649,10 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 		goto err;
 	}
 
-	if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
+	remote = mr->access & RXE_ACCESS_REMOTE;
+	if (remote ? (key != mr->rkey) : (key != mr->lkey)) {
 		rxe_dbg_mr(mr, "wr key (%#x) doesn't match mr key (%#x)\n",
-			key, (mr->rkey ? mr->rkey : mr->lkey));
+			key, (remote ? mr->rkey : mr->lkey));
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
@@ -711,7 +712,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	mr->access = access;
 	mr->lkey = key;
-	mr->rkey = (access & RXE_ACCESS_REMOTE) ? key : 0;
+	mr->rkey = key;
 	mr->ibmr.iova = wqe->wr.wr.reg.mr->iova;
 	mr->state = RXE_MR_STATE_VALID;
 
-- 
2.39.2

