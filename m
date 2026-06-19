Return-Path: <linux-rdma+bounces-22373-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KtfwCWrZNGr0iQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22373-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 07:53:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D76A4002
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 07:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=c9o4mGhN;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22373-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22373-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F8D53029821
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E29345749;
	Fri, 19 Jun 2026 05:53:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33923438A4;
	Fri, 19 Jun 2026 05:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848420; cv=none; b=Astl9+GYtnTypozooQ3npOzQNxxU77MeLjOadepA5M5x/KION9t99jWrWb5GwU1rxITWcUAhEuYCYDQ3oBmFia8ldk2EeKUM0Zh7ZyF7A0I7vnigbdIcVeFMkVLfjIPOwwl7Poj9ZmeHyRXV7SN7sHIK3jnYMgCbbgk3s3EZpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848420; c=relaxed/simple;
	bh=pwU0m4lyd8j1X2A4VZl6+KScuVNCBF0yEhTZlNEn3+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLBxUg3Vk3lK3SALyhOvjSQMEx9GwAZN6ykFPhyFufQMLCR4uI2KuaeOlvwbaZGo/3ZDO7rmZ0VnusAXK7iHFiw8705LpxI+wlweeby+T2dMsZ+YOxh1FucjuA5j1st1LK6FYJxaKit4Sbvqhl0XjIxntfPQ2xKNZHnY6dyL+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=c9o4mGhN; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42ff5c258;
	Fri, 19 Jun 2026 13:48:20 +0800 (GMT+08:00)
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
Subject: [PATCH net v2] net/smc: avoid recursive sk_callback_lock in listen data_ready
Date: Fri, 19 Jun 2026 13:48:15 +0800
Message-Id: <20260619054815.176764-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ede6c4ccc03a1kunm905fb605c0aad
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0tOVh5CT0saH0xJGEweTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c9o4mGhNnuIp1FH4m4iDWfO8zpzxV8lY6OnmEmhimTACoKeaJ8UmvJsqnqrokI+IvQeveSH8bVWEBwSwlex9k7fhA3Fe2M8y/ylW6xEhO9YQVSbaa8al2E4wshTiiInJdVuHxaQ7NlBoQEaBs8AvU0K9oh2oqARndIOdRP0Zpwg=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=y3r//VB8rHOFLln9YAyOG3ki0d6Mj/h1cPOiZugptRA=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22373-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF2D76A4002

smc_listen() installs smc_clcsock_data_ready() as the underlying TCP
listen socket's sk_data_ready callback.  The callback takes
sk_callback_lock before looking up the SMC listener and queuing
smc_tcp_listen_work().

This can recurse when the underlying TCP listen socket is being closed.
The close/flush path may invoke the installed sk_data_ready callback with
sk_callback_lock already held, so smc_clcsock_data_ready() tries to take
the same rwlock again in the same thread.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.  The reproducer keeps the SMC listen
callback installation path:

  smc_listen()
  smc_clcsock_replace_cb()
  sk_data_ready = smc_clcsock_data_ready()

It then models the close/flush carrier that invokes the installed
sk_data_ready callback while sk_callback_lock is already held.  Lockdep
reports the same-thread recursive acquisition:

  WARNING: possible recursive locking detected
  kworker/u4:3/39 is trying to acquire lock:
    (sk_callback_lock) at smc_clcsock_data_ready+0xa/0x4d

  but task is already holding lock:
    (sk_callback_lock) at smc_close_flush_work+0xc/0x30

  Possible unsafe locking scenario:

        CPU0
        ----
        lock(sk_callback_lock);
        lock(sk_callback_lock);

  *** DEADLOCK ***

  Workqueue: smc_close_wq smc_close_flush_work

  Call Trace:
    dump_stack_lvl
    __lock_acquire
    lock_acquire
    _raw_read_lock_bh
    smc_clcsock_data_ready
    smc_close_flush_work
    process_one_work
    worker_thread
    kthread
    ret_from_fork

The same pattern was fixed for nvmet TCP by checking TCP_LISTEN before
taking sk_callback_lock:

  commit 2fa8961d3a6a ("nvmet-tcp: fixup hang in
  nvmet_tcp_listen_data_ready()")

Do the same for SMC.  smc_clcsock_data_ready() is installed by
smc_listen() on the underlying TCP listen socket and only queues
smc_tcp_listen_work() for the SMC listen/accept path.  Once that socket is
no longer in TCP_LISTEN, there is no listen accept work to queue from this
callback, and avoiding sk_callback_lock also avoids the recursive locking
path.

Fixes: 0558226cebee ("net/smc: Fix slab-out-of-bounds issue in fallback")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Include the fuller Lockdep stack from the grounded reproducer.
- Add the related nvmet TCP fix reference.
- Explain why the TCP_LISTEN check is valid for the SMC listen callback.

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

