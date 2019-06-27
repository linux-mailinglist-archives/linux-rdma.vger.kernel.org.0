Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEF5840A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0OAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:00:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36388 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbfF0OAX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 10:00:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDtYp9002054;
        Thu, 27 Jun 2019 07:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=bbkAQyexr0bHkcmWPxF0kM2Frw7KvUWP+MsFMb1Gs8Q=;
 b=iSVoaCWjJ8TsyPs768hYm43wmPW9n9g4ktMaMSP12GOPF+TyZ6Bs+4FGup3sdwV/yJ5W
 hwdYjOm6U8btYi35J1vSz5hjwtNM8wzveJxaUn53HsXYCTRcCymMHswQEmSzakkR/rRL
 gTmE7w2VSMlLNtwNRwawpJz54Ly1lDX9CKuI5J5/pMeMTq1dK6DnHuEUJYKlk+dmPGx8
 GkON+FjAeXuiT7f14cYLjTa3jxgide5uITFI86jvN6OGHuG7Sd0sRQw1Oy6Pceuv2eXb
 0b1N1DisciHcbH3Tv6lYc/NORhV+xIQ4RREtaVBLrrvnUqmGEtOHov4O3ZBLsXBkjXLH pg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tcvnh8k56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 07:00:01 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 27 Jun
 2019 06:59:56 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 27 Jun 2019 06:59:56 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id CD7933F703F;
        Thu, 27 Jun 2019 06:59:54 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <galpress@amazon.com>, <jgg@ziepe.ca>, <dledford@redhat.com>,
        <leon@kernel.org>, <sleybo@amazon.com>,
        <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Date:   Thu, 27 Jun 2019 16:58:23 +0300
Message-ID: <20190627135825.4924-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190627135825.4924-1-michal.kalderon@marvell.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_07:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Create a common API for adding entries to a xa_mmap.
This API can be used by drivers that don't require special
mapping for user mapped memory.

The code was copied from the efa driver almost as is, just renamed
function to be generic and not efa specific.

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/core/rdma_core.c   |   1 +
 drivers/infiniband/core/uverbs_cmd.c  |   1 +
 drivers/infiniband/core/uverbs_main.c | 177 ++++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h               |  29 ++++++
 4 files changed, 208 insertions(+)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index ccf4d069c25c..7166741834c8 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	rdma_restrack_del(&ucontext->res);
 
 	ib_dev->ops.dealloc_ucontext(ucontext);
+	rdma_user_mmap_entries_remove_free(ucontext);
 	kfree(ucontext);
 
 	ufile->ucontext = NULL;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 911533081db5..53cd38e4c509 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -243,6 +243,7 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 
 	mutex_init(&ucontext->per_mm_list_lock);
 	INIT_LIST_HEAD(&ucontext->per_mm_list);
