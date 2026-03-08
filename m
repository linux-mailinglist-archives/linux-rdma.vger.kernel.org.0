Return-Path: <linux-rdma+bounces-17731-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id luBJLrbYrWlq8QEAu9opvQ
	(envelope-from <linux-rdma+bounces-17731-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 21:14:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A1B23216A
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 21:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4003300DA58
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6739E6EF;
	Sun,  8 Mar 2026 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBimrzlG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232A3A255D
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000880; cv=none; b=XQpbAd9kU4cuKUQjiDEkFYebLA9huJHeU3St0rMl4LuctbslFSgrYwjtiPT60b7DgOv2UwGA2+kUim1IBdvunwHhPnDfTltCyGC7ZGjf3HwIqS5nTO3wK2N3fvzMApnogo7BEL+3iYyHBKpWOgNyheZ6uVz/ixirc+LvKVn75d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000880; c=relaxed/simple;
	bh=xzSJCVQINHqp98FDmuwsR6YmeKB/Lv2LWfU3EU7r3MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jC1H6fOUddfHMk4aid07UnBKvKdfou6q6yovfJD9XhdJuu7N7Hs0WgqxErEFmRH+3C+44ZJDbUpXLgqDhRcVELQ9RZdvEpsdad6cTNsrKiJIOEtqNSzM3wf2B+ii9xEj1iTeJFZB9AOAbukTLPrRM5Fz1JbptJ4xSH9j+Rd9fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBimrzlG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3598df39444so4642298a91.2
        for <linux-rdma@vger.kernel.org>; Sun, 08 Mar 2026 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773000877; x=1773605677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqO+J4I/bu5ZWIIanV+1z7egiiiePfAh7lAfSkxvl/w=;
        b=EBimrzlGiAcGrdbkL1JgvMTbN9E3dflSDbpa9DQaXr6X+jPB1xaS2l5eVWQQWXqow0
         wlvugD53F6jlgBVvvb98Fb42Dy4eW5CZxQ09NxjjnDmgvGGppr3sTpE34zrg/LI3Su5x
         D2Pe8Q+/gxKKUgZqHHKogfxBioiL/fcqzfOd40e8Rjlb9I7cpGHsWZEFwUh1eJ24wlxI
         jBfBDqq9pR+wpHCF22rRL7m9efDCm7iBb3REx+8dC/X4HJYmbyP/2sht5bKSEmV3yfkk
         lW5Ppy8ClULm+j5MHg48VSo0BfN1FxnbKbL/4n0ptMjBB9O5a0EhPNI/5Mcg2YD2M3pD
         +ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773000877; x=1773605677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqO+J4I/bu5ZWIIanV+1z7egiiiePfAh7lAfSkxvl/w=;
        b=UinsxKG5DYrXQrMozFiXp4x8feWwIR47LtMTVFFa/429BmFYZNExi5VkeqD4q23tgj
         UJ5sjifxxq8HJrvep/sEpAa3KGroZEVFBz2Js6OOjS5ylKBaGwMeyOnZSpjnog967psk
         674P/KLAtKQEEtgWW0ZajDxk20Lo5Qe7+4Lbij8gvxELoDUvwLykueAt+qwEdyW5VrS6
         bA7chFRHxNqw3bOhXzCV5O0um/LoK59iAQQQ7+8Ps47L3+boCVRNwAhwKFaXlfDEN7LN
         QOTV6CVB/QQM/f9lCzWk8Ppo1YhakQQj/L13jTvW1jCjoA8oOEDv7f3DFQACtcJoGqou
         QwDw==
X-Gm-Message-State: AOJu0Yx8USjTyj/4PsncyYOI6ERWzBf0UdXB3kDLMqioUMv3OUdn0Bb0
	xnCaS4mpUiSRcUEzZwqpZNxBR9UYi/jtrt24bUZ400KG18TsCL4Bq/NGBV6dW5Cz
X-Gm-Gg: ATEYQzyCxJ3K6Go0trr1E8hfiA94sWLeH4t5t4fhun6Hs/FRSm04kswSbE9tyKkvQXI
	FNKo5v9plKekR9DDBr5IlLpGWRcBIX1lXawGVn+ooVwThbz/wpWoUvRaUX6BFt2xm6gF+lJ3JpF
	z+gW+ChAVlFdUuJCKiEL1aaOyPuSOHFULVZF3uoBnqLLnAtSt+Yhb7QTzeVNq7Y8ORr74ZaWB9P
	+539rKO2lsmayTOZZl7zk5V4yaHDmTBBFHcgcd4j6hSNyiTRn8LlGwGOAAKTsW/rj/q7vvdZXTy
	ZHf1Lwkxnzn5u7rP675iEmDyjFim7VzZFL94t6TuoeAhq8D39U+5xA0jPwvap07FvRWAAADTlJY
	8DZf7sbR5PlsOWDb1bArC8SdiBRGCvQAVT4OjCw3NabB5IJyzn6FpGylv9YA0G/2KQVHHbn0D9z
	aZX5oPksTs0F4rYQyPxQrMxKSpe5Sy+phW50uddKEGj5OwS23YibhOHYcpyse6KMLQ
X-Received: by 2002:a17:90b:1850:b0:352:f2a6:334 with SMTP id 98e67ed59e1d1-359be2f9111mr7531977a91.16.1773000876941;
        Sun, 08 Mar 2026 13:14:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c005e224sm11014225a91.7.2026.03.08.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 13:14:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] RDMA/ocrdma: kzalloc_objs to kzalloc_flex
