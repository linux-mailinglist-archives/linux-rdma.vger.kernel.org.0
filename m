Return-Path: <linux-rdma+bounces-12388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7027CB0D645
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4792B188CB26
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7AF24169F;
	Tue, 22 Jul 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="usaCaIvV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C7021C19D
	for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177762; cv=none; b=cRAUi9+IhRNe/C+OSeju8rh4xk/4en4ofFY0G6dv9soNhDBu1B3e7iXIuAevMawz2bkzujq9s0Fanj31R6B7wczJW8NWvRuFcAdXx+IoxL8HQmArQw4qxnHI6pqq65BkRAP3W1oiIpQtg0UR0zMrg6ah39vHk8stt8toqLX7Q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177762; c=relaxed/simple;
	bh=oKHSyFqQMV7qSgUFmtWtljI4mut2ikF+Jl1ZPXxQOI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOE1UictaNIwOzyIe+bG6UOXGQT+76R3PTBLsufrntcIjrlphtbZy/VVOpmG/csgd16vNcuKwUwYBg4dth825Xki4WFadYgVZKGjcjcsVBYi1JN5Q+qOVHkwqyDRLJCh0X6tx1vRAy5lEG84uRgdxXWBkFtWdncwJ9Wf3cAKANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=usaCaIvV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753177758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=inmuqIFTQvozGz2paDDhRtt7I9mhNgK8cvUypUP32fI=;
	b=usaCaIvVi/Vib43Y9jbmIqrUhUmjEW7ZAsut0jopnvobN+ARMgGAzML/V8py3kCBvL8j9T
	buleJO3dWVrWrN2zqfw41v7iImPnhw3BbffO3qQTiLhiQbt89tT5rfmMehF3gCVcou1jT2
	SEP/hHfP8UV+1p2cbp+Nw7gKXcs1omw=
From: bernard.metzler@linux.dev
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [PATCH] RDMA/siw: Change maintainer email address
Date: Tue, 22 Jul 2025 11:49:15 +0200
Message-ID: <20250722094915.2078-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bernard Metzler <bernard.metzler@linux.dev>

Change siw maintainer email address since old address
will become disfunctional.

Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..84bce0f7aee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22994,7 +22994,7 @@ S:	Maintained
 F:	drivers/leds/leds-net48xx.c
 
 SOFT-IWARP DRIVER (siw)
-M:	Bernard Metzler <bmt@zurich.ibm.com>
+M:	Bernard Metzler <bernard.metzler@linux.dev>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/sw/siw/
-- 
2.50.0


