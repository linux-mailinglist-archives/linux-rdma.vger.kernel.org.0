Return-Path: <linux-rdma+bounces-20310-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH+zC/mzAGohLwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20310-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:36:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F1505220
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862E430191BF
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519A3B27DB;
	Sun, 10 May 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byym8Uok"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B335AC1E
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430929; cv=none; b=MvSUkx08E7sk/k7Yd8tByL0G8pQnqxwZsviL3Ri8R5ErwL/Bi2gzLhpOCTQdcJpRs0ooqqIlXIDi/2TgZoQUYFG5j98lIzf6GOOD9ATHynYsjf3Esn20dj/EaoxtKZ1pd/ETkTgRwvRkgFqgpilg1jdCyiRyozFCbbUL4mjhwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430929; c=relaxed/simple;
	bh=dD6l8VmKuNQkIv7tvRgwMxIbtAjjBGjAsfRUM+v1bss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUVUrxPIFciuBPMofgTnNuqMqLD8BY5Itixf7Nh+tJOKUnd4Ume5iN2LPDb0+bURZZlwdtY92R4dRcX1955iRz/47E6ct+N/qPpJ8LKvEnc4qLHIxQxF+TBNW70fYU3m5fhO3dytSC11ng2AhgU0u0ZqqwZ30DriMVYW1uMFRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byym8Uok; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so59627085e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778430925; x=1779035725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66E1wRA9xWgEOR2dqWlyPjo6zh/YZ58R9fKD8OAxMUY=;
        b=Byym8UokMGbCigue6+UHQHftxYr4A1Ck8dCM5TM6lCjSw3uQm8fA4UducmVbErqPUd
         v1JvAcihawzU3zCdgZbLkVMM1/Ez/0OHe2/AaKqt5Y6LeYKfjxqD2CtVsQrqOiOApgos
         8hPsNmDq8ByqJ2re1VN//bpUTFteTHa6CDdbl1X7elx3XZuuoItbwx6qhPT3LLm7OpuB
         qrBFoAI2SGdmCKzdqwjlT7FSptud5jn2Wdl7KMbSdsLjeN4A9hzAc5KjpsyWFRpJRgP3
         bMfp73Q/ZzVbSCtJmVZYgbwr5vSK4NLTSurMKWQlMHsP+DKh077e14ZlKWlleUN84ksV
         226w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778430925; x=1779035725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66E1wRA9xWgEOR2dqWlyPjo6zh/YZ58R9fKD8OAxMUY=;
        b=M8riGpomUx6wSeWXFmxQRzht709MjtEuDc7BbqlF0bFW11IzjBDyo0/Wn5w9quBWy+
         fn/hWtEcVd00Fl6fA7ftDgvC0MW+DTA3UV+fAyG4VadTYJemVZoUOn0vPQdrNswQHkwL
         wgVJ2K5e8PD0IsWe1j0tsQwaH9U4jSKDIOyIJfrUe9inLVXMQHctLIXCW8dfkP25cNZ4
         +OcNC2jB24ODPvncrwSC42xS8WQqp/BsHaGEWF4faPJN1+KzkVv1XMN02MdQdQ00+/3H
         izKO7n0XIUxtfbRZmkfV1NNmXskLU982Q2/ier5rp1CLQMAu8JYdzUK+RIzTe6e1lbge
         IeLg==
X-Forwarded-Encrypted: i=1; AFNElJ+WL3Sbe56oBp8pb5fYQ1tj0jIGYv40Q5ew7tFuYuM4vhjXfemTTYh1EkUFTEvvN+fM8l9fm0qzOTK8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9Ecn4j9ztZeHdcDJB47p/2p+fnRW3XmljuMNA/viHs5V+5ij
	aDUnkYBmjSAdhGHTxiuC8CU/83HDwYH1wS3R6dIOjVJ1MO3PKr3oMfQHtE7w8uCvAfY=
X-Gm-Gg: Acq92OH9sf/qtxdl1rMT2Ip0J2UbkU0JoLf47fh7gp88c/wh+fyTlqfb0e5RLK91gO0
	mHpj+NZQT8RcbubvBp2VRwbOuX1J5Z+N7RVcRmc57E58j3WZg/gMlvP8pudvjwoyEO7pv5/vMiL
	tFg5Bs8fQf86to/j7CYlaZjdDT8EbndH7DXa9lwrRTIeQVroI4rwU7Nc9Y4KnAut1zXIxMqutbl
	uIukJrhn/zqTZBCiUvvJodUpajCkFXmctPn0JRdmEF4LaQhw0ThFxIgazBqQ9ISNN3HJIcqnme2
	RHEp928BeiXasXYNOMivtvPUH+OUQNetqu1ECkP4IlZsxVi3qlT5x/853ha+wi8B+b2BkhHBqpd
	RYnSe1iev+5+unRU73SwojKT3FFPA+XzLkXoGiUoYxmO4Za2L7jrQzzQWxj7WzdZFneiSSteN3r
	+8OopLKiGC4WPCJh56Uw8+RNmrzPzGNQSP/EGmul79SSYZYGYixR7TOZ8sPSQ=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr190222805e9.10.1778430924757;
        Sun, 10 May 2026 09:35:24 -0700 (PDT)
Received: from kali (93-41-117-77.ip81.fastwebnet.it. [93.41.117.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba52sm143706015e9.3.2026.05.10.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:35:24 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nicolo.coccia@leonardo.com,
	=?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>
Subject: [PATCH v3] net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS
Date: Sun, 10 May 2026 12:34:13 -0400
Message-ID: <20260510163414.16651-1-n.coccia96@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 862F1505220
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20310-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux.alibaba.com,vger.kernel.org,leonardo.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncoccia96@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")

Signed-off-by: Nicolò Coccia <n.coccia96@gmail.com>
---
 v1 -> v3:
 - Resend via git send-email to fix webmail whitespace corruption
 - Rebased against netdev/net tree
 - Added Fixes tag
 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..da28652f6810 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
 
 	smc = smc_sk(sk);
 
+	/* pre-fetch user data outside the lock */
+	if (optname == SMC_LIMIT_HS) {
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(int)))
+			return -EFAULT;
+	}
+
 	lock_sock(sk);
 	switch (optname) {
 	case SMC_LIMIT_HS:
-		if (optlen < sizeof(int)) {
-			rc = -EINVAL;
-			break;
-		}
-		if (copy_from_sockptr(&val, optval, sizeof(int))) {
-			rc = -EFAULT;
-			break;
-		}
-
 		smc->limit_smc_hs = !!val;
 		rc = 0;
 		break;
-- 
2.53.0


