Return-Path: <linux-rdma+bounces-20039-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGFlM2ac+mkKQQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20039-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 03:41:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D084D55D5
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 03:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C4A3044B9B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 01:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BD271456;
	Wed,  6 May 2026 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D3Mvyh6v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D22580F3;
	Wed,  6 May 2026 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031681; cv=none; b=LBPYh9j7Ze+B3vxTBpsmuexc3nHoA6a5oq40bA9V0KFovtFK+8Ay9gKhoIZV6GXfC4cV4c6muKSb8Em3dY+je06kU0lG9m9cGHmL2xGZedxgc2lVT4EaiWzCJJikhipT33bekFEOcMee3c+2nkP9klxsdA1vY+LSmTbS1qhCq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031681; c=relaxed/simple;
	bh=pnmZZhAHCFw2R56Un6jB8g3I0UAfHhdY+6q2FWlzRKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnfnZV1EEfcOiIUVo4R65xPRcr9E+D+tPJBy6pODSNnP/WOoTIuoWywsU+Gm155tzizQ7waifFa5FVjx+XosZAkzEIs2rCMtHNJ9VzBqe4ALXa3D4o5nnbVnvkqp5kMJol5Ninigoc7tT+aF4Ddz5vntdhLpeFPADxTBXRqH7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D3Mvyh6v; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778031670; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6yti4GL1+tcD4wNIQaYPwVaTZwBljAcSrHFDH4V+DeY=;
	b=D3Mvyh6vwcKuEPrXbHqqu0NuDiu4+JOMkIP360DjHFdMN/L7RTAGvpuLEFQ2kuDsWZZa6FjwgNmXHcuBj16kTppCGKDXaf8u5E+G1jqxWQRVI25BCdA8byVQ7uSb1pQheCt1rp2j5gIxvgigi4PY9W/Q61xZ8pER+ZZVFNrztDM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X2JDI-l_1778031665;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X2JDI-l_1778031665 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 May 2026 09:41:09 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: [PATCH net] net/smc: fix missing sk_err when TCP handshake fails
Date: Wed,  6 May 2026 09:41:05 +0800
Message-ID: <20260506014105.27093-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36D084D55D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20039-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In smc_connect_work(), when the underlying TCP handshake fails, the error
code (rc) must be propagated to sk_err to ensure userspace can correctly
retrieve the error status via SO_ERROR. Currently, the code only handles
a restricted set of error codes (e.g., EPIPE, ECONNREFUSED). If other
errors occurs, such as EHOSTUNREACH, sk_err remains unset (zero).

This affects applications that rely on SO_ERROR to determine connect
outcome. For example, higher versions of Go's netpoller treats
SO_ERROR == 0 combined with a failed getpeername() as a spurious wakeup
and re-enters epoll_wait(). Under ET mode, no further edge will be
generated since the socket is already in a terminal state, causing the
connect to hang indefinitely or until a user-specified timeout, if one
is set.

Fixes: 50717a37db03 ("net/smc: nonblocking connect rework")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1a565095376a..185dbed7de5d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1628,12 +1628,8 @@ static void smc_connect_work(struct work_struct *work)
 	lock_sock(&smc->sk);
 	if (rc != 0 || smc->sk.sk_err) {
 		smc->sk.sk_state = SMC_CLOSED;
-		if (rc == -EPIPE || rc == -EAGAIN)
-			smc->sk.sk_err = EPIPE;
-		else if (rc == -ECONNREFUSED)
-			smc->sk.sk_err = ECONNREFUSED;
-		else if (signal_pending(current))
-			smc->sk.sk_err = -sock_intr_errno(timeo);
+		if (!smc->sk.sk_err)
+			smc->sk.sk_err = (rc == -EAGAIN) ? EPIPE : -rc;
 		sock_put(&smc->sk); /* passive closing */
 		goto out;
 	}
-- 
2.45.0


