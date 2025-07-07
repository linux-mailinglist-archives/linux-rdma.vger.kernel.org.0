Return-Path: <linux-rdma+bounces-11945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2BFAFBE17
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 00:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC361884151
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A22951CB;
	Mon,  7 Jul 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iUJy5S40"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A328BAB9;
	Mon,  7 Jul 2025 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925824; cv=none; b=S9dmOj+61dR/iEG0XycSbr+GasP2RcvcPkQlu1EnmmbMaScIsdTjghTaaxwZtFG/ftw2FKYb1h1Sa4GXSeW+5PHjuXb5C81yDGNLqzGjld+IEohhVLZ9hkMxtLUT3TCxeGEhXsewP+eKBYazPTArdHpyTFMDZjslnAXGCZAQ/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925824; c=relaxed/simple;
	bh=VIoB7qiTLaV7Z1JX5PmXLYanxXX/r8BMP27IJazNm84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0JkALTgE9JtJo4+zsayPQEDgE7IERPaKn+L7esIgeRbGUTDiZ/in83m8PO8EhYCfJxJDevmgJIcEX0QU9QAVfeXMYiRYfslU9y6H1T2s4NmGJctYTeGRVfCHCYsDqUnALxmoxw/A/BXUTnGh+ZVHO1JjXl9KPYvcY8xZzlunIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iUJy5S40; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from easwarh-mobl2. (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80DEF2054689;
	Mon,  7 Jul 2025 15:03:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80DEF2054689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751925823;
	bh=ZQBUkjDtvUw42acvYUgd6vDbgxWPxXM2A3fBzrkCpHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iUJy5S402vW9QcG4yGSfhRWs8qDBqFXFp3IkaUFVFzW5hQOyEWnpgi4tW1UbfLlj+
	 +boa03gPqNmBv5uvN7aWJNvIaDZLz9Hv1+CzGVEk89Jxl+duextke1Xz8uKTQbZ1HS
	 8foQuORd+bKXJB85V9fjNiD+GRWt+jOvD5OqUNV8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 07 Jul 2025 15:03:33 -0700
Subject: [PATCH net-next v2 2/2] net: ipconfig: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-netdev-secs-to-jiffies-part-2-v2-2-b7817036342f@linux.microsoft.com>
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


