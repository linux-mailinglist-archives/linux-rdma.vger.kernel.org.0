Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03AE9E963
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfH0Nbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:31:37 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46000 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfH0Nbh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 09:31:37 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RDU4p3025031;
        Tue, 27 Aug 2019 06:31:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=1OLv64ILyQPn1rMl5k7fKEkeI8Sjy5wo6zzwITVjZvQ=;
 b=Gr8y2pFIKzjtBoHPLGb9CXWg5lhGmqJ3nUQe1Nqggz0UCNQod2oyTBExCDQGkPV04AlR
 J7kMGw2VfYhwxNE8bE3c+bqOO6m9peFQzX6tJFi/5TyITjMa2loRmZXJesGd4z0aFjZ+
 tJEGW9isle52784987jvQplcINYnqEQY/9EU77Ddgjh40j3Zxt0olnEACkRo/JddOIeD
 FSrhWwrdllr/ioinMdKaVxsuu5avrwWehUhM3PgggAKC9mm7yY3u2zHWv8gw6kapRHDM
 kbWcotDQ3vfFFucCzfyER+8G0LQLkvsnVrk0mD4i15Zi1sDwGeePjwqSwNI6vvKsHl6A Pw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uk2kq3kp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 06:31:32 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 27 Aug
 2019 06:31:31 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 27 Aug 2019 06:31:31 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 36C6E3F7045;
        Tue, 27 Aug 2019 06:31:28 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v8 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
Date:   Tue, 27 Aug 2019 16:28:42 +0300
Message-ID: <20190827132846.9142-4-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190827132846.9142-1-michal.kalderon@marvell.com>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_02:2019-08-27,2019-08-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the functions related to managing the mmap_xa database.
This code was copied to the ib_core. Use the common API's instead.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/efa/efa.h       |  18 +-
 drivers/infiniband/hw/efa/efa_main.c  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c | 339 +++++++++++++++++-----------------
 3 files changed, 185 insertions(+), 173 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 2283e432693e..148ff5b86746 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -71,8 +71,6 @@ struct efa_dev {
 
 struct efa_ucontext {
 	struct ib_ucontext ibucontext;
-	struct xarray mmap_xa;
-	u32 mmap_xa_page;
 	u16 uarn;
 };
 
@@ -91,6 +89,7 @@ struct efa_cq {
 	struct efa_ucontext *ucontext;
 	dma_addr_t dma_addr;
 	void *cpu_addr;
+	u64 mmap_key;
 	size_t size;
 	u16 cq_idx;
 };
@@ -101,6 +100,13 @@ struct efa_qp {
 	void *rq_cpu_addr;
 	size_t rq_size;
 	enum ib_qp_state state;
+
+	/* Used for saving mmap_xa entries */
+	u64 sq_db_mmap_key;
+	u64 llq_desc_mmap_key;
+	u64 rq_db_mmap_key;
+	u64 rq_mmap_key;
+
 	u32 qp_handle;
 	u32 max_send_wr;
 	u32 max_recv_wr;
@@ -116,6 +122,13 @@ struct efa_ah {
 	u8 id[EFA_GID_SIZE];
 };
 
+struct efa_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u64 address;
+	u64 length;
+	u8 mmap_flag;
+};
+
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata);
@@ -147,6 +160,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata);
 void efa_dealloc_ucontext(struct ib_ucontext *ibucontext);
 int efa_mmap(struct ib_ucontext *ibucontext,
 	     struct vm_area_struct *vma);
