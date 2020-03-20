Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E3618D8CA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 21:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTUCN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 16:02:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:28216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgCTUCN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 16:02:13 -0400
IronPort-SDR: VU3jAt1LqlGb0AeyG9J72um5L3TimQmojz6FhGDqeRVoVupFAdeZhFCki7cNM0Zr75SPt8Fd0I
 YFFERnz5/d1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 13:02:12 -0700
IronPort-SDR: GYrIV0+VsamVBv9kcWi0rbip2hF+DK/vC+I7Wa93xxx7bPM4sXmaHT3i6DVKu61eywEmWjom+v
 xducdwNLt4Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="418829577"
Received: from awfm-01.aw.intel.com ([10.228.212.213])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2020 13:02:10 -0700
Subject: [PATCH v2] IB/hfi1: Insure pq is not left on waitlist
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 20 Mar 2020 16:02:10 -0400
Message-ID: <20200320200200.23203.37777.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following warning can occur when a pq is left on the
dmawait list and the pq is then freed:

[3218804.385525] WARNING: CPU: 47 PID: 3546 at lib/list_debug.c:29 __list_add+0x65/0xc0
[3218804.385527] list_add corruption. next->prev should be prev (ffff939228da1880), but was ffff939cabb52230. (next=ffff939cabb52230).
[3218804.385528] Modules linked in: mmfs26(OE) mmfslinux(OE) tracedev(OE) 8021q garp mrp ib_isert iscsi_target_mod target_core_mod crc_t10dif crct10dif_generic opa_vnic rpcrdma ib_iser libiscsi scsi_transport_iscsi ib_ipoib(OE) bridge stp llc iTCO_wdt iTCO_vendor_support intel_powerclamp coretemp intel_rapl iosf_mbi kvm_intel kvm irqbypass crct10dif_pclmul crct10dif_common crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd ast ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm pcspkr joydev drm_panel_orientation_quirks i2c_i801 mei_me lpc_ich mei wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad hfi1(OE) rdmavt(OE) rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_core binfmt_misc numatools(OE) xpmem(OE) ip_tables
[3218804.385576] nfsv3 nfs_acl nfs lockd grace sunrpc fscache igb ahci libahci i2c_algo_bit dca libata ptp pps_core crc32c_intel [last unloaded: i2c_algo_bit]
[3218804.385589] CPU: 47 PID: 3546 Comm: wrf.exe Kdump: loaded Tainted: G W OE ------------ 3.10.0-957.41.1.el7.x86_64 #1
[3218804.385590] Hardware name: HPE.COM HPE SGI 8600-XA730i Gen10/X11DPT-SB-SG007, BIOS SBED1229 01/22/2019
[3218804.385592] Call Trace:
[3218804.385602] [<ffffffff91f65ac0>] dump_stack+0x19/0x1b
[3218804.385607] [<ffffffff91898b78>] __warn+0xd8/0x100
[3218804.385609] [<ffffffff91898bff>] warn_slowpath_fmt+0x5f/0x80
[3218804.385616] [<ffffffff91a1dabe>] ? ___slab_alloc+0x24e/0x4f0
[3218804.385618] [<ffffffff91b97025>] __list_add+0x65/0xc0
[3218804.385642] [<ffffffffc03926a5>] defer_packet_queue+0x145/0x1a0 [hfi1]
[3218804.385658] [<ffffffffc0372987>] sdma_check_progress+0x67/0xa0 [hfi1]
[3218804.385673] [<ffffffffc03779d2>] sdma_send_txlist+0x432/0x550 [hfi1]
[3218804.385676] [<ffffffff91a20009>] ? kmem_cache_alloc+0x179/0x1f0
[3218804.385691] [<ffffffffc0392973>] ? user_sdma_send_pkts+0xc3/0x1990 [hfi1]
[3218804.385704] [<ffffffffc0393e3a>] user_sdma_send_pkts+0x158a/0x1990 [hfi1]
[3218804.385707] [<ffffffff918ab65e>] ? try_to_del_timer_sync+0x5e/0x90
[3218804.385710] [<ffffffff91a3fe1a>] ? __check_object_size+0x1ca/0x250
[3218804.385723] [<ffffffffc0395546>] hfi1_user_sdma_process_request+0xd66/0x1280 [hfi1]
[3218804.385737] [<ffffffffc034e0da>] hfi1_aio_write+0xca/0x120 [hfi1]
[3218804.385739] [<ffffffff91a4245b>] do_sync_readv_writev+0x7b/0xd0
[3218804.385742] [<ffffffff91a4409e>] do_readv_writev+0xce/0x260
[3218804.385746] [<ffffffff918df69f>] ? pick_next_task_fair+0x5f/0x1b0
[3218804.385748] [<ffffffff918db535>] ? sched_clock_cpu+0x85/0xc0
[3218804.385751] [<ffffffff91f6b16a>] ? __schedule+0x13a/0x860
[3218804.385752] [<ffffffff91a442c5>] vfs_writev+0x35/0x60
[3218804.385754] [<ffffffff91a4447f>] SyS_writev+0x7f/0x110
[3218804.385757] [<ffffffff91f78ddb>] system_call_fastpath+0x22/0x27

