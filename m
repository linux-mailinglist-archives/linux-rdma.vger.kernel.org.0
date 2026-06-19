Return-Path: <linux-rdma+bounces-22377-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aIOmDIdaNWo2twYAu9opvQ
	(envelope-from <linux-rdma+bounces-22377-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 17:04:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC56A691F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 17:04:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=icaPiIDi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22377-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22377-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D77304A8C0
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B23B14C9;
	Fri, 19 Jun 2026 15:03:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE108282F2E
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2026 15:03:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881438; cv=none; b=aXjq02t2OyD2grghnMcb967MaygL/oJZjNV76U+/Iiw8NYHOU1l8Sfd0paJUCNkQUh0ijLxmoGScjA+Ltl1F/iWM3jCrOd9Gs40SOtACyiXNYKdQP6eGqCEZ/MrpIzm/z5aOnN+IfAQ82QRrFNj6IuavktNlrOIwJRzDQusTHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881438; c=relaxed/simple;
	bh=n0TaIFU2dlUiY6Vzb+eElnBvXKO/Y+F2CeNOmOSDEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vhk9plD3nVXHP8IYKD4z/fGN/gtBQMvTSk8ZhgUDTrqX/q07zlvyKjoBzmDhfWXGP6QIgHaor3ynSb1p6TD771apb4Vk6JNs1vTquhfHDgO2BLsCFfYnHWdanfRPu73/fHZXuokApZrcZIrt3JXW30VjG+xlLHhwvD8aQ5Y5yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icaPiIDi; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84347ad88edso1857392b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881436; x=1782486236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=icaPiIDia+iWmEFhB2Z748fn+YVVv6PPRnGMgZMay8iUtTkG7gu1SsqMAw7Skq6vFo
         Aij2rIUYIY5Ft41A0gg2hN0XapAOQGCSm18cZOvew193TwvFWFpbVnPph7wBqub0Q2p4
         Scy1nT3lyVvtRb3bVrddCUwlYbM8K+sT1hdyLtpsjHi/70Ro9zaP3T4AVhhtny0DTdnC
         67LXG+zPFF4ZGoP4zz+3V3M0gFWkKlmdRfKif61AeWvLVLkpgXokbEN6zejedbmUlcoU
         wcBQKVfRezT3RJV52pp/0ptJ6lzVx8rxxSpJssrV7K+G2OpIDj6uYs4sjJPd+Mxa1Gt4
         nlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881436; x=1782486236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=sYebNz7tSQv+lc3dp2pHnunMbxQmgm39pdK8bSSl3hA07I+d/n7u7M1ZYZ9Fe00iLW
         tBK65YCKfiGSf0o8rq+wE6l6JMV7a+35bK/rVTocds3sTVCh7H7SaC8yXF5Bd2aGDnAm
         8GfBWZo41l4RuuKQ7EcRXP2sJGaPu6qo4DTKV1XBtd3j6iUkMYquWUdfyGtsgI1hAjeq
         rRhUQhr37tXsgkM00xeTjFk2lP/E2GNayUEQ+PEmFlnU34OJlD6L17ypMRaIJsjVj4KW
         sazutiSH7ZSjlKYbItIQq0EW/rhRDT3lHWfSIMDINGjr0+uf3m8CgHQ3a+wS1dmXudeL
         C8Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+X07t4w+a5PJgCdfXipcb6np+vZm14ee/l5jWKQp5SnrH4E7Fg90MbA++FwMxylQYC2jt6IbJs3TtL@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcoYjoKEGun/WnAp1N8emvGGsaLya5FuLrf3OKabpBfYS3QK7
	TEVd4HGDMjDYK1PYaJtVVASrsi/2bGfMMWMvG5VCLZkl76pqvBKpOLhV
X-Gm-Gg: AfdE7ck1DVpkjGmaxzYuyLn7iSYlMbql9ZrpBa29+8lEKiGNqed7mRUWyRpehYYBiGG
	cgerX+ju/9U9PYS+FrM0ZpUZL85sBAgFO8mMdcwBqDXTWm4j0ANC26mH2HxVqwoLH3LfBoTfb/Q
	UxPblaiTx34kkcO9z2nokj3zKlWoIUU1oAvSpAX+OWtQjDnyOFHieczwRcjM1sln+xcYnEbkGWQ
	L8KVNB9bVs6s1JNIrJ6hx9FQqTSflgRDXQuiKw0RAfREGv4c9tg/a/h7DYVMGJ2M36rdKAifVWe
	Uy2u3V8n5WyUIaALABu3DEAiL/5vMgZApf7QB/IUa7touH09L/wCWUIQcbW9UNyK8cQxQ/EE2DI
	I8JPThdARhz57O6NGl10kdRssdJ5y1OmhUtnIr6I57YBXUZ40H55wkjTAfC7pDL9YlCzY7YU8l1
	KFGekuekkpVdoOFcUzj6cTvEOsiZVLA/vDZCHJnGANmYrL70ZePMQ=
X-Received: by 2002:aa7:8882:0:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-8455078a5a4mr4177673b3a.4.1781881435832;
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455366ec53sm2844747b3a.13.2026.06.19.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
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
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock
Date: Fri, 19 Jun 2026 15:03:41 +0000
Message-ID: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22377-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EACC56A691F

SMC stores its smc_sock in the clcsock's sk_user_data tagged
SK_USER_DATA_NOCOPY and reads it back with smc_clcsock_user_data(), which
only strips that flag. sockmap stores a sk_psock in the same field tagged
SK_USER_DATA_NOCOPY | SK_USER_DATA_PSOCK. Nothing keeps both off one
socket, and SMC then casts the sk_psock to an smc_sock.

A passive-open child hits this. It inherits the listener's
smc_clcsock_data_ready(), but sk_clone_lock() clears its NOCOPY
sk_user_data, and a BPF sock_ops program then adds the child to a sockmap,
installing a sk_psock in that field. The inherited callback reads it as an
smc_sock and dereferences a clcsk_* pointer past the end of the sk_psock:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   [...]
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   [...]

sk_psock() already guards the other side, returning NULL unless
SK_USER_DATA_PSOCK is set. Make smc_clcsock_user_data() and its RCU
variant return the smc_sock only when sk_user_data carries SMC's tag
alone. A sk_psock then reads back as NULL, which the data_ready and
fallback callbacks already handle.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/smc.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..88dfb459b7cc 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -342,13 +342,25 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 
 static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
 {
-	return (struct smc_sock *)
-	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
+	uintptr_t data = (uintptr_t)clcsk->sk_user_data;
+
+	/*
+	 * Return the smc_sock only if the slot carries SMC's tag alone.
+	 * sockmap stores a sk_psock here tagged SK_USER_DATA_PSOCK; it is
+	 * not an smc_sock and must not be dereferenced as one.
+	 */
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
 {
-	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
+	uintptr_t data = (uintptr_t)rcu_dereference(__sk_user_data(clcsk));
+
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
-- 
2.43.0


