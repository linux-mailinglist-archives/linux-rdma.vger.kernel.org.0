Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201E9F0724
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 21:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfKEUls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 15:41:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36970 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEUlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 15:41:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id e187so9768727qkf.4
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2019 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5HYv/S0pA0xlrqEWU8N9XxDenNY0rnEDu7baBPL/N0=;
        b=W9JLOvGL5b6r1aFDDL67eVZhbRPjUx2sFWVbV1UGndIlkFyenmgkpael9DPhlCEc5w
         ewd/ORJwgtkZlbIyKKB2jBEpspuSfBIJjHxbL3yq6u2kMhR9BKWFzRJTet8PSduWO1fy
         s0qzpHwTvSECzlSiqckrvjwOvX2K6Z5el1aChb0CbB29qTgJKMFvFPIElXlgtjb4NtqI
         pp5eINDceRrSlwfDqsdVDVNv3U92wqY2Elb5Dd8Q/omPU3P05smpQocu0Zr0LcalHO91
         ozm7LSGWGE2smv2cMSzuiAgkruQZbgPZHLkz7c2kMkED06OfPoFa7MvA2n6oqviODVSg
         2pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5HYv/S0pA0xlrqEWU8N9XxDenNY0rnEDu7baBPL/N0=;
        b=Ar/+joS8uoJNgc8BcVhKDw9cEE7KmbtQwqiqO7cu1uTObpPAgcA2Mk9PdBYZpV+BHN
         goBi+BU2vGICtifbgmHFfk4j4LuDB2OdeZs/Xho1ZysicREkt6q0Pw2p8+FGNBDoVIzm
         d01c4VegiF1GBDghHiADtnGiVgomQWJ0PjKq0WxmMpda/B/3lid8YGHWpB/+0yV/6EtC
         sceWf0VurP5U9mdXEyf6HLlZPxdQWtR2efgaDYZDLmasg7hDb0OJAFE/vRBKzqYX9+mK
         OAu+xyL2avWt/4FLlkEHJtPx6+buz0h/H0NvRArMbB8mA3GEsYk7W2Xj+gfDXbiKxbCD
         03pQ==
X-Gm-Message-State: APjAAAVPxFJe9U75y2cher/odODT4JLuPf47RHwjOwcvgubbODO6NM/g
        +90d6iNyDKVOCS69cquAlbGqRw==
X-Google-Smtp-Source: APXvYqzTVpwmfUjqXKuDPGAS7lGzF0QSfRvJNr9y2QLm6ed6KX49OPp5iNNiGdLxbhmOoJKAC4VBaw==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr7661811qkk.381.1572986505547;
        Tue, 05 Nov 2019 12:41:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w69sm12728426qkb.26.2019.11.05.12.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 12:41:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iS5e4-0001Un-CR; Tue, 05 Nov 2019 16:41:44 -0400
Date:   Tue, 5 Nov 2019 16:41:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com, galpress@amazon.com,
        yishaih@mellanox.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v12 rdma-next 0/8] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Message-ID: <20191105204144.GB19938@ziepe.ca>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030094417.16866-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 30, 2019 at 11:44:09AM +0200, Michal Kalderon wrote:
> This patch series uses the doorbell overflow recovery mechanism
> introduced in
> commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
> for rdma ( RoCE and iWARP )
> 
> The first six patches modify the core code to contain helper
> functions for managing mmap_xa inserting, getting and freeing
> entries. The code was based on the code from efa driver.
> There is still an open discussion on whether we should take
> this even further and make the entire mmap generic. Until a
> decision is made, I only created the database API and modified
> the efa, qedr, siw driver to use it. The functions are integrated
> with the umap mechanism.
> 
> The doorbell recovery code is based on the common code.
> 
> rdma-core pull request #493 was closed for now, once kernel series is
> accepted will be reopend.
> 
> This series applies over the wip/jgg-for-next branch and not the
> for-next since it contains the series:
> RDMA/qedr: Fix memory leaks and synchronization
> https://www.spinics.net/lists/linux-rdma/msg85242.html
> 
> SIW driver was reviewed, tested and signed-off by Bernard Metzler.

Since we are on v12 now, let us get this done. I added this diff to
the series. Mostly just renaming, indenting, the notes I gave already
(to all drivers) and probably a few other things I forgot

Here is the series with everything reflowed hopefully properly:

https://github.com/jgunthorpe/linux/commits/rdma_mmap

Please let me know if I messed it up, otherwise I'll apply this in a
few days.

Thanks,
Jason

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 355c59d2eaa35b..6be180eb8cb329 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -398,7 +398,4 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 			 struct vm_area_struct *vma,
 			 struct rdma_user_mmap_entry *entry);
 
