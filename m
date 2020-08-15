Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C33624531E
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgHOV6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgHOVv4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:56 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E71C0612B2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id x1so2353074oox.6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNH0D3OCw0/3bR6FAwuz4sebVNlKM6WDdrOt2LSSOsg=;
        b=LeFI7B6Ip3x5YI3AyISR06GrcgrT/NOVdB76HPCbIblJoVdDOP1N0fOLaveZ9RnxlY
         nkX1y/30Cq0KLlou8hQm9y9bdZXfn+eNhvVZcBiNaX6vY1Tu+MfhFlMEnCGKRUHXa3ZX
         QeEceUwwbLWkccHxY6OHn3Rm59It08TmdsLJyneJ+lLqEl/f2gG6RzJM++0O+FpX4Sri
         68oTaNhonhBB0wSKUUcXdhVYn6QdwAeIC5hI16d3ffUz5pjr+lo77Abc1QKb8bDhvDWA
         gSMzq7nm0P9H53/IRbPFK97XdNIU5KlZiRT9A8PCJHL90/8GnqXrWf6i48WuhjaracFf
         L3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNH0D3OCw0/3bR6FAwuz4sebVNlKM6WDdrOt2LSSOsg=;
        b=pR/WVx80HhqR/Rk05zj4WJUPrMT8MeveixSojUDmtV7OvuvA2hKiY0xUwFp4xuO9kP
         sqs+/G+jqCLWnzuyZ/3Uc6a+4RC+2S0T787+m1c8E46i05z1scV+zT5aVzLRnw8WfArm
         bTa5CEAnP0TiywVQovLBpZvswjjs/NoktzU4FCe9iZKgMWKQd+Dr7sRaHfGFON1wGgQR
         due+Zq6WE3Ri5zYOuThOZ18qocJ26HpLj2XREe7VQiaIHaZlrPET+JAbyrTfEgybmIIG
         6iXFytHJ7eB72310/2UO53KU7GMrTmjnSzFvc28iJMyY8FMNaiuiebI8iIkpXG9eRgDK
         hsEQ==
X-Gm-Message-State: AOAM531/knWT2RhXRvqDxB/qJC4rAGFnWlX63wctCHx5BBOGuCfkx+Ah
        742MVlh0gm0F5V4ngEevr7knn2n4WEY1PQ==
X-Google-Smtp-Source: ABdhPJyOQYYBroprosQYzmaXlqedECDPHwC3GxC70g3ssoTrksmLbQbOzuDReJ24rzqOc4Q+bWcacQ==
X-Received: by 2002:a4a:9cd6:: with SMTP id d22mr4152903ook.0.1597467604685;
        Fri, 14 Aug 2020 22:00:04 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id j2sm2120889ooo.6.2020.08.14.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 13/20] add debug print statements
Date:   Fri, 14 Aug 2020 23:58:37 -0500
Message-Id: <20200815045912.8626-14-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added some debug prints to help out. They will go away later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 29191cacfc56..b91364ba2c68 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -172,6 +172,8 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 
+	pr_info("rxe_alloc_pd: called\n");
+
 	return rxe_add_to_pool(&rxe->pd_pool, &pd->pelem);
 }
 
@@ -179,6 +181,8 @@ static void rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
+	pr_info("rxe_dealloc_pd: called\n");
+
 	rxe_drop_ref(pd);
 }
 
@@ -410,6 +414,8 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 	struct rxe_qp *qp;
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
+	pr_info("rxe_create_qp: called\n");
+
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return ERR_PTR(-EINVAL);
@@ -457,6 +463,8 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 
+	pr_info("rxe_modify_qp: called\n");
+
 	err = rxe_qp_chk_attr(rxe, qp, attr, mask);
 	if (err)
 		goto err1;
@@ -476,6 +484,8 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
 
+	pr_info("rxe_query_qp: called\n");
+
 	rxe_qp_to_init(qp, init);
 	rxe_qp_to_attr(qp, attr, mask);
 
@@ -486,6 +496,8 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
 
+	pr_info("rxe_destroy_qp: called\n");
+
 	rxe_qp_destroy(qp);
 	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
@@ -782,6 +794,8 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_create_cq_resp __user *uresp = NULL;
 
+	pr_info("rxe_create_cq: called\n");
+
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
@@ -807,6 +821,8 @@ static void rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
+	pr_info("rxe_destroy_cq: called\n");
+
 	rxe_cq_disable(cq);
 
 	rxe_drop_ref(cq);
@@ -846,6 +862,8 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	struct rxe_cqe *cqe;
 	unsigned long flags;
 
+	pr_info("rxe_poll_cq: called\n");
+
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
 		cqe = queue_head(cq->queue);
@@ -916,6 +934,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_reg_mr_resp __user *uresp = NULL;
 
+	pr_info("rxe_reg_user_mr: called\n");
+
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
@@ -939,9 +959,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	if (err)
 		goto err3;
 
-	pr_info("rxe_reg_user_mr: index = 0x%08x, rkey = 0x%08x\n",
-			mr->pelem.index, mr->ibmr.rkey);
-
 	if (uresp) {
 		if (copy_to_user(&uresp->index, &mr->pelem.index,
 				 sizeof(uresp->index))) {
@@ -964,6 +981,8 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 
+	pr_info("rxe_dereg_user_mr: called\n");
+
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
 	rxe_drop_index(mr);
-- 
2.25.1

