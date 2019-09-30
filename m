Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEBC1E2A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2019 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfI3JiH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 05:38:07 -0400
Received: from hr2.samba.org ([144.76.82.148]:16630 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbfI3JiG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Sep 2019 05:38:06 -0400
X-Greylist: delayed 1973 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 05:38:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-Id:Date:Cc:To:From;
        bh=zqgK4TKq5AjyZis1KXUpbTQ/RkluYjIwx9cMHd/BAek=; b=jiksKiJdxzgeoA76iCn21wcCHW
        7CgfCUSfzb37o8tczI9mfjuVutjMngDB2fgb4/Me7is6d/UCNTksPjzjR/WCKKMznguQHnwC4fxlH
        VEiQbaQUETSf/96BLkK2Je65pfrFH+O5TT30DdV2DM9T3ZF0wlSosDKRkJ0psLIVjXds=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1iErcE-0003BT-CH; Mon, 30 Sep 2019 09:05:10 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH] rdma/core: add __module_get()/module_put() to cma_[de]ref_dev()
Date:   Mon, 30 Sep 2019 11:04:55 +0200
Message-Id: <20190930090455.10772-1-metze@samba.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently there seems to be a problem when an RDMA listener or connection
is active on an ib_device.

'rmmod rdma_rxe' (the same for 'siw' and most likely all
others) just hangs like this until shutdown the listeners and
connections:

  [<0>] remove_client_context+0x97/0xe0 [ib_core]
  [<0>] disable_device+0x90/0x120 [ib_core]
  [<0>] __ib_unregister_device+0x41/0xa0 [ib_core]
  [<0>] ib_unregister_driver+0xbb/0x100 [ib_core]
  [<0>] rxe_module_exit+0x1a/0x8aa [rdma_rxe]
  [<0>] __x64_sys_delete_module+0x147/0x290
  [<0>] do_syscall_64+0x5a/0x130
  [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

The following would be expected:

  rmmod: ERROR: Module rdma_rxe is in use

And this change provides that.

Once all add listeners and connections are gone
the module can be removed again.

Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: stable@vger.kernel.org
---
 drivers/infiniband/core/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index a68d0ccf67a4..d10f3d01fa02 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -276,6 +276,7 @@ enum {
 void cma_ref_dev(struct cma_device *cma_dev)
 {
 	atomic_inc(&cma_dev->refcount);
+	__module_get(cma_dev->device->ops.owner);
 }
 
 struct cma_device *cma_enum_devices_by_ibdev(cma_device_filter	filter,
@@ -512,6 +513,7 @@ static void cma_attach_to_dev(struct rdma_id_private *id_priv,
 
 void cma_deref_dev(struct cma_device *cma_dev)
 {
+	module_put(cma_dev->device->ops.owner);
 	if (atomic_dec_and_test(&cma_dev->refcount))
 		complete(&cma_dev->comp);
 }
-- 
2.17.1

