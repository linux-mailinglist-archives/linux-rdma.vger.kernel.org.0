Return-Path: <linux-rdma+bounces-1345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56393876B7C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 21:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA92F1F21D10
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AA5B5A2;
	Fri,  8 Mar 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qBty96za"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020050A80;
	Fri,  8 Mar 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928111; cv=none; b=mFhyR5D7pHQPMvcFqcNfgDXpuSB9eyiQVCl4XWdm5ncEHbsea+EtASJu3ue34mjihR0w6JHAf3PigWDEtD2g3pFMEDpZtA7AMGaTGJz8BbFrDcdXjOMBMhCPBznrdYCXOc4ADro5PjsNNTzNusdmQbHculxbxwdyWqsPjS4CDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928111; c=relaxed/simple;
	bh=sBi3PsrW8eEUjbFvqncGAmduFUQfT43kVhLc+5lLatE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKdKsXvD3i9sIsRMlkYAC6cHhXoR1i4RqYW5y6vhYyB+v0J/i6OE2NDrD+FFgBaUEdvH5eBNCzCdAHpS7PQMAevsr6DbGiGPId5Ec5o7cG1WnrklFrN+tUW+IyX6VQUhEdYmNQfXAGvJuQvy7/eQDYyDr55qL8I7AYwcHHA48YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qBty96za; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709928110; x=1741464110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FKQFu6C9LJsQVEJ6RUl3kiPedrxmDdWQ52fWqWvlQAI=;
  b=qBty96zafyhfOovPIl8zPJDth2hy2RB7SLb+GGrxEZx6VX6CvP6DHZVw
   jbAd70LnJ1zFK2am0sKJMwWD+/zBFc1pB+swqkdxfsCS4PuQFl3cfxhZT
   gmdQKq8+bSbDkrzqFrGlqfVGCOg37s4Tc2Vh5ECFSo6aX2E/pylwqwRck
   w=;
X-IronPort-AV: E=Sophos;i="6.07,110,1708387200"; 
   d="scan'208";a="402621794"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 20:01:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:36409]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.222:2525] with esmtp (Farcaster)
 id 2a404405-6cc4-48d2-a6e7-b39807168e1e; Fri, 8 Mar 2024 20:01:41 +0000 (UTC)
X-Farcaster-Flow-ID: 2a404405-6cc4-48d2-a6e7-b39807168e1e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 20:01:35 +0000
Received: from 88665a182662.ant.amazon.com.com (10.142.235.16) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 20:01:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v5 net 0/2] tcp/rds: Fix use-after-free around kernel TCP reqsk.
Date: Fri, 8 Mar 2024 12:01:20 -0800
Message-ID: <20240308200122.64357-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported an warning of netns ref tracker for RDS TCP listener,
which commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") fixed for per-netns ehash.

This series fixes the bug in the partial fix and fixes the reported bug
in the global ehash.


Changes:
  v5:
    * Reuse the correct logic for reqsk in inet_twsk_purge().

  v4: https://lore.kernel.org/netdev/20240307232151.55963-1-kuniyu@amazon.com/
    * Add sk_family/refcnt check in inet_twsk_purge().

  v3: https://lore.kernel.org/netdev/20240307224423.53315-1-kuniyu@amazon.com/
    * Drop patch 2, 3, 5
    * Fix uaf by iterating ehash and purging reqsk during netns dismantle.

  v2: https://lore.kernel.org/netdev/20240227011041.97375-1-kuniyu@amazon.com/
    * Add patch 1, 3, 5
    * Use __sock_create() instead of converting socket
    * Drop Sowmini from CC as it's bounced (patchwork may complain)

  v1: https://lore.kernel.org/netdev/20240223172448.94084-1-kuniyu@amazon.com/


Eric Dumazet (1):
  tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Kuniyuki Iwashima (1):
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().

 net/ipv4/inet_timewait_sock.c | 41 ++++++++++++++++-------------------
 net/ipv4/tcp_minisocks.c      |  4 ----
 2 files changed, 19 insertions(+), 26 deletions(-)

-- 
2.30.2


