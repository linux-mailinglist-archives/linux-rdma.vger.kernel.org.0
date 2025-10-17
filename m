Return-Path: <linux-rdma+bounces-13916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD14BE6A61
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 458074FCE28
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276630DED0;
	Fri, 17 Oct 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tctNvCZQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315F190685;
	Fri, 17 Oct 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682323; cv=none; b=O+KDI9kXen8JGarN0ZIyHK9Cbe3EThGGNfl7OAG7+wziCuXwf/Y+zTIDdLZgao7HGxenLeTEcWvKPFsCMADhJeAx1H+3Yx4xITso1vRCi/GOEqFVW9v2yxe2O3xiv8eQDyOqtH0rqoSxUMJ2SdOe77CEGpyHJVZF9Lhg4MTLFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682323; c=relaxed/simple;
	bh=7etpPFxmDoHeFqMLgTVURFSBEnY5w9kZFx1G/B7x+qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkMZBh2eoKWr0ggLQ2mUHikgKSYqgHcs/ZwZMLDcqEJPjvnUTYgN8xuD2kud3aErJF4V14QtqtRkNvb9scQFkekk8QZOD7BU884xKU88ffzEFfipPYcuzlAkIddy5hLQ7ktyzfv8ZJW7gxQlHJkPtoeTSkJ7Sy8NhnF2vmP6TBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tctNvCZQ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hf3s6IotuP8hPtMIWtNOWIPPdPC89JlbFcmRlpjDvK0=;
	b=tctNvCZQg2dyAE6oTFninje0M0O50QZC6fhyfXcVU04yK0oQCf9lB3lcUaROxVZ/uflAlMHJQ
	fJxdr+S9GKU4S5Dp/QHSFHQF6LVuR/TqZ0RULBGARSZ6vXoYgxMcSxMMRN75wmOVV41hVkJGzgp
	oHFaOTW/GBHctH02235OLIQ=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cnvtv095mzmV66;
	Fri, 17 Oct 2025 14:24:55 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E68A140120;
	Fri, 17 Oct 2025 14:25:16 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 14:25:15 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
Date: Fri, 17 Oct 2025 14:48:23 +0800
Message-ID: <20251017064823.1639083-1-wangliang74@huawei.com>
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


