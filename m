Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7778E4C1F5C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244715AbiBWXIO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244716AbiBWXIN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:13 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453356779
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:44 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so833652oob.8
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnZMowBykl/ZuOijrTLkaDDU0JEbdavNgWnYY4Bf6Ys=;
        b=kmqH7PtwSrgpkHKQ8sttcfdkvZ+eMjXneLxwj4lUtiNrKUwBkXVSKf3aOQAVrdjF6x
         FN+bOj4s5eS+ArdxQDOYNoM1HTJELOB6BxcuIFqDcNlTM1/91qfiSOInE/uaB3EuKEuK
         ef9JeJAEmT32Cb68jqApe+JP3tmxW5vJNuYpPJwd+kBLfoqkfcD1rvdYnE0TtKHk2w34
         LfBPmIdhShUGFc7b9i5NB9ajYzPUvgRIDPANMDaCblaA3gQPDJ4xsu2IqJrkesbDGFiZ
         OXfo4jQACLIN7piL2W7BSONwmF2NBzHJQ09iiEHwrqr0uBsK6k4hb3ts5SdnaBBvYkx6
         nsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnZMowBykl/ZuOijrTLkaDDU0JEbdavNgWnYY4Bf6Ys=;
        b=Y1s5cmGmDw/96+56MaeizLZZCvrkA2ITEkIKAv7zTw/Ue0HpVJaM6LtvZLZ9QeF4Tv
         DnbafBK1E2CT4oE84N2aow/S1PAvztFtQOk/63no6yDYsJHxmOaopZfJ1AWCwAexm4OC
         m1phpiYY4C3e2lnUj+JjXb059WDvfMntXRh74QQKG3EG5Shsz4B69QZnL3oBelSqQ6ft
         eApyqbzj0Sd/BgEkYi//Z7hyh2mMmJ3sgvf1pOwJv5fEm3P62Q0W6G5kTz7dzRUH8H2R
         tU+QFz3kk5lopRxvcb2zddxuB8xoNdYR4NQSxLjuEOBbcMKbf129Jy8fInqjhpQWpwCy
         xUIw==
X-Gm-Message-State: AOAM531vL217URNwMR/TMQGZqeDaH7nozyyyfqqlSp2deuXPS7Cp+Yrz
        cI2HgIjsLcfPdiwz+YEIaKQ=
X-Google-Smtp-Source: ABdhPJw96GZCXJQ9DFxMrMPxGM4shYtchW6VSZlGFDbmKSNDZVmEOmmfzxfoc1sxn/HzUU4Ni+JuWg==
X-Received: by 2002:a05:6870:6014:b0:d6:ca51:2108 with SMTP id t20-20020a056870601400b000d6ca512108mr860692oaa.47.1645657663942;
        Wed, 23 Feb 2022 15:07:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 3/6] RDMA/rxe: Collect cleanup mca code in a subroutine
Date:   Wed, 23 Feb 2022 17:07:05 -0600
Message-Id: <20220223230706.50332-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
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

Collect cleanup code for struct rxe_mca into a subroutine,
__rxe_cleanup_mca() called in rxe_detach_mcg() in rxe_mcast.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 41 +++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index a0a7f8720f95..66c1ae703976 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -339,13 +339,31 @@ static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
+/**
+ * __rxe_cleanup_mca - cleanup mca object holding lock
+ * @mca: mca object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ */
+static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
+{
+	list_del(&mca->qp_list);
+
+	atomic_dec(&mcg->qp_num);
+	atomic_dec(&mcg->rxe->mcg_attach);
+	atomic_dec(&mca->qp->mcg_num);
+	rxe_drop_ref(mca->qp);
+
+	kfree(mca);
+}
+
 static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca, *tmp;
 	unsigned long flags;
-	int err;
 
 	mcg = rxe_lookup_mcg(rxe, mgid);
 	if (!mcg)
@@ -354,37 +372,30 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_irqsave(&rxe->mcg_lock, flags);
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			list_del(&mca->qp_list);
-			atomic_dec(&qp->mcg_num);
-			atomic_dec(&rxe->mcg_attach);
-			rxe_drop_ref(qp);
+			__rxe_cleanup_mca(mca, mcg);
 
 			/* if the number of qp's attached to the
 			 * mcast group falls to zero go ahead and
 			 * tear it down. This will not free the
 			 * object since we are still holding a ref
-			 * from the get key above.
+			 * from the get key above
 			 */
-			if (atomic_dec_return(&mcg->qp_num) <= 0)
+			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
 			/* drop the ref from get key. This will free the
 			 * object if qp_num is zero.
 			 */
 			kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-			kfree(mca);
-			err = 0;
-			goto out_unlock;
+
+			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			return 0;
 		}
 	}
 
 	/* we didn't find the qp on the list */
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-	err = -EINVAL;
-
-out_unlock:
 	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
-	return err;
+	return -EINVAL;
 }
 
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
-- 
2.32.0

