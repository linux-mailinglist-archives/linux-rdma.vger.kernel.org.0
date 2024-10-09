Return-Path: <linux-rdma+bounces-5331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF4995E60
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 05:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82F21F25EC5
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 03:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3A145B14;
	Wed,  9 Oct 2024 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SHn+oQW/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302341C65;
	Wed,  9 Oct 2024 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728446149; cv=none; b=U7WI71N8pWK5HY5a1DYceAIeyZqZBkeCFmsAgjWOQnVKzv2PStvwm59dUilY4rsRHmBmx2jMzXgyeL7A2fhE4tmI7FtO+0t8LhXnYZFWs4wTKYibX7aeWnRWBq9c/oGHL3vbiCP+JAn7JRxrMPD2DVqjeEkwC3tpgH0PdqhMwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728446149; c=relaxed/simple;
	bh=YovY8awh6dbLsCBABiTUW8uP7hHUPRnKOpmIcgmFz/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBCUDUPtt7QLzF9GBH35boC5F4VYm/wGKhnXzkd8CeIaeVIfKn7eMxyoetFBFN5CYtdi5PO6Uu1c9QJxG7ligIVJKLPP2V2J63Y891OHbp66wW3he99Wz4Qi5xkW4g+zI7lKN5v7KxlvruLYzeVExUSvB3mD7XThNGNS0RYjuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SHn+oQW/; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728446144; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Mr4AZgx3ef7zPfrFWLebkXYqCtEPlBo2EembcVccSu8=;
	b=SHn+oQW/1KqyzIH4zUapzI6K9dj6aMoxQoF09JrgEmwx4hte7NjO/C6eklVFz2Rxsb9iJvyUnNA49BPTCsldpqGUIdBqAoC0nICXQYrchn1pVNsfvYHuTdq5zc4CYAIIebkd/8SgOE+sTbVLYAY+Sri0pI2at6k7xE2QpTtazDk=
Received: from localhost(mailfrom:KaiShen@linux.alibaba.com fp:SMTPD_---0WGhOfQw_1728446142)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 11:55:43 +0800
From: Kai Shen <KaiShen@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	guwen@linux.alibaba.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	tonylu@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v1] net/smc: Fix memory leak in percpu refs
Date: Wed,  9 Oct 2024 03:55:42 +0000
Message-Id: <20241009035542.121951-1-KaiShen@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds missing percpu_ref_exit when releasing percpu refs.
When releasing percpu refs, percpu_ref_exit should be called.
Otherwise, memory leak happens.

Signed-off-by: Kai Shen <KaiShen@linux.alibaba.com>
---
 net/smc/smc_wr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 0021065a600a..994c0cd4fddb 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -648,8 +648,10 @@ void smc_wr_free_link(struct smc_link *lnk)
 	smc_wr_tx_wait_no_pending_sends(lnk);
 	percpu_ref_kill(&lnk->wr_reg_refs);
 	wait_for_completion(&lnk->reg_ref_comp);
+	percpu_ref_exit(&lnk->wr_reg_refs);
 	percpu_ref_kill(&lnk->wr_tx_refs);
 	wait_for_completion(&lnk->tx_ref_comp);
+	percpu_ref_exit(&lnk->wr_tx_refs);
 
 	if (lnk->wr_rx_dma_addr) {
 		ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
@@ -912,11 +914,13 @@ int smc_wr_create_link(struct smc_link *lnk)
 	init_waitqueue_head(&lnk->wr_reg_wait);
 	rc = percpu_ref_init(&lnk->wr_reg_refs, smcr_wr_reg_refs_free, 0, GFP_KERNEL);
 	if (rc)
-		goto dma_unmap;
+		goto cancel_ref;
 	init_completion(&lnk->reg_ref_comp);
 	init_waitqueue_head(&lnk->wr_rx_empty_wait);
 	return rc;
 
+cancel_ref:
+	percpu_ref_exit(&lnk->wr_tx_refs);
 dma_unmap:
 	if (lnk->wr_rx_v2_dma_addr) {
 		ib_dma_unmap_single(ibdev, lnk->wr_rx_v2_dma_addr,
-- 
2.31.1


