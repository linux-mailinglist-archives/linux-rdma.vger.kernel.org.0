Return-Path: <linux-rdma+bounces-19452-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJPjI+5752nC9QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19452-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 15:30:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8343B5D3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64088303309D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939983D5661;
	Tue, 21 Apr 2026 13:28:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43F2417D9;
	Tue, 21 Apr 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778092; cv=none; b=EQSBHG/RsXxdvcBMXdFcmBMADyFvAUWQQ2elnG36rWXS7eliI6m8hXp6vwH7fF6VA9wNDTRlftg2BOdcY4dXVRrTfKVV2Ej8w7GyLANFpk/wj3d56Ir897q7YaGSaVXPhqPKg/UF5n6knZYi5m1PkX9hbuDyEv5cHVOByd2wJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778092; c=relaxed/simple;
	bh=nB2CSSPIMzaLjMggI6Fx4gyuEbPax/F4VyVi6w66dn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knNqC1dSu7BwDN9hva7fG0irHC6cL8m9D0FKtqbYLdukUVGxBYFAa9eHWxI9ZfnykEqy9B8FupnkN0MKeGo7WIkDU58krFZHLv+ecm648j22XSUPUZ6SGDlR4wLt8VkNTZDgjqemvoHzs39rLoRT1uno+PdJFvUfl8pRTryh3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id D011A23390;
	Tue, 21 Apr 2026 16:28:08 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Leonid Ravich <lravich@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	linux-rdma@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] IB/mad: Don't call to function that might sleep while in atomic context
Date: Tue, 21 Apr 2026 16:28:08 +0300
Message-Id: <20260421132808.38664-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,vger.kernel.org,linuxtesting.org,altlinux.org];
	TAGGED_FROM(0.00)[bounces-19452-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altlinux.org:mid,altlinux.org:email]
X-Rspamd-Queue-Id: 20C8343B5D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leonid Ravich <lravich@gmail.com>

commit 5c20311d76cbaeb7ed2ecf9c8b8322f8fc4a7ae3 upstream.

Tracepoints are not allowed to sleep, as such the following splat is
generated due to call to ib_query_pkey() in atomic context.

WARNING: CPU: 0 PID: 1888000 at kernel/trace/ring_buffer.c:2492 rb_commit+0xc1/0x220
CPU: 0 PID: 1888000 Comm: kworker/u9:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.3.1.el8.x86_64 #1
 Hardware name: Red Hat KVM, BIOS 1.13.0-2.module_el8.3.0+555+a55c8938 04/01/2014
 Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
 RIP: 0010:rb_commit+0xc1/0x220
 RSP: 0000:ffffa8ac80f9bca0 EFLAGS: 00010202
 RAX: ffff8951c7c01300 RBX: ffff8951c7c14a00 RCX: 0000000000000246
 RDX: ffff8951c707c000 RSI: ffff8951c707c57c RDI: ffff8951c7c14a00
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: ffff8951c7c01300 R11: 0000000000000001 R12: 0000000000000246
 R13: 0000000000000000 R14: ffffffff964c70c0 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8951fbc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f20e8f39010 CR3: 000000002ca10005 CR4: 0000000000170ef0
 Call Trace:
  ring_buffer_unlock_commit+0x1d/0xa0
  trace_buffer_unlock_commit_regs+0x3b/0x1b0
  trace_event_buffer_commit+0x67/0x1d0
  trace_event_raw_event_ib_mad_recv_done_handler+0x11c/0x160 [ib_core]
  ib_mad_recv_done+0x48b/0xc10 [ib_core]
  ? trace_event_raw_event_cq_poll+0x6f/0xb0 [ib_core]
  __ib_process_cq+0x91/0x1c0 [ib_core]
  ib_cq_poll_work+0x26/0x80 [ib_core]
  process_one_work+0x1a7/0x360
  ? create_worker+0x1a0/0x1a0
  worker_thread+0x30/0x390
  ? create_worker+0x1a0/0x1a0
  kthread+0x116/0x130
  ? kthread_flush_work_fn+0x10/0x10
  ret_from_fork+0x35/0x40
 ---[ end trace 78ba8509d3830a16 ]---

