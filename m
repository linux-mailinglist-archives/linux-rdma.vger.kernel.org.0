Return-Path: <linux-rdma+bounces-16917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJvyI6gJk2ni1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 13:12:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE01433F4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948A43013262
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246030C62A;
	Mon, 16 Feb 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHG0tG2K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574C30C37E;
	Mon, 16 Feb 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243939; cv=none; b=Lu6NIA59F91E0tNqP/sOCwJebcfC1cctJ+/ROoPiQm9Wdd2XylZZOWCuNPw+N+SwwPIR1catZMoQM5g+AL5QL7C4jk1eqfp588x9C8+rQkN+B16mKgwee8iZGDvNuPvI2va6wSap4430f3YvFEatAHBF9sDxcIXYy92xC3MUMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243939; c=relaxed/simple;
	bh=I11pRf0o3sGKWiSJdyEdgNdgk/nI/P4FnQ6Zb4g6s4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7/j2tt4WUhTupRiyILMichPZEKbLgQHnGzpJvH52FDaXZrB4NpjpL7FvsImHkTbTrU6BZjx3xx1LxeeA0SuLq2IdfqpaMzuXkLoIbUvJOxO7HaXJbZmxGdtmGQj3mY52YBPmQw7S0bcWBouzb0PJFQAZ0jyq4KgnUCvgFAdmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHG0tG2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938E4C116C6;
	Mon, 16 Feb 2026 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771243939;
	bh=I11pRf0o3sGKWiSJdyEdgNdgk/nI/P4FnQ6Zb4g6s4g=;
	h=From:To:Cc:Subject:Date:From;
	b=FHG0tG2KFX73G9wLrUdh91IOTEbgdEqi6kFYLEHTbMr8FeYD74mJLiYaffKMLwlvG
	 4ggnCdnJQ9hGXLCqAA/Ro1ulqDMGMPwju8wiczUXKczG7uu6wHeD3ICXr+oxgNGW/C
	 K1i6+XhP/fc84g3LfoAN8EWItaxMC795nXjleStNb9d7s8fCdVUFnuW5SyE9i0F7AI
	 3+B/6hzktgdcai2dcNX9bXrCF4pdzoGiVLE3h3DKAlsbnxeCXT5DpzorgnBqtm8vaN
	 r33QcIsmkfaHnC0LP0Cq3pGeor9k6Z9T5i47YfG5AXOIXqo4Nz6zxhHPjG8vmGRNdr
	 7g/MD/mNJajzw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Usman Ansari <usman.ansari@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: select CONFIG_DMA_SHARED_BUFFER
Date: Mon, 16 Feb 2026 13:12:00 +0100
Message-Id: <20260216121213.2088910-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16917-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: E9CE01433F4
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The addition of dmabuf support in uverbs means that it is no
longer possible to build infiniband support if that is disabled:

arm-linux-gnueabi-ld: drivers/infiniband/core/ib_core_uverbs.o: in function `rdma_user_mmap_entry_remove.part.0':
ib_core_uverbs.c:(.text+0x508): undefined reference to `dma_buf_move_notify'
(dma_buf_move_notify): Unknown destination type (ARM/Thumb) in drivers/infiniband/core/ib_core_uverbs.o
ib_core_uverbs.c:(.text+0x518): undefined reference to `dma_resv_wait_timeout'
(dma_resv_wait_timeout): Unknown destination type (ARM/Thumb) in drivers/infiniband/core/ib_core_uverbs.o

Select this from Kconfig, as we do for the other users.

Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 794b9778816b..78ac2ff5befd 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -6,6 +6,7 @@ menuconfig INFINIBAND
 	depends on INET
 	depends on m || IPV6 != m
 	depends on !ALPHA
+	select DMA_SHARED_BUFFER
 	select IRQ_POLL
 	select DIMLIB
 	help
-- 
2.39.5


