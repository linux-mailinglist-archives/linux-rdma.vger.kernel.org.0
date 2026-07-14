Return-Path: <linux-rdma+bounces-23230-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K88LEOSoVmpd/wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23230-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 23:23:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E7758F53
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 23:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=azP2SjXs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23230-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23230-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E6B73022601
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD487427A1A;
	Tue, 14 Jul 2026 21:23:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464140D590
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 21:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064223; cv=none; b=Z4fLIXSH0+4oYMiGFSlskkkFc+3UoQSkgf4YRQ6ERPV/vzN722R7SxiVhjFFM+TmPM+w8XbjDCH04ymxfRwRVfhZJ8iB2sop/Zw1SIFvRiUQvWq9g0lf1iemF6Do0leGuJd1bxOUQ640wfBfbs4T6eV1AG856pfMWuEI6aYkhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064223; c=relaxed/simple;
	bh=n9Yz/38hoJril5dCerx/HxGEMGg/Te0wQ4wLGv6TztA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiGovidSiPRKn88GtZZ7+d3GZg/hH+i1CPOvzqleq7a87L99fxR6Sy1Et05uZb59a1+U/4MHvz+R1Q4sFbYhvq1tufNhcM5Q3G+XADzQNRk935CcofJ1Zo9qEIpLNzHjVp1cqmPcRPc22gxx6yxr/jDARtnoIcRYGb638SyD4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=azP2SjXs; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1332597b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784064221; x=1784669021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1344qgK1KXfGz8odnjT3G64QkGD5RQr6ifbgVRduQo=;
        b=azP2SjXsmGbkjgyYUH/HUxQFlR8JTnNFIsymrhIsgh5OWS0mZ9cjS7UmTg2rYJbvdp
         cKcG7J3F9XOr1QFWuu95SXGhYMii0kAjWIlm1FI3p5BRIC4VWB6eEoQT5nScdH1EQMLW
         pCYDteB+Mfn+fSj1widPhnA1dww7TY/P9sl26mWRtx+X6XMbpk812MhVOU1bjsXpTsEj
         FG3XbUQ4iuB2pnKy4dhBBFxbn4+VV2CVTGbsP/nU7UZSiaFz7Ip1YXrURc4vdLROJB8M
         mU29d+903RXOpoZOSbHgxuolM6VNZWgJbzIgBFiljK3vR7DpXSYRNmJoluHOo1lCCrH4
         F4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064221; x=1784669021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1344qgK1KXfGz8odnjT3G64QkGD5RQr6ifbgVRduQo=;
        b=aS/EtefJCYp6aB6Y758qbICG4DLnhrA1NNsoT+Kk6wyu+wbW7BennBUjd7bF5tlFrW
         9lSVFDesXiw9Cug1OHKfVL7p+O7tBoINRcYG6L0czoLu3WlP5UsfQf12nPWuclPiio/K
         gllYvKY1yF0Wvxv4qtnXuIi9pqpceVPFPiVVMOFo7nZLbymmNrJS+8A2bq7v/kH5kZG6
         0CUj9cVjIlvFytAA8xUBA2HID1A+CKGWh0s8JCcV/+joO6z/LWW54cr6ogKjdiawS1Us
         zQP0be9b71AiwcAr0LzDIh3jSLO+zV8SszOJ7HxbaV3Cmdr7dGSIUFeMW+vuN//F6yn2
         LIVA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+NI5/RKioF01xSToeJYHnFYDF+kAa6q6VA7V3l8OwV74lKEWv8ctTXGGw+nkAXCDlmrO9dtE45lTf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23WwVT6BCvTTX95Eu8Rl303Fr0xwHAVooLoW3DwAT99UqkLhf
	98mqiQ24u3mkRhsoJs29monUHER98pmvrvMA8EfN8/PBkBJbQ1kcDebu+Hrbpj61NA==
X-Gm-Gg: AfdE7clDsvvIj5SqFSBiXDi7X6pTVDRSJ2mRBwCZkB8siBREvFXXsz7ETy26F97pONl
	RJjKxp7pYky4YbxQ76EGhc1dE3rhN2f4/fs5ihhRatIqcQ7+VhdzB00qmYMqVk5mFWjurIVgR4H
	V4K8HY7Qv5eAy5psv4HIDhha4HomL8Wr+u2obUB7bu/c4fIDnY9MfKFN9KnervfJI5QN0Hk8GzV
	+LVTljlkztjZ5xN3QMEFJhKBBkIytwjn13mA9PGuQIwRhBc2m54TTzqdH2v6eZ4kagTE2qgIU86
	ikf2bcHkEZOEszNnCywZM/OLMA6aNezBPXJCY0TlP2t+szESEXsQbFOFAY5/YSvIaw4DRZbs/Ej
	2d+TUJerIcGMRNYsbUZ0p/32b9DtRdhG9ticoFg04EaftukloRKP/u4AoYdRhaSXGDhkhFZ+5T+
	BxUpkWBmY/SQ==
X-Received: by 2002:a05:6a00:27a5:b0:847:e2c7:59c5 with SMTP id d2e1a72fcca58-848896bb796mr14050225b3a.49.1784064221414;
        Tue, 14 Jul 2026 14:23:41 -0700 (PDT)
Received: from p1.. ([172.56.106.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc8e7sm2018325b3a.47.2026.07.14.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:23:41 -0700 (PDT)
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
Subject: [PATCH net v3] rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()
Date: Tue, 14 Jul 2026 14:22:39 -0700
Message-ID: <20260714212239.1511269-1-xmei5@asu.edu>
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
	TAGGED_FROM(0.00)[bounces-23230-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 994E7758F53

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

Changes since v1:
  Use rcu_read_locks instead of dev_hold/put
  Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Changes since v2:
  Add change log

Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Allison Henderson <achender@kernel.org>
---
v2: Use rcu_read_locks and rebase on rds: Fix inet6_addr_lst NULL 
    dereference when IPv6 is disabled
v3: Add change log to commit message as Allison suggested


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


