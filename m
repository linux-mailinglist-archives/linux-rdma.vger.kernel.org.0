Return-Path: <linux-rdma+bounces-22323-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZVPKjHBMmqB5AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22323-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 17:45:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0413B69B1CB
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 17:45:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=cWjoZHjJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22323-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22323-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8BF326667C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445F248AE0B;
	Wed, 17 Jun 2026 15:29:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m83193.xmail.ntesmail.com (mail-m83193.xmail.ntesmail.com [156.224.83.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5748AE06;
	Wed, 17 Jun 2026 15:29:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710163; cv=none; b=B+XfRDi+YNBZwWme6owNpTOA1yp3A5RWaTbXN2GQi6V9CRQyrLbFmRWZ70K0pmX55TjAg2MAvW6yHQ0detCfTzFiaYknP7PsHJ6vfkDX4BzA4mtYuYVaZJlhCeR/bqeB8awbS4ARoL13D+nFCFM4FHnmJ9D9Bz81p1Af/Z4EqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710163; c=relaxed/simple;
	bh=kwmBT4nlb7xVQUXAzhMyhS0dyDCrP8EroEcr4VEcUHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tr72B2aa+V0AgeO+x50tMPjutT4l0CqrsKpEsI07QlPBnDSMzA4X8lTcjK6Kp1CvYkyyAT6xakI2xRCMH9zew2Mm2efB0vO97O3Jj+TZXits/VBnQuO93c92ab0FJjPNp9M0TiUodXvvUJxY/o+vemVPH5sMcfXLSmIrchtZrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cWjoZHjJ; arc=none smtp.client-ip=156.224.83.193
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42c703f2d;
	Wed, 17 Jun 2026 23:29:04 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: avoid recursive sk_callback_lock in listen data_ready
Date: Wed, 17 Jun 2026 23:28:55 +0800
Message-Id: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed633453d03a1kunm157301bb72f1b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0MeVhhNGEgeTU5JGU5DGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=cWjoZHjJZsgwMC8U+BcHZI9LO51sXKUkUPkOKBMogisrVHRqcwEuwt10tnF2WshNirD57HqR1FoKd/eVhnGznFf28BI6oktfN/WIRG4TybMGPxlz+XBEqtqIXx1Z+VS/TzhdzFoK7PyDVC6v33KfxYEDkB+HmrgHdRnyDeMd/xc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=rMc5Y78GK3F3OqxRtJU+Ti2byo39bkwyB99aa0f2KMs=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22323-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0413B69B1CB

smc_listen() installs smc_clcsock_data_ready() as the underlying TCP
listen socket's sk_data_ready callback.  smc_clcsock_data_ready() then
immediately takes sk_callback_lock before looking up the SMC listener and
queuing smc_tcp_listen_work().

That is unsafe once the TCP listen socket is leaving TCP_LISTEN.  The TCP
close/flush path can run the installed sk_data_ready callback with
sk_callback_lock already held, so entering smc_clcsock_data_ready() again
tries to take the same rwlock recursively in the same thread.  The nvmet
TCP listener had to make the same state check before taking
sk_callback_lock for this reason.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the SMC listen callback installation path:

  smc_listen()
  smc_clcsock_replace_cb()
  sk_data_ready = smc_clcsock_data_ready()

It then modeled the close/flush carrier that invokes the installed
sk_data_ready callback while sk_callback_lock is already held.  Lockdep
reported the same-thread recursive acquisition:

  WARNING: possible recursive locking detected
  smc_clcsock_data_ready+0xa/0x4d [vuln_msv]
  smc_close_flush_work+0x1f/0x30 [vuln_msv]
  *** DEADLOCK ***

Return before taking sk_callback_lock when the underlying TCP socket is no
longer in TCP_LISTEN.  In that state there is no listen accept work to
queue for SMC, and avoiding the callback lock mirrors the fix used by the
TCP nvmet listener.

Fixes: 0558226cebee ("net/smc: Fix slab-out-of-bounds issue in fallback")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/smc/af_smc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6421c2e1c84d..1af4e3c333ff 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2631,6 +2631,9 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
 {
 	struct smc_sock *lsmc;
 
+	if (READ_ONCE(listen_clcsock->sk_state) != TCP_LISTEN)
+		return;
+
 	read_lock_bh(&listen_clcsock->sk_callback_lock);
 	lsmc = smc_clcsock_user_data(listen_clcsock);
 	if (!lsmc)
-- 
2.34.1