-void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
-			      struct rdma_user_mmap_entry *entry);
-
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 88d9d47fb8adaa..6238842fd06402 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -11,14 +11,14 @@
 /**
  * rdma_umap_priv_init() - Initialize the private data of a vma
  *
+ * @priv: The already allocated private data
  * @vma: The vm area struct that needs private data
  * @entry: entry into the mmap_xa that needs to be linked with
  *       this vma
  *
- * Each time we map IO memory into user space this keeps track
- * of the mapping. When the device is hot-unplugged we 'zap' the
- * mmaps in user space to point to the zero page and allow the
- * hot unplug to proceed.
+ * Each time we map IO memory into user space this keeps track of the
+ * mapping. When the device is hot-unplugged we 'zap' the mmaps in user space
+ * to point to the zero page and allow the hot unplug to proceed.
  *
  * This is necessary for cases like PCI physical hot unplug as the actual BAR
  * memory may vanish after this and access to it from userspace could MCE.
@@ -48,20 +48,21 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 EXPORT_SYMBOL(rdma_umap_priv_init);
 
 /**
- * rdma_user_mmap_io() - Map IO memory into a process.
+ * rdma_user_mmap_io() - Map IO memory into a process
  *
  * @ucontext: associated user context
- * @vma: the vma related to the current mmap call.
+ * @vma: the vma related to the current mmap call
  * @pfn: pfn to map
  * @size: size to map
  * @prot: pgprot to use in remap call
+ * @entry: mmap_entry retrieved from rdma_user_mmap_entry_get(), or NULL
+ *         if mmap_entry is not used by the driver
  *
- * This is to be called by drivers as part of their mmap()
- * functions if they wish to send something like PCI-E BAR
- * memory to userspace.
+ * This is to be called by drivers as part of their mmap() functions if they
+ * wish to send something like PCI-E BAR memory to userspace.
  *
- * Return -EINVAL on wrong flags or size, -EAGAIN on failure to
- * map. 0 on success.
+ * Return -EINVAL on wrong flags or size, -EAGAIN on failure to map. 0 on
+ * success.
  */
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot,
@@ -98,45 +99,46 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 EXPORT_SYMBOL(rdma_user_mmap_io);
 
 /**
- * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa.
+ * rdma_user_mmap_entry_get_pgoff() - Get an entry from the mmap_xa
  *
- * @ucontext: associated user context.
- * @key: the key received from rdma_user_mmap_entry_insert which
- *     is provided by user as the address to map.
- * @vma: the vma related to the current mmap call.
+ * @ucontext: associated user context
+ * @pgoff: The mmap offset >> PAGE_SHIFT
  *
- * This function is called when a user tries to mmap a key it
- * initially received from the driver. The key was created by
- * the function rdma_user_mmap_entry_insert.
- * This function increases the refcnt of the entry so that it won't
- * be deleted from the xa in the meantime.
+ * This function is called when a user tries to mmap with an offset (returned
+ * by rdma_user_mmap_get_offset()) it initially received from the driver. The
+ * rdma_user_mmap_entry was created by the function
+ * rdma_user_mmap_entry_insert().  This function increases the refcnt of the
+ * entry so that it won't be deleted from the xarray in the meantime.
  *
- * Return an entry if exists or NULL if there is no match.
+ * Return an reference to an entry if exists or NULL if there is no
+ * match. rdma_user_mmap_entry_put() must be called to put the reference.
  */
 struct rdma_user_mmap_entry *
-rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key,
-			 struct vm_area_struct *vma)
+rdma_user_mmap_entry_get_pgoff(struct ib_ucontext *ucontext,
+			       unsigned long pgoff)
 {
 	struct rdma_user_mmap_entry *entry;
-	u64 mmap_page;
 
-	mmap_page = key >> PAGE_SHIFT;
-	if (mmap_page > U32_MAX)
+	if (pgoff > U32_MAX)
 		return NULL;
 
 	xa_lock(&ucontext->mmap_xa);
 
-	entry = xa_load(&ucontext->mmap_xa, mmap_page);
+	entry = xa_load(&ucontext->mmap_xa, pgoff);
 
-	/* if refcount is zero, entry is already being deleted */
-	if (!entry || entry->invalid || !kref_get_unless_zero(&entry->ref))
+	/*
+	 * If refcount is zero, entry is already being deleted, driver_removed
+	 * indicates that the no further mmaps are possible and we waiting for
+	 * the active VMAs to be closed.
+	 */
+	if (!entry || entry->start_pgoff != pgoff || entry->driver_removed ||
+	    !kref_get_unless_zero(&entry->ref))
 		goto err;
 
 	xa_unlock(&ucontext->mmap_xa);
 
-	ibdev_dbg(ucontext->device,
-		  "mmap: key[%#llx] npages[%#x] returned\n",
-		  key, entry->npages);
+	ibdev_dbg(ucontext->device, "mmap: pgoff[%#lx] npages[%#zx] returned\n",
+		  pgoff, entry->npages);
 
 	return entry;
 
@@ -144,25 +146,54 @@ rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key,
 	xa_unlock(&ucontext->mmap_xa);
 	return NULL;
 }
