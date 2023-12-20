Return-Path: <linux-rdma+bounces-470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F240819AEF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1467E1C2089B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEC11CAB9;
	Wed, 20 Dec 2023 08:54:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032ED1CA8C
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vytmj2S_1703062465;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vytmj2S_1703062465)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:54:25 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/2] RDMA/erdma: Introduce hardware statistics support
Date: Wed, 20 Dec 2023 16:54:22 +0800
Message-Id: <20231220085424.97407-1-chengyou@linux.alibaba.com>
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

Cheng Xu (2):
  RDMA/erdma: Introduce dma pool for hardware responses of CMDQ requests
  RDMA/erdma: Add hardware statistics support

 drivers/infiniband/hw/erdma/erdma.h       |   2 +
 drivers/infiniband/hw/erdma/erdma_hw.h    |  40 +++++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  40 ++++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 100 +++++++++++++++++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +
 5 files changed, 180 insertions(+), 6 deletions(-)

-- 
2.31.1