Fixes: 821bf1de45a1 ("IB/MAD: Add recv path trace point")
Signed-off-by: Leonid Ravich <lravich@gmail.com>
Link: https://lore.kernel.org/r/Y2t5feomyznrVj7V@leonid-Inspiron-3421
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ kovalev: bp to fix CVE-2022-50472 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/infiniband/core/mad.c |  5 -----
 include/trace/events/ib_mad.h | 13 ++++---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 19540a13cb84..e38ae4ac454f 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -59,9 +59,6 @@ static void create_mad_addr_info(struct ib_mad_send_wr_private *mad_send_wr,
 			  struct ib_mad_qp_info *qp_info,
 			  struct trace_event_raw_ib_mad_send_template *entry)
 {
-	u16 pkey;
-	struct ib_device *dev = qp_info->port_priv->device;
-	u8 pnum = qp_info->port_priv->port_num;
 	struct ib_ud_wr *wr = &mad_send_wr->send_wr;
 	struct rdma_ah_attr attr = {};
 
@@ -69,8 +66,6 @@ static void create_mad_addr_info(struct ib_mad_send_wr_private *mad_send_wr,
 
 	/* These are common */
 	entry->sl = attr.sl;
-	ib_query_pkey(dev, pnum, wr->pkey_index, &pkey);
-	entry->pkey = pkey;
 	entry->rqpn = wr->remote_qpn;
 	entry->rqkey = wr->remote_qkey;
 	entry->dlid = rdma_ah_get_dlid(&attr);
diff --git a/include/trace/events/ib_mad.h b/include/trace/events/ib_mad.h
index 59363a083ecb..d92691c78cff 100644
--- a/include/trace/events/ib_mad.h
+++ b/include/trace/events/ib_mad.h
@@ -49,7 +49,6 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		__field(int,            retries_left)
 		__field(int,            max_retries)
 		__field(int,            retry)
-		__field(u16,            pkey)
 	),
 
 	TP_fast_assign(
@@ -89,7 +88,7 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		  "hdr : base_ver 0x%x class 0x%x class_ver 0x%x " \
 		  "method 0x%x status 0x%x class_specific 0x%x tid 0x%llx " \
 		  "attr_id 0x%x attr_mod 0x%x  => dlid 0x%08x sl %d "\
-		  "pkey 0x%x rpqn 0x%x rqpkey 0x%x",
+		  "rpqn 0x%x rqpkey 0x%x",
 		__entry->dev_index, __entry->port_num, __entry->qp_num,
 		__entry->agent_priv, be64_to_cpu(__entry->wrtid),
 		__entry->retries_left, __entry->max_retries,
@@ -100,7 +99,7 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		be16_to_cpu(__entry->class_specific),
 		be64_to_cpu(__entry->tid), be16_to_cpu(__entry->attr_id),
 		be32_to_cpu(__entry->attr_mod),
-		be32_to_cpu(__entry->dlid), __entry->sl, __entry->pkey,
+		be32_to_cpu(__entry->dlid), __entry->sl,
 		__entry->rqpn, __entry->rqkey
 	)
 );
@@ -204,7 +203,6 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		__field(u16,            wc_status)
 		__field(u32,            slid)
 		__field(u32,            dev_index)
-		__field(u16,            pkey)
 	),
 
 	TP_fast_assign(
@@ -224,9 +222,6 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		__entry->slid = wc->slid;
 		__entry->src_qp = wc->src_qp;
 		__entry->sl = wc->sl;
-		ib_query_pkey(qp_info->port_priv->device,
-			      qp_info->port_priv->port_num,
-			      wc->pkey_index, &__entry->pkey);
 		__entry->wc_status = wc->status;
 	),
 
@@ -234,7 +229,7 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		  "base_ver 0x%02x class 0x%02x class_ver 0x%02x " \
 		  "method 0x%02x status 0x%04x class_specific 0x%04x " \
 		  "tid 0x%016llx attr_id 0x%04x attr_mod 0x%08x " \
-		  "slid 0x%08x src QP%d, sl %d pkey 0x%04x",
+		  "slid 0x%08x src QP%d, sl %d",
 		__entry->dev_index, __entry->port_num, __entry->qp_num,
 		__entry->wc_status,
 		__entry->length,
@@ -244,7 +239,7 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		be16_to_cpu(__entry->class_specific),
 		be64_to_cpu(__entry->tid), be16_to_cpu(__entry->attr_id),
 		be32_to_cpu(__entry->attr_mod),
-		__entry->slid, __entry->src_qp, __entry->sl, __entry->pkey
+		__entry->slid, __entry->src_qp, __entry->sl
 	)
 );
 
-- 
2.50.1


