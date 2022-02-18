Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082314BAE9D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiBRAg7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:36:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiBRAg6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:36:58 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462BD31200
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:43 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x193so1473019oix.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBKd18xtZScg/tYiH1GX5Afq48PxutZy5Io/riDzpx8=;
        b=X50DzE2BdT0yBCZ59/liU/zAcKsB0XF7jNeydwqkRkQRJL9+tKaIrww7oRDZbX+MPl
         VR3nigzZTXZXOKTigOitW2bRbu4zu+dznMRg9KN/e7f2Rxbmaxu36PxzTk8eLsT9Dn6X
         5BGrG3qyMlReAH9A3T0vgK6/mJdTEkfc+Jue+Ku1UmGrfJcBlX/MtOWMTCZoveT3/bKr
         aGPu5i4KlGgEue8BjXMCzfVd5iVrW8JlwNeEAFPRMZfKZQcpCcfevmk6x+6WyckBHdTV
         VuW3iXdjXPrz4BfEhrWlTpmR4hRvgOxCbf8hcbUXYrG0homt8uh4jcBqmbwUxi5AQhcw
         QAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBKd18xtZScg/tYiH1GX5Afq48PxutZy5Io/riDzpx8=;
        b=NIa2/sGgOFqdh9V1Wc83YM4j8KXiM+loYYxilQiwGF5QVhnWe8+iS7tGADwU25ELpZ
         bkxq8/qnEMnIW2hPheYnrDNomNnWFZ+wGJ5480lqXKWjTfeNtui/6e1CcMYXhTCHOwtV
         0E4YDWUf9BSNjPgjVMXaouJzaL+YnR+Z/Cd4lipk9QfHli6MFkGAMdwVfvCMA5rMCaKV
         I+WdVku2T3V2o6G58iRHSmxdx7k+2LAnPVglIPGsjj0xBdYKKEDUuFEgmchmLrQEYSbP
         AFcPPj3r4CxIJ4ml+D3FciBs0Af6zGhgYPq5m0Nqw41oPqfPMiprfFEMP2NJVwcP1kIp
         kbYA==
X-Gm-Message-State: AOAM531k+1AtgSmKb55lPClmSLjZNqIbY6IDiFkmXNFblC8uKAgU8iyp
        syp/c93wHTaJgtvh2Ma6T/Q=
X-Google-Smtp-Source: ABdhPJySXQdi0b4mcRbL0ng1BnT5Dgg0m9E1MTAvhr4iGUjRSrZSkrERbkjd0bBbur/3Dno3T5cnYQ==
X-Received: by 2002:a05:6808:2108:b0:2d4:3ad1:6625 with SMTP id r8-20020a056808210800b002d43ad16625mr4027860oiw.74.1645144602664;
        Thu, 17 Feb 2022 16:36:42 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 3/6] RDMA/rxe: Collect cleanup mca code in a subroutine
Date:   Thu, 17 Feb 2022 18:35:41 -0600
Message-Id: <20220218003543.205799-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218003543.205799-1-rpearsonhpe@gmail.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
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
index 53db0984a9a1..0f0655e81d40 100644
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