+	xa_init(&ucontext->mmap_xa);
 
 	ret = get_unused_fd_flags(O_CLOEXEC);
 	if (ret < 0)
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 11c13c1381cf..e7ba855e137b 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -932,6 +932,18 @@ static const struct vm_operations_struct rdma_umap_ops = {
  * their mmap() functions if they wish to send something like PCI-E BAR memory
  * to userspace.
  */
+
+struct rdma_user_mmap_entry {
+	void  *obj;
+	u64 address;
+	u64 length;
+	u32 mmap_page;
+	u8 mmap_flag;
+};
+
+#define RDMA_USER_MMAP_FLAG_SHIFT 56
+#define RDMA_USER_MMAP_PAGE_MASK GENMASK(RDMA_USER_MMAP_FLAG_SHIFT - 1, 0)
+
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot)
 {
@@ -965,6 +977,171 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(rdma_user_mmap_io);
 
+static inline u64
+rdma_user_mmap_get_key(const struct rdma_user_mmap_entry *entry)
+{
+	return ((u64)entry->mmap_flag << RDMA_USER_MMAP_FLAG_SHIFT) |
+	       ((u64)entry->mmap_page << PAGE_SHIFT);
+}
+
+static struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key, u64 len)
+{
+	struct rdma_user_mmap_entry *entry;
+	u64 mmap_page;
+
+	mmap_page = (key & RDMA_USER_MMAP_PAGE_MASK) >> PAGE_SHIFT;
+	if (mmap_page > U32_MAX)
+		return NULL;
+
+	entry = xa_load(&ucontext->mmap_xa, mmap_page);
+	if (!entry || rdma_user_mmap_get_key(entry) != key ||
+	    entry->length != len)
+		return NULL;
+
+	ibdev_dbg(ucontext->device,
+		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
+		  entry->obj, key, entry->address, entry->length);
+
+	return entry;
+}
+
+/*
+ * Note this locking scheme cannot support removal of entries, except during
+ * ucontext destruction when the core code guarentees no concurrency.
+ */
+u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
+				u64 address, u64 length, u8 mmap_flag)
+{
+	struct rdma_user_mmap_entry *entry;
+	int err;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return RDMA_USER_MMAP_INVALID;
+
+	entry->obj = obj;
+	entry->address = address;
+	entry->length = length;
+	entry->mmap_flag = mmap_flag;
+
+	xa_lock(&ucontext->mmap_xa);
+	entry->mmap_page = ucontext->mmap_xa_page;
+	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
+	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
+			  GFP_KERNEL);
+	xa_unlock(&ucontext->mmap_xa);
+	if (err) {
+		kfree(entry);
+		return RDMA_USER_MMAP_INVALID;
+	}
+
+	ibdev_dbg(ucontext->device,
+		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
+		  entry->obj, entry->address, entry->length,
+		  rdma_user_mmap_get_key(entry));
+
+	return rdma_user_mmap_get_key(entry);
+}
+EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
+/*
+ * This is only called when the ucontext is destroyed and there can be no
+ * concurrent query via mmap or allocate on the xarray, thus we can be sure no
+ * other thread is using the entry pointer. We also know that all the BAR
+ * pages have either been zap'd or munmaped at this point.  Normal pages are
+ * refcounted and will be freed at the proper time.
+ */
+void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext)
+{
+	struct rdma_user_mmap_entry *entry;
+	unsigned long mmap_page;
+
+	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
+		xa_erase(&ucontext->mmap_xa, mmap_page);
+
+		ibdev_dbg(ucontext->device,
+			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
+			  entry->obj, rdma_user_mmap_get_key(entry),
+			  entry->address, entry->length);
+		if (entry->mmap_flag == RDMA_USER_MMAP_DMA_PAGE)
+			/* DMA mapping is already gone, now free the pages */
+			free_pages_exact(phys_to_virt(entry->address),
+					 entry->length);
+		kfree(entry);
+	}
+}
+
+int rdma_user_mmap(struct ib_ucontext *ucontext,
+		   struct vm_area_struct *vma)
+{
+	u64 length = vma->vm_end - vma->vm_start;
+	u64 key = vma->vm_pgoff << PAGE_SHIFT;
+	struct rdma_user_mmap_entry *entry;
+	unsigned long va;
+	u64 pfn;
+	int err;
+
+	ibdev_dbg(ucontext->device,
+		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
+		  vma->vm_start, vma->vm_end, length, key);
+
+	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
+		ibdev_dbg(ucontext->device,
+			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
+			  length, PAGE_SIZE, vma->vm_flags);
+		return -EINVAL;
+	}
+
+	if (vma->vm_flags & VM_EXEC) {
+		ibdev_dbg(ucontext->device, "Mapping executable pages is not permitted\n");
+		return -EPERM;
+	}
+	vma->vm_flags &= ~VM_MAYEXEC;
+
+	entry = rdma_user_mmap_entry_get(ucontext, key, length);
+	if (!entry) {
+		ibdev_dbg(ucontext->device, "key[%#llx] does not have valid entry\n",
+			  key);
+		return -EINVAL;
+	}
+
+	ibdev_dbg(ucontext->device,
+		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
+		  entry->address, length, entry->mmap_flag);
+
+	pfn = entry->address >> PAGE_SHIFT;
+	switch (entry->mmap_flag) {
+	case RDMA_USER_MMAP_IO_NC:
+		err = rdma_user_mmap_io(ucontext, vma, pfn, length,
+					pgprot_noncached(vma->vm_page_prot));
+		break;
+	case RDMA_USER_MMAP_IO_WC:
+		err = rdma_user_mmap_io(ucontext, vma, pfn, length,
+					pgprot_writecombine(vma->vm_page_prot));
+		break;
+	case RDMA_USER_MMAP_DMA_PAGE:
+		for (va = vma->vm_start; va < vma->vm_end;
+		     va += PAGE_SIZE, pfn++) {
+			err = vm_insert_page(vma, va, pfn_to_page(pfn));
+			if (err)
+				break;
+		}
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (err) {
+		ibdev_dbg(ucontext->device,
+			  "Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
+			  entry->address, length, entry->mmap_flag, err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_user_mmap);
+
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 {
 	struct rdma_umap_priv *priv, *next_priv;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e2478b74551d..5856cc6fa3bc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1425,6 +1425,8 @@ struct ib_ucontext {
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
 	struct rdma_restrack_entry res;
+	struct xarray mmap_xa;
+	u32 mmap_xa_page;
 };
 
 struct ib_uobject {
@@ -2705,10 +2707,28 @@ void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 void ib_set_device_ops(struct ib_device *device,
 		       const struct ib_device_ops *ops);
 
+#define RDMA_USER_MMAP_INVALID U64_MAX
+enum {
+	RDMA_USER_MMAP_DMA_PAGE = 0,
+	RDMA_USER_MMAP_IO_WC,
+	RDMA_USER_MMAP_IO_NC,
+};
+
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+int rdma_user_mmap(struct ib_ucontext *ibucontext,
+		   struct vm_area_struct *vma);
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot);
+u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
+				u64 address, u64 length, u8 mmap_flag);
+void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext);
 #else
+static int rdma_user_mmap(struct ib_ucontext *ibucontext,
+			  struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
 static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
 				    struct vm_area_struct *vma,
 				    unsigned long pfn, unsigned long size,
@@ -2716,6 +2736,15 @@ static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
 {
 	return -EINVAL;
 }
+
+u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
+				u64 address, u64 length, u8 mmap_flag)
+{
+	return RDMA_USER_MMAP_INVALID;
+}
+
+static void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext) {}
+
 #endif
 
 static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
-- 
2.14.5