Date: Sun,  8 Mar 2026 13:14:19 -0700
Message-ID: <20260308201419.5260-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 39A1B23216A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17731-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simplify allocation by eliminating one. No longer need to kfree pages
separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma.h       |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 15 +++------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/ocrdma/ocrdma.h
index 5584b781e2e8..da2deae6857b 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma.h
@@ -190,8 +190,8 @@ struct ocrdma_mr {
 	struct ib_mr ibmr;
 	struct ib_umem *umem;
 	struct ocrdma_hw_mr hwmr;
-	u64 *pages;
 	u32 npages;
+	u64 pages[];
 };
 
 struct ocrdma_stats {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 7383b67e1723..eb922b9b0075 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -910,7 +910,6 @@ int ocrdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	(void) ocrdma_mbx_dealloc_lkey(dev, mr->hwmr.fr_mr, mr->hwmr.lkey);
 
-	kfree(mr->pages);
 	ocrdma_free_mr_pbl_tbl(dev, &mr->hwmr);
 
 	/* it could be user registered memory. */
@@ -2908,19 +2907,13 @@ struct ib_mr *ocrdma_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (max_num_sg > dev->attr.max_pages_per_frmr)
 		return ERR_PTR(-EINVAL);
 
-	mr = kzalloc_obj(*mr);
+	mr = kzalloc_flex(*mr, pages, max_num_sg);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->pages = kzalloc_objs(*mr->pages, max_num_sg);
-	if (!mr->pages) {
-		status = -ENOMEM;
-		goto pl_err;
-	}
-
 	status = ocrdma_get_pbl_info(dev, mr, max_num_sg);
 	if (status)
-		goto pbl_err;
+		goto pl_err;
 	mr->hwmr.fr_mr = 1;
 	mr->hwmr.remote_rd = 0;
 	mr->hwmr.remote_wr = 0;
@@ -2929,7 +2922,7 @@ struct ib_mr *ocrdma_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	mr->hwmr.mw_bind = 0;
 	status = ocrdma_build_pbl_tbl(dev, &mr->hwmr);
 	if (status)
-		goto pbl_err;
+		goto pl_err;
 	status = ocrdma_reg_mr(dev, &mr->hwmr, pd->id, 0);
 	if (status)
 		goto mbx_err;
@@ -2940,8 +2933,6 @@ struct ib_mr *ocrdma_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 mbx_err:
 	ocrdma_free_mr_pbl_tbl(dev, &mr->hwmr);
-pbl_err:
-	kfree(mr->pages);
 pl_err:
 	kfree(mr);
 	return ERR_PTR(-ENOMEM);
-- 
2.53.0


