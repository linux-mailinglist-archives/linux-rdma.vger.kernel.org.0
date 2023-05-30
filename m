Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67921717082
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjE3WN7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjE3WN6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C70E5
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:56 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3909756b8b1so1774466b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484835; x=1688076835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5joMuKjZqEF29Zy4iKhDoohhfPjvd0ykaakmkeg//1c=;
        b=p/853iM4wi+DCVC7rT3hPjcGI8zJo5u3M+qMCVGDDc0+iYl9mLFVpbB3vZEUxZ9HMX
         nPvOrw1a/k+HDc/6y8yLCL8Q7+KISkWRj7GZqJ9AIjLj3h2c3alsfKouJ/CR7e9IQvLD
         w2kY6+rqj6MRIkvtuKxm6THIiNDa0v/tTHRx8ByLLUbEmiK1IaR0IaTAX4dYtLLlhUue
         KNrNnTBQFQdUnXNrm43dDK6To261XlCqpugBRaPf1ElHgn6liW/NYmrZg3/GichHABUj
         QLlzhKdjrafeVdRCfhLDHjziPutdpEdHjhKPAvS7lC/3Qza7XQvO5+D+FfeES50V70ig
         Ju6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484835; x=1688076835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5joMuKjZqEF29Zy4iKhDoohhfPjvd0ykaakmkeg//1c=;
        b=Ct6sAWDBIxxbVdANOxJKq9+ETinTE0fQy0pUq3t9Untz5ryFNVKBjZZOUx5xZ1Durp
         7468ZbBeEGnJN4BF7jnNU/LTz4AVfz2zDAxWoRnNr83kM+vMCC1KDhIzjfiVkDTT/tV3
         ea3wdqG4A+/q33wy65ZubUlfpeQ4VpxBznb+BaVfsuuysS7qA9MZqlVxzipR8ht2MbjL
         hmWpmm4Bl7O7ltoXdWW41qOGDo89TK04pMVY+ifYXonMPvvnllVCJk1WNiEICVKkmxQL
         QiEdYzWXFHxnOQmkwFXEAgmvn/qCXwC9mHQvT5wF/sT5SS7v+i8ICHHC4sDSOI0gLG5l
         NC1A==
X-Gm-Message-State: AC+VfDwYWCMrbziqrQyxs92xh9eBL3HX109PWOHjNGN7Q0UpP4Br4Cus
        JB964eovJZscWadhK5CuFQPh9pKAVzI=
X-Google-Smtp-Source: ACHHUZ7jE4OfritkEFyZYGmJte5MfLHe4iGy6iYsTEMeSYtD5CaiPwL3RPIl99jLCUWGVyUoZSYzHg==
X-Received: by 2002:a05:6808:2816:b0:39a:bf0:4fd2 with SMTP id et22-20020a056808281600b0039a0bf04fd2mr2003155oib.11.1685484834186;
        Tue, 30 May 2023 15:13:54 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:53 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/6] RDMA/rxe: Implement rereg_user_mr
Date:   Tue, 30 May 2023 17:13:35 -0500
Message-Id: <20230530221334.89432-7-rpearsonhpe@gmail.com>
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

Implement the two easy cases of ib_rereg_user_mr.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 35 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bb2b9d40e242..f6396333bcef 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1299,6 +1299,40 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	return ERR_PTR(err);
 }
 
+static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
+				       u64 start, u64 length, u64 iova,
+				       int access, struct ib_pd *ibpd,
+				       struct ib_udata *udata)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
+	struct rxe_pd *pd = to_rpd(ibpd);
+
+	/* for now only support the two easy cases:
+	 * rereg_pd and rereg_access
+	 */
+	if (flags & ~RXE_MR_REREG_SUPPORTED) {
+		rxe_err_mr(mr, "flags = %#x not supported", flags);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (flags & IB_MR_REREG_PD) {
+		rxe_put(old_pd);
+		rxe_get(pd);
+		mr->ibmr.pd = ibpd;
+	}
+
+	if (flags & IB_MR_REREG_ACCESS) {
+		if (access & ~RXE_ACCESS_SUPPORTED_MR) {
+			rxe_err_mr(mr, "access = %#x not supported", access);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+		mr->access = access;
+	}
+
+	return NULL;
+}
+
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				  u32 max_num_sg)
 {
@@ -1451,6 +1485,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.query_srq = rxe_query_srq,
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
+	.rereg_user_mr = rxe_rereg_user_mr,
 	.resize_cq = rxe_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 2f2dc67f03dd..cb18b83b73c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -284,6 +284,11 @@ enum rxe_mr_lookup_type {
 	RXE_LOOKUP_REMOTE,
 };
 
+enum rxe_rereg {
+	RXE_MR_REREG_SUPPORTED	= IB_MR_REREG_PD
+				| IB_MR_REREG_ACCESS,
+};
+
 static inline int rkey_is_mw(u32 rkey)
 {
 	u32 index = rkey >> 8;
-- 
2.39.2

