Return-Path: <linux-rdma+bounces-17686-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MdcvLPXqrGkAwAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17686-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 04:20:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4707D22E6BC
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 04:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35223023DF9
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 03:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F02E2EEE;
	Sun,  8 Mar 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEwKwETe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1F27FD4A
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772940017; cv=none; b=jbVBjoOV0R/wgXcnkvD1C6kZI01i/34UG7ZJaQX9Utkhu3YX4/0GNmFazBMD14Q2wwO1r12NqDXfL17Usdzh8sEVLbyIDCxPg69Q0i2P2f9ue55y4mU1VaMod7pwLjkOGYrjY3hPZz+12OAPDzLBtnyvyikYcGi9iC7T0xsKkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772940017; c=relaxed/simple;
	bh=KgJsvx1IcN9NsDZGqhbA1t3ZxHApBqizQDZHsQZW1d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsWRU1j8vXzMyV/K8ocY5E2NWQtPhMhdNnvNN/e3B56iteaSg4+OUx8S2LXtz8v37cOFQ6ABJ68y4qCla1yNuVCKgG1EezWipvjZ7XdkaT8EDxm4zaKHcup7/H+sLgvr5XXFjxOaAMq12oHcSdIxKxRkbZNtrE1e3QCg/Vl8MeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEwKwETe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829a568f3ccso896706b3a.0
        for <linux-rdma@vger.kernel.org>; Sat, 07 Mar 2026 19:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772940015; x=1773544815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5S2gvLeO3HtB5KquXoTw6XAQVdla0vPImwUUawa4hM=;
        b=OEwKwETeL7874jmFVnJ+R3tskTk8MuhtMW2sPCD+l8lGOyFbUNdsPc7K4F3DsgqMes
         Bwj/JcYf1UKwThue8Md0eihoRj/wpJn9DqEbbRkFFNHW5h5sot65drmBf+EeZK7mGR0z
         bwMSCkRexd/7vnFukgf+v2C9nQ5H8BSMcyBk1xmKJPbdHwt0+Ig988b5KUf6UfBXoAtY
         QRCqHKlztBEQPseQHI0sW6XXkUkKMflji5hu7JqqR+aMwMzQub5UgnaC6DPIE6uK0MLE
         fJIYmhlbTnMcCGyTdyEaY85dlWhm0+RFtf4766eg4gYWUGcB4YlcFG/QvH/yzXnj8HE+
         7M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772940015; x=1773544815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5S2gvLeO3HtB5KquXoTw6XAQVdla0vPImwUUawa4hM=;
        b=mj+y5SudvvM7ZBl0bVMRThEdXjuEo+mIPhovVgmo34VLhAPcPy67qorasXLKlMLc4d
         SFZFRGu0NVPG56qK5uHAQWtZ4rPIuk/d/dvNzojEWQQu1G9Qbm6hV9e+eQmuqlGbTKrf
         6SJ3QYD2jshV7CnTsC7QFf9FLwa5lh3vN0kif5Ft/JhdHWhMUVIlr9oBgOnPYuHOy3c/
         PvZqEDRlQbgpiqQBMd5mMLUF/lAAUMNUhJ63kX+k2yrCwIYzev3iN8jI2jJXzQN3Qq4t
         Hh8RKMzWnsyCdiSMlPV2ZDjSQhEdvhfUnv9RN1uj+6or7jjfFJ8GdH81E3Zo6md2VAIs
         oKBQ==
X-Gm-Message-State: AOJu0YwXEsxDt9AVvER8x2VlToOQsYei31RQkc6Lm3PnJSM9QwBlbsYj
	p5CucHfm9wx2QXpDVR4CHvQ9NxpzhGR+ixwZHD5bCJcJIXZYE13GNn6bPa1vGxJvj0A=
X-Gm-Gg: ATEYQzzcXVR/IghVGXWU9/b+Z0C06eU8KPZOnjE7x5t2uXiWeZ0sur5vKMQp/F//sIf
	M187ZXYttjTuStQWb3NhcKHXOplIuFkzGcZ8GQeDm4JgI8BYcGkmo8YgrTtFYQWjfkXrdDjtSMa
	Cd69AFXf32+htsHdmgzidl/lQbSFSMKRpJ0dVYZMYohexv0kIEGhuae/DCESsxMBZMhyFfvZ+qT
	O/WJr01ajbBUH7xhV6nRSUdaK/BFE8xDOv5LPNPwUwk6UbNQh6fGL2Y1rDhLuL5j1VjKXmPQtKC
	abhwEQjrD7Y/vEdXdqODGzXgVTQcXZProNZ9a8Ikfu5HXcVx9m/0uNBTvUrPwVVs1G3TIkWicEE
	WV/pkQaPuk+aj0kWZRVPp9Zd8FJyTs6zdI+ENvQdJKQIjjmCpNcKkIUtX4R7tARV6vzSdmBpqPi
	Y73fZacrfLH2PORDa3yLQsP0uYTLwOopTm5J1yo8mtfCFcOaxgUgOuQw==
X-Received: by 2002:a05:6a21:4846:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3986ea82cb2mr3394774637.19.1772940014806;
        Sat, 07 Mar 2026 19:20:14 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657a10sm5422904b3a.21.2026.03.07.19.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 19:20:14 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] IB/hfi1: kzalloc to kzalloc_flex
Date: Sat,  7 Mar 2026 19:19:56 -0800
Message-ID: <20260308031957.90900-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4707D22E6BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17686-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.958];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Combine kzalloc and kcalloc with a flexible array member. Avoids having
to free separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +---------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 5b01070ed66f..2597d311fb1f 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -257,7 +257,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (tinfo->length == 0)
 		return -EINVAL;
 
-	tidbuf = kzalloc(sizeof(*tidbuf), GFP_KERNEL);
+	tidbuf = kzalloc_flex(*tidbuf, psets, uctxt->expected_count);
 	if (!tidbuf)
 		return -ENOMEM;
 
@@ -265,12 +265,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	tidbuf->vaddr = tinfo->vaddr;
 	tidbuf->length = tinfo->length;
 	tidbuf->npages = num_user_pages(tidbuf->vaddr, tidbuf->length);
-	tidbuf->psets = kcalloc(uctxt->expected_count, sizeof(*tidbuf->psets),
-				GFP_KERNEL);
-	if (!tidbuf->psets) {
-		ret = -ENOMEM;
-		goto fail_release_mem;
-	}
 
 	if (fd->use_mn) {
 		ret = mmu_interval_notifier_insert(
@@ -448,7 +442,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (fd->use_mn)
 		mmu_interval_notifier_remove(&tidbuf->notifier);
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return 0;
@@ -471,7 +464,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		unpin_rcv_pages(fd, tidbuf, NULL, 0, pinned, false);
 fail_release_mem:
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 055726f7c139..b4a309a051f9 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -22,8 +22,8 @@ struct tid_user_buf {
 	unsigned long length;
 	unsigned int npages;
 	struct page **pages;
-	struct tid_pageset *psets;
 	unsigned int n_psets;
+	struct tid_pageset psets[];
 };
 
 struct tid_rb_node {
-- 
2.53.0


