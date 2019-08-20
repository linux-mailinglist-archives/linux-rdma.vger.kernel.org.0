Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC69D95E44
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfHTMUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 08:20:55 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3090 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTMUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 08:20:54 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KCA3Ze030599;
        Tue, 20 Aug 2019 05:20:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=CVrjg3a2ni8mXMJC4hx2t8FPfF1w/oneoYxAPmpRCUI=;
 b=wYaeWgvfkPYc7w8KG/qNQsJ8kFT5IVq5+gv2S6O6BriTIVSFXKC4cLSHFl+95MDtjkH4
 +eC2DTEqy6FbwPs3Hy4XuFAXn9ScoJ4RkZCHzgaYrBp0oHJ2SXmzg7hA8LfmSIuKRKG6
 eZga+CCb1As8cw1kTLNEZ6qjSz8fYO1zTPrJE9Fzy3YfhYkl4mm3CTbwoX2rh1VdBeQ1
 aUI5rNOc4kLJbM4VOnWC35cPih6Rtucq/9eKFr9VpSRBYZGXmK5CO0kDpc2M2mm2eAuE
 mBeQDIxZpx+7h+9UriquHDNVaQ2i/ZtpH1fnYPPtcsfmDDsg+kUkexIyPLM/c6Y5s1T5 fw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ug8d79m9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 05:20:45 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 05:20:43 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 20 Aug 2019 05:20:43 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 6F41D3F7040;
        Tue, 20 Aug 2019 05:20:40 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and cookie helper functions
Date:   Tue, 20 Aug 2019 15:18:42 +0300
Message-ID: <20190820121847.25871-3-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190820121847.25871-1-michal.kalderon@marvell.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_04:2019-08-19,2019-08-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Create some common API's for adding entries to a xa_mmap.
Searching for an entry and freeing one.

Most of the code was copied from the efa driver almost as is, just renamed
function to be generic and not efa specific.
In addition to original code, the xa_mmap entries are now linked
to a umap_priv object and reference counted according to umap operations.
The fact that this code moved to core enabled managing it differently,
so that now entries can be removed and deleted when driver+user are
done with them. This enabled changing the insert algorithm in
comparison to what was done in efa.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/core/core_priv.h      |  12 +-
 drivers/infiniband/core/device.c         |   1 +
 drivers/infiniband/core/ib_core_uverbs.c | 343 +++++++++++++++++++++++++++++--
 drivers/infiniband/core/rdma_core.c      |   1 +
 drivers/infiniband/core/uverbs_cmd.c     |   1 +
 drivers/infiniband/core/uverbs_main.c    |  18 +-
 include/rdma/ib_verbs.h                  |  41 +++-
 7 files changed, 381 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 6850e973401c..4951ecfbf133 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -388,9 +388,17 @@ void rdma_nl_net_exit(struct rdma_dev_net *rnet);
 struct rdma_umap_priv {
 	struct vm_area_struct *vma;
 	struct list_head list;
+	struct rdma_user_mmap_entry *entry;
 };
 
-void rdma_umap_priv_init(struct rdma_umap_priv *priv,
-			 struct vm_area_struct *vma);
+int rdma_umap_priv_init(struct vm_area_struct *vma,
+			struct rdma_user_mmap_entry *entry);
+
+void rdma_umap_priv_delete(struct ib_uverbs_file *ufile,
+			   struct rdma_umap_priv *priv);
+
+void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext);
+void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
+			      struct rdma_user_mmap_entry *entry);
 
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8892862fb759..229977237d1a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2594,6 +2594,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, map_mr_sg_pi);
 	SET_DEVICE_OP(dev_ops, map_phys_fmr);
 	SET_DEVICE_OP(dev_ops, mmap);
+	SET_DEVICE_OP(dev_ops, mmap_free);
 	SET_DEVICE_OP(dev_ops, modify_ah);
 	SET_DEVICE_OP(dev_ops, modify_cq);
 	SET_DEVICE_OP(dev_ops, modify_device);
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index cab7dc922cf0..cce20172cd71 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -36,41 +36,98 @@
 #include "uverbs.h"
 #include "core_priv.h"
 
