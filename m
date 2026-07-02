Return-Path: <linux-rdma+bounces-22674-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OmRHNqkURmrjJQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22674-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 09:35:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 944CA6F43B2
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 09:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=UVPyNFNM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22674-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22674-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 038EA3017460
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CC3932C3;
	Thu,  2 Jul 2026 07:34:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35E3932CA
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 07:34:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977672; cv=none; b=LxyE1pVbdL0wjpzefkSAY+ZbIb9ogXmheE/tzn9GFMfLzrM/KeADFLwpa67CpCEfkyjy4hmvKoaU0qXbIHrT3PNlxaOdY2Fs8XC/rXvPi9DjRyQyz4pOnqt7JhISvH0YvXnmb7+KbdQC/rbUu/T3sKW4FyzdbOhuLeFsQXcmM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977672; c=relaxed/simple;
	bh=3IoAjGtc5PPwc/jwvuN1dC094YhhJy8DnXxnIgCJaB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lGTAjgPZHgT017sHZcIUg4IfnHmEJKFfv0vWlDZlc3CxLebGYNpRi0tPK8qC7Eg6imyseBjq+rC6fnlEublIt+neNulr7ke7Y9ePzYkE56fh5KxFX4rlBQtxxhi6ELFGYJ3rU7NqGIttKL51A+DmLWNXoGbLUXA115oDJDAMa0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UVPyNFNM; arc=none smtp.client-ip=91.218.175.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782977668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ofRe3CY+qXek9zjNbNMQwygk4HXJeQDWlophp5uNfmg=;
	b=UVPyNFNMgEJ6wdjgWtfoBk/jKkPvsv63hRs53vu30FMyWAhdGchgBg3fxV6bS7q7euDrAB
	+iorDeQfXVbQA1ETmbeUWiAE1e36ssOlENZu2TpgMRP/wQY9L41C+bcWpUTWPfNi/SPD9U
	9dtKQhPPt5PpI0EzT0Cdep00g9MC7JA=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: edwards@nvidia.com,
	michaelgur@nvidia.com,
	vdumitrescu@nvidia.com,
	jiri@resnulli.us,
	chenguang.zhao@linux.dev,
	linux-rdma@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH] RDMA/core: quiesce CQ polling before device shutdown on reboot
