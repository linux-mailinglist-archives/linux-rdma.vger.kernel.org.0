Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540281FAECA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgFPK6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgFPK6v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:58:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAAE20786;
        Tue, 16 Jun 2020 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592305130;
        bh=E2fBSMSU5uZcCxn/1uWI5B3kEQC/l3+q95AWZkDObVo=;
        h=From:To:Cc:Subject:Date:From;
        b=YyBEPd03A6wuVlQRCfY+l4LGJTWauHUFU8sU/hW+m+PKPE6hNdup5sgLpNPDdPeN7
         jlGJqvUC/ZYRJ0nXiHK5ZaZn2u+0n/2uNz50l05CLEmnGMCrdj+N/7MMDNbjwyRWdh
         hUFjzBfov+5P45oNZvACAoR8cLFqc5IU7uSZ6mkI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/core: Check that type_attrs is not NULL prior access
Date:   Tue, 16 Jun 2020 13:58:13 +0300
Message-Id: <20200616105813.2428412-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

In disassociate flow, the type_attrs is set to be NULL, which is in
implicit way is checked in alloc_uobj() in "if (!attrs->context)" flow.
Change the logic to rely on that check, that will fix the following kernel
splat.

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 3 PID: 2743 Comm: python3 Not tainted 5.7.0-rc6-for-upstream-perf-2020-05-23_19-04-38-5 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
 RIP: 0010:alloc_begin_fd_uobject+0x18/0xf0 [ib_uverbs]
 Code: 89 43 48 eb 97 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 55 49 89 f5 41 54 55 48 89 fd 53 48 83 ec 08 48 8b 1f <48> 8b 43 18 48 8b 80 80 00 00 00 48 3d 20 10 33 a0 74 1c 48 3d 30
 RSP: 0018:ffffc90001127b70 EFLAGS: 00010282
 RAX: ffffffffa0339fe0 RBX: 0000000000000000 RCX: 8000000000000007
 RDX: fffffffffffffffb RSI: ffffc90001127d28 RDI: ffff88843fe1f600
 RBP: ffff88843fe1f600 R08: ffff888461eb06d8 R09: ffff888461eb06f8
 R10: ffff888461eb0700 R11: 0000000000000000 R12: ffff88846a5f6450
 R13: ffffc90001127d28 R14: ffff88845d7d6ea0 R15: ffffc90001127cb8
 FS: 00007f469bff1540(0000) GS:ffff88846f980000(0000) knlGS:0000000000000000
 CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000018 CR3: 0000000450018003 CR4: 0000000000760ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
 ? xa_store+0x28/0x40
 rdma_alloc_begin_uobject+0x4f/0x90 [ib_uverbs]
 ib_uverbs_create_comp_channel+0x87/0xf0 [ib_uverbs]
 ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xb1/0xf0 [ib_uverbs]
 ib_uverbs_cmd_verbs.isra.8+0x96d/0xae0 [ib_uverbs]
 ? get_page_from_freelist+0x3bb/0xf70
 ? _copy_to_user+0x22/0x30
 ? uverbs_disassociate_api+0xd0/0xd0 [ib_uverbs]
 ? __wake_up_common_lock+0x87/0xc0
 ib_uverbs_ioctl+0xbc/0x130 [ib_uverbs]
 ksys_ioctl+0x83/0xc0
 ? ksys_write+0x55/0xd0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x48/0x130
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f469ac43267

Fixes: 849e149063bd ("RDMA/core: Do not allow alloc_commit to fail")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c | 31 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 38de4942c682..16b86635d752 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -470,40 +470,41 @@ static struct ib_uobject *
 alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
 		       struct uverbs_attr_bundle *attrs)
 {
-	const struct uverbs_obj_fd_type *fd_type =
-		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
+	const struct uverbs_obj_fd_type *fd_type;
 	int new_fd;
 	struct ib_uobject *uobj;
 	struct file *filp;

+	uobj = alloc_uobj(attrs, obj);
+	if (IS_ERR(uobj))
+		return uobj;
+
+	fd_type =
+		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
 	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release &&
-		    fd_type->fops->release != &uverbs_async_event_release))
+		    fd_type->fops->release != &uverbs_async_event_release)) {
+		uverbs_uobject_put(uobj);
 		return ERR_PTR(-EINVAL);
+	}

 	new_fd = get_unused_fd_flags(O_CLOEXEC);
-	if (new_fd < 0)
+	if (new_fd < 0) {
+		uverbs_uobject_put(uobj);
 		return ERR_PTR(new_fd);
-
-	uobj = alloc_uobj(attrs, obj);
-	if (IS_ERR(uobj))
-		goto err_fd;
+	}

 	/* Note that uverbs_uobject_fd_release() is called during abort */
 	filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
 				  fd_type->flags);
 	if (IS_ERR(filp)) {
 		uverbs_uobject_put(uobj);
-		uobj = ERR_CAST(filp);
-		goto err_fd;
+		put_unused_fd(new_fd);
+		return ERR_CAST(filp);
 	}
-	uobj->object = filp;

+	uobj->object = filp;
 	uobj->id = new_fd;
 	return uobj;
-
-err_fd:
-	put_unused_fd(new_fd);
-	return uobj;
 }

 struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
--
2.26.2

