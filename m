Return-Path: <linux-rdma+bounces-14954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C526CB2FBF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 14:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FF6D301E5F0
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C6207A32;
	Wed, 10 Dec 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W4QQi92c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0943AA6;
	Wed, 10 Dec 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372577; cv=none; b=rbDnXRtw1TJKrbYvt3r80o9fykyHMRPErhLP5Gz4NN/X8wod41grLgKiYemV+VQ3s2q0SETKYe2mB4f+issVCNUEaulCtn67uKFWgZNojWkq8x6cHzusJjZ404eHeWa9+yS1a02DWlLBrrVDxR1IT35qV+3yOM1d/melkLPqWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372577; c=relaxed/simple;
	bh=1L15fxF5wCvcnci/IDH1flEWQ/ZxEisBA1XCRveqJOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhPx8GUWYTM1+WXwyWufrEhU53cWKNaKY75Nto/ca4ACtGqgPNLBTmwuvIqa/1Qaelyl2jFSOQO648PxGBwqZGkDZzpcUjtZhYgEl3fY6oW5FWC0QiE39Ka4cU1ggbReTxBvZv4GY1PCZGiYaASvQ7Hw9P0lsqoZHtg2txb7Mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W4QQi92c; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765372573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8tIAMfxaWjtRGPcV8/eYqm4n2ylsDhAaF/W3QJDQ3TI=;
	b=W4QQi92cfhazsVDjshlk0rwhJ3RopDY48BMWMoe86JlBs0DxGcv5RI4OP70t75IZlmoyjs
	+qDKfGLQ89aXbbaLOZsx/ZeeDkWZH3nHOE8g6HC/3ArHCAGPiL0Jf1ZM8kiGHbuJXTGZrq
	8OOQw6zT7x7DPEPVajTi+XvZYtoTlig=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: Replace cpu_to_be64 + le64_to_cpu with swab64
Date: Wed, 10 Dec 2025 14:15:29 +0100
Message-ID: <20251210131528.569382-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace cpu_to_be64(le64_to_cpu()) with swab64() to simplify
bnxt_re_assign_pma_port_ext_counters().  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 651cf9d0e0c7..bb1137ad84c0 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -290,19 +290,12 @@ int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad
 	pma_cnt_ext = (struct ib_pma_portcounters_ext *)(out_mad->data + 40);
 	if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
 	    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
-		pma_cnt_ext->port_xmit_data =
-			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_bytes) / 4);
-		pma_cnt_ext->port_rcv_data =
-			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_bytes) / 4);
-		pma_cnt_ext->port_xmit_packets =
-			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
-		pma_cnt_ext->port_rcv_packets =
-			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
-		pma_cnt_ext->port_unicast_rcv_packets =
-			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
-		pma_cnt_ext->port_unicast_xmit_packets =
-			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
-
+		pma_cnt_ext->port_xmit_data = swab64(hw_stats->tx_ucast_bytes / 4);
+		pma_cnt_ext->port_rcv_data = swab64(hw_stats->rx_ucast_bytes / 4);
+		pma_cnt_ext->port_xmit_packets = swab64(hw_stats->tx_ucast_pkts);
+		pma_cnt_ext->port_rcv_packets = swab64(hw_stats->rx_ucast_pkts);
+		pma_cnt_ext->port_unicast_rcv_packets = swab64(hw_stats->rx_ucast_pkts);
+		pma_cnt_ext->port_unicast_xmit_packets = swab64(hw_stats->tx_ucast_pkts);
 	} else {
 		pma_cnt_ext->port_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
 		pma_cnt_ext->port_rcv_data = cpu_to_be64(estat->rx_roce_good_bytes / 4);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