+void efa_mmap_free(struct rdma_user_mmap_entry *entry);
 int efa_create_ah(struct ib_ah *ibah,
 		  struct rdma_ah_attr *ah_attr,
 		  u32 flags,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 83858f7e83d0..0e3050d01b75 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -217,6 +217,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.get_link_layer = efa_port_link_layer,
 	.get_port_immutable = efa_get_port_immutable,
 	.mmap = efa_mmap,
+	.mmap_free = efa_mmap_free,
 	.modify_qp = efa_modify_qp,
 	.query_device = efa_query_device,
 	.query_gid = efa_query_gid,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 70851bd7f801..dde276acbd00 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -13,10 +13,6 @@
 
 #include "efa.h"
 
-#define EFA_MMAP_FLAG_SHIFT 56
-#define EFA_MMAP_PAGE_MASK GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)
-#define EFA_MMAP_INVALID U64_MAX
-
 enum {
 	EFA_MMAP_DMA_PAGE = 0,
 	EFA_MMAP_IO_WC,
@@ -27,20 +23,6 @@ enum {
 	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
 	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
 
-struct efa_mmap_entry {
-	void  *obj;
-	u64 address;
-	u64 length;
-	u32 mmap_page;
-	u8 mmap_flag;
-};
-
-static inline u64 get_mmap_key(const struct efa_mmap_entry *efa)
-{
-	return ((u64)efa->mmap_flag << EFA_MMAP_FLAG_SHIFT) |
-	       ((u64)efa->mmap_page << PAGE_SHIFT);
-}
-
 #define EFA_DEFINE_STATS(op) \
 	op(EFA_TX_BYTES, "tx_bytes") \
 	op(EFA_TX_PKTS, "tx_pkts") \
@@ -147,6 +129,12 @@ static inline struct efa_ah *to_eah(struct ib_ah *ibah)
 	return container_of(ibah, struct efa_ah, ibah);
 }
 
+static inline struct efa_user_mmap_entry *
+to_emmap(struct rdma_user_mmap_entry *rdma_mmap)
+{
+	return container_of(rdma_mmap, struct efa_user_mmap_entry, rdma_entry);
+}
+
 #define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
 				 sizeof(((typeof(x) *)0)->fld) <= (sz))
 
@@ -172,106 +160,6 @@ static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
 	return addr;
 }
 
-/*
- * This is only called when the ucontext is destroyed and there can be no
- * concurrent query via mmap or allocate on the xarray, thus we can be sure no
- * other thread is using the entry pointer. We also know that all the BAR
- * pages have either been zap'd or munmaped at this point.  Normal pages are
- * refcounted and will be freed at the proper time.
- */
-static void mmap_entries_remove_free(struct efa_dev *dev,
-				     struct efa_ucontext *ucontext)
-{
-	struct efa_mmap_entry *entry;
-	unsigned long mmap_page;
-
-	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
-		xa_erase(&ucontext->mmap_xa, mmap_page);
-
-		ibdev_dbg(
-			&dev->ibdev,
-			"mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
-			entry->obj, get_mmap_key(entry), entry->address,
-			entry->length);
-		if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
-			/* DMA mapping is already gone, now free the pages */
-			free_pages_exact(phys_to_virt(entry->address),
-					 entry->length);
-		kfree(entry);
-	}
-}
-
-static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
-					     struct efa_ucontext *ucontext,
-					     u64 key, u64 len)
-{
-	struct efa_mmap_entry *entry;
-	u64 mmap_page;
-
-	mmap_page = (key & EFA_MMAP_PAGE_MASK) >> PAGE_SHIFT;
-	if (mmap_page > U32_MAX)
-		return NULL;
-
-	entry = xa_load(&ucontext->mmap_xa, mmap_page);
-	if (!entry || get_mmap_key(entry) != key || entry->length != len)
-		return NULL;
-
-	ibdev_dbg(&dev->ibdev,
-		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
-		  entry->obj, key, entry->address, entry->length);
-
-	return entry;
-}
-
-/*
- * Note this locking scheme cannot support removal of entries, except during
- * ucontext destruction when the core code guarentees no concurrency.
- */
-static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
-			     void *obj, u64 address, u64 length, u8 mmap_flag)
-{
-	struct efa_mmap_entry *entry;
-	u32 next_mmap_page;
-	int err;
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return EFA_MMAP_INVALID;
-
-	entry->obj = obj;
-	entry->address = address;
-	entry->length = length;
-	entry->mmap_flag = mmap_flag;
-
-	xa_lock(&ucontext->mmap_xa);
-	if (check_add_overflow(ucontext->mmap_xa_page,
-			       (u32)(length >> PAGE_SHIFT),
-			       &next_mmap_page))
-		goto err_unlock;
-
-	entry->mmap_page = ucontext->mmap_xa_page;
-	ucontext->mmap_xa_page = next_mmap_page;
-	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
-			  GFP_KERNEL);
-	if (err)
-		goto err_unlock;
-
-	xa_unlock(&ucontext->mmap_xa);
-
-	ibdev_dbg(
-		&dev->ibdev,
-		"mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
-		entry->obj, entry->address, entry->length, get_mmap_key(entry));
-
-	return get_mmap_key(entry);
-
-err_unlock:
-	xa_unlock(&ucontext->mmap_xa);
-	kfree(entry);
-	return EFA_MMAP_INVALID;
-
-}
-
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata)
@@ -485,13 +373,28 @@ static int efa_destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
 	return efa_com_destroy_qp(&dev->edev, &params);
 }
 
