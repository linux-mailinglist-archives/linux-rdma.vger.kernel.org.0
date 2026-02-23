Return-Path: <linux-rdma+bounces-17056-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGkoHoBSnGktDwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17056-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 14:13:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD417696D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B1A303A91D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307823659F3;
	Mon, 23 Feb 2026 13:12:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223373659EE;
	Mon, 23 Feb 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852340; cv=none; b=RMjH19hOAfT1cFMjYzEdRYVFjap+blpWO2kpXBCKU2r3uogKE1pCvB3HTaBFNJK2dADgjIrsdLho5/Za+IG616UM0mneUvGVayPp5TFCHG1Xqjnhym4Y1i86chTkfrtNjUcsY8ZnsOV5tFxepp+JuQB1Usc+/1fxZEAKf6JMw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852340; c=relaxed/simple;
	bh=uZwCD109POTfTP64VTCGl3TiAZeOQxq62O10u33MI2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dK40ott7GqtOtciz5cNM551DNJpVl3zPWo1dmcV9DAi0vh6mxQdUUgiwxWMsq7FrvcBSuzKCbRCS1mF2vTehL+Xj9g4NHXC+5PLJMBPc+Yie/l7uSkZg9xBhhdf7VORHDISi6Gh+731L54n8Kd36p4ClmeIIkUVG3mLnnBGPhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 0114F3F1F5;
	Mon, 23 Feb 2026 14:12:06 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH] RDMA/uverbs: follow rename of dma_buf_move_notify()
Date: Mon, 23 Feb 2026 22:11:34 +0900
Message-ID: <20260223131148.490904-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[hogyros.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17056-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[Simon.Richter@hogyros.de,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,hogyros.de:mid,hogyros.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFCD417696D
X-Rspamd-Action: no action

Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
dma_buf_invalidate_mappings()" does precisely what it says, and commit
0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations"), which
was merged during the same window, started using the old name.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>
Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/infiniband/core/ib_core_uverbs.c          | 2 +-
 drivers/infiniband/core/uverbs_std_types_dmabuf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index d3836a62a004..d6e99c79cf18 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -246,7 +246,7 @@ void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
 		dma_resv_lock(uverbs_dmabuf->dmabuf->resv, NULL);
 		list_del(&uverbs_dmabuf->dmabufs_elm);
 		uverbs_dmabuf->revoked = true;
-		dma_buf_move_notify(uverbs_dmabuf->dmabuf);
+		dma_buf_invalidate_mappings(uverbs_dmabuf->dmabuf);
 		dma_resv_wait_timeout(uverbs_dmabuf->dmabuf->resv,
 				      DMA_RESV_USAGE_BOOKKEEP, false,
 				      MAX_SCHEDULE_TIMEOUT);
diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
index dfdfcd1d1a44..149220a1599c 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
@@ -167,7 +167,7 @@ static void uverbs_dmabuf_fd_destroy_uobj(struct ib_uobject *uobj,
 	if (!uverbs_dmabuf->revoked) {
 		uverbs_dmabuf->revoked = true;
 		list_del(&uverbs_dmabuf->dmabufs_elm);
-		dma_buf_move_notify(uverbs_dmabuf->dmabuf);
+		dma_buf_invalidate_mappings(uverbs_dmabuf->dmabuf);
 		dma_resv_wait_timeout(uverbs_dmabuf->dmabuf->resv,
 				      DMA_RESV_USAGE_BOOKKEEP, false,
 				      MAX_SCHEDULE_TIMEOUT);
-- 
2.47.3


