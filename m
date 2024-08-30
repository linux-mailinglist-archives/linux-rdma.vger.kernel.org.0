Return-Path: <linux-rdma+bounces-4668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCBB966518
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372391F24DD2
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F11B1D5F;
	Fri, 30 Aug 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="ZqDrwNMT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCBEACD;
	Fri, 30 Aug 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031004; cv=none; b=S3GJae06i+Zes7vweoXPDdFsa5IC8U1aBVYeW/BCEX2LRDl5/K4xuEw2bZNJpx0ww25TGz5Y3vtxbjP1UNMZ92VLIi31QwRD2Moqeoan2Z6NaUUCHnubpeEI71U22CGJYZvJxVKwrCY3ho6LokHm9fQWP5V1+Hr8Gp69ff0h7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031004; c=relaxed/simple;
	bh=g+wXH8diiArOpiFAZ4p7I2LZkyYLwQaQGlmBFwZYjuc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U2p2mSkaSSARm15xmsz2pGSXW38KTOc1pi4sYYGkRgv64NdW6iHYwgQjn9+UMA0q/9+tTy6gJI7lwrt90HmbwoVOjIDQf5Ai0LrMJPDTgPn9vDJ4rPnda9rLKP2V5mYc1BMl88qUgf2nd/zRSS0BJmkHf8BPQyVmzMhvVd6Gt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=ZqDrwNMT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id C1E3620B7165; Fri, 30 Aug 2024 08:16:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1E3620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1725030997;
	bh=yWbH6WERHo/4P/dpJi9ViKZqC7UJeDZwqOXbc7gy6wk=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=ZqDrwNMT1yoU9oOzVJS3bkdFYKkOPkbUBu/ibtuvzsr4daMePaN/V4sPei71zDw7y
	 JNjvAbws9yFzO4RTVQ7OEbkutm8qIy1uiv6/qpCIA5KYWRyKg337W8yKGTnbyed0Nd
	 S/rlrZoLKps4RBIHjFVmbP3ncmphk8A8JJ/YzNgM=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH rdma-next v2 1/2] RDMA/mana_ib: use the correct page table index based on hardware page size
Date: Fri, 30 Aug 2024 08:16:32 -0700
Message-Id: <1725030993-16213-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

MANA hardware uses 4k page size. When calculating the page table index,
it should use the hardware page size, not the system page size.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Long Li <longli@microsoft.com>
---
change log
v2: replaced net with rdma-next tag in patch title and simplified the title

 drivers/infiniband/hw/mana/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index d13abc954d2a..f68f54aea820 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -383,7 +383,7 @@ static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
 
 	create_req->length = umem->length;
 	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
-	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
+	create_req->gdma_page_type = order_base_2(page_sz) - MANA_PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
 	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu num_pages_total %lu\n",
-- 
2.17.1


