Return-Path: <linux-rdma+bounces-4621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFB196316C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148571C21CD5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB61AC43C;
	Wed, 28 Aug 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="cUvMlT7Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C641ABEBB;
	Wed, 28 Aug 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875573; cv=none; b=YFhFVAAiLt18ftYavnrAacHjovSg5aDWmUC09GiT2m0Wpvu9kCyKNJleI4IjM0zngPQ4D9ND1sOEJmQrThYDbHM3S8in0LG15zU2AL6H+OCzO1W7K40Gmxu4RqirgNUg5qO3acvu12jdxhTRUspx5kIBHJpNr5z83dTNJCKVVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875573; c=relaxed/simple;
	bh=V2E9tUITa49EaxYUeSswLYuGRt1qeXnt98bH0/lm+Js=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RPZQIZAX9n8JXGdc9b/mGvidbARtx6z/DTV1sRDXUms7lzRudejj4VlU8b6eILw8CD9cJxrIW+bgiU2PqhGyrBz4D8NMdi+7KAdcWYa1y3LL94iN4wevsXpUMtG+zLwogRkRldz473+oOPM0i1mB7vyhYPB9625ky6OPscUVR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=cUvMlT7Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id F26AF20B7165; Wed, 28 Aug 2024 13:06:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F26AF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1724875572;
	bh=dZLG9ZlJdCTW7XunPOFOCjTZguZqOpflRSJwrkIlLGo=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=cUvMlT7Y/rkM9IKCZbeT2QuG88Q1/vxd+rSpmjDWh6fBnpIxLukJPkvzJ+f9xfoQv
	 LbtYXGW+wDDCfO37NbD3brORNe9nEtxOKuf1k1pcCWUMchQKFK9LNMVoa7pp8JqxS7
	 dcMvv9vJ29WbJRIVDtRWGiFFnh1MQrxhfCSfKuEI=
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
Subject: [PATCH net] RDMA/mana_ib: fix a bug in calculating the wrong page table index when 64kb page table is used
Date: Wed, 28 Aug 2024 13:06:08 -0700
Message-Id: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
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


