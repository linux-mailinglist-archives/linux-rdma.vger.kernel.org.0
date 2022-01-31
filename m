Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA24A5210
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiAaWKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiAaWKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:06 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F91C06173B
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:06 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r27so7386922oiw.4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkBHdRKk08KQIqTCTrTE63cnp3LYEJ5QRumogQcI5G0=;
        b=dJywDkLPDXfIXJiqADZpswJCpqe2+5SUfvRdlKd4fp8y9UAXhlA90UebHlHAemnpNn
         x5A34WxdQKEbrwz5/V8uTdnGKmMEA3JuCAGxhIVkmqs6inZ1hmBE44ldfR7RKv2+ZL8n
         7gcB0oFFC8Fb59kmmyNKhQQLpFF0gWWNdQuhPE2JhYyd3fq6ZLcbiubX/7QWrWSfOUPk
         bzV9wC2u6DINlhCmHWTGr2I+uk4BVFSEL0YJ6zL4h+FkrLDKEIvdeLdPfHhRR9iMGLTk
         BDu3sWgvbPutUHGKRM+Vfrvc9s2vyXzReaN0CrskEkAxopOhzzD+u3pbV1lxULk/n4td
         CmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkBHdRKk08KQIqTCTrTE63cnp3LYEJ5QRumogQcI5G0=;
        b=VHYZpOfNGGX0ZSDHsrWttd8yE7Sw/Q7X0Iv4TY/sPbAEzRdTyJfUgrM3O/748O71TL
         ERnrZJXZxJcFRgguuf6yYjF5BETD7tg5htFEOxTS0K8AlnCDrqvq3oiU8jIx81LlviUE
         CHFYgk8hn/iEx3l1kLLBh+vsVSJKSgfDPLFKYCt3oV/xT/266BQVBpwCZ7twHDF/1Xwg
         MSpzZ5IG/jHBlAjWcblpF38+HJuzllDhmIeIqKUKLyfJUQWKqrohhbKOCmYcvm51oks/
         UoovGsxHe04xYlt8ZsDQqoUKXoFefjFMy+gRQPBIHuOFT2BaIwCQoyBaX0oYtRHzXwrm
         sqIQ==
X-Gm-Message-State: AOAM530jWB3wjBDS8lVudme11txzCg9d94Ff812tZ3wS03y6kXXSh/Yu
        W3oxAUKrovEuUUes/eJE6QU=
X-Google-Smtp-Source: ABdhPJxaDX+omJu0E96vCETXCi02qaCKtMhBMk7fDHTwPs7Q+UuyUVr+rbJJPIGA871dMgUs7NupoA==
X-Received: by 2002:a05:6808:181c:: with SMTP id bh28mr843055oib.125.1643667005767;
        Mon, 31 Jan 2022 14:10:05 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:05 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 02/17] RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
Date:   Mon, 31 Jan 2022 16:08:35 -0600
Message-Id: <20220131220849.10170-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move rxe_mcast_attach and rxe_mcast_detach from rxe_verbs.c to rxe_mcast.c,
Make non-static and add declarations to rxe_loc.h. Make the subroutines
in rxe_mcast.c referenced by these routines static and remove their
declarations from rxe_loc.h.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 12 ++-------
 drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 26 -------------------
 3 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bcec33c3c3b7..dc606241f0d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,18 +40,10 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p);
-
-int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mc_grp *grp);
-
-int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			    union ib_gid *mgid);
-
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
-
 void rxe_mc_cleanup(struct rxe_pool_elem *arg);
+int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
+int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index e5689c161984..f86e32f4e77f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -52,8 +52,8 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	return grp;
 }
 
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p)
+static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
+			     struct rxe_mc_grp **grp_p)
 {
 	int err;
 	struct rxe_mc_grp *grp;
@@ -81,7 +81,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	return 0;
 }
 
-int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
+static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mc_grp *grp)
 {
 	int err;
@@ -125,8 +125,8 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
-int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			    union ib_gid *mgid)
+static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
+				   union ib_gid *mgid)
 {
 	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem, *tmp;
@@ -194,3 +194,29 @@ void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 	rxe_drop_key(grp);
 	rxe_mcast_delete(rxe, &grp->mgid);
 }
+
+int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
+{
+	int err;
+	struct rxe_dev *rxe = to_rdev(ibqp->device);
+	struct rxe_qp *qp = to_rqp(ibqp);
+	struct rxe_mc_grp *grp;
+
+	/* takes a ref on grp if successful */
+	err = rxe_mcast_get_grp(rxe, mgid, &grp);
+	if (err)
+		return err;
+
+	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
+
+	rxe_drop_ref(grp);
+	return err;
+}
+
+int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
+{
+	struct rxe_dev *rxe = to_rdev(ibqp->device);
+	struct rxe_qp *qp = to_rqp(ibqp);
+
+	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 915ad6664321..f7682541f9af 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -999,32 +999,6 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 	return n;
 }
 
-static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
-{
-	int err;
-	struct rxe_dev *rxe = to_rdev(ibqp->device);
-	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mc_grp *grp;
-
-	/* takes a ref on grp if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
-	if (err)
-		return err;
-
-	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
-
-	rxe_drop_ref(grp);
-	return err;
-}
-
-static int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
-{
-	struct rxe_dev *rxe = to_rdev(ibqp->device);
-	struct rxe_qp *qp = to_rqp(ibqp);
-
-	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
-}
-
 static ssize_t parent_show(struct device *device,
 			   struct device_attribute *attr, char *buf)
 {
-- 
2.32.0

