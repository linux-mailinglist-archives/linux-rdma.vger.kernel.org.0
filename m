Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE9132B05
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGQWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 11:22:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:8331 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgAGQWi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jan 2020 11:22:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 08:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="223229833"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.122.128.61])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2020 08:22:35 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mkalderon@marvell.com
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc] i40iw: Remove setting of VMA private data and use rdma_user_mmap_io
Date:   Tue,  7 Jan 2020 10:22:23 -0600
Message-Id: <20200107162223.1745-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

vm_ops is now initialized in ib_uverbs_mmap with the
recent rdma mmap API changes. Earlier it was done in
rdma_umap_priv_init which would not be called unless a
driver called rdma_user_mmap_io in its mmap.

i40iw does not use the rdma_user_mmap_io API but sets
the vma's vm_private_data to a driver object.
This now conflicts with the vm_op rdma_umap_close as
priv pointer points to the i40iw driver object instead
of the private data setup by core when rdma_user_mmap_io
is called. And this leads to a crash in rdma_umap_close
with a mmap put being called when it should not have.

Remove the redundant setting of the vma private_data in
i40iw as it is not used. Also move i40iw over to use the
rdma_user_mmap_io API. This gives the extra protection of
having the mappings zapped when the context is detsroyed.

[  223.523395] BUG: unable to handle page fault for address: 0000000100000001
[  223.523400] #PF: supervisor write access in kernel mode
[  223.523401] #PF: error_code(0x0002) - not-present page
[  223.523403] PGD 0 P4D 0
[  223.523406] Oops: 0002 [#1] SMP PTI
[  223.523409] CPU: 6 PID: 9528 Comm: rping Kdump: loaded Not tainted 5.5.0-rc4+ #117
[  223.523410] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./Q87M-D2H, BIOS F7 01/17/2014
[  223.523425] RIP: 0010:rdma_user_mmap_entry_put+0xa/0x30 [ib_core]
[  223.523429] RSP: 0018:ffffb340c04c7c38 EFLAGS: 00010202
[  223.523431] RAX: 00000000ffffffff RBX: ffff9308e7be2a00 RCX: 000000000000cec0
[  223.523433] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000100000001
[  223.523434] RBP: ffff9308dc7641f0 R08: 0000000000000001 R09: 0000000000000000
[  223.523436] R10: 0000000000000001 R11: ffffffff8d4414d8 R12: ffff93075182c780
[  223.523438] R13: 0000000000000001 R14: ffff93075182d2a8 R15: ffff9308e2ddc840
[  223.523440] FS:  0000000000000000(0000) GS:ffff9308fdc00000(0000) knlGS:0000000000000000
[  223.523442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  223.523443] CR2: 0000000100000001 CR3: 00000002e0412004 CR4: 00000000001606e0
[  223.523445] Call Trace:
[  223.523451]  rdma_umap_close+0x40/0x90 [ib_uverbs]
[  223.523455]  remove_vma+0x43/0x80
[  223.523458]  exit_mmap+0xfd/0x1b0
[  223.523465]  mmput+0x6e/0x130
[  223.523468]  do_exit+0x290/0xcc0
[  223.523472]  ? get_signal+0x152/0xc40
[  223.523475]  do_group_exit+0x46/0xc0
[  223.523478]  get_signal+0x1bd/0xc40
[  223.523482]  ? prepare_to_wait_event+0x97/0x190
[  223.523486]  do_signal+0x36/0x630
[  223.523489]  ? remove_wait_queue+0x60/0x60
[  223.523493]  ? __audit_syscall_exit+0x1d9/0x290
[  223.523497]  ? rcu_read_lock_sched_held+0x52/0x90
[  223.523500]  ? kfree+0x21c/0x2e0
[  223.523505]  exit_to_usermode_loop+0x4f/0xc3
[  223.523509]  do_syscall_64+0x1ed/0x270
[  223.523512]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  223.523514] RIP: 0033:0x7fae715a81fd
[  223.523517] Code: Bad RIP value.
[  223.523519] RSP: 002b:00007fae6e163cb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[  223.523521] RAX: fffffffffffffe00 RBX: 00007fae6e163d30 RCX: 00007fae715a81fd
[  223.523523] RDX: 0000000000000010 RSI: 00007fae6e163cf0 RDI: 0000000000000003
[  223.523525] RBP: 00000000013413a0 R08: 00007fae68000000 R09: 0000000000000017
[  223.523526] R10: 0000000000000001 R11: 0000000000000293 R12: 00007fae680008c0
[  223.523528] R13: 00007fae6e163cf0 R14: 00007fae717c9804 R15: 00007fae6e163ed0
[  223.523569] CR2: 0000000100000001
[  223.523571] ---[ end trace b33d58d3a06782cb ]---
[  223.523580] RIP: 0010:rdma_user_mmap_entry_put+0xa/0x30 [ib_core]

Fixes: b86deba977a9 ("RDMA/core: Move core content from ib_uverbs to ib_core")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 8637594..19b65fd 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -169,8 +169,7 @@ static void i40iw_dealloc_ucontext(struct ib_ucontext *context)
 static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 {
 	struct i40iw_ucontext *ucontext;
-	u64 db_addr_offset;
-	u64 push_offset;
+	u64 db_addr_offset, push_offset, pfn;
 
 	ucontext = to_ucontext(context);
 	if (ucontext->iwdev->sc_dev.is_pf) {
@@ -189,7 +188,6 @@ static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	if (vma->vm_pgoff == (db_addr_offset >> PAGE_SHIFT)) {
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-		vma->vm_private_data = ucontext;
 	} else {
 		if ((vma->vm_pgoff - (push_offset >> PAGE_SHIFT)) % 2)
 			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
@@ -197,12 +195,11 @@ static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	}
 
-	if (io_remap_pfn_range(vma, vma->vm_start,
-			       vma->vm_pgoff + (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) >> PAGE_SHIFT),
-			       PAGE_SIZE, vma->vm_page_prot))
-		return -EAGAIN;
+	pfn = vma->vm_pgoff +
+	      (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) >> PAGE_SHIFT);
 
-	return 0;
+	return rdma_user_mmap_io(context, vma, pfn, PAGE_SIZE, vma->vm_page_prot,
+				 NULL);
 }
 
 /**
-- 
1.8.3.1

