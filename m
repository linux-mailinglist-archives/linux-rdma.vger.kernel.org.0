Return-Path: <linux-rdma+bounces-1129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1F866AA1
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 08:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2416E28353D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682321BF47;
	Mon, 26 Feb 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rYZwS6si"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD11BDDC;
	Mon, 26 Feb 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932359; cv=none; b=lNKwjQseueF0Typs9clInvaRWKLIlKYy7NhysB5C8zx1qeChmuFL839Te6CEDDxQrinP5EUtdTvVuhD0A44nrFWWqQfb/VggDHKDjb24xc1oZyDjuhvyWKNeCQjlVsXgAsDctLIxApGj2Na6E8cg+DtLtTv8g4oDPuL2lSanbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932359; c=relaxed/simple;
	bh=Tj7WsO02oBY3rpOVtVkrmLamQ8bHlbEb+mt75vTTGAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pMJORzKLZtOokAqoYmlDOoCLE5X4jy0f2pqBamzCvec6cWo/+MGDqGRtllLD6p5SMQz3u5w6d/gGL92xZOpfOTUnvbZB0Uac6wf+z4K3buD0yaiLJfH50zzNVZSscd70WcwlUAMs8UEeNoB06hZlIhtOoKHNWDdogblcdLJlbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rYZwS6si; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B4C720B74C1;
	Sun, 25 Feb 2024 23:25:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B4C720B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708932351;
	bh=KEd2yZoIBVvL18aDItKvfvTSbUPB7RV44kXga7k9ang=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYZwS6siVEV+fYA4wnGrsUj0ukcUGR2DXFzOUC7qP4LiBmzVlPkZh9YSkfC9GF4PE
	 it7A6pQLN+5OUMNyETMCWMS+IzHZxiotBsQCxy4J9JLyXtxPnBjG0NN1ynns988IA0
	 WQcDRlH0PJtfEFUkgYu3+wh1rFopdpAM6EwzYr90=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/2] RDMA/mana_ib: Fix bug in creation of dma regions
Date: Sun, 25 Feb 2024 23:25:38 -0800
Message-Id: <1708932339-27914-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708932339-27914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1708932339-27914-1-git-send-email-kotaranov@linux.microsoft.com>
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


