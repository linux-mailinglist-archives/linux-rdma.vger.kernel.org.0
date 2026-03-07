Return-Path: <linux-rdma+bounces-17663-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD6AGfeZq2nYegEAu9opvQ
	(envelope-from <linux-rdma+bounces-17663-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 04:22:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC9F229D58
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 04:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44CDD301E7D6
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002AE1E7C23;
	Sat,  7 Mar 2026 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HcKoFVbR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954E2EF67A
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853743; cv=none; b=JK9oPKspBPRj8b1SFQKlOsjwtXD/vWBG5CINxlRdHR3oKWUNN/LwlAykeZ3Bpye878j/3B19ZDQn9UjaY0wS1eARr86wTqxntphmkB0Zq9Afds+ly3YSfgX9a5x2BSPzYMQVOt2bY9S1sKEJoHDVWGNyjDklrqrP+KMT+l/9eEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853743; c=relaxed/simple;
	bh=VQwpztTD6X2+N2GcGFC+cfF0qdSug6p/2KKpCFyCe7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+di/09aWp01xRP484l+gyOv/fFT2UJQ5ad6AP6gmUDpGP6uUk5vwuO6Syxi+6r91WWHiaX4tnFWZkYADVxtZX5LdZ1t99Nypk5Cv5Fif+URZ/m/lrZ3EBCPpDBnSCUuHK1GWHWCsD+k7WxyTQGIU3N1Q8OocPq6jQH9y+Ey51o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HcKoFVbR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772853730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJBoqx1LHyd0/cvODH/iQXRMAkmqnF6l6wgjSb0JHZ0=;
	b=HcKoFVbRz57KHwAFkUutc+hPS9luMCnbkUmROaaPHfjaWWJT8en1f2qNtW+m4hW3QcRzWM
	rVQ0BYBLCZMYOXnAPaGh0JxjUiEyxo7rR3d6B4Lf6av/sd/rgct5SFnTL/qs2VKdzgS0Tk
	SQrOt6mUH9I0UsUi2khhjwpHggm06n8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
Date: Sat,  7 Mar 2026 11:21:57 +0800
Message-ID: <20260307032158.372165-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CEC9F229D58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17663-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
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

Fix this by taking sk_callback_lock to read sk_user_data and
then sock_hold(&smc->sk) under the lock to pin the smc_sock.
The lock is released immediately after sock_hold(), rather
than being held for the entire function, to avoid holding it
across ori_af_ops->syn_recv_sock() which creates child
sockets and could risk deadlocks with nested lock ordering.
sock_put(&smc->sk) is called on all exit paths after the
hold.

[1] https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/smc/af_smc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..21218b9b0f9a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -131,7 +131,14 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct smc_sock *smc;
 	struct sock *child;
 
+	read_lock_bh(&((struct sock *)sk)->sk_callback_lock);
 	smc = smc_clcsock_user_data(sk);
+	if (!smc) {
+		read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
+		return NULL;
+	}
+	sock_hold(&smc->sk);
+	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
@@ -153,11 +160,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
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
 
-- 
2.43.0


