Return-Path: <linux-rdma+bounces-1149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1F8685A0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 02:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9DD286C16
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 01:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DBA4A31;
	Tue, 27 Feb 2024 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IVAFF0Hz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13D4A21;
	Tue, 27 Feb 2024 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996388; cv=none; b=LuzFxFVP/+4AYKf8ottazhgzbBe5LtRXCCG/sxqIWY2pqSHznsoyuBYoZzqqEE/MgIgfqEIexxtxW3FKoySOej0/V9E5u9Y57XyUNHZDKuk3sxsTQH4SnhSLtyYsYhuNWydhALdvkJ4h0gpszlcWiOoV9vZktdquPqmdgj8uRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996388; c=relaxed/simple;
	bh=rjDwHqLTMJJ+cqWoqsmMZdFyD7O0WVCXFw75kbvv13g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3ATAnIUAQNxjKMOHW3lm60TzJYpREtgzSVhJsRjvCvukBPMOP+NGfrKrodWqoVnf4NotOnKwq0v+Uy0C8Fq++CwT2srkLQHmEuF2mg5VZD9U3mugeRxE7ifWXuYQLrrAfQ16qVbQHRoDA+BDIgQspstd/74eDXS0QDPKpCne/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IVAFF0Hz; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708996387; x=1740532387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cYQeMcglbfCsqO+n2FbujJNC86HX4oA1mykhbxRwasM=;
  b=IVAFF0Hzp94AWhzx/Wwn/E8sxk1m6QkSFeeEqDktB5JxBylP9iyG+d0i
   JXFDu4VkH3O9Yq+sNMrvRtXweIYw64JXoqDr2YZb4MVlsUG5YVHIWoP6x
   zoNZvXso7x6sW3S4aWBNTSRL2GlXIZjPolIQAGeH7XBE6LsDByKLmVik4
   8=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="187574180"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:13:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:20027]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.27:2525] with esmtp (Farcaster)
 id ec880b31-c8da-499e-ae0d-5b40799d14aa; Tue, 27 Feb 2024 01:13:05 +0000 (UTC)
X-Farcaster-Flow-ID: ec880b31-c8da-499e-ae0d-5b40799d14aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:13:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 01:13:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v2 net 5/5] tcp: Add assertion for reqsk->rsk_listener->sk_net_refcnt.
Date: Mon, 26 Feb 2024 17:10:41 -0800
Message-ID: <20240227011041.97375-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot demonstrated that a reqsk timer could be fired after netns
dismantle if the timer was kicked by kernel TCP listener.

Regardless of the owner of the socket, TCP listener always has to
hold netns refcount.

Let's make sure that new user will not create kernel TCP listener
without holding netns refcount.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index df7b13f0e5e0..341dd5bb3fd1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6972,6 +6972,8 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 	if (req) {
 		struct inet_request_sock *ireq = inet_rsk(req);
 
+		DEBUG_NET_WARN_ON_ONCE(!sk_listener->sk_net_refcnt);
+
 		ireq->ireq_opt = NULL;
 #if IS_ENABLED(CONFIG_IPV6)
 		ireq->pktopts = NULL;
-- 
2.30.2


