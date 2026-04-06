Return-Path: <linux-rdma+bounces-19038-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA0NMY6102nLkgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19038-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 15:30:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAA3A38F8
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D895830263CA
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361FE372B37;
	Mon,  6 Apr 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fs8UYGUx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95E28751B
	for <linux-rdma@vger.kernel.org>; Mon,  6 Apr 2026 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482152; cv=none; b=rCbut9+OL8wWjSPtLMoYT7BLPrpIvtNk3uODZMLa7r+aQzkxcPSEBivombyIGkyp72WNCZKo3ALvqN0O3Fmb5wS28jn5isMm0CmEHlat60sRGyz76cOatbmeSL7ChYFCwOXfqlEUzEcvSpVPjhTUL1F4az45Wve5aLRt+am22rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482152; c=relaxed/simple;
	bh=Pb0Ht32CUEfKTpgdfS5Sb8QSBESokRrXsw/1ceFr1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j25wYC/5PIhEMp00CHxIP5gI/EwtAhH8oq/cxWUQnTIKG4haCHw+pm/c52dsC8OP2BdAX0T98xI+W0+dMr8J9YueoKfHyzVwSyXp/iu69Mu6A2JaQAOwMAdLnbdgZ57DMFDrnJ4IECaPvdWsNQ23a0ecXR2ooj4CK0MfzBRllZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fs8UYGUx; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775482148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7kCt14hnsEavZYgYShaEjTpC641cL3XlLdxhEoW0x8=;
	b=Fs8UYGUx5QkhHu92keW3T3GuvcQ4QtYzg01TJuQYtK2SkMPMEMb60ORJ4LAGIYojM7uhOT
	DEctGvWRLd595QAUg9cLC1iTg9si+MOqDzqyDOnoROpw9dvkxnoSoRMyNy8OjUN4g3QwpG
	EXc/LIHQI85Rp/Wto87Y49Kay+B/aGY=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v4 4/4] RDMA/rxe: support perf mgmt GET method
Date: Mon,  6 Apr 2026 21:28:29 +0800
Message-ID: <20260406132830.435381-5-zhenwei.pi@linux.dev>
In-Reply-To: <20260406132830.435381-1-zhenwei.pi@linux.dev>
References: <20260406132830.435381-1-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19038-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 43EAA3A38F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In RXE, hardware counters are already supported, but not in a
standardized manner. For instance, user-space monitoring tools like
atop only read from the *counters* directory. Therefore, it is
necessary to add perf management support to RXE.

Also use rxe_counter_get instead of raw atomic64_read in hw-counters.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/Makefile    |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |   6 ++
 drivers/infiniband/sw/rxe/rxe_mad.c   | 101 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |   1 +
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 3977f4f13258..e097c1ca1874 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -23,6 +23,7 @@ rdma_rxe-y := \
 	rxe_task.o \
 	rxe_net.o \
 	rxe_hw_counters.o \
