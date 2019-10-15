Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D875D7E97
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJOSQL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45457 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfJOSQL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:11 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so48105126iot.12
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98vHKVBEM0hEBK2KPs+I58gQveSostE1DslOfyfeJEU=;
        b=dV2Dye+25NP3t0c1fbIUgbOGBNbXYc3nsQEzHcJE5Yf16XOsk94QpIcf+Vi+zAkzDi
         KMpTRTTlh4Td/GoOS+XmBibAcdSyQBHrqm9wXu4D/Ub3h2MmXJE3GDShf9Ii1oIMV0GQ
         8hBKNBsj9DWNCSF+BIX4JmT2RLaTT/yYmHpXBaHgHSpvXzup11BuqujtlNWytceRqh45
         usTvbEt4RNRh+4mpCwIfZHqbG30obKko3SLXU2XQ3Q785hBXkUFrfvPI6jSk4aj2bla3
         tIOpuIxP6ApZKhPJU/sioDlEsXHtrZrYoBL4ezArzZ/IkVPt/8kb4z+RUV2k82EhqoFp
         vKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98vHKVBEM0hEBK2KPs+I58gQveSostE1DslOfyfeJEU=;
        b=VIhEJ7HXjFNXAqq8+V2LPPeGklXCkepJm5GxtS2MZhpYjIhJJV7bjfPaZriDPvr/NH
         bp3SOjmXJQMqh4LMI7p42nqPxaCHcEDWqcOqP73iFQUJgu8P5toezDul9ZQd/LAdKnKf
         MyQhdJmN7JPTOZC0uXjz+ZE/6aGQx2SgYcHkqFyA410nNkq9elb+NgEVpvM8wrxzeI2L
         XyRJKlpJpEdEZWgKDk9W706WUmMjDECnuTQ2zCH7adKG5jEo39ySZJLgyQlUKqvWMe/v
         hvYbYfGR58FcRZrSwpyMYTtABa6BGpSXItbR21i9gr3MvFGgXGkT511XeAUqtY40uN2i
         tRRg==
X-Gm-Message-State: APjAAAXb78Vc/POYnnPdlQAWCvWPQJMyjxVcv0w9PenALjRVtvvYs34K
        KgBB08IJ9gKQ8EzhJpNJ2/1W8Q==
X-Google-Smtp-Source: APXvYqzEGMTGXIdGw9Kq7dhMQJVot12wGm4H93GQCM84MUNp6unnufR3VgRi65NkWzp0Mkni5LfD3g==
X-Received: by 2002:a92:ba0a:: with SMTP id o10mr7335324ili.150.1571163369703;
        Tue, 15 Oct 2019 11:16:09 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id u204sm21426020iod.50.2019.10.15.11.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:09 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002CQ-JR; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH hmm 09/15] xen/gntdev: use mmu_range_notifier_insert
Date:   Tue, 15 Oct 2019 15:12:36 -0300
Message-Id: <20191015181242.8343-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

gntdev simply wants to monitor a specific VMA for any notifier events,
this can be done straightforwardly using mmu_range_notifier_insert() over
the VMA's VA range.

The notifier should be attached until the original VMA is destroyed.

It is unclear if any of this is even sane, but at least a lot of duplicate
code is removed.

Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/xen/gntdev-common.h |   8 +-
 drivers/xen/gntdev.c        | 179 ++++++++++--------------------------
 2 files changed, 48 insertions(+), 139 deletions(-)

diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
index 2f8b949c3eeb14..b201fdd20b667b 100644
--- a/drivers/xen/gntdev-common.h
+++ b/drivers/xen/gntdev-common.h
@@ -21,15 +21,8 @@ struct gntdev_dmabuf_priv;
 struct gntdev_priv {
 	/* Maps with visible offsets in the file descriptor. */
 	struct list_head maps;
-	/*
-	 * Maps that are not visible; will be freed on munmap.
-	 * Only populated if populate_freeable_maps == 1
-	 */
-	struct list_head freeable_maps;
 	/* lock protects maps and freeable_maps. */
 	struct mutex lock;
-	struct mm_struct *mm;
-	struct mmu_notifier mn;
 
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	/* Device for which DMA memory is allocated. */
@@ -49,6 +42,7 @@ struct gntdev_unmap_notify {
 };
 
 struct gntdev_grant_map {
+	struct mmu_range_notifier notifier;
 	struct list_head next;
 	struct vm_area_struct *vma;
 	int index;
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index a446a7221e13e9..234153f556afd6 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -65,7 +65,6 @@ MODULE_PARM_DESC(limit, "Maximum number of grants that may be mapped by "
 static atomic_t pages_mapped = ATOMIC_INIT(0);
 
 static int use_ptemod;
-#define populate_freeable_maps use_ptemod
 
 static int unmap_grant_pages(struct gntdev_grant_map *map,
 			     int offset, int pages);
@@ -251,12 +250,6 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 		evtchn_put(map->notify.event);
 	}
 
-	if (populate_freeable_maps && priv) {
-		mutex_lock(&priv->lock);
-		list_del(&map->next);
-		mutex_unlock(&priv->lock);
-	}
-
 	if (map->pages && !use_ptemod)
 		unmap_grant_pages(map, 0, map->count);
 	gntdev_free_map(map);
@@ -445,17 +438,9 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
 	struct gntdev_priv *priv = file->private_data;
 
 	pr_debug("gntdev_vma_close %p\n", vma);
-	if (use_ptemod) {
-		/* It is possible that an mmu notifier could be running
-		 * concurrently, so take priv->lock to ensure that the vma won't
-		 * vanishing during the unmap_grant_pages call, since we will
-		 * spin here until that completes. Such a concurrent call will
-		 * not do any unmapping, since that has been done prior to
-		 * closing the vma, but it may still iterate the unmap_ops list.
-		 */
-		mutex_lock(&priv->lock);
+	if (use_ptemod && map->vma == vma) {
+		mmu_range_notifier_remove(&map->notifier);
 		map->vma = NULL;
-		mutex_unlock(&priv->lock);
 	}
 	vma->vm_private_data = NULL;
 	gntdev_put_map(priv, map);
@@ -477,109 +462,43 @@ static const struct vm_operations_struct gntdev_vmops = {
 
 /* ------------------------------------------------------------------ */
 
-static bool in_range(struct gntdev_grant_map *map,
-			      unsigned long start, unsigned long end)
-{
-	if (!map->vma)
-		return false;
-	if (map->vma->vm_start >= end)
-		return false;
-	if (map->vma->vm_end <= start)
-		return false;
-
-	return true;
-}
-
-static int unmap_if_in_range(struct gntdev_grant_map *map,
-			      unsigned long start, unsigned long end,
-			      bool blockable)
+static bool gntdev_invalidate(struct mmu_range_notifier *mn,
+			      const struct mmu_notifier_range *range)
 {
+	struct gntdev_grant_map *map =
+		container_of(mn, struct gntdev_grant_map, notifier);
 	unsigned long mstart, mend;
 	int err;
 
-	if (!in_range(map, start, end))
-		return 0;
+	if (!mmu_notifier_range_blockable(range))
+		return false;
 
-	if (!blockable)
-		return -EAGAIN;
+	/*
+	 * If the VMA is split or otherwise changed the notifier is not
+	 * updated, but we don't want to process VA's outside the modified
+	 * VMA. FIXME: It would be much more understandable to just prevent
+	 * modifying the VMA in the first place.
+	 */
+	if (map->vma->vm_start >= range->end ||
+	    map->vma->vm_end <= range->start)
+		return true;
 
-	mstart = max(start, map->vma->vm_start);
-	mend   = min(end,   map->vma->vm_end);
+	mstart = max(range->start, map->vma->vm_start);
+	mend = min(range->end, map->vma->vm_end);
 	pr_debug("map %d+%d (%lx %lx), range %lx %lx, mrange %lx %lx\n",
 			map->index, map->count,
 			map->vma->vm_start, map->vma->vm_end,
-			start, end, mstart, mend);
+			range->start, range->end, mstart, mend);
 	err = unmap_grant_pages(map,
 				(mstart - map->vma->vm_start) >> PAGE_SHIFT,
 				(mend - mstart) >> PAGE_SHIFT);
 	WARN_ON(err);
 
-	return 0;
-}
-
-static int mn_invl_range_start(struct mmu_notifier *mn,
-			       const struct mmu_notifier_range *range)
-{
-	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
-	struct gntdev_grant_map *map;
-	int ret = 0;
-
-	if (mmu_notifier_range_blockable(range))
-		mutex_lock(&priv->lock);
-	else if (!mutex_trylock(&priv->lock))
-		return -EAGAIN;
-
-	list_for_each_entry(map, &priv->maps, next) {
-		ret = unmap_if_in_range(map, range->start, range->end,
-					mmu_notifier_range_blockable(range));
-		if (ret)
-			goto out_unlock;
-	}
-	list_for_each_entry(map, &priv->freeable_maps, next) {
-		ret = unmap_if_in_range(map, range->start, range->end,
-					mmu_notifier_range_blockable(range));
-		if (ret)
-			goto out_unlock;
-	}
-
-out_unlock:
-	mutex_unlock(&priv->lock);
-
-	return ret;
-}
-
-static void mn_release(struct mmu_notifier *mn,
-		       struct mm_struct *mm)
-{
-	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
-	struct gntdev_grant_map *map;
-	int err;
-
-	mutex_lock(&priv->lock);
-	list_for_each_entry(map, &priv->maps, next) {
-		if (!map->vma)
-			continue;
-		pr_debug("map %d+%d (%lx %lx)\n",
-				map->index, map->count,
-				map->vma->vm_start, map->vma->vm_end);
-		err = unmap_grant_pages(map, /* offset */ 0, map->count);
-		WARN_ON(err);
-	}
-	list_for_each_entry(map, &priv->freeable_maps, next) {
-		if (!map->vma)
-			continue;
-		pr_debug("map %d+%d (%lx %lx)\n",
-				map->index, map->count,
-				map->vma->vm_start, map->vma->vm_end);
-		err = unmap_grant_pages(map, /* offset */ 0, map->count);
-		WARN_ON(err);
-	}
-	mutex_unlock(&priv->lock);
+	return true;
 }
 
-static const struct mmu_notifier_ops gntdev_mmu_ops = {
-	.release                = mn_release,
-	.invalidate_range_start = mn_invl_range_start,
+static const struct mmu_range_notifier_ops gntdev_mmu_ops = {
+	.invalidate = gntdev_invalidate,
 };
 
 /* ------------------------------------------------------------------ */
@@ -594,7 +513,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&priv->maps);
-	INIT_LIST_HEAD(&priv->freeable_maps);
 	mutex_init(&priv->lock);
 
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
@@ -606,17 +524,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	}
 #endif
 
-	if (use_ptemod) {
-		priv->mm = get_task_mm(current);
-		if (!priv->mm) {
-			kfree(priv);
-			return -ENOMEM;
-		}
-		priv->mn.ops = &gntdev_mmu_ops;
-		ret = mmu_notifier_register(&priv->mn, priv->mm);
-		mmput(priv->mm);
-	}
-
 	if (ret) {
 		kfree(priv);
 		return ret;
@@ -653,16 +560,12 @@ static int gntdev_release(struct inode *inode, struct file *flip)
 		list_del(&map->next);
 		gntdev_put_map(NULL /* already removed */, map);
 	}
-	WARN_ON(!list_empty(&priv->freeable_maps));
 	mutex_unlock(&priv->lock);
 
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
 	gntdev_dmabuf_fini(priv->dmabuf_priv);
 #endif
 
-	if (use_ptemod)
-		mmu_notifier_unregister(&priv->mn, priv->mm);
-
 	kfree(priv);
 	return 0;
 }
@@ -723,8 +626,6 @@ static long gntdev_ioctl_unmap_grant_ref(struct gntdev_priv *priv,
 	map = gntdev_find_map_index(priv, op.index >> PAGE_SHIFT, op.count);
 	if (map) {
 		list_del(&map->next);
-		if (populate_freeable_maps)
-			list_add_tail(&map->next, &priv->freeable_maps);
 		err = 0;
 	}
 	mutex_unlock(&priv->lock);
@@ -1096,11 +997,6 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto unlock_out;
 	if (use_ptemod && map->vma)
 		goto unlock_out;
-	if (use_ptemod && priv->mm != vma->vm_mm) {
-		pr_warn("Huh? Other mm?\n");
-		goto unlock_out;
-	}
-
 	refcount_inc(&map->users);
 
 	vma->vm_ops = &gntdev_vmops;
@@ -1111,10 +1007,6 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		vma->vm_flags |= VM_DONTCOPY;
 
 	vma->vm_private_data = map;
-
-	if (use_ptemod)
-		map->vma = vma;
-
 	if (map->flags) {
 		if ((vma->vm_flags & VM_WRITE) &&
 				(map->flags & GNTMAP_readonly))
@@ -1125,8 +1017,28 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 			map->flags |= GNTMAP_readonly;
 	}
 
+	if (use_ptemod) {
+		map->vma = vma;
+		err = mmu_range_notifier_insert_locked(
+			&map->notifier, vma->vm_start,
+			vma->vm_end - vma->vm_start, vma->vm_mm);
+		if (err)
+			goto out_unlock_put;
+	}
 	mutex_unlock(&priv->lock);
 
+	/*
+	 * gntdev takes the address of the PTE in find_grant_ptes() and passes
+	 * it to the hypervisor in gntdev_map_grant_pages(). The purpose of
+	 * the notifier is to prevent the hypervisor pointer to the PTE from
+	 * going stale.
+	 *
+	 * Since this vma's mappings can't be touched without the mmap_sem,
+	 * and we are holding it now, there is no need for the notifier_range
+	 * locking pattern.
+	 */
+	mmu_range_read_begin(&map->notifier);
+
 	if (use_ptemod) {
 		map->pages_vm_start = vma->vm_start;
 		err = apply_to_page_range(vma->vm_mm, vma->vm_start,
@@ -1175,8 +1087,11 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	mutex_unlock(&priv->lock);
 out_put_map:
 	if (use_ptemod) {
-		map->vma = NULL;
 		unmap_grant_pages(map, 0, map->count);
+		if (map->vma) {
+			mmu_range_notifier_remove(&map->notifier);
+			map->vma = NULL;
+		}
 	}
 	gntdev_put_map(priv, map);
 	return err;
-- 
2.23.0