-/*
- * Each time we map IO memory into user space this keeps track of the mapping.
- * When the device is hot-unplugged we 'zap' the mmaps in user space to point
- * to the zero page and allow the hot unplug to proceed.
+/**
+ * rdma_umap_priv_init() - Initialize the private data of a vma
+ *
+ * @vma: The vm area struct that needs private data
+ * @entry: entry into the mmap_xa that needs to be linked with
+ *       this vma
+ *
+ * Each time we map IO memory into user space this keeps track
+ * of the mapping. When the device is hot-unplugged we 'zap' the
+ * mmaps in user space to point to the zero page and allow the
+ * hot unplug to proceed.
  *
  * This is necessary for cases like PCI physical hot unplug as the actual BAR
  * memory may vanish after this and access to it from userspace could MCE.
  *
  * RDMA drivers supporting disassociation must have their user space designed
  * to cope in some way with their IO pages going to the zero page.
+ *
+ * We extended the umap list usage to track all memory that was mapped by
+ * user space and not only the IO memory. This will occur for drivers that use
+ * the mmap_xa database and helper functions
+ *
+ * Return 0 on success or -ENOMEM if out of memory
  */
-void rdma_umap_priv_init(struct rdma_umap_priv *priv,
-			 struct vm_area_struct *vma)
+int rdma_umap_priv_init(struct vm_area_struct *vma,
+			struct rdma_user_mmap_entry *entry)
 {
 	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
+	struct rdma_umap_priv *priv;
+
+	/* If the xa_mmap is used, private data will already be initialized.
+	 * this is required for the cases that rdma_user_mmap_io is called
+	 * from drivers that don't use the xa_mmap database yet
+	 */
+	if (vma->vm_private_data)
+		return 0;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	priv->vma = vma;
+	priv->entry = entry;
 	vma->vm_private_data = priv;
 
 	mutex_lock(&ufile->umap_lock);
 	list_add(&priv->list, &ufile->umaps);
 	mutex_unlock(&ufile->umap_lock);
+
+	return 0;
 }
 EXPORT_SYMBOL(rdma_umap_priv_init);
 
-/*
- * Map IO memory into a process. This is to be called by drivers as part of
- * their mmap() functions if they wish to send something like PCI-E BAR memory
- * to userspace.
+/**
+ * rdma_umap_priv_delete() - Delete an entry from the umaps list
+ *
+ * @ufile: associated user file:
+ * @priv:  private data allocated and stored in
+ *      rdma_umap_priv_init
+ *
+ */
+void rdma_umap_priv_delete(struct ib_uverbs_file *ufile,
+			   struct rdma_umap_priv *priv)
+{
+	mutex_lock(&ufile->umap_lock);
+	list_del(&priv->list);
+	mutex_unlock(&ufile->umap_lock);
+	kfree(priv);
+}
+EXPORT_SYMBOL(rdma_umap_priv_delete);
+
+/**
+ * rdma_user_mmap_io() - Map IO memory into a process.
+ *
+ * @ucontext: associated user context
+ * @vma: the vma related to the current mmap call.
+ * @pfn: pfn to map
+ * @size: size to map
+ * @prot: pgprot to use in remap call
+ *
+ * This is to be called by drivers as part of their mmap()
+ * functions if they wish to send something like PCI-E BAR
+ * memory to userspace.
+ *
+ * Return -EINVAL on wrong flags or size, -EAGAIN on failure to
+ * map. 0 on success.
  */
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	struct ib_uverbs_file *ufile = ucontext->ufile;
-	struct rdma_umap_priv *priv;
+	int ret;
 
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
@@ -84,17 +141,271 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		return -EINVAL;
 	lockdep_assert_held(&ufile->device->disassociate_srcu);
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	ret = rdma_umap_priv_init(vma, NULL);
+	if (ret)
+		return ret;
 
 	vma->vm_page_prot = prot;
 	if (io_remap_pfn_range(vma, vma->vm_start, pfn, size, prot)) {
-		kfree(priv);
+		rdma_umap_priv_delete(ufile, vma->vm_private_data);
 		return -EAGAIN;
 	}
 
-	rdma_umap_priv_init(priv, vma);
 	return 0;
 }
 EXPORT_SYMBOL(rdma_user_mmap_io);