+static void efa_qp_user_mmap_entries_remove(struct efa_ucontext *ucontext,
+					    struct efa_qp *qp)
+{
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->sq_db_mmap_key);
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
+				    qp->llq_desc_mmap_key);
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->rq_mmap_key);
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->rq_db_mmap_key);
+}
+
 int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
+	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
+		struct efa_ucontext, ibucontext);
 	struct efa_dev *dev = to_edev(ibqp->pd->device);
 	struct efa_qp *qp = to_eqp(ibqp);
 	int err;
 
 	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
+
+	efa_qp_user_mmap_entries_remove(ucontext, qp);
+
 	err = efa_destroy_qp_handle(dev, qp->qp_handle);
 	if (err)
 		return err;
@@ -509,57 +412,114 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	return 0;
 }
 
+static int efa_user_mmap_entry_insert(struct ib_ucontext *ucontext,
+				      u64 address, u64 length,
+				      u8 mmap_flag, u64 *key)
+{
+	struct efa_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return -ENOMEM;
+
+	entry->address = address;
+	entry->length = length;
+	entry->mmap_flag = mmap_flag;
+
+	*key = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
+					   length);
+	if (*key == RDMA_USER_MMAP_INVALID) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void efa_qp_init_keys(struct efa_qp *qp)
+{
+	qp->sq_db_mmap_key = RDMA_USER_MMAP_INVALID;
+	qp->llq_desc_mmap_key = RDMA_USER_MMAP_INVALID;
+	qp->rq_db_mmap_key = RDMA_USER_MMAP_INVALID;
+	qp->rq_mmap_key = RDMA_USER_MMAP_INVALID;
+}
+
 static int qp_mmap_entries_setup(struct efa_qp *qp,
 				 struct efa_dev *dev,
 				 struct efa_ucontext *ucontext,
 				 struct efa_com_create_qp_params *params,
 				 struct efa_ibv_create_qp_resp *resp)
 {
-	/*
-	 * Once an entry is inserted it might be mmapped, hence cannot be
-	 * cleaned up until dealloc_ucontext.
-	 */
-	resp->sq_db_mmap_key =
-		mmap_entry_insert(dev, ucontext, qp,
-				  dev->db_bar_addr + resp->sq_db_offset,
-				  PAGE_SIZE, EFA_MMAP_IO_NC);
-	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
-		return -ENOMEM;
+	u64 address;
+	u64 length;
+	int err;
+
+	err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
+					 dev->db_bar_addr +
+					 resp->sq_db_offset,
+					 PAGE_SIZE, EFA_MMAP_IO_NC,
+					 &qp->sq_db_mmap_key);
+	if (err)
+		return err;
 
+	resp->sq_db_mmap_key = qp->sq_db_mmap_key;
 	resp->sq_db_offset &= ~PAGE_MASK;
 
-	resp->llq_desc_mmap_key =
-		mmap_entry_insert(dev, ucontext, qp,
-				  dev->mem_bar_addr + resp->llq_desc_offset,
-				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
-					     (resp->llq_desc_offset & ~PAGE_MASK)),
-				  EFA_MMAP_IO_WC);
-	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
-		return -ENOMEM;
+	address = dev->mem_bar_addr + resp->llq_desc_offset;
+	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
+			    (resp->llq_desc_offset & ~PAGE_MASK));
+
+	err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
+					 address,
+					 length,
+					 EFA_MMAP_IO_WC,
+					 &qp->llq_desc_mmap_key);
+	if (err)
+		goto err1;
 
