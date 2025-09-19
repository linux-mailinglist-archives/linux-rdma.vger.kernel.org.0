Return-Path: <linux-rdma+bounces-13512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE0B87F07
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 07:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AC556945A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 05:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF126560D;
	Fri, 19 Sep 2025 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A+FmHRiT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7325DAF0;
	Fri, 19 Sep 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260614; cv=none; b=oI3ewQ698znpTQP4GReZnjiWVHADd7CMEokl7cZyq0ePhNxQvKYcm6Z1aBhql9+I6aaKnYMW8NN3e3Ig8wC6nNqbda2B4npMwpG5mVyBoF9qvvH7cvJ5NQjAXCip/lvAQGU67i8mJdm2QomaBNBx+/EX5YC7J9Jx5VgAYP2TIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260614; c=relaxed/simple;
	bh=ivSPbVdKipX7Q7V4zcUvxvFhobL0E3ii3lnlqHGQKoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbpPNOQ9GI4ozsguEPN+Ts5cRFRN8i9DxXAk3G1BaDORHAcFloYh3WEU+CTwJKVGOPXfkI82vxZEZ1VZTbPJPKTlhk0Ys4gRKcRy34OdM18dP6wyC0SfGUQcHpyVUBm/h3F5W0bB+j54byIg+2uZrMH7GXIbzGfCZwkI9T0pZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A+FmHRiT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8e
	xNzx+xoJqlafHrTNqWHrkBAyUceFUk2Em0hLWMCR4=; b=A+FmHRiTcDYWArJ3X4
	S7UrBsZRxMcC8VWMWXxgini9nvW6hnAlMshg3neLLA3sjrzWYzvWAQNjUv1KmU9n
	Kgxd1FSzItjx38+Uw+ONIBqyk1b1RXCfvMjj3MnmjyAumKwIlUKkfxNB+5vRg47N
	MrcPrV60RdABldIBTlBL/jvFQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnOfNQ7cxoDR8oDg--.24033S2;
	Fri, 19 Sep 2025 13:42:41 +0800 (CST)
From: YanLong Dai <dyl_wlc@163.com>
To: kalesh-anakkur.purayil@broadcom.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com,
	daiyanlong@kylinos.cn,
	dyl_wlc@163.com
Subject: [PATCH rdma-rc] RDMA/bnxt_re: Fix a potential memory leak in destroy_gsi_sqp
Date: Fri, 19 Sep 2025 13:42:38 +0800
Message-ID: <20250919054238.5374-1-dyl_wlc@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnOfNQ7cxoDR8oDg--.24033S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4kKryxZr1kAF13WrW3Jrb_yoW8Xw4kpr
	43Ga4qk3y5JF4xWFWUAa4UXa15GayIy3ykta9FkwnxAw1rA3Z7XFyfK3ZaqF95CrZ5Gr4I
	vw15Jrs8Ga47WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELvtJUUUUU=
X-CM-SenderInfo: 5g1os4lof6il2tof0z/1tbiEAPNImjM5S61LAAAsK

From: daiyanlong <daiyanlong@kylinos.cn>

The current error handling path in bnxt_re_destroy_gsi_sqp() could lead
to a resource leak. When bnxt_qplib_destroy_qp() fails, the function
jumps to the 'fail' label and returns immediately, skipping the call
to bnxt_qplib_free_qp_res().

Continue the resource teardown even if bnxt_qplib_destroy_qp() fails,
which aligns with the driver's general error handling strategy and
prevents the potential leak.

Fixes: 8dae419f9ec73 ("RDMA/bnxt_re: Refactor queue pair creation code")

Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 260dc67b8b87..15d3f5d5c0ee 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -931,10 +931,9 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 
 	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
-	if (rc) {
+	if (rc)
 		ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
-		goto fail;
-	}
+
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
 
 	/* remove from active qp list */
@@ -951,8 +950,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	rdev->gsi_ctx.sqp_tbl = NULL;
 
 	return 0;
-fail:
-	return rc;
 }
 
 /* Queue Pairs */
-- 
2.43.0


