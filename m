Return-Path: <linux-rdma+bounces-22211-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7FCqGiSaLmpE0QQAu9opvQ
	(envelope-from <linux-rdma+bounces-22211-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 14:10:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776E680FE7
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 14:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iAicbphZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22211-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22211-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B091300B3D4
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072F39E171;
	Sun, 14 Jun 2026 12:09:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84738D011
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 12:09:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438994; cv=none; b=VMwVF61c1tWQUqnM0ShgOfBblh/Fb4n3XBput+yVRBL4SlFrsYyG1G4zVZFMUQYIge4CdA1zQOSEOZ9m6tbRHPu2ovTE6inF1tAf2isDsHj32M99bY+8FiOwzyuXNQw+yio8tERCvoNlT5Qc9spZk2suhCGpK/pzTT1Gfz2aks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438994; c=relaxed/simple;
	bh=ENl8qycC4hOgV9OJcdWSk1WCzOza6yzUWtNtzRZMFY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2KC5MuRTGgoV5zyMF77/LdHXTI9rVMLcGoOOURrUmaqzLmkOG10KXunWNTxcJcix7e7WuhAAsKiQ7ZwOVSFxKtYlftcFSbohCtvL31Q+bR//syVXtYbRriCcIOA0ORfRfUnHSdpmNBngC/WeVoI5zdWhDHbWvlNRtkwqIHkbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAicbphZ; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so2195749a91.0
        for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781438992; x=1782043792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBz8xwezxj1aIuO0db8vVWpBd4FeH4XlQcs+DSABQC8=;
        b=iAicbphZEk3Mmjed3KjMcjmUGU1Uv6F8ceO9iTIurE7KFL6E1n5BQlBw5laN71ubJz
         VGQeANWZFOFIs3PAdkOH47kqzFubfa0idjt6IdKOt4ubP2I8CabGL4UiiZcApfx1x1QS
         1D0c3XLsN+cUbRWYzydlvDeHNl8yt8s5fY9tnixWqZglCyRveVcHZ8o2youENAEBbTB0
         Zp3o+H9Rib3vQ61aLhXAhtoS3XSKxqKm2PWP3pJs8Gk/AwYacvpFf8eBQzF2gvCAsbZO
         0JVyEXc2mey14jLnRDHL98gBJnHNOTKiBMyiL0GTkVYUpjvZJj4Qkemgs+0R/3Xm51U3
         cJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781438992; x=1782043792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBz8xwezxj1aIuO0db8vVWpBd4FeH4XlQcs+DSABQC8=;
        b=gPSTY5kkvFgw4owN7S6j8bQhVCnK7MC66aWdU/RbXZXtsKAfxLKIgRXchnkh+kjX9R
         Y5CnFk9a6vh38YuHF9P7RMa3K7i+a8ZzMvVQibYmqM+bTcSEeACciTnbgSNw8PD34TQ2
         reHjrzvDWYpoWJ/27l7I8nlomHSc2qUQriqWFao/FLyvIUvUWSVR1VPg3QPf23BnX2yd
         1rEkONHglOTlc0eVjdT+zCocn8cWLYS7UyAytZ5lDQgSCfMW7ylM74wRHQ13bLJIBtwS
         WvD+AXKfE9luOlUiOZ81YqIma7ocTkJB5brvmudA5DZi4MBJh4DaChG2B/220YNUI0GX
         gynA==
X-Forwarded-Encrypted: i=1; AFNElJ/9ytI7HLcOYfgGw0nWFWxUqAU2MwaxWxgvvPbL2kFxLa2olopgzlAeiGvSpSKk/4grrVK9ZiFHyqYH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/BOJumbglw3RKTPxw7EHmtLIY/bjOj52ysLTYrPo9J9HkUNN
	E+6/NYK0plwGsEMqnuFYCxjA0XzBR7+sbv98+psw0b78RGkOVh+ocaLq
X-Gm-Gg: Acq92OEr5xlyf1rP7qS1Gmw5l3j8CBcLBI9i8I1lCoytbAkrRNVSvm9fW7SFN4MVPdP
	X2UCRz3ArWj4QYlxO61jG00F+RvzNA8cOSaRdIobsH9GZqrqsUPb8WRgGM4uVXSjmpHyFlLXSnl
	yVOVcVzZEUk+4ibsnZPBn+xJfXuQiblILq/b0fKbNWBbs+SwAgfCpBAeG5pkPJEaa1YCUavmAG7
	cbZcGk4cSVY5539Egp1j0xdRHvOMXfUi0otonAxfxFNEWPtPzVcghwaxsAXMI8NRS3kCXDbMdB0
	FPQ4EwI/V7I/+LPnxMVjRflwlyW/368MblbJGDVacClR7sLfgoTaeaKInKU30a07qKnC/p8cQbu
	xCE1XRFT0LmLNzaU2YeuNdUCPY2rSh9xHFqwKw5o6vLoA0gpA8icmH5EYogPrNxw3LLQ8idWHYm
	2VR77h0qYjscrzCX2hP3H0OQ3G510uUkh/rSoO/RQ23y8CofbT41RoVsaPlJNnuh93SKaAoEng
X-Received: by 2002:a17:90b:2884:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-37a03ccdeadmr11438677a91.22.1781438992123;
        Sun, 14 Jun 2026 05:09:52 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a20dbc386sm7260143a91.11.2026.06.14.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:09:51 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: fix out-of-bounds read in smc_clcsock_data_ready()
Date: Sun, 14 Jun 2026 12:09:30 +0000
Message-ID: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22211-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0776E680FE7

smc_clcsock_data_ready() is installed on the listen socket and reads its
sk_user_data as an smc_sock. A passive-open child inherits this callback,
but sk_clone_lock() clears the child's sk_user_data because it is tagged
SK_USER_DATA_NOCOPY. smc_tcp_syn_recv_sock() restores the child's af_ops,
but the inherited sk_data_ready() is left in place until accept.

In that window the child is established. A cgroup sock_ops program can run
bpf_sock_hash_update() on it from tcp_init_transfer(); sk_psock_init()
stores a sk_psock in the NULL sk_user_data. The inherited callback then
reads sk_user_data via smc_clcsock_user_data(), which masks only
SK_USER_DATA_NOCOPY, mistakes the sk_psock for an smc_sock, and reads a
callback pointer past the end of the sk_psock:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   ip_protocol_deliver_rcu+0x226/0x420 net/ipv4/ip_input.c:207
   ip_local_deliver_finish+0x35a/0x5f0 net/ipv4/ip_input.c:241
   __netif_receive_skb_one_core+0x1e5/0x210 net/core/dev.c:6216
   process_backlog+0x631/0x1470 net/core/dev.c:6682
   __napi_poll+0xb3/0x320 net/core/dev.c:7749
   net_rx_action+0x4fa/0xcb0 net/core/dev.c:7969
   handle_softirqs+0x236/0x800 kernel/softirq.c:622
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_map_link+0x646/0xdf0 net/core/sock_map.c:279
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   tcp_rcv_state_process+0x241e/0x4940 net/ipv4/tcp_input.c:7231
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002

Restore the inherited sk_data_ready() in smc_tcp_syn_recv_sock(), where the
child's sk_user_data is already cleared, rather than only at accept.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/af_smc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..152971e8ad17 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -156,6 +156,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	if (child) {
 		rcu_assign_sk_user_data(child, NULL);
 
+		/*
+		 * the child inherited the listen-specific sk_data_ready();
+		 * restore it here, as sk_user_data may be reused before accept
+		 */
+		child->sk_data_ready = smc->clcsk_data_ready;
+
 		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
-- 
2.43.0