Date: Thu,  2 Jul 2026 15:34:22 +0800
Message-Id: <20260702073422.279820-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22674-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[chenguang.zhao@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:edwards@nvidia.com,m:michaelgur@nvidia.com,m:vdumitrescu@nvidia.com,m:jiri@resnulli.us,m:chenguang.zhao@linux.dev,m:linux-rdma@vger.kernel.org,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenguang.zhao@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 944CA6F43B2

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

When executing reboot -f in an NFS over RDMA environment, there is a 5%
probability of a crash occurring. The call trace is as follows:
 [  610.937741] Unable to handle kernel paging request at virtual address ffff3773a3e867f8
 [  610.938895] ib_srpt received unrecognized IB event 8
 [  610.952435] Mem abort info:
 [  610.977383]   ESR = 0x96000005
 [  610.984027]   Exception class = DABT (current EL), IL = 32 bits
 [  610.993574]   SET = 0, FnV = 0
 [  611.000197]   EA = 0, S1PTW = 0
 [  611.006851] Data abort info:
 [  611.013183]   ISV = 0, ISS = 0x00000005
 [  611.020435]   CM = 0, WnR = 0
 [  611.026766] swapper pgtable: 64k pages, 48-bit VAs, pgdp = 00000000489bb83a
 [  611.040104] [ffff3773a3e867f8] pgd=0000000000000000, pud=0000000000000000
 [  611.053421] Internal error: Oops: 96000005 [#1] SMP
 [  611.061809] Modules linked in: rpcsec_gss_krb5(OE) auth_rpcgss(OE) nfsv4(OE) dns_resolver enfs(OE) iptable_filter nfsv3(OE) nfs_acl(OE) nfs(OE) lockd(OE) grace fscache(OE) rfkill vfat fat rpcrdma(OE) sunrpc(OE) rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser rdma_cm iw_cm ib_umad libiscsi scsi_transport_iscsi ib_ipoib ib_cm ipmi_ssif aes_ce_blk crypto_simd cryptd mlx5_ib aes_ce_cipher crct10dif_ce ib_uverbs ofpart cmdlinepart ghash_ce ses ib_core sha2_ce hi_sfc sha256_arm64 enclosure sha1_ce joydev sbsa_gwdt ipmi_si ipmi_devintf ipmi_msghandler mtd spi_dw_mmio sch_fq_codel ip_tables realtek hns3 mlx5_core megaraid_sas hclge nfit mlxfw nvme hisi_sas_v3_hw hnae3 libnvdimm hisi_sas_main nvme_core host_edma_drv dm_mirror dm_region_hash dm_log
 [  611.162725] Process kworker/70:1H (pid: 778, stack limit = 0x00000000fdde5e06)
 [  611.177485] CPU: 70 PID: 778 Comm: kworker/70:1H Kdump: loaded Tainted: G           OE     4.19.90-52.40.v2207.ky10.aarch64 #4
 [  611.196574] Source Version: 2c067295fb9b1b9b1b6693820c85b8ba78e29114
 [  611.207038] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDDUA, BIOS 1.89 05/20/2022
 [  611.223343] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
 [  611.233098] pstate: 20c00009 (nzCv daif +PAN +UAO)
 [  611.242075] pc : __ib_process_cq+0x88/0xe8 [ib_core]
 [  611.251215] lr : __ib_process_cq+0x90/0xe8 [ib_core]
 [  611.260316] sp : ffffa04001e2bd20
 [  611.267776] x29: ffffa04001e2bd20 x28: ffff8040a0f6dc40
 [  611.277259] x27: 0000000000000040 x26: ffff8040a0f6dc00
 [  611.286723] x25: 0000000000010000 x24: 0000000000000010
 [  611.296109] x23: 0000000000000000 x22: 000000000000000a
 [  611.305385] x21: ffff8040a0f62000 x20: ffff8040a0f6de80
 [  611.314578] x19: ffff8040a0f6dcc0 x18: 0000000000000001
 [  611.323685] x17: 0000fffe7b3ae660 x16: ffff2b4528d7c368
 [  611.332767] x15: 0000000000000001 x14: ffff2b45299da9f8
 [  611.341778] x13: 0000000000000000 x12: 0000000000000000
 [  611.350689] x11: 00000000ffffffff x10: 0000000000000000
 [  611.359482] x9 : 000000000000000a x8 : ffff8040abe80000
 [  611.368173] x7 : 0000000000000005 x6 : 000000000000000a
 [  611.376760] x5 : 000000000000174b x4 : 000000000000000a
 [  611.385224] x3 : ffffa04001e2bd1c x2 : ffff3773a3e867f8
 [  611.393611] x1 : ffff8040a0f6dcc0 x0 : ffff8040a0f62000
 [  611.401910] Call trace:
 [  611.407252]  __ib_process_cq+0x88/0xe8 [ib_core]
 [  611.414725]  ib_cq_poll_work+0x34/0xa0 [ib_core]
 [  611.422103]  process_one_work+0x1fc/0x4a8
 [  611.428793]  worker_thread+0x50/0x4d8
 [  611.435047]  kthread+0x134/0x138
 [  611.440779]  ret_from_fork+0x10/0x18
 [  611.446770] Code: f9400262 aa1303e1 aa1503e0 b40002a2 (f9400042)
 [  611.455330] SMP: stopping secondary CPUs
 [  611.467959] Starting crashdump kernel...

On forced reboot (reboot -f), mlx5 may enter shutdown while ib-comp-wq
still polls live CQs, causing use-after-free in wr_cqe->done(). Drain
completion workqueues from the kernel reboot path before device_shutdown()
via a function pointer hook, and guard CQ processing during shutdown.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
With NFS over RDMA (rpcrdma + mlx5), reboot -f can Oops in
ib_cq_poll_work -> __ib_process_cq when calling wr_cqe->done(),
often after mlx5_core: Shutdown was called.

reboot -f skips orderly shutdown and goes directly to:

kernel_restart_prepare() -> device_shutdown() -> mlx5 shutdown
Upper layers may still hold live CQs, while ib-comp-wq keeps
polling — a use-after-free race.

Normal reboot usually works because userspace has already
torn down RDMA and called ib_free_cq().

This fixes the crash, but putting InfiniBand-specific logic
into the generic reboot path does not feel ideal. Is this
the right place, or is there a better pattern — e.g. a hook
inside ib_core, driver-level quiesce, or a generic
pre-device_shutdown() mechanism?

 drivers/infiniband/core/cq.c     | 47 +++++++++++++++++++++++++++++++-
 drivers/infiniband/core/device.c |  3 ++
 include/rdma/ib_verbs.h          |  3 ++
 kernel/reboot.c                  | 11 ++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 3d7b6cddd131..b64905bafeaf 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -9,6 +9,13 @@
 #include "core_priv.h"
 
 #include <trace/events/rdma_core.h>
+
+static atomic_t ib_cq_drain;
+
+static bool ib_cq_draining(void)
+{
+	return atomic_read(&ib_cq_drain) || system_state != SYSTEM_RUNNING;
+}
 /* Max size for shared CQ, may require tuning */
 #define IB_MAX_SHARED_CQ_SZ		4096U
 
@@ -96,6 +103,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 
 	trace_cq_process(cq);
 
+	if (ib_cq_draining())
+		return 0;
+
 	/*
 	 * budget might be (-1) if the caller does not
 	 * want to bound this call, thus we need unsigned
@@ -106,6 +116,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 		for (i = 0; i < n; i++) {
 			struct ib_wc *wc = &wcs[i];
 
+			if (ib_cq_draining())
+				return completed;
+
 			if (wc->wr_cqe)
 				wc->wr_cqe->done(cq, wc);
 			else
@@ -157,7 +170,8 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 	completed = __ib_process_cq(cq, budget, cq->wc, IB_POLL_BATCH);
 	if (completed < budget) {
 		irq_poll_complete(&cq->iop);
-		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0) {
+		if (!ib_cq_draining() &&
+		    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0) {
 			trace_cq_reschedule(cq);
 			irq_poll_sched(&cq->iop);
 		}
@@ -171,6 +185,9 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 
 static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 {
+	if (ib_cq_draining())
+		return;
+
 	trace_cq_schedule(cq);
 	irq_poll_sched(&cq->iop);
 }
@@ -180,8 +197,14 @@ static void ib_cq_poll_work(struct work_struct *work)
 	struct ib_cq *cq = container_of(work, struct ib_cq, work);
 	int completed;
 
+	if (ib_cq_draining())
+		return;
+
 	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, cq->wc,
 				    IB_POLL_BATCH);
+	if (ib_cq_draining())
+		return;
+
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
 		queue_work(cq->comp_wq, &cq->work);
@@ -191,6 +214,9 @@ static void ib_cq_poll_work(struct work_struct *work)
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
+	if (ib_cq_draining())
+		return;
+
 	trace_cq_schedule(cq);
 	queue_work(cq->comp_wq, &cq->work);
 }
@@ -359,6 +385,25 @@ void ib_free_cq(struct ib_cq *cq)
 }
 EXPORT_SYMBOL(ib_free_cq);
 
+/**
+ * ib_drain_completion_queues - Quiesce CQ polling before device shutdown
+ *
+ * Called from the kernel reboot/poweroff path immediately before
+ * device_shutdown(), while RDMA upper layers may still hold live CQs.
+ * Stops new CQ work from being queued and waits for in-flight
+ * ib_cq_poll_work handlers to finish.
+ */
+void ib_drain_completion_queues(void)
+{
+	atomic_set(&ib_cq_drain, 1);
+
+	if (ib_comp_wq)
+		flush_workqueue(ib_comp_wq);
+	if (ib_comp_unbound_wq)
+		flush_workqueue(ib_comp_unbound_wq);
+}
+EXPORT_SYMBOL_GPL(ib_drain_completion_queues);
+
 void ib_cq_pool_cleanup(struct ib_device *dev)
 {
 	struct ib_cq *cq, *n;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b8193e077a74..601c58abd184 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -3105,6 +3105,8 @@ static int __init ib_core_init(void)
 
 	register_netdevice_notifier(&nb_netdevice);
 
+	ib_drain_completion_queues_fn = ib_drain_completion_queues;
+
 	return 0;
 
 err_parent:
@@ -3134,6 +3136,7 @@ static int __init ib_core_init(void)
 
 static void __exit ib_core_cleanup(void)
 {
+	ib_drain_completion_queues_fn = NULL;
 	unregister_netdevice_notifier(&nb_netdevice);
 	roce_gid_mgmt_cleanup();
 	rdma_nl_unregister(RDMA_NL_LS);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 794746de8db0..c0b6d1cca598 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -61,6 +61,9 @@ extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
 extern struct workqueue_struct *ib_comp_unbound_wq;
 
+extern void (*ib_drain_completion_queues_fn)(void);
+void ib_drain_completion_queues(void);
+
 struct ib_ucq_object;
 
 __printf(2, 3) __cold
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..889e77960153 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -81,6 +81,9 @@ void __weak (*pm_power_off)(void);
  */
 static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 
+void (*ib_drain_completion_queues_fn)(void);
+EXPORT_SYMBOL_GPL(ib_drain_completion_queues_fn);
+
 /**
  *	emergency_restart - reboot the system
  *
@@ -102,6 +105,10 @@ void kernel_restart_prepare(char *cmd)
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	usermodehelper_disable();
+#if IS_ENABLED(CONFIG_INFINIBAND)
+	if (ib_drain_completion_queues_fn)
+		ib_drain_completion_queues_fn();
+#endif
 	device_shutdown();
 }
 
@@ -305,6 +312,10 @@ static void kernel_shutdown_prepare(enum system_states state)
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
 	usermodehelper_disable();
+#if IS_ENABLED(CONFIG_INFINIBAND)
+	if (ib_drain_completion_queues_fn)
+		ib_drain_completion_queues_fn();
+#endif
 	device_shutdown();
 }
 /**
-- 
2.25.1


