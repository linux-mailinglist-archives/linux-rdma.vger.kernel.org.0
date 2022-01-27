Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF27049ED81
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbiA0ViJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiA0ViJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:09 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EFC061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:09 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id b186so2347729oif.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VS4ULIj6Z254AwbD710TEadG7JtfZappHmjpTUGkXM=;
        b=LwbgAVcn4Rf/F6i9k228sTh35JRlIEgD5lY7+wcqvi8Gvx9m3iO+WvxXT/gjzabD5w
         PqfYO3y8v8dsn/qctCyDnMFpIyS86T6fDrQzSXKZ6EAun0CTsE7hcoOS//b6xnWs5whr
         EXG6jjFmmoQbLQEoW6kAYPG/3AARpQKIzVe4tD7hQS8JXE3OHv34HTCjt9pQ8vxFUilf
         2VzR9vXEjJeJFK/o3iV2h7NTtkzPCkcy+MeH1h/HS6nckU/Qwdz916lRwFYg2tTkPS0P
         SsMYq5pKo+x36p8pAT64+VHEO/Lh/vOEtCXaezCD5vKq0pKHn0UncY8ciStR18vo4OPD
         vI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VS4ULIj6Z254AwbD710TEadG7JtfZappHmjpTUGkXM=;
        b=6T9uc/H9idMCjF+EU43SFsHsDEr3ZfsQNp401KUulcxcw59emE6Vq9YVWzGzA149wW
         BKU5zXLHyQOqrvkJ85urjwT6AsZg+dF8hJCazaDe0Eud2hhbb5LCkW8i2qRUPknYBupX
         NMZWpGMpF9y5mtVFxVgk52enrS9niztYmkl7C9H5wf9TLRiowk32Znzzek9S0NcPQMv2
         DZCaoAsQuXwyUYJ/cJhaAhtRcnyDv3utsREwkK1meUjhtRUR7enCLUtWt/+HSnqcCrgo
         7RiAUqfEc1PNrz2T7AWfvN8pd7CziQVn1siM/m/PEnIy90pkl+wIpqH5HXsnA0rjSS48
         oXSg==
X-Gm-Message-State: AOAM5307xjCk78ba7Vl8MjJSGIcWIEtawOIC5SEeC0K3bnWzpE4qHhRK
        578eT0uyf0lwYgDMILIO/gJWrYZtcLM=
X-Google-Smtp-Source: ABdhPJyVULT2ZJm++zHP+ZFGUJ/thpqrcb1wOwnP9rGyLkaOjI44fodOTxSKBDK5U/TbdCXvYjUt4g==
X-Received: by 2002:a05:6808:1789:: with SMTP id bg9mr3609405oib.47.1643319488800;
        Thu, 27 Jan 2022 13:38:08 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:08 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 04/26] RDMA/rxe: Enforce IBA o10-2.2.3
Date:   Thu, 27 Jan 2022 15:37:33 -0600
Message-Id: <20220127213755.31697-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to check if a QP is attached to one or more multicast groups
when destroy_qp is called and return an error if so.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  9 +--------
 drivers/infiniband/sw/rxe/rxe_mcast.c |  2 ++
 drivers/infiniband/sw/rxe/rxe_qp.c    | 14 ++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  5 +++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index dc606241f0d6..052beaaacf43 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -101,26 +101,19 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
-
 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 		     struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
 		     struct ib_pd *ibpd, struct ib_udata *udata);
-
 int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init);
-
 int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		    struct ib_qp_attr *attr, int mask);
-
 int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr,
 		     int mask, struct ib_udata *udata);
-
 int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask);
-
 void rxe_qp_error(struct rxe_qp *qp);
-
+int rxe_qp_chk_destroy(struct rxe_qp *qp);
 void rxe_qp_destroy(struct rxe_qp *qp);
-
 void rxe_qp_cleanup(struct rxe_pool_elem *elem);
 
 static inline int qp_num(struct rxe_qp *qp)
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 949784198d80..34e3c52f0b72 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -114,6 +114,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	grp->num_qp++;
 	elem->qp = qp;
 	elem->grp = grp;
+	atomic_inc(&qp->mcg_num);
 
 	list_add(&elem->qp_list, &grp->qp_list);
 	list_add(&elem->grp_list, &qp->grp_list);
@@ -143,6 +144,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			list_del(&elem->qp_list);
 			list_del(&elem->grp_list);
 			grp->num_qp--;
+			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&grp->mcg_lock);
 			spin_unlock_bh(&qp->grp_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 5018b9387694..2af19b79dd23 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -770,6 +770,20 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	return 0;
 }
 
+int rxe_qp_chk_destroy(struct rxe_qp *qp)
+{
+	/* See IBA o10-2.2.3
+	 * An attempt to destroy a QP while attached to a mcast group
+	 * will fail immediately.
+	 */
+	if (atomic_read(&qp->mcg_num)) {
+		pr_warn_once("Attempt to destroy QP while attached to multicast group\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /* called by the destroy qp verb */
 void rxe_qp_destroy(struct rxe_qp *qp)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f7682541f9af..9f0aef4b649d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -493,6 +493,11 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
+	int ret;
+
+	ret = rxe_qp_chk_destroy(qp);
+	if (ret)
+		return ret;
 
 	rxe_qp_destroy(qp);
 	rxe_drop_index(qp);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 388b7dc23dd7..4910d0782e33 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -235,6 +235,7 @@ struct rxe_qp {
 	/* list of mcast groups qp has joined (for cleanup) */
 	struct list_head	grp_list;
 	spinlock_t		grp_lock; /* guard grp_list */
+	atomic_t		mcg_num;
 
 	struct sk_buff_head	req_pkts;
 	struct sk_buff_head	resp_pkts;
-- 
2.32.0

