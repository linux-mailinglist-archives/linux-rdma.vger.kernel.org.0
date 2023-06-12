Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42972B7CD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 07:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjFLFrw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjFLFrX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 01:47:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B501199C
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 22:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686548628; x=1718084628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bcQ9MAb6Kml0F+jmJRbrMByxY0+us5vRd5ZBKaPi0Q4=;
  b=K5P+fJfUOw6VIwhKgkZI4Mgpmt6Ynwtd9tDVd6vAcvAiCOJInlmVz9F5
   1ppdbJuQepD34jPhMSIXRjeeh3KAoluAMemNdEZi7Xjny/R1lQQq/wUuT
   juymSvRa6e2/iQu5RtsztK7WK3bfNp4vFgjBwmvYTPC4iADJYp7jHarVM
   cn0fUJHYzwAPf/BtZUpNGLo3J5X7KT/CwGxWzu+MJGqEjKUiqwWI1ExX/
   R75LeGSzkSbdka5oXFI3Y5d6eCpQt+hLnyAI4pEL5AyTHie6T9YpqOGka
   qB3wDQu1oRl/c6/4KnAh74OwK1ZXXFf8U+G1+blcexa4p/b+etgYgzOiM
   A==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681142400"; 
   d="scan'208";a="233473817"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2023 13:42:39 +0800
IronPort-SDR: FL+15qHHNOoP8W0o47XE2flx2qt1AgMFWv7E70O7WWy/7OkuYL6tfV1crIbNk4n+YLB63yO8cI
 wYAtm9HJriYTjxNxiAOK5zMxV5WKpeduTJl1z14OtGs+8BKJspSykaHEw//KKPuyxd0ZbYNxFM
 3uVfTMOOrPTT9/5wjX3XBBLeJr2DkyQC8N1iE2P7b1TCcK1r/YuGU7CNZVGWzCqZqst6YGBf3n
 cZBR7ccki3rAzmG7mzwpE5ADW9giyXt+LbnrAFUk8SyE0IWFt1L7lmD7VEBEesg5Uv6++n044T
 zW0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2023 21:51:36 -0700
IronPort-SDR: fQ1Xj7+ryZDGrYQITJqXcvKcl3qBuRoq+aUwL/uwwqZjVKrSlbNNdkrl28GGCun4GIovLyDkTh
 kLCNklyLjGZ+fJq9tAUCfwwo4BPZDykXDiAz4crKpWfz/iGC5HJ2zlpk5C1++XrPr49tb8wD5Z
 hDYcTazhaKOrlDKSAP0WP13zeRkQvPKXCOB6ho1UbsHxYrorvs0yfTCnkR6614Hl3wefqGGDpM
 Nb/ieHFl2TOF9yxGLVthj/+UizkwzLtR0kH/5ZfWPh7a4JuvJPM/g/e+iFYkvh3Kn7QceOzznV
 WIc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jun 2023 22:42:38 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-nvme@lists.infradead.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Date:   Mon, 12 Jun 2023 14:42:37 +0900
Message-Id: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
*id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler() [1].
To prevent the destroy of id_priv, keep its reference count by calling
cma_id_get() and cma_id_put() at start and end of cma_iw_handler().

[1]

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock+0x1324/0x18f0
Read of size 8 at addr ffff888197b37418 by task kworker/u8:0/9

