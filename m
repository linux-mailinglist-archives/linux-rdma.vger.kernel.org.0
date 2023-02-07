Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67568E1CA
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 21:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBGUUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 15:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBGUUB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 15:20:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4722A31
        for <linux-rdma@vger.kernel.org>; Tue,  7 Feb 2023 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675801200; x=1707337200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JCOJuga9o6XHY3S0ayR3nGD/5rhiMH4iu0qrSiYriMc=;
  b=OE+luUIwR0hclfVf5Z1iPY+SapljTTd/npRX+qibbHCaf1RA+0je63LY
   ZXIAza29IgPPdcChhs5oUMthLRB4EP3kzeIoaOXA/z3Und5iHt3BtNinN
   FkcvJ/ZD9OjG0BytBkPTZmIA+hq9dru/IcCwfeHh/7Uf336a5pX/jf3JX
   QpfIHn1ebcDYhc24oGjGHVuC0aqQ3+/zwpeqecDk0f6Uj58420z1TbJl8
   b5xrGKncjE8+lf5rX9GZfgFBo6plECDvUzs1Qyd4NsiVzix1IyWg5H/Yr
   3ggM8JpY6VAUoUCPQjfs/ETcxzYGnekhzY7TJMI0AIjNDh8T2r8EJcvww
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327309041"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="327309041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:19:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912466024"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="912466024"
Received: from sindhude-mobl.amr.corp.intel.com ([10.255.37.71])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:19:58 -0800
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH for-rc, v2] RDMA/irdma: Cap MSIX used to online CPUs + 1
Date:   Tue,  7 Feb 2023 14:19:38 -0600
Message-Id: <20230207201938.1329-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The irdma driver can use a maximum number of msix vectors equal to num_online_cpus() + 1 and the kernel warning stack below is shown if that number is exceeded.
The kernel throws a warning as the driver tries to update the affinity hint with a CPU mask greater than the max CPU IDs. Fix this by capping the MSIX vectors to num_online_cpus() + 1.

kernel: WARNING: CPU: 7 PID: 23655 at include/linux/cpumask.h:106 irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
kernel: RIP: 0010:irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
kernel: Call Trace:
kernel: irdma_rt_init_hw+0xa62/0x1290 [irdma]
kernel: ? irdma_alloc_local_mac_entry+0x1a0/0x1a0 [irdma]
kernel: ? __is_kernel_percpu_address+0x63/0x310
kernel: ? rcu_read_lock_held_common+0xe/0xb0
kernel: ? irdma_lan_unregister_qset+0x280/0x280 [irdma]
kernel: ? irdma_request_reset+0x80/0x80 [irdma]
kernel: ? ice_get_qos_params+0x84/0x390 [ice]
kernel: irdma_probe+0xa40/0xfc0 [irdma]
kernel: ? rcu_read_lock_bh_held+0xd0/0xd0
kernel: ? irdma_remove+0x140/0x140 [irdma]
kernel: ? rcu_read_lock_sched_held+0x62/0xe0
kernel: ? down_write+0x187/0x3d0
kernel: ? auxiliary_match_id+0xf0/0x1a0
kernel: ? irdma_remove+0x140/0x140 [irdma]
kernel: auxiliary_bus_probe+0xa6/0x100
kernel: __driver_probe_device+0x4a4/0xd50
kernel: ? __device_attach_driver+0x2c0/0x2c0
kernel: driver_probe_device+0x4a/0x110
kernel: __driver_attach+0x1aa/0x350
kernel: bus_for_each_dev+0x11d/0x1b0
kernel: ? subsys_dev_iter_init+0xe0/0xe0
kernel: bus_add_driver+0x3b1/0x610
kernel: driver_register+0x18e/0x410
kernel: ? 0xffffffffc0b88000
kernel: irdma_init_module+0x50/0xaa [irdma]
kernel: do_one_initcall+0x103/0x5f0
kernel: ? perf_trace_initcall_level+0x420/0x420
kernel: ? do_init_module+0x4e/0x700
kernel: ? __kasan_kmalloc+0x7d/0xa0
kernel: ? kmem_cache_alloc_trace+0x188/0x2b0
kernel: ? kasan_unpoison+0x21/0x50
kernel: do_init_module+0x1d1/0x700
kernel: load_module+0x3867/0x5260
kernel: ? layout_and_allocate+0x3990/0x3990
kernel: ? rcu_read_lock_held_common+0xe/0xb0
kernel: ? rcu_read_lock_sched_held+0x62/0xe0
kernel: ? rcu_read_lock_bh_held+0xd0/0xd0
kernel: ? __vmalloc_node_range+0x46b/0x890
kernel: ? lock_release+0x5c8/0xba0
kernel: ? alloc_vm_area+0x120/0x120
kernel: ? selinux_kernel_module_from_file+0x2a5/0x300
kernel: ? __inode_security_revalidate+0xf0/0xf0
kernel: ? __do_sys_init_module+0x1db/0x260
kernel: __do_sys_init_module+0x1db/0x260
kernel: ? load_module+0x5260/0x5260
kernel: ? do_syscall_64+0x22/0x450
kernel: do_syscall_64+0xa5/0x450
kernel: entry_SYSCALL_64_after_hwframe+0x66/0xdb

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---

v2: Commit message and call stack trace updated based on the feedback.

 drivers/infiniband/hw/irdma/hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index ab246447520b..2e1e2bad0401 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -483,6 +483,8 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
 	iw_qvlist->num_vectors = rf->msix_count;
 	if (rf->msix_count <= num_online_cpus())
 		rf->msix_shared = true;
+	else if (rf->msix_count > num_online_cpus() + 1)
+		rf->msix_count = num_online_cpus() + 1;
 
 	pmsix = rf->msix_entries;
 	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
-- 
2.27.0

