Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18193758400
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjGRSAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjGRSAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 14:00:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA75C0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 11:00:48 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39ca120c103so3784967b6e.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703247; x=1692295247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiducbU0Z276ddwT5Mxs5bsEbtVKyWhgJJcUYbp5cus=;
        b=Gti8w+JJKlHjX5YXwExaLlX/yAJ5yHTTo84TisM35iv9WNRdzDpS+Evl/8IAwX4qfo
         TvKV1ydKTBxa58xQLGWW8jCPiBoyx4ohEPYelC+KGBW9tEhoeCH+cWf3CVj3MFLKTS76
         W2Cd2TjSAuSuyBgsDr/REos8ug6eiK9cp0vdKQFL8ZDz1rJn6vhMEJhu9xuV4YAXM3vD
         daVBuXINXupPX/mNGqcRJDkRKbhNeY9KlHy0LJc/ezgMcWjOQe35RtbFtmPx1ivGsfv5
         HNW33MXkw/0xWqIxRweqWJBbV5uGcoQgFs+u1+TmiJUlYrP8z8rpO6QiNZLGM+PrZ7a8
         i0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703247; x=1692295247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiducbU0Z276ddwT5Mxs5bsEbtVKyWhgJJcUYbp5cus=;
        b=E6xzyno/Xq++FYJiQIX9JgcBJ95zDIsuzF3XcbhEPVsf6OGa35iWvDiEgBNIBw2STv
         ox8Y0tV8lU75fuMLAsov5XyJ+Po0rUOGn2iyFiIAnTSB6YKnNh43EalQ8U7+z7/22o5b
         HvlVlnW4xsizid78EIBFd4zwbMADzuDmUJocLQzp3vF2f34Q4dqBO+b6dIAq9S+ozB/a
         rCE6ULV4uyRpX3gDTdzHszVhVDB+J/y1q0z+dlf3gBWSa2A9fTsCi5hvLMHRXOi05lWV
         ZrMGoMAUCb3iX3sWEp2Na0y1pFcbWQSW7XaRWitngKO3+nhxpI14zVFPb+eEN94poA1E
         tX4A==
X-Gm-Message-State: ABy/qLbvQdImFA27rccgNYfDwiTHrBTlQnICIRFzKCltjdtq4fCS/TJH
        EbzrD5fV8OFvIXDQyvu6dvA=
X-Google-Smtp-Source: APBJJlEbMvtRtJf/jXu8YVHWuIgdxNyrOwZ9WnuXRM/ykYc4E2kQb7lFgf/7ylAqqbPtb+ZxNYgiPg==
X-Received: by 2002:a05:6808:1d8:b0:3a2:572a:eaa6 with SMTP id x24-20020a05680801d800b003a2572aeaa6mr42501oic.5.1689703247258;
        Tue, 18 Jul 2023 11:00:47 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-407d-4821-8a8f-dae8.res6.spectrum.com. [2603:8081:140c:1a00:407d:4821:8a8f:dae8])
        by smtp.gmail.com with ESMTPSA id o3-20020a05680803c300b003a38df6284dsm1007954oie.11.2023.07.18.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:00:46 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed objects
Date:   Tue, 18 Jul 2023 12:59:44 -0500
Message-Id: <20230718175943.16734-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718175943.16734-1-rpearsonhpe@gmail.com>
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make rcu_read locking of critical sections with the indexed
verbs objects be protected from early freeing of those objects.
The AH, QP, MR and MW objects are looked up from their indices
contained in received packets or WQEs during I/O processing.
Make these objects be freed using kfree_rcu to avoid races.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.h  | 1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b42e26427a70..ef2f6f88e254 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -25,6 +25,7 @@ struct rxe_pool_elem {
 	struct kref		ref_cnt;
 	struct list_head	list;
 	struct completion	complete;
+	struct rcu_head		rcu;
 	u32			index;
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 903f0b71447e..b899924b81eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1395,7 +1395,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (cleanup_err)
 		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
 
-	kfree_rcu_mightsleep(mr);
+	kfree_rcu(mr, elem.rcu);
 	return 0;
 
 err_out:
@@ -1494,6 +1494,10 @@ static const struct ib_device_ops rxe_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
 	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
+
+	.rcu_offset_ah = offsetof(struct rxe_ah, elem.rcu),
+	.rcu_offset_qp = offsetof(struct rxe_qp, elem.rcu),
+	.rcu_offset_mw = offsetof(struct rxe_mw, elem.rcu),
 };
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
-- 
2.39.2

