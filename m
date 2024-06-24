Return-Path: <linux-rdma+bounces-3447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD3915322
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E0AB212CA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D18619D886;
	Mon, 24 Jun 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NZEWBC8h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A619D062
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245371; cv=none; b=OXXKcYNjBjVIwxmS74/aXCrcE4DyDgzqzIZhMEMfGVpfXYeQmG6IfIbfy0lRmvdeccxLPBVj7WQLVlhvWnAssKHUhmTN9398syqGSwThPZ0rfPlt5HYmEXbHQ6xUmaZXv+jMhlw+idp/MzbzoCG/cT5W20AbG9t3WFDZep3DMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245371; c=relaxed/simple;
	bh=wFCM35m9hZcmVPsI+PJOb6fD5QRZQi4Odl8n/9KVXLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3gdsHVpcx7WHoyLbaTH2NbqSpATLbjd35Gd6Vx/f8crbfy0YA92JEVlmW52OFTkq5lH1VEoujHLGTFg8khrhzBUOtbS0LNV/TlyA/5TRpKgvKrC66/wkAgmxT4yXPdt4wEQ9zLCm/iRygA+BcTOiIFfhW6LOvYLgwsLK3BPim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NZEWBC8h; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719245371; x=1750781371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGQ18YBcLyJY6WZhyyetu0wovE1qXdWsyTblPp5Ozwk=;
  b=NZEWBC8hakbPEAx46yhmvqPGmcsis5krr6whktCmADDBx9atJIpDiD44
   X7/kaXlYf74YVeO6PMPNd7KP/nSngWWJwe+ia1h5M/CDmJ+wQ8AI1Nqsd
   /DfB575qvrO9bl3LUJmo2C5l6Hva6/5/3hMN/yG4sSvZhAzFHcamDYs+U
   0=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="735104357"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:09:24 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:36161]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.201:2525] with esmtp (Farcaster)
 id a1dea10a-9a3a-4abe-a8d6-03b5dcf1592f; Mon, 24 Jun 2024 16:09:22 +0000 (UTC)
X-Farcaster-Flow-ID: a1dea10a-9a3a-4abe-a8d6-03b5dcf1592f
Received: from EX19D019EUB002.ant.amazon.com (10.252.51.33) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:22 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D019EUB002.ant.amazon.com (10.252.51.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:21 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:09:20
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Gal
 Pressman" <galpress@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-next 1/5] RDMA/efa: Use offset_in_page() function
Date: Mon, 24 Jun 2024 16:09:14 +0000
Message-ID: <20240624160918.27060-2-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240624160918.27060-1-mrgolin@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Gal Pressman <galpress@amazon.com>

Use offset_in_page() instead of open-coding it.

Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Reviewed-by: Firas Jahjah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8f7a13b79cdc..eee2ae215414 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -524,7 +524,7 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 
 	address = dev->mem_bar_addr + resp->llq_desc_offset;
 	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
-			    (resp->llq_desc_offset & ~PAGE_MASK));
+			    offset_in_page(resp->llq_desc_offset));
 
 	qp->llq_desc_mmap_entry =
 		efa_user_mmap_entry_insert(&ucontext->ibucontext,
-- 
2.40.1


