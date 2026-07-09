Return-Path: <linux-rdma+bounces-22928-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I0oiBClST2qleQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22928-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:47:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6872DED1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:47:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b="k/R1qZ8E";
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22928-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22928-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAA95307C66B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BF3C1974;
	Thu,  9 Jul 2026 07:45:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6D3CCFD4
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 07:45:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583106; cv=none; b=d679vVzqXXhfqVIHID6/G99QVorLHfv/xabG8fg+VPSYbfrJ/6dkWPIHEpJvKWVoXkdokf4DqIykMFJAH5yRTVuQYRFGcvsXkbb9Tqtg9PYfXNT8erD0QuAT4RvvHQqdrs54RExaZzssW+nlXR5Km6X3rpWpCg79+v/jFhnydbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583106; c=relaxed/simple;
	bh=ljQxIHA11d7j3UwD5SUG7PWcXQCYFxsNMhqkVbdm2WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpkFCKRkOP1dvPADbfQqgW8iBHJcJ1EDm/FS2xshqJV8HbjSByG8F99jmxvXALr1lpZiosBJiAYqc/32SX/NXtuGNG8SBs5x8cQrk6OrFYPekLFYV7ESMDTF1ElUC15MYogM10YoG3L3CwkWbg/ZeSCoBhBQ+FbSiUItGVOb4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=k/R1qZ8E; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8485b80f8f0so288005b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783583103; x=1784187903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3pmlo/oWq2uNWTooLbzNWToUXky3k5pknmZssX/yPA=;
        b=k/R1qZ8Eov4b7hTEpg6BojLWtq2FsUkfqz9KCFcoPdTz/2jT9BGUzEHaWyzqE13HfR
         Vi60NSdYWz8XgMpRizJzpW9NFWnhcIGRuCpMfPeBPVh2/VLyH6Bu27lDDfRN5xT93u88
         GyTZkyHFh9A8gKji+Lv1SqlnZG5hzD1JR/janhBiI37HI0NvKxL2UMwoqmSKgOtNWj2v
         Hu754VoCscGCDLn63rPmfpP5DULW5+wDqgLgZ+vUq3CosmMC7JeBr8Lk1c+9acWfcxL7
         PVJyGHtwacnTd8ZI05Ap1g6BNBtrvRwO5k7TKn3ibxLcNZcBEeM2G5dAudcdGZWkbJ95
         ENJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583103; x=1784187903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3pmlo/oWq2uNWTooLbzNWToUXky3k5pknmZssX/yPA=;
        b=ooAReq0yHTZt/r+tO1Kya3Su6RAVsradPvwSs3os54DkViD4E2KI9NhExK74NfX7Tn
         CW+cYlS1nrf13r/QOixvlN2lbR6p7xgeDQpnq7wPsY6nvDN18A7xzWva9cziS43Q4xmN
         ZqTbVXMLs/oGrg/10mKWKu+hEtH1o+NukZocMBbP7Xop6yftARyjVUT5from7k33jonE
         GDrVtTwtBtcgDsOAry+FnJID9jG4u05u740VLomc7MLYFTaeAJ3jozCfJ7pKWFCTxJES
         rPQlPZQd9NDp7T58Bs2ozQMi7nKh9ffVLTsz5xaMJ8HMYNOW9YT0/aNcMZ9KOIUCD8q3
         /kdw==
X-Forwarded-Encrypted: i=1; AHgh+RrbSBu8P/HkVKJ5+zDAKI0uXq4O3IMT9IwavQ1dP4/NiN5+juCNoFk5Ssg2ZAaZH/rnx5M71Cg0/4ud@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQrw93M+Yb6Jh0tutp4XfNB1vLym6BsU/HQQrWTamD+ug3mkv
	hNsodm94xstdOdfUrJVNkryenSxxu8PdKwc0LBjedY8qS9JrXqWO55r5jkEKEeOTKg==
X-Gm-Gg: AfdE7clhIyJuyuWiUGuMuFfptCqH/+Z9T6XrpCCB+YqGzpmmtPDkrKfBHaEX38W5ACd
	aiebIgWr9v567uS+Pw98qNN7wvZT9O2c1LG0eGJ2Az7AToile4XYTQQyLuscNecsrlzdqilqlGi
	O3qDkkVkPGezcAe3jB2jAscHRN+qmQc662G/Xs9UkBXXqafAna/QGg2K4i/wp3CYAwtccgAYkmu
	aI8nb/0UTN/bII9cUMq4NSO2rTC58LswIdtYw8LfYj03yphJgBI6jVvZYC3RaUAXbKUUK77qVeZ
	TXrN/faJmC2xieNH2ge0x7dHCr3jjh620H4yCArcWIRWrmTe39f8Ye2KBpWqjHFpeDunLizHeER
	/dfm5296aiRqJTyQWdrqw9WumRS4OEP+2vKVbIw9SxEB9J7KE0CP/1nLPrhegHF37DuoxNTjcqQ
	==
X-Received: by 2002:a05:6a00:1bc9:b0:848:42c4:d8c8 with SMTP id d2e1a72fcca58-848437a26bamr6023748b3a.68.1783583102879;
        Thu, 09 Jul 2026 00:45:02 -0700 (PDT)
Received: from p1.. ([2601:600:a402:c8a0:214c:bc6d:954f:ba01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483dc66f2asm2501048b3a.24.2026.07.09.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:45:02 -0700 (PDT)
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
Subject: [PATCH net] rds: tcp: hold the net_device across ipv6_chk_addr() in rds_tcp_laddr_check()
Date: Thu,  9 Jul 2026 00:44:59 -0700
Message-ID: <20260709074459.326345-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22928-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,oracle.com,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:santosh.shilimkar@oracle.com,m:ka-cheong.poon@oracle.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CA6872DED1

rds_tcp_laddr_check() looks up a scoped IPv6 interface with
dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
passes the bare struct net_device * into ipv6_chk_addr().

dev_get_by_index_rcu() only keeps the device alive within the same RCU
read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK can
free the net_device; ipv6_chk_addr() then dereferences the stale pointer
in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), reading
freed memory.

Take a reference with dev_hold() before dropping the RCU lock and release
it with dev_put() after ipv6_chk_addr(), so the device cannot be freed
while in use. dev_put(NULL) is a no-op, so the scope_id == 0 path is
unaffected.

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
 net/rds/tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index a1de114d5e2e..204dcdc33c27 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -363,12 +363,16 @@ int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 			rcu_read_unlock();
 			return -EADDRNOTAVAIL;
 		}
+		dev_hold(dev);
 		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	ret = ipv6_chk_addr(net, addr, dev, 0);
+	dev_put(dev);
 	if (ret)
 		return 0;
+#else
+	dev_put(dev);
 #endif
 	return -EADDRNOTAVAIL;
 }
-- 
2.43.0


