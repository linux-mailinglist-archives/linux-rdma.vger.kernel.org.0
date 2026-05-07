Return-Path: <linux-rdma+bounces-20115-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKFFFoAk/GnxLwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20115-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:34:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4E4E31FD
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5780830028D3
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 05:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A231E837;
	Thu,  7 May 2026 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H5/xtcPc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7440DFA3
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132091; cv=none; b=bzehSMJwrbjFzX5wzNNirp/HnHz16XARZcqrSrZRo10/9OTFCF3Z8uIEMAivv49HY7+Y1NdU5TJ/yQF8cv0Af9KMybQvhi1acIi/AtOGD5ddJzboHRgUXlCqw8mY2mWl9zzBvoSFt7Lq9UdSdfolS+3p3MlwGt1vHWcFdKgA8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132091; c=relaxed/simple;
	bh=NrBikbrVZnBEPGKBrvV56xeysATF+FdYrlWNkaoyuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4mTx+yDnmi+oGgQEpt4TeSk9nqEfAkATjvbAFw4mS120ZwQXmgA4DKxCKvTJOUX4UdpQZpB+kPm6Bt0Yevc8oqOo89nntqf8LKMjkMJz+QR/WI9nnd+g0tycEY7Ruc/+pzVamTigTRSyzfgObPayOrZqq0ha+xxtOBpNj+lKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H5/xtcPc; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778132080; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MB9rV6HBBs9jmCI3L/ansRRQhct/wZS7NdDTeym/Pzw=;
	b=H5/xtcPcVnGarrWQGF+MBSAXZqpBPn3EuHiwsRWVV9iYQiaeSSE0UkPsxmX9mA6KJQ/4ymTg1jMQl51/7wP5jzQPdeB+0aI1W1vINDN80eFyaUWekrZB6KHcKVd448qop2g7g6BYHJOnhQKv+MoCShm9Lk/ITQJs5oW1sJG/MS0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X2TQgeA_1778132078;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X2TQgeA_1778132078 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 13:34:39 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 0/3] RDMA/erdma: Add DMA-BUF memory registration
Date: Thu,  7 May 2026 13:34:18 +0800
Message-ID: <20260507053437.46211-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53B4E4E31FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20115-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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

Boshi Yu (3):
  RDMA/erdma: Rename get/put_mtt_entries to erdma_mem_init/uninit
  RDMA/erdma: Introduce struct erdma_mem_init_attr
  RDMA/erdma: Implement erdma_reg_user_mr_dmabuf

 drivers/infiniband/hw/erdma/erdma_main.c  |   1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 146 ++++++++++++++--------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  19 +++
 3 files changed, 117 insertions(+), 49 deletions(-)

-- 
2.46.0


