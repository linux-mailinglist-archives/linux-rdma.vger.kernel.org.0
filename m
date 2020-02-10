Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53CE1578D3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgBJNKj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:10:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:4880 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbgBJNKh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:10:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="233098939"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2020 05:10:36 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADAZol007524;
        Mon, 10 Feb 2020 06:10:35 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADAX7Z087658;
        Mon, 10 Feb 2020 08:10:34 -0500
Subject: [PATCH for-rc 2/3] IB/hfi1: Close window for pq and request coliding
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:10:33 -0500
Message-ID: <20200210131033.87408.81174.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
References: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Cleaning up a pq can result in the following warning and panic:

[29386.970819] WARNING: CPU: 52 PID: 77418 at lib/list_debug.c:53 __list_del_entry+0x63/0xd0
[29386.970821] list_del corruption, ffff88cb2c6ac068->next is LIST_POISON1 (dead000000000100)
[29386.970823] Modules linked in: mmfs26(OE) mmfslinux(OE) tracedev(OE) 8021q garp mrp ib_isert iscsi_target_mod target_core_mod crc_t10dif crct10dif_generic opa_vnic rpcrdma ib_iser libiscsi scsi_transport_iscsi ib_ipoib(OE) bridge stp llc iTCO_wdt iTCO_vendor_support intel_powerclamp coretemp intel_rapl iosf_mbi kvm_intel kvm irqbypass crct10dif_pclmul crct10dif_common crc32_pclmul ghash_clmulni_intel ast aesni_intel ttm lrw gf128mul glue_helper ablk_helper drm_kms_helper cryptd syscopyarea sysfillrect sysimgblt fb_sys_fops drm pcspkr joydev lpc_ich mei_me drm_panel_orientation_quirks i2c_i801 mei wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad hfi1(OE) rdmavt(OE) rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_core binfmt_misc numatools(OE) xpmem(OE) ip_tables
[29386.970877]  nfsv3 nfs_acl nfs lockd grace sunrpc fscache igb ahci i2c_algo_bit libahci dca ptp libata pps_core crc32c_intel [last unloaded: i2c_algo_bit]
[29386.970891] CPU: 52 PID: 77418 Comm: pvbatch Kdump: loaded Tainted: G           OE  ------------   3.10.0-957.38.3.el7.x86_64 #1
[29386.970893] Hardware name: HPE.COM HPE SGI 8600-XA730i Gen10/X11DPT-SB-SG007, BIOS SBED1229 01/22/2019
[29386.970894] Call Trace:
[29386.970905]  [<ffffffff90365ac0>] dump_stack+0x19/0x1b
[29386.970911]  [<ffffffff8fc98b78>] __warn+0xd8/0x100
[29386.970913]  [<ffffffff8fc98bff>] warn_slowpath_fmt+0x5f/0x80
[29386.970916]  [<ffffffff8ff970c3>] __list_del_entry+0x63/0xd0
[29386.970919]  [<ffffffff8ff9713d>] list_del+0xd/0x30
[29386.970924]  [<ffffffff8fddda70>] kmem_cache_destroy+0x50/0x110
[29386.970969]  [<ffffffffc0328130>] hfi1_user_sdma_free_queues+0xf0/0x200 [hfi1]
[29386.970984]  [<ffffffffc02e2350>] hfi1_file_close+0x70/0x1e0 [hfi1]
[29386.970988]  [<ffffffff8fe4519c>] __fput+0xec/0x260
[29386.970991]  [<ffffffff8fe453fe>] ____fput+0xe/0x10
[29386.970995]  [<ffffffff8fcbfd1b>] task_work_run+0xbb/0xe0
[29386.971000]  [<ffffffff8fc2bc65>] do_notify_resume+0xa5/0xc0
[29386.971004]  [<ffffffff90379134>] int_signal+0x12/0x17
[29386.971024] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[29386.978897] IP: [<ffffffff8fe1f93e>] kmem_cache_close+0x7e/0x300
[29386.984928] PGD 2cdab19067 PUD 2f7bfdb067 PMD 0
[29386.989627] Oops: 0000 [#1] SMP
[29386.992902] Modules linked in: mmfs26(OE) mmfslinux(OE) tracedev(OE) 8021q garp mrp ib_isert iscsi_target_mod target_core_mod crc_t10dif crct10dif_generic opa_vnic rpcrdma ib_iser libiscsi scsi_transport_iscsi ib_ipoib(OE) bridge stp llc iTCO_wdt iTCO_vendor_support intel_powerclamp coretemp intel_rapl iosf_mbi kvm_intel kvm irqbypass crct10dif_pclmul crct10dif_common crc32_pclmul ghash_clmulni_intel ast aesni_intel ttm lrw gf128mul glue_helper ablk_helper drm_kms_helper cryptd syscopyarea sysfillrect sysimgblt fb_sys_fops drm pcspkr joydev lpc_ich mei_me drm_panel_orientation_quirks i2c_i801 mei wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad hfi1(OE) rdmavt(OE) rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_core binfmt_misc numatools(OE) xpmem(OE) ip_tables
[29387.065320]  nfsv3 nfs_acl nfs lockd grace sunrpc fscache igb ahci i2c_algo_bit libahci dca ptp libata pps_core crc32c_intel [last unloaded: i2c_algo_bit]
[29387.078246] CPU: 52 PID: 77418 Comm: pvbatch Kdump: loaded Tainted: G        W  OE  ------------   3.10.0-957.38.3.el7.x86_64 #1
[29387.089796] Hardware name: HPE.COM HPE SGI 8600-XA730i Gen10/X11DPT-SB-SG007, BIOS SBED1229 01/22/2019
[29387.099097] task: ffff88cc26db9040 ti: ffff88b5393a8000 task.ti: ffff88b5393a8000
[29387.106576] RIP: 0010:[<ffffffff8fe1f93e>]  [<ffffffff8fe1f93e>] kmem_cache_close+0x7e/0x300
[29387.115033] RSP: 0018:ffff88b5393abd60  EFLAGS: 00010287
[29387.120346] RAX: 0000000000000000 RBX: ffff88cb2c6ac000 RCX: 0000000000000003
[29387.127479] RDX: 0000000000000400 RSI: 0000000000000400 RDI: ffffffff9095b800
[29387.134612] RBP: ffff88b5393abdb0 R08: ffffffff9095b808 R09: ffffffff8ff77c19
[29387.141746] R10: ffff88b73ce1f160 R11: ffffddecddde9800 R12: ffff88cb2c6ac000
[29387.148877] R13: 000000000000000c R14: ffff88cf3fdca780 R15: 0000000000000000
[29387.156010] FS:  00002aaaaab52500(0000) GS:ffff88b73ce00000(0000) knlGS:0000000000000000
[29387.164097] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29387.169839] CR2: 0000000000000010 CR3: 0000002d27664000 CR4: 00000000007607e0
[29387.176966] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[29387.184100] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[29387.191232] PKRU: 55555554
[29387.193944] Call Trace:
[29387.196400]  [<ffffffff8fe20d44>] __kmem_cache_shutdown+0x14/0x80
[29387.202492]  [<ffffffff8fddda78>] kmem_cache_destroy+0x58/0x110
[29387.208461]  [<ffffffffc0328130>] hfi1_user_sdma_free_queues+0xf0/0x200 [hfi1]
[29387.215694]  [<ffffffffc02e2350>] hfi1_file_close+0x70/0x1e0 [hfi1]
[29387.221957]  [<ffffffff8fe4519c>] __fput+0xec/0x260
[29387.226837]  [<ffffffff8fe453fe>] ____fput+0xe/0x10
[29387.231718]  [<ffffffff8fcbfd1b>] task_work_run+0xbb/0xe0
[29387.237116]  [<ffffffff8fc2bc65>] do_notify_resume+0xa5/0xc0
[29387.242778]  [<ffffffff90379134>] int_signal+0x12/0x17
[29387.247922] Code: 00 00 ba 00 04 00 00 0f 4f c2 3d 00 04 00 00 89 45 bc 0f 84 e7 01 00 00 48 63 45 bc 49 8d 04 c4 48 89 45 b0 48 8b 80 c8 00 00 00 <48> 8b 78 10 48 89 45 c0 48 83 c0 10 48 89 45 d0 48 8b 17 48 39
[29387.268313] RIP  [<ffffffff8fe1f93e>] kmem_cache_close+0x7e/0x300
[29387.274440]  RSP <ffff88b5393abd60>
[29387.277932] CR2: 0000000000000010