+	resp->llq_desc_mmap_key = qp->llq_desc_mmap_key;
 	resp->llq_desc_offset &= ~PAGE_MASK;
 
 	if (qp->rq_size) {
-		resp->rq_db_mmap_key =
-			mmap_entry_insert(dev, ucontext, qp,
-					  dev->db_bar_addr + resp->rq_db_offset,
-					  PAGE_SIZE, EFA_MMAP_IO_NC);
-		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
-			return -ENOMEM;
+		address = dev->db_bar_addr + resp->rq_db_offset;
 
+		err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
+						 address, PAGE_SIZE,
+						 EFA_MMAP_IO_NC,
+						 &qp->rq_db_mmap_key);
+		if (err)
+			goto err2;
+
+		resp->rq_db_mmap_key = qp->rq_db_mmap_key;
 		resp->rq_db_offset &= ~PAGE_MASK;
 
-		resp->rq_mmap_key =
-			mmap_entry_insert(dev, ucontext, qp,
-					  virt_to_phys(qp->rq_cpu_addr),
-					  qp->rq_size, EFA_MMAP_DMA_PAGE);
-		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
-			return -ENOMEM;
+		address = virt_to_phys(qp->rq_cpu_addr);
+		err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
+						 address, qp->rq_size,
+						 EFA_MMAP_DMA_PAGE,
+						 &qp->rq_mmap_key);
+		if (err)
+			goto err3;
 
+		resp->rq_mmap_key = qp->rq_mmap_key;
 		resp->rq_mmap_size = qp->rq_size;
 	}
 
 	return 0;
+
+err3:
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->rq_db_mmap_key);
+
+err2:
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
+				    qp->llq_desc_mmap_key);
+
+err1:
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->sq_db_mmap_key);
+
+	/* If any error occurred, we init the keys back to invalid */
+	efa_qp_init_keys(qp);
+
+	return err;
 }
 
 static int efa_qp_validate_cap(struct efa_dev *dev,
@@ -634,7 +594,6 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_ibv_create_qp_resp resp = {};
 	struct efa_ibv_create_qp cmd = {};
-	bool rq_entry_inserted = false;
 	struct efa_ucontext *ucontext;
 	struct efa_qp *qp;
 	int err;
@@ -687,6 +646,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 		goto err_out;
 	}
 
+	efa_qp_init_keys(qp);
 	create_qp_params.uarn = ucontext->uarn;
 	create_qp_params.pd = to_epd(ibpd)->pdn;
 
@@ -742,7 +702,6 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 	if (err)
 		goto err_destroy_qp;
 
-	rq_entry_inserted = true;
 	qp->qp_handle = create_qp_resp.qp_handle;
 	qp->ibqp.qp_num = create_qp_resp.qp_num;
 	qp->ibqp.qp_type = init_attr->qp_type;
@@ -759,7 +718,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 			ibdev_dbg(&dev->ibdev,
 				  "Failed to copy udata for qp[%u]\n",
 				  create_qp_resp.qp_num);
-			goto err_destroy_qp;
+			goto err_remove_mmap_entries;
 		}
 	}
 
@@ -767,15 +726,17 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 
 	return &qp->ibqp;
 
+err_remove_mmap_entries:
+	efa_qp_user_mmap_entries_remove(ucontext, qp);
 err_destroy_qp:
 	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
 err_free_mapped:
-	if (qp->rq_size) {
+	if (qp->rq_dma_addr)
 		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
 				 DMA_TO_DEVICE);
-		if (!rq_entry_inserted)
-			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
-	}
+
+	if (qp->rq_mmap_key == RDMA_USER_MMAP_INVALID)
+		free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
 err_free_qp:
 	kfree(qp);
 err_out:
@@ -887,6 +848,7 @@ static int efa_destroy_cq_idx(struct efa_dev *dev, int cq_idx)
 
 void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
+	struct efa_ucontext *ucontext;
 	struct efa_dev *dev = to_edev(ibcq->device);
 	struct efa_cq *cq = to_ecq(ibcq);
 
@@ -894,20 +856,33 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
 
