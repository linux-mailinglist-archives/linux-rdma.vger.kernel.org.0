Return-Path: <linux-rdma+bounces-13019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC14B3E814
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18868179613
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB730E839;
	Mon,  1 Sep 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lkYQqRoH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F061DF271
	for <linux-rdma@vger.kernel.org>; Mon,  1 Sep 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738865; cv=none; b=B3BT/KWJjG3ErGvDT7ti/Q96zZhkK2ADPr/msNeXS+WJ1MXduHdNybayOggeZHHjdTU+ddUYNHGp4h8lN4bSQfFB0YXUrAC/2SuOnSlCT49zx/fzslqgf0hZ5Wf9ESrvpzcEosGM8iyQzragkPewdHxNT+e4piQtFM+82uBy4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738865; c=relaxed/simple;
	bh=bhsgslIQ2txcAHts3Qvp0r6de4FEaFaUAz2tbH37AtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9a9pWu2U1IrOHdeejPT2WXUBYBg3mGVw8c1+QQpSJT9dd1E55jp7m4+OCm2t6KKeKIR3H7Z3iw56L2wqTkgXJv/sFibWuE0Bj8xfSDD1VItNwCeysWLLFw9r1u+yZXwLJkN9bLopMJnuBDn1XPTU3vRfoyAyOHQbf5qsI+1WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lkYQqRoH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756738858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2wHsii/Qa6huXYM2RR7dWMJJdJHUMFRlSMFRkEDOArg=;
	b=lkYQqRoHgugZi5tdkd7UNREH9SVGqJHbWHRI6/djRHboUfzP4ulMbA/ZFqpSVvSSfzPXcg
	qs0yJ57sL3KjoHR7j/XDI1iGxXp7aUsntZRU86vyyOy9w0+uT+qfZwomItFf7L6jJSJghS
	/09KAsWNt25if4He0pA2/juiJsxi8BQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: Call strscpy() with correct size argument
Date: Mon,  1 Sep 2025 17:00:39 +0200
Message-ID: <20250901150038.227036-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In bnxt_re_register_ib(), strscpy() is called with the length of the
source string rather than the size of the destination buffer.

This is fine as long as the destination buffer is larger than the source
string, but we should still use the destination buffer size instead to
call strscpy() as intended. And since 'node_desc' has a fixed size, we
can safely omit the size argument and let strscpy() infer it using
sizeof().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/infiniband/hw/bnxt_re/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index df7cf8d68e27..0718421bbf09 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1323,8 +1323,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 
 	/* ib device init */
 	ibdev->node_type = RDMA_NODE_IB_CA;
-	strscpy(ibdev->node_desc, BNXT_RE_DESC " HCA",
-		strlen(BNXT_RE_DESC) + 5);
+	strscpy(ibdev->node_desc, BNXT_RE_DESC " HCA");
 	ibdev->phys_port_cnt = 1;
 
 	addrconf_addr_eui48((u8 *)&ibdev->node_guid, rdev->netdev->dev_addr);
-- 
2.51.0


