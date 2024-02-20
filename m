Return-Path: <linux-rdma+bounces-1057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF285B372
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E211F22916
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D55B660;
	Tue, 20 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CjZipc81"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EF5B5AC;
	Tue, 20 Feb 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412525; cv=none; b=WM0+5nwL7wGq4fgAzWQuiIAWtHhXEbcUtYxmc1Aror0l5kNcvarEljA/xD/uw7yr0Kgz8PQ5LOg7uIElFmkTkU2RvuZgHLRjydlqH3K8PXiB5gYJyKn/pL0b+HEJ77/G+a2P0n3suqPVnyBFang60qWnLKqj/SYRSuDcj52bv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412525; c=relaxed/simple;
	bh=lUsgo7B7TuvCI1PsvB7d/R6A6ox50ArQ1Zv2S8EHM3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AtjrpQ9XFc9gZIdily4VuNtfcUYtXRFD8y/dEPs3raDQUOHF5MCFIYK+mWmkr1PihJ3Zz99Mldb62kycNOU16NR49LcUzSgEiMGITrSeG6qoniCeDo5lGnuQqbTsN78Nc3hQO1ipk8qt5CvNhX8ERc74C5Ft0+RohV3zd6+h4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CjZipc81; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412515; h=From:To:Subject:Date:Message-Id;
	bh=9lQeQhf1fFiHWvZuBmGc279ZVtyAMjo0RgNUKteShYc=;
	b=CjZipc81Zaf6OLyk8KVBBrIdVEDtirOi8+ZA5hDtDi1k0lHHggRU2nLHKCDEcCqyKjfYbawDG9z2x9z2SjJ/zoHxlc8gW7GuNGnaWJmanAkIRMkuu6W7Jg9lUMSYRY5AwRdj30jOwqeFbInO0pcRCFpdWpic1beuyOdNY0jZnGI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXeh_1708412514;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXeh_1708412514)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:54 +0800
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
Subject: [RFC net-next 08/20] net/smc: optimize mutex_fback_rsn from mutex to spinlock
Date: Tue, 20 Feb 2024 15:01:33 +0800
Message-Id: <1708412505-34470-9-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

The region protected by mutex_fback_rsn is simple enough and has no
potential blocking points. This change makes us can invoke
smc_stat_fallback() in any context, typically, in the context of
IRQ.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/net/netns/smc.h | 2 +-
 net/smc/af_smc.c        | 4 ++--
 net/smc/smc_stats.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index fc752a5..99bde74 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -10,7 +10,7 @@ struct netns_smc {
 	/* per cpu counters for SMC */
 	struct smc_stats __percpu	*smc_stats;
 	/* protect fback_rsn */
-	struct mutex			mutex_fback_rsn;
+	spinlock_t			mutex_fback_rsn;
 	struct smc_stats_rsn		*fback_rsn;
 
 	bool				limit_smc_hs;	/* constraint on handshake */
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 66306b7..1381ac1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -769,7 +769,7 @@ static void smc_stat_fallback(struct smc_sock *smc)
 {
 	struct net *net = sock_net(&smc->sk);
 
-	mutex_lock(&net->smc.mutex_fback_rsn);
+	spin_lock_bh(&net->smc.mutex_fback_rsn);
 	if (smc->listen_smc) {
 		smc_stat_inc_fback_rsn_cnt(smc, net->smc.fback_rsn->srv);
 		net->smc.fback_rsn->srv_fback_cnt++;
@@ -777,7 +777,7 @@ static void smc_stat_fallback(struct smc_sock *smc)
 		smc_stat_inc_fback_rsn_cnt(smc, net->smc.fback_rsn->clnt);
 		net->smc.fback_rsn->clnt_fback_cnt++;
 	}
-	mutex_unlock(&net->smc.mutex_fback_rsn);
+	spin_unlock_bh(&net->smc.mutex_fback_rsn);
 }
 
 /* must be called under rcu read lock */
diff --git a/net/smc/smc_stats.c b/net/smc/smc_stats.c
index ca14c0f..64668e9 100644
--- a/net/smc/smc_stats.c
+++ b/net/smc/smc_stats.c
@@ -26,7 +26,7 @@ int smc_stats_init(struct net *net)
 	net->smc.smc_stats = alloc_percpu(struct smc_stats);
 	if (!net->smc.smc_stats)
 		goto err_stats;
-	mutex_init(&net->smc.mutex_fback_rsn);
+	spin_lock_init(&net->smc.mutex_fback_rsn);
 	return 0;
 
 err_stats:
@@ -387,7 +387,7 @@ int smc_nl_get_fback_stats(struct sk_buff *skb, struct netlink_callback *cb)
 	int snum = cb_ctx->pos[0];
 	bool is_srv = true;
 
-	mutex_lock(&net->smc.mutex_fback_rsn);
+	spin_lock_bh(&net->smc.mutex_fback_rsn);
 	for (k = 0; k < SMC_MAX_FBACK_RSN_CNT; k++) {
 		if (k < snum)
 			continue;
@@ -406,7 +406,7 @@ int smc_nl_get_fback_stats(struct sk_buff *skb, struct netlink_callback *cb)
 		if (rc_clnt == -ENODATA && rc_srv == -ENODATA)
 			break;
 	}
-	mutex_unlock(&net->smc.mutex_fback_rsn);
+	spin_unlock_bh(&net->smc.mutex_fback_rsn);
 	cb_ctx->pos[1] = skip_serv;
 	cb_ctx->pos[0] = k;
 	return skb->len;
-- 
1.8.3.1


