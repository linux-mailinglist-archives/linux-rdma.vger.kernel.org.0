Return-Path: <linux-rdma+bounces-7863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B1A3C9D2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0640416D492
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9ED23DEB6;
	Wed, 19 Feb 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="evARzIu6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32522FAD4;
	Wed, 19 Feb 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997040; cv=none; b=HEvN1M5nGoU2zIcrafYX/phjH4oxyrPRao5LgxVvWG6hz467lEF1vvWYYxqabogNzQ6S3XZa76GtCAMUXpDnjWLL1TTIy0L7slW+hNJxHXecb/aqXVyVu3EXxLUN3LJOPvNPeHUH2dQYsXPDucXn/BK0+DYucWEuB61ExXVqFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997040; c=relaxed/simple;
	bh=VIoB7qiTLaV7Z1JX5PmXLYanxXX/r8BMP27IJazNm84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRe+HUH97gUDtyJ9VXrGtdtPv4tzTu9ZS8wPs+GxR/TYch4p5oSta9VC+i6gJeH2tAKWnpZVEw0BIZaxi4B+wICGrljBVf4u+qBae/oS56+14dLXlzJv+pI0NJwT977BDu5Y1+8mLB+SJq/5AgC9MGaF6zsaYQqsajYalGiezCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=evARzIu6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 396A02043E1E;
	Wed, 19 Feb 2025 12:30:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 396A02043E1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739997038;
	bh=ZQBUkjDtvUw42acvYUgd6vDbgxWPxXM2A3fBzrkCpHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=evARzIu6/NX/9bIBI2sfnXYCdJ1nGvbU+dT6yPCQ1yzeubqxOcOD7XP2biSMadmZB
	 a59SM5gvupbfOizLJ+pP03crueVpvNWGnnKSCZ8vz6RoeICb4Rsb0zMD5kVAlJlxkK
	 7OmgwKLxyHF6cJsFvZHGR3MAVoedH7OLKzcKMQ9s=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 20:30:38 +0000
Subject: [PATCH net-next 3/3] net: ipconfig: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-netdev-secs-to-jiffies-part-2-v1-3-c484cc63611b@linux.microsoft.com>
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

While here, manually convert a couple timeouts denominated in seconds

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/ipv4/ipconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d771e9275bb66c159d9abb330bdf4c..22a7889876c1cf7d5233fe8a0ee12e134b20c1cd 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -274,9 +274,9 @@ static int __init ic_open_devs(void)
 
 	/* wait for a carrier on at least one device */
 	start = jiffies;
-	next_msg = start + msecs_to_jiffies(20000);
+	next_msg = start + secs_to_jiffies(20);
 	while (time_before(jiffies, start +
-			   msecs_to_jiffies(carrier_timeout * 1000))) {
+			   secs_to_jiffies(carrier_timeout))) {
 		int wait, elapsed;
 
 		rtnl_lock();
@@ -295,7 +295,7 @@ static int __init ic_open_devs(void)
 		elapsed = jiffies_to_msecs(jiffies - start);
 		wait = (carrier_timeout * 1000 - elapsed + 500) / 1000;
 		pr_info("Waiting up to %d more seconds for network.\n", wait);
-		next_msg = jiffies + msecs_to_jiffies(20000);
+		next_msg = jiffies + secs_to_jiffies(20);
 	}
 have_carrier:
 

-- 
2.43.0


