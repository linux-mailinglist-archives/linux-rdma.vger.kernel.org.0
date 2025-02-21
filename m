Return-Path: <linux-rdma+bounces-7988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623EBA40031
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9019E12A0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B98C253336;
	Fri, 21 Feb 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="BBd7Eeyy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69F1FF1BD;
	Fri, 21 Feb 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167919; cv=none; b=W7vZ1CiL9hpp71a+9M3IVyQOgumPUlKTkUgseQFA+w1CUnNInxS3Egs8R5LpB7ofEo3fgn6+j3jWcq60R7M2XxTftoAwFGlksCH4O5I3e62uxhXAVIlyuR+RFQRNLakZlkOrLoIG6XqxRt7t8m7hPFBDK4lFp6ZZafpWNff3ke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167919; c=relaxed/simple;
	bh=eNfboFDHiMeOJ/SbjFt/oLkB+nM17iSP7YIzph4ek+U=;
	h=From:Date:Subject:To:Cc:Message-Id; b=XEi0wv3Gy2h09IAm7UMvlYSbo66bNSgGK6cknKKVKIwi92CruBPKrJUlsAvar+8NUamSSPXGI+Hj/rKOVANC3y+lPp0Zb2k4seejEWlbRTgSEgMJbXlPg6vm+/HpLWwje/njq70t9XJrQFrLwMItuNFDpcXK7yD3xEdeht93CoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=none smtp.mailfrom=bout3.ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=BBd7Eeyy; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bout3.ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1740167913; bh=eNfboFDHiMeOJ/SbjFt/oLkB+nM17iSP7YIzph4ek+U=;
	h=From:Date:Subject:To:Cc:From;
	b=BBd7EeyyodI0yf08/U0qvLDGUWgalBoEuqdCIcadP9Un28CpnXAdeojxIXs/5YU/h
	 d4cTdr6AexJaESEM+J4+X8k97jLPVQiqFxfqVXnRk6tEG6UD7GkyEtlCcfHQQMH7dx
	 1aC8HCpXTNisj0kNMyf2yDgNQftPI1wf0X/zLPgCyICRlJHB98Ly/I2YkkDdaj5XEv
	 lwF476eo6Pnx439rqP5RirhsJQYZ9T+oBtsKBu3Eq0ou2OOwXLZ/ZdizQnXbXi6x+z
	 Uw49jSOaYOvv0jDkCxhD5rsBMe3C+Lq7OmkNPIs3utVQWxbP9Io9wSBI5HkmvwFMaT
	 sRveY4DtwYoDL5l8lpO5LSSj72zbCtShR+1ymiCGmLzZCA8uMvU78E0DzYFrW/3BgN
	 OEABL+NWLF2HhNAxRGkFzMgL0cMSLRSqJBPeJnxi+id9kTr0ksw5KHIg9ch2BFIXog
	 MJl6DPS4Fvp+a3kPQTWmKMOkB9XXHS538p4fihsK49BRFxSDp/Oo4LlQts8WRIvs76
	 uErYnJmv0QTXYOlRHOI1OJPRGwb0bLT4rLRYyzlHetxPcWGA/m0RStss1XAJqq4wW+
	 TPE5CHTSEbf+zOmPNcFlWtRPKgJWCOO+9/WE7Y9fhTG4ibv43P/6CcoFQ+zJmCZN0V
	 rxlm9K7BY+Do4Ta4UbjDelb0=
Received: by bout3.ijzerbout.nl (Postfix, from userid 1000)
	id 7516C16290A; Fri, 21 Feb 2025 20:58:33 +0100 (CET)
From: Kees Bakker <kees@ijzerbout.nl>
Date: Fri, 21 Feb 2025 20:39:03 +0100
Subject: [PATCH] RDMA/mana_ib: Ensure variable err is initialized
To: Long Li <longli@microsoft.com>,
    Konstantin Taranov <kotaranov@microsoft.com>,
    Jason Gunthorpe <jgg@ziepe.ca>,
    Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
    linux-kernel@vger.kernel.org
Message-Id: <20250221195833.7516C16290A@bout3.ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

In the function mana_ib_gd_create_dma_region if there are no dma blocks
to process the variable `err` remains uninitialized.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
---
 drivers/infiniband/hw/mana/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 114ca8c509ce..eda9c5b971de 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -384,7 +384,7 @@ static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
 	unsigned int tail = 0;
 	u64 *page_addr_list;
 	void *request_buf;
-	int err;
+	int err = 0;
 
 	gc = mdev_to_gc(dev);
 	hwc = gc->hwc.driver_data;
-- 
2.48.1