+
+static inline u64
+rdma_user_mmap_get_key(const struct rdma_user_mmap_entry *entry)
+{
+	return (u64)entry->mmap_page << PAGE_SHIFT;
+}
+
+/**
+ * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa.
+ *
+ * @ucontext: associated user context.
+ * @key: The key received from rdma_user_mmap_entry_insert which
+ *     is provided by user as the address to map.
+ * @len: The length the user wants to map.
+ * @vma: the vma related to the current mmap call.
+ *
+ * This function is called when a user tries to mmap a key it
+ * initially received from the driver. The key was created by
+ * the function rdma_user_mmap_entry_insert. The function should
+ * be called only once per mmap. It initializes the vma and
+ * increases the entries ref-count. Once the memory is unmapped
+ * the ref-count will decrease. When the refcount reaches zero
+ * the entry will be deleted.
+ *
+ * Return an entry if exists or NULL if there is no match.
+ */
+struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key, u64 len,
+			 struct vm_area_struct *vma)
+{
+	struct rdma_user_mmap_entry *entry;
+	u64 mmap_page;
+
+	mmap_page = key >> PAGE_SHIFT;
+	if (mmap_page > U32_MAX)
+		return NULL;
+
+	entry = xa_load(&ucontext->mmap_xa, mmap_page);
+	if (!entry || entry->length != len)
+		return NULL;
+
+	kref_get(&entry->ref);
+	rdma_umap_priv_init(vma, entry);
+
+	ibdev_dbg(ucontext->device,
+		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] returned\n",
+		  entry->obj, key, entry->address, entry->length);
+
+	return entry;
+}
+EXPORT_SYMBOL(rdma_user_mmap_entry_get);
+
+void rdma_user_mmap_entry_free(struct kref *kref)
+{
+	struct rdma_user_mmap_entry *entry =
+		container_of(kref, struct rdma_user_mmap_entry, ref);
+	unsigned long i, npages = (u32)DIV_ROUND_UP(entry->length, PAGE_SIZE);
+	struct ib_ucontext *ucontext = entry->ucontext;
+
+	/* need to erase all entries occupied... */
+	for (i = 0; i < npages; i++) {
+		xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);
+
+		ibdev_dbg(ucontext->device,
+			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] npages[%#lx] removed\n",
+			  entry->obj, rdma_user_mmap_get_key(entry),
+			  entry->address, entry->length, npages);
+
+		if (ucontext->device->ops.mmap_free)
+			ucontext->device->ops.mmap_free(entry);
+	}
+	kfree(entry);
+}
+
+/**
+ * rdma_user_mmap_entry_put() - drop reference to the mmap entry
+ *
+ * @ucontext: associated user context.
+ * @entry: An entry in the mmap_xa.
+ *
+ * This function is called when the mapping is closed or when
+ * the driver is done with the entry for some other reason.
+ * Should be called after rdma_user_mmap_entry_get was called
+ * and entry is no longer needed. This function will erase the
+ * entry and free it if it's refcnt reaches zero.
+ */
+void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
+			      struct rdma_user_mmap_entry *entry)
+{
+	WARN_ON(!kref_read(&entry->ref));
+	kref_put(&entry->ref, rdma_user_mmap_entry_free);
+}
+EXPORT_SYMBOL(rdma_user_mmap_entry_put);
+
+/**
+ * rdma_user_mmap_entry_remove() - Remove a key's entry from the mmap_xa
+ *
+ * @ucontext: associated user context.
+ * @key: The key to be deleted
+ *
+ * This function will find if there is an entry matching the key and if so
+ * decrease it's refcnt, which will in turn delete the entry if its refcount
+ * reaches zero.
+ */
+void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext, u64 key)
+{
+	struct rdma_user_mmap_entry *entry;
+	u32 mmap_page;
+
+	if (key == RDMA_USER_MMAP_INVALID)
+		return;
+
+	mmap_page = key >> PAGE_SHIFT;
+	if (mmap_page > U32_MAX)
+		return;
+
+	entry = xa_load(&ucontext->mmap_xa, mmap_page);
+	if (!entry)
+		return;
+
+	rdma_user_mmap_entry_put(ucontext, entry);
+}
+EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
+
+/**
+ * rdma_user_mmap_entry_insert() - Allocate and insert an entry to the mmap_xa.
+ *
+ * @ucontext: associated user context.
+ * @obj: opaque driver object that will be stored in the entry.
+ * @address: The address that will be mmapped to the user
+ * @length: Length of the address that will be mmapped
+ * @mmap_flag: opaque driver flags related to the address (For
+ *           example could be used for cachability)
+ *
+ * This function should be called by drivers that use the rdma_user_mmap
+ * interface for handling user mmapped addresses. The database is handled in
+ * the core and helper functions are provided to insert entries into the
+ * database and extract entries when the user call mmap with the given key.
+ * The function returns a unique key that should be provided to user, the user
+ * will use the key to map the given address.
+ *
+ * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not added.
+ */
+u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
+				u64 address, u64 length, u8 mmap_flag)
+{
+	XA_STATE(xas, &ucontext->mmap_xa, 0);
+	struct rdma_user_mmap_entry *entry;
+	unsigned long index = 0, index_max;
+	u32 xa_first, xa_last, npages;
+	int err, i;
+	void *ent;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return RDMA_USER_MMAP_INVALID;
+
+	entry->obj = obj;
+	entry->address = address;
+	entry->length = length;
+	kref_init(&entry->ref);
+	entry->mmap_flag = mmap_flag;
+	entry->ucontext = ucontext;
+
+	xa_lock(&ucontext->mmap_xa);
+
+	/* We want to find an empty range */
+	npages = (u32)DIV_ROUND_UP(length, PAGE_SIZE);
+	do {
+		/* First find an empty index */
+		xas_find_marked(&xas, U32_MAX, XA_FREE_MARK);
+		if (xas.xa_node == XAS_RESTART)
+			goto err_unlock;
+
+		xa_first = xas.xa_index;
+
+		/* Is there enough room to have the range? */
+		if (check_add_overflow(xa_first, npages, &xa_last))
+			goto err_unlock;
+
+		/* Iterate over all present entries in the range. If a present
+		 * entry exists we will finish this with the largest index
+		 * occupied in the range which will serve as the start of the
+		 * new search
+		 */
+		index_max = xa_last;
+		xa_for_each_start(&ucontext->mmap_xa, index, ent, xa_first)
+			if (index < xa_last)
+				index_max = index;
+			else
+				break;
+		if (index_max == xa_last) /* range is free */
+			break;
+		/* o/w start again from largest index found in range */
+		xas_set(&xas, index_max);
+	} while (true);
+
+	for (i = xa_first; i < xa_last; i++) {
+		err = __xa_insert(&ucontext->mmap_xa, i, entry, GFP_KERNEL);
+		if (err)
+			goto err_undo;
+	}
+
+	entry->mmap_page = xa_first;
+	xa_unlock(&ucontext->mmap_xa);
+
+	ibdev_dbg(ucontext->device,
+		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] npages[%#x] inserted\n",
+		  entry->obj, entry->address, entry->length,
+		  rdma_user_mmap_get_key(entry), npages);
+
+	return rdma_user_mmap_get_key(entry);
+
+err_undo:
+	for (; i > xa_first; i--)
+		__xa_erase(&ucontext->mmap_xa, i - 1);
+
+err_unlock:
+	xa_unlock(&ucontext->mmap_xa);
+	kfree(entry);
+	return RDMA_USER_MMAP_INVALID;
+}
+EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
+
+/**
+ * rdma_user_mmap_entries_remove_free() - Free remaining entries
+ * in mmap_xa.
+ *
+ * @ucontext: associated user context
+ *
+ * This is only called when the ucontext is destroyed and there
+ * can be no concurrent query via mmap or allocate on the
+ * xarray, thus we can be sure no other thread is using the
+ * entry pointer. We also know that all the BAR pages have
+ * either been zap'd or munmaped at this point. Normal pages are
+ * refcounted and will be freed at the proper time.
+ */
+void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext)
+{
+	struct rdma_user_mmap_entry *entry;
+	unsigned long mmap_page;
+
+	WARN_ON(!xa_empty(&ucontext->mmap_xa));
+	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
+		ibdev_dbg(ucontext->device,
+			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
+			  entry->obj, rdma_user_mmap_get_key(entry),
+			  entry->address, entry->length);
+
+		/* override the refcnt to make sure entry is deleted */
+		kref_init(&entry->ref);
+		rdma_user_mmap_entry_put(ucontext, entry);
+	}
+}
+EXPORT_SYMBOL(rdma_user_mmap_entries_remove_free);
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
index 7ddd0e5bc6b3..4903e6eee854 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -254,6 +254,7 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 
 	mutex_init(&ucontext->per_mm_list_lock);
 	INIT_LIST_HEAD(&ucontext->per_mm_list);
