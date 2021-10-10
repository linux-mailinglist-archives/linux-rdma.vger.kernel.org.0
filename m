Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437CD4281A9
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Oct 2021 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhJJOKP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 10:10:15 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:26744 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232864AbhJJOKO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 10:10:14 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d78 with ME
        id 4E8D2600A4m3Hzu03E8DVM; Sun, 10 Oct 2021 16:08:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Oct 2021 16:08:15 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca, bharat@chelsio.com,
        yishaih@nvidia.com, bmt@zurich.ibm.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA: Remove redundant 'flush_workqueue()' calls
Date:   Sun, 10 Oct 2021 16:08:10 +0200
Message-Id: <ca7bac6e6c9c5cc8d04eec3944edb13de0e381a3.1633874776.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/core/sa_query.c        | 1 -
 drivers/infiniband/hw/cxgb4/cm.c          | 1 -
 drivers/infiniband/hw/cxgb4/device.c      | 1 -
 drivers/infiniband/hw/mlx4/alias_GUID.c   | 4 +---
 drivers/infiniband/sw/siw/siw_cm.c        | 4 +---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 1 -
 6 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index a20b8108e160..4220a545387f 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -2261,7 +2261,6 @@ int ib_sa_init(void)
 void ib_sa_cleanup(void)
 {
 	cancel_delayed_work(&ib_nl_timed_work);
-	flush_workqueue(ib_nl_wq);
 	destroy_workqueue(ib_nl_wq);
 	mcast_cleanup();
 	ib_unregister_client(&sa_client);
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 291471d12197..913f39ee4416 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -4464,6 +4464,5 @@ int __init c4iw_cm_init(void)
 void c4iw_cm_term(void)
 {
 	WARN_ON(!list_empty(&timeout_list));
-	flush_workqueue(workq);
 	destroy_workqueue(workq);
 }
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 541dbcf22d0e..80970a1738f8 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -1562,7 +1562,6 @@ static void __exit c4iw_exit_module(void)
 		kfree(ctx);
 	}
 	mutex_unlock(&dev_mutex);
-	flush_workqueue(reg_workq);
 	destroy_workqueue(reg_workq);
 	cxgb4_unregister_uld(CXGB4_ULD_RDMA);
 	c4iw_cm_term();
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 571d9c542024..e2e1f5daddc4 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -822,10 +822,8 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 		}
 		spin_unlock_irqrestore(&sriov->alias_guid.ag_work_lock, flags);
 	}
-	for (i = 0 ; i < dev->num_ports; i++) {
-		flush_workqueue(dev->sriov.alias_guid.ports_guid[i].wq);
+	for (i = 0 ; i < dev->num_ports; i++)
 		destroy_workqueue(dev->sriov.alias_guid.ports_guid[i].wq);
-	}
 	ib_sa_unregister_client(dev->sriov.alias_guid.sa_client);
 	kfree(dev->sriov.alias_guid.sa_client);
 }
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7a5ed86ffc9f..7acdd3c3a599 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1951,8 +1951,6 @@ int siw_cm_init(void)
 
 void siw_cm_exit(void)
 {
-	if (siw_cm_wq) {
-		flush_workqueue(siw_cm_wq);
+	if (siw_cm_wq)
 		destroy_workqueue(siw_cm_wq);
-	}
 }
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 0aa8629fdf62..9c9da5aa592a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1997,7 +1997,6 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 	if (priv->wq) {
 		/* See ipoib_mcast_carrier_on_task() */
 		WARN_ON(test_bit(IPOIB_FLAG_OPER_UP, &priv->flags));
-		flush_workqueue(priv->wq);
 		destroy_workqueue(priv->wq);
 		priv->wq = NULL;
 	}
-- 
2.30.2

