Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A17583FF
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGRSAs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGRSAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 14:00:48 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348E0B6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 11:00:47 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5661eb57452so3286389eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703246; x=1692295246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5hyP14VBkNrF0GuB4LMeJoqaHlfLFBeob/rDesPoWA=;
        b=dVw1VmE9jzjGBciexMqPIsOZe8YkJUvrAvLQ7WI6b0ELP4wpW22Clva+mVhGTjIH77
         gmYrJ922yPSyvMOe0wCUgcg09GCRWhEOV2VXuYoMhc4UQUo61ZE9udPDKhvKvPRWILoa
         /9D5V30aeBgAhRcsVNHxXH3WJDxtTLxGZZEuX5ZslrVzWASkBtz7k7o1eSH2FBUsGGos
         FMlTB9WqscR7NJ6NRM0p2auj5fe3a+eqLlZTGg+V/nZSTPg1s8GXwJL6C7GiOI/s90Uj
         sPspH5K7RwDZ1+pAuKSGZdQjcEEjBxKsWwPMKMF6yriBTojmQKdTLR/RKTOF2G48AB/T
         gLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703246; x=1692295246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5hyP14VBkNrF0GuB4LMeJoqaHlfLFBeob/rDesPoWA=;
        b=OXv6zMFuewZu52s8t8PKmCP25YGBJZbMKYAJ7iXw0b4knwfWKi5w18S/NLspP7a/Es
         BRgb8d8WsFlayVK0G4lApAxnLCS25hbGdY2aTsxK+4y4r3fKYHNih+74AMbHw/QGrWxV
         m7BHRjM9vXOTh9Epe3L4s6RbIxfMDgDJ3CjfqpYzjGy/vxA64hIk/PJSJdlfTwrllsJk
         Zz8SlW9/9/PAiz5MGpKuqHrDwxF1sQclTd4VKYm4D2gv5chqUYsWCIKIuaFRLpASTr9E
         0G/QMuU0KJ4VS9XiGbJ83ZXvk4CZQZk2ZOXx6raAqpRfirkHNhqJagb1Bsj3JzkBnEcr
         RENw==
X-Gm-Message-State: ABy/qLaIoJOzBnZQM6uzWAguEDc0bIh08bxn9iiZGdL0VZ2vh9bRD4qV
        QOwTospaAXpQABJjOhqrNv4=
X-Google-Smtp-Source: APBJJlE9+ZIYAsU/UwME2Zz32rE9Joy2NEFw3+QnDP4B25/568RIt3ej1/4KwcxIKscB7XyaXCmWYA==
X-Received: by 2002:a05:6808:1a25:b0:3a3:8e77:ddfd with SMTP id bk37-20020a0568081a2500b003a38e77ddfdmr38749oib.8.1689703246468;
        Tue, 18 Jul 2023 11:00:46 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-407d-4821-8a8f-dae8.res6.spectrum.com. [2603:8081:140c:1a00:407d:4821:8a8f:dae8])
        by smtp.gmail.com with ESMTPSA id o3-20020a05680803c300b003a38df6284dsm1007954oie.11.2023.07.18.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:00:46 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/2] RDMA/core: Support drivers use of rcu locking
Date:   Tue, 18 Jul 2023 12:59:43 -0500
Message-Id: <20230718175943.16734-2-rpearsonhpe@gmail.com>
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

This patch allows drivers to optionally include struct rcu_head
in their private object data structs and have rdma-core use kfree_rcu
to free the objects.

The offsets of the rcu_heads are stored in fields in struct
ib_device_ops and a macro RDMA_KFREE_RCU is introduced which calls
(an open coded) kfree_rcu instead of kfree if the value is non-
zero. Currently the supported object types are AH, QP and MW.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/core/uverbs_main.c |  2 +-
 drivers/infiniband/core/verbs.c       |  6 +++---
 include/rdma/ib_verbs.h               | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 7c9c79c13941..50497e550f18 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -112,7 +112,7 @@ int uverbs_dealloc_mw(struct ib_mw *mw)
 		return ret;
 
 	atomic_dec(&pd->usecnt);
-	kfree(mw);
+	RDMA_KFREE_RCU(mw);
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b99b3cc283b6..a49ae8c52c66 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -982,7 +982,7 @@ int rdma_destroy_ah_user(struct ib_ah *ah, u32 flags, struct ib_udata *udata)
 	if (sgid_attr)
 		rdma_put_gid_attr(sgid_attr);
 
-	kfree(ah);
+	RDMA_KFREE_RCU(ah);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_destroy_ah_user);
@@ -1970,7 +1970,7 @@ int ib_close_qp(struct ib_qp *qp)
 	atomic_dec(&real_qp->usecnt);
 	if (qp->qp_sec)
 		ib_close_shared_qp_security(qp->qp_sec);
-	kfree(qp);
+	RDMA_KFREE_RCU(qp);
 
 	return 0;
 }
@@ -2041,7 +2041,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 		ib_destroy_qp_security_end(sec);
 
 	rdma_restrack_del(&qp->res);
-	kfree(qp);
+	RDMA_KFREE_RCU(qp);
 	return ret;
 }
 EXPORT_SYMBOL(ib_destroy_qp_user);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1e7774ac808f..616e9e54a733 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2684,8 +2684,32 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
 	DECLARE_RDMA_OBJ_SIZE(ib_xrcd);
+
+	/* if non-zero holds offset of rcu_head in object */
+	ssize_t rcu_offset_ah;
+	ssize_t rcu_offset_qp;
+	ssize_t rcu_offset_mw;
+
 };
 
+/* drivers may optionally use rcu locking on verbs objects
+ * by including struct rcu_head in their private data and
+ * setting rcu_offset_xx in the ib_driver_ops struct where
+ * xx is one of ah, qp or mw.
+ */
+static inline void __rdma_kfree_rcu(void *obj, ssize_t rcu_offset)
+{
+	if (rcu_offset)
+		kvfree_call_rcu((struct rcu_head *)((u8 *)obj + rcu_offset),
+				obj);
+	else
+		kfree(obj);
+}
+
+/* obj must be one of ah, qp, or mw */
+#define RDMA_KFREE_RCU(obj) __rdma_kfree_rcu(obj,		\
+				obj->device->ops.rcu_offset_##obj)
+
 struct ib_core_device {
 	/* device must be the first element in structure until,
 	 * union of ib_core_device and device exists in ib_device.
-- 
2.39.2

