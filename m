Return-Path: <linux-rdma+bounces-4700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592E96863D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405BC1F2136D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033341D31BD;
	Mon,  2 Sep 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rfpiZUWf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB571D2F52
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276573; cv=none; b=A7mig0ovotbW0G2Djf8M4Cl8GgY+iUlwdpXUjsZFlisUSRyOP1ym9BI332g5oshCLyZkOSJkATZnONGzS/IkOqVFejy/Fr4EWa+FtaQJdW/DGPchptZGsOvbpkgMvjB81hImjbuf715pZfrL6qVYRgc859D10167Gzf93OYfEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276573; c=relaxed/simple;
	bh=WjDOcnXfMYXtno8Yc82ALK+EoyPsGMPvxj7qjVDELBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U653OJDFP98Vnc1pNEq8P9m2a/MoAUPGJyuKBR0dlMEmXryWsbRFHCDZJIrAIhw2C+Q/Dg3/g7XnG4QE4Qx+gMRgovsBsWXOBBZHSdka4yanqDWqTAJD2GB9jOQ3svNg17R7MpApIDYNvQlRdrRGPRrUxuytkLrESJkKVOyX1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rfpiZUWf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725276563; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hAVKcWBwcfZYH4Hb7VThuGvzEPdZvnp2J9/f7CJ225g=;
	b=rfpiZUWf3cVoaRppzsrkKyZ2qEH/w0/H6FpxLLWZbj4W5JYFkkoXn18D+DTwU4l78WLn+/9S/Cfk2skWgu3ctQr/uuHQs7EgMs9/kGYnEyDUSmdbnJrhun5lOu52kMv1AhVWRcTEEeHEuQ7fkJV5KmEIKWkewajwtNzYxpZR4IA=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WE8ne1Z_1725276562)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:29:22 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v3 0/3] RDMA/erdma: erdma updates
Date: Mon,  2 Sep 2024 19:29:17 +0800
Message-Id: <20240902112920.58749-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series has some updates for erdma driver:
- #1 refactors the initialization and destruction process of EQ to
  make the code cleaner.
- #2 adds disassociate ucontext support.
- #3 returns QP state in erdma_query_qp.

v3:
- Remove patch "RDMA/erdma: Make the device probe process more robust"
  for internal discussion.
- Remove __GFP_ZERO flags when calling dma_alloc_coherent in patch #1.
- Eliminate __GFP_ZERO by calling dma_pool_zalloc instead of
  dma_pool_alloc in patch #1.

v2:
- Remove unsed erdma_aeq_destroy.

Thanks,
Cheng Xu

Cheng Xu (3):
  RDMA/erdma: Refactor the initialization and destruction of EQ
  RDMA/erdma: Add disassociate ucontext support
  RDMA/erdma: Return QP state in erdma_query_qp

 drivers/infiniband/hw/erdma/erdma.h       |  3 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c  | 26 ++-----
 drivers/infiniband/hw/erdma/erdma_eq.c    | 87 +++++++++++------------
 drivers/infiniband/hw/erdma/erdma_main.c  |  5 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 29 +++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
 6 files changed, 81 insertions(+), 70 deletions(-)

-- 
2.31.1