The panic is the result of slab entries being freed during the
destruction of the pq slab.

The code attempts to quiesce the pq, but looking for
n_req == 0 doesn't account for new requests.

Fix the issue by using SRCU to get a pq pointer and adjust the pq
free logic to NULL the fd pq pointer prior to the quiesce.

Fixes: e87473bc1b6c ("IB/hfi1: Only set fd pointer when base context is completely initialized")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c     |   52 ++++++++++++++++++-----------
 drivers/infiniband/hw/hfi1/hfi.h          |    5 ++-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    3 --
 drivers/infiniband/hw/hfi1/user_sdma.c    |   17 +++++++--
 4 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index bef6946..2591158 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -200,23 +200,24 @@ static int hfi1_file_open(struct inode *inode, struct file *fp)
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
 
-	if (fd) {
-		fd->rec_cpu_num = -1; /* no cpu affinity by default */
-		fd->mm = current->mm;
-		mmgrab(fd->mm);
-		fd->dd = dd;
-		kobject_get(&fd->dd->kobj);
-		fp->private_data = fd;
-	} else {
-		fp->private_data = NULL;
-
-		if (atomic_dec_and_test(&dd->user_refcount))
-			complete(&dd->user_comp);
-
-		return -ENOMEM;
-	}
-
+	if (!fd || init_srcu_struct(&fd->pq_srcu))
+		goto nomem;
+	spin_lock_init(&fd->pq_rcu_lock);
+	spin_lock_init(&fd->tid_lock);
+	spin_lock_init(&fd->invalid_lock);
+	fd->rec_cpu_num = -1; /* no cpu affinity by default */
+	fd->mm = current->mm;
+	mmgrab(fd->mm);
+	fd->dd = dd;
+	kobject_get(&fd->dd->kobj);
+	fp->private_data = fd;
 	return 0;
