Return-Path: <linux-rdma+bounces-1300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C13874374
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47C71F26A78
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71131C6A6;
	Wed,  6 Mar 2024 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LLKnEP7W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB597CA4E;
	Wed,  6 Mar 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766347; cv=none; b=BJ03jv5zd4b+nTmvPWPa4tzHCrkoituVfAWPw40SMBhZoEp2fURmfShZLZ69slX8DwctLOq/Dab8mPY7OQHaJ6vvkuRIkPAkqcGs6WxIIHHljTlCLw7fhApnWyRmyhBFenh1JIj8YaShPFBg3+iorgqSySZ8cbY4mbzv61sQq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766347; c=relaxed/simple;
	bh=i/0OhZU0UMNFGtZJSkXf7ib+APaaauaQK+ZfJgpJR7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dq8b69eEGs016Q+k8ID150YXSnKSOfZNKT+gzr/ZRqhDUcycrjQtmvgCj2olOF5AHiCJ0eItIdhJ9NrgZvGwERRgCc/tPtV1xO4IinNig5tsS+pSvziROkScFtgfkZl1uD6J3uQAIEIw45nfYdmW+vjzhg+ZpioBRH6SU7i0lXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LLKnEP7W; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709766345; x=1741302345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7nBtPJHjw1WBuP8Uf9okhml5369rnBo8/KDqgxWMKs=;
  b=LLKnEP7WX8JJ8LEoySA8Qzc6jbfGP4jxn/qIVueFJ6p0LEwmLnmUrGgy
   K+eHeRWnaNWWQ2aedSc5yw8QJvakWJsXgbSuBd6pQLM1E7gJAI0JXDyjr
   qCVh5Hvyhm7AolT0ibt4uiUEs44+SWWUbvdadvc5QWjwOyVtlw3nVgnEs
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,209,1705363200"; 
   d="scan'208";a="71297243"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:05:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:65423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.222:2525] with esmtp (Farcaster)
 id 4a7e7381-df83-43ef-9d51-560fd90f6361; Wed, 6 Mar 2024 23:05:43 +0000 (UTC)
X-Farcaster-Flow-ID: 4a7e7381-df83-43ef-9d51-560fd90f6361
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 23:05:35 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 23:05:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v3 net 1/2] tcp: Restart iteration after removing reqsk in inet_twsk_purge().
Date: Wed, 6 Mar 2024 15:04:57 -0800
Message-ID: <20240306230458.28784-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240306230458.28784-1-kuniyu@amazon.com>
References: <20240306230458.28784-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") added changes in inet_twsk_purge() to purge
reqsk in per-netns ehash during netns dismantle.

inet_csk_reqsk_queue_drop_and_put() will remove reqsk from per-netns
ehash, but the iteration uses sk_nulls_for_each_rcu(), which is not
safe.

After removing reqsk, we need to restart iteration.

Note that we need not check net->ns.count here because per-netns
ehash does not have reqsk in other live netns.  We will check
net->ns.count in the following patch.

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_timewait_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5befa4de5b24..00cbebaa2c68 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -287,6 +287,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 					struct request_sock *req = inet_reqsk(sk);
 
 					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+
+					goto restart;
 				}
 
 				continue;
-- 
2.30.2


