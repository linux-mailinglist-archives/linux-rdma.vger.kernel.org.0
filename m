Return-Path: <linux-rdma+bounces-13805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465AABC6794
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 21:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6AE40481E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E972566E2;
	Wed,  8 Oct 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSWAC1qs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A22417F0
	for <linux-rdma@vger.kernel.org>; Wed,  8 Oct 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951747; cv=none; b=my+JyO8LLfDJhxSVd/j5QRyVPUsv2HLYzXlA9Kd0gH9J0Pv6U7hyCdkC3IwyHpu+/9SW2VqVnIHsAu/nyOqghQCKcRkG/R9o2U2DZnXuJlY7e8YyW5WmixnUMA3ZAZ+I7+EAA5QjVZrgo4B5wwhg2VO0JtcCzQa+5y/OWIWYSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951747; c=relaxed/simple;
	bh=u/H8oDeoW+BqGGZThVowoRlZtyvAaYaTRqKBExRBXmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRA1qtjxJTWOwpSlbBdKfSEQvny4DLNjCjXNbV7gaHGcFi3jbgfbfH6WsOcDrigmOOToWs+Q3oMF25//rwA+0aZ/XZXiZgClVDJfNWGzgVRyRSy1CI/qvmzyxhwYBJDwqgqLjSPcckREYPIdO+qkIhUD7IUCT96KjZze9e4r10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSWAC1qs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759951744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=idQoBc0h+p4BoqF0vp4i23/4bGkj1q+Al+uYte3sS5E=;
	b=HSWAC1qs/LA8CLEqyTAQ6puAUIBy8THXlvmJmHqJGrzFlF3nlb7TIFdaBb6ObhpU+hy/9w
	lDImGq40SkSbHmIbJT9IlxXsbViC0s7zYJfBm/iTxgj+dJe5zi2PAGS7WY5H1Cqvh385AM
	V4eJQcMdBnTMOwO7ipAoc3wdtdEBcfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-vMya6t9SPpabzWgifmO_cg-1; Wed,
 08 Oct 2025 15:28:58 -0400
X-MC-Unique: vMya6t9SPpabzWgifmO_cg-1
X-Mimecast-MFC-AGG-ID: vMya6t9SPpabzWgifmO_cg_1759951738
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC0F2180047F;
	Wed,  8 Oct 2025 19:28:57 +0000 (UTC)
