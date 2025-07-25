Return-Path: <linux-rdma+bounces-12474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9AB1181B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 07:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53078189D560
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7841E24468D;
	Fri, 25 Jul 2025 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wskRgTC1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763B244666
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422858; cv=none; b=ZzRgGo7Pljog4yicYsvn1CMSoUxZqCYlMt0vnYF6ftMxYbRWpC/QC8zJyt7Gb9rqeLx2qjZdOtrSgthXZAFLQY+8pF1SOzjepvho+u52NJfcBfnuFHHheG4F6xUqAdXgwQxOGnIvo01lrwOC2lY+Yxlibq6jv1en/PVrc2+yHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422858; c=relaxed/simple;
	bh=l/xqNjjqabCDWdQaWX3v0f44eVWIVr5OL9GPpmgu9f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOBToFIMCXvgC+ML7UAxq0q7F0TnWg9AyfN4pRJe++utYk2gunpp8u4svtnQitzsAqMRmJ8P35RyypNHyL5gGtOznyEn3444vpASJ4k7+OICoARiaTTMTZ8apjc2YVH/g7cln8yj6h/tMm5dLm1Yq0h/F84DbCw96E+PTK7kqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wskRgTC1; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753422852; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wbMlidhSyOFHi/d6dfVjFUlbWqq3yZAdrwKYJicw7VQ=;
	b=wskRgTC132aK1QpU9rha98ryjW/W7CbeEyBcle1OyTx0tCB2Bb4Qpp7iHnS6OhjwAfDA/nI0DDX/AIzCOi+2Ljqo4CXkalko7Q6e2O+x9ATKPwp/Ej3JiUQwX9FG9Y+L9JHeUD6WfFN4gWJOjCzyhbWLEW6Vh3t/Nj8ix1QkjYY=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0Wjw1Is6_1753422851 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 13:54:11 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 0/3] RDMA/erdma: Misc fixes for the erdma driver
Date: Fri, 25 Jul 2025 13:53:53 +0800
Message-ID: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series of patches provides several fixes for the erdma driver:
- #1 uses dma_map_page to map the scatter MTT buffer page by page to avoid
     merging contiguous physical pages.
- #2 fixes ignored return value of init_kernel_qp.
- #3 fixes unset QPN of GSI QP.

Thanks,
Boshi Yu

Boshi Yu (3):
  RDMA/erdma: Use dma_map_page to map scatter MTT buffer
  RDMA/erdma: Fix ignored return value of init_kernel_qp
  RDMA/erdma: Fix unset QPN of GSI QP

 drivers/infiniband/hw/erdma/erdma_verbs.c | 116 ++++++++++++++--------
 drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
 2 files changed, 76 insertions(+), 44 deletions(-)

-- 
2.46.0


