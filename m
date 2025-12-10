Return-Path: <linux-rdma+bounces-14953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442DCB2FB9
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7F5E3022B78
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E211E1DF0;
	Wed, 10 Dec 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3pIfjCu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDB84A35
	for <linux-rdma@vger.kernel.org>; Wed, 10 Dec 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372520; cv=none; b=Z4c/S53G5fZThpDwOP91apiO+FO8nErkrJsdrmdzDb0WQxvQGitvAp/FEgpG/aB+QYl+QtYBmXg8+F/pV53MrlX6epV3IsjJgsIUIR45yOas5EtD+OSQ+avUB3XDmRWvlVl55maPFoUpAqRuUwPsL1xww17Ev7xLqbmdvnBz2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372520; c=relaxed/simple;
	bh=gO3JBwiEW5hod8mZpypnYMmOduaXlggwF9/CsE7e9Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVW2wuDNAdOH6Kf2h0xY1SjcDZIZh0Lw4fMQKw52cIRxCq+rB72oAwm+4MqOqz+O5G9Z/X6ZyZzfMRb63hihscY7LqJ+kXfywt+C3RyAnYysqVdawqfPJpi0tN7xGDN+YVW4K+Prhh0fjcEcI6ACwrDBpQyULvHeLmsFskoYZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3pIfjCu; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765372516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oAyInuc6Izcy6CJHpxdCJ6HrbhzOY0NUblG8NLlk75A=;
	b=Q3pIfjCuDweRALrajaAU3fZ7HCuV4Z9LGGykLX9pBUjjk31xHaKDA7FqxwfOs1gYrO/2vF
	5neLvCS20pRj8+0BjvH0DVgM07EdUK+ggNfeqY0zJq6xVO0GY81zj63GiaZQxx4uCv/M6H
	IRAAz4AorZPHjU4R1NxiEwsOkNyubqw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/ionic: Replace cpu_to_be64 + le64_to_cpu with swab64
Date: Wed, 10 Dec 2025 14:14:29 +0100
Message-ID: <20251210131428.569187-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace cpu_to_be64(le64_to_cpu()) with swab64() to simplify
ionic_prep_reg().  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/infiniband/hw/ionic/ionic_datapath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
index aa2944887f23..1a1cf82d1745 100644
--- a/drivers/infiniband/hw/ionic/ionic_datapath.c
+++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
@@ -1105,7 +1105,7 @@ static int ionic_prep_reg(struct ionic_qp *qp,
 	wqe->reg_mr.length = cpu_to_be64(mr->ibmr.length);
 	wqe->reg_mr.offset = ionic_pgtbl_off(&mr->buf, mr->ibmr.iova);
 	dma_addr = ionic_pgtbl_dma(&mr->buf, mr->ibmr.iova);
-	wqe->reg_mr.dma_addr = cpu_to_be64(le64_to_cpu(dma_addr));
+	wqe->reg_mr.dma_addr = swab64(dma_addr);
 
 	wqe->reg_mr.map_count = cpu_to_be32(mr->buf.tbl_pages);
 	wqe->reg_mr.flags = cpu_to_be16(flags);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


