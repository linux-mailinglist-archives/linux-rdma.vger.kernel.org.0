Return-Path: <linux-rdma+bounces-1112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0186195F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8DF1C246C5
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3112FB30;
	Fri, 23 Feb 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B2lfYivn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4B13A860;
	Fri, 23 Feb 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709125; cv=none; b=Q2YjMNlXZkItVyD1KX0j2rwpVOThs4aXNnn9zhEYSR76SeCtXCE/ZcvtN6ixKQzSqKd2Q3xtZ6A1qVwNpUpYyr6AsrB6LIEk3/HAegQSK5bTP0gLZISePRyWY8+Q1OizODwgAqArOuiWhFMDUWdp1WIg3KcD9AMt5PrNu1jdkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709125; c=relaxed/simple;
	bh=MKN9vH/iun7P96LKmIMq41fE9zw1qwu9Xj9oh1LbzFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSOBLDZ/xuPOIBJHtzQaVaYE0WAp7TwKhkQYxmDeb27e3gTHDj3cP2k0F7k++XJ17vQJWjwtd4nVSLaeQK7qlGwCpaXgfWlGpbK0XKN32sYF8Yeeg9m/W2DkvIE+E0zKqzKlphAdv/zfFycvaMNUJ74Ww/jRR2yw8EKYV0V8cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B2lfYivn; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708709115; x=1740245115;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h6mFAehqXAaDlonc1U6G+xqxJE9MaF54iVPyFAGbCMs=;
  b=B2lfYivnJgC32xwwD6w2bnD1Awfd/VsCKym2gkItlmDqh3iJfgOF1oFo
   LcTPlGOKGc2OT6z+q6O7Qnq7vnCT8tjJqcxua/GL3Rw+E1cgoSSkZk0V+
   wPO+ERpih5K3Vw8TPSnUQ7MLl0ehn6hFYzpxgGcO1ol3dZ5DvXya8gxkc
   M=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="383251499"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 17:25:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:33258]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.236:2525] with esmtp (Farcaster)
 id 308277d0-93fd-488f-b129-6a4a600b3ad6; Fri, 23 Feb 2024 17:25:09 +0000 (UTC)
X-Farcaster-Flow-ID: 308277d0-93fd-488f-b129-6a4a600b3ad6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 17:25:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 17:25:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v1 net 0/2] rds: Fix use-after-free of net by tcp reqsk timer.
Date: Fri, 23 Feb 2024 09:24:46 -0800
Message-ID: <20240223172448.94084-1-kuniyu@amazon.com>
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
inet_twsk_purge()") partially fixed.

This series reverts the partial fix on the TCP side and fixes the root
cause on the RDS side.


Kuniyuki Iwashima (2):
  Revert "tcp: Clean up kernel listener's reqsk in inet_twsk_purge()"
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().

 net/ipv4/inet_timewait_sock.c | 15 +--------------
 net/ipv4/tcp_minisocks.c      |  9 ++++-----
 net/rds/tcp_listen.c          |  5 +++++
 3 files changed, 10 insertions(+), 19 deletions(-)

-- 
2.30.2


