Return-Path: <linux-rdma+bounces-2504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079C8C7426
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610D51C225B3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A2143868;
	Thu, 16 May 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EJlQOi7M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EBA14293
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853080; cv=none; b=j9XbhHAM2Swov9WES/7hsnipxElSgFmU1zmbaaWKautgGIP3Vl6QM0Gd6JmUpDB703Atl6SjUHHSqWpSfcWlcXPNMK4G8mwcdXfopvrFdH6nU9AdUrj9D2K2rngcbYWrDpmMczot853Sry7tXGKilQxuAlYfMDmH/fGECTvk6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853080; c=relaxed/simple;
	bh=EDqhrwqvdUo/iBWjaEGbI3BPea15Zw70H3NRUdKkRWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8dLl9RPgclQpBdZTd1ir3UjdErJzSMoElOK0jPkRC7kzppaGPe39Rw9JvS/ZWeZL0WXtuwnOOoElH2nFjQIe/PtTulv1wAICJJD4xfq/CWkbXq7SVaCOmkfbMtkX9bI+Snzv59bkojXZsCW/8ciku3kIExohB094DO2SwlxESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EJlQOi7M; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Ow253
	hg5ev2lv4YBcYE2O+22Gg5wl+b0wII6AZriS/U=; b=EJlQOi7MPfxV1jtFofu+N
	HjFPEfzqH1vPrUDCny2pj7jKznLvkafM9FMI7OvbvhQRQX+5HPyhqEJ++WEVDcD/
	mAIWVNOUX0UQwm95Us7MBectHINh4xOqKywZhUHtTxsoT5mUm3nPZEMZEG3bspX/
	phVlZfSV1jfA1R3ou7yZBU=
Received: from fc39.. (unknown [183.81.182.182])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wDHD+4F10VmDr8aEw--.4760S4;
	Thu, 16 May 2024 17:51:02 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: honggangli@163.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Date: Thu, 16 May 2024 17:50:52 +0800
Message-ID: <20240516095052.542767-1-honggangli@163.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD+4F10VmDr8aEw--.4760S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyfKw4ftr1kJr48trWfAFb_yoWDXrg_Cr
	W8K3srGFW5CFn3C3ZrtryfWFy2va15ur1kZ3Waqa4fAry3uFn5Za4Iqr95Zw43Za1FkFs8
	JrnrW34xCFWrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAnYF3UUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDwzgRWVOD7-u1AABsG

For RDMA Send and Write with IB_SEND_INLINE, the memory buffers
specified in sge list will be placed inline in the Send Request.

The data should be copied by CPU from the virtual addresses of
corresponding sge list DMA addresses.

Fixes: 8d7c7c0eeb74 ("RDMA: Add ib_virt_dma_to_page()")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 614581989b38..b94d05e9167a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -812,7 +812,7 @@ static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
 	int i;
 
 	for (i = 0; i < ibwr->num_sge; i++, sge++) {
-		memcpy(p, ib_virt_dma_to_page(sge->addr), sge->length);
+		memcpy(p, ib_virt_dma_to_ptr(sge->addr), sge->length);
 		p += sge->length;
 	}
 }
-- 
2.45.0


