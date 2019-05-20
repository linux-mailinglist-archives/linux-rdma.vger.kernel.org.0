Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2222C5F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfETGzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:10 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D286208C3;
        Mon, 20 May 2019 06:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335309;
        bh=g7dZHrOeyfpUsyNi+JwaauH+b1q8zCwVNP/WGY3o7cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kb5Y7UJnXCQHNZYfd5daZ65ekXwnhYCiiJUYYoJJYo/WeCbP68ZvR0eqFtqqGAkgK
         PPyb1ra7xtbQacLz+ouiyrdtyLWsOxt9OixLUMUdbFxKqgGDtgGTWhCZ/Glg0eTpe5
         Oc+D0nxCaMfHrGY6IIlmtnDtx/P0T3/ks6YOxpkc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 10/15] RDMA/cxgb3: Use sizeof() notation instead of plain sizeof
Date:   Mon, 20 May 2019 09:54:28 +0300
Message-Id: <20190520065433.8734-11-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

sizeof(a), sizeof a and sizeof (a) are all valid notations,
but first is more readable format recommended by checkpatch.pl.

Let's canonize it in cxgb3 drivers, so latter patches won't emit
checkpatch warnings. As part of this change, redundant memset() were
removed.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c      |  4 ++--
 drivers/infiniband/hw/cxgb3/iwch_cm.c       |  2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 24 ++++++++++-----------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 11ba482345ab..90c0d2db5177 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -219,7 +219,7 @@ static u32 get_qpid(struct cxio_rdev *rdev_p, struct cxio_ucontext *uctx)
 		if (!qpid)
 			goto out;
 		for (i = qpid+1; i & rdev_p->qpmask; i++) {
-			entry = kmalloc(sizeof *entry, GFP_KERNEL);
+			entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 			if (!entry)
 				break;
 			entry->qpid = i;
@@ -237,7 +237,7 @@ static void put_qpid(struct cxio_rdev *rdev_p, u32 qpid,
 {
 	struct cxio_qpid_list *entry;
 
-	entry = kmalloc(sizeof *entry, GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return;
 	pr_debug("%s qpid 0x%x\n", __func__, qpid);
diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c b/drivers/infiniband/hw/cxgb3/iwch_cm.c
index 1c90c86fc8b8..0bca72cb4d9a 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_cm.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.c
@@ -170,7 +170,7 @@ static void release_tid(struct t3cdev *tdev, u32 hwtid, struct sk_buff *skb)
 {
 	struct cpl_tid_release *req;
 
-	skb = get_skb(skb, sizeof *req, GFP_KERNEL);
+	skb = get_skb(skb, sizeof(*req), GFP_KERNEL);
 	if (!skb)
 		return;
 	req = skb_put(skb, sizeof(*req));
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index a0408933786c..be8b329b4cb8 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -126,7 +126,7 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 
 	if (udata) {
 		if (!t3a_device(rhp)) {
-			if (ib_copy_from_udata(&ureq, udata, sizeof (ureq))) {
+			if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
 				kfree(chp);
 				return ERR_PTR(-EFAULT);
 			}
@@ -171,7 +171,7 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 		struct iwch_ucontext *ucontext = rdma_udata_to_drv_context(
 			udata, struct iwch_ucontext, ibucontext);
 
-		mm = kmalloc(sizeof *mm, GFP_KERNEL);
+		mm = kmalloc(sizeof(*mm), GFP_KERNEL);
 		if (!mm) {
 			iwch_destroy_cq(&chp->ibcq, udata);
 			return ERR_PTR(-ENOMEM);
@@ -184,7 +184,7 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 		spin_unlock(&ucontext->mmap_lock);
 		mm->key = uresp.key;
 		mm->addr = virt_to_phys(chp->cq.queue);
-		if (udata->outlen < sizeof uresp) {
+		if (udata->outlen < sizeof(uresp)) {
 			if (!warned++)
 				pr_warn("Warning - downlevel libcxgb3 (non-fatal)\n");
 			mm->len = PAGE_ALIGN((1UL << uresp.size_log2) *
@@ -195,7 +195,7 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 					     sizeof(struct t3_cqe));
 			uresp.memsize = mm->len;
 			uresp.reserved = 0;
-			resplen = sizeof uresp;
+			resplen = sizeof(uresp);
 		}
 		if (ib_copy_to_udata(udata, &uresp, resplen)) {
 			kfree(mm);
@@ -549,7 +549,7 @@ static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	for_each_sg_dma_page(mhp->umem->sg_head.sgl, &sg_iter, mhp->umem->nmap, 0) {
 		pages[i++] = cpu_to_be64(sg_page_iter_dma_address(&sg_iter));
-		if (i == PAGE_SIZE / sizeof *pages) {
+		if (i == PAGE_SIZE / sizeof(*pages)) {
 			err = iwch_write_pbl(mhp, pages, i, n);
 			if (err)
 				goto pbl_done;
@@ -583,7 +583,7 @@ static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		pr_debug("%s user resp pbl_addr 0x%x\n", __func__,
 			 uresp.pbl_addr);
 
-		if (ib_copy_to_udata(udata, &uresp, sizeof (uresp))) {
+		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
 			iwch_dereg_mr(&mhp->ibmr, udata);
 			err = -EFAULT;
 			goto err;
@@ -876,13 +876,13 @@ static struct ib_qp *iwch_create_qp(struct ib_pd *pd,
 
 		struct iwch_mm_entry *mm1, *mm2;
 
-		mm1 = kmalloc(sizeof *mm1, GFP_KERNEL);
+		mm1 = kmalloc(sizeof(*mm1), GFP_KERNEL);
 		if (!mm1) {
 			iwch_destroy_qp(&qhp->ibqp, udata);
 			return ERR_PTR(-ENOMEM);
 		}
 
-		mm2 = kmalloc(sizeof *mm2, GFP_KERNEL);
+		mm2 = kmalloc(sizeof(*mm2), GFP_KERNEL);
 		if (!mm2) {
 			kfree(mm1);
 			iwch_destroy_qp(&qhp->ibqp, udata);
@@ -899,7 +899,7 @@ static struct ib_qp *iwch_create_qp(struct ib_pd *pd,
 		uresp.db_key = ucontext->key;
 		ucontext->key += PAGE_SIZE;
 		spin_unlock(&ucontext->mmap_lock);
-		if (ib_copy_to_udata(udata, &uresp, sizeof (uresp))) {
+		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
 			kfree(mm1);
 			kfree(mm2);
 			iwch_destroy_qp(&qhp->ibqp, udata);
@@ -907,7 +907,7 @@ static struct ib_qp *iwch_create_qp(struct ib_pd *pd,
 		}
 		mm1->key = uresp.key;
 		mm1->addr = virt_to_phys(qhp->wq.queue);
-		mm1->len = PAGE_ALIGN(wqsize * sizeof (union t3_wr));
+		mm1->len = PAGE_ALIGN(wqsize * sizeof(union t3_wr));
 		insert_mmap(ucontext, mm1);
 		mm2->key = uresp.db_key;
 		mm2->addr = qhp->wq.udb & PAGE_MASK;
@@ -928,7 +928,7 @@ static int iwch_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct iwch_dev *rhp;
 	struct iwch_qp *qhp;
 	enum iwch_qp_attr_mask mask = 0;
-	struct iwch_qp_attributes attrs;
+	struct iwch_qp_attributes attrs = {};
 
 	pr_debug("%s ib_qp %p\n", __func__, ibqp);
 
@@ -940,7 +940,6 @@ static int iwch_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (!attr_mask)
 		return 0;
 
-	memset(&attrs, 0, sizeof attrs);
 	qhp = to_iwch_qp(ibqp);
 	rhp = qhp->rhp;
 
@@ -1036,7 +1035,6 @@ static int iwch_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 		return -EINVAL;
 
 	dev = to_iwch_dev(ibdev);
-	memset(props, 0, sizeof *props);
 	memcpy(&props->sys_image_guid, dev->rdev.t3cdev_p->lldev->dev_addr, 6);
 	props->hw_ver = dev->rdev.t3cdev_p->type;
 	props->fw_ver = fw_vers_string_to_u64(dev);
-- 
2.20.1