+EXPORT_SYMBOL(rdma_user_mmap_entry_get_pgoff);
+
+/**
+ * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa
+ *
+ * @ucontext: associated user context
+ * @vma: the vma being mmap'd into
+ *
+ * This function is like rdma_user_mmap_entry_get_pgoff() except that it also
+ * checks that the VMA is correct.
+ */
+struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext,
+			 struct vm_area_struct *vma)
+{
+	struct rdma_user_mmap_entry *entry;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return NULL;
+	entry = rdma_user_mmap_entry_get_pgoff(ucontext, vma->vm_pgoff);
+	if (!entry)
+		return NULL;
+	if (entry->npages * PAGE_SIZE != vma->vm_end - vma->vm_start) {
+		rdma_user_mmap_entry_put(entry);
+		return NULL;
+	}
+	return entry;
+}
 EXPORT_SYMBOL(rdma_user_mmap_entry_get);
 
-void rdma_user_mmap_entry_free(struct kref *kref)
+static void rdma_user_mmap_entry_free(struct kref *kref)
 {
 	struct rdma_user_mmap_entry *entry =
 		container_of(kref, struct rdma_user_mmap_entry, ref);
 	struct ib_ucontext *ucontext = entry->ucontext;
 	unsigned long i;
 
-	/* need to erase all entries occupied by this single entry */
+	/*
+	 * Erase all entries occupied by this single entry, this is deferred
+	 * until all VMA are closed so that the mmap offsets remain unique.
+	 */
 	xa_lock(&ucontext->mmap_xa);
 	for (i = 0; i < entry->npages; i++)
-		__xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);
+		__xa_erase(&ucontext->mmap_xa, entry->start_pgoff + i);
 	xa_unlock(&ucontext->mmap_xa);
 
-	ibdev_dbg(ucontext->device,
-		  "mmap: key[%#llx] npages[%#x] removed\n",
-		  rdma_user_mmap_get_key(entry),
-		  entry->npages);
+	ibdev_dbg(ucontext->device, "mmap: pgoff[%#lx] npages[%#zx] removed\n",
+		  entry->start_pgoff, entry->npages);
 
 	if (ucontext->device->ops.mmap_free)
 		ucontext->device->ops.mmap_free(entry);
@@ -171,8 +202,7 @@ void rdma_user_mmap_entry_free(struct kref *kref)
 /**
  * rdma_user_mmap_entry_put() - Drop reference to the mmap entry
  *
- * @ucontext: associated user context.
- * @entry: an entry in the mmap_xa.
+ * @entry: an entry in the mmap_xa
  *
  * This function is called when the mapping is closed if it was
  * an io mapping or when the driver is done with the entry for
@@ -181,8 +211,7 @@ void rdma_user_mmap_entry_free(struct kref *kref)
  * and entry is no longer needed. This function will erase the
  * entry and free it if its refcnt reaches zero.
  */
-void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
-			      struct rdma_user_mmap_entry *entry)
+void rdma_user_mmap_entry_put(struct rdma_user_mmap_entry *entry)
 {
 	kref_put(&entry->ref, rdma_user_mmap_entry_free);
 }
@@ -190,36 +219,38 @@ EXPORT_SYMBOL(rdma_user_mmap_entry_put);
 
 /**
  * rdma_user_mmap_entry_remove() - Drop reference to entry and
- *				   mark it as invalid.
+ *				   mark it as unmmapable
  *
- * @ucontext: associated user context.
  * @entry: the entry to insert into the mmap_xa
+ *
+ * Drivers can call this to prevent userspace from creating more mappings for
+ * entry, however existing mmaps continue to exist and ops->mmap_free() will
+ * not be called until all user mmaps are destroyed.
  */
-void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext,
-				 struct rdma_user_mmap_entry *entry)
+void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
 {
 	if (!entry)
 		return;
 
-	entry->invalid = true;
+	entry->driver_removed = true;
 	kref_put(&entry->ref, rdma_user_mmap_entry_free);
 }
 EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
 
 /**
- * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa.
+ * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa
  *
  * @ucontext: associated user context.
  * @entry: the entry to insert into the mmap_xa
  * @length: length of the address that will be mmapped
  *
  * This function should be called by drivers that use the rdma_user_mmap
- * interface for handling user mmapped addresses. The database is handled in
- * the core and helper functions are provided to insert entries into the
- * database and extract entries when the user calls mmap with the given key.
- * The function allocates a unique key that should be provided to user, the user
- * will use the key to retrieve information such as address to
- * be mapped and how.
+ * interface for implementing their mmap syscall A database of mmap offsets is
+ * handled in the core and helper functions are provided to insert entries
+ * into the database and extract entries when the user calls mmap with the
+ * given offset.  The function allocates a unique page offset that should be
+ * provided to user, the user will use the iffset to retrieve information such
+ * as address to be mapped and how.
  *
  * Return: 0 on success and -ENOMEM on failure
  */
@@ -230,7 +261,8 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 	struct ib_uverbs_file *ufile = ucontext->ufile;
 	XA_STATE(xas, &ucontext->mmap_xa, 0);
 	u32 xa_first, xa_last, npages;
-	int err, i;
+	int err;
+	u32 i;
 
 	if (!entry)
 		return -EINVAL;
@@ -238,10 +270,11 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 	kref_init(&entry->ref);
 	entry->ucontext = ucontext;
 
