Return-Path: <linux-rdma+bounces-4782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69B96E7CA
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 04:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F40EB231E7
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F127450;
	Fri,  6 Sep 2024 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FGWCiCHx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540F20309;
	Fri,  6 Sep 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590149; cv=none; b=q3lShJhrfB9bVn+RsiTIs+xm7zwPji6x+mmUfgQsDyX5FR20pyvfXYhulqRLaeoXn0fMhxA3sDx+8EFBcFus4BHWwwbe5SW/JIxgCa6VucqXeVEtGfmO1BDaAN7UYe1VnTKPtbN3WQvCmWPdLxS92oc5yG6nYc4elkVflgNU5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590149; c=relaxed/simple;
	bh=Fzr6nr+kwIKI9j5BIdLiVRJ3OmBZ4n8WUcYcVRxtIGs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Et17vECAdkhTqQYhDZAdkKsKasqYVWf2URZYINZEjfaHKO+mm3PU7LczQhtYIIzxdzkXlwjHY8PihLKwqBM/bsU4RqkLn5biwJ5E1q3ZJNP4WoMBlWK1HL6fYo6GJ+IfkA46R2VcuMcuzJAAnAmzaiAPj0Cvx8QwCGa8ebyklPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FGWCiCHx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725590139; h=From:To:Subject:Date:Message-Id;
	bh=DnyB99j6a2ROjkoQoX8a/uNCuS7pxEQfXsOLHA3wH0o=;
	b=FGWCiCHxILs5KvtuPt+k95cr1aWhskJFYWpAYBahLVqOr/V9rMY3keg0qeDRywueByfr5zjEnCOvN9+/ZRQLMh+hEfzMMkqcY27uFPC60iB4Yckgb0SYLUNWORTAUHb++h2jgrA8jO/8LH/KW5OM4EUAStx14YiCooxOhAfbLt0=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WENfFPd_1725590135)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 10:35:39 +0800
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
Subject: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
Date: Fri,  6 Sep 2024 10:35:35 +0800
Message-Id: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
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
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Jan Karcher <jaka@linux.ibm.com>
---
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


