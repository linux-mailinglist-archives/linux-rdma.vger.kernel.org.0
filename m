Return-Path: <linux-rdma+bounces-4598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB73961F12
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32231F24CF0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7990154BEB;
	Wed, 28 Aug 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="knMSqeD4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ACD1799F
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825391; cv=none; b=HN1X8X7XQRMEgYm+J4Q1KuC+taA8fMrEKQPTw8wf2xHcELjYfVFGdhYiNEa9hUOIXue+Mv9k+K5pmdPDU/fU6icmm4NP7p6q3k31S/BPDwCtyKxmyr3NDCoSnB+JwCtj/qhQgeKBiGEilr4A2zwBs5PAFvgzfXN/3GwmP4XF5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825391; c=relaxed/simple;
	bh=fbzsOBWRmzZxtD5oEQ+d135JL3Ufa8hnx7Bl+GSXVmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PugOrfPRDhnTmmKndMn3cIZzw4JkllocFeHKsCTeEoliila2Jp0OqpZKLewuuMF80anWpH+HfK6kHKJvkzLO+vF4ELbsar3mDCFvlb/uIz5jLSJ7d2eOSWb++52vMAxDYWffqpeQSxFUUV50+qnvtBiLW8ce9Q5sOFtKHUyRyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=knMSqeD4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724825385; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qN+qBDeulMOYyAj2v56oiBswn8rsrCHSgx9L4OXi8dw=;
	b=knMSqeD4Epi23xUHtbcyN5q/JFhERmzxGBh/uDZPsAdLQtkj/vm6vJDfiva4d7lNgYs7DKU9ZdNp+VfYngTg+80Y6U0vZCNYlz8nD+Vg5vvSnVHC7tl7x//u28lEM6/Lb4Ktc5r2h9hFmED0byTnARA2jjVRyCBccK+NSn20VZs=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDoszQK_1724825384)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 14:09:45 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 0/4] RDMA/erdma: erdma updates
Date: Wed, 28 Aug 2024 14:09:40 +0800
Message-Id: <20240828060944.77829-1-chengyou@linux.alibaba.com>
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
- #1 always issues a reset request in probe routing to ensure that
  the hardware is ready to probe before continuing.
- #2 refactors the initialization and destruction process of EQ to
  make the code cleaner.
- #3 adds disassociate ucontext support.
- #4 returns QP state in erdma_query_qp.

v2:
- Remove unsed erdma_aeq_destroy.

Thanks,
Cheng Xu

Cheng Xu (4):
  RDMA/erdma: Make the device probe process more robust
  RDMA/erdma: Refactor the initialization and destruction of EQ
  RDMA/erdma: Add disassociate ucontext support
  RDMA/erdma: Return QP state in erdma_query_qp

 drivers/infiniband/hw/erdma/erdma.h       |  4 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c  | 26 ++-----
 drivers/infiniband/hw/erdma/erdma_eq.c    | 91 +++++++++++------------
 drivers/infiniband/hw/erdma/erdma_main.c  | 49 +++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 29 +++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
 6 files changed, 120 insertions(+), 80 deletions(-)

-- 
2.31.1


