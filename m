Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64EED142A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfJIQgR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:36:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44782 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIQgR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:36:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so4258130qth.11
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rgj+Em+k5g8VITkwsSO4Kk3ctS7hLkQ0A4Swm0wJxDs=;
        b=VmUl94XenE+Dj005g/a4KtY87W73ts+nGnbmOeydX/I0M8fG6DA/fTfgQLe2Sk1fx+
         9h1dr7UIY6uCnvkmcG6yfAhzrqJBd18JNH56F5JVFt9ixKfhPCvu7YTqZvWMLyRmoPAR
         Er4h27Kn+8PBrCw2HxMXzxqZMyqHei516al5DwtRoxOSFZfj8BnLFJkBleuNmI7LAQpt
         ZaHYLL+xPidWWsnlTgHAAE5n1+JYXOBx1TwPVsHlOUAokP3UCGiKNaN2MFF2Vk5oLWd7
         wZ9Oy7bZMxg8tFjf2P9vMFTqkFD2qXgjYFltrODYjBl/IdwWR+/ePoJ0Fe9JKMaU70Mk
         qi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rgj+Em+k5g8VITkwsSO4Kk3ctS7hLkQ0A4Swm0wJxDs=;
        b=YGzCxggme/pQ9xTncEpEm8R7m/fts3216Ii7WGZtUDkH56kmnNC1H79iZKzGr2SMQZ
         RTFU+ZFo98tEJ1duuc+KAl1s4baPh1myrzjMBiSgut6ouLBfP90ztD94HJSq8zZOBKan
         gGgRNUUi9npmQVYFxzDh6VmNbCz7UhUA/5BgrHlE2Ql7RK6UbhSkW6qP4gcJ3bhjoPOp
         vR5N0uu71toNwdB7oVbAYdEdo2uUBhE4hCbMe+e8g/mnZ2fxSQUg+mpVHAL7XMXUpAPL
         Q21i7oHQ8KZ7jqg61mbX7nDfK8/rZbuWxWBixjWqF9ZY4EItMYLkseABgO760ONaUVNQ
         efZQ==
X-Gm-Message-State: APjAAAXIeNNnQnQ7yOLZiMCcVEx00lfi9FA0e0GnSb9AQBR09Vz1lTEC
        /8MKya8inxmz5JWWumEhqyldWD1buGE=
X-Google-Smtp-Source: APXvYqy93mYAEiamt7JHN95mxOF7yk1idgL0/g/oIzAfYx+WMaMGCBVCUBvGqZoDfkJTW+rRLz+Eeg==
X-Received: by 2002:ac8:2d87:: with SMTP id p7mr4655187qta.198.1570638975509;
        Wed, 09 Oct 2019 09:36:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id n17sm1208530qke.103.2019.10.09.09.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:36:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000rT-9M; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 13/15] RDMA/mlx5: Do not store implicit children in the odp_mkeys xarray
Date:   Wed,  9 Oct 2019 13:09:33 -0300
Message-Id: <20191009160934.3143-14-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

These mkeys are entirely internal and are never used by the HW for
page fault. They should also never be used by userspace for prefetch.
Simplify & optimize things by not including them in the xarray.

Since the prefetch path can now never see a child mkey there is no need
for the second synchronize_srcu() during imr destroy.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 36 ++++++--------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 71f8580b25b2ab..66523313c3e46c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -146,9 +146,9 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 
 /*
  * This must be called after the mr has been removed from implicit_children
- * and odp_mkeys and the SRCU synchronized.  NOTE: The MR does not necessarily
- * have to be empty here, parallel page faults could have raced with the free
- * process and added pages to it.
+ * and the SRCU synchronized.  NOTE: The MR does not necessarily have to be
+ * empty here, parallel page faults could have raced with the free process and
+ * added pages to it.
  */
 static void free_implicit_child_mr(struct mlx5_ib_mr *mr, bool need_imr_xlt)
 {
@@ -210,7 +210,6 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	    mr)
 		goto out_unlock;
 
-	__xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
 	atomic_inc(&imr->num_deferred_work);
 	call_srcu(&mr->dev->odp_srcu, &mr->odp_destroy.rcu,
 		  free_implicit_child_mr_rcu);
@@ -401,13 +400,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(mr))
 		goto out_umem;
 
-	err = xa_reserve(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-			 GFP_KERNEL);
-	if (err) {
-		ret = ERR_PTR(err);
-		goto out_mr;
-	}
-
 	mr->ibmr.pd = imr->ibmr.pd;
 	mr->access_flags = imr->access_flags;
 	mr->umem = &odp->umem;
@@ -424,7 +416,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 				 MLX5_IB_UPD_XLT_ENABLE);
 	if (err) {
 		ret = ERR_PTR(err);
-		goto out_release;
+		goto out_mr;
 	}
 
 	/*
@@ -433,26 +425,21 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	 */
 	ret = xa_cmpxchg(&imr->implicit_children, idx, NULL, mr,
 			 GFP_KERNEL);
-	if (likely(!ret))
-		xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-			 &mr->mmkey, GFP_ATOMIC);
 	if (unlikely(ret)) {
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
-			goto out_release;
+			goto out_mr;
 		}
 		/*
 		 * Another thread beat us to creating the child mr, use
 		 * theirs.
 		 */
-		goto out_release;
+		goto out_mr;
 	}
 
 	mlx5_ib_dbg(imr->dev, "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
-out_release:
-	xa_release(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
 out_mr:
 	mlx5_mr_cache_free(imr->dev, mr);
 out_umem:
@@ -535,14 +522,10 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 	xa_lock(&imr->implicit_children);
 	xa_for_each (&imr->implicit_children, idx, mtt) {
 		__xa_erase(&imr->implicit_children, idx);
-		__xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mtt->mmkey.key));
 		list_add(&mtt->odp_destroy.elm, &destroy_list);
 	}
 	xa_unlock(&imr->implicit_children);
 
-	/* Fence access to the child pointers via the pagefault thread */
-	synchronize_srcu(&dev->odp_srcu);
-
 	/*
 	 * num_deferred_work can only be incremented inside the odp_srcu, or
 	 * under xa_lock while the child is in the xarray. Thus at this point
@@ -1655,13 +1638,6 @@ get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
 	if (mr->ibmr.pd != pd)
 		return NULL;
 
-	/*
-	 * Implicit child MRs are internal and userspace should not refer to
-	 * them.
-	 */
-	if (mr->parent)
-		return NULL;
-
 	odp = to_ib_umem_odp(mr->umem);
 
 	/* prefetch with write-access must be supported by the MR */
-- 
2.23.0

