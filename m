Return-Path: <linux-rdma+bounces-11732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A67BAECCEA
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0CE174842
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8022259B;
	Sun, 29 Jun 2025 13:35:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527E1F92A;
	Sun, 29 Jun 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751204111; cv=none; b=qAEeIxOmHksQ1mOWEm3porL95xTeru+dozEFwkm5SM2EDLwdlZGDbj1ChSwYFJx9RnBAzqtMrAYw17OoQJqpHWwxC0LCU+28pmRX/L1dGw1YVw9SU5yQUFDhsqKdkxavDXGUcr+3pu3tDn5aTnB/gGcXG9LPCFBE4zfvNtVa5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751204111; c=relaxed/simple;
	bh=tcug8XrJIcCuYfiSBxqFOEwin4mfCE6UNDWtr7RJpYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsvrUuRMbbFYl5LJIRG+uXJMZPd5jE02DS6pMLnDF5JhAE2mvt9Su2SLqKhhWQSjdqeJJP/jzvhU3lNV3d+UNuE3OvtHMzAFlHIj0raKKu3jHmmT2vypvOEVqYl7TAul2JgylJ/3puexfpUShbnK9QxbShySzEq9SKChtTGJk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d1f3:4f54:4c66:bf44])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 0692241B49;
	Sun, 29 Jun 2025 13:29:39 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:d1f3:4f54:4c66:bf44) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
Cc: agordeev@linux.ibm.com,
	alibuda@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com
Subject: syztest
Date: Sun, 29 Jun 2025 14:29:32 +0100
Message-ID: <20250629132933.33599-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67eaf9b8.050a0220.3c3d88.004a.GAE@google.com>
References: <67eaf9b8.050a0220.3c3d88.004a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175120378100.6050.10331989249896580154@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -123,11 +123,14 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 					  struct request_sock *req_unhash,
 					  bool *own_req)
 {
+        read_lock_bh(&((struct sock *)sk)->sk_callback_lock);
 	struct smc_sock *smc;
 	struct sock *child;
-
 	smc = smc_clcsock_user_data(sk);
 
+	if (!smc)
+		goto drop;
+
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
 		goto drop;
@@ -148,9 +151,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
 	}
+	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
 	return child;
 
 drop:
+	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
 	dst_release(dst);
 	tcp_listendrop(sk);
 	return NULL;
@@ -2613,7 +2618,7 @@ int smc_listen(struct socket *sock, int backlog)
 	int rc;
 
 	smc = smc_sk(sk);
-	lock_sock(sk);
+	lock_sock(sock->sk);
 
 	rc = -EINVAL;
 	if ((sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) ||
-- 
2.43.0


