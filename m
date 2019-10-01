Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20229C393B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfJAPih (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33112 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfJAPih (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so11692954qkb.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8IPBG3dgj2MA8wIPbTYtDxNXlAPNZNoDy7J6NM8bRQ=;
        b=FXHq4hOeiYiYpL8i2etxTsNt5Z+cjnttDjILRPclKw4ytfydwQO19NkaZqZmVFSx4t
         60CK5IwCyOJ4zlHpT7W40Y37I7WJNlEaRLY0RDUyswXFLEq2cK8VCR+2kn+rC1BS1duF
         u9EKJffL+sO6QXnyeK/YsJyEH4DXsylVd6BkMlHpAYswvnTIEDRsYkcbU0Yr2bJYOt15
         qqfJmyIJ13vBw+tn6PRUhiP9lEpuKTjWFGhpIqy0tBnn9S1r9IhJ+xuHTmGipDYYS2kl
         aCJZqkf1YyL2g/xC8finzEichRaX2HprDdC3KiPlPDAdyB7fkW2PpWp0EUDsTtgqAgcs
         kbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8IPBG3dgj2MA8wIPbTYtDxNXlAPNZNoDy7J6NM8bRQ=;
        b=imQQwvZu688mHNL1/OSttvfUyH9P3pXJKiEqJcudPs3GXaGmV5nX7QAUSFJaTy1ENP
         fc0QDAM6+DXhXg86mCbYwAZJriyBqTimZyKhupA/WuUAGvuGZoq6j3KYgx5bgNOwxbBv
         jarJwMjWCATXVAFZ7X7HZ9mtuX/u/ECdhodly9uB0n0vq3WWyghIa4Ut4vOyfl4MrKzV
         8VcL8MsmcqNFdty+QSvZq5lenQB+pfOKeWngspMg1Dwm8r4X67ICZFkq8zPn7WZc6wqd
         XsQT7urpxy6VBgz2oq4q2E0S+OvnkhZ3SP7jQGa3hrT4S578v8zubCZEeUlk7mx0PQSI
         L/cw==
X-Gm-Message-State: APjAAAWB/uKIEVojCuF36Q2oCu3/1iO8lHq4+Zk6DibNU6XbziL2LBMY
        XsqlhFa8t/mptHfC/PJ8/wh8KGpANuM=
X-Google-Smtp-Source: APXvYqzIs39si8HJ7MjjT0NVAxrhbR6lILeTrTWwe9Y92gprg7fsZI1qwJhLLHuC+SE5FLyJMgE7ng==
X-Received: by 2002:a37:4a85:: with SMTP id x127mr6545943qka.362.1569944315715;
        Tue, 01 Oct 2019 08:38:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 29sm7681743qkp.86.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKEU-0006Ed-1f; Tue, 01 Oct 2019 12:38:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 2/6] RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an implicit MR
Date:   Tue,  1 Oct 2019 12:38:17 -0300
Message-Id: <20191001153821.23621-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

mlx5_ib_update_xlt() must be protected against parallel free of the MR it
is accessing, also it must be called single threaded while updating the
HW. Otherwise we can have races of the form:

    CPU0                               CPU1
  mlx5_ib_update_xlt()
   mlx5_odp_populate_klm()
     odp_lookup() == NULL
     pklm = ZAP
                                      implicit_mr_get_data()
 				        implicit_mr_alloc()
 					  <update interval tree>
					mlx5_ib_update_xlt
					  mlx5_odp_populate_klm()
					    odp_lookup() != NULL
					    pklm = VALID
					   mlx5_ib_post_send_wait()

    mlx5_ib_post_send_wait() // Replaces VALID with ZAP

This can be solved by putting both the SRCU and the umem_mutex lock around
every call to mlx5_ib_update_xlt(). This ensures that the content of the
interval tree relavent to mlx5_odp_populate_klm() (ie mr->parent == mr)
will not change while it is running, and thus the posted WRs to update the
KLM will always reflect the correct information.

The race above will resolve by either having CPU1 wait till CPU0 completes
the ZAP or CPU0 will run after the add and instead store VALID.

The pagefault path adding children already holds the umem_mutex and SRCU,
so the only missed lock is during MR destruction.

Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 34 ++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 2e9b4306179745..3401c06b7e54f5 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -178,6 +178,29 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
 		return;
 	}
 
+	/*
+	 * The locking here is pretty subtle. Ideally the implicit children
+	 * list would be protected by the umem_mutex, however that is not
+	 * possible. Instead this uses a weaker update-then-lock pattern:
+	 *
+	 *  srcu_read_lock()
+	 *    <change children list>
+	 *    mutex_lock(umem_mutex)
+	 *     mlx5_ib_update_xlt()
+	 *    mutex_unlock(umem_mutex)
+	 *    destroy lkey
+	 *
+	 * ie any change the children list must be followed by the locked
+	 * update_xlt before destroying.
+	 *
+	 * The umem_mutex provides the acquire/release semantic needed to make
+	 * the children list visible to a racing thread. While SRCU is not
+	 * technically required, using it gives consistent use of the SRCU
+	 * locking around the children list.
+	 */
+	lockdep_assert_held(&to_ib_umem_odp(mr->umem)->umem_mutex);
+	lockdep_assert_held(&mr->dev->mr_srcu);
+
 	odp = odp_lookup(offset * MLX5_IMR_MTT_SIZE,
 			 nentries * MLX5_IMR_MTT_SIZE, mr);
 
@@ -202,15 +225,22 @@ static void mr_leaf_free_action(struct work_struct *work)
 	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
 	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;
+	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
+	int srcu_key;
 
 	mr->parent = NULL;
 	synchronize_srcu(&mr->dev->mr_srcu);
 
-	ib_umem_odp_release(odp);
-	if (imr->live)
+	if (imr->live) {
+		srcu_key = srcu_read_lock(&mr->dev->mr_srcu);
+		mutex_lock(&odp_imr->umem_mutex);
 		mlx5_ib_update_xlt(imr, idx, 1, 0,
 				   MLX5_IB_UPD_XLT_INDIRECT |
 				   MLX5_IB_UPD_XLT_ATOMIC);
+		mutex_unlock(&odp_imr->umem_mutex);
+		srcu_read_unlock(&mr->dev->mr_srcu, srcu_key);
+	}
+	ib_umem_odp_release(odp);
 	mlx5_mr_cache_free(mr->dev, mr);
 
 	if (atomic_dec_and_test(&imr->num_leaf_free))
-- 
2.23.0

