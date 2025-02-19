Return-Path: <linux-rdma+bounces-7864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E85AA3C9DB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B45C1737F5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E9241C8F;
	Wed, 19 Feb 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gHI/szIr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721781B393D;
	Wed, 19 Feb 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997040; cv=none; b=pWe8rIxpICRFDjIb6B1QWyTC9BP/lyoy98GQRvSodSsu2D8F4eegZ7fRB5SEJsWv8dftOGlXjQ4WrVqoe0cttmjCvBLueWMXKJA4X3soUwmP+yLhgxkMmDylALdd6pMYEEPLySfbqnLLw2jbP5Y55RAQwAxEsT35lXVlK64lyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997040; c=relaxed/simple;
	bh=DQPWMVuUQIr0IxHiIYQ/n4uOkjrc8H0ifaBmg6YK+gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZgD/fqwA4IPLI6S9j5oY7jnG+qMu0x4vWY6CJSuBbU+RYQUdj43Gq6UR3a0djKVP1xWC+5ivcU5KvPVHLO4/4RIwRtqDLzdCj7/Kl3CWfS3fsFeyC1v9hlHjoSP5fbcy1lIUsZy7vlLtcx+aOpRdxF2Zg6wYF8E3ujGkARIsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gHI/szIr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1CAA02043E1D;
	Wed, 19 Feb 2025 12:30:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CAA02043E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739997038;
	bh=90UV+JP+XbwbcCJgflCYjTDRG9AqL4zRGYQK3ZIz7DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gHI/szIreKPPS8CxgVZkOrmds1yXBXX+RfhyiAWEF7PcU8TVQ0OV06loHmtB3AUfI
	 58ImeFrYtjThwlYVfIYTdDyP5hnERUBNdU7qo7iuGhbT+d3WAuLF2z7gsLiCHbK/jt
	 twqPKca7sGyepZzdk8+yUGqjwgkcEGptijcqgwI4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 20:30:37 +0000
Subject: [PATCH net-next 2/3] netfilter: xt_IDLETIMER: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-netdev-secs-to-jiffies-part-2-v1-2-c484cc63611b@linux.microsoft.com>
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
 net/netfilter/xt_IDLETIMER.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 9f54819eb52ca28a6ef6544249e864f17ca3de7a..9082155ee558933c640f51f1a6fec8ccdc1f0fa2 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -168,7 +168,7 @@ static int idletimer_tg_create(struct idletimer_tg_info *info)
 	INIT_WORK(&info->timer->work, idletimer_tg_work);
 
 	mod_timer(&info->timer->timer,
-		  msecs_to_jiffies(info->timeout * 1000) + jiffies);
+		  secs_to_jiffies(info->timeout) + jiffies);
 
 	return 0;
 
@@ -229,7 +229,7 @@ static int idletimer_tg_create_v1(struct idletimer_tg_info_v1 *info)
 	} else {
 		timer_setup(&info->timer->timer, idletimer_tg_expired, 0);
 		mod_timer(&info->timer->timer,
-				msecs_to_jiffies(info->timeout * 1000) + jiffies);
+				secs_to_jiffies(info->timeout) + jiffies);
 	}
 
 	return 0;
@@ -254,7 +254,7 @@ static unsigned int idletimer_tg_target(struct sk_buff *skb,
 		 info->label, info->timeout);
 
 	mod_timer(&info->timer->timer,
-		  msecs_to_jiffies(info->timeout * 1000) + jiffies);
+		  secs_to_jiffies(info->timeout) + jiffies);
 
 	return XT_CONTINUE;
 }
@@ -275,7 +275,7 @@ static unsigned int idletimer_tg_target_v1(struct sk_buff *skb,
 		alarm_start_relative(&info->timer->alarm, tout);
 	} else {
 		mod_timer(&info->timer->timer,
-				msecs_to_jiffies(info->timeout * 1000) + jiffies);
+				secs_to_jiffies(info->timeout) + jiffies);
 	}
 
 	return XT_CONTINUE;
@@ -320,7 +320,7 @@ static int idletimer_tg_checkentry(const struct xt_tgchk_param *par)
 	if (info->timer) {
 		info->timer->refcnt++;
 		mod_timer(&info->timer->timer,
-			  msecs_to_jiffies(info->timeout * 1000) + jiffies);
+			  secs_to_jiffies(info->timeout) + jiffies);
 
 		pr_debug("increased refcnt of timer %s to %u\n",
 			 info->label, info->timer->refcnt);
@@ -382,7 +382,7 @@ static int idletimer_tg_checkentry_v1(const struct xt_tgchk_param *par)
 			}
 		} else {
 				mod_timer(&info->timer->timer,
-					msecs_to_jiffies(info->timeout * 1000) + jiffies);
+					secs_to_jiffies(info->timeout) + jiffies);
 		}
 		pr_debug("increased refcnt of timer %s to %u\n",
 			 info->label, info->timer->refcnt);

-- 
2.43.0