+nomem:
+	kfree(fd);
+	fp->private_data = NULL;
+	if (atomic_dec_and_test(&dd->user_refcount))
+		complete(&dd->user_comp);
+	return -ENOMEM;
 }
 
 static long hfi1_file_ioctl(struct file *fp, unsigned int cmd,
@@ -301,21 +302,30 @@ static long hfi1_file_ioctl(struct file *fp, unsigned int cmd,
 static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 {
 	struct hfi1_filedata *fd = kiocb->ki_filp->private_data;
-	struct hfi1_user_sdma_pkt_q *pq = fd->pq;
+	struct hfi1_user_sdma_pkt_q *pq;
 	struct hfi1_user_sdma_comp_q *cq = fd->cq;
 	int done = 0, reqs = 0;
 	unsigned long dim = from->nr_segs;
+	int idx;
 
-	if (!cq || !pq)
+	idx = srcu_read_lock(&fd->pq_srcu);
+	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
+	if (!cq || !pq) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
 		return -EIO;
+	}
 
-	if (!iter_is_iovec(from) || !dim)
+	if (!iter_is_iovec(from) || !dim) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
 		return -EINVAL;
+	}
 
 	trace_hfi1_sdma_request(fd->dd, fd->uctxt->ctxt, fd->subctxt, dim);
 
-	if (atomic_read(&pq->n_reqs) == pq->n_max_reqs)
+	if (atomic_read(&pq->n_reqs) == pq->n_max_reqs) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
 		return -ENOSPC;
+	}
 
 	while (dim) {
 		int ret;
@@ -333,6 +343,7 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 		reqs++;
 	}
 
