Return-Path: <linux-rdma+bounces-11743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FC0AECE10
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF611896BB4
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10422D7A1;
	Sun, 29 Jun 2025 14:48:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FC21CFF6;
	Sun, 29 Jun 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751208480; cv=none; b=BCn7e+S2CR0ubsT9llaEFNQqLlZIGNnsDa3z35Kpsy84wcwuK7Hx/vVmjFuCSLY7lOUr+rD+zjXjug4hIAVVl1Q69fJjBQo9zX5dPHpd9Z4cj9CfGbyxT1kIzOO0aRTYiAMJue74t3XUBgCvIu8cdmvYZh8F/axgVEtKHw5bRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751208480; c=relaxed/simple;
	bh=eM2liCDKnARzi9AhLRurJabRqtSureLL4r0eETuZHvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR+auD4t5o3mJlWBDVShlWc0O1oV61jzVNIwxRwmm9Yaa3ez9ldGYjwjRj2OfRUPn5aY2J+u74F86pJZyEoUoSCXYL6b2Vsl9nsWJ0Mlt/BXwXgOS99utjYvDih+4ZLS3YzC4sB7jlBqxYS9HzHkDtUE4HmE7JyeNmPdnVIaO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d1f3:4f54:4c66:bf44])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id ECA7A405BA;
	Sun, 29 Jun 2025 14:47:54 +0000 (UTC)
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
Date: Sun, 29 Jun 2025 15:47:48 +0100
Message-ID: <20250629144748.45117-1-contact@arnaud-lcm.com>
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
X-PPP-Message-ID: <175120847594.11582.8826915060601164203@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -126,8 +126,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct smc_sock *smc;
 	struct sock *child;
 
+	lockdep_assert_held_read(&sk->sk_callback_lock);
 	smc = smc_clcsock_user_data(sk);
 
+	if (!smc)
+		goto drop;
+
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
 		goto drop;
-- 
2.43.0


