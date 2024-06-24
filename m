Return-Path: <linux-rdma+bounces-3453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4AF9157B1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F2F1F21E2A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 20:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2F1A071A;
	Mon, 24 Jun 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FZfqrxAa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4BFBEF;
	Mon, 24 Jun 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260091; cv=none; b=VT6+4HfLIPz7gncVRsSl+t2jOLN9jLk5GiKwiVY8M7TXXRN5rdv/9WhxJpskne077xbosCdEJLm6FHlW6H2ju1b2ju2/ajWj2+xkK2IB7L9TiajDWbdSIBzZ6AuVDabUMeTBC19ZRbIo/Xi17B5baq+xzbOwIulPn0z8kSZYBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260091; c=relaxed/simple;
	bh=fDp0bfLOTgweVFtXCjjNaHA/d2bWypmpiTDG5XkIAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVfzaQD+iU7Tx6pCMaSxBH/diINiRppBWsJByz9wYxn3WlYwm8hhmiTbyL7MdzJbrJnLYrjv3jNUOKEchMU03BZPUp87WitQo9wcMnKr8MAnAxeKB27Bpiln2nJayNbDmyIrOeRzS1a75yaR1Xh+Bn5mOqEO0DAMV3+JRcPWg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FZfqrxAa; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Lq4CsKPgR6xnbLq4CsCLm9; Mon, 24 Jun 2024 22:13:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719260015;
	bh=Elslo1pemTLslrrEitU31K06X28LN8QnqrN10QUJgz8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FZfqrxAakQ6ncfePlzV7aPvu5uhH2TwEk70ZO7AglRqZkBeUP7AK5KXz1g1dyWNx/
	 8v3NFKjMD+EzRejV3k1cCd30g4fFdf8NE9t8LKgiJAcGI2WVwfyzKvQK4WhZWDowu8
	 3GsP1oe8/gEAT/T8hSEbyFLSjmBNd4paeDTn6fdYI6OB6jS1W9Ilrih3HUXTOjbbP/
	 4csVnHtFUcYUL+YiB4H+Nk8NToQ6/QiG5ZTPd2ahNryAaNfGarlqFk/zmAj+p3gwqN
	 7raITcddSY8tKh++LsEtFc7Pk1lW/hfxe03OMQkdYhB/+C0+2pmL7qbFtB4v5+FHMP
	 RPFmJYCeocaKg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jun 2024 22:13:35 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/hfi1: Constify struct mmu_rb_ops
Date: Mon, 24 Jun 2024 22:13:27 +0200
Message-ID: <b826dd05eefa5f4d6a7a1b4d191eaf37c714ed04.1719259997.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mmu_rb_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  10879	    164	      0	  11043	   2b23	drivers/infiniband/hw/hfi1/pin_system.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  10907	    140	      0	  11047	   2b27	drivers/infiniband/hw/hfi1/pin_system.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/infiniband/hw/hfi1/mmu_rb.c     | 2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h     | 4 ++--
 drivers/infiniband/hw/hfi1/pin_system.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index d4a6acad0e65..67a5c410fb5e 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -40,7 +40,7 @@ static unsigned long mmu_node_last(struct mmu_rb_node *node)
 }
 
 int hfi1_mmu_rb_register(void *ops_arg,
-			 struct mmu_rb_ops *ops,
+			 const struct mmu_rb_ops *ops,
 			 struct workqueue_struct *wq,
 			 struct mmu_rb_handler **handler)
 {
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 8e5d05454d70..3fa50dd64db6 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -42,7 +42,7 @@ struct mmu_rb_handler {
 	/* Begin on a new cachline boundary here */
 	struct rb_root_cached root ____cacheline_aligned_in_smp;
 	void *ops_arg;
-	struct mmu_rb_ops *ops;
+	const struct mmu_rb_ops *ops;
 	struct list_head lru_list;
 	struct work_struct del_work;
 	struct list_head del_list;
@@ -51,7 +51,7 @@ struct mmu_rb_handler {
 };
 
 int hfi1_mmu_rb_register(void *ops_arg,
-			 struct mmu_rb_ops *ops,
+			 const struct mmu_rb_ops *ops,
 			 struct workqueue_struct *wq,
 			 struct mmu_rb_handler **handler);
 void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
diff --git a/drivers/infiniband/hw/hfi1/pin_system.c b/drivers/infiniband/hw/hfi1/pin_system.c
index 384f722093e0..cce56134519b 100644
--- a/drivers/infiniband/hw/hfi1/pin_system.c
+++ b/drivers/infiniband/hw/hfi1/pin_system.c
@@ -26,7 +26,7 @@ static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode, void *arg2,
 			 bool *stop);
 static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
 
-static struct mmu_rb_ops sdma_rb_ops = {
+static const struct mmu_rb_ops sdma_rb_ops = {
 	.filter = sdma_rb_filter,
 	.evict = sdma_rb_evict,
 	.remove = sdma_rb_remove,
-- 
2.45.2


