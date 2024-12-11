Return-Path: <linux-rdma+bounces-6402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604F9EC1F2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19634166CC5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553C1FBE8E;
	Wed, 11 Dec 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C+lBxgYv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4E44384
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882983; cv=none; b=pDjkejg2IEG6aOE1Qcl79eefVbBCzXmYwEZjBqWl1bmEDS94U3RzXDAnfeV0k2Qt4wAEw8sAQjFELf8bPFXUq1d73Cif5Amb5zdw2FYxoo+hOaa/89uHxIvqb3dMkHmhsL8qUkon2kmJ3epRoKMhAC/szI/Bp3XIbj9sVTPWJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882983; c=relaxed/simple;
	bh=Y+Dddd/fAilbCejdAxL1lboTYngCxAalb0kiop797cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+7+QUMxle82N+nVfnQBynj4A5c8fTcxkHC3HwinbyXGMXaNebzwR2w65wzy7QD7LXGLlbKKCyaHV1nSE8zfABLFRlrygTpiB6/4RNGfvl4dSYRbkz1jx3HEP0pfrP48a7P9k6MXJtT2Vv3f77jKZzAuhtfbea8uNhRwJoVu2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C+lBxgYv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882973; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eCQmo3jON9XZrj5j515hbAD9j0/7qbZRB86vNXxL9hA=;
	b=C+lBxgYvdZZoEriWjaLl+LRHeTgstjeu0xMTJyUXL7fmWSR0VO9EWpFk2LqGdMHOcubnhUWefYoPD7MoC4YX9K0ITj836yvi3XQB7UXbf09XYHdN4pmv0DsWmCIQBmrNDUb4RigytT5FAZUicY538Bs6r3fBtwkInQHou1SgEhs=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGS1I4_1733882971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:32 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 0/8] RDMA/erdma: Support the RoCEv2 protocol
Date: Wed, 11 Dec 2024 10:09:00 +0800
Message-ID: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series introduces support for the RoCEv2 protocol into the
erdma driver. As the most prevalent RDMA protocol, RoCEv2 is widely
used in the production environment. Given the extensive application of
erdma across various scenarios in the Alibaba Cloud, there has arisen a
requirement for erdma to support the RoCEv2 protocol. Therefore, we update
both the erdma hardware and the erdma driver to accommodate the RoCEv2
protocol.

- #1 adds the device probe logic for the erdma RoCEv2 device.
- #2~#4 implement resource management interfaces required by the erdma
  RoCEv2 device, such as the GID table, PKey and address handle.
- #5~#6 implment the modify QP interface for the erdma RoCEv2 device and
  refactor the code of modify_qp interface to improve readability.
- #7 introduces the query_qp command to obtain several qp attributes
  from the hardware.
- #8 extends the procedure for create_qp, post_send and poll_cq interfaces
  to support UD QPs and UD WRs.

Thanks,
Boshi Yu

---

v2:
 - Patch#1: remove the unnecessary check for device protocol.
 - Patch#1: remove the erdma_device_init_iwarp() and erdma_device_init_rocev2()
   functions, as they are simple and used only once.
 - Patch#4: move the function definitions of erdma_av_to_attr(), erdma_attr_to_av(),
   and erdma_set_av_cfg() to patch#5, where they are used for more than once.
 - Patch#6: remove the declaration of deprecated erdma_modify_qp_rocev2().
 - Patch#6: replace the 'reformat' with 'refactor' in the commit message for clarity.

v1:
  link: https://lore.kernel.org/all/20241126070351.92787-1-boshiyu@linux.alibaba.com/

Boshi Yu (8):
  RDMA/erdma: Probe the erdma RoCEv2 device
  RDMA/erdma: Add GID table management interfaces
  RDMA/erdma: Add the erdma_query_pkey() interface
  RDMA/erdma: Add address handle implementation
  RDMA/erdma: Add erdma_modify_qp_rocev2() interface
  RDMA/erdma: Refactor the code of the modify_qp interface
  RDMA/erdma: Add the query_qp command to the cmdq
  RDMA/erdma: Support UD QPs and UD WRs

 drivers/infiniband/hw/erdma/Kconfig       |   2 +-
 drivers/infiniband/hw/erdma/erdma.h       |   8 +-
 drivers/infiniband/hw/erdma/erdma_cm.c    |  71 +--
 drivers/infiniband/hw/erdma/erdma_cq.c    |  65 +++
 drivers/infiniband/hw/erdma/erdma_hw.h    | 135 +++++-
 drivers/infiniband/hw/erdma/erdma_main.c  |  44 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    | 299 +++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 524 +++++++++++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.h | 166 +++++--
 9 files changed, 1116 insertions(+), 198 deletions(-)

-- 
2.43.5