+	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
+					     ibucontext);
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
+				    cq->mmap_key);
 }
 
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 				 struct efa_ibv_create_cq_resp *resp)
 {
+	struct efa_ucontext *ucontext = cq->ucontext;
+	int err;
+
 	resp->q_mmap_size = cq->size;
-	resp->q_mmap_key = mmap_entry_insert(dev, cq->ucontext, cq,
-					     virt_to_phys(cq->cpu_addr),
-					     cq->size, EFA_MMAP_DMA_PAGE);
-	if (resp->q_mmap_key == EFA_MMAP_INVALID)
-		return -ENOMEM;
+
+	err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
+					 virt_to_phys(cq->cpu_addr),
+					 cq->size, EFA_MMAP_DMA_PAGE,
+					 &cq->mmap_key);
+	if (err) {
+		cq->mmap_key = RDMA_USER_MMAP_INVALID;
+		return err;
+	}
+
+	resp->q_mmap_key = cq->mmap_key;
 
 	return 0;
 }
@@ -924,7 +899,6 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_dev *dev = to_edev(ibdev);
 	struct efa_ibv_create_cq cmd = {};
 	struct efa_cq *cq = to_ecq(ibcq);
-	bool cq_entry_inserted = false;
 	int entries = attr->cqe;
 	int err;
 
@@ -1013,15 +987,13 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		goto err_destroy_cq;
 	}
 
-	cq_entry_inserted = true;
-
 	if (udata->outlen) {
 		err = ib_copy_to_udata(udata, &resp,
 				       min(sizeof(resp), udata->outlen));
 		if (err) {
 			ibdev_dbg(ibdev,
 				  "Failed to copy udata for create_cq\n");
-			goto err_destroy_cq;
+			goto err_remove_mmap;
 		}
 	}
 
@@ -1030,13 +1002,16 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	return 0;
 
+err_remove_mmap:
+	rdma_user_mmap_entry_remove(&ucontext->ibucontext, cq->mmap_key);
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
-	if (!cq_entry_inserted)
+	if (cq->mmap_key == RDMA_USER_MMAP_INVALID)
 		free_pages_exact(cq->cpu_addr, cq->size);
+
 err_out:
 	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
 	return err;
@@ -1558,7 +1533,6 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 		goto err_out;
 
 	ucontext->uarn = result.uarn;
-	xa_init(&ucontext->mmap_xa);
 
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
@@ -1587,28 +1561,47 @@ void efa_dealloc_ucontext(struct ib_ucontext *ibucontext)
 	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
 	struct efa_dev *dev = to_edev(ibucontext->device);
 
-	mmap_entries_remove_free(dev, ucontext);
 	efa_dealloc_uar(dev, ucontext->uarn);
 }
 
+void efa_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
+{
+	struct efa_user_mmap_entry *entry = to_emmap(rdma_entry);
+
+	/* DMA mapping is already gone, now free the pages */
+	if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
+		free_pages_exact(phys_to_virt(entry->address),
+				 entry->length);
+	kfree(entry);
+}
+
 static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		      struct vm_area_struct *vma, u64 key, u64 length)
 {
-	struct efa_mmap_entry *entry;
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct efa_user_mmap_entry *entry;
 	unsigned long va;
 	u64 pfn;
 	int err;
 
-	entry = mmap_entry_get(dev, ucontext, key, length);
-	if (!entry) {
+	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, key,
+					      length, vma);
+	if (!rdma_entry) {
 		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
 			  key);
 		return -EINVAL;
 	}
+	entry = to_emmap(rdma_entry);
+	if (entry->length != length) {
+		ibdev_dbg(&dev->ibdev,
+			  "key[%#llx] does not have valid length[%#llx] expected[%#llx]\n",
+			  key, length, entry->length);
+		return -EINVAL;
+	}
 
 	ibdev_dbg(&dev->ibdev,
 		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
-		  entry->address, length, entry->mmap_flag);
+		  entry->address, entry->length, entry->mmap_flag);
 
 	pfn = entry->address >> PAGE_SHIFT;
 	switch (entry->mmap_flag) {
@@ -1637,6 +1630,10 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 			&dev->ibdev,
 			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
 			entry->address, length, entry->mmap_flag, err);
+
+		rdma_user_mmap_entry_put(&ucontext->ibucontext,
+					 rdma_entry);
+
 		return err;
 	}
 
-- 
2.14.5

