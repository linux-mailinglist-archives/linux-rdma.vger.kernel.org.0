Return-Path: <linux-rdma+bounces-17888-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ILPOnhbsGn2iQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17888-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:57:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5925603E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D26E30EB55B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A613D88EE;
	Tue, 10 Mar 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI+Ftvvo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149573D8126
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165282; cv=none; b=t7Yl34aefnarQZHi6tszEzWPDh7n+o2NQbUcQaQfdCeMfk3F+jlhMUjSD/qMzettwomeBp9ImOU/WR88DridjuVN9TAuqbBOr4PCTsw3BLyw3sHO+pS/Dmfg/JOyi9SJhZOF+vfDruKgm+OVtjWG94bvXoWbadLOo3rsdG4MYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165282; c=relaxed/simple;
	bh=tpIcoWuPSsflrFdJ37N7ykid+E9spThfaWn0fNKRhgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfkEPOMU/6C4o1V9Chn6/1aVWijLA85VUX3mI+hN7/Qv6Qg0auUGiXkzKEw/MEH84RZGjSzFoQpb0AhmQj5MboakMBYfrN7gS2jBaMWGLPz5z4AG4HDnvbkGqudVvcw7tmlL3vmh4NaFKPq700QD3uwWXLdBmKsBzlYhXEIZoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI+Ftvvo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79800183233so2403807b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165280; x=1773770080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DX7YX3olkxxd54BvAn1gDzrrUOGFvO/gswDwkhEoMI=;
        b=iI+Ftvvo1Vq6vn0KL8HprpuN7cBPPNq25MlSL3nsmTaoYutg/YmHGkeQK17yZm1iZZ
         OKwTEeSuOg8fQxnDgIFLvci8O67ASlmQ/+dYJdHgoVZElUSIxy1o7AzSgoU/ns1atoeY
         N/OGLdbG/YbE7Lxz5uABfC+1Somo4m4lGpgwjuFVRBCPsiqcc11O8oj7N5B3SHvvDYem
         4z8laTLMITpbYgS9GQ6W7L7JJgCswGHYWioWbk1hrwN7yDmAiclYCHpAXL8eVyvayPuI
         ZEiyHhVIYEFfhOP2UpZ3WJkbIv2JzoO0RHvlRLaCANNXYvghdDt/F9BXtn/ZQLDSmMyT
         E0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165280; x=1773770080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DX7YX3olkxxd54BvAn1gDzrrUOGFvO/gswDwkhEoMI=;
        b=M/LshYE19YlS3f1JEZ9xFYxn/d1eO4VTa25imm+a0JI/eyxvJGyFPUFvyssIgLiPQr
         Bknsm4Y+fPE8Aj5oCzp0XR6xdkk6g4+duNzZMky1PlHKqKXyjijWX8OTE3QpcK+4hpbT
         H99/FKo77i7Fg6vIG6rjOe9CYUFu5pA65VorVjbv8MZN0IJUaCxvG0cAR56YHJFyh51/
         2uU39jkf7wbRWtEwOgxWcXpJ2AFcZ3DaHU3xiv38xZKiaGFz6JfW02uJuX+2sXnUlEhU
         tsyX0xLZL/skoey5fal/nW9VHyX12ckXKe8u1O8aRheC6pMwPXPJCnXwh867sMt2Dzzw
         VbYA==
X-Forwarded-Encrypted: i=1; AJvYcCXK0PhUquNNw0lBbA4aVgDHCkpQj/NKQ7t7c43ZSCeGv70l7bgcAzaP6y+X/b97t+a8OZon1F3NgXOu@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+0C9J9DUiriLK2Urvo5gfUSL+NDobiEYEYmYmklnUemX6ij2
	mTLhz4bGtJ8scrNSGmtSAe46gxmxftEcisFmir5+d3mHVVm5FBZ2Y64L
X-Gm-Gg: ATEYQzyPhwFRRSRzHZhoJRmd5b3bIzME9UagmNikUGKg8cVgfnza74raTShpzhh7sgL
	tPKbJeV1WWhJ623Kx57FM1kX2J40IjwOBSNg5dgIQUPoUm1yNg5+iAuL4Q03JD/WqW2nIUEuqJc
	ogR29mf+wzxYj2q3BSUtR8JNTIgmtnrdhrUIEhIZWeNu4pzQmhioL5FYohN+LyIgijl/BxgR0a3
	Ws1AqPu74a1GUGrLT0Zvv1jzmeDVexMrj5qanRJskBRSuiOaoVm5VO2GMJ9mPd4u0ierhObXc99
	ShPKwmyOwOCnFzi544BM9dLwknjrE8k62SFDsQM2tru94kY3zbMwh5iOms/j0DyroicxCKq3ijU
	5XndJiwReDgxPb/9p0tJ+vCq6ZY4zs4E1WmiZa4nGi9s5m6Lzjj/pKq3QSejvsP8kjxwW6E7tRy
	jN/WCDnbf80O9CDRxjp6aDzZmD36Eu8blCS/K3I/duhmKanLlxtwL20xwh
X-Received: by 2002:a05:690c:6913:b0:798:5bb7:4982 with SMTP id 00721157ae682-7990a86998emr40492057b3.16.1773165280041;
        Tue, 10 Mar 2026 10:54:40 -0700 (PDT)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a676fedsm19799977b3.42.2026.03.10.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:54:39 -0700 (PDT)
From: Mehul Rao <mehulrao@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
Date: Tue, 10 Mar 2026 13:54:26 -0400
Message-ID: <20260310175426.110496-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AEF5925603E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-17888-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

smc_clcsock_user_data() can return NULL when the listening SMC socket is
being torn down concurrently. During close, smc_close_active() sets
sk_user_data to NULL on the underlying CLC socket before shutting it
down. If a TCP SYN completion arrives in this window,
smc_tcp_syn_recv_sock() is called from softirq and dereferences the NULL
pointer when accessing smc->queued_smc_hs.

The sibling function smc_hs_congested() already handles this case by
checking for NULL and returning early. Add the same NULL check to
smc_tcp_syn_recv_sock().

 BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
 Read of size 4 at addr 00000000000006b0 by task poc-F362/154

 CPU: 2 UID: 0 PID: 154 Comm: poc-F362 Not tainted 7.0.0-rc3 #1 PREEMPT(lazy)
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <IRQ>
  dump_stack_lvl (lib/dump_stack.c:122)
  kasan_report (mm/kasan/report.c:597)
  ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/generic.c:200 (discriminator 1))
  smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  tcp_check_req (net/ipv4/tcp_minisocks.c:927)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2245)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
  ip_local_deliver_finish (include/linux/rcupdate.h:883 net/ipv4/ip_input.c:242)
  ip_local_deliver (net/ipv4/ip_input.c:259)
  ip_rcv (net/ipv4/ip_input.c:573)
  __netif_receive_skb_one_core (net/core/dev.c:6164)

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..bb8966eeb332 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct sock *child;
 
 	smc = smc_clcsock_user_data(sk);
+	if (!smc)
+		goto drop;
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
-- 
2.53.0


