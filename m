Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B521424FE
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgATIXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 03:23:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgATIXk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02FA9C40D78002B2886E;
        Mon, 20 Jan 2020 16:23:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:23:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/7] RDMA/hns: Optimize qp buffer allocation flow
Date:   Mon, 20 Jan 2020 16:19:34 +0800
Message-ID: <1579508377-55818-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
References: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Encapsulate qp buffer allocation related code into 3 functions:
alloc_qp_buf(), map_qp_buf() and free_qp_buf().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 268 +++++++++++++++-------------
 2 files changed, 147 insertions(+), 122 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1f361e6..9ddeb2b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -660,7 +660,6 @@ struct hns_roce_qp {
 	/* this define must less than HNS_ROCE_MAX_BT_REGION */
 #define HNS_ROCE_WQE_REGION_MAX	 3
 	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX];
-	int			region_cnt;
 	int                     wqe_bt_pg_shift;
 
 	u32			buff_size;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 3bd5809..5184cb4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -716,23 +716,150 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 	kfree(hr_qp->rq_inl_buf.wqe_list);
 }
 
+static int map_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+		      u32 page_shift, bool is_user)
+{
+	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_region *r;
+	int region_count;
+	int buf_count;
+	int ret;
+	int i;
+
+	region_count = split_wqe_buf_region(hr_dev, hr_qp, hr_qp->regions,
+					ARRAY_SIZE(hr_qp->regions), page_shift);
+
+	/* alloc a tmp list for storing wqe buf address */
+	ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list, region_count);
+	if (ret) {
+		ibdev_err(ibdev, "alloc buf_list error for create qp\n");
+		return ret;
+	}
+
+	for (i = 0; i < region_count; i++) {
+		r = &hr_qp->regions[i];
+		if (is_user)
+			buf_count = hns_roce_get_umem_bufs(hr_dev, buf_list[i],
+					r->count, r->offset, hr_qp->umem,
+					page_shift);
+		else
+			buf_count = hns_roce_get_kmem_bufs(hr_dev, buf_list[i],
+					r->count, r->offset, &hr_qp->hr_buf);
+
+		if (buf_count != r->count) {
+			ibdev_err(ibdev, "get %s qp buf err,expect %d,ret %d.\n",
+				  is_user ? "user" : "kernel",
+				  r->count, buf_count);
+			ret = -ENOBUFS;
+			goto done;
+		}
+	}
+
+	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
+							region_count);
+	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
+			  page_shift);
+	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list, hr_qp->regions,
+				  region_count);
+	if (ret)
+		ibdev_err(ibdev, "mtr attatch error for create qp\n");
+
+	goto done;
+
+	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
+done:
+	hns_roce_free_buf_list(buf_list, region_count);
+
+	return ret;
+}
+
+static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			struct ib_qp_init_attr *init_attr,
+			struct ib_udata *udata, unsigned long addr)
+{
+	u32 page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	bool is_rq_buf_inline;
+	int ret;
+
+	is_rq_buf_inline = (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
+			   hns_roce_qp_has_rq(init_attr);
+	if (is_rq_buf_inline) {
+		ret = alloc_rq_inline_buf(hr_qp, init_attr);
+		if (ret) {
+			ibdev_err(ibdev, "alloc recv inline buffer error\n");
+			return ret;
+		}
+	}
+
+	if (udata) {
+		hr_qp->umem = ib_umem_get(udata, addr, hr_qp->buff_size, 0);
+		if (IS_ERR(hr_qp->umem)) {
+			ibdev_err(ibdev, "get umem error for qp buf\n");
+			ret = PTR_ERR(hr_qp->umem);
+			goto err_inline;
+		}
+	} else {
+		ret = hns_roce_buf_alloc(hr_dev, hr_qp->buff_size,
+					 (1 << page_shift) * 2,
+					 &hr_qp->hr_buf, page_shift);
+		if (ret) {
+			ibdev_err(ibdev, "alloc roce buf error\n");
+			goto err_inline;
+		}
+	}
+
+	ret = map_qp_buf(hr_dev, hr_qp, page_shift, udata);
+	if (ret) {
+		ibdev_err(ibdev, "map roce buf error\n");
+		goto err_alloc;
+	}
+
+	return 0;
+
+err_inline:
+	if (is_rq_buf_inline)
+		free_rq_inline_buf(hr_qp);
+
+err_alloc:
+	if (udata) {
+		ib_umem_release(hr_qp->umem);
+		hr_qp->umem = NULL;
+	} else {
+		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
+	}
+
+	return ret;
+}
+
+static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+{
+	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
+	if (hr_qp->umem) {
+		ib_umem_release(hr_qp->umem);
+		hr_qp->umem = NULL;
+	}
+
+	if (hr_qp->hr_buf.nbufs > 0)
+		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
+
+	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
+	     hr_qp->rq.wqe_cnt)
+		free_rq_inline_buf(hr_qp);
+}
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
 				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
 {
-	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_ib_create_qp ucmd;
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct hns_roce_ucontext, ibucontext);
-	struct hns_roce_buf_region *r;
-	u32 page_shift;
-	int buf_count;
 	int ret;