-	/* We want the whole allocation to be done without interruption
-	 * from a different thread. The allocation requires finding a
-	 * free range and storing. During the xa_insert the lock could be
-	 * released, we don't want another thread taking the gap.
+	/*
+	 * We want the whole allocation to be done without interruption from a
+	 * different thread. The allocation requires finding a free range and
+	 * storing. During the xa_insert the lock could be released, possibly
+	 * allowing another thread to choose the same range.
 	 */
 	mutex_lock(&ufile->umap_lock);
 
@@ -262,13 +295,13 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 		if (check_add_overflow(xa_first, npages, &xa_last))
 			goto err_unlock;
 
-		/* Now look for the next present entry. If such doesn't
-		 * exist, we found an empty range and can proceed
+		/*
+		 * Now look for the next present entry. If an entry doesn't
+		 * exist, we found an empty range and can proceed.
 		 */
 		xas_next_entry(&xas, xa_last - 1);
 		if (xas.xa_node == XAS_BOUNDS || xas.xa_index >= xa_last)
 			break;
-		/* o/w look for the next free entry */
 	}
 
 	for (i = xa_first; i < xa_last; i++) {
@@ -277,13 +310,16 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 			goto err_undo;
 	}
 
-	entry->mmap_page = xa_first;
+	/*
+	 * Internally the kernel uses a page offset, in libc this is a byte
+	 * offset. Drivers should not return pgoff to userspace.
+	 */
+	entry->start_pgoff = xa_first;
 	xa_unlock(&ucontext->mmap_xa);
-
 	mutex_unlock(&ufile->umap_lock);
-	ibdev_dbg(ucontext->device,
-		  "mmap: key[%#llx] npages[%#x] inserted\n",
-		  rdma_user_mmap_get_key(entry), npages);
+
+	ibdev_dbg(ucontext->device, "mmap: pgoff[%#lx] npages[%#x] inserted\n",
+		  entry->start_pgoff, npages);
 
 	return 0;
 
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index dbe9bd3d389a28..9aa7ffc1d12a93 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -844,17 +844,15 @@ static void rdma_umap_close(struct vm_area_struct *vma)
 	if (!priv)
 		return;
 
-	if (priv->entry) {
-		rdma_user_mmap_entry_put(ufile->ucontext, priv->entry);
-		priv->entry = NULL;
-	}
-
 	/*
 	 * The vma holds a reference on the struct file that created it, which
 	 * in turn means that the ib_uverbs_file is guaranteed to exist at
 	 * this point.
 	 */
 	mutex_lock(&ufile->umap_lock);
+	if (priv->entry)
+		rdma_user_mmap_entry_put(priv->entry);
+
 	list_del(&priv->list);
 	mutex_unlock(&ufile->umap_lock);
 	kfree(priv);
@@ -951,17 +949,15 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 
 			if (vma->vm_mm != mm)
 				continue;
-
-			if (priv->entry) {
-				rdma_user_mmap_entry_put(ufile->ucontext,
-							 priv->entry);
-				priv->entry = NULL;
-			}
-
 			list_del_init(&priv->list);
 
 			zap_vma_ptes(vma, vma->vm_start,
 				     vma->vm_end - vma->vm_start);
+
+			if (priv->entry) {
+				rdma_user_mmap_entry_put(priv->entry);
+				priv->entry = NULL;
+			}
 		}
 		mutex_unlock(&ufile->umap_lock);
 	skip_mm:
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 482d8acaad2c1d..2bda07078b9743 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -122,13 +122,6 @@ struct efa_ah {
 	u8 id[EFA_GID_SIZE];
 };
 
-struct efa_user_mmap_entry {
-	struct rdma_user_mmap_entry rdma_entry;
-	u64 address;
-	size_t length;
-	u8 mmap_flag;
-};
-
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index f39e24df29a55e..b242ea7a3bc868 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -23,6 +23,12 @@ enum {
 	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
 	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
 
+struct efa_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u64 address;
+	u8 mmap_flag;
+};
+
 #define EFA_DEFINE_STATS(op) \
 	op(EFA_TX_BYTES, "tx_bytes") \
 	op(EFA_TX_PKTS, "tx_pkts") \
@@ -376,10 +382,10 @@ static int efa_destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
 static void efa_qp_user_mmap_entries_remove(struct efa_ucontext *uctx,
 					    struct efa_qp *qp)
 {
-	rdma_user_mmap_entry_remove(&uctx->ibucontext, qp->rq_mmap_entry);
-	rdma_user_mmap_entry_remove(&uctx->ibucontext, qp->rq_db_mmap_entry);
-	rdma_user_mmap_entry_remove(&uctx->ibucontext, qp->llq_desc_mmap_entry);
-	rdma_user_mmap_entry_remove(&uctx->ibucontext, qp->sq_db_mmap_entry);
+	rdma_user_mmap_entry_remove(qp->rq_mmap_entry);
+	rdma_user_mmap_entry_remove(qp->rq_db_mmap_entry);
+	rdma_user_mmap_entry_remove(qp->llq_desc_mmap_entry);
+	rdma_user_mmap_entry_remove(qp->sq_db_mmap_entry);
 }
 
 int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
