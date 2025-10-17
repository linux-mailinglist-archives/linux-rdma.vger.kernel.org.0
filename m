Return-Path: <linux-rdma+bounces-13917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2CBE6B66
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 08:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6279A3AAFF6
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B730F54D;
	Fri, 17 Oct 2025 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W8gvXA9u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AC1FBEB0;
	Fri, 17 Oct 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682464; cv=none; b=lsppekodRIGQ4c/uWLnM2CLW/6aoHLxBAUo5QppjQJ8oKtwBCZAKN/oIJ5XTYm7QZinQ1uLo+2b6upnfdL96hPoH+pLqVhZDfWlRQ1wn8LALjOUG5SjgcFC3l6xKJg8YtGFeJrh8BZJM7tbGhoowHBk4UGfG4zkcog3d38SspxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682464; c=relaxed/simple;
	bh=hRcoYEbQV0mo4m0T81fbrsNIRJfAjdAMFHPldlGfJUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHKi3uDe6H6DWaVv81Vaa0423UtziffamgMv3yb0lRT3ajBUufHPsvv0Kmnmf7V85kZDqriJWfd695FdPpUXvfT7B8aeKnuMCSBbjo3xXEyYx7DET8Nm5axkXNI8zVaYSUy6ju/5ohfuHA6VnQbG4+5GlbGyuuIs7ZYlb8cY9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W8gvXA9u; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5DJFLlrLZkXL+gGLN727iAo9OGJQnJtVOjdN7wGssVE=;
	b=W8gvXA9uXtvO4llyiIZgatSxSYmO3IQ/Sz7HSxlBm7/SOYsFbd+sorDvydsSX5H4L5QIqdZuG
	UcfMGNDcQsD3Aqj7f5Ld9R3F3o7123AfNVAHsP45Z6DFbggX0tJJih/kl/eZbsCX/nKNqDzt+tE
	rM/nDh0AUpLkRp/l8XCDfAE=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cnvxd1DTszLlZ8;
	Fri, 17 Oct 2025 14:27:17 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DD17140142;
	Fri, 17 Oct 2025 14:27:38 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 14:27:38 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
Date: Fri, 17 Oct 2025 14:50:45 +0800
Message-ID: <20251017065045.1706877-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

#syz test

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a944e7dcb8b9..a94084b4a498 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -56,7 +56,6 @@ static struct inet_protosw smc_inet_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet_prot,
 	.ops		= &smc_inet_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -104,27 +103,15 @@ static struct inet_protosw smc_inet6_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet6_prot,
 	.ops		= &smc_inet6_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 #endif /* CONFIG_IPV6 */
 
-static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
-{
-	/* No need pass it through to clcsock, mss can always be set by
-	 * sock_create_kern or smc_setsockopt.
-	 */
-	return 0;
-}
-
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
-
-	inet_csk(sk)->icsk_sync_mss = smc_sync_mss;
-
 	/* create clcsock */
 	return smc_create_clcsk(net, sk, sk->sk_family);
 }
-- 
2.34.1


