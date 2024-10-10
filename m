Return-Path: <linux-rdma+bounces-5363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC6998564
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 13:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402FF1C23162
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4F1C32FE;
	Thu, 10 Oct 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fOrvlRz5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49301BE23D;
	Thu, 10 Oct 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561398; cv=none; b=sIpNuzJWZ0T9TpinfB9+8K/+necOcepiFDj0u90qZx9lRpxzq7JypdPwOK3lWbYaNU2HOaonItpDeaSubYcGVu/VBPfdQgwLSII0XQMKKg/pAZd/zEIaQyunb2cAvk065IltJ5O6kWEUb2k7epsvvZAvPaSYImEM2bsDRLSE14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561398; c=relaxed/simple;
	bh=g0mJrkgOFjF/EPZobqRoNNKRxR2msN1zVVeJiADVljQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3idkvMpObDVYcubX9MFLymdvsemEu8ugCSt5c9eJcBQkWMjilu4M0uq4GgJ8SqOg0edEDxLA2xP8loQtFi+QQWRvRXNuk7gKFEd4TUtgpIg1ECAGBQW4OAb5s78ViTS46WQLH3DoFnNcF3YYLAMiOFjF5GUS6IQfzsOijKxvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fOrvlRz5; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728561385; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IE9WTErSsarSbJYkwpClIloeKGivinfPYDinjLv3SYM=;
	b=fOrvlRz5bqYygNDMeLEOVsq2ykJPfcGSJJUGBjnGnxAXRsDhL748AtJaWP4hSkLBIGz9WgNy08EVIU2ORRF+E+p+Xd0OjV0If48nh5ioQAOQF35mKKqAVt3GbNhZJ6SJSjwg0R185VOoUUZpJH8E6vHm4i6BZ1Ko2nuecL3Lq3o=
Received: from localhost(mailfrom:KaiShen@linux.alibaba.com fp:SMTPD_---0WGmFPL-_1728561384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 19:56:25 +0800
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
Subject: [PATCH net] net/smc: Fix memory leak when using percpu refs
Date: Thu, 10 Oct 2024 11:56:24 +0000
Message-Id: <20241010115624.7769-1-KaiShen@linux.alibaba.com>
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

Fixes: 79a22238b4f2 ("net/smc: Use percpu ref for wr tx reference")
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