@@ -412,7 +418,7 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 static struct rdma_user_mmap_entry*
 efa_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 			   u64 address, size_t length,
-			   u8 mmap_flag, u64 *key)
+			   u8 mmap_flag, u64 *offset)
 {
 	struct efa_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	int err;
@@ -421,7 +427,6 @@ efa_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 		return NULL;
 
 	entry->address = address;
-	entry->length = length;
 	entry->mmap_flag = mmap_flag;
 
 	err = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
@@ -430,7 +435,7 @@ efa_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 		kfree(entry);
 		return NULL;
 	}
-	*key = rdma_user_mmap_get_key(&entry->rdma_entry);
+	*offset = rdma_user_mmap_get_offset(&entry->rdma_entry);
 
 	return &entry->rdma_entry;
 }
@@ -828,9 +833,6 @@ static int efa_destroy_cq_idx(struct efa_dev *dev, int cq_idx)
 
 void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
-	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
-			struct efa_ucontext, ibucontext);
-
 	struct efa_dev *dev = to_edev(ibcq->device);
 	struct efa_cq *cq = to_ecq(ibcq);
 
@@ -841,8 +843,7 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
-	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
-				    cq->mmap_entry);
+	rdma_user_mmap_entry_remove(cq->mmap_entry);
 }
 
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
@@ -975,7 +976,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return 0;
 
 err_remove_mmap:
-	rdma_user_mmap_entry_remove(&ucontext->ibucontext, cq->mmap_entry);
+	rdma_user_mmap_entry_remove(cq->mmap_entry);
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
@@ -1541,12 +1542,12 @@ void efa_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 	/* DMA mapping is already gone, now free the pages */
 	if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
 		free_pages_exact(phys_to_virt(entry->address),
-				 entry->length);
+				 entry->rdma_entry.npages * PAGE_SIZE);
 	kfree(entry);
 }
 
 static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
-		      struct vm_area_struct *vma, u64 key, size_t length)
+		      struct vm_area_struct *vma)
 {
 	struct rdma_user_mmap_entry *rdma_entry;
 	struct efa_user_mmap_entry *entry;
@@ -1554,35 +1555,31 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 	int err = 0;
 	u64 pfn;
 
-	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, key,
-					      vma);
+	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, vma);
 	if (!rdma_entry) {
-		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
-			  key);
+		ibdev_dbg(&dev->ibdev,
+			  "pgoff[%#lx] does not have valid entry\n",
+			  vma->vm_pgoff);
 		return -EINVAL;
 	}
 	entry = to_emmap(rdma_entry);
-	if (entry->length != length) {
-		ibdev_dbg(&dev->ibdev,
-			  "key[%#llx] does not have valid length[%#zx] expected[%#zx]\n",
-			  key, length, entry->length);
-		err = -EINVAL;
-		goto out;
-	}
 
 	ibdev_dbg(&dev->ibdev,
 		  "Mapping address[%#llx], length[%#zx], mmap_flag[%d]\n",
-		  entry->address, entry->length, entry->mmap_flag);
+		  entry->address, rdma_entry->npages * PAGE_SIZE,
+		  entry->mmap_flag);
 
 	pfn = entry->address >> PAGE_SHIFT;
 	switch (entry->mmap_flag) {
 	case EFA_MMAP_IO_NC:
-		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
+		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn,
+					entry->rdma_entry.npages * PAGE_SIZE,
 					pgprot_noncached(vma->vm_page_prot),
 					rdma_entry);
 		break;
 	case EFA_MMAP_IO_WC:
-		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
+		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn,
+					entry->rdma_entry.npages * PAGE_SIZE,
 					pgprot_writecombine(vma->vm_page_prot),
 					rdma_entry);
 		break;
@@ -1599,14 +1596,14 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 	}
 
 	if (err) {
-		ibdev_dbg(&dev->ibdev,
-			  "Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
-			  entry->address, length, entry->mmap_flag, err);
+		ibdev_dbg(
+			&dev->ibdev,
+			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
+			entry->address, rdma_entry->npages * PAGE_SIZE,
+			entry->mmap_flag, err);
 	}
 
-out:
-	rdma_user_mmap_entry_put(&ucontext->ibucontext, rdma_entry);
-
+	rdma_user_mmap_entry_put(rdma_entry);
 	return err;
 }
 
@@ -1616,25 +1613,12 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
 	struct efa_dev *dev = to_edev(ibucontext->device);
 	size_t length = vma->vm_end - vma->vm_start;
-	u64 key = vma->vm_pgoff << PAGE_SHIFT;
 
 	ibdev_dbg(&dev->ibdev,
-		  "start %#lx, end %#lx, length = %#zx, key = %#llx\n",
-		  vma->vm_start, vma->vm_end, length, key);
-
-	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
-		ibdev_dbg(&dev->ibdev,
-			  "length[%#zx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
-			  length, PAGE_SIZE, vma->vm_flags);
-		return -EINVAL;
-	}
-
-	if (vma->vm_flags & VM_EXEC) {
-		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
-		return -EPERM;
-	}
+		  "start %#lx, end %#lx, length = %#zx, pgoff = %#lx\n",
+		  vma->vm_start, vma->vm_end, length, vma->vm_pgoff);
 
