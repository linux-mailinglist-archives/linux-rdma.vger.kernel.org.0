Return-Path: <linux-rdma+bounces-1328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645A875B0B
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A8E1C213AA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5D47A76;
	Thu,  7 Mar 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qSKQUrzf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AD46521;
	Thu,  7 Mar 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853731; cv=none; b=SdWrVgr0vZ6vWAh7i3xV+sblk5iBsHr3RTRT7iwz7ptHqQcWkxRQMXT4UpEJxEr28FycXjZKAHgsyo3lez16VWa7Ru9DG2Wf0QSN94csJmzf2RIds69eD+eu3kryIGLRZWvU9qF+WGUbw65UrF1D+YkSer01SgHg8jFFRSuEJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853731; c=relaxed/simple;
	bh=CVQ7hPIuBN6kugN9cx+m8wn5ReNrOunvCf+GLejAh2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gU9Q7GZAFMmuEQZe12KDLan7x6XfvPRRfrmxY1Op+sqZPzb22vhClbGbyItgDg5VRiJHXHoIsuJMgGMEL9492QghLVvErn5xQh1IeFvlWYL5qY1GBGY28tgfuNVUfe675+R0ZvNU/zRa1XCWPpEYuFkgGJpaJjepoIDjQSrYaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qSKQUrzf; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709853730; x=1741389730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O/sRC4ICj7amOdO4WXTxg0mc1+QeoUVckHKiORst4rg=;
  b=qSKQUrzfXxeEGQg3Q7rIruFb0Awb/pz3ST4b5M2fj1kMGycCzB2a5lQ9
   Z2K5tZUliy8pcT0dzq6arJ4Np/dVUaWAA95WSe/kIAL8ndiF/qDbP0GQN
   wPt/FumM/VLh36F0BhvWa02f4b17MFDO3q2hjRMrvlC9p2ww57qNQ/1JD
   s=;
X-IronPort-AV: E=Sophos;i="6.07,107,1708387200"; 
   d="scan'208";a="190085491"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:22:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:46579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.13:2525] with esmtp (Farcaster)
 id fae2de8a-f1a2-4feb-8010-b418ff1fc41e; Thu, 7 Mar 2024 23:22:05 +0000 (UTC)
X-Farcaster-Flow-ID: fae2de8a-f1a2-4feb-8010-b418ff1fc41e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 23:22:05 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 23:22:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v4 net 0/2] tcp/rds: Fix use-after-free around kernel TCP reqsk.
Date: Thu, 7 Mar 2024 15:21:49 -0800
Message-ID: <20240307232151.55963-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported an warning of netns ref tracker for RDS TCP listener,
which commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") fixed for per-netns ehash.

This series fixes the bug in the partial fix and fixes the reported bug
in the global ehash.


Changes:
  v4:
    * Add sk_family/refcnt check in inet_twsk_purge().

  v3: https://lore.kernel.org/netdev/20240307224423.53315-1-kuniyu@amazon.com/
    * Drop patch 2, 3, 5
    * Fix uaf by iterating ehash and purging reqsk during netns dismantle.

  v2: https://lore.kernel.org/netdev/20240227011041.97375-1-kuniyu@amazon.com/
    * Add patch 1, 3, 5
    * Use __sock_create() instead of converting socket
    * Drop Sowmini from CC as it's bounced (patchwork may complain)

  v1: https://lore.kernel.org/netdev/20240223172448.94084-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  tcp: Fix use-after-free in inet_twsk_purge().
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().

 net/ipv4/inet_timewait_sock.c | 24 +++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c      |  4 ----
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.30.2


