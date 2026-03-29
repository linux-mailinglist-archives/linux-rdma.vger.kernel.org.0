Return-Path: <linux-rdma+bounces-18764-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGfoD/y7yGmlpwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18764-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 07:43:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1DE350D86
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A525E3034316
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 05:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527529D281;
	Sun, 29 Mar 2026 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGuZVewN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7728FFFB
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774762944; cv=none; b=SiZWkRWxlJ4v5j7Fe49JpOoRl3sCMw0N9yhtTPzOiqdOPV2dSDpc6k8bL6HhVM5fcFrZYNyqZg6132p9tIkk1QDAJrSxgXZFY52GDhy8skbgHFcrvf0siDebS6FcgJpMJZ/4M0XYdcJe6r5SLMS2y9r9vcIOksIhhutxGsVTeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774762944; c=relaxed/simple;
	bh=odX1WzUOisnIjbngzWrEzk71b5natdlujLZcp8tSYY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xyp4uHREW3fnkMMQf50A8a0ZRVDO0D4dZ1TI3qsbYah6QtN4A1/rFCyz4tzpvfYO2L8nlCpmd9DG8j8uMl9rr5flLPkn5F7Dg/1seZ4SyzMAo3KyekRicQm2ShsQXrtbctThHPJlnk5ActzAccewvMRspD6hx0AFAxvhj490Xr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGuZVewN; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774762941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2sp5/GUf5BPEEdnIMYDtF74UILlR+HyIrGJbl+kuY4=;
	b=IGuZVewNi9JJOYRB8e7iExp94eseK/kvTYPjKXOCva95q+GSV906ecrzUO42gqmn4CXkyb
	7RZNuUWunbedobuu88N9nBgjVVnPNhJcOlcwMD64vQXRDGZu9Q5r+Z+QxQSFpQsVsxKJdg
	73LU7V07GR2nZcFe8t3iSmkXUlzQLAo=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v3 3/3] RDMA/rxe: support perf mgmt GET method
Date: Sun, 29 Mar 2026 13:41:56 +0800
Message-ID: <20260329054156.125362-4-zhenwei.pi@linux.dev>
In-Reply-To: <20260329054156.125362-1-zhenwei.pi@linux.dev>
References: <20260329054156.125362-1-zhenwei.pi@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-18764-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB1DE350D86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In RXE, hardware counters are already supported, but not in a
standardized manner. For instance, user-space monitoring tools like
atop only read from the *counters* directory. Therefore, it is
necessary to add perf management support to RXE.

Also use rxe_counter_get instead of raw atomic64_read in hw-counters.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/Makefile          |  1 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         |  6 ++
 drivers/infiniband/sw/rxe/rxe_mad.c         | 93 +++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  5 ++
 6 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 93134f1d1d0c..3c47e5b982c2 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -22,6 +22,7 @@ rdma_rxe-y := \
 	rxe_mcast.o \
 	rxe_task.o \
 	rxe_net.o \
+	rxe_mad.o \
 	rxe_hw_counters.o
 
 rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index 17edaa9a9b9b..a612e96f7a88 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -37,7 +37,7 @@ int rxe_ib_get_hw_stats(struct ib_device *ibdev,
 		return -EINVAL;
 
 	for (cnt = 0; cnt < ARRAY_SIZE(rxe_counter_descs); cnt++)
-		stats->value[cnt] = atomic64_read(&dev->stats_counters[cnt]);
+		stats->value[cnt] = rxe_counter_get(dev, cnt);
 
 	return ARRAY_SIZE(rxe_counter_descs);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 7992290886e1..a8ce85147c1f 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -245,4 +245,10 @@ static inline int rxe_ib_advise_mr(struct ib_pd *pd,
 
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
index 000000000000..f41b8d5cdfe1
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_mad.c
@@ -0,0 +1,93 @@
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
+	val = rxe_counter_get(rxe, RXE_CNT_LINK_DOWNED);
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
+
+	pma_cnt_ext->port_xmit_data = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_SENT_BYTES) >> 2);
+	pma_cnt_ext->port_rcv_data = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_RCVD_BYTES) >> 2);
+	pma_cnt_ext->port_xmit_packets = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_SENT_PKTS));
+	pma_cnt_ext->port_rcv_packets = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_RCVD_PKTS));
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
+	if (port_num != RXE_PORT)
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
index bcd486e8668b..7df0cb5a09a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1509,6 +1509,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.post_recv = rxe_post_recv,
 	.post_send = rxe_post_send,
 	.post_srq_recv = rxe_post_srq_recv,
+	.process_mad = rxe_process_mad,
 	.query_ah = rxe_query_ah,
 	.query_device = rxe_query_device,
 	.query_pkey = rxe_query_pkey,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 2bcfb919a40b..1c4fa8eaa733 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -466,6 +466,11 @@ static inline void rxe_counter_add(struct rxe_dev *rxe, enum rxe_counters index,
 	atomic64_add(val, &rxe->stats_counters[index]);
 }
 
+static inline s64 rxe_counter_get(struct rxe_dev *rxe, enum rxe_counters index)
+{
+	return atomic64_read(&rxe->stats_counters[index]);
+}
+
 static inline struct rxe_dev *to_rdev(struct ib_device *dev)
 {
 	return dev ? container_of(dev, struct rxe_dev, ib_dev) : NULL;
-- 
2.43.0