-	return __efa_mmap(dev, ucontext, vma, key, length);
+	return __efa_mmap(dev, ucontext, vma);
 }
 
 static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index b67248c9d92c29..9a674e65c4f783 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -321,7 +321,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.dpm_enabled = dev->user_dpm_enabled;
 	uresp.wids_enabled = 1;
 	uresp.wid_count = oparams.wid_count;
-	uresp.db_pa = rdma_user_mmap_get_key(ctx->db_mmap_entry);
+	uresp.db_pa = rdma_user_mmap_get_offset(ctx->db_mmap_entry);
 	uresp.db_size = ctx->dpi_size;
 	uresp.max_send_wr = dev->attr.max_sqe;
 	uresp.max_recv_wr = dev->attr.max_rqe;
@@ -345,7 +345,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	if (!ctx->db_mmap_entry)
 		dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
 	else
-		rdma_user_mmap_entry_remove(uctx, ctx->db_mmap_entry);
+		rdma_user_mmap_entry_remove(ctx->db_mmap_entry);
 
 	return rc;
 }
@@ -357,7 +357,7 @@ void qedr_dealloc_ucontext(struct ib_ucontext *ibctx)
 	DP_DEBUG(uctx->dev, QEDR_MSG_INIT, "Deallocating user context %p\n",
 		 uctx);
 
-	rdma_user_mmap_entry_remove(ibctx, uctx->db_mmap_entry);
+	rdma_user_mmap_entry_remove(uctx->db_mmap_entry);
 }
 
 void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
@@ -377,44 +377,22 @@ int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
 {
 	struct ib_device *dev = ucontext->device;
 	size_t length = vma->vm_end - vma->vm_start;
-	u64 key = vma->vm_pgoff << PAGE_SHIFT;
 	struct rdma_user_mmap_entry *rdma_entry;
 	struct qedr_user_mmap_entry *entry;
 	int rc = 0;
 	u64 pfn;
 
 	ibdev_dbg(dev,
-		  "start %#lx, end %#lx, length = %#zx, key = %#llx\n",
-		  vma->vm_start, vma->vm_end, length, key);
+		  "start %#lx, end %#lx, length = %#zx, pgoff = %#lx\n",
+		  vma->vm_start, vma->vm_end, length, vma->vm_pgoff);
 
-	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
-		ibdev_dbg(dev,
-			  "length[%#zx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
-			  length, PAGE_SIZE, vma->vm_flags);
-		return -EINVAL;
-	}
-
-	if (vma->vm_flags & VM_EXEC) {
-		ibdev_dbg(dev, "Mapping executable pages is not permitted\n");
-		return -EPERM;
-	}
-	vma->vm_flags &= ~VM_MAYEXEC;
-
-	rdma_entry = rdma_user_mmap_entry_get(ucontext, key, vma);
+	rdma_entry = rdma_user_mmap_entry_get(ucontext, vma);
 	if (!rdma_entry) {
-		ibdev_dbg(dev, "key[%#llx] does not have valid entry\n",
-			  key);
+		ibdev_dbg(dev, "pgoff[%#lx] does not have valid entry\n",
+			  vma->vm_pgoff);
 		return -EINVAL;
 	}
 	entry = get_qedr_mmap_entry(rdma_entry);
-	if (entry->length != length) {
-		ibdev_dbg(dev,
-			  "key[%#llx] does not have valid length[%#zx] expected[%#zx]\n",
-			  key, length, entry->length);
-		rc = -EINVAL;
-		goto out;
-	}
-
 	ibdev_dbg(dev,
 		  "Mapping address[%#llx], length[%#zx], mmap_flag[%d]\n",
 		  entry->io_address, length, entry->mmap_flag);
@@ -439,9 +417,7 @@ int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
 			  "Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
 			  entry->io_address, length, entry->mmap_flag, rc);
 
-out:
-	rdma_user_mmap_entry_put(ucontext, rdma_entry);
-
+	rdma_user_mmap_entry_put(rdma_entry);
 	return rc;
 }
 
@@ -713,7 +689,7 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 
 	uresp.db_offset = db_offset;
 	uresp.icid = cq->icid;
-	uresp.db_rec_addr = rdma_user_mmap_get_key(cq->q.db_mmap_entry);
+	uresp.db_rec_addr = rdma_user_mmap_get_offset(cq->q.db_mmap_entry);
 
 	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (rc)
@@ -758,7 +734,7 @@ static int qedr_init_user_db_rec(struct ib_udata *udata,
 	/* Allocate a page for doorbell recovery, add to mmap */
 	q->db_rec_data = (void *)get_zeroed_page(GFP_USER);
 	if (!q->db_rec_data) {
-		DP_ERR(dev, "get_free_page failed\n");
+		DP_ERR(dev, "get_zeroed_page failed\n");
 		return -ENOMEM;
 	}
 
@@ -1044,8 +1020,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
 		ib_umem_release(cq->q.umem);
 		if (ctx)
-			rdma_user_mmap_entry_remove(&ctx->ibucontext,
-						    cq->q.db_mmap_entry);
+			rdma_user_mmap_entry_remove(cq->q.db_mmap_entry);
 	} else {
 		dev->ops->common->chain_free(dev->cdev, &cq->pbl);
 	}
