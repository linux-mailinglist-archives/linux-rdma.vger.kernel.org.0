Return-Path: <linux-rdma+bounces-16625-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBy0D393hWngBwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16625-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 06:09:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3542FA4A7
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 06:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FB693007539
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 05:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3160330D50;
	Fri,  6 Feb 2026 05:09:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C42566F7;
	Fri,  6 Feb 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354554; cv=none; b=tUQyKQgic+mA5umo0tXcnX5Kj6rp5Pan4TBoR7+GKp8e1F/Xde+LW0/9Y3QnuQ1OMJN1RhBxg3HR0B8ubnAVBy/jCL9o+fOF3NXBB44/tShW1TCDHAoKCC2ACPrstmjWeO5oFlZVNSzt7/xAggvvVt99FaAPO4HmDI8jAN9D3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354554; c=relaxed/simple;
	bh=TAZfoiGrw3PNQllTZSb1YY9jhdPtOmD7oISmUn9qdg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ejTJRrxtdBk6PYkmu0yY4oooIsxp4HUNm7oIIJ7pTDnIL6DOp34gaU1rP7xAkk4fFL4W7aVfhGmSaOhg/xt/Fdd9t0hOqBO6YTs/D+X7snZfIZTXYqoyUnarFfZ7UTcRVgoKo3NWjYjoUlYGZ0auP68SdXR8H21Gq08vZPvGu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Kyle Liddell
	<kyle.liddell@intel.com>, Caz Yokoyama <caz.yokoyama@intel.com>, Sadanand
 Warrier <sadanand.warrier@intel.com>, Arthur Kepner
	<arthur.kepner@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] IB/hfi1: Fix potential use-after-free in PIO and SDMA map teardown
Date: Fri, 6 Feb 2026 00:08:36 -0500
Message-ID: <20260206050836.5890-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16625-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3542FA4A7
X-Rspamd-Action: no action

From: Li RongQing <lirongqing@baidu.com>

The current teardown logic for dd->pio_map and dd->sdma_map frees the
structures while they might still be accessed by RCU readers. Although
the pointer is nulled under a spinlock, the memory is reclaimed before
waiting for the grace period to end.

This patch fixes the sequence by:
1. Extracting the pointer under the lock.
2. Clearing the RCU-protected pointer.
3. Waiting for readers to finish with synchronize_rcu().
4. Finally freeing the memory.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/infiniband/hw/hfi1/pio.c  | 5 ++++-
 drivers/infiniband/hw/hfi1/sdma.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 764286d..acf40f8 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1946,13 +1946,16 @@ int pio_map_init(struct hfi1_devdata *dd, u8 port, u8 num_vls, u8 *vl_scontexts)
 
 void free_pio_map(struct hfi1_devdata *dd)
 {
+	struct pio_vl_map *map;
+
 	/* Free PIO map if allocated */
 	if (rcu_access_pointer(dd->pio_map)) {
 		spin_lock_irq(&dd->pio_map_lock);
-		pio_map_free(rcu_access_pointer(dd->pio_map));
+		map = rcu_access_pointer(dd->pio_map);
 		RCU_INIT_POINTER(dd->pio_map, NULL);
 		spin_unlock_irq(&dd->pio_map_lock);
 		synchronize_rcu();
+		pio_map_free(map);
 	}
 	kfree(dd->kernel_send_context);
 	dd->kernel_send_context = NULL;
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 5cfa4f8..7c01616 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1255,6 +1255,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 {
 	size_t i;
 	struct sdma_engine *sde;
+	struct sdma_vl_map *map;
 
 	if (dd->sdma_pad_dma) {
 		dma_free_coherent(&dd->pcidev->dev, SDMA_PAD,
@@ -1291,10 +1292,11 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 	}
 	if (rcu_access_pointer(dd->sdma_map)) {
 		spin_lock_irq(&dd->sde_map_lock);
-		sdma_map_free(rcu_access_pointer(dd->sdma_map));
+		map = rcu_access_pointer(dd->sdma_map);
 		RCU_INIT_POINTER(dd->sdma_map, NULL);
 		spin_unlock_irq(&dd->sde_map_lock);
 		synchronize_rcu();
+		sdma_map_free(map);
 	}
 	kfree(dd->per_sdma);
 	dd->per_sdma = NULL;
-- 
2.9.4