-	int i;
 
 	mutex_init(&hr_qp->mutex);
 	spin_lock_init(&hr_qp->sq.lock);
@@ -754,59 +881,18 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		goto err_out;
 	}
 
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	    hns_roce_qp_has_rq(init_attr)) {
-		ret = alloc_rq_inline_buf(hr_qp, init_attr);
-		if (ret) {
-			dev_err(dev, "allocate receive inline buffer failed\n");
-			goto err_out;
-		}
-	}
-
-	page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 	if (udata) {
 		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
 			dev_err(dev, "ib_copy_from_udata error for create qp\n");
 			ret = -EFAULT;
-			goto err_alloc_rq_inline_buf;
+			goto err_out;
 		}
 
 		ret = hns_roce_set_user_sq_size(hr_dev, &init_attr->cap, hr_qp,
 						&ucmd);
 		if (ret) {
 			dev_err(dev, "hns_roce_set_user_sq_size error for create qp\n");
-			goto err_alloc_rq_inline_buf;
-		}
-
-		hr_qp->umem = ib_umem_get(udata, ucmd.buf_addr,
-					  hr_qp->buff_size, 0);
-		if (IS_ERR(hr_qp->umem)) {
-			dev_err(dev, "ib_umem_get error for create qp\n");
-			ret = PTR_ERR(hr_qp->umem);
-			goto err_alloc_rq_inline_buf;
-		}
-		hr_qp->region_cnt = split_wqe_buf_region(hr_dev, hr_qp,
-				hr_qp->regions, ARRAY_SIZE(hr_qp->regions),
-				page_shift);
-		ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list,
-					      hr_qp->region_cnt);
-		if (ret) {
-			dev_err(dev, "alloc buf_list error for create qp\n");
-			goto err_alloc_list;
-		}
-
-		for (i = 0; i < hr_qp->region_cnt; i++) {
-			r = &hr_qp->regions[i];
-			buf_count = hns_roce_get_umem_bufs(hr_dev,
-					buf_list[i], r->count, r->offset,
-					hr_qp->umem, page_shift);
-			if (buf_count != r->count) {
-				dev_err(dev,
-					"get umem buf err, expect %d,ret %d.\n",
-					r->count, buf_count);
-				ret = -ENOBUFS;
-				goto err_get_bufs;
-			}
+			goto err_out;
 		}
 
 		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) &&
@@ -817,7 +903,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 						   &hr_qp->sdb);
 			if (ret) {
 				dev_err(dev, "sq record doorbell map failed!\n");
-				goto err_get_bufs;
+				goto err_out;
 			}
 
 			/* indicate kernel supports sq record db */
@@ -844,13 +930,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
 			dev_err(dev, "init_attr->create_flags error!\n");
 			ret = -EINVAL;
-			goto err_alloc_rq_inline_buf;
+			goto err_out;
 		}
 
 		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
 			dev_err(dev, "init_attr->create_flags error!\n");
 			ret = -EINVAL;
-			goto err_alloc_rq_inline_buf;
+			goto err_out;
 		}
 
 		/* Set SQ size */
@@ -858,7 +944,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 						  hr_qp);
 		if (ret) {
 			dev_err(dev, "hns_roce_set_kernel_sq_size error!\n");
-			goto err_alloc_rq_inline_buf;
+			goto err_out;
 		}
 
 		/* QP doorbell register address */
@@ -872,49 +958,17 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
 			if (ret) {
 				dev_err(dev, "rq record doorbell alloc failed!\n");
-				goto err_alloc_rq_inline_buf;
+				goto err_out;
 			}
 			*hr_qp->rdb.db_record = 0;
 			hr_qp->rdb_en = 1;
 		}
 
