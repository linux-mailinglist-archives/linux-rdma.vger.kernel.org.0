Return-Path: <linux-rdma+bounces-5952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727EA9C69B3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 08:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B401F25855
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA518660A;
	Wed, 13 Nov 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tQh46zbE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5E17D341;
	Wed, 13 Nov 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482057; cv=none; b=aoyw2on9noPTjfNwYe59aSPs5AwrBbsT9bzq/AqvoOqQFwyNDLkZHnbsBTJK7cu6BUzDezen+YajCY26YJyf3K+K6Y+cgluD3jNiCZDf4uVZD64o1eFKLBrW8Dc026UNyOgI9GdmyQPBAh9KgTc6sMZzAnc4zp7GYf1KTHntbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482057; c=relaxed/simple;
	bh=5dLao9gALixVdBKOeLmYUEytT9KF2WSrxonNCfISUmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGFNhazmQDxWJ3eKIT3NAVYwmGu1o8gkDPP4gWLxt+8eYh6iSvfQE61Q6zADtf1RQB+yjMFDkp2hibshbKT3kOOBVI7zduOzlij9uQjwmkadMoqfuFfo/Hpy62KfM/9M2P0b6Ds4fnZ7aq6ckAzZSeQTB4lDzO7wUIsxavJjKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tQh46zbE; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731482051; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uZ65EEAW3VwgGJhMH9S8hjOD7Qzduk2ssjxQR5jmTnU=;
	b=tQh46zbEAl3aa3e6YBcBEC9FZ1R/0UK6BCWhceSAVC0NWm8rnbqvImqnHv5ykE2wrBmGX9vvK2/bbO32UCFCjnTxT1OMvDBsWMZPlLuXKgZZ2EoJzZKuZnfB25xSATB9zYO+TpJ4n1sdeFQQOzTcU/x/N+b0hpJtec+2+k6AZJk=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WJK51YT_1731482050 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 15:14:10 +0800
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
Subject: [PATCH net-next 2/3] net/smc: reduce locks scope of smc_xxx_lgr_pending
Date: Wed, 13 Nov 2024 15:14:04 +0800
Message-ID: <20241113071405.67421-3-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241113071405.67421-1-alibuda@linux.alibaba.com>
References: <20241113071405.67421-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce locks scope of smc_xxx_lgr_pending, who aim to serialize
the creation of link group. However, once link group existed already,
those locks are meaningless, worse still, they make incoming connections
have to be queued one after the other.

As an optimization, Once we found that we have reused an existing link group,
we can immediately release the lock. This way, only the first contact connection
needs to hold the global lock throughout its entire lifecycle, while the
NON first contact only needing to hold it until the end of smc_conn_create.
This greatly alleviates the bottleneck of establishing
connections in SMC.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..5559a8218bd9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1951,8 +1951,8 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 	return true;
 }
 
-/* create a new SMC connection (and a new link group if necessary) */
-int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
+static int __smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini,
+			     bool unlock_with_existed_lgr)
 {
 	struct smc_connection *conn = &smc->conn;
 	struct net *net = sock_net(&smc->sk);
@@ -2026,7 +2026,10 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 			smc_lgr_cleanup_early(lgr);
 			goto out;
 		}
+	} else if (unlock_with_existed_lgr) {
+		smc_lgr_pending_unlock(ini);
 	}
+
 	smc_lgr_hold(conn->lgr); /* lgr_put in smc_conn_free() */
 	if (!conn->lgr->is_smcd)
 		smcr_link_hold(conn->lnk); /* link_put in smc_conn_free() */
@@ -2050,6 +2053,16 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	return rc;
 }
 
+/* create a new SMC connection (and a new link group if necessary) */
+int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
+{
+	/* Considering that the path for SMC-D is shorter than SMC-R
+	 * the impact of global locking is smaller. So, let's make no
+	 * change on SMC-D.
+	 */
+	return __smc_conn_create(smc, ini, !ini->is_smcd);
+}
+
 #define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
 #define SMCR_RMBE_SIZES		15 /* 0 -> 16KB, 1 -> 32KB, .. 15 -> 512MB */
 
-- 
2.45.0


