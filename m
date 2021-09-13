Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F1408870
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhIMJmn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 05:42:43 -0400
Received: from mail-m2837.qiye.163.com ([103.74.28.37]:15612 "EHLO
        mail-m2837.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbhIMJmm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Sep 2021 05:42:42 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 05:42:41 EDT
Received: from localhost.localdomain (unknown [106.75.220.3])
        by mail-m2837.qiye.163.com (Hmail) with ESMTPA id CA1216005A0;
        Mon, 13 Sep 2021 17:33:54 +0800 (CST)
From:   Tao Liu <thomas.liu@ucloud.cn>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        haakon.bugge@oracle.com, shayd@nvidia.com, avihaih@nvidia.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.liu@ucloud.com
Subject: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all() failure
Date:   Mon, 13 Sep 2021 17:33:44 +0800
Message-Id: <20210913093344.17230-1-thomas.liu@ucloud.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWRlMTk5WShpOGU9PTEgdGh
        9DVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6HCo6KDNNAQgPTDVDPiE6
        UTAKCQJVSlVKTUhKTklOTUhOT0tPVTMWGhIXVQ8TFBYaCFUXEg47DhgXFA4fVRgVRVlXWRILWUFZ
        SktNVUxOVUlJS1VIWVdZCAFZQUhOTEs3Bg++
X-HM-Tid: 0a7bde818421841fkuqwca1216005a0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rdma_cma_listen_on_all() just destroy listener which lead to an error,
but not including those already added in listen_list. Then cm state
fallbacks to RDMA_CM_ADDR_BOUND.

When user destroys id, the listeners will not be destroyed, and
process stucks.

 task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
 Call Trace:
  __schedule+0x29a/0x780
  ? free_unref_page_commit+0x9b/0x110
  schedule+0x3c/0xa0
  schedule_timeout+0x215/0x2b0
  ? __flush_work+0x19e/0x1e0
  wait_for_completion+0x8d/0xf0
  _destroy_id+0x144/0x210 [rdma_cm]
  ucma_close_id+0x2b/0x40 [rdma_ucm]
  __destroy_id+0x93/0x2c0 [rdma_ucm]
  ? __xa_erase+0x4a/0xa0
  ucma_destroy_id+0x9a/0x120 [rdma_ucm]
  ucma_write+0xb8/0x130 [rdma_ucm]
  vfs_write+0xb4/0x250
  ksys_write+0xb5/0xd0
  ? syscall_trace_enter.isra.19+0x123/0x190
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
---
 drivers/infiniband/core/cma.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c40791b..d8cea33 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1746,16 +1746,11 @@ static void cma_cancel_route(struct rdma_id_private *id_priv)
 	}
 }
 
-static void cma_cancel_listens(struct rdma_id_private *id_priv)
+static void _cma_cancel_listens(struct rdma_id_private *id_priv)
 {
 	struct rdma_id_private *dev_id_priv;
 
-	/*
-	 * Remove from listen_any_list to prevent added devices from spawning
-	 * additional listen requests.
-	 */
-	mutex_lock(&lock);
-	list_del(&id_priv->list);
+	lockdep_assert_held(&lock);
 
 	while (!list_empty(&id_priv->listen_list)) {
 		dev_id_priv = list_entry(id_priv->listen_list.next,
@@ -1768,6 +1763,18 @@ static void cma_cancel_listens(struct rdma_id_private *id_priv)
 		rdma_destroy_id(&dev_id_priv->id);
 		mutex_lock(&lock);
 	}
+}
+
+static void cma_cancel_listens(struct rdma_id_private *id_priv)
+{
+	/*
+	 * Remove from listen_any_list to prevent added devices from spawning
+	 * additional listen requests.
+	 */
+	mutex_lock(&lock);
+	list_del(&id_priv->list);
+
+	_cma_cancel_listens(id_priv);
 	mutex_unlock(&lock);
 }
 
@@ -2575,6 +2582,7 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
 
 err_listen:
 	list_del(&id_priv->list);
+	_cma_cancel_listens(id_priv);
 	mutex_unlock(&lock);
 	if (to_destroy)
 		rdma_destroy_id(&to_destroy->id);
-- 
1.8.3.1

