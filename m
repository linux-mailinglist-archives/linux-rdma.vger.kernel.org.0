Return-Path: <linux-rdma+bounces-1381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170F877F2B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 12:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF624284484
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924D3B78E;
	Mon, 11 Mar 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sB0YSFhy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7CD3AC08
	for <linux-rdma@vger.kernel.org>; Mon, 11 Mar 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157108; cv=none; b=WsN9dx2YHH06GrLqy4DMSTZ5DKuxkyEZj+JcZElo9ehaMr+YC3DuQHVupjeAf68++sPOse46mupLIAhCJuFHJg2TL6NvBN2qrGfKMPzzgwdsamXGNnvsUYwdY/BcjSDhz5JmX+jUvvPxtx5O7ZBY5p+3BhpKkSU+vgVt0HRhR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157108; c=relaxed/simple;
	bh=Ve/9DGlqOMiO3BZX1jpbh6cQCDf8KZt/Xrk4RUwWDo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XociurLKFRwPLZrgUronMMKNPoVKlWau92MWHJg3pFpThF3xCwqgt93LfK9gaezkUQKjEl2ORDnRy/ISPBmBG1pi8yO3T3EyHL74pONmlu17xKRjxV2KmWsy/IId6wNgRuG4wFrKfAGyoNHMwuNnz/Zg67nJSY5JqeBpy8lwCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alibaba-inc.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sB0YSFhy; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alibaba-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710157102; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BsZd5jgzLt4cLrnvpWTka7ODujNMFIzTiYwypzRSsBA=;
	b=sB0YSFhyCWRKFI4nUhMYYzwmrJfU3zBCldTSXpUnAGIMr09O3dJUYgyuoSgM9sxE92GsMUkGcWz7c8xzSlgrTZjWUIQDN6Uug/o3EAdoAaT0PLXY0Zc/sSotQX3zFHnPBvIERXpK9EWNwCnSofinf3c+0pkClMOJS+pKQm/S0DI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2HEV-N_1710157101;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0W2HEV-N_1710157101)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 19:38:22 +0800
From: Boshi Yu <boshiyu@alibaba-inc.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/3] RDMA/erdma: A series of fixes for the erdma driver
Date: Mon, 11 Mar 2024 19:38:18 +0800
Message-Id: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series of patchs introduce a new dma pool named db_pool for doorbell
record allocation. Besides, we unify the names related to doorbell records
into dbrec for simplicity. By the way, we also remove the uncessary
__GFP_ZERO flag when calling dma_alloc_coherent().

- #1 introduces the dma pool named db_pool and allocates all doorbell
  records from it.
- #2 unifies the names related to doorbell record into dbrec.
- #3 remove the unnecessary __GFP_ZERO flag when calling
  dma_alloc_coherent().

Thanks,
Boshi Yu

Boshi Yu (3):
  RDMA/erdma: Allocate doorbell records from dma pool
  RDMA/erdma: Unify the names related to doorbell records
  RDMA/erdma: Remove unnecessary __GFP_ZERO flag

 drivers/infiniband/hw/erdma/erdma.h       |  13 +--
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  99 +++++++++++---------
 drivers/infiniband/hw/erdma/erdma_cq.c    |   2 +-
 drivers/infiniband/hw/erdma/erdma_eq.c    |  54 ++++++-----
 drivers/infiniband/hw/erdma/erdma_hw.h    |   6 +-
 drivers/infiniband/hw/erdma/erdma_main.c  |  15 +++-
 drivers/infiniband/hw/erdma/erdma_qp.c    |   4 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 105 ++++++++++++----------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  16 ++--
 9 files changed, 181 insertions(+), 133 deletions(-)

-- 
2.39.3


