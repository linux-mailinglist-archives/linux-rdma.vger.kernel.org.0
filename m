Return-Path: <linux-rdma+bounces-3415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31691404D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 04:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC8B1F211B2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2253C28;
	Mon, 24 Jun 2024 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lfl/iLE5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CD8F40
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194703; cv=none; b=RQDRDDRuNU1eqMRD87MTByUqA3SL3COVl7M5q72EyfwqE4LWllT3Wna8EwpE+q8ZjpS34ZEAZQhmfUi5p5qTENp6iKaWRdTrEzqTxlvBCltvwACM6xj2ovgaCErwIPSfwyBeMt3ulolkDILSjF6DUgjyu/ejcSPJIi0oAuM+ySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194703; c=relaxed/simple;
	bh=Dh2KjbGfJhEWTATsy/urvDywqPAOwaTWjMnx+e55jMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf24S9l1tAvFNPang1kkgMw8A5KUPUWaDtfr88/ORNtuT7PtrCmjrjE6HjlBZqWpFVeWc2HE0SbASASrJYGjwX1tiTxgWKZLFqE2RJ0UZZPa0dmBQpThwXyXMG83sPJ2ChJoo7n15NvDNMyQXy1TKCKqgGsWFI+UA8v3W6OfjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lfl/iLE5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=exaxl
	aNTc6NRf+wrsiWzjAUdsg5xUGUYQM5KdPjG2GQ=; b=Lfl/iLE5LjCFWvP+BOyG6
	NtA0wfLZ0q0twwjXrz+reQxtUDioURHQHOWLNl11yJGWv6BG3hAsDQm459Hhs7Gy
	fq6dNenFQhD2M7nyRgXRfRbcgT6GVeMSAmIDpBNuOZ5z8l9oI6dq/ZAXwTz3GBmD
	+qij8RSbBfQ7M/5c6rp1d0=
Received: from fc39.. (unknown [183.81.182.182])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDn1ygr1HhmAUv_AA--.13076S4;
	Mon, 24 Jun 2024 10:04:29 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: dledford@redhat.com,
	kamalh@mellanox.com,
	amirv@mellanox.com,
	monis@mellanox.com,
	haggaie@mellanox.com,
	honggangli@163.com
Subject: [PATCH] RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs
Date: Mon, 24 Jun 2024 10:03:48 +0800
Message-ID: <20240624020348.494338-1-honggangli@163.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1ygr1HhmAUv_AA--.13076S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4xGr45Cw13Gw18XFWDurg_yoWkAwc_C3
	y8trn7XFWUGFs3Aw13ArW5Cry0kw42y39Y93Z0ga15Ary3uF4fA397WFy8uw1UuF1Fyrs8
	AryDZwnYkay2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU1vVtUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDxEIRWVOEwiJ-QAAsX

BTH_ACK_MASK bit is used to indicate that an acknowledge
(for this packet) should be scheduled by the responder.
Both UC and UD QPs are unacknowledged, so don't set
BTH_ACK_MASK for UC or UD QPs.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index cd14c4c2dff9..ffd7ed712a02 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -445,8 +445,12 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
 
-	ack_req = ((pkt->mask & RXE_END_MASK) ||
-		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_UC)
+		ack_req = 0;
+	else {
+		ack_req = ((pkt->mask & RXE_END_MASK) ||
+			(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+	}
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
-- 
2.45.2


