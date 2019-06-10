Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9817A3B96D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFJQ2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 12:28:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:38703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfFJQ2e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 12:28:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 09:28:32 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2019 09:28:33 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5AGSOOY023560;
        Mon, 10 Jun 2019 09:28:26 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5AGSIBS098955;
        Mon, 10 Jun 2019 12:28:18 -0400
Subject: [PATCH v2 for-rc 3/3] IB/hfi1: Correct tid qp rcd to match verbs
 context
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 10 Jun 2019 12:28:18 -0400
Message-ID: <20190610162818.98933.46638.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190608081533.GO5261@mtr-leonro.mtl.com>
References: <20190608081533.GO5261@mtr-leonro.mtl.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The qp priv rcd pointer doesn't match the context being
used for verbs causing issues when 9B and kdeth packets
are processed by different receive contexts and hence
different CPUs.

When running on different CPUs the following panic can
occur:
[476262.398106] WARNING: CPU: 3 PID: 2584 at lib/list_debug.c:59 __list_del_entry+0xa1/0xd0
[476262.398109] list_del corruption. prev->next should be ffff9a7ac31f7a30, but was ffff9a7c3bc89230
[476262.398266] CPU: 3 PID: 2584 Comm: z_wr_iss Kdump: loaded Tainted: P           OE  ------------   3.10.0-862.2.3.el7_lustre.x86_64 #1
[476262.398272] Call Trace:
[476262.398277]  <IRQ>  [<ffffffffb7b0d78e>] dump_stack+0x19/0x1b
[476262.398314]  [<ffffffffb74916d8>] __warn+0xd8/0x100
[476262.398317]  [<ffffffffb749175f>] warn_slowpath_fmt+0x5f/0x80
[476262.398320]  [<ffffffffb7768671>] __list_del_entry+0xa1/0xd0
[476262.398402]  [<ffffffffc0c7a945>] process_rcv_qp_work+0xb5/0x160 [hfi1]
[476262.398424]  [<ffffffffc0c7bc2b>] handle_receive_interrupt_nodma_rtail+0x20b/0x2b0 [hfi1]
[476262.398438]  [<ffffffffc0c70683>] receive_context_interrupt+0x23/0x40 [hfi1]
[476262.398447]  [<ffffffffb7540a94>] __handle_irq_event_percpu+0x44/0x1c0
[476262.398450]  [<ffffffffb7540c42>] handle_irq_event_percpu+0x32/0x80
[476262.398454]  [<ffffffffb7540ccc>] handle_irq_event+0x3c/0x60
[476262.398460]  [<ffffffffb7543a1f>] handle_edge_irq+0x7f/0x150
[476262.398469]  [<ffffffffb742d504>] handle_irq+0xe4/0x1a0
[476262.398475]  [<ffffffffb7b23f7d>] do_IRQ+0x4d/0xf0
[476262.398481]  [<ffffffffb7b16362>] common_interrupt+0x162/0x162
[476262.398482]  <EOI>  [<ffffffffb775a326>] ? memcpy+0x6/0x110
[476262.398645]  [<ffffffffc109210d>] ? abd_copy_from_buf_off_cb+0x1d/0x30 [zfs]
[476262.398678]  [<ffffffffc10920f0>] ? abd_copy_to_buf_off_cb+0x30/0x30 [zfs]
[476262.398696]  [<ffffffffc1093257>] abd_iterate_func+0x97/0x120 [zfs]
[476262.398710]  [<ffffffffc10934d9>] abd_copy_from_buf_off+0x39/0x60 [zfs]
[476262.398726]  [<ffffffffc109b828>] arc_write_ready+0x178/0x300 [zfs]
[476262.398732]  [<ffffffffb7b11032>] ? mutex_lock+0x12/0x2f
[476262.398734]  [<ffffffffb7b11032>] ? mutex_lock+0x12/0x2f
[476262.398837]  [<ffffffffc1164d05>] zio_ready+0x65/0x3d0 [zfs]
[476262.398884]  [<ffffffffc04d725e>] ? tsd_get_by_thread+0x2e/0x50 [spl]
[476262.398893]  [<ffffffffc04d1318>] ? taskq_member+0x18/0x30 [spl]
[476262.398968]  [<ffffffffc115ef22>] zio_execute+0xa2/0x100 [zfs]
[476262.398982]  [<ffffffffc04d1d2c>] taskq_thread+0x2ac/0x4f0 [spl]
[476262.399001]  [<ffffffffb74cee80>] ? wake_up_state+0x20/0x20
[476262.399043]  [<ffffffffc115ee80>] ? zio_taskq_member.isra.7.constprop.10+0x80/0x80 [zfs]
[476262.399055]  [<ffffffffc04d1a80>] ? taskq_thread_spawn+0x60/0x60 [spl]
[476262.399067]  [<ffffffffb74bae31>] kthread+0xd1/0xe0
[476262.399072]  [<ffffffffb74bad60>] ? insert_kthread_work+0x40/0x40
[476262.399082]  [<ffffffffb7b1f5f7>] ret_from_fork_nospec_begin+0x21/0x21
[476262.399087]  [<ffffffffb74bad60>] ? insert_kthread_work+0x40/0x40

Fix by reading the map entry in the same manner as the
hardware so that the kdeth and verbs contexts match.

Fixes: 5190f052a365 ("IB/hfi1: Allow the driver to initialize QP priv struct")
Cc: <stable@vger.kernel.org>
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
v2: Remove superflous casts
---
 drivers/infiniband/hw/hfi1/chip.c     |   13 +++++++++++++
 drivers/infiniband/hw/hfi1/chip.h     |    1 +
 drivers/infiniband/hw/hfi1/tid_rdma.c |    4 +---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 4221a99e..d5b643a 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14032,6 +14032,19 @@ static void init_kdeth_qp(struct hfi1_devdata *dd)
 }
 
 /**
+ * hfi1_get_qp_map
+ * @dd: device data
+ * @idx: index to read
+ */
+u8 hfi1_get_qp_map(struct hfi1_devdata *dd, u8 idx)
+{
+	u64 reg = read_csr(dd, RCV_QP_MAP_TABLE + (idx / 8) * 8);
+
+	reg >>= (idx % 8) * 8;
+	return reg;
+}
+
+/**
  * init_qpmap_table
  * @dd - device data
  * @first_ctxt - first context
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 4e6c355..b76cf81 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1445,6 +1445,7 @@ int hfi1_set_ctxt_pkey(struct hfi1_devdata *dd, struct hfi1_ctxtdata *ctxt,
 void remap_intr(struct hfi1_devdata *dd, int isrc, int msix_intr);
 void remap_sdma_interrupts(struct hfi1_devdata *dd, int engine, int msix_intr);
 void reset_interrupts(struct hfi1_devdata *dd);
+u8 hfi1_get_qp_map(struct hfi1_devdata *dd, u8 idx);
 
 /*
  * Interrupt source table.
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 6fb9303..aa9c8d3 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -312,9 +312,7 @@ static struct hfi1_ctxtdata *qp_to_rcd(struct rvt_dev_info *rdi,
 	if (qp->ibqp.qp_num == 0)
 		ctxt = 0;
 	else
-		ctxt = ((qp->ibqp.qp_num >> dd->qos_shift) %
-			(dd->n_krcv_queues - 1)) + 1;
-
+		ctxt = hfi1_get_qp_map(dd, qp->ibqp.qp_num >> dd->qos_shift);
 	return dd->rcd[ctxt];
 }
 

