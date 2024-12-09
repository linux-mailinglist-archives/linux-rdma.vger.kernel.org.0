Return-Path: <linux-rdma+bounces-6332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA79E9642
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6973A164188
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EE1B043D;
	Mon,  9 Dec 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fb82XNWo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31D234969;
	Mon,  9 Dec 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749631; cv=none; b=FiCz38p4ddaun4VXDxXPYf0GuKKtqbcpn3LOx9KNMt65WvkDB8keCL8HIHUHynCwNP1wd+Bhq4PfIc7fMydJrIkCxMXVXyP5gP0FylZJ5JzpaCkzFD35bJouovg8AxnmGIJ3PZjQF5OZWy5JucF/OLGNwbvcEd0ZbknHLnqaqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749631; c=relaxed/simple;
	bh=DpHAyUjc3/1GiIvRLKBvS5sUpFpfrxKhPzzv6CSy3DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJseVKCNf3duUn16ANRxkB5ZcjYiXeGUhM4J5YM07ltnVEzVXY5Q3lDrnqyYrYYoovnxjUTslqWpLtYKk31CxD8pXbtOCmmPEAEfjgqYLVP0DUQuA988fFmyf3mt5p99d+j4D1kkTl0aKqEs10V2GFpMMH5BrSlUNwTPKqLJ+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fb82XNWo; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733749623; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FfWawy1cHTcYAUYSNosBjfVSaxcWpVzVuXJ5f856eL0=;
	b=fb82XNWo+oboHgjDnDHKKk5CCec2Nx0410Omhr7mfeVmfvtRSqEOa8tACNWvBoxcakAsZCzaQLlgCgJ84U7hrIrad6+YylmPUM8KuR54reaGRum3VPila9yQ0FafvZ+CzKvRuFBXOBAefVc9ScOGhjw7Nx8Q7PKIjCTd4VZh++w=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WL8eHjH_1733749622 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 21:07:02 +0800
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
Subject: [PATCH net-next v3 2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
Date: Mon,  9 Dec 2024 21:06:49 +0800
Message-Id: <20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
References: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_INET6 is not supported for smc-r v2 client before, even if the
ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
will fallback to tcp, especially for java applications running smc-r.
This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
using real global ipv6 addr is still not supported yet.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 net/smc/af_smc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..c3f9c0457418 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1116,7 +1116,10 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
 	ini->check_smcrv2 = true;
 	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
 	if (!(ini->smcr_version & SMC_V2) ||
-	    smc->clcsock->sk->sk_family != AF_INET ||
+#if IS_ENABLED(CONFIG_IPV6)
+	    (smc->clcsock->sk->sk_family == AF_INET6 &&
+	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
+#endif
 	    !smc_clc_ueid_count() ||
 	    smc_find_rdma_device(smc, ini))
 		ini->smcr_version &= ~SMC_V2;
-- 
2.24.3 (Apple Git-128)