Received: from lima-fedora.redhat.com (unknown [10.22.65.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CF543000198;
	Wed,  8 Oct 2025 19:28:56 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-next] RDMA/cxgb4: Fix possible circular locking dependency
Date: Wed,  8 Oct 2025 15:28:37 -0400
Message-ID: <20251008192837.481193-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Holding dev_mutex across c4iw_remove() during module exit can lead to a
lockdep warning and potential deadlock. The RDMA core takes global
locks (e.g. devices_rwsem) inside ib_unregister_device(), which may
conflict with the locking order used elsewhere in the driver.

 ======================================================
 WARNING: possible circular locking dependency detected
 6.12.0-124.5.1.el10_1.x86_64+debug #1 Not tainted
 ------------------------------------------------------
 rmmod/3524 is trying to acquire lock:
 ffffffffc1c0dd18 (devices_rwsem){++++}-{4:4}, at: disable_device+0xaf/0x240 [ib_core]

 but task is already holding lock:
 ffff889104e44708 (&device->unregistration_lock){+.+.}-{4:4}, at: __ib_unregister_device+0x209/0x460 [ib_core]

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #6 (&device->unregistration_lock){+.+.}-{4:4}:
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        __mutex_lock+0x18b/0x12b0
        __ib_unregister_device+0x209/0x460 [ib_core]
        ib_unregister_device+0x25/0x30 [ib_core]
        c4iw_remove+0xce/0xda [iw_cxgb4]
        c4iw_exit_module+0x7d/0xe0 [iw_cxgb4]
        __do_sys_delete_module.isra.0+0x33a/0x540
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #5 (dev_mutex){+.+.}-{4:4}:
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        __mutex_lock+0x18b/0x12b0
        c4iw_uld_add+0x137/0x500 [iw_cxgb4]
        uld_attach+0x908/0xd80 [cxgb4]
        cxgb4_uld_alloc_resources.part.0+0x364/0x1120 [cxgb4]
        cxgb4_register_uld+0x10c/0x400 [cxgb4]
        c4iw_init_module+0x77/0x80 [iw_cxgb4]
        do_one_initcall+0xa5/0x260
        do_init_module+0x238/0x7c0
        init_module_from_file+0xdf/0x150
        idempotent_init_module+0x230/0x770
        __x64_sys_finit_module+0xbe/0x130
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #4 (uld_mutex){+.+.}-{4:4}:
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        __mutex_lock+0x18b/0x12b0
        cxgb_up+0x24/0xee0 [cxgb4]
        cxgb_open+0x7e/0x250 [cxgb4]
        __dev_open+0x241/0x420
        __dev_change_flags+0x44c/0x660
        dev_change_flags+0x80/0x160
        do_setlink+0x1acd/0x23e0
        __rtnl_newlink+0xb07/0xe40
        rtnl_newlink+0x62/0x90
        rtnetlink_rcv_msg+0x2f3/0xb20
        netlink_rcv_skb+0x13d/0x3b0
        netlink_unicast+0x42e/0x720
        netlink_sendmsg+0x765/0xc20
        ____sys_sendmsg+0x974/0xc60
        ___sys_sendmsg+0xfd/0x180
        __sys_sendmsg+0xe8/0x190
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #3 (rtnl_mutex){+.+.}-{4:4}:
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        __mutex_lock+0x18b/0x12b0
        ib_get_eth_speed+0xee/0x9d0 [ib_core]
        ib_query_port+0x140/0x1f0 [ib_core]
        ib_setup_port_attrs+0x1a5/0x4c0 [ib_core]
        add_one_compat_dev+0x4bd/0x7b0 [ib_core]
        rdma_dev_init_net+0x257/0x3e0 [ib_core]
        ops_init+0x109/0x300
        setup_net+0x1c4/0x730
        copy_net_ns+0x23b/0x540
        create_new_namespaces+0x358/0x920
        unshare_nsproxy_namespaces+0x8a/0x1b0
        ksys_unshare+0x2df/0x740
        __x64_sys_unshare+0x31/0x40
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #2 (&device->compat_devs_mutex){+.+.}-{4:4}:
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        __mutex_lock+0x18b/0x12b0
        add_one_compat_dev+0xe0/0x7b0 [ib_core]
        rdma_dev_init_net+0x257/0x3e0 [ib_core]
        ops_init+0x109/0x300
        setup_net+0x1c4/0x730
        copy_net_ns+0x23b/0x540
        create_new_namespaces+0x358/0x920
        unshare_nsproxy_namespaces+0x8a/0x1b0
        ksys_unshare+0x2df/0x740
        __x64_sys_unshare+0x31/0x40
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #1 (rdma_nets_rwsem){++++}-{4:4}:
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        down_read+0xa3/0x4b0
        enable_device_and_get+0x26b/0x350 [ib_core]
        ib_register_device+0x1c3/0x4f0 [ib_core]
        bnxt_re_ib_init+0x433/0x530 [bnxt_re]
        bnxt_re_add_device+0x60d/0x760 [bnxt_re]
        bnxt_re_probe+0xcf/0x140 [bnxt_re]
        auxiliary_bus_probe+0xa1/0xf0
        really_probe+0x1e0/0x8a0
        __driver_probe_device+0x18c/0x370
        driver_probe_device+0x4a/0x120
        __driver_attach+0x194/0x4a0
        bus_for_each_dev+0x106/0x190
        bus_add_driver+0x2a1/0x4d0
        driver_register+0x1a5/0x360
        __auxiliary_driver_register+0x152/0x240
        c4iw_init_module+0x43/0x80 [iw_cxgb4]
        do_one_initcall+0xa5/0x260
        do_init_module+0x238/0x7c0
        init_module_from_file+0xdf/0x150
        idempotent_init_module+0x230/0x770
        __x64_sys_finit_module+0xbe/0x130
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (devices_rwsem){++++}-{4:4}:
        check_prev_add+0xf1/0xce0
        validate_chain+0x481/0x560
        __lock_acquire+0x559/0xb80
        lock_acquire.part.0+0xbe/0x270
        down_write+0x99/0x220
        disable_device+0xaf/0x240 [ib_core]
        __ib_unregister_device+0x26f/0x460 [ib_core]
        ib_unregister_device+0x25/0x30 [ib_core]
        c4iw_remove+0xce/0xda [iw_cxgb4]
        c4iw_exit_module+0x7d/0xe0 [iw_cxgb4]
        __do_sys_delete_module.isra.0+0x33a/0x540
        do_syscall_64+0x92/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 other info that might help us debug this:

 Chain exists of:
   devices_rwsem --> dev_mutex --> &device->unregistration_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&device->unregistration_lock);
                                lock(dev_mutex);
                                lock(&device->unregistration_lock);
   lock(devices_rwsem);

  *** DEADLOCK ***

This patch fixes the issue by moving all uld_ctx entries from the global
uld_ctx_list to a temporary local list while holding dev_mutex, then
releasing the mutex before calling c4iw_remove() and freeing the
contexts. This prevents any lock inversion while safely avoiding races
on the shared list.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/cxgb4/device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index d892f55febe2..fe902e2f3b0d 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -1554,14 +1554,18 @@ static int __init c4iw_init_module(void)
 static void __exit c4iw_exit_module(void)
 {
 	struct uld_ctx *ctx, *tmp;
+	LIST_HEAD(local_list);
 
 	mutex_lock(&dev_mutex);
-	list_for_each_entry_safe(ctx, tmp, &uld_ctx_list, entry) {
+	list_splice_init(&uld_ctx_list, &local_list);
+	mutex_unlock(&dev_mutex);
+
+	list_for_each_entry_safe(ctx, tmp, &local_list, entry) {
+		list_del(&ctx->entry);
 		if (ctx->dev)
 			c4iw_remove(ctx);
 		kfree(ctx);
 	}
-	mutex_unlock(&dev_mutex);
 	destroy_workqueue(reg_workq);
 	cxgb4_unregister_uld(CXGB4_ULD_RDMA);
 	c4iw_cm_term();
-- 
2.51.0


