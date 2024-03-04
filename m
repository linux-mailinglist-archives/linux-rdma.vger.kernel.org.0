Return-Path: <linux-rdma+bounces-1203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C08A87034B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF20B221CF
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15013EA83;
	Mon,  4 Mar 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m7HWS9FK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1603E468;
	Mon,  4 Mar 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560374; cv=none; b=B8UyPBKXrWvVtxaYut08Zk6mXnmW6d4jlLtFqv06HGFlPNpwPGSBZ9F5np7/5M9dBcPkMw2AYvSqZpwXFvuoCCRgRqlF8//FmNptFvW2VqDOi6jYpr6sYSSO6pepItHnvcEqbhUaZ6p2YREYpXzHykLwvhl2Xz7gQCS7anB85ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560374; c=relaxed/simple;
	bh=Tj7WsO02oBY3rpOVtVkrmLamQ8bHlbEb+mt75vTTGAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AhVTqWNZ8MgjTNed0jtqHhQ3PTM5IMx5B3U1fT2uIpq6/s5BVaUOwc2Ehz+SqrPpFqe8TRYuVHjjGwoHqkNXsOdp2i9Qy/uwL6wZc4VY1ckyHeoQNBV+J6Nz5u2DYk+CDkNraH1qXm0f7W+Bphy5itFYNx9K5NgnC2Cofdo8kns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m7HWS9FK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3050420B74C1;
	Mon,  4 Mar 2024 05:52:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3050420B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709560367;
	bh=KEd2yZoIBVvL18aDItKvfvTSbUPB7RV44kXga7k9ang=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7HWS9FKynD9hCTJb8HUvOydOjlW7R61XvzXbL3qC2Fp0G3EtiEA4XULAIUhamUB3
	 rR9dFVAZVtsI89TlNepYowrsTV7CCr4F1LVdGNid7u8LwgnMV1rfobPaT2s+nUHNMv
	 nDI5hLOb1f63vnGnbmerWmfQL3DQDrO64Mm8UCWs=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 1/2] RDMA/mana_ib: Fix bug in creation of dma regions
Date: Mon,  4 Mar 2024 05:52:40 -0800
Message-Id: <1709560361-26393-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1709560361-26393-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1709560361-26393-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use ib_umem_dma_offset() helper to calculate correct dma offset.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 29dd2438d..dd570832d 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -348,7 +348,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 			     sizeof(struct gdma_create_dma_region_resp));
 
 	create_req->length = umem->length;
-	create_req->offset_in_page = umem->address & (page_sz - 1);
+	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
 	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
-- 
2.43.0


