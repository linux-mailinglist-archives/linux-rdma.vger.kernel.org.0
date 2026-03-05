Return-Path: <linux-rdma+bounces-17507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGWQDdgiqWkL2gAAu9opvQ
	(envelope-from <linux-rdma+bounces-17507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 07:29:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429D20B98C
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 07:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCE1302BE0C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340382E7BD3;
	Thu,  5 Mar 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tLp0yzNS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E266293C42
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692181; cv=none; b=YajSxMsqoYXws4tc6kuqPwIXo17cHkjox8wG+KUt749VK7w+864Rwkol13Gm+vXT4NR7kUSPHRtW2fS/QKnsH/xKyEJArQ3fA9mPIymcCpIAT5vE0H1UojDtQOnnnvQK7orDF1A0XZEqOZG1HJy6Jn6Dqt6oO7Eks2Hv7SNvvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692181; c=relaxed/simple;
	bh=1Qe7Mhvhnymaw2RwFGjljBQznJvKrw2G0AlfeYPeHLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJALbsTQ88Yqb98yWElARCjmFI1MlZhqZBdDgI1QuYPPhxuyYEandfDYTIi5WsWe6VLFUTZ4sgbqmh5ANiiywYjXup+xwqcfPNBACiettDKFvo8r5FAZhZCXO7NnZBwcScqSfsTdR1kSlepN2c7i811EKswsd8B2Wg6l4HZ5EhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tLp0yzNS; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772692170; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oH31XNTn3Ncq8/5McG2vayJZHAOU3+LKmM5a97wczzw=;
	b=tLp0yzNSR3tqRyO7SCNupVuVGhuvcylRzTvyv6RKGm6VjeN0WYo/btKIxb47qKI0P/NeyTu56bSis0Ad3QnxgkhZgxm8eZnm+J+xyVMUj/ymre/ic0XtUhoeqX50WsscVqlvK9yjf/oRlHgG/phjqmhSEf6IC21SDBo6XrE2yDM=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0X-HUeR0_1772692169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 14:29:29 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next] RDMA/erdma: Remove numa_node from struct erdma_devattr
Date: Thu,  5 Mar 2026 14:29:26 +0800
Message-ID: <20260305062929.58881-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5429D20B98C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17507-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action

Using dev_to_node() to get the pci device's numa information
instead of caching it in struct erdma_devattr.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h      | 1 -
 drivers/infiniband/hw/erdma/erdma_eq.c   | 3 ++-
 drivers/infiniband/hw/erdma/erdma_main.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 2a023b99f992..ceabbdf2556f 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -127,7 +127,6 @@ struct erdma_devattr {
 	unsigned char peer_addr[ETH_ALEN];
 	unsigned long cap_flags;
 
-	int numa_node;
 	enum erdma_cc_alg cc;
 	u32 irq_num;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index 6486234a2360..d5b9d19882b2 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -197,7 +197,8 @@ static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
 	tasklet_init(&dev->ceqs[ceqn].tasklet, erdma_intr_ceq_task,
 		     (unsigned long)&dev->ceqs[ceqn]);
 
-	cpumask_set_cpu(cpumask_local_spread(ceqn + 1, dev->attrs.numa_node),
+	cpumask_set_cpu(cpumask_local_spread(ceqn + 1,
+					     dev_to_node(&dev->pdev->dev)),
 			&eqc->irq.affinity_hint_mask);
 
 	err = request_irq(eqc->irq.msix_vector, erdma_intr_ceq_handler, 0,
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 1b6426e89d80..25fa2604cf77 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -261,7 +261,6 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, dev);
 	dev->pdev = pdev;
-	dev->attrs.numa_node = dev_to_node(&pdev->dev);
 
 	bars = pci_select_bars(pdev, IORESOURCE_MEM);
 	err = pci_request_selected_regions(pdev, bars, DRV_MODULE_NAME);
-- 
2.31.1


