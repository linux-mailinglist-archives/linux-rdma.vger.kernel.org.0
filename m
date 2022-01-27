Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DB49ED7F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiA0ViJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbiA0ViI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026EAC061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:08 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w133so8535143oie.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkBHdRKk08KQIqTCTrTE63cnp3LYEJ5QRumogQcI5G0=;
        b=aLXtTLI1ELhgUsKKyMXAUT3Lvn9mNQ9Lyr2Ehcyum+y4p9tfOXJS4QQvBEpjTk8MgN
         xDWQxRBgCcbgBTx4qk9etnI1koAKiiJsVu2z0yGTEXI1LFNrBffSBGocdELC7VMVNSWv
         LdvwGFLaSIU/Ql3Pn9BKeV8uJO3YR6sMnHCZmAp4ZAkHtaGW33dUc2FHrimVvORSJ25L
         6OuqZ49wggseYWqjGv8ctPpBfV9Z5nMhqFvf+RsCoI7frZy8O0cskkHUCzAP2cfVyHEZ
         Ew2alwsV8SnYmsj5stCGrI9XpFuUcXbmxSQoSh6cMjWS9fkBe6mc+3r+1KJy9xmvvgwB
         bBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkBHdRKk08KQIqTCTrTE63cnp3LYEJ5QRumogQcI5G0=;
        b=NaLyQ7maZh5LwYoEJ6S8X3aHNCgcuGlwNSdUUHxTqb0lFhybLwfImKEmXROmtLL8Kd
         Ac3AAHKgD8+kQthcrCJ/Q8SLuFSgJCtITDMGQqlCzcaQs1eZrPf4gWCX0JTQ69rCUX67
         nC/oJCC1ag9rF9sgm/7autYQ2UKq7raK7OCn4jKMzhXiWnKYSX4vj/xFPmJB9KXgFm/q
         T+1pQhmWlmsSlwfa0TnFFQ+MFwBMvUL53LwbuYrcMD+elj4WUkXxCQPQB5gnHQ+5m9Xa
         sJEMPU+X4YT7OyqNepGTeDNbSkmLQe4+VV/uJAODIGojqg3FNi7ljvb/G9RqDX1IroSA
         jg+w==
X-Gm-Message-State: AOAM533yYHx2j0sib63oQ16nYVmJHmcTqWhoxDvo3zZPwhuXWVUAqZSc
        GrlzlHuTsKl+FNYTyxnOXv8=
X-Google-Smtp-Source: ABdhPJz6nCR1XBFeowKA7//H9R98eUWMhgHQbcauGuvHMZ6T0ju7N6ShYV8OXPBjWiImLfq07ogAPg==
X-Received: by 2002:a05:6808:1281:: with SMTP id a1mr8741617oiw.69.1643319487417;
        Thu, 27 Jan 2022 13:38:07 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:07 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 02/26] RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
Date:   Thu, 27 Jan 2022 15:37:31 -0600
Message-Id: <20220127213755.31697-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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

