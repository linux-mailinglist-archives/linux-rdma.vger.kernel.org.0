Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68511FC7D5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFQHqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:37 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37757 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbgFQHqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:36 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTO9017663;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTU3007210;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kT50007209;
        Wed, 17 Jun 2020 10:46:29 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 12/13] Documentation: Add usage example for verbs import
Date:   Wed, 17 Jun 2020 10:45:55 +0300
Message-Id: <1592379956-7043-13-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

Add a documentation for shared PD and verbs import usage in Pyverbs.
This includes a code snippet to demonstrate a usage example.

Reviewed-by: Ido Kalir <idok@mellanox.com>
Signed-off-by: Edward Srouji <edwards@mellanox.com>
---
 Documentation/pyverbs.md | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index 77a5406..2516b10 100755
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -626,3 +626,43 @@ ctx = Context(name='rocep0s8f0')
 uar = Mlx5UAR(ctx)
 uar.close()
 ```
+
+##### Import device, PD and MR
+Importing a device, PD and MR enables processes to share their context and then
+share PDs and MRs that is associated with.
+A process creates a device and then uses some of the Linux systems calls to dup
+its 'cmd_fd' member which lets other process to obtain ownership.
+Once other process obtains the 'cmd_fd' it can import the device, then PD(s) and
+MR(s) to share these objects.
+Like in C, Pyverbs users are responsible for unimporting the imported objects
+(which will also close the Pyverbs instance in our case) after they finish using
+them, and they have to sync between the different processes in order to
+coordinate the closure of the objects.
+Unlike in C, closing the underlying objects is currently supported only via the
+"original" object (meaning only by the process that creates them) and not via
+the imported object. This limitation is made because currently there's no
+reference or relation between different Pyverbs objects in different processes.
+But it's doable and might be added in the future.
+Here is a demonstration of importing a device, PD and MR in one process.
+```python
+from pyverbs.device import Context
+from pyverbs.pd import PD
+from pyverbs.mr import MR
+import pyverbs.enums as e
+import os
+
+ctx = Context(name='ibp0s8f0')
+pd = PD(ctx)
+mr = MR(pd, 100, e.IBV_ACCESS_LOCAL_WRITE)
+cmd_fd_dup = os.dup(ctx.cmd_fd)
+improted_ctx = Context(cmd_fd=cmd_fd_dup)
+imported_pd = PD(improted_ctx, handle=pd.handle)
+imported_mr = MR(imported_pd, handle=mr.handle)
+# MRs can be created as usual on the imported PD
+secondary_mr = MR(imported_pd, 100, e.IBV_ACCESS_REMOTE_READ)
+# Must manually unimport the imported objects (which close the object and frees
+# other resources that use them) before closing the "original" objects.
+# This prevents unexpected behaviours caused by the GC.
+imported_mr.unimport()
+imported_pd.unimport()
+```
-- 
1.8.3.1

