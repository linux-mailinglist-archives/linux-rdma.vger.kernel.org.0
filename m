Return-Path: <linux-rdma+bounces-4501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD295C6F5
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7991C224F1
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173213E8A5;
	Fri, 23 Aug 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SrpFfiGu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018F13D51E
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399474; cv=none; b=har2PXOf0ZaQAgdlugZd9rZbsnhIEwdAIGJTcT2nRpNIfVOFbOn4pISkWmklRR0uMUDFC9eO7+jWQ/OCM2oSXcPDgACb4ecRlHCqPzOVgrVV1Pt3qIVG8U9KeqIauo7TTQMamen+D/dXj+rUpzJIfF17PCiW5SCKi7jE3UslT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399474; c=relaxed/simple;
	bh=bp2oKTdYbAnVizsxE/upavi/HrCAY6RUWdbzMs9mkz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nv/DwYBwLpilIk/1JwJKvrMq/DAULJ0iz+td4VOWK2yTMZ/2TYw/HSDaJmkv5+AdWPCSXSzd6bE6K/p9nyJTcqSNdf/32qA6rzZXu09z3S23lRE57EXrtMMzJwOzpP7P/tE3Ho4r4HSmpRewEXDtwJRk7cgrM1UEdP0KRKJUetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SrpFfiGu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724399462; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eScIlKBffBScPxaAyRhlnoEL711KPv02UMH5ajyUdI0=;
	b=SrpFfiGuFANO1qJp72ZwGmfuPXVnplcVhKgZLjhAzfQ2hYhzKa52rkrSogSvYkjtxm2q1ic1+lEcTffto8Xn8nbu0vNORJ0gm9K2f1zeOAzGeDeSshWtsnXeu8CPrF0KfxBq2g9akRdFANyMOlf1X0FujsrifEXZUTgdmynEVbs=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDSn1V4_1724399461)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 15:51:02 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/4] RDMA/erdma: erdma updates
Date: Fri, 23 Aug 2024 15:50:54 +0800
Message-Id: <20240823075058.89488-1-chengyou@linux.alibaba.com>
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

Thanks,
Cheng Xu

Cheng Xu (4):
  RDMA/erdma: Make the device probe process more robust
  RDMA/erdma: Refactor the initialization and destruction of EQ
  RDMA/erdma: Add disassociate ucontext support
  RDMA/erdma: Return QP state in erdma_query_qp

 drivers/infiniband/hw/erdma/erdma.h       |  4 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c  | 26 ++-----
 drivers/infiniband/hw/erdma/erdma_eq.c    | 83 +++++++++++++----------
 drivers/infiniband/hw/erdma/erdma_main.c  | 49 ++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 29 +++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
 6 files changed, 121 insertions(+), 71 deletions(-)

-- 
2.31.1


