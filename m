Return-Path: <linux-rdma+bounces-7862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A975BA3C9C8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4859F3A5738
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D77323C8BD;
	Wed, 19 Feb 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lZ0NYqHW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C022F167;
	Wed, 19 Feb 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997039; cv=none; b=CNxABG091kaPioukANSYdJPCbFCBqIYhaJcdW5tDQvLr+8rF2RwiUu3CJ1SbcdZnMj9fIj5tREWwYaq60VlECBEvivC5lvbioHcuuTqpwQJVHLL+biH9mu1ILpfGVwR/utkgm76eJDHxCKIfiH/hL/RPXgoecFNYo6MiFqcVs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997039; c=relaxed/simple;
	bh=kWNQkjEkje7cq9Kj6cTDyTGuX928Z2Dhg2sQVtWeWos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YF49MBBDC4oTozU1/rsnPoiUZQKGDYAP11g25l2dDJQKYKMwGo+shUJzmTU5R0Iur+ofl+1Yh22PoxqXGLP0AzjcbLQ1h498CR2M502YWWDgT03vawusPitl6hiYd8TnXa8111QEnK8+gonlgNX7S5Fc5qDx5R4ZDNhz6WAZeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lZ0NYqHW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 008DB2043E1C;
	Wed, 19 Feb 2025 12:30:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 008DB2043E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739997038;
	bh=mInSugtMcFd7uRrpSysmK7J5WYRlx7jlnEH7lwmvBzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lZ0NYqHWJraRU6lo9mlQ7DH5wa3HAp9yVPZBdjVt77P71IYTAjuWOaP2BamQG8KSv
	 Dgpj6PJc2g/S9QbncWF9k0rJ3842JrVTUJX85EkJusiXBcvPdoMQkfHM/guzo5HR/6
	 GpzW38gULTczercq4/W/zFURfOg/ycDaF4j/OumU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 20:30:36 +0000
Subject: [PATCH net-next 1/3] net/smc: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-netdev-secs-to-jiffies-part-2-v1-1-c484cc63611b@linux.microsoft.com>
References: <20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com>
In-Reply-To: <20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
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
index ca6984541edbda33a3539a48ed7c2aefecfa690e..dd713b8f783024c46f30bf04cbaad898a631f3f4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2730,8 +2730,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
 
 	if (lsmc->sockopt_defer_accept && !(arg->flags & O_NONBLOCK)) {
 		/* wait till data arrives on the socket */
-		timeo = msecs_to_jiffies(lsmc->sockopt_defer_accept *
-								MSEC_PER_SEC);
+		timeo = secs_to_jiffies(lsmc->sockopt_defer_accept);
 		if (smc_sk(nsk)->use_fallback) {
 			struct sock *clcsk = smc_sk(nsk)->clcsock->sk;
 

-- 
2.43.0


