Return-Path: <linux-rdma+bounces-1055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F085B369
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ADE1C21561
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0EE5A7B4;
	Tue, 20 Feb 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sH6MRfLT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441F5A4D3;
	Tue, 20 Feb 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412520; cv=none; b=FqzC6Ih7n6n/t6wmXqGyal2dP7o7RM1uYAE/t8jKG4Ji/EH5Ht+qzkMuboGBg0lYKjtvx781nHRNRrKxAXEPGcPR51xqscGl7yKLw9M89AJf9kEPrYOpsXAKI3u+DV0x/PLCZYP9uI3huhVRkZH+mhUeLJhXBOKbYnth48aFa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412520; c=relaxed/simple;
	bh=3KZsEV1WJUZcqZISvCXQp8Hcw+dNN1oGioEr2lvo0AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PXLfXBE4qCWA1fHyjpAG907SeLKnFmVZG0hykA90MPwtRobUXuejwCMBVDV/FPinkgnoIXRnNeD0MCSN7BN+Dk/dmyARIm+KIWDyDFNiJY2QnAhrcfc5Uq6VCDiMaGgR0rzcmYhsqZLU0gw2yQvxF9XiveaNZ62WimMRH4x6E7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sH6MRfLT; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412516; h=From:To:Subject:Date:Message-Id;
	bh=3USlzh593tPYna5RCKRSdt/zJLdUUoPtKz7as3FKsT8=;
	b=sH6MRfLTAVgVa1eqVq/Cx1ZaNt8RadDEO61NIbb5tBrHLP//Smq2ay43/4ZL2/3orfbbnm/xh/xSZ1kFPBpPsdgRyzU3n9iABRiE2FoOJ67fwUjfSqOP9sqQoJ1/2sQKwDmU9vqVp02PSXV2KPH5mc/zmop2FW/+RtwGF9HV+EQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXez_1708412515;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXez_1708412515)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:55 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [RFC net-next 09/20] net/smc: refator smc_switch_to_fallback
Date: Tue, 20 Feb 2024 15:01:34 +0800
Message-Id: <1708412505-34470-10-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Move code ahead which has no need protected by clcsock_release_lock,
On the one hand, this reduces the granularity of the critical area, and
on the other hand, for the inet version of SMC, the code protected by
the critical area is meaningless. This patch make it possible to invoke
smc_switch_to_fallback() in any context (IRQ .etc) within inet sock
version of SMC.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1381ac1..20abdda 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -909,16 +909,18 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 {
 	int rc = 0;
 
+	/* no need protected by clcsock_release_lock, move head */
+	smc->use_fallback = true;
+	smc->fallback_rsn = reason_code;
+	smc_stat_fallback(smc);
+	trace_smc_switch_to_fallback(smc, reason_code);
+
 	mutex_lock(&smc->clcsock_release_lock);
 	if (!smc->clcsock) {
 		rc = -EBADF;
 		goto out;
 	}
 
-	smc->use_fallback = true;
-	smc->fallback_rsn = reason_code;
-	smc_stat_fallback(smc);
-	trace_smc_switch_to_fallback(smc, reason_code);
 	if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
 		smc->clcsock->file = smc->sk.sk_socket->file;
 		smc->clcsock->file->private_data = smc->clcsock;
-- 
1.8.3.1


