Return-Path: <linux-rdma+bounces-19493-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF5XJjP26WnkpwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19493-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:36:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03B450CBE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830F93038ADA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1A8378D8C;
	Thu, 23 Apr 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc6F7Y6f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB337CD59
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940189; cv=none; b=G7pXXLgXTsClF7Q2K8S8+ZJkwALozUbIVxEEER+3DIruV4pTHKZ/2Wio2UOIq6zqhMTR7+CDZuoDfxGUjXhI0Evo+YWuePxrqnTEXk+kaXeINs3IiWBe+m+J4rrHoSbf6lV6KoEtnVBCVSspux3vx/AZhkAg8swOtXQzBmzGHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940189; c=relaxed/simple;
	bh=i2CfFYtrls5Mfh8jl9B0Dx35/AVjhbDxUMTHf/x0+zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1obJOcl/xI7ZmqJUHnJCrr1FgSeJnseStXGY+V9BQFetgUpmTOGF/dYjn0Jc9OIMK1wK1pnKUhK9Y95qKH2WJQLxN8tKmbIA6eJ3/cY886Ha3o6TV/09SjS7qGUCXjFAi1hVMcgXQpppwiDzUn6P6/1qLaDU00Tnei1coK1zNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc6F7Y6f; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c19d23b19so8320054c88.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776940187; x=1777544987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8w5fOH/PqUx6ePD5lx3kpu9r4IZp2v338rhXTGbYE+Q=;
        b=mc6F7Y6fMbWJOM7Yu7S0nk0nfT0lpP6fLxCPyuwsAE+x7vKOF3SrrbUn5sSOSKn3zW
         ZKYsdN+69hzRbw7T2RXbYa5YUU4Dj2DOoPeL7dMxevEYkv2CV2hvzdhbXHA8W37m+H8J
         Z7Cm0NdF8BvGvLNyd1gh5PxzdUI/Fv+FLjm1bdD4cUiq45zQDcM8ncqrM9gcdNCeSKpT
         qc2DXZc5WkFf/e3sLakBTLdHBGBx0InAcVfBbesaT/d61kWVv6ALt2WDtSvtnSlVw0Vh
         YSJpGB3uZOJpSuJxSfj7JDS0IWwyLKC59PHRLaBPQY+XkNiTVf0/P2q5TEw09/rzEQIw
         hPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776940187; x=1777544987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w5fOH/PqUx6ePD5lx3kpu9r4IZp2v338rhXTGbYE+Q=;
        b=RLP1aFsqq7dTqGdEWEKbRCesJFp5X8A3hdrq2E1bl6AEdk0ujyk/3x0lPXJXYApBH4
         BthSMRlHhrIddFEj8F/NBXcP8f28xxoJ/EesuAQT4oevkoPf12fT8B9gttYbZkAkt0zS
         8MZuARyYTB6FdXwMLSCMrMR3Ky+E4eFzZS7raxRz4moWvq+WeNYOGbiGBNh6QxwY1dph
         5wEq2OoUMkvGN3/PVVVwNk4WCJ2ZNHJv7qKhZ5oJ+jpcb3AZ+dzrchZv1YwusSvAZ6Bk
         ggGKENzKCqYHpXQKkNufnKWLlfeTo8tS9dsamJo5OkCHne/PHs/hK0l7gSPrMyJ532Cg
         rp5A==
X-Forwarded-Encrypted: i=1; AFNElJ9DbwSGCJ9VdKOIqjnr1CCdHZARZd/GAPydmK46u7EKWevh8NoL2BiOXdwOtLtR1d2nmQZOOp/IOJwI@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiWXOmShR5UF5p6oGVtz1eHnqQ41LF9UCnwXwKp/fTQPTPqVf
	x84qvuyroLgN4gf0ysymSpYjOdteqZsLwZmCC1MYysMyZ+nYBWv6cd+n
X-Gm-Gg: AeBDies3d0iymwlaza4CX1KqzUGwMs/7wZiWdCrCOdoAWwMtMmnjiCEX5Taw09q8Uwg
	mLtvPCZVvOBiT6gx5G+yZGelLLX8eEs/qDwKRrFgHQ2nFJZbc18HefgB8yxO+4U9nviZmiaVank
	J9D2Uj8PNjUccLNrqp9aGizyqxmRfq5a1RiUo1+7bsh2C/ZajiYyYDddb1G0GZO0OUvVkUnoVip
	m1eJYJIw+wC2zQFfsFI/kkejFvMo/ww/DvylYD6fAGxYnD5Vyic/lx94mhfuzaslVizjMXlciPy
	ksBPbIZeObJwvLAw6yFkoW3NxUAzaIXzqF2L037hrePTesafb72JCKVnLFELxW6ZJxLYLtQl78K
	DRydTnzIX3Z45R8C8ZxaNTQGJHOiymo4fInugNVays5b3gQ4u2BAMSaCfm+Y0PY3SmHjbLxdXFg
	ZiUXhSkatjA20ilwAIJJDMd3PBPUhkcZ+XP4LB+X2vH32jdJib3+cDxQHCP0+kiuSlE4o21vYm+
	24JJ3m97/HL+FciEKnX
X-Received: by 2002:a05:7022:10c:b0:12c:61fe:fb49 with SMTP id a92af1059eb24-12c73f6ded9mr14785443c88.6.1776940186680;
        Thu, 23 Apr 2026 03:29:46 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ab8b89csm27223984eec.12.2026.04.23.03.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:29:46 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] net/smc: fix NULL pointer dereference in smc_clc_wait_msg()
Date: Thu, 23 Apr 2026 03:02:07 -0700
Message-ID: <20260423100205.1093987-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19493-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux.alibaba.com,kernel.org,linux.vnet.ibm.com,vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.944];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: DD03B450CBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In smc_listen_work(), smc_clc_wait_msg() is called to wait for a CLC
PROPOSAL message before any link group has been created, so
smc->conn.lgr is still NULL at this point. smc_clc_wait_msg() also
accepts CLC DECLINE messages regardless of the expected type. When a
DECLINE with SMC_FIRST_CONTACT_MASK set in hdr.typev2 arrives, the code
unconditionally dereferences smc->conn.lgr to set sync_err, causing a
NULL pointer dereference.

KASAN reported a null-ptr-deref in smc_clc_wait_msg():

 Oops: general protection fault, 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000310-0x0000000000000317]
 RIP: 0010:smc_clc_wait_msg (net/smc/smc_clc.c:793)
 Call Trace:
  <TASK>
  smc_listen_work (net/smc/af_smc.c:2491)
  process_one_work (kernel/workqueue.c:3281)
  worker_thread (kernel/workqueue.c:3440)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:164)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Add a NULL check for smc->conn.lgr before dereferencing it. 

Fixes: 0cfdd8f92cac ("smc: connection and link group creation")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/smc/smc_clc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index c38fc7bf0a7e..d22c9417d239 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -790,8 +790,10 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
 		if (((struct smc_clc_msg_decline *)buf)->hdr.typev2 &
 						SMC_FIRST_CONTACT_MASK) {
-			smc->conn.lgr->sync_err = 1;
-			smc_lgr_terminate_sched(smc->conn.lgr);
+			if (smc->conn.lgr) {
+				smc->conn.lgr->sync_err = 1;
+				smc_lgr_terminate_sched(smc->conn.lgr);
+			}
 		}
 	}
 
-- 
2.43.0