The issue happens when wait_event_interruptible_timeout() returns a
value <= 0.

In that case, the pq is left on the list.   The code continues sending
packets and potentially can complete the current request with the pq
still on the dmawait list provided no descriptor shortage is seen.

If the pq is torn down in that state, the sdma interrupt handler could
find the now freed pq on the list with list corruption or memory
corruption resulting.

Fix by adding a flush routine to ensure that the pq is never on a list
after processing a request.

A follow-up patch series will address issues with seqlock surfaced in:
https://lore.kernel.org/linux-rdma/20200320003129.GP20941@ziepe.ca

The seqlock use for sdma will then be converted to a spin lock since
the list_empty() doesn't need the protection afforded by the sequence
probes currently in use.

Fixes: a0d406934a46 ("staging/rdma/hfi1: Add page lock limit check for SDMA requests")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
v1 => v2:
- s/insure/ensure/
- Add info about locking and follow-on series

 drivers/infiniband/hw/hfi1/user_sdma.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index c2f0d9b..13e4203 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -141,6 +141,7 @@ static int defer_packet_queue(
 	 */
 	xchg(&pq->state, SDMA_PKT_Q_DEFERRED);
 	if (list_empty(&pq->busy.list)) {
+		pq->busy.lock = &sde->waitlock;
 		iowait_get_priority(&pq->busy);
 		iowait_queue(pkts_sent, &pq->busy, &sde->dmawait);
 	}
@@ -155,6 +156,7 @@ static void activate_packet_queue(struct iowait *wait, int reason)
 {
 	struct hfi1_user_sdma_pkt_q *pq =
 		container_of(wait, struct hfi1_user_sdma_pkt_q, busy);
+	pq->busy.lock = NULL;
 	xchg(&pq->state, SDMA_PKT_Q_ACTIVE);
 	wake_up(&wait->wait_dma);
 };
@@ -256,6 +258,21 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	return ret;
 }
 
+static void flush_pq_iowait(struct hfi1_user_sdma_pkt_q *pq)
+{
+	unsigned long flags;
+	seqlock_t *lock = pq->busy.lock;
+
+	if (!lock)
+		return;
+	write_seqlock_irqsave(lock, flags);
+	if (!list_empty(&pq->busy.list)) {
+		list_del_init(&pq->busy.list);
+		pq->busy.lock = NULL;
+	}
+	write_sequnlock_irqrestore(lock, flags);
+}
+
 int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 			       struct hfi1_ctxtdata *uctxt)
 {
@@ -281,6 +298,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		kfree(pq->reqs);
 		kfree(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
+		flush_pq_iowait(pq);
 		kfree(pq);
 	} else {
 		spin_unlock(&fd->pq_rcu_lock);
@@ -587,11 +605,12 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		if (ret < 0) {
 			if (ret != -EBUSY)
 				goto free_req;
-			wait_event_interruptible_timeout(
+			if (wait_event_interruptible_timeout(
 				pq->busy.wait_dma,
-				(pq->state == SDMA_PKT_Q_ACTIVE),
+				pq->state == SDMA_PKT_Q_ACTIVE,
 				msecs_to_jiffies(
-					SDMA_IOWAIT_TIMEOUT));
+					SDMA_IOWAIT_TIMEOUT)) <= 0)
+				flush_pq_iowait(pq);
 		}
 	}
 	*count += idx;