+	rxe_mad.o \
 	rxe_ns.o
 
 rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index e095c12699cb..64d636bf80fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -242,4 +242,10 @@ static inline int rxe_ib_advise_mr(struct ib_pd *pd,
 
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
+/* rxe-mad.c */
+int rxe_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
+		    const struct ib_wc *in_wc, const struct ib_grh *in_grh,
+		    const struct ib_mad *in, struct ib_mad *out,
+		    size_t *out_mad_size, u16 *out_mad_pkey_index);
+
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mad.c b/drivers/infiniband/sw/rxe/rxe_mad.c
new file mode 100644
index 000000000000..7cf6d94e636e
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_mad.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2026 zhenwei pi <zhenwei.pi@linux.dev>
+ */
+
+#include <rdma/ib_pma.h>
+#include "rxe.h"
+#include "rxe_hw_counters.h"
+
+static int rxe_get_pma_info(struct ib_mad *out)
+{
+	struct ib_class_port_info cpi = {};
+
+	cpi.capability_mask = IB_PMA_CLASS_CAP_EXT_WIDTH;
+	memcpy((out->data + 40), &cpi, sizeof(cpi));
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
+
+static int rxe_get_pma_counters(struct rxe_dev *rxe, struct ib_mad *out)
+{
+	struct ib_pma_portcounters *pma_cnt = (struct ib_pma_portcounters *)(out->data + 40);
+	s64 val;
+
+	/* IBA release 1.8, 16.1.3.5: During operation, instead of overflowing, they shall stop
+	 * at all ones.
+	 */
+	val = atomic64_read(&rxe->stats_counters[RXE_CNT_LINK_DOWNED]);
+	if (val > U8_MAX)
+		pma_cnt->link_downed_counter = U8_MAX;
+	else
+		pma_cnt->link_downed_counter = (u8)val;
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
+
+static int rxe_get_pma_counters_ext(struct rxe_dev *rxe, struct ib_mad *out)
+{
+	struct ib_pma_portcounters_ext *pma_cnt_ext =
+		(struct ib_pma_portcounters_ext *)(out->data + 40);
+	s64 val;
+
+	val = atomic64_read(&rxe->stats_counters[RXE_CNT_SENT_BYTES]);
+	pma_cnt_ext->port_xmit_data = cpu_to_be64(val >> 2);
+
+	val = atomic64_read(&rxe->stats_counters[RXE_CNT_RCVD_BYTES]);
+	pma_cnt_ext->port_rcv_data = cpu_to_be64(val >> 2);
+
+	val = atomic64_read(&rxe->stats_counters[RXE_CNT_SENT_PKTS]);
+	pma_cnt_ext->port_xmit_packets = cpu_to_be64(val);
+
+	val = atomic64_read(&rxe->stats_counters[RXE_CNT_RCVD_PKTS]);
+	pma_cnt_ext->port_rcv_packets = cpu_to_be64(val);
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
+
+static int rxe_get_perf_mgmt(struct rxe_dev *rxe, const struct ib_mad *in, struct ib_mad *out)
+{
+	switch (in->mad_hdr.attr_id) {
+	case IB_PMA_CLASS_PORT_INFO:
+		return rxe_get_pma_info(out);
+
+	case IB_PMA_PORT_COUNTERS:
+		return rxe_get_pma_counters(rxe, out);
+
+	case IB_PMA_PORT_COUNTERS_EXT:
+		return rxe_get_pma_counters_ext(rxe, out);
+
+	default:
+		out->mad_hdr.status = cpu_to_be16(IB_MGMT_MAD_STATUS_UNSUPPORTED_METHOD_ATTRIB);
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+	}
+}
+
+int rxe_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
+		    const struct ib_wc *in_wc, const struct ib_grh *in_grh,
+		    const struct ib_mad *in, struct ib_mad *out,
+		    size_t *out_mad_size, u16 *out_mad_pkey_index)
+{
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	u8 mgmt_class = in->mad_hdr.mgmt_class;
+	u8 method = in->mad_hdr.method;
+
+	if (port_num != 1)
+		return IB_MAD_RESULT_FAILURE;
+
+	memset(out, 0, sizeof(*out));
+	switch (mgmt_class) {
+	case IB_MGMT_CLASS_PERF_MGMT:
+		if (method == IB_MGMT_METHOD_GET)
+			return rxe_get_perf_mgmt(rxe, in, out);
+		break;
+
+	default:
+		break;
+	}
+
+	out->mad_hdr.status = cpu_to_be16(IB_MGMT_MAD_STATUS_UNSUPPORTED_METHOD);
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d3b2d610ca37..1ef5cddf620a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1505,6 +1505,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.post_recv = rxe_post_recv,
 	.post_send = rxe_post_send,
 	.post_srq_recv = rxe_post_srq_recv,
+	.process_mad = rxe_process_mad,
 	.query_ah = rxe_query_ah,
 	.query_device = rxe_query_device,
 	.query_pkey = rxe_query_pkey,
-- 
2.43.0


