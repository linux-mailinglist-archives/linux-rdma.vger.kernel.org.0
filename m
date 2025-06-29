Return-Path: <linux-rdma+bounces-11745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206DAECE45
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A817161D
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC5231829;
	Sun, 29 Jun 2025 15:10:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9927456;
	Sun, 29 Jun 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751209852; cv=none; b=BCnPzKK8HOyFgAUCHouODMqqxVI5S9CzY9ZQ+zvRiRR6485KZn3YTcy7tdOV6oUSXzTCaVpfXgsLUSw8dNKodP+MUMAgTZuTFMK8gSBQkIxRTi3BB564KsH1TI/DhI8o10dMJG8KU8LRkgkhvpb6CK32swZ4BSssilJzg7n72Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751209852; c=relaxed/simple;
	bh=+XqR8bvOHxkPqaJepQHhIXbhpGpTPU9EP0Oa/KDkYuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL879nnDJpS53kmWtkpBoiborRI29ED8Ma9t3qGKKOj3/BN5HVbk0ohcOuh4iojgLRsZZLTjd0aPu1Ozo0olmoa9KPfEMrzgIsKLfA8L6XjG8aTYifnRuGZxI0w3iEudkswRxNwz/qfBZ13FVpMAbwFvwVJdOfOydjOemshhjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d1f3:4f54:4c66:bf44])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id A51A841E5E;
	Sun, 29 Jun 2025 15:10:48 +0000 (UTC)
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
Date: Sun, 29 Jun 2025 16:10:42 +0100
Message-ID: <20250629151042.50986-1-contact@arnaud-lcm.com>
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
X-PPP-Message-ID: <175120984960.24200.8751488680677029462@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -125,9 +125,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 {
 	struct smc_sock *smc;
 	struct sock *child;
-
+	read_lock_bh(&((struct sock *)sk)->sk_callback_lock);
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
-- 
2.43.0