@@ -1068,8 +1043,6 @@ int qedr_resize_cq(struct ib_cq *ibcq, int new_cnt, struct ib_udata *udata)
 
 void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
-	struct qedr_ucontext *ctx = rdma_udata_to_drv_context(udata,
-		struct qedr_ucontext, ibucontext);
 	struct qedr_dev *dev = get_qedr_dev(ibcq->device);
 	struct qed_rdma_destroy_cq_out_params oparams;
 	struct qed_rdma_destroy_cq_in_params iparams;
@@ -1097,8 +1070,7 @@ void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		if (cq->q.db_rec_data) {
 			qedr_db_recovery_del(dev, cq->q.db_addr,
 					     &cq->q.db_rec_data->db_data);
-			rdma_user_mmap_entry_remove(&ctx->ibucontext,
-						    cq->q.db_mmap_entry);
+			rdma_user_mmap_entry_remove(cq->q.db_mmap_entry);
 		}
 	} else {
 		qedr_db_recovery_del(dev, cq->db_addr, &cq->db.data);
@@ -1280,7 +1252,7 @@ static void qedr_copy_rq_uresp(struct qedr_dev *dev,
 	}
 
 	uresp->rq_icid = qp->icid;
-	uresp->rq_db_rec_addr = rdma_user_mmap_get_key(qp->urq.db_mmap_entry);
+	uresp->rq_db_rec_addr = rdma_user_mmap_get_offset(qp->urq.db_mmap_entry);
 }
 
 static void qedr_copy_sq_uresp(struct qedr_dev *dev,
@@ -1295,7 +1267,8 @@ static void qedr_copy_sq_uresp(struct qedr_dev *dev,
 	else
 		uresp->sq_icid = qp->icid + 1;
 
-	uresp->sq_db_rec_addr = rdma_user_mmap_get_key(qp->usq.db_mmap_entry);
+	uresp->sq_db_rec_addr =
+		rdma_user_mmap_get_offset(qp->usq.db_mmap_entry);
 }
 
 static int qedr_copy_qp_uresp(struct qedr_dev *dev,
@@ -1747,15 +1720,13 @@ static void qedr_cleanup_user(struct qedr_dev *dev,
 	if (qp->usq.db_rec_data) {
 		qedr_db_recovery_del(dev, qp->usq.db_addr,
 				     &qp->usq.db_rec_data->db_data);
-		rdma_user_mmap_entry_remove(&ctx->ibucontext,
-					    qp->usq.db_mmap_entry);
+		rdma_user_mmap_entry_remove(qp->usq.db_mmap_entry);
 	}
 
 	if (qp->urq.db_rec_data) {
 		qedr_db_recovery_del(dev, qp->urq.db_addr,
 				     &qp->urq.db_rec_data->db_data);
-		rdma_user_mmap_entry_remove(&ctx->ibucontext,
-					    qp->urq.db_mmap_entry);
+		rdma_user_mmap_entry_remove(qp->urq.db_mmap_entry);
 	}
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1))
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index ecc338e8f0b09d..f851afb5632e65 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -507,7 +507,6 @@ struct iwarp_msg_info {
 struct siw_user_mmap_entry {
 	struct rdma_user_mmap_entry rdma_entry;
 	void *address;
-	size_t length;
 };
 
 /* Global siw parameters. Currently set in siw_main.c */
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index cc4e7aebc9bc09..725985ed8af3be 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -44,7 +44,6 @@ void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 {
 	struct siw_ucontext *uctx = to_siw_ctx(ctx);
-	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
 	size_t size = vma->vm_end - vma->vm_start;
 	struct rdma_user_mmap_entry *rdma_entry;
 	struct siw_user_mmap_entry *entry;
@@ -57,29 +56,22 @@ int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 		pr_warn("siw: mmap not page aligned\n");
 		return -EINVAL;
 	}
-	rdma_entry = rdma_user_mmap_entry_get(&uctx->base_ucontext, off,
-					      vma);
+	rdma_entry = rdma_user_mmap_entry_get(&uctx->base_ucontext, vma);
 	if (!rdma_entry) {
 		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %#zx\n",
-			off, size);
+			vma->vm_pgoff, size);
 		return -EINVAL;
 	}
 	entry = to_siw_mmap_entry(rdma_entry);
-	if (PAGE_ALIGN(entry->length) != size) {
-		siw_dbg(&uctx->sdev->base_dev,
-			"key[%#lx] does not have valid length[%#zx] expected[%#zx]\n",
-			off, size, entry->length);
-		rv = -EINVAL;
-		goto out;
-	}
 
 	rv = remap_vmalloc_range(vma, entry->address, 0);
 	if (rv) {
-		pr_warn("remap_vmalloc_range failed: %lu, %zu\n", off, size);
+		pr_warn("remap_vmalloc_range failed: %lu, %zu\n", vma->vm_pgoff,
+			size);
 		goto out;
 	}
 out:
