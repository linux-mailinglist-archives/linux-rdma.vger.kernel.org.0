Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77797C2ABF
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfI3XRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41727 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbfI3XRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so6483017pfh.8
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUSAgCJXEgMrQIQdTaSDbcphVPmwFXISsrnMoNw0POQ=;
        b=l2KvaFBMtoLA83sVwToJBNcbs9SGi6mi2FYmApeco4GVafU6xK/kdr0BGb4S6XqOQG
         pwYOL94lpWevIvKepIdOhqhywPhgPibI7CDM+emH3lLX8oRhAGhdoKpzbYJ8KNmYCoTZ
         VZG5rrHfzoLrKcFMWy6WEKlkllgPm+y13enRdkqiTCmp53I2kiKFKqXyGZ+92jmkhcla
         Dvta0harqm8MUPR7nJexUOV3o+DWWeZNRf1gcHATDOgk8kqlxvWugFu+ZJ+m+t/NyN/a
         qSgw374IU+lva1bbQrKYHU+2RdjbDiWXKoAQMk4UoQMKbFADn2kFwKb5ChY29ZW4Zjpa
         R5vQ==
X-Gm-Message-State: APjAAAUxPznkIm5Y9l2d93G2KsPy+4bOqe7iGCNJmTsHmXoGGxZsdcz/
        YcjZ9906XMdNMTV3Yhh48og=
X-Google-Smtp-Source: APXvYqwDBL/13dFIL8m7i0Hr/g/u8erz1zeFUGl8h78AYw+2rwdQekto+D6tZlW8RWd4hVUUZ4PXIQ==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr26254605pgc.435.1569885459527;
        Mon, 30 Sep 2019 16:17:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 15/15] RDMA/srpt: Postpone HCA removal until after configfs directory removal
Date:   Mon, 30 Sep 2019 16:17:07 -0700
Message-Id: <20190930231707.48259-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A shortcoming of the SCSI target core is that it does not have an API
for removing tpg or wwn objects. Wait until these directories have been
removed before allowing HCA removal to finish.

See also Bart Van Assche, "Re: Why using configfs as the only interface is
wrong for a storage target", 2011-02-07
(https://www.spinics.net/lists/linux-scsi/msg50248.html).

This patch fixes the following kernel crash:

==================================================================
BUG: KASAN: use-after-free in __configfs_open_file.isra.4+0x1a8/0x400
Read of size 8 at addr ffff88811880b690 by task restart-lio-srp/1215

CPU: 1 PID: 1215 Comm: restart-lio-srp Not tainted 5.3.0-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xca
 print_address_description+0x74/0x32d
 __kasan_report.cold.6+0x1b/0x36
 kasan_report+0x12/0x17
 __asan_load8+0x54/0x90
 __configfs_open_file.isra.4+0x1a8/0x400
 configfs_open_file+0x13/0x20
 do_dentry_open+0x2b1/0x770
 vfs_open+0x58/0x60
 path_openat+0x5fa/0x14b0
 do_filp_open+0x115/0x180
 do_sys_open+0x1d4/0x2a0
 __x64_sys_openat+0x59/0x70
 do_syscall_64+0x6b/0x2d0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f2f2bd3fcce
Code: 25 00 00 41 00 3d 00 00 41 00 74 48 48 8d 05 19 d7 0d 00 8b 00 85 c0 75 69 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a6 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
RSP: 002b:00007ffd155f7850 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000564609ba88e0 RCX: 00007f2f2bd3fcce
RDX: 0000000000000241 RSI: 0000564609ba8cf0 RDI: 00000000ffffff9c
RBP: 00007ffd155f7950 R08: 0000000000000000 R09: 0000000000000020
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000001 R15: 0000564609ba8cf0

Allocated by task 995:
 save_stack+0x21/0x90
 __kasan_kmalloc.constprop.9+0xc7/0xd0
 kasan_kmalloc+0x9/0x10
 __kmalloc+0x153/0x370
 srpt_add_one+0x4f/0x561 [ib_srpt]
 add_client_context+0x251/0x290 [ib_core]
 ib_register_client+0x1da/0x220 [ib_core]
 iblock_get_alignment_offset_lbas+0x6b/0x100 [target_core_iblock]
 do_one_initcall+0xcd/0x43a
 do_init_module+0x103/0x380
 load_module+0x3b77/0x3eb0
 __do_sys_finit_module+0x12d/0x1b0
 __x64_sys_finit_module+0x43/0x50
 do_syscall_64+0x6b/0x2d0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 1221:
 save_stack+0x21/0x90
 __kasan_slab_free+0x139/0x190
 kasan_slab_free+0xe/0x10
 slab_free_freelist_hook+0x67/0x1e0
 kfree+0xcb/0x2a0
 srpt_remove_one+0x596/0x670 [ib_srpt]
 remove_client_context+0x9a/0xe0 [ib_core]
 disable_device+0x106/0x1b0 [ib_core]
 __ib_unregister_device+0x5f/0xf0 [ib_core]
 ib_unregister_driver+0x11a/0x170 [ib_core]
 0xffffffffa087f666
 __x64_sys_delete_module+0x1f8/0x2c0
 do_syscall_64+0x6b/0x2d0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88811880b300
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 912 bytes inside of
 4096-byte region [ffff88811880b300, ffff88811880c300)
The buggy address belongs to the page:
page:ffffea0004620200 refcount:1 mapcount:0 mapping:ffff88811ac0de00 index:0x0 compound_mapcount: 0
flags: 0x2fff000000010200(slab|head)
raw: 2fff000000010200 dead000000000100 dead000000000122 ffff88811ac0de00
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811880b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811880b600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811880b680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88811880b700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811880b780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 0582b3d4ec4d..daf811abf40a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2921,7 +2921,7 @@ static int srpt_release_sport(struct srpt_port *sport)
 
 	while (atomic_read(&sport->refcount) > 0 &&
 	       wait_for_completion_timeout(&c, 5 * HZ) <= 0) {
-		pr_info("%s_%d: waiting for unregistration of %d sessions ...\n",
+		pr_info("%s_%d: waiting for unregistration of %d sessions and configfs directories ...\n",
 			dev_name(&sport->sdev->device->dev), sport->port,
 			atomic_read(&sport->refcount));
 		rcu_read_lock();
@@ -3732,6 +3732,8 @@ static struct se_portal_group *srpt_make_tpg(struct se_wwn *wwn,
 	if (res)
 		return ERR_PTR(res);
 
+	atomic_inc(&sport->refcount);
+
 	return tpg;
 }
 
@@ -3745,6 +3747,7 @@ static void srpt_drop_tpg(struct se_portal_group *tpg)
 
 	sport->enabled = false;
 	core_tpg_deregister(tpg);
+	srpt_drop_sport_ref(sport);
 }
 
 /**
-- 
2.23.0.444.g18eeb5a265-goog

