Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA084DD29F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiCRB5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1C241B6E
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so7486162oix.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ir1rbhJVm4YOuatC8nTnW07YQS3a/+GpADxu2BBd+7A=;
        b=FNRipG9CDMnaM6uTvDPD3IgPUmUEwVeEq6doaoHc4Yl1kaHYUZ2l5nZTRVo2g2gpqC
         b9M7dvjWuoxWkiHmd4kIiOA8mBIOPSqXuATlbYtW+dq5m1UVhfC4M60z1PG50zpi3ohu
         jqwwJRranXQn06mf18oeVhduRuoo429ctkeBn8KMru0NPQ3HrKeXC8ov1pSPPZmeFOtw
         x6Cj+jr35PQzY0rJtqnBSWMFROmxB2UrcT74TLX6aQ3LqMq4cNHienXAVV7hIZyfPFpF
         UO5Xx2PhR0DCrTSziYrEdeRCxlJoUGTXmQ7ejZNr3xHJRzZNShVKdkzZFdKCpafVdTt4
         phpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ir1rbhJVm4YOuatC8nTnW07YQS3a/+GpADxu2BBd+7A=;
        b=VvseTGcY0ndYv+RTMmhxD9NegjuIpEydn4ULxk+eUyxo4bPAJ4YoSSU0yMX5DR7hsw
         AUj/ngbCf8+WrwmSoU5/iiRz5KPxy9RU3XeC0GpYtcBeUotjqtGj+yYymVIUy2xV9FXt
         BIE3X41/hJnV5KzJ1wy+jKyhiGRwgrNKHCFBzM+KWrsl8hkpjcih44roRAsGkjlovbI+
         hECLZ0GEiMQd9W10FRlEY1My0W5AbBVl0ZJkq6R8xexC+Tc1H1kQpdanXgqf41k/OJaP
         zwZ9BgO7zINO2jJ15SqGd2uoFJ/+w17U9CxsCDA+SQTWNlaKC0rXxSpUg6HiPChfDqmt
         0Jrg==
X-Gm-Message-State: AOAM530ETo+SJdnG6jBCaQjxhyXTCdE1JrsJpVkuGDbADECKRitOB5tt
        ZLFWxBYpz8ZjyxIlTWJwwbo=
X-Google-Smtp-Source: ABdhPJy7YB7H62QgmymhziVSnV22gROhua4mx4x/tngvRuBLmDU9Pn9IalnOWSNNMWRnOaSDGsd8ew==
X-Received: by 2002:a05:6808:b19:b0:2ec:aefc:be5b with SMTP id s25-20020a0568080b1900b002ecaefcbe5bmr3062134oij.135.1647568532859;
        Thu, 17 Mar 2022 18:55:32 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 05/11] RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
Date:   Thu, 17 Mar 2022 20:55:08 -0500
Message-Id: <20220318015514.231621-6-rpearsonhpe@gmail.com>
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

Move the code which tears down an mr to rxe_mr_cleanup to allow
operations holding a reference to the mr to complete.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 60a31b718774..fc3942e04a1f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -683,14 +683,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 
-	if (atomic_read(&mr->num_mw) > 0) {
-		pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
-			__func__);
+	/* See IBA 10.6.7.2.6 */
+	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
-	}
 
-	mr->state = RXE_MR_STATE_INVALID;
-	rxe_put(mr_pd(mr));
 	rxe_put(mr);
 
 	return 0;
@@ -700,6 +696,8 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
 
+	rxe_put(mr_pd(mr));
+
 	ib_umem_release(mr->umem);
 
 	if (mr->cur_map_set)
-- 
2.32.0

