Return-Path: <linux-rdma+bounces-1299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E635874372
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 00:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE45A281ED9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29AA1C68A;
	Wed,  6 Mar 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rFVGtz/+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A21C291;
	Wed,  6 Mar 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766316; cv=none; b=JqSEp4KBlp0xovbERtS4KSUM73XXDRfYYdbYJpwBq2QebZVDdLcl8b0Mb/HciWHhCPHCahDDdjV6yhWt2TKygxBY29IxO16nTuqySca5gc5ckhA2UHQRdwSad+7ZJWWV8o/lj9rPgjv2mePk9puzoyJJLcbFefdrnumJI1P1waU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766316; c=relaxed/simple;
	bh=xhlIT+EZ1CJj0eq9kztu2VQgOq4D9T/87BnbZ1zDMP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gilLqngupVU0ELV7K3TyF/IkRoHC8W+GPxiH8uAScn9ISzPPBP9TmLR1yPPAnmU85qoVjiRV4ijIWbS30gAeDJda06WXFGtwUgn37nfpTAA49y3C9mIaUQI1bPYZsEOWK5mqNPbLvcoReAj9+g9qqwMsHdFhrrrkm5Ysq4ezcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rFVGtz/+; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709766315; x=1741302315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4+xazsZ8auCGyyQth/zWsKS9gvCd2G2WMpDXe9b6wJs=;
  b=rFVGtz/+bvP+I/LSfUeSmw3YaKyjSP1PYnh3Zx/vyUufRkb0zoBb6l90
   ckWT/zYUfCcXTJCLkSH3e2FKspO2vY8Jf7F2O2OCgX1ssKOxWmXcBP4Vg
   y6KB0Z89TZwGkNLd2Bjcln2F8sHkXvHlBX6sK2QxKBRxMGnM5Qvn0I/LZ
   E=;
X-IronPort-AV: E=Sophos;i="6.06,209,1705363200"; 
   d="scan'208";a="617908178"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:05:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:61480]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id 8ecd97e6-5282-49cf-b0dc-2dad61813fcb; Wed, 6 Mar 2024 23:05:11 +0000 (UTC)
X-Farcaster-Flow-ID: 8ecd97e6-5282-49cf-b0dc-2dad61813fcb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 23:05:11 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 23:05:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v3 net 0/2] tcp/rds: Fix use-after-free around kernel TCP reqsk.
Date: Wed, 6 Mar 2024 15:04:56 -0800
Message-ID: <20240306230458.28784-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported an warning of netns ref tracker for RDS per-netns
TCP listener, which commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's
reqsk in inet_twsk_purge()") fixed for per-netns ehash.

This series fixes the bug in the partial fix and fixes the bug in the
global ehash.


Changes:
  v3:
    * Drop patch 2, 3, 5
    * Fix UAF by purging reqsk during netns dismantle.

  v2: https://lore.kernel.org/netdev/20240227011041.97375-1-kuniyu@amazon.com/
    * Add patch 1, 3, 5
    * Use __sock_create() instead of converting socket
    * Drop Sowmini from CC as it's bounced (patchwork may complain)

  v1: https://lore.kernel.org/netdev/20240223172448.94084-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  tcp: Restart iteration after removing reqsk in inet_twsk_purge().
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().

 net/ipv4/inet_timewait_sock.c | 4 +++-
 net/ipv4/tcp_minisocks.c      | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.30.2


