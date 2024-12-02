Return-Path: <linux-rdma+bounces-6178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C19E0297
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FAE28334C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115421FECD0;
	Mon,  2 Dec 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hu9g1Bdl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AF1FECAA;
	Mon,  2 Dec 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144270; cv=none; b=WnAkHY9B0oSpM1tzsk+WSgfga2qpVLPQFnSB2VVntn9abfgpj/sBfK156NXfH+fhH8YnQklcX0JgFosWp6KIQJ9nQeqyw62Sc0Y41lZEzYInKrwt1jFfLRENZ1BL1uvy/in4zAKAOfJAsrMBXbYuHIeNp/1pRXKJckik6wuZ0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144270; c=relaxed/simple;
	bh=WIFTfLRtWIbmKOe5N2WxKahoy+fZDYTmWbbkb1Xe/h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9AvfBsg30usgNeBs/EHtfjSEgwIZYMjnQbx9fsr5ftXIaciPcIZo18SXtYWgLifbEIagvelMoYAykRrs0wKgkNpJZmHhf+7iLScGKdrNyEv5XAzs15Y9eIfCJPeu1KzULs9j6hIeRJwPW/sgSziaeMTg7UOFCkCEAdUdpA63Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hu9g1Bdl; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733144264; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Hwovjb37oAscD8S2WDwN1CnxYV2g6cBXzAMEDEitLYs=;
	b=hu9g1BdlxaEyyeZc3jDaYLywmSL+JlwYT2++Q/5er3vU3BQLGCnq8LbfJKltkX6x6zj7loDjjG9oEP75B0kdNOEkH6mHoWEpFTGRfkOJXxBxFYvfZXn2wSso1olnwK9jAiopQ6p78tEKdu3JTOGyOMI3rSE2aLK3uD2YHIf09Qk=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKiDfpQ_1733143936 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Dec 2024 20:52:16 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
Date: Mon,  2 Dec 2024 20:52:03 +0800
Message-Id: <20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_INET6 is not supported for smc-r v2 client before, event if the
ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
will fallback to tcp, especially for java applications running smc-r.
This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
using real global ipv6 addr is still not supported yet.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..5b13dd759766 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
 	ini->check_smcrv2 = true;
 	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
 	if (!(ini->smcr_version & SMC_V2) ||
+#if IS_ENABLED(CONFIG_IPV6)
+	    (smc->clcsock->sk->sk_family != AF_INET &&
+	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
+#else
 	    smc->clcsock->sk->sk_family != AF_INET ||
+#endif
 	    !smc_clc_ueid_count() ||
 	    smc_find_rdma_device(smc, ini))
 		ini->smcr_version &= ~SMC_V2;
-- 
2.24.3 (Apple Git-128)


