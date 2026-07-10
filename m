Return-Path: <linux-rdma+bounces-23035-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 98+TDqtyUWo+FAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23035-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 00:31:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5D73F8B4
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 00:31:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=JVaJNw7K;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23035-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23035-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264C43014513
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDF448CFB;
	Fri, 10 Jul 2026 22:31:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D84483A9
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 22:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722664; cv=none; b=UBe1cYnqLN6IgMMz7r/xkK3a4k7J+Sk4Vy2MsYxDHEzaBT+M8Fv1MwVpDFZeXXxZceBfF7tURcR+wRv/ePNQHYakWkbktnJXL2n4ZwGe9YcLVYqMYsktwtXTdQyZFQu6ZY1KiX0HPm/l6xBNv2rHUQV71h+iE4UZPQQ8ANSr+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722664; c=relaxed/simple;
	bh=je8b0NJ3kzl2VgAVR76DhvpWSaNnBgzqfWKjUFfnbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPe2RIEfDEnoJZXHWOQxgVYwX307GgsbIVTYyph8Vt9fop8RfWnNNtsvpVe+Q5YlvDWfRNn/UkboZUby48noel3pheRbQxothZ7lX/872EUNRsR1n//ALUgD897+GYPNIzgjBYENyuCsxh0yZ8bFd7zwSG1uEdRfEOZouAgG9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JVaJNw7K; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37df72c9984so2441428a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783722661; x=1784327461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0kfgGvEQ8I7mCwBq+ettrM4PZ07Bq+DUOcQ+ZPJPwM=;
        b=JVaJNw7K6iRbe6SVWLVhRoiXL8XTdKSIZEgwgTTARF59sIkQypcguk5Hgv4O23xki/
         zDj01Pp45TAxlX1vYMqebRbfbKkfMM7lXhQRPZNagalSUFfuareHuoH3NdzzOcfrQWJX
         K/oZsgTmgUiinqlVSh6ihV0SZSeb7Ho5YqC4kYwtxcLJZK3S/CUgDLRE+KB1SaxU+ero
         naFGicxwF49B/hl/1KnTjKKxSG50ony3TEXSQ1DXeRr69SN6oDjb2P/+7XmMwKVv97iN
         Fix1NnbT1QtJnfGfBtqS8uKpcrLuYGf9+V6XxmCXAY0W4gD2vSkCLMWKPw56zSy7bynX
         T5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722661; x=1784327461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0kfgGvEQ8I7mCwBq+ettrM4PZ07Bq+DUOcQ+ZPJPwM=;
        b=YnDQgJbcebGubmLlmsgKHuG3Bg0d6sqihsSOtGMAef3fRwyopKyjpxddEnattQBcnK
         zU9wA9SL9NwZt6rV79ZWS07qTwGCGOfzrH1rxf478kzGSjTwb5RmrCpze/+jyImjKnS1
         q8P67RWFmPJP++MVgnhqZ4Zq2WlqwbZQbjd0Uai5sstvKm+rWmXSb6s9MQ79kR/b/Of3
         qQdG88u761Pa2JsSkVDR7QUnqtTA8B1qRDc3k9QPrJbYr7MAGv5MbNRthYdSwtSv0i70
         FpxFB/0DLa+BGobAE8kbGGaW9o/Q60rEmLIfPH3cnx2i5bXZK7KjOTIqFWbzMBpEBF69
         TPyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOD+WLqDmuZouY6eAFiELdAixSbsSg5bCytE6uU2EGA7a+jueUe6e9eyo5TN5dhziM3ydfWbRE825r@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtf+1qGA9NP0CaVEuRh/AH6/aE78Ps/hWsLX/yeWT/5Ao8Dp6
	gaiJUY8wpW+SkzWOaxI3r48u6bWsXE3XctHKt2cEE0hWR/5Qj78lvbWogUu3V/FguDc1KtB3BvA
	yfVSFRQ==
X-Gm-Gg: AfdE7cm5n7S7CKDKgWZ9E5tHQedezl5HQ4ubE0G/A1kYzii3Z2FMM2PuOMFkCTTalO7
	enhOeqqQvdR8EU8+RBEOyHkSYDn8e1Tx9mOh/MdVnJIELSgFLuzKUv0kiD/2TRIvN71V5gBLrKa
	BRzpF4ITk5/JUY48kiBf55rYB2dhiEavY83GJPE4S4Tw40grlR1l6pMGP3vTtObCqwKNOgUTFl/
	+rBz5reeTPeooCHPjUsupDU4Bd6bceF2Tz96Z78vXf6TxpJnTztxlH6Fg/x0Kin/Gsp94u8LxsB
	t354ukpxBfaACNXc7Iz6f/MZpviAZCNnbMS96vlEtrXlGB6cTtjrPf76Q7zmsqsHoYqbXb5paAg
	KFZedtSat+UVnBqQBw10EJuHUFKyG9MaS+CvWtOGmvEW7/dp/onAdGIjKO+Q4HLpuuixgrKtu
X-Received: by 2002:a17:90b:4f47:b0:387:e0cb:7f1 with SMTP id 98e67ed59e1d1-38dc7836681mr669430a91.37.1783722661211;
        Fri, 10 Jul 2026 15:31:01 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec80:eae:8075:172b:81dd:854c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38dc9fc78ffsm53267a91.9.2026.07.10.15.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:31:00 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()
Date: Fri, 10 Jul 2026 15:30:29 -0700
Message-ID: <20260710223029.1307043-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23035-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,oracle.com,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:santosh.shilimkar@oracle.com,m:ka-cheong.poon@oracle.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99D5D73F8B4

rds_tcp_laddr_check() looks up a scoped IPv6 interface with
dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
passes the bare struct net_device * into ipv6_chk_addr().

dev_get_by_index_rcu() only keeps the device alive within the same RCU
read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK can
free the net_device; ipv6_chk_addr() then dereferences the stale pointer
in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), reading
freed memory.

Keep the RCU read-side lock held across the ipv6_chk_addr() call instead
of dropping it right after the lookup, so the device cannot be freed
while it is in use.

  BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
  Read of size 8 at addr ffff8880106ec000 by task exploit/153
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
   ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
   rds_tcp_laddr_check (net/rds/tcp.c:370)
   rds_bind (net/rds/bind.c:248)
   __sys_bind (net/socket.c:1920)
   __x64_sys_bind (net/socket.c:1956)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/rds/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 955d92277d5a..30cfb0087f2c 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -355,23 +355,25 @@ int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 	/* If the scope_id is specified, check only those addresses
 	 * hosted on the specified interface.
 	 */
+	rcu_read_lock();
 	if (scope_id != 0) {
-		rcu_read_lock();
 		dev = dev_get_by_index_rcu(net, scope_id);
 		/* scope_id is not valid... */
 		if (!dev) {
 			rcu_read_unlock();
 			return -EADDRNOTAVAIL;
 		}
-		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6_mod_enabled()) {
 		ret = ipv6_chk_addr(net, addr, dev, 0);
-		if (ret)
+		if (ret) {
+			rcu_read_unlock();
 			return 0;
+		}
 	}
 #endif
+	rcu_read_unlock();
 	return -EADDRNOTAVAIL;
 }
 
-- 
2.43.0


