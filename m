Return-Path: <linux-rdma+bounces-17927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIS4LMvSsGmLnQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 03:26:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E825AEEE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 03:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB0F3066E5B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 02:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501F2BEC2C;
	Wed, 11 Mar 2026 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="maR5mh/N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C32D978B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195967; cv=none; b=rGcj+oqnyIr3LLniianOibxDbcr02WOzjhTllt7k8+x+v6/ESmE3oLsEAfZLCrYGrbbIEbnMvTqkRl5QETlM/GxIvxaiJicZNrrMuNSApWkfsJ/+MOkamihLUIq76xMxXYtQ5oAl8/GX9kbXyDSxGMSwS2t93J4jeGCaGH8GNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195967; c=relaxed/simple;
	bh=OovTU4urH1LmHOV36MqoIDVgBgbTOz2YmSyM8tlS5+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPjGp6P4E7houmW8Betm7QZP30BCSHZ2+U7BAmt60bzg2XLTz8ThA3Ahh6/AiocoyZ6j2YH5aHmkRjU3CfNZwWEvYGrmVPV7y2rHvCqpf3ZZ2RAeaRIfx3qA1sjaQNhsON+sGCUsj685do/8/eMoQXQEATbKOwpMbGB1xkYH1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=maR5mh/N; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773195953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7K3lm7FNrZezaEn1W8fr0tU3CFeWHGT9PnaHpEVKSSA=;
	b=maR5mh/NZKBeC4SZbFZ6pVqCmKZnMUFJe7I1MiErEirDPPZx2Emxw8bsWeVKy6qLvQ9IIq
	ANGdIWwHQOQsqp4+DRuZAnqx4IeiP2Yv5CibG+2GVI8EZYwQeW/Xuu5AQ/tGM1lA1phPiF
	YeqPjb8dwtztR2c4ou3F+vYUAfoeyYY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
Subject: [PATCH net v4] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
Date: Wed, 11 Mar 2026 10:24:49 +0800
Message-ID: <20260311022451.395802-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 195E825AEEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-17927-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

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
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
v4:
- Add a new smc_clcsock_user_data_rcu() helper instead of
  modifying the existing smc_clcsock_user_data(), to allow
  gradual conversion of callers. Only smc_tcp_syn_recv_sock()
  uses the RCU variant; other callers under sk_callback_lock
  remain unchanged, avoiding lockdep warnings.
- Use rcu_dereference_sk_user_data() for reading and
  rcu_assign_sk_user_data() for writing sk_user_data to
  prevent load/store tearing.

v3: https://lore.kernel.org/netdev/20260310120053.136594-1-jiayuan.chen@linux.dev/

v3:
- Write sk_user_data with RCU to prevent store tearing.

v2: https://lore.kernel.org/netdev/20260309023846.18516-1-jiayuan.chen@linux.dev/

v2:
- Use rcu_read_lock() + refcount_inc_not_zero() instead of
  read_lock_bh(sk_callback_lock) + sock_hold(), since this
  is the TCP handshake hot path and read_lock_bh is too
  expensive under SYN flood.
- Set SOCK_RCU_FREE on SMC listen socket to ensure
  RCU-deferred freeing.

v1: https://lore.kernel.org/netdev/20260307032158.372165-1-jiayuan.chen@linux.dev/
---
 net/smc/af_smc.c    | 21 +++++++++++++++------
 net/smc/smc.h       |  5 +++++
 net/smc/smc_close.c |  2 +-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..808a107d3354 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct smc_sock *smc;
 	struct sock *child;
 
-	smc = smc_clcsock_user_data(sk);
+	rcu_read_lock();
+	smc = smc_clcsock_user_data_rcu(sk);
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
 
@@ -254,7 +262,7 @@ static void smc_fback_restore_callbacks(struct smc_sock *smc)
 	struct sock *clcsk = smc->clcsock->sk;
 
 	write_lock_bh(&clcsk->sk_callback_lock);
-	clcsk->sk_user_data = NULL;
+	rcu_assign_sk_user_data(clcsk, NULL);
 
 	smc_clcsock_restore_cb(&clcsk->sk_state_change, &smc->clcsk_state_change);
 	smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
@@ -902,7 +910,7 @@ static void smc_fback_replace_callbacks(struct smc_sock *smc)
 	struct sock *clcsk = smc->clcsock->sk;
 
 	write_lock_bh(&clcsk->sk_callback_lock);
-	clcsk->sk_user_data = (void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
+	__rcu_assign_sk_user_data_with_flags(clcsk, smc, SK_USER_DATA_NOCOPY);
 
 	smc_clcsock_replace_cb(&clcsk->sk_state_change, smc_fback_state_change,
 			       &smc->clcsk_state_change);
@@ -2665,8 +2673,8 @@ int smc_listen(struct socket *sock, int backlog)
 	 * smc-specific sk_data_ready function
 	 */
 	write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
-	smc->clcsock->sk->sk_user_data =
-		(void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
+	__rcu_assign_sk_user_data_with_flags(smc->clcsock->sk, smc,
+					     SK_USER_DATA_NOCOPY);
 	smc_clcsock_replace_cb(&smc->clcsock->sk->sk_data_ready,
 			       smc_clcsock_data_ready, &smc->clcsk_data_ready);
 	write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
@@ -2687,10 +2695,11 @@ int smc_listen(struct socket *sock, int backlog)
 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 		smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 				       &smc->clcsk_data_ready);
-		smc->clcsock->sk->sk_user_data = NULL;
+		rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 		goto out;
 	}
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = SMC_LISTEN;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 9e6af72784ba..52145df83f6e 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -346,6 +346,11 @@ static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
 	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
 }
 
+static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
+{
+	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
+}
+
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
 static inline void smc_clcsock_replace_cb(void (**target_cb)(struct sock *),
 					  void (*new_cb)(struct sock *),
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10219f55aad1..bb0313ef5f7c 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -218,7 +218,7 @@ int smc_close_active(struct smc_sock *smc)
 			write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 			smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 					       &smc->clcsk_data_ready);
-			smc->clcsock->sk->sk_user_data = NULL;
+			rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
 			write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
 		}
-- 
2.43.0


