Return-Path: <linux-rdma+bounces-19322-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFlhHC7f3WkYkgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19322-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:31:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FA3F5F45
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C423303FFD7
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 06:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E15336AB46;
	Tue, 14 Apr 2026 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="djDStVrv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7B369981
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148227; cv=none; b=uVwqtNWwkNmUh6DYdY8fJ3xGOuxGHOqRmpb5OSMVn4dezzN/InF5zDUc0h3Ogd4YH8bll8tKujRcoAnhzF+z0LthN/FucdQb0G1KlEfSGURMk+uXap4GRpk0WksAPwIw5H/AgmKvP+ASW3OIkSK/fGYvXUClwqfUs6rS5YPW1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148227; c=relaxed/simple;
	bh=gG44iXHx9nTcl722pxo/EULpV1wt9L9h8ugZHQSema4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltifCdHCz/qyH6T/+Jrdykqr6CK3e47S2yyWZ/NYIFS3xcavHs9VWMvmBabkCWAxzClo38g9iHoFTByjGxjy2PF9l2OGI5ysas8erlDcoB/pku0IKLdQ2MZhnn+iowAIrUoCcp7nCxTYgCSOS07a5sDpbxzI+aZj+Gw0qgZdJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=djDStVrv; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776148224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpPita2qv7oC8Q5RczDZc9Ulot3JW1NrQ3aoE//GC1c=;
	b=djDStVrvNOj1GGNr8OvZ/cCW9Imw0SfceeJsEwdOjdWMiTp6a83yBIwJwp8aiNrBxhBH3d
	4hyGE5OxdUIvyQ4pQflrlrV3uUYQ00buoz3AszPGZvJF7OWrOs/+cQzclhsG9y8fxYXpmi
	gaSCWADkQ1bM8ZhCqCax0cF8BlQIF14=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v7 3/4] RDMA/rxe: support perf mgmt GET method
Date: Tue, 14 Apr 2026 14:29:47 +0800
Message-ID: <20260414062948.671658-4-zhenwei.pi@linux.dev>
In-Reply-To: <20260414062948.671658-1-zhenwei.pi@linux.dev>
References: <20260414062948.671658-1-zhenwei.pi@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-19322-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE0FA3F5F45
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
index 000000000000..d54ee49e225e
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
+		return IB_MAD_RESULT_SUCCESS;
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
+		out->mad_hdr.status = cpu_to_be16(IB_MGMT_MAD_STATUS_UNSUPPORTED_METHOD);
+		return IB_MAD_RESULT_SUCCESS;
+	}
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index eb17b6086d5e..8edd4dd1f031 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1496,6 +1496,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.post_recv = rxe_post_recv,
 	.post_send = rxe_post_send,
 	.post_srq_recv = rxe_post_srq_recv,
+	.process_mad = rxe_process_mad,
 	.query_ah = rxe_query_ah,
 	.query_device = rxe_query_device,
 	.query_pkey = rxe_query_pkey,
-- 
2.43.0


