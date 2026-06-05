Return-Path: <linux-rdma+bounces-21837-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NwfrMnO/Imp0dAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21837-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:22:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783A648114
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:22:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=Cg+RrNWC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21837-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21837-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371D33044824
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D94DB55D;
	Fri,  5 Jun 2026 12:13:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0E4DBD6E;
	Fri,  5 Jun 2026 12:13:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661629; cv=none; b=jkswB90olzg0xcBB1wE9c+7MB6UTt4Uy0wqrKsqhL1eBD2iw8Jbn42tl44WdoUQK5BEIdwNIra0Do49iJWkqHUNe7xDxY2trh8EuIUX5ulh58G9CmVIl79pt77GnLJYyUmwXuf1h2ao6fPAsz9BVhUuxn59LuV4BmigY/cuTio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661629; c=relaxed/simple;
	bh=3dPr7qEVvxmzqp5Fa68RHp4F3vW5/2Q/V40NwuplFpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMP4WQESAkf3EOBTewO84kuvSHyU2u3izrV/+5hi4Zahkl4eWS+0wmMJLn5C2amWllzW/2oQoh2dnGeeCB8KiXK3wojHnlFGq4CUJ6CIwlSrO4vl7G9H3dU6kCTzupbqVsoE7kz//Cf8Gfi3EkKj7d/VrXq/hQUOIobayT9TpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Cg+RrNWC; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=kFUydBL2VOJZxCjSY8+wesOl5nfUP1qHfnXLPzIPWck=; b=Cg+RrNWC1/3+bkJkbTflL8ztDI
	go10PZKiqgyCXY+ZgJ85TJniJwKYe7lOncmV6ur/xkQDLhGRarJ4KqUBiNoY2j9Q+eLEH/+dvBI8B
	7aLDkGXm1u5ziV+SnwE4KLgjnfFCtXVPcLlDO2Hz4HYAPQL3NgAe53G6Q4dVi3A+d4WpUnDkmQrfX
	YiPtvqv0fgwecZHZKvyZffAm9Tvf2cSxo23GP23r3GHmFm7hNtkSYGvxNri3UJpv/t372ioqRcp3C
	lPy1jvwErc9oKrq5cxTZv0rgAH+n1L4NSIPyNzDG6cHKQT/WowD0Mzo1PtvNEc19cyj4HKSqwlFK9
	zYwMa0hg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVTQm-005HWG-1Y;
	Fri, 05 Jun 2026 12:13:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 05:13:26 -0700
Subject: [PATCH net-next 2/2] selftests: net: add SMC getsockopt_iter
 conversion test
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-getsockopt_smc-v1-2-65da62fa44c4@debian.org>
References: <20260605-getsockopt_smc-v1-0-65da62fa44c4@debian.org>
In-Reply-To: <20260605-getsockopt_smc-v1-0-65da62fa44c4@debian.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6628; i=leitao@debian.org;
 h=from:subject:message-id; bh=3dPr7qEVvxmzqp5Fa68RHp4F3vW5/2Q/V40NwuplFpg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIr1qlb+aNt6A0tAWKYvap0Vpdt/edGJZQ6XHG
 i0dJttj2k6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiK9agAKCRA1o5Of/Hh3
 bSqnD/9aZpOTD0RZsKZbziT9z+aDoKf+Xw1RatCpANzHyubQazRzHF+T13BySpQNQvrQDLl94Z8
 jXErk1WB1mcxWZ+wXKTvXT9CS74NP6O+PsAKYyObIC5z2HGMPtwzEWVCKxCarolZuXERmf2zu4K
 ABLPLo2bZbR4YVeXjX8e3RBbq9IG/vFb5U+4+mh/24qHAAv/W8i3tp2M8mn89ngmW+hhmwQJPHr
 aXevJKErr5GDvnFl3ho9EK5dq4xBpFWE7vsic5hv9482jfsb8/9Epsne75OesKyzMdXmt40Am7h
 JW+0EQfsiqz1nu0K78Oe+P21SHQa7ITtmq0vK1Hz5wwsef3ijPkTns555IVz6w4jMfFBAB0KSRy
 0+xj0O24HFwWfuBBHJ/IJfY58BlKFCN6K9eguSvCc7ma7BHwrNUjQUFFHSvU7CZLS7kqMUeASPI
 GVI+nuRT1FbAnrSVaggd+JdgBafZWywzzMmxq8f9LggEOz0/1jur4o8Wkn9XWuPKfgMc9mNK9df
 inlYDAukb8PfDlN0GuL4T4pP3KnYLH/rhpNLsPMwh4r6nkIV3FiftoQkFao8xjvx/NEbIdcZIAa
 XVsMJ3n+DHAo3psms8LII+EcNq1IjLPLe0V2R09CpHVuWeZMcdxu684wd7O7LMlO14D3RQl5D2M
 j3/liRQy2BBJIpw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-21837-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3783A648114

