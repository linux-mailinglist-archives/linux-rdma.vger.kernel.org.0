Return-Path: <linux-rdma+bounces-1144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5C868596
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 02:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC60F28829A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894A4A21;
	Tue, 27 Feb 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KjQTdNy/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E344431;
	Tue, 27 Feb 2024 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996269; cv=none; b=h4WnIcspL1bcAv1t3ts+n7R6n81wsnPkebpCAW39dkxIMTe0bTjrhMRTqQ2majALqcMrwoenp+NVBpEjmBICRqMkizz16mQI7vIislshhB8mIiZMjIGZGCPbzU8vFwqWsk4zwcZH99x9d2BPTYj2SjbIqcTDf/IlqGyCYGW647s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996269; c=relaxed/simple;
	bh=31fx+RgHtZQf83ehXggRMV7BeY/u3gFBIwnuDWEuBTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjHLWIsPZUWZ3e5NF+/TTsXRJQLLnhTyJ+Skzq8PA33oiAmnC3DGKvV22akCHHmySNwvSkK3oVoKYloxLNxGuP+/Xk+K92UOiHu9SW866KXGtjCwGAXGihjKJpGzUKM6T1BjYlwZhKDbcpqTwXryEKplFJK8OBUS/cz/Nt7mWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KjQTdNy/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708996263; x=1740532263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nyiY0qMYbFd1Ila4fyy+C1/UyqVqR9w3awAl3lt5HJI=;
  b=KjQTdNy/wcMiXcL7121r45RCu2h/ASMjmtQ5cnx3KeITPOWZAVzlkKpB
   GxZZAfyy/jOYTmadYA/BkECvAQzcpRKVxSklQ4Wf78VdWeOuwo8qf6SYH
   X3HeVhotT3UbvdyjE/Bpz0L5wRVW3bdSeTc4pJednlfyJ5RpalqsARMHj
   o=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="399853896"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:10:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:40138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.172:2525] with esmtp (Farcaster)
 id a8a2cb32-841f-4ce5-b3cd-b8a793e4fbf3; Tue, 27 Feb 2024 01:10:57 +0000 (UTC)
X-Farcaster-Flow-ID: a8a2cb32-841f-4ce5-b3cd-b8a793e4fbf3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:10:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 27 Feb 2024 01:10:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v2 net 0/5] tcp/rds: Fix use-after-free around kernel TCP reqsk.
Date: Mon, 26 Feb 2024 17:10:36 -0800
Message-ID: <20240227011041.97375-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported an warning of netns ref tracker for RDS TCP listener,
which commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") partially fixed.

This series fixes the bug in the partial fix, reverts the partial fix,
and fixes the root cause on the RDS side.


Changes:
  v2:
    * Add patch 1, 3, 5
    * Use __sock_create() instead of converting socket
    * Drop Sowmini from CC as it's bounced (patchwork may complain)

  v1: https://lore.kernel.org/netdev/20240223172448.94084-1-kuniyu@amazon.com/


Kuniyuki Iwashima (5):
  tcp: Restart iteration after removing reqsk in inet_twsk_purge().
  Revert "tcp: Clean up kernel listener's reqsk in inet_twsk_purge()"
  net: Convert @kern of __sock_create() to enum.
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
  tcp: Add assertion for reqsk->rsk_listener->sk_net_refcnt.

 include/linux/net.h           |  6 ++++++
 net/core/sock.c               |  2 +-
 net/ipv4/inet_timewait_sock.c | 14 +-------------
 net/ipv4/tcp_input.c          |  2 ++
 net/ipv4/tcp_minisocks.c      |  9 ++++-----
 net/rds/tcp_listen.c          |  4 ++--
 net/socket.c                  | 11 ++++++-----
 7 files changed, 22 insertions(+), 26 deletions(-)

-- 
2.30.2


