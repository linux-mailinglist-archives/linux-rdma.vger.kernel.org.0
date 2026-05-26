Return-Path: <linux-rdma+bounces-21287-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF0lJtiVFWp9WgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21287-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:45:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C25D5BA1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C57F300BC92
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69A3FA5E7;
	Tue, 26 May 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=baidu.com header.i=@baidu.com header.b="YdQlDLcD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C6CBD3DD86E
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799488; cv=none; b=idY1u87pprpcXiiKzkw5JRT7YLePgSSQrNjRqunMAOE9wT6w8DITb9sKsBGi+dUwPE+Q/qXhDrYP61Q4YWDrZOeHChpKAWdS7tPZIgJYlYYmBkZNSoZK1eo5gdDJsjq0vsKlH+07jSRdjmriMA6xPyEn8tOkF3j+MODM6lnG2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799488; c=relaxed/simple;
	bh=sArlGPDS/xmWU/Q+rpmQaVwcXqWJaTwjtsMEogPebLU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UsTdE+RL+Cj+D/nYpUJuY3mkjfb7r46rqasmQkjF7/cBQbioHrkHMwX8sr2vJtoEAN+RubpIxie/UTADe73VblJH2lVY+jFSmYKxdo1hQJo64pNKEIdzUcZHkYaOnC6/QxJFFNlQeB9ZPBRs9CS3TCR5ifhRFJGoC1Yje02r/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=fail (0-bit key) header.d=baidu.com header.i=@baidu.com header.b=YdQlDLcD reason="key not found in DNS"; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai
 Hadas <yishaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	<linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] RDMA/mlx5: Fix boundary check in phys_addr_to_bar() for DMABUF export
Date: Tue, 26 May 2026 08:44:13 -0400
Message-ID: <20260526124413.2220-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1779799462;
	bh=FydAub/sSEPMlybPWuQtyu/4khQN024QPDVq/ajTU8o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=YdQlDLcDcT+ztwq4gVSyT6nUYgs8eSysR6S1Y1ZbQgJErOoG0G8j3KzR2Coy/W3F2
	 hIx629aTBd517KiQnTLA2qYr/nlH+WHjo0c4dvJFQwqk8f04q2CxpAkq+vdcY6oCjy
	 tyyK7pDx5ivrc8CiDD3paZs92n53AWdP8TVGYCTpoj90y7k9iv2TEm/Y6mzI1zLZYh
	 QWx1c4vDUskvNFWrGABL9KfPIjvj/rYXHEVVqWOGQ/YonuHMy2nxuSaWK3z0ROJzQJ
	 zZELsXNT0eRxE2G94eoqNtOs1oyMIX+K098k/k6e2YFANdN9zrnkZVFK8wHA9GTYab
	 Uz451YLT2yl6A==
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21287-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[baidu.com:?];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.919];
	DMARC_DNSFAIL(0.00)[baidu.com : SPF/DKIM temp error,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	R_DKIM_TEMPFAIL(0.00)[baidu.com:s=selector1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C81C25D5BA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

In mlx5_ib_mmap_get_pfns(), the physical address range to be mapped via
DMABUF is defined by both a starting physical address (phys_vec->paddr)
and a length (phys_vec->len).

However, phys_addr_to_bar() only validates whether the starting physical
address 'pa' falls within a PCI BAR's boundaries. It fails to verify
if the entire requested memory range (pa + len) fits inside that BAR.
This can potentially lead to out-of-bounds P2PDMA memory mappings if the
requested range overlaps or exceeds the BAR limit.

Fix this by extending phys_addr_to_bar() to accept a 'len' parameter
and enforcing a strict range check to ensure that the entire requested
buffer is completely contained within the same PCI BAR.

Fixes: d6c58f4eb3d00 ("RDMA/mlx5: Implement DMABUF export ops")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/infiniband/hw/mlx5/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6107828..7359395 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2453,7 +2453,7 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx5_ib_dev *dev,
 			      virt_to_page(dev->mdev->clock_info));
 }
 
-static int phys_addr_to_bar(struct pci_dev *pdev, phys_addr_t pa)
+static int phys_addr_to_bar(struct pci_dev *pdev, phys_addr_t pa, size_t len)
 {
 	resource_size_t start, end;
 	int bar;
@@ -2469,7 +2469,7 @@ static int phys_addr_to_bar(struct pci_dev *pdev, phys_addr_t pa)
 		if (!start || !end)
 			continue;
 
-		if (pa >= start && pa <= end)
+		if (pa >= start && (pa + len - 1) <= end)
 			return bar;
 	}
 
@@ -2487,7 +2487,7 @@ static int mlx5_ib_mmap_get_pfns(struct rdma_user_mmap_entry *entry,
 	phys_vec->paddr = mentry->address;
 	phys_vec->len = entry->npages * PAGE_SIZE;
 
-	bar = phys_addr_to_bar(pdev, phys_vec->paddr);
+	bar = phys_addr_to_bar(pdev, phys_vec->paddr, phys_vec->len);
 	if (bar < 0)
 		return -EINVAL;
 
-- 
2.9.4