Add a kselftest that exercises the SMC getsockopt() paths converted to
the getsockopt_iter() / sockopt_t callback:

- SOL_SMC options (SMC_LIMIT_HS), handled directly by smc_getsockopt(),
  which returns the int value through copy_to_iter() and reports the
  written length in opt->optlen.

- The CLC pass-through (e.g. SOL_TCP), where smc_getsockopt() forwards to
  the underlying TCP socket: optval is reconstructed from iter_out, the
  optlen pointer is forwarded, and the clamped length is mirrored back
  through opt->optlen. The oversized-buffer case (input optlen differs
  from output) specifically guards against a missing writeback sync.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/getsockopt_smc.c | 175 +++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5ca6c557fc3f..5b50f718dbde 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -177,6 +177,7 @@ TEST_GEN_PROGS := \
 	bind_wildcard \
 	epoll_busy_poll \
 	getsockopt_iter \
+	getsockopt_smc \
 	icmp_rfc4884 \
 	ipv6_fragmentation \
 	proc_net_pktgen \
diff --git a/tools/testing/selftests/net/getsockopt_smc.c b/tools/testing/selftests/net/getsockopt_smc.c
new file mode 100644
index 000000000000..239deefb3187
--- /dev/null
+++ b/tools/testing/selftests/net/getsockopt_smc.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Exercise the SMC getsockopt() paths that were converted to the
+ * getsockopt_iter() / sockopt_t callback.
+ *
+ * Two distinct paths are covered:
+ *
+ *   - SOL_SMC options (SMC_LIMIT_HS) are handled directly by
+ *     smc_getsockopt(), which returns the int value through copy_to_iter()
+ *     and reports the written length in opt->optlen.
+ *
+ *   - Other levels (e.g. SOL_TCP) are forwarded to the underlying CLC (TCP)
+ *     socket, whose getsockopt() still operates on __user buffers. The
+ *     converted smc_getsockopt() reconstructs the userspace optval from
+ *     iter_out, forwards the original optlen pointer, and mirrors the length
+ *     the clcsock reported back into opt->optlen so the core writes the right
+ *     value to userspace.
+ *
+ * The kernel-buffer (kvec) path of the CLC pass-through returns -EOPNOTSUPP
+ * and is not reachable from a userspace getsockopt(), so it is not tested
+ * here.
+ *
+ * Author: Breno Leitao <leitao@debian.org>
+ */
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <sys/socket.h>
+
+#include "kselftest_harness.h"
+
+#ifndef AF_SMC
+#define AF_SMC 43
+#endif
+#ifndef SMCPROTO_SMC
+#define SMCPROTO_SMC 0
+#endif
+#ifndef SOL_SMC
+#define SOL_SMC 286
+#endif
+#ifndef SMC_LIMIT_HS
+#define SMC_LIMIT_HS 1
+#endif
+
+FIXTURE(smc) {
+	int fd;
+};
+
+FIXTURE_SETUP(smc)
+{
+	self->fd = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC);
+	if (self->fd < 0)
+		SKIP(return, "AF_SMC unavailable (errno %d) - load the smc module",
+		     errno);
+}
+
+FIXTURE_TEARDOWN(smc)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+/* ---------- SOL_SMC: handled directly by smc_getsockopt() ---------- */
+
+/* SMC_LIMIT_HS is reported back as a 4-byte int via copy_to_iter(). */
+TEST_F(smc, limit_hs_default)
+{
+	socklen_t optlen = sizeof(int);
+	int val = 0xdeadbeef;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_SMC, SMC_LIMIT_HS, &val, &optlen));
+	EXPECT_EQ(sizeof(int), optlen);
+	EXPECT_TRUE(val == 0 || val == 1);
+}
+
+/* A value set via setsockopt() must be readable back unchanged. */
+TEST_F(smc, limit_hs_set_get)
+{
+	socklen_t optlen = sizeof(int);
+	int val = 1;
+
+	ASSERT_EQ(0, setsockopt(self->fd, SOL_SMC, SMC_LIMIT_HS, &val, optlen));
+
+	val = -1;
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_SMC, SMC_LIMIT_HS, &val, &optlen));
+	EXPECT_EQ(sizeof(int), optlen);
+	EXPECT_EQ(1, val);
+}
+
+/* setsockopt() stores !!val, so a non-1 truthy value reads back as 1. */
+TEST_F(smc, limit_hs_set_get_clear)
+{
+	socklen_t optlen = sizeof(int);
+	int val = 0;
+
+	ASSERT_EQ(0, setsockopt(self->fd, SOL_SMC, SMC_LIMIT_HS, &val, optlen));
+
+	val = -1;
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_SMC, SMC_LIMIT_HS, &val, &optlen));
+	EXPECT_EQ(sizeof(int), optlen);
+	EXPECT_EQ(0, val);
+}
+
+/* An oversized buffer is clamped: optlen is reported back as sizeof(int). */
+TEST_F(smc, limit_hs_oversize_clamped)
+{
+	socklen_t optlen;
+	char buf[16] = {};
+
+	optlen = sizeof(buf);
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_SMC, SMC_LIMIT_HS, buf, &optlen));
+	EXPECT_EQ(sizeof(int), optlen);
+}
+
+/* An unknown SOL_SMC option is rejected with -EOPNOTSUPP. */
+TEST_F(smc, bad_optname)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SMC, 0x7fff, &val, &optlen));
+	EXPECT_EQ(EOPNOTSUPP, errno);
+}
+
+/* ---------- CLC pass-through: forwarded to the underlying TCP socket ------ */
+
+/* A TCP option set on the SMC socket is applied to the CLC socket and must be
+ * readable back through the pass-through, exercising optval reconstruction.
+ */
+TEST_F(smc, clc_tcp_nodelay_set_get)
+{
+	socklen_t optlen = sizeof(int);
+	int val = 1;
+
+	ASSERT_EQ(0, setsockopt(self->fd, IPPROTO_TCP, TCP_NODELAY,
+				&val, optlen));
+
+	val = -1;
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_NODELAY,
+				&val, &optlen));
+	EXPECT_EQ(sizeof(int), optlen);
+	EXPECT_EQ(1, val);
+}
+
+/* With an oversized buffer the clcsock clamps the reported length to
+ * sizeof(int). That length is produced by the clcsock writing the user optlen
+ * pointer, and must be mirrored back through opt->optlen; since the input
+ * optlen (16) differs from the output (4), this fails if the writeback sync
+ * in smc_getsockopt() is missing.
+ */
+TEST_F(smc, clc_tcp_nodelay_oversize_clamped)
+{
+	socklen_t optlen;
+	char buf[16] = {};
+
+	optlen = sizeof(buf);
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_NODELAY,
+				buf, &optlen));
+	EXPECT_EQ(sizeof(int), optlen);
+}
+
+/* An error from the clcsock (unknown TCP option) is propagated unchanged. */
+TEST_F(smc, clc_bad_optname)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, IPPROTO_TCP, 0x7fff, &val, &optlen));
+	EXPECT_EQ(ENOPROTOOPT, errno);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0-Meta