-	rdma_user_mmap_entry_put(&uctx->base_ucontext, rdma_entry);
+	rdma_user_mmap_entry_put(rdma_entry);
 
 	return rv;
 }
@@ -274,17 +266,16 @@ void siw_qp_put_ref(struct ib_qp *base_qp)
 static struct rdma_user_mmap_entry *
 siw_mmap_entry_insert(struct siw_ucontext *uctx,
 		      void *address, size_t length,
-		      u64 *key)
+		      u64 *offset)
 {
 	struct siw_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	int rv;
 
-	*key = SIW_INVAL_UOBJ_KEY;
+	*offset = SIW_INVAL_UOBJ_KEY;
 	if (!entry)
 		return NULL;
 
 	entry->address = address;
-	entry->length = length;
 
 	rv = rdma_user_mmap_entry_insert(&uctx->base_ucontext,
 					 &entry->rdma_entry,
@@ -294,7 +285,7 @@ siw_mmap_entry_insert(struct siw_ucontext *uctx,
 		return NULL;
 	}
 
-	*key = rdma_user_mmap_get_key(&entry->rdma_entry);
+	*offset = rdma_user_mmap_get_offset(&entry->rdma_entry);
 
 	return &entry->rdma_entry;
 }
@@ -512,10 +503,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 
 	if (qp) {
 		if (uctx) {
-			rdma_user_mmap_entry_remove(&uctx->base_ucontext,
-						    qp->sq_entry);
-			rdma_user_mmap_entry_remove(&uctx->base_ucontext,
-						    qp->rq_entry);
+			rdma_user_mmap_entry_remove(qp->sq_entry);
+			rdma_user_mmap_entry_remove(qp->rq_entry);
 		}
 		vfree(qp->sendq);
 		vfree(qp->recvq);
@@ -631,8 +620,8 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 	qp->rx_stream.rx_suspend = 1;
 
 	if (uctx) {
-		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->sq_entry);
-		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->rq_entry);
+		rdma_user_mmap_entry_remove(qp->sq_entry);
+		rdma_user_mmap_entry_remove(qp->rq_entry);
 	}
 
 	down_write(&qp->state_lock);
@@ -1104,7 +1093,7 @@ void siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
 	siw_cq_flush(cq);
 
 	if (ctx)
-		rdma_user_mmap_entry_remove(&ctx->base_ucontext, cq->cq_entry);
+		rdma_user_mmap_entry_remove(cq->cq_entry);
 
 	atomic_dec(&sdev->num_cq);
 
@@ -1198,8 +1187,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
 						  base_ucontext);
 		if (ctx)
-			rdma_user_mmap_entry_remove(&ctx->base_ucontext,
-						    cq->cq_entry);
+			rdma_user_mmap_entry_remove(cq->cq_entry);
 		vfree(cq->queue);
 	}
 	atomic_dec(&sdev->num_cq);
@@ -1650,8 +1638,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 err_out:
 	if (srq->recvq) {
 		if (ctx)
-			rdma_user_mmap_entry_remove(&ctx->base_ucontext,
-						    srq->srq_entry);
+			rdma_user_mmap_entry_remove(srq->srq_entry);
 		vfree(srq->recvq);
 	}
 	atomic_dec(&sdev->num_srq);
@@ -1738,8 +1725,7 @@ void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata)
 					  base_ucontext);
 
 	if (ctx)
-		rdma_user_mmap_entry_remove(&ctx->base_ucontext,
-					    srq->srq_entry);
+		rdma_user_mmap_entry_remove(srq->srq_entry);
 	vfree(srq->recvq);
 	atomic_dec(&sdev->num_srq);
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 13de7c1b796d7d..416e72ea80d913 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2262,15 +2262,16 @@ struct iw_cm_conn_param;
 struct rdma_user_mmap_entry {
 	struct kref ref;
 	struct ib_ucontext *ucontext;
-	u32 npages;
-	u32 mmap_page;
-	bool invalid;
+	unsigned long start_pgoff;
+	size_t npages;
+	bool driver_removed;
 };
 
+/* Return the offset (in bytes) the user should pass to libc's mmap() */
 static inline u64
-rdma_user_mmap_get_key(const struct rdma_user_mmap_entry *entry)
+rdma_user_mmap_get_offset(const struct rdma_user_mmap_entry *entry)
 {
-	return (u64)entry->mmap_page << PAGE_SHIFT;
+	return (u64)entry->start_pgoff << PAGE_SHIFT;
 }
 
 /**
@@ -2832,14 +2833,14 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 				struct rdma_user_mmap_entry *entry,
 				size_t length);
 struct rdma_user_mmap_entry *
-rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key,
+rdma_user_mmap_entry_get_pgoff(struct ib_ucontext *ucontext,
+			       unsigned long pgoff);
+struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext,
 			 struct vm_area_struct *vma);
+void rdma_user_mmap_entry_put(struct rdma_user_mmap_entry *entry);
 
-void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
-			      struct rdma_user_mmap_entry *entry);
-
-void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext,
-				 struct rdma_user_mmap_entry *entry);
+void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry);
 
 static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
 {
