Return-Path: <linux-rdma+bounces-4440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19339592EF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 04:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E421C20D7F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA014BFB4;
	Wed, 21 Aug 2024 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UllWxUSS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01ED146D75;
	Wed, 21 Aug 2024 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207810; cv=none; b=t/L45qTslJTV9ucDOXaxTI3j35lp5XAKqx8An7I3y4bjz7A4E2N/hNpaqual8d8PCFCWDpch+URhyhNrCK8VUwW1C64uNnisB+XS7j35Hlp4/93qUap1rx91C3QI2lu5qk1v7fd3x77EqeRmrNoQ6OIhccMKbknrO9ADKfcnr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207810; c=relaxed/simple;
	bh=HL9y2bHven80Acr7ptdtVe2NS9OfHeWdGcgm82QfLg0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cIiRK3AdS83zcf85jBHofhHyUBzDeRtWPKu6B11aWVYqb+hXSXJWl1VzEKmJqfKxtwHLpsNBGGpiPCUY858wFIO2q/rBSPzll0RcZGkaRuTncEzY7K9J80vwcElv4l4llZuncNujTIag3IZKRn2Q7H0nOS+GyJkT5PLpsUC8+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UllWxUSS; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724207804; h=From:To:Subject:Date:Message-Id;
	bh=/LtM0Vhj5juKXv4hadpMVC/PvoFiH6ytC4L9vRYgly8=;
	b=UllWxUSShl4f5vKg27+v7orDNYF9qQcpENeXC4KlpH2F9rmBVbtHbt2jDNhOAb/NJ8pY/LdmtGuyOHYGPcDNRWy1E/6UBCN7OIncXw0CvIKsTuiS8Va4tDX+mYJT+Gd9W5QPU9m6shpuOtJg6RzbNKRaB/wd6uG8UHM/XMQKuSo=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WDKIPAU_1724207797)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 10:36:43 +0800
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
Subject: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
Date: Wed, 21 Aug 2024 10:36:37 +0800
Message-Id: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
we introduce a mechanism to put constraint on SMC connections visit
according to the pressure of SMC handshake process.

At that time, we believed that controlling the feature through netlink
was sufficient. However, most people have realized now that netlink is
not convenient in container scenarios, and sysctl is a more suitable
approach.

In addition, since commit 462791bbfa35 ("net/smc: add sysctl interface for SMC")
had introcuded smc_sysctl_net_init(), it is reasonable for us to
initialize limit_smc_hs in it instead of initializing it in
smc_pnet_net_int().

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
v1 -> v2:

Modified the description in the commit and removed the incorrect
spelling.

 net/smc/smc_pnet.c   |  3 ---
 net/smc/smc_sysctl.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 2adb92b..1dd3623 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -887,9 +887,6 @@ int smc_pnet_net_init(struct net *net)
 
 	smc_pnet_create_pnetids_list(net);
 
-	/* disable handshake limitation by default */
-	net->smc.limit_smc_hs = 0;
-
 	return 0;
 }
 
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 13f2bc0..2fab645 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -90,6 +90,15 @@
 		.extra1		= &conns_per_lgr_min,
 		.extra2		= &conns_per_lgr_max,
 	},
+	{
+		.procname	= "limit_smc_hs",
+		.data		= &init_net.smc.limit_smc_hs,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
@@ -121,6 +130,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
 	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
+	/* disable handshake limitation by default */
+	net->smc.limit_smc_hs = 0;
 
 	return 0;
 
-- 
1.8.3.1


