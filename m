Return-Path: <linux-rdma+bounces-480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420C81DDF6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 04:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2A1C20DD7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBC9808;
	Mon, 25 Dec 2023 03:21:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9551A34
	for <linux-rdma@vger.kernel.org>; Mon, 25 Dec 2023 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vz59KLA_1703474478;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vz59KLA_1703474478)
          by smtp.aliyun-inc.com;
          Mon, 25 Dec 2023 11:21:18 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 0/2] RDMA/erdma: Introduce hardware statistics support
Date: Mon, 25 Dec 2023 11:21:15 +0800
Message-Id: <20231225032117.7493-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patchset introduces the support of hardware statistics.
Statistics counters can not be put in CQEs due to limited CQE size. To
address this, we provide an extra dma buffer to hardware when posting
statistics query request, and then hardware writes back the response to
this dma buffer. Based on this, we add the hardware statistics support
of erdma.

- #1 introduces dma pool used for hardware responses of CMDQ requests.
- #2 adds hardware statistics support.

Changes in v2:
- Remove extra layer of erdma_dma_pools_init and erdma_dma_pools_destroy
- Move ERDMA_HW_RESP_SIZE from patch #2 to #1 because it's used in #1
- Remove unrelated change in patch #2
- Remove "hw_" prefix and add "tx_" prefix to some items in erdma_descs
- Use dma_pool_zalloc instead of dma_pool_alloc with __GFP_ZERO flag
- Remove port index check logic in erdma_get_hw_stats

Cheng Xu (2):
  RDMA/erdma: Introduce dma pool for hardware responses of CMDQ requests
  RDMA/erdma: Add hardware statistics support

 drivers/infiniband/hw/erdma/erdma.h       |  2 +
 drivers/infiniband/hw/erdma/erdma_hw.h    | 39 ++++++++++
 drivers/infiniband/hw/erdma/erdma_main.c  | 26 ++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 89 +++++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  4 +
 5 files changed, 158 insertions(+), 2 deletions(-)

-- 
2.31.1


