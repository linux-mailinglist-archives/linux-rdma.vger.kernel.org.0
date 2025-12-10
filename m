Return-Path: <linux-rdma+bounces-14956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23BDCB3A48
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B8503017A48
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5B3233E3;
	Wed, 10 Dec 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LBAq/mqf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2728207A32
	for <linux-rdma@vger.kernel.org>; Wed, 10 Dec 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765388231; cv=none; b=g4F91Zi+wu4OpcuAKZsrE9zFTU4dptK6zGOT5lo2pHa5281GIYLTzCtEBzjdEMVrSRk2JxnpIjVZeSMFZwmdtXxEwzLmx53IRbYicRKupYDiX9os1tZ/b5gX8KAQcvUaexTQYZ+DnyKoY1QcBKFluVrMOA0lg1SDYd/hBQ5YT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765388231; c=relaxed/simple;
	bh=+oVYyKrTWRuooM+e6M7777f7fuo1Z8REtQ8qP7ti65I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRImnmZZtvINsiX+a03fRpguI2ELPjtJpATX2Sg9Tx25+bN1s3kKk3HlETtSeOgf3U0j3u8AImnM3JWvoDxL2SyeTjiz9D3e1shi9zFLKxRGK/4nJW5TCvZ3OJ/j9jc2XcaBlLRKKJbievVm10gAgCuQvVJoeLNVABzSm24YoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LBAq/mqf; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765388229; x=1796924229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cwqjfpIeVCfdOlO4ch1vYJcdaWYPlm4fPoB7IKKw05M=;
  b=LBAq/mqfHMI+jFire1ZO5O1NhfgoGfVw8M+pG2v73K6wfZnxuzxe8PIh
   75HrotoiGD9/xqqGHYTsn4yrYvrUmyS1zbvY3thYxit5nRaw6M33+6R+U
   T5OxIJcUvRMjMhaRUrdpUe0ouEPySRZKO5UB0W8ZIS0I1pFYldaMbzNaL
   HHWqjjNzPQGJZfNT+QYWjIkvzdTt9RicB1bM/lgrYnG1RT5JtyruW7Uub
   Pvb8seLX3e9JHpTxu8koePE6iN6eTB+xx4bE1J4t3kk4PXWzZ8rN6xAdQ
   KtWtV5QVY7CCtoLgaOSMTdMswoTkdvRo9EpIUPnPOkzRAHQWerubcC6yO
   w==;
X-CSE-ConnectionGUID: HAjhV8JgRyOY0QmLeHGpSA==
X-CSE-MsgGUID: Awddz8jFSa2UqdrRHXYWMw==
X-IronPort-AV: E=Sophos;i="6.20,264,1758585600"; 
   d="scan'208";a="8652178"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 17:37:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:5398]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.230:2525] with esmtp (Farcaster)
 id aca7c0a7-0aff-4cf4-aaa8-341bac7fd083; Wed, 10 Dec 2025 17:37:07 +0000 (UTC)
X-Farcaster-Flow-ID: aca7c0a7-0aff-4cf4-aaa8-341bac7fd083
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Dec 2025 17:36:59 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 10 Dec 2025
 17:36:58 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Tom
 Sela" <tomsela@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH] RDMA/efa: Remove possible negative shift
Date: Wed, 10 Dec 2025 17:36:56 +0000
Message-ID: <20251210173656.8180-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The page size used for device might in some cases be smaller than
PAGE_SIZE what results in a negative shift when calculating the number
of host pages in PAGE_SIZE for a debug log. Remove the debug line
together with the calculation.

Reviewed-by: Tom Sela <tomsela@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22d3e25c3b9d..755bba8d58bb 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1320,13 +1320,9 @@ static int umem_to_page_list(struct efa_dev *dev,
 			     u32 hp_cnt,
 			     u8 hp_shift)
 {
-	u32 pages_in_hp = BIT(hp_shift - PAGE_SHIFT);
 	struct ib_block_iter biter;
 	unsigned int hp_idx = 0;
 
-	ibdev_dbg(&dev->ibdev, "hp_cnt[%u], pages_in_hp[%u]\n",
-		  hp_cnt, pages_in_hp);
-
 	rdma_umem_for_each_dma_block(umem, &biter, BIT(hp_shift))
 		page_list[hp_idx++] = rdma_block_iter_dma_address(&biter);
 
-- 
2.47.3


