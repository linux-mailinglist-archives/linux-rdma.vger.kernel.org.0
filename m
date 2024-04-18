Return-Path: <linux-rdma+bounces-1981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F28AA069
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 18:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874ACB22FBE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460B176FB0;
	Thu, 18 Apr 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tFTXJCb+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73615171646;
	Thu, 18 Apr 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459134; cv=none; b=e2TqAABTMlhONK3l5XhbAcdgwd63KXpJtScyqnAzvdOBGUFcdxmqsRZ7B6YEBD55+ccHgV30gSSxOTFc1W9ivo+hUmsETyMt59Z3gkrYJwkS7GFYuOM+j6N1LyipoymFVKKyf2WyBQArknxNycLRt3VFOAos3BLH5NUM/YMw/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459134; c=relaxed/simple;
	bh=USYxCd+6xF7K5pkaEdGKIuCmDU74c0xRd5gM491L5uY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GvyccN1cM3Coq26xMrrPctQfO0G0vRTKjzwVwGarTPayDGvkqWwFOysPC2b3SWRVZSUOqxRx2QbDbKlXcIOcXJpKY2XQvNbLhWP5myfUfVb15gT49fh98uhsusORdLdiS4eH/BqPstIDCmSkJQK0XycIu78EryS2si6BdIfB2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tFTXJCb+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1093220FD8C4;
	Thu, 18 Apr 2024 09:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1093220FD8C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713459131;
	bh=usFNmjgTL6o5J7+904XNALZFx9gHBIeiQH0Vr4rMqvE=;
	h=From:To:Cc:Subject:Date:From;
	b=tFTXJCb+gAVRa5xBhiNQU3IburUjdpK/uVk/+2xq+dt3aHEtd8QM+M2BKC9O7YggH
	 kOEQHSz5QS3VRxnwnPkuNmdHFU214zT/+qd0WRoYF2proCoApzw91tZk7c1/6pDjMn
	 Le0WjOhlZLimf9lNA9zG8NrmcX8Xg6Vj+r0QkW1s=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/6] RDMA/mana_ib: Implement RNIC CQs
Date: Thu, 18 Apr 2024 09:51:59 -0700
Message-Id: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series implements creation and destruction of CQs
which can be used with RC QPs.

Patches with RC QPs will be sent in the next patch series.

To create a CQ for RNIC, mana_ib requires creation of EQs
within mana_ib device. An EQ of mana ethernet cannot be used.

To make the implementation of create_cq cleaner, this series
also introduces minor changes to mana_cq structure (cqe->buf_size)
and adds a helper to remove CQ callbacks.

Mana ethernet and mana_ib CQs are different entities which are
created in different isolation zones (ethernet vs rnic).
As a result, RNIC cannot use ethenet CQs and ethernet cannot
use RNIC CQs.
That is why, we use existing udata request for creation of
ethernet CQs. If the request has extra fields, then we create
an RNIC CQ. The kernel-level CQs will be RNIC CQs (in future
patches).

To preserve backward and forward compatibility with RDMA-CORE,
we will make the following changes to mana provider in RDMA-CORE:

The rdma-core will request RNIC CQs by default, with the proposed
request format.
If the mana has installed an allocator with manadv_set_context_attr,
then the rdma-core undestands that this is a DPDK use-case and
requests an ethernet CQ, using old short request format.

Konstantin Taranov (6):
  RDMA/mana_ib: create EQs for RNIC CQs
  RDMA/mana_ib: create and destroy RNIC cqs
  RDMA/mana_ib: replace duplicate cqe with buf_size
  RDMA/mana_ib: introduce a helper to remove cq callbacks
  RDMA/mana_ib: boundary check before installing cq callbacks
  RDMA/mana_ib: implement uapi for creation of rnic cq

 drivers/infiniband/hw/mana/cq.c      | 77 ++++++++++++++++++++----
 drivers/infiniband/hw/mana/main.c    | 88 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h | 36 +++++++++++-
 drivers/infiniband/hw/mana/qp.c      | 30 ++--------
 include/uapi/rdma/mana-abi.h         |  7 +++
 5 files changed, 200 insertions(+), 38 deletions(-)

-- 
2.43.0


