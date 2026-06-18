Return-Path: <linux-rdma+bounces-22341-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c29BIFJ5M2odCgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22341-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:51:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 187EC69D8E2
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:51:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=n3Z3XqsB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22341-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22341-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ED9930039B5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 04:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857A28469F;
	Thu, 18 Jun 2026 04:51:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB817D6
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 04:51:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758287; cv=none; b=R3W3XSpKopnjShfzrUBveDq3t+QlwFdpG6R+wzT+Mm8ufC4q2o/xWWdM1dn0RVM7JQ9aC0ylRrBJmz82SSDsmh1F6U5CpSWjXeEW/SVd4Z3PHPm46RGpa+UTxNwx1Ux9qNqcGo5ElYg0LcNRQ1NCXop7oqjFdHAYT8N2okpwIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758287; c=relaxed/simple;
	bh=4xUtzaiAM3YLwS9Z7UUMnoFB4oWjik7AMElIdZRTVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMp+YdPj1OLUgjiIXo51l+1wxSoB3llnxQrBzKYYZd2SdyQ3OjhhGMZBy2bIi0HBFK98qgh4UA+yj36JAIs+syxf+oF2rpZUQOFhq33Kx8Efpce/whaTWHzGVWqJSfbbm6fr5+YXV+L6EjyJKFiPEemn9ikqFEhxJ7Mx6AZVT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n3Z3XqsB; arc=none smtp.client-ip=115.124.30.130
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781758282; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cCMjDcrLFetuhckaeLgI0VBBStQhu0wpnaugvBaY6e4=;
	b=n3Z3XqsBMPPB8ztq9b8JQ8iDoq1rOWPR5sQJ3OJiqdfzHIUeJwrtVu/OHP7jR5dYKAmNZpCsqupCFvH/ovmIAk9Ot21A0TSM2vQ4V1oyP4EBJ0PrYmURTKDKRH9FARGhssZa/ZTzisaUd8l4usqRzdmDrXxCu7doQJHkkVsjisY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X55fLTy_1781758280;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X55fLTy_1781758280 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 12:51:21 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v3 0/3] RDMA/erdma: Add DMA-BUF memory registration
Date: Thu, 18 Jun 2026 12:51:02 +0800
Message-ID: <20260618045120.51210-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22341-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 187EC69D8E2

Hi,

This patch series adds DMA-BUF memory registration support to the erdma
driver:

- #1 renames get/put_mtt_entries to erdma_mem_init/uninit to better reflect
     their purpose of initializing the struct erdma_mem.
- #2 introduces struct erdma_mem_init_attr to pass parameters to
     erdma_mem_init(), improving code maintainability and preparing for
     DMA-BUF support.
- #3 implements erdma_reg_user_mr_dmabuf() to enable DMA-BUF based user
     memory registration using the revocable pinned dmabuf interface.

One known limitation: if the DEREG_MR command fails in the revoke
callback, the driver can only log an error, since erdma does not
support a function-level reset like irdma's request_reset() yet.
We plan to introduce such a mechanism in future work.

Thanks,
Boshi Yu

---

v3:
 - Patch#3: Switch to the revocable pinned dmabuf interface as
   suggested by Jason Gunthorpe.

v2:
 - Patch#2: Add validation for the return value of ib_umem_find_best_pgsz().
  link: https://lore.kernel.org/all/20260518120637.16831-1-boshiyu@linux.alibaba.com/

v1:
  link: https://lore.kernel.org/all/20260507053437.46211-1-boshiyu@linux.alibaba.com/

Boshi Yu (3):
  RDMA/erdma: Rename get/put_mtt_entries to erdma_mem_init/uninit
  RDMA/erdma: Introduce struct erdma_mem_init_attr
  RDMA/erdma: Implement erdma_reg_user_mr_dmabuf

 drivers/infiniband/hw/erdma/erdma_main.c  |   1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 262 +++++++++++++++-------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  17 ++
 3 files changed, 201 insertions(+), 79 deletions(-)

-- 
2.46.0


