Return-Path: <linux-rdma+bounces-11943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A74AFBE10
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 00:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8554E3B5ED2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B328CF68;
	Mon,  7 Jul 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MVEbWS8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B36944F;
	Mon,  7 Jul 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925824; cv=none; b=n/kZNRXN++tVB9v0whe5RAj0jJTEF1D69SvoAuPQJAQ214htgEwqb8+khSVPLhuQ1/RfhChAkKra3Lqsmpf/3qlnANqI78Mo3gmANmRt17/pyxW/v3ZFhs6KbEZhTlmImXIoc8a4a9G72qdZSHK6veVVVvvbmBD3xZYLJsPOOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925824; c=relaxed/simple;
	bh=+SAM8PoZovijHVxvPUIPN/YnxqQxec5IiQv7Me7VaVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXSVOD8KrjWh8AMqx9Xb0v+znB3SozC82QeqGf2/uyExj+020ne79FrjiLsE2yPitxi0xUw3fsC0QeSGBY3CAzQkHMaSJ/r6HqbiGXLbfXa9K3hZ605dHFFlf4AQXSNpnkxNfGs2B/4yoRxI6bruHqQUQupkTXPgVU7crxmcNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MVEbWS8O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from easwarh-mobl2. (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id DBFCC2033420;
	Mon,  7 Jul 2025 15:03:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBFCC2033420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751925822;
	bh=AlFM+M+KNW9QL9luNsE6t5ZUXlN1KrLG3+QvxKi/qa0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MVEbWS8OfHuek8rLDdwjP3h5le0g25JP4KEB5179+1a6QX91oJ23DhYThK4l+ttnQ
	 ZHL4egp/hodlrrssCxfGIaha1Bi3DNsZGnDrtlF8SRydl6KF0iNs6EnqyMh/CkRymP
	 DfGb96IqNs/3Xc1DElP/1fe4KqH0q/H9rUMCQAJs=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 07 Jul 2025 15:03:32 -0700
Subject: [PATCH net-next v2 1/2] net/smc: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>
References: <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
In-Reply-To: <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-rdma@vger.kernel.org, 
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/smc/af_smc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8d56e4db63e041724f156aa3ab30bab745a15bad..bdbaad17f98012c10d0bbc721c80d4c5ae4fb220 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2735,8 +2735,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
 
 	if (lsmc->sockopt_defer_accept && !(arg->flags & O_NONBLOCK)) {
 		/* wait till data arrives on the socket */
-		timeo = msecs_to_jiffies(lsmc->sockopt_defer_accept *
-								MSEC_PER_SEC);
+		timeo = secs_to_jiffies(lsmc->sockopt_defer_accept);
 		if (smc_sk(nsk)->use_fallback) {
 			struct sock *clcsk = smc_sk(nsk)->clcsock->sk;
 

-- 
2.43.0


