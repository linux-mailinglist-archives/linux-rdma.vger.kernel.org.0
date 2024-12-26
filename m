Return-Path: <linux-rdma+bounces-6749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD909FC9D3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5A18834D3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18416DC12;
	Thu, 26 Dec 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mF+1N5gb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE9450F2
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735202830; cv=none; b=GOm2eWBLUY/jLE1VxEZuPDMDhRsv0ttwO1mcw0+NzBuSOtuMLcdRVcKRGUKoX7iO1jSrsbtGt0/aa1U+PtVTXdJTF7zHWwztbZaQ0EtMpphVW1bbBEEyJ1BNf8+v4X2c0I4/P9PfZjYejpZvLBmjwVvHIQGkZ3NOtxeP9jOelTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735202830; c=relaxed/simple;
	bh=lEn2QYlXK04Ek3OKxAAObSnHduuah7OzB5XhhJuKph8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyOEtBU7UXQBshhHPMETQdxUEcN1GlTfoxdoN5U/Q64/4Bgpf6V4QH8jtnS12ZwVgncrDLlim7y3TYZxof6ai1xeAhnuPnb6ifkgjB4kaAi1HG8un1AvQUK8pIbDZXbGlBT4RxYl5EPFQDnxdfTC4EFFokKOSDAkWUDhN8i5JaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mF+1N5gb; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735202819; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hkrwovV3Fo3WOhYRnUDtV9s8uuMLbFQ21cfCbvBLZvY=;
	b=mF+1N5gbBBy0mHoyvB66pT38rSSvrxvPKmliAU6LLio5kaYU4bxNUilN//wgPwZfGCX6ohUTdUdKOt2/m4N+ANWMCegejmOnPrKLACGocC96g6qYCvFFmKv4HAudxv4UDwFwtewde7xUyfMES5rjU28f4VpWxGQRnEpWfXVXj0Y=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WMHh26N_1735202502 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 16:41:42 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 0/4] RDMA/erdma: Misc fixes for the erdma RoCEv2 protocol
Date: Thu, 26 Dec 2024 16:41:07 +0800
Message-ID: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series addresses several issues for the erdma RoCEv2 protocol.

- #1 adds missing fields to the erdma_device_ops_rocev2.
- #2 fixes incorrect response returned from query_qp.
- #3~#4 support posting create_ah and destroy_ah commands to the cmdq
  in polling mode to eliminate the hard lockup issue.

Thanks,
Boshi Yu

Boshi Yu (4):
  RDMA/erdma: Add missing fields to the erdma_device_ops_rocev2
  RDMA/erdma: Fix incorrect response returned from query_qp
  RDMA/erdma: Support non-sleeping erdma_post_cmd_wait()
  RDMA/erdma: Support create_ah/destroy_ah in non-sleepable contexts

 drivers/infiniband/hw/erdma/erdma.h       |  4 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c  | 26 +++++-----
 drivers/infiniband/hw/erdma/erdma_eq.c    |  6 ++-
 drivers/infiniband/hw/erdma/erdma_main.c  | 10 ++--
 drivers/infiniband/hw/erdma/erdma_qp.c    |  8 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.c | 58 ++++++++++++++---------
 6 files changed, 64 insertions(+), 48 deletions(-)

-- 
2.46.0


