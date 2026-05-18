Return-Path: <linux-rdma+bounces-20904-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN98NREEC2qj/QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20904-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:20:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C16D56C80C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C18F306E2E5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2D3FCB3B;
	Mon, 18 May 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MZscewth"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B793FCB18
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106007; cv=none; b=IOH42SSC/xxeJBSwr3C2ze86DU2A6q7z9dF/Or5X+2eEuslMMmTlDsAEAiMYo8XV6AM4vvdoSh3EKgbF13b+ggnarhJA1rK1hVdv39/vgflztnHr3qFMHHOZ5sTg1TgqSJeAJf7/OfII5Se5CX/QZy2TfGix/+xwHdGDkmupums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106007; c=relaxed/simple;
	bh=wErdrGjRZ/jZZ3H53wlO+r28/G49wj/Lb82/nVjqR0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmuJkuVBDFjVQGjYAAypZuE4l3CMvC6ionjaWlGlQklLwyIf2Ro5btv7MuxbVWgtqyK7L4Tf2VZX+VWG+C0ujk8mAHv6QbyT3pZxs0AkXhN+9K7+w2GvSjWwvw27aDpIlxdPW+Own33M100oh60ES0ads1LhL3VSTKzm4qibwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MZscewth; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779105998; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EFDrNKAXcgEIZkOMoxjR8QG7oY8c9bOcl0rinCkws0M=;
	b=MZscewthwPu4FhhqatfPl6p5Y/i+i0YOJRKEBY97EIBJTShgyQ5CDXPofiYP0JlAMEKnNPdjKRx/P1d7OAO71ea8kAyig2rVsFFIEyiMh12PR0lQoBaV60xl2NVf9nIMmpLL8qbOHUWCMNQCUqDj3BvCSPdsUQRcQdsdsHeS6Qk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X392coW_1779105998;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X392coW_1779105998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 20:06:38 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v2 0/3] RDMA/erdma: Add DMA-BUF memory registration
Date: Mon, 18 May 2026 20:06:25 +0800
Message-ID: <20260518120637.16831-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C16D56C80C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20904-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Hi,

This patch series adds DMA-BUF memory registration support to the erdma
driver:

- #1 renames get/put_mtt_entries to erdma_mem_init/uninit to better reflect
     their purpose of initializing the struct erdma_mem.
- #2 introduces struct erdma_mem_init_attr to pass parameters to
     erdma_mem_init(), improving code maintainability and preparing for
     DMA-BUF support.
- #3 implements erdma_reg_user_mr_dmabuf() to enable DMA-BUF based user
     memory registration using ib_umem_dmabuf_get_pinned().

Thanks,
Boshi Yu

---

v2:
 - Patch#2: Add validation for the return value of ib_umem_find_best_pgsz().

v1:
  link: https://lore.kernel.org/all/20260507053437.46211-1-boshiyu@linux.alibaba.com/

Boshi Yu (3):
  RDMA/erdma: Rename get/put_mtt_entries to erdma_mem_init/uninit
  RDMA/erdma: Introduce struct erdma_mem_init_attr
  RDMA/erdma: Implement erdma_reg_user_mr_dmabuf

 drivers/infiniband/hw/erdma/erdma_main.c  |   1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 152 +++++++++++++++-------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  19 +++
 3 files changed, 123 insertions(+), 49 deletions(-)

-- 
2.46.0


