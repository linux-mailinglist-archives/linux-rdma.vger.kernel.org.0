Return-Path: <linux-rdma+bounces-22969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DbpZK03NT2o+ogIAu9opvQ
	(envelope-from <linux-rdma+bounces-22969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 18:33:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E27337F5
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 18:33:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infotecs.ru header.s=mx header.b=xHSUDBhT;
	dmarc=pass (policy=reject) header.from=infotecs.ru;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22969-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22969-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 596773018BD5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3604252A7;
	Thu,  9 Jul 2026 16:28:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAE3DF01C;
	Thu,  9 Jul 2026 16:27:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614481; cv=none; b=Bk5EsCAdpPzZW6gwzw4LYJnfENrVGICyBvQzaAxpwMk2ukBQd/2sixByw2zuoEG7gyp89ZBp4n1rfNIj8GI/Lr7s5deJj+rDShiGQbVpbyGftyEMfaMaigZTp0R7D0x43BHpc67D/Qfxk87+a0/lpW2AgYC+FAB/jW5kkTUmXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614481; c=relaxed/simple;
	bh=1FQPBe3UTrCHvaS7K8WVrQOoZRV3GJ75PFXYfS5/dmU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UcLEWjDYNsvO1Fn7c08Z/alYd13ikGbrz6lW3SDwrhlB6IorLmyzAbdrT/pB2iaQE3ke60wG8a5NdXkLSrFQcV1dzj4U020xmlDOILTP6IoP6YhkT1LlMv2xw7VRtIfqbem07k1UUZOKE8/ZkSa1IZgyKFsS1sh1XIe183u9fNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=xHSUDBhT; arc=none smtp.client-ip=91.244.183.115
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 9D7612C0BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1783614476; bh=BXCGI44zV7fCdSdUq7/+YgzGsBKc5xehOdWGxwHvjhk=;
	h=From:To:CC:Subject:Date:From;
	b=xHSUDBhT3e7OXaYp0MAmowhjNrKnKZm2YJ50dIhiC6HLscM6zwA8BMVJny8FlzL1S
	 20qtxAQg8L+LOsfoEPiuoPxO4275dzSj1FT5ujIwP6iPJ5cee/BUvwKb55IZT7SEsH
	 jp7dS4mAmdWZiAhP53fIxdAbcjIPEg22M67+N7pM=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 9D7612C0BCC;
	Thu,  9 Jul 2026 19:27:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 5B6432C0BDE
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 5B6432C0BDE;
	Thu,  9 Jul 2026 19:27:56 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Allison Henderson <achender@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ka-Cheong Poon
	<ka-cheong.poon@oracle.com>, Santosh Shilimkar
	<santosh.shilimkar@oracle.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when IPv6 is
 disabled
Thread-Topic: [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when
 IPv6 is disabled
Thread-Index: AQHdD7/l9bQwacus3kaGFh6vOxW+Aw==
Date: Thu, 9 Jul 2026 16:27:54 +0000
Message-ID: <20260709162723.367523-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KSMG-AntiSpam-Info: LuaCore: 112 0.3.112 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec, {Tracking_from_domain_doesnt_match_to}, infotecs.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204372 [Jul 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059, bases: 2026/07/09 08:43:00 #28414782
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infotecs.ru,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infotecs.ru:s=mx];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22969-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ka-cheong.poon@oracle.com,m:santosh.shilimkar@oracle.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Ilia.Gavrilov@infotecs.ru,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infotecs.ru:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ilia.Gavrilov@infotecs.ru,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infotecs.ru:from_mime,infotecs.ru:email,infotecs.ru:mid,infotecs.ru:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 112E27337F5

When booting with the 'ipv6.disable=3D1' parameter, inet6_addr_lst
is never initialized because inet6_init() exits before addrconf_init()
is called to initialize it. An attempt to bind an RDS socket to
an ipv6 address results in a crash in __ipv6_chk_addr_and_flags()

KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
RIP: 0010:__ipv6_chk_addr_and_flags+0x1df/0x7e0
Call Trace:
 <TASK>
 ipv6_chk_addr+0x3b/0x50
 rds_tcp_laddr_check+0x155/0x3b0 [rds_tcp]
 rds_trans_get_preferred+0x15d/0x2d0 [rds]
 ? trace_hardirqs_on+0x2d/0x110
 rds_bind+0x1433/0x1d60 [rds]
 ? rds_remove_bound+0xd50/0xd50 [rds]
 ? aa_af_perm+0x250/0x250
 ? __might_fault+0xde/0x190
 ? __sys_bind+0x1dc/0x210
 __sys_bind+0x1dc/0x210
 ? __ia32_sys_socketpair+0x100/0x100
 ? restore_fpregs_from_fpstate+0x53/0x100
 __x64_sys_bind+0x73/0xb0
 ? syscall_enter_from_user_mode+0x1c/0x50
 do_syscall_64+0x34/0x80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7f47f8269ea9
 </TASK>

The following code reproduces the issue:

struct sockaddr_in6 addr;
s =3D socket(PF_RDS, SOCK_SEQPACKET, 0);

memset(&addr, 0, sizeof(addr));
inet_pton(AF_INET6, ADDRESS, &addr.sin6_addr);
addr.sin6_family =3D AF_INET6;
addr.sin6_port =3D htons(PORT);

bind(s, &addr, sizeof(addr));

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to s=
truct in6_addr")
Fixes: 1e2b44e78eea ("rds: Enable RDS IPv6 support")
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
v2: Add a similar check for inbound link-local IPv6 connects

 net/rds/ib.c    | 4 ++++
 net/rds/ib_cm.c | 4 ++++
 net/rds/tcp.c   | 8 +++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/rds/ib.c b/net/rds/ib.c
index 39f87272e071..8f9cf491984f 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -429,6 +429,10 @@ static int rds_ib_laddr_check_cm(struct net *net, cons=
t struct in6_addr *addr,
 		sa =3D (struct sockaddr *)&sin;
 	} else {
 #if IS_ENABLED(CONFIG_IPV6)
+		if (!ipv6_mod_enabled()) {
+			ret =3D -EADDRNOTAVAIL;
+			goto out;
+		}
 		memset(&sin6, 0, sizeof(sin6));
 		sin6.sin6_family =3D AF_INET6;
 		sin6.sin6_addr =3D *addr;
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 5667f0173b47..d46146887ba4 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -810,6 +810,10 @@ int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
 	dp =3D event->param.conn.private_data;
 	if (isv6) {
 #if IS_ENABLED(CONFIG_IPV6)
+		if (!ipv6_mod_enabled()) {
+			err =3D -EOPNOTSUPP;
+			goto out;
+		}
 		dp_cmn =3D &dp->ricp_v6.dp_cmn;
 		saddr6 =3D &dp->ricp_v6.dp_saddr;
 		daddr6 =3D &dp->ricp_v6.dp_daddr;
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index a1de114d5e2e..955d92277d5a 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -366,9 +366,11 @@ int rds_tcp_laddr_check(struct net *net, const struct =
in6_addr *addr,
 		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
-	ret =3D ipv6_chk_addr(net, addr, dev, 0);
-	if (ret)
-		return 0;
+	if (ipv6_mod_enabled()) {
+		ret =3D ipv6_chk_addr(net, addr, dev, 0);
+		if (ret)
+			return 0;
+	}
 #endif
 	return -EADDRNOTAVAIL;
 }
--=20
2.47.3