+	srcu_read_unlock(&fd->pq_srcu, idx);
 	return reqs;
 }
 
@@ -707,6 +718,7 @@ static int hfi1_file_close(struct inode *inode, struct file *fp)
 	if (atomic_dec_and_test(&dd->user_refcount))
 		complete(&dd->user_comp);
 
+	cleanup_srcu_struct(&fdata->pq_srcu);
 	kfree(fdata);
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 6365e8f..cae12f4 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1444,10 +1444,13 @@ static inline bool hfi1_vnic_is_rsm_full(struct hfi1_devdata *dd, int spare)
 
 /* Private data for file operations */
 struct hfi1_filedata {
+	struct srcu_struct pq_srcu;
 	struct hfi1_devdata *dd;
 	struct hfi1_ctxtdata *uctxt;
 	struct hfi1_user_sdma_comp_q *cq;
-	struct hfi1_user_sdma_pkt_q *pq;
+	/* update side lock for SRCU */
+	spinlock_t pq_rcu_lock;
+	struct hfi1_user_sdma_pkt_q __rcu *pq;
 	u16 subctxt;
 	/* for cpu affinity; -1 if none */
 	int rec_cpu_num;
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 2443423..4da03f8 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -87,9 +87,6 @@ int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 {
 	int ret = 0;
 
-	spin_lock_init(&fd->tid_lock);
-	spin_lock_init(&fd->invalid_lock);
-
 	fd->entry_to_rb = kcalloc(uctxt->expected_count,
 				  sizeof(struct rb_node *),
 				  GFP_KERNEL);
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index fd754a1..c2f0d9b 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -179,7 +179,6 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	pq = kzalloc(sizeof(*pq), GFP_KERNEL);
 	if (!pq)
 		return -ENOMEM;
-
 	pq->dd = dd;
 	pq->ctxt = uctxt->ctxt;
 	pq->subctxt = fd->subctxt;
@@ -236,7 +235,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 		goto pq_mmu_fail;
 	}
 
-	fd->pq = pq;
+	rcu_assign_pointer(fd->pq, pq);
 	fd->cq = cq;
 
 	return 0;
@@ -264,8 +263,14 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 
 	trace_hfi1_sdma_user_free_queues(uctxt->dd, uctxt->ctxt, fd->subctxt);
 
-	pq = fd->pq;
+	spin_lock(&fd->pq_rcu_lock);
+	pq = srcu_dereference_check(fd->pq, &fd->pq_srcu,
+				    lockdep_is_held(&fd->pq_rcu_lock));
 	if (pq) {
+		rcu_assign_pointer(fd->pq, NULL);
+		spin_unlock(&fd->pq_rcu_lock);
+		synchronize_srcu(&fd->pq_srcu);
+		/* at this point there can be no more new requests */
 		if (pq->handler)
 			hfi1_mmu_rb_unregister(pq->handler);
 		iowait_sdma_drain(&pq->busy);
@@ -277,7 +282,8 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		kfree(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		kfree(pq);
-		fd->pq = NULL;
+	} else {
+		spin_unlock(&fd->pq_rcu_lock);
 	}
 	if (fd->cq) {
 		vfree(fd->cq->comps);
@@ -321,7 +327,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 {
 	int ret = 0, i;
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
-	struct hfi1_user_sdma_pkt_q *pq = fd->pq;
+	struct hfi1_user_sdma_pkt_q *pq =
+		srcu_dereference(fd->pq, &fd->pq_srcu);
 	struct hfi1_user_sdma_comp_q *cq = fd->cq;
 	struct hfi1_devdata *dd = pq->dd;
 	unsigned long idx = 0;

