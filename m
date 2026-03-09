Return-Path: <linux-rdma+bounces-17744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC9JDcgyrmlrAQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 03:39:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC9233551
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 03:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22DB43008C1B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 02:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB226158B;
	Mon,  9 Mar 2026 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QXmFAL62"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BF23536B
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023941; cv=none; b=lcqE1DjY/rUS5txMmBha5yQaIiYDq88STTz+kDNj0LtOz4+6im7jIFMxUIctKRhTZVk0c3MZ7x/MrQl4AdI64jP0iP/93aFyBnX57IYQ/XZrGKNz79iSKWzWvAnEGPFNPs/Ga0W8t6p2NHhw1CSd5qp4UCAsD2epctPuAcOK7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023941; c=relaxed/simple;
	bh=R0H4l0OMlNt9Wqb5hw2JLkc44oTi8bqWgi1LpA+2eDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7StO8OBwWnooREYynz2AZPeA9zLqvcY0WBGcBjTtN5/84No7Y6OQD8kx5QvBv2NDirg86DNs+kmFNFxug32fPBizRKkfChPeIAxqIrPuLrAN/7LRZx1/IAla1VaArCfW5Z6gPnuBWu+To/kJHokr11AMJNauIzVLN5gieR3PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QXmFAL62; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773023937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gg9IZVa6miFgcHKiCXdTEoQFBVABLtKoIAlpWTSHRw=;
	b=QXmFAL62fOnI4PpkKzO2aVQsyInz5lwCndRU3ORHtiIXmmXRCIhongHsqj0Vz17TiZ8Rrh
	jbXFFaF3/FuSJqo5ZNBRj2JZvyjqxdvDkUGalxEUUMAVUdDefdo0DtcjZr0p2SGXedmxi2
	dWunQ4yM79aW41mFtGsFqPFExB542WE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
Date: Mon,  9 Mar 2026 10:38:45 +0800
Message-ID: <20260309023846.18516-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C9AC9233551
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17744-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].

smc_tcp_syn_recv_sock() is called in the TCP receive path
(softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
listening socket). It reads sk_user_data to get the smc_sock
pointer. However, when the SMC listen socket is being closed
concurrently, smc_close_active() sets clcsock->sk_user_data
to NULL under sk_callback_lock, and then the smc_sock itself
can be freed via sock_put() in smc_release().

This leads to two issues:

1) NULL pointer dereference: sk_user_data is NULL when
   accessed.
2) Use-after-free: sk_user_data is read as non-NULL, but the
   smc_sock is freed before its fields (e.g., queued_smc_hs,
   ori_af_ops) are accessed.

The race window looks like this:

  CPU A (softirq)              CPU B (process ctx)

  tcp_v4_rcv()
    TCP_NEW_SYN_RECV:
    sk = req->rsk_listener
    sock_hold(sk)
    /* No lock on listener */
                               smc_close_active():
                                 write_lock_bh(cb_lock)
                                 sk_user_data = NULL
                                 write_unlock_bh(cb_lock)
                                 ...
                                 smc_clcsock_release()
                                 sock_put(smc->sk) x2
                                   -> smc_sock freed!
    tcp_check_req()
      smc_tcp_syn_recv_sock():
        smc = user_data(sk)
          -> NULL or dangling
        smc->queued_smc_hs
          -> crash!

Note that the clcsock and smc_sock are two independent objects
with separate refcounts. TCP stack holds a reference on the
clcsock, which keeps it alive, but this does NOT prevent the
smc_sock from being freed.

Fix this by using RCU and refcount_inc_not_zero() to safely
access smc_sock. Since smc_tcp_syn_recv_sock() is called in
the TCP three-way handshake path, taking read_lock_bh on
sk_callback_lock is too heavy and would not survive a SYN
flood attack. Using rcu_read_lock() is much more lightweight.

- Set SOCK_RCU_FREE on the SMC listen socket so that
  smc_sock freeing is deferred until after the RCU grace
  period. This guarantees the memory is still valid when
  accessed inside rcu_read_lock().
- Use rcu_read_lock() to protect reading sk_user_data.
- Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
  smc_sock. If the refcount has already reached zero (close
  path completed), it returns false and we bail out safely.

Note: smc_hs_congested() has a similar lockless read of
sk_user_data without rcu_read_lock(), but it only checks for
NULL and accesses the global smc_hs_wq, never dereferencing
any smc_sock field, so it is not affected.

Reproducer was verified with mdelay injection and smc_run,
the issue no longer occurs with this patch applied.

[1] https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@google.com/T/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2:
- Use rcu_read_lock() + refcount_inc_not_zero() instead of
  read_lock_bh(sk_callback_lock) + sock_hold(), since this
  is the TCP handshake hot path and read_lock_bh is too
  expensive under SYN flood.
- Set SOCK_RCU_FREE on SMC listen socket to ensure
  RCU-deferred freeing.

v1: https://lore.kernel.org/netdev/20260307032158.372165-1-jiayuan.chen@linux.dev/
---
 net/smc/af_smc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..72ac1d8c62d4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct smc_sock *smc;
 	struct sock *child;
 
+	rcu_read_lock();
 	smc = smc_clcsock_user_data(sk);
+	if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	rcu_read_unlock();
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
@@ -153,11 +159,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
 	}
+	sock_put(&smc->sk);
 	return child;
 
 drop:
 	dst_release(dst);
 	tcp_listendrop(sk);
+	sock_put(&smc->sk);
 	return NULL;
 }
 
@@ -2691,6 +2699,7 @@ int smc_listen(struct socket *sock, int backlog)
 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 		goto out;
 	}
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = SMC_LISTEN;
-- 
2.43.0


