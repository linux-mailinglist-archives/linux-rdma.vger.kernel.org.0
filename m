Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83936794B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhDVF3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhDVF3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:31 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A1EC06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:56 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso27025949otm.4
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcWbqqOyF9MlgaTqvIN7nO/zyisge7RNWRD6TlY0V+o=;
        b=kJh46/5rPL6YEIAdC2s0w4z2URUpSDgqQZexyzF10LG5QDMioNsXXzCSdhe9UBOpG7
         FMioEXch4+OfHUNSki3K/bZZF8HIP652piJ2QsT3Fmiz6gBrGEC6zek4Z5JB/vTHV1jc
         ntYcAOtHG50WVhcE06mFh6aiYUQTblCYEgEBToiIum1obtoH8Kib/Yj0UExhRECTb3cf
         kWQbG1+U7syL8/mkYvJO8Er7bMNCfoZ1LjUq9oQ7B7Tpy4dkpkXjjvvYvaMSoL6IY6ZQ
         DqTMLMo6liQg8jKcOIT/skIMbmM0jBYO+DLG1+yeWgoTPXvegG9BHXKOt2fXlVF3oE5G
         DJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcWbqqOyF9MlgaTqvIN7nO/zyisge7RNWRD6TlY0V+o=;
        b=XnvCKpkBcPxPu8zLdrAZqM75k3A2RvYTZci6YeYtsBTLpvBg1ohiotgyS76lhpVziH
         If/1/1oQRTTwda7zsBPfrHnZ22yLK2j0e2HXXBq7kVDRyCfdD0n6VeZNTIXEgS9vIugJ
         NiRxx9+yoIwFaIf0uZpXxAfAQd9skv2x9L1wgF0nqZNpf2WWKa730CcnLM5RDMKZbHny
         N5F0mnTuGBhFipeGwKa09Tm5QbXH6XMrpRAluUvekCETvY+zWDSej2RRYAzhlH60atk6
         CkK0qZ2OCLVx4bbkmZWGveRoM+3FD/nHHKZ1TxZ6py6uuqHFlgOGpvhGpQFDbYglyuML
         BnJA==
X-Gm-Message-State: AOAM531axrpE3PClDid1E0B9UCyx9L4SQeScBZG9t2S7R4w7rTKaVIcj
        +RqlnaEk07EurCNlXBvOsmU=
X-Google-Smtp-Source: ABdhPJwOJjXcx5g7QiDju7M4U8w3GbAuFEEMeGKQPIvgOV3lq6enE5HW+Dsk8HsZacsbb3z8bT5Vcw==
X-Received: by 2002:a9d:1724:: with SMTP id i36mr1391097ota.171.1619069336292;
        Wed, 21 Apr 2021 22:28:56 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id d2sm416088otl.48.2021.04.21.22.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 10/10] RDMA/rxe: Disallow MR dereg and invalidate when bound
Date:   Thu, 22 Apr 2021 00:28:23 -0500
Message-Id: <20210422052822.36527-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422052822.36527-1-rpearson@hpe.com>
References: <20210422052822.36527-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Check that an MR has no bound MWs before allowing a dereg or invalidate
operation.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v4:
  Added this patch to check mr->num_mw to disallow
  dereg and invalidate operations when MR has MW's
  bound.

 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 25 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 -----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 076e1460577f..93dbd81222e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -87,6 +87,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f871879e5f80..ec5bafc66207 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -546,6 +546,13 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 		goto err_drop_ref;
 	}
 
+	if (atomic_read(&mr->num_mw) > 0) {
+		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
+				__func__);
+		return -EINVAL;
+		goto err_drop_ref;
+	}
+
 	mr->state = RXE_MR_STATE_FREE;
 	ret = 0;
 
@@ -555,6 +562,24 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
+int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+
+	if (atomic_read(&mr->num_mw) > 0) {
+		pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	mr->state = RXE_MR_STATE_ZOMBIE;
+	rxe_drop_ref(mr_pd(mr));
+	rxe_drop_index(mr);
+	rxe_drop_ref(mr);
+
+	return 0;
+}
+
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d22f011a20f3..89f8f00215d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -913,17 +913,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return ERR_PTR(err);
 }
 
-static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-
-	mr->state = RXE_MR_STATE_ZOMBIE;
-	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
-	return 0;
-}
-
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				  u32 max_num_sg)
 {
-- 
2.27.0

