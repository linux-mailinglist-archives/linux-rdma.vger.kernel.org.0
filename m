Return-Path: <linux-rdma+bounces-6411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB99EC234
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7374D188B3BC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684291FE466;
	Wed, 11 Dec 2024 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uTswmEjB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F531AAA1D;
	Wed, 11 Dec 2024 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884274; cv=none; b=sgEYbzh1H7edo0mHjE0vfTYXddWdYUHnfUHTz6MR6OYlOPKnkrgE1AE6p2nuC0yQC9XMUQERHvAHF5+iXICWdsZYa1+ytPqTQrXDZu85iXeDn8o1TZcMSp3JRkrNwa/9EY/C14xsaQ9ELBf4jvidCE11t6HIPK3jy4JcrlIccu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884274; c=relaxed/simple;
	bh=0fRgUTdnBmXLaWNbMU90YNCIvevgYoE3c4lpJnZCwME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHeu8WooDSimVoKxcyQ/LRhX7T6li/OL5A1DsUG0QxtwiorAJs2tx1lQ6xmxtCtSLMGGeN+wdxp5Y376Pj2z8FdSv9shTKrjitUat3DrqiPJXcCEdvaClrGZykqiLMw8uXBcznoI7DfSiEQ/7H2taVDtleFUolc6V0z3uquhEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uTswmEjB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733884268; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=E7TKlEymnhK0dRUNd1uWV3b7/9DQgqeStKAp9nTcWbw=;
	b=uTswmEjBzCLim6Yb+IOtL5K0iyBce3MLUKZKmKz+SOkVcFXeplJhqy8PPr0o1nMEKcB9qkjilMqi1lbC/H8Nepn2CkuVsjFtCWS/IpTeR1WGOeIxwfOhHaSwcD5cJkZQdS18FjWq2jUxZudMByndATlhIbewqoNGyoAJtoW9HVU=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLGemVk_1733884266 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:31:07 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	pasic@linux.ibm.com,
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
Subject: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
Date: Wed, 11 Dec 2024 10:30:55 +0800
Message-Id: <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
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
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
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