-		/* Allocate QP buf */
-		if (hns_roce_buf_alloc(hr_dev, hr_qp->buff_size,
-				       (1 << page_shift) * 2,
-				       &hr_qp->hr_buf, page_shift)) {
-			dev_err(dev, "hns_roce_buf_alloc error!\n");
-			ret = -ENOMEM;
-			goto err_db;
-		}
-		hr_qp->region_cnt = split_wqe_buf_region(hr_dev, hr_qp,
-				hr_qp->regions, ARRAY_SIZE(hr_qp->regions),
-				page_shift);
-		ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list,
-					      hr_qp->region_cnt);
-		if (ret) {
-			dev_err(dev, "alloc buf_list error for create qp!\n");
-			goto err_alloc_list;
-		}
-
-		for (i = 0; i < hr_qp->region_cnt; i++) {
-			r = &hr_qp->regions[i];
-			buf_count = hns_roce_get_kmem_bufs(hr_dev,
-					buf_list[i], r->count, r->offset,
-					&hr_qp->hr_buf);
-			if (buf_count != r->count) {
-				dev_err(dev,
-					"get kmem buf err, expect %d,ret %d.\n",
-					r->count, buf_count);
-				ret = -ENOBUFS;
-				goto err_get_bufs;
-			}
-		}
-
 		hr_qp->sq.wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64),
 					 GFP_KERNEL);
 		if (ZERO_OR_NULL_PTR(hr_qp->sq.wrid)) {
 			ret = -ENOMEM;
-			goto err_get_bufs;
+			goto err_db;
 		}
 
 		if (hr_qp->rq.wqe_cnt) {
@@ -927,21 +981,16 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
-							hr_qp->region_cnt);
-	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
-			  page_shift);
-	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list,
-				  hr_qp->regions, hr_qp->region_cnt);
+	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
 	if (ret) {
-		dev_err(dev, "mtr attach error for create qp\n");
-		goto err_wrid;
+		ibdev_err(&hr_dev->ib_dev, "alloc qp buf error\n");
+		goto err_db;
 	}
 
 	ret = alloc_qpn(hr_dev, hr_qp);
 	if (ret) {
 		ibdev_err(&hr_dev->ib_dev, "alloc qpn error\n");
-		goto err_mtr;
+		goto err_buf;
 	}
 
 	ret = alloc_qpc(hr_dev, hr_qp);
@@ -974,8 +1023,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	atomic_set(&hr_qp->refcount, 1);
 	init_completion(&hr_qp->free);
 
-	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
-
 	return 0;
 
 err_store:
@@ -987,8 +1034,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 err_qpn:
 	free_qpn(hr_dev, hr_qp);
 
-err_mtr:
-	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
+err_buf:
+	free_qp_buf(hr_dev, hr_qp);
 
 err_wrid:
 	if (udata) {
@@ -1013,24 +1060,11 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	if (!udata)
 		kfree(hr_qp->sq.wrid);
 
-err_get_bufs:
-	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
-
-err_alloc_list:
-	if (!hr_qp->umem)
-		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
-	ib_umem_release(hr_qp->umem);
-
 err_db:
 	if (!udata && hns_roce_qp_has_rq(init_attr) &&
 	    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
 		hns_roce_free_db(hr_dev, &hr_qp->rdb);
 
-err_alloc_rq_inline_buf:
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	     hns_roce_qp_has_rq(init_attr))
-		free_rq_inline_buf(hr_qp);
-
 err_out:
 	return ret;
 }
@@ -1046,7 +1080,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	free_qpn(hr_dev, hr_qp);
 
-	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
+	free_qp_buf(hr_dev, hr_qp);
 
 	if (udata) {
 		struct hns_roce_ucontext *context =
@@ -1063,17 +1097,9 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	} else {
 		kfree(hr_qp->sq.wrid);
 		kfree(hr_qp->rq.wrid);
-		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
 		if (hr_qp->rq.wqe_cnt)
 			hns_roce_free_db(hr_dev, &hr_qp->rdb);
 	}
-	ib_umem_release(hr_qp->umem);
-
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	     hr_qp->rq.wqe_cnt) {
-		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
-		kfree(hr_qp->rq_inl_buf.wqe_list);
-	}
 
 	kfree(hr_qp);
 }
-- 
2.8.1