+	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
 
 	ret = get_unused_fd_flags(O_CLOEXEC);
 	if (ret < 0)
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 180a5e0f70e4..80d0d3467d93 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -802,7 +802,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 {
 	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
 	struct rdma_umap_priv *opriv = vma->vm_private_data;
-	struct rdma_umap_priv *priv;
+	int ret;
 
 	if (!opriv)
 		return;
@@ -816,10 +816,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 	if (!ufile->ucontext)
 		goto out_unlock;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	if (opriv->entry)
+		kref_get(&opriv->entry->ref);
+
+	ret = rdma_umap_priv_init(vma, opriv->entry);
+	if (ret)
 		goto out_unlock;
-	rdma_umap_priv_init(priv, vma);
 
 	up_read(&ufile->hw_destroy_rwsem);
 	return;
@@ -844,15 +846,15 @@ static void rdma_umap_close(struct vm_area_struct *vma)
 	if (!priv)
 		return;
 
+	if (priv->entry)
+		rdma_user_mmap_entry_put(ufile->ucontext, priv->entry);
+
 	/*
 	 * The vma holds a reference on the struct file that created it, which
 	 * in turn means that the ib_uverbs_file is guaranteed to exist at
 	 * this point.
 	 */
-	mutex_lock(&ufile->umap_lock);
-	list_del(&priv->list);
-	mutex_unlock(&ufile->umap_lock);
-	kfree(priv);
+	rdma_umap_priv_delete(ufile, priv);
 }
 
 /*
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 391499008a22..b66c197a7079 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1479,6 +1479,7 @@ struct ib_ucontext {
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
 	struct rdma_restrack_entry res;
+	struct xarray mmap_xa;
 };
 
 struct ib_uobject {
@@ -2259,6 +2260,19 @@ struct iw_cm_conn_param;
 
 #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
 
+#define RDMA_USER_MMAP_FLAG_SHIFT 56
+#define RDMA_USER_MMAP_PAGE_MASK GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)
+#define RDMA_USER_MMAP_INVALID U64_MAX
+struct rdma_user_mmap_entry {
+	struct kref ref;
+	struct ib_ucontext *ucontext;
+	void *obj;
+	u64 address;
+	u64 length;
+	u32 mmap_page;
+	u8 mmap_flag;
+};
+
 /**
  * struct ib_device_ops - InfiniBand device operations
  * This structure defines all the InfiniBand device operations, providers will
@@ -2371,6 +2385,13 @@ struct ib_device_ops {
 			      struct ib_udata *udata);
 	void (*dealloc_ucontext)(struct ib_ucontext *context);
 	int (*mmap)(struct ib_ucontext *context, struct vm_area_struct *vma);
+	/**
+	 * This will be called once refcount of an entry in mmap_xa reaches
+	 * zero. The type of the memory that was mapped may differ between
+	 * entries and is opaque to the rdma_user_mmap interface.
+	 * Therefore needs to be implemented by the driver in mmap_free.
+	 */
+	void (*mmap_free)(struct rdma_user_mmap_entry *entry);
 	void (*disassociate_ucontext)(struct ib_ucontext *ibcontext);
 	int (*alloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
 	void (*dealloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
@@ -2793,18 +2814,18 @@ void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 void ib_set_device_ops(struct ib_device *device,
 		       const struct ib_device_ops *ops);
 
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot);
-#else
-static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
-				    struct vm_area_struct *vma,
-				    unsigned long pfn, unsigned long size,
-				    pgprot_t prot)
-{
-	return -EINVAL;
-}
-#endif
+u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
+				u64 address, u64 length, u8 mmap_flag);
+struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key, u64 len,
+			 struct vm_area_struct *vma);
+
+void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
+			      struct rdma_user_mmap_entry *entry);
+
+void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext, u64 key);
 
 static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
 {
-- 
2.14.5

