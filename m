Return-Path: <linux-rdma+bounces-1145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B6868598
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 02:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B6BB22FB0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446A4A24;
	Tue, 27 Feb 2024 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e1RxINpv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCA4A21;
	Tue, 27 Feb 2024 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996286; cv=none; b=J1hDSNefUpOXu66mK4Vq6we8SakPu5h6zUrvOqRNSGpmpI0qrnVepiBiLLOrdLqzQNzQke7RmfZder30l4HnLzWOp3C1ncSd322GTA7QfPtMZxucGwzak1JCb4b73syYbJv6PlHobKa4R0kDpwENPStez73rCzx2DPC4mP4HoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996286; c=relaxed/simple;
	bh=9fky4NXpr+3ykSW2uH/qdFPPJQ8A2KdjRO58GhtpncM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa2vlMYYDUmD6mt+jsEFkEJ5aElqfSg9ll8R4iOQyIIODssAYFN3En1HFt+fe3ESw0mG5lDbVvkKe7ffrUwwiLBHsz7T4NyubvqWlypgQlkNg3p76Wwh++8bOnwyyQeIUtnaw2w/o11Dql+QMdP2SCx0q/6ptIs5kveOpcMe7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e1RxINpv; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708996286; x=1740532286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=veGEC1zoLAkeldJklL1xVz9Rq+F2PDiRn3qM0xZssAs=;
  b=e1RxINpvXnaODEgtmBJkGBWAYSG1OB4Ujtl7GsAlds8r2UEA14UeG5cu
   uUa45BeiBsPkYEh5YMpeN5k1lCAcC/jWxdV2Sak287FNxMWe4W6NcLtsy
   nIRkBhrV9IHyWqGdgQ53z98s0rXC+iKvNs1DXpM8NdIZq6zycst7GFjca
   o=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="276917896"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:11:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:19212]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.110:2525] with esmtp (Farcaster)
 id 0b049094-5800-4107-a40d-082085f99593; Tue, 27 Feb 2024 01:11:22 +0000 (UTC)
X-Farcaster-Flow-ID: 0b049094-5800-4107-a40d-082085f99593
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:11:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 01:11:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v2 net 1/5] tcp: Restart iteration after removing reqsk in inet_twsk_purge().
Date: Mon, 26 Feb 2024 17:10:37 -0800
Message-ID: <20240227011041.97375-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240227011041.97375-1-kuniyu@amazon.com>
References: <20240227011041.97375-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") added changes in inet_twsk_purge() to purge
reqsk in per-netns ehash during netns dismantle.

inet_csk_reqsk_queue_drop_and_put() will remove reqsk from per-netns
ehash, but the iteration uses sk_nulls_for_each_rcu(), which is not
safe.

After removing reqsk, we need to restart iteration.

Note that we need not check net->ns.count here because per-netns
ehash does not have reqsk in other live netns.

This change will be removed by the following patch.

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