CPU: 0 PID: 9 Comm: kworker/u8:0 Not tainted 6.3.0 #62
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x90
 print_report+0xcf/0x660
 ? __mutex_lock+0x1324/0x18f0
 kasan_report+0xa4/0xe0
 ? __mutex_lock+0x1324/0x18f0
 __mutex_lock+0x1324/0x18f0
 ? cma_iw_handler+0xac/0x4f0 [rdma_cm]
 ? _raw_spin_unlock_irqrestore+0x30/0x60
 ? rcu_is_watching+0x11/0xb0
 ? _raw_spin_unlock_irqrestore+0x30/0x60
 ? trace_hardirqs_on+0x12/0x100
 ? __pfx___mutex_lock+0x10/0x10
 ? __percpu_counter_sum+0x147/0x1e0
 ? domain_dirty_limits+0x246/0x390
 ? wb_over_bg_thresh+0x4d5/0x610
 ? rcu_is_watching+0x11/0xb0
 ? cma_iw_handler+0xac/0x4f0 [rdma_cm]
 cma_iw_handler+0xac/0x4f0 [rdma_cm]
 ? rcu_is_watching+0x11/0xb0
 ? __pfx_cma_iw_handler+0x10/0x10 [rdma_cm]
 ? attach_entity_load_avg+0x4e2/0x920
 ? _raw_spin_unlock_irqrestore+0x30/0x60
 ? rcu_is_watching+0x11/0xb0
 cm_work_handler+0x139e/0x1c50 [iw_cm]
 ? __pfx_cm_work_handler+0x10/0x10 [iw_cm]
 ? rcu_is_watching+0x11/0xb0
 ? __pfx_try_to_wake_up+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? __pfx___might_resched+0x10/0x10
 ? _raw_spin_unlock_irq+0x24/0x50
 process_one_work+0x843/0x1350
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx_process_one_work+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 worker_thread+0xfc/0x1260
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x29e/0x340
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>

Allocated by task 4225:
 kasan_save_stack+0x2f/0x50
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0xa6/0xb0
 __rdma_create_id+0x5b/0x5d0 [rdma_cm]
 __rdma_create_kernel_id+0x12/0x40 [rdma_cm]
 nvme_rdma_alloc_queue+0x26a/0x5f0 [nvme_rdma]
 nvme_rdma_setup_ctrl+0xb84/0x1d90 [nvme_rdma]
 nvme_rdma_create_ctrl+0x7b5/0xd20 [nvme_rdma]
 nvmf_dev_write+0xddd/0x22b0 [nvme_fabrics]
 vfs_write+0x211/0xd50
 ksys_write+0x100/0x1e0
 do_syscall_64+0x5b/0x80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Freed by task 4227:
 kasan_save_stack+0x2f/0x50
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x50
 ____kasan_slab_free+0x169/0x1c0
 slab_free_freelist_hook+0xdb/0x1b0
 __kmem_cache_free+0xb8/0x2e0
 nvme_rdma_free_queue+0x4a/0x70 [nvme_rdma]
 nvme_rdma_teardown_io_queues.part.0+0x14a/0x1e0 [nvme_rdma]
 nvme_rdma_delete_ctrl+0x4f/0x100 [nvme_rdma]
 nvme_do_delete_ctrl+0x14e/0x240 [nvme_core]
 nvme_sysfs_delete+0xcb/0x100 [nvme_core]
 kernfs_fop_write_iter+0x359/0x530
 vfs_write+0x58f/0xd50
 ksys_write+0x100/0x1e0
 do_syscall_64+0x5b/0x80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

The buggy address belongs to the object at ffff888197b37000
        which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1048 bytes inside of
        freed 2048-byte region [ffff888197b37000, ffff888197b37800)

The buggy address belongs to the physical page:
page:00000000fbe33a6e refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x197b30
head:00000000fbe33a6e order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0010200 ffff888100042f00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888197b37300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888197b37380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888197b37400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888197b37480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888197b37500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: de910bd92137 ("RDMA/cma: Simplify locking needed for serialization of callbacks")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org
---
The BUG KASAN was observed with blktests at test cases nvme/030 or nvme/031,
using SIW transport [*]. To reproduce it, it is required to repeat the test
cases from 30 to 50 times on my test system.

[*] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

Changes from v1:
* Improved the commit message per comments on the list

 drivers/infiniband/core/cma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 93a1c48d0c32..c5267d9bb184 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2477,6 +2477,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	struct sockaddr *laddr = (struct sockaddr *)&iw_event->local_addr;
 	struct sockaddr *raddr = (struct sockaddr *)&iw_event->remote_addr;
 
+	cma_id_get(id_priv);
 	mutex_lock(&id_priv->handler_mutex);
 	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		goto out;
@@ -2524,12 +2525,14 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
+		cma_id_put(id_priv);
 		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
 
 out:
 	mutex_unlock(&id_priv->handler_mutex);
+	cma_id_put(id_priv);
 	return ret;
 }
 
-- 
2.40.1

