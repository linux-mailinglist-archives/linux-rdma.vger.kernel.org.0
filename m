Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49C94A5213
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiAaWKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiAaWKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:08 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245AC061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:07 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t199so12940819oie.10
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKT0Z4cQawwxui4aW6anZu6dMHukCC9UuGWraip01Fo=;
        b=N8v3cZKEZBgSa5OqUd5UMZo3O76vH10UhLMy5gP+KUUnTts/PP9MYIdJmn86z34m5M
         9iJkqF2r8yl8k0F0x/raCKpR0ffvCNHfSQHrFUqATxrXxmsfx0EW5C0y0X4FfDmLtNya
         OnF4CeyA1KbnB9VSA/DxjJ/QGrt2gIkCN4LuH9sdBAGiym99TzHBHLwjP/A4i8wkilcW
         zXEHQFjogOQUEohneQFVPe8f6PieqBayIxCq37j+u9ghXw3aQ2jajKkASrXR0EhCuccW
         j8HrclOwNBUBwz08bvQmibTdWSVi46+nrH7WqWgJPhw9QvyAXwHphtPI8aX0NicC4hSo
         SxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKT0Z4cQawwxui4aW6anZu6dMHukCC9UuGWraip01Fo=;
        b=ZwA9gEZWu9q9+VdXQohh8jmQ1mOAgpT3kq+Euy++Hb2nC5dqBbSVXpBXmd7UzfGUSp
         YIorMQ5Dv6Nz3hPEEgIPYk5bvD/xAg1FpknkNizjVUzdrHFeZOiJ/oU7r0ELH1suxW2m
         yBXjhSP5EX65i9owe/Hx2GeuQpH+JNQ2iOlCDSbtiCUeA9ND7Mi9D46wtkRI/CKFIdVM
         VVGb0/uB6oBqLpbpxETSl32JjHjN9fGF4lxZBH866yyaIZl3nZRbiTYQ61c87l8xDO79
         JhP75kDM8OPNXwALx2TJX3QhYneturHm4oUa3C6qyo/MaxEfUUBGhheWwo5zvsI8WgGY
         ONQw==
X-Gm-Message-State: AOAM531IF1kD7aIn6JGA2DKm04O8s9Id80HcwijI5ZmEZ4HTmNHpsaMx
        yDVRDURmLff4FipZYUVZjp8=
X-Google-Smtp-Source: ABdhPJy8KoU0TM6DP8q9nVeXNPsN0c+En1yAs6+RRgQFJCT0Y71YeRY+Nw62xVPA1GPSK+4fpRpZ0A==
X-Received: by 2002:a05:6808:1250:: with SMTP id o16mr14512099oiv.95.1643667007297;
        Mon, 31 Jan 2022 14:10:07 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 04/17] RDMA/rxe: Enforce IBA o10-2.2.3
Date:   Mon, 31 Jan 2022 16:08:37 -0600
Message-Id: <20220131220849.10170-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
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
index 5018b9387694..99284337f547 100644
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
+		pr_debug_once("Attempt to destroy QP while attached to multicast group\n");
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

