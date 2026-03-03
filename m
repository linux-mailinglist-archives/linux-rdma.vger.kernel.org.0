Return-Path: <linux-rdma+bounces-17413-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKovAZZTpmkbOAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17413-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 04:20:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAB1E873A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 04:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D0C8306AEEA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 03:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6137DE86;
	Tue,  3 Mar 2026 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Id2bqdfC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B137DE94
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507966; cv=none; b=cRbLcfVEIPr+j/pYme87yJB/GyWbJGSEStHxr3uQY+AE66HsPZEWB3y3dcpvoW39imnz7MhA/MT5dzRxS5kzC+5vna/w8rRZiqhZrlggm9hYB/5QiDkVYSAP1q2f/Cr3asOKmSwxVW2eY8PjwnU+Yapqw/viXhnxBIs15JwNHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507966; c=relaxed/simple;
	bh=gqibbrpPL6fmmG4Ltt0DBTqLb3el3iNptOMQaa0qJY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8twijpqWt4lG62/WFBCoYxK6ryZQtJjjs18ETM+1Co6YaSBrYqDEPRp5lcO86sQaaczF651RKEItB5YxLOzSkAm9JyDPn2sb8BvUVFOoX1iSX4t2NAdfLsDb2xfDID6xuaJqWBC7WNEfsqaOAOg1/beKNShiez6bd1kLJ/7tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Id2bqdfC; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772507955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+4QnPS1ZxPSdJ0LZC23RaGC8jNW0B9tHmbv9NgjnMo4=;
	b=Id2bqdfCfY27CbO+XQAbX3zJCxbBTIDx1G8ZZF8u+Avvi6xwcYiJZrW/U0HMxwr1BOrMLAac+ZgXkKxHTdigm7nRzsqkIrdgJkJyXzRLXkm4zqS3/P3PQZR2ueX8wAzTCS6vSZtsR2HjYcd181ZDguThA3dBhaLJ7VqIxphio4Q=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0X-8FYI9_1772507954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 11:19:14 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next] RDMA/core: Fix missing MODULE_IMPORT_NS in ib_uverbs module
Date: Tue,  3 Mar 2026 11:19:10 +0800
Message-ID: <20260303031913.74708-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67FAB1E873A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17413-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action

Compiling failed with the following messages:

<...>
  CC [M]  drivers/infiniband/core/uverbs_std_types_dmabuf.o
  LD [M]  drivers/infiniband/core/ib_uverbs.o
  MODPOST Module.symvers
ERROR: modpost: module ib_uverbs uses symbol dma_buf_move_notify from namespace DMA_BUF, but does not import it.
ERROR: modpost: module ib_uverbs uses symbol dma_buf_phys_vec_to_sgt from namespace DMA_BUF, but does not import it.
ERROR: modpost: module ib_uverbs uses symbol dma_buf_export from namespace DMA_BUF, but does not import it.
ERROR: modpost: module ib_uverbs uses symbol dma_buf_free_sgt from namespace DMA_BUF, but does not import it.
ERROR: modpost: module ib_uverbs uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/opt/linux/Makefile:2051: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Add the missing MODULE_IMPORT_NS to fix it.

Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/core/uverbs_std_types_dmabuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
index dfdfcd1d1a44..4a7f8b6f9dc8 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
@@ -10,6 +10,8 @@
 #include "rdma_core.h"
 #include "uverbs.h"
 
+MODULE_IMPORT_NS("DMA_BUF");
+
 static int uverbs_dmabuf_attach(struct dma_buf *dmabuf,
 				struct dma_buf_attachment *attachment)
 {
-- 
2.31.1


