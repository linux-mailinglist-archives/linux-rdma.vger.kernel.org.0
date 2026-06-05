Return-Path: <linux-rdma+bounces-21832-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GLBIIHioImp/bgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21832-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:44:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE264773E
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=Hz0N0Fi9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21832-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21832-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 069FE3047BCE
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9154B8DFA;
	Fri,  5 Jun 2026 10:32:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5F413639;
	Fri,  5 Jun 2026 10:31:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655520; cv=none; b=d6gwy4q0h4gWP3FC1lrILCF1BqfsDE4OZiB/wvq1mgwTsmgc2SxT7VThX4bMsY08PAd3Ckl0eajyRZ8nVP/pMN0SVoYCVF2J3BP31XuvAbVn+Z+vHcSfM4kgij6bazVP2zaTgCun0NigJxUlPL7Bjle1VapxUcncrzwsxn5JeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655520; c=relaxed/simple;
	bh=2T4DFLH/MMXVWsdzGqJxGHAK4SGM4EQq5vtnTmZSHVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POmtwm000C0F12qLWT8+lHjKQr22qKdAkmzbaMwmJ5SDmm3caexCPfu/b2OM9EPiLcOsbP1kUXYEgrcQoR9W2innEEGyB+jPg00urMn18zNvzEZHxVWNGvIAlDzSs8la4l9em+W48fxvU1T+xgrT+ktEPEhuaOm+SfMVDrBNaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Hz0N0Fi9; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=AFPyGQV821OzzmRoEExC4e6wLm4TD6TcSsxTuBRLxCI=; b=Hz0N0Fi9jjp9xAmvN1XWmbC7u1
	zWy60yIezbN8+T3K17vHrP4B1g00Uc6c+WLSuXvDevnNKZ2CIYcKU34qD3DSEUUPuXzvFqCUcYUL6
	JxF9+PaiVTqFNclbgMDZ+DR/j/Zh3pbneWtcFwvBiaWb6I/xOjTq/JfjTzw3MiSQDIgrP3uOkyhsp
	TqUuM/SN9G6p39BuPUc7/TjhUEpVaGPRmxm6Gk85P+TDKNPLDC9P8zDQuGlNkBUtHGR1tTmn+WYsk
	anH19nmGGJmQXSTHmWgsPIRh7s6stT5/ofUni4w9KQo4KA5tTin8EbDNlXhArmfxMJC6Xhntgq2Dh
	GuEsi+QQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVRqE-005EEy-0p;
	Fri, 05 Jun 2026 10:31:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 03:31:39 -0700
Subject: [PATCH net-next v2 2/3] selftests: net: rds: add getsockopt()
 conversion test
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-getsock_more-v2-2-80f38cdb8706@debian.org>
References: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
In-Reply-To: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7861; i=leitao@debian.org;
 h=from:subject:message-id; bh=2T4DFLH/MMXVWsdzGqJxGHAK4SGM4EQq5vtnTmZSHVc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIqWNApY8c+8Dghkx5y6kcWMqSLt0jZk/ZtPJ3
 SCOlJ0sjweJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiKljQAKCRA1o5Of/Hh3
 bcpLD/9OPqR/AQ6JKDhvMzIm29l9yHBNo11ZkJgqoLZvapjSkyqS7Poovsw6rWf7dtnvBpwgooJ
 tcEskyY1vNkDqNU7jwvYC3pxhu6o45RH4glon3LvTFTMpMGcuyCAEHsZvZ7i79+yZ8x1mpZnlZi
 GEbeC/67BEB3RHFSwahh+Gm7cy1+o1KiwmWqUhSgwAuxM5xB5AFXo0RFow/FjFPl+ySgdcC6tqS
 4MRvLRqd2nEy8ZBfcDvv+8ZgHSAF1KdmLU7Q6xDFloypw0C6nDwEm6g/Ic21X2DW6x8uRXCwT78
 YP5HM6y4X13MUqNmk8WoLcqyNEOw7ONYaM3HPB2nPuYdkqbM6maMnn5AvZEsHCvRobV1/NRgkT5
 FRFoXmPyEIO2hboM2Pv4ETfBY+V+w/Sk3MwqEgp/ZWzekaX7/lSHakIV1enQDVpyCJ16BHcH8Rg
 baEgCOyoumgLjfd6hjWI3JBnS/H48YWp9yLzD0yGVMD4wentPIdcdzDY51PCS/Zhpzy5me0nvTx
 7AsgFEBCMfVsqkQK91UZ32jyYLA2dTv/xxjs3a5fJgb7RVknTaQKnB8ZlJo6MiRYu1f5g6V3TrC
 AH8ZtKppGaDxA8QjWVks9PitmiilP3I5XVyissC3GqqZgYpftOeFMEDjmmz1ty97de9Ht3T1VE/
 5YfXBMxXOOc6U8g==
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
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21832-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,include.sh:url,run.sh:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEBE264773E

Add a kselftest that exercises the RDS getsockopt() paths converted to
the getsockopt_iter() / sockopt_t callback:

- RDS_RECVERR and SO_RDS_TRANSPORT, which return their int value through
  copy_to_iter() and report the written length in opt->optlen.

- RDS_INFO_*, which obtains the userspace buffer pages with
  iov_iter_extract_pages() (including a non-zero starting page offset)
  and lets the info producers copy the snapshot in under a spinlock.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/rds/.gitignore   |   1 +
 tools/testing/selftests/net/rds/Makefile     |   4 +
 tools/testing/selftests/net/rds/getsockopt.c | 208 +++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)

diff --git a/tools/testing/selftests/net/rds/.gitignore b/tools/testing/selftests/net/rds/.gitignore
index 1c6f04e2aa11..7ca4b1440f51 100644
--- a/tools/testing/selftests/net/rds/.gitignore
+++ b/tools/testing/selftests/net/rds/.gitignore
@@ -1 +1,2 @@
 include.sh
+getsockopt
diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index fe363be8e358..0700d8298eec 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -5,6 +5,8 @@ all:
 
 TEST_PROGS := run.sh
 
+TEST_GEN_PROGS := getsockopt
+
 TEST_FILES := \
 	include.sh \
 	settings \
@@ -16,4 +18,6 @@ EXTRA_CLEAN := \
 	/tmp/rds_logs \
 # end of EXTRA_CLEAN
 
+CFLAGS += $(KHDR_INCLUDES)
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/rds/getsockopt.c b/tools/testing/selftests/net/rds/getsockopt.c
new file mode 100644
index 000000000000..93ff252c69b8
--- /dev/null
+++ b/tools/testing/selftests/net/rds/getsockopt.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Exercise the RDS getsockopt() paths that were converted to the
+ * getsockopt_iter() / sockopt_t callback.
+ *
+ * Three distinct paths are covered:
+ *
+ *   - RDS_RECVERR and SO_RDS_TRANSPORT, which now return their int value
+ *     through copy_to_iter() and report the written length in opt->optlen.
+ *
+ *   - RDS_INFO_*, which pins the userspace buffer with
+ *     iov_iter_extract_pages() (including a non-zero starting page offset)
+ *     and lets the info producers memcpy the snapshot in under a spinlock.
+ *
+ * The kvec (in-kernel buffer) -> -EOPNOTSUPP path of rds_info_getsockopt()
+ * is not reachable from a userspace getsockopt() and so is not tested here.
+ */
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <linux/rds.h>
+
+#include "../../kselftest_harness.h"
+
+#ifndef AF_RDS
+#define AF_RDS 21
+#endif
+
+FIXTURE(rds) {
+	int fd;
+};
+
+FIXTURE_SETUP(rds)
+{
+	self->fd = socket(AF_RDS, SOCK_SEQPACKET, 0);
+	if (self->fd < 0)
+		SKIP(return, "AF_RDS unavailable (errno %d) - load the rds module",
+		     errno);
+}
+
+FIXTURE_TEARDOWN(rds)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+/* RDS_RECVERR defaults to 0 and is reported back as a 4-byte int. */
+TEST_F(rds, recverr_default)
+{
+	socklen_t len = sizeof(int);
+	int val = 0xdeadbeef;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_RDS, RDS_RECVERR, &val, &len));
+	EXPECT_EQ(sizeof(int), len);
+	EXPECT_EQ(0, val);
+}
+
+/* A value set via setsockopt() must be readable back unchanged. */
+TEST_F(rds, recverr_set_get)
+{
+	socklen_t len = sizeof(int);
+	int val = 1;
+
+	ASSERT_EQ(0, setsockopt(self->fd, SOL_RDS, RDS_RECVERR, &val, len));
+
+	val = 0;
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_RDS, RDS_RECVERR, &val, &len));
+	EXPECT_EQ(sizeof(int), len);
+	EXPECT_EQ(1, val);
+}
+
+/* A buffer smaller than an int is rejected with EINVAL, not silently. */
+TEST_F(rds, recverr_short_buffer)
+{
+	socklen_t len = sizeof(int) - 1;
+	char buf[sizeof(int)];
+
+	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, RDS_RECVERR, buf, &len));
+	EXPECT_EQ(EINVAL, errno);
+}
+
+/* An unbound socket reports RDS_TRANS_NONE for SO_RDS_TRANSPORT. */
+TEST_F(rds, transport_unbound)
+{
+	socklen_t len = sizeof(int);
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_RDS, SO_RDS_TRANSPORT, &val,
+				&len));
+	EXPECT_EQ(sizeof(int), len);
+	EXPECT_EQ(RDS_TRANS_NONE, (unsigned int)val);
+}
+
+TEST_F(rds, transport_short_buffer)
+{
+	socklen_t len = sizeof(int) - 1;
+	char buf[sizeof(int)];
+
+	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, SO_RDS_TRANSPORT, buf,
+				 &len));
+	EXPECT_EQ(EINVAL, errno);
+}
+
+/*
+ * RDS_INFO_COUNTERS with a zero-length buffer is the "probe" call: it must
+ * fail with ENOSPC and report the required snapshot size in optlen.
+ */
+TEST_F(rds, info_counters_probe)
+{
+	socklen_t len = 0;
+
+	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL,
+				 &len));
+	EXPECT_EQ(ENOSPC, errno);
+	EXPECT_GT(len, 0);
+	/* The snapshot is an array of fixed-size counter records. */
+	EXPECT_EQ(0, len % (socklen_t)sizeof(struct rds_info_counter));
+}
+
+/*
+ * A real snapshot into an unaligned userspace buffer exercises the
+ * iov_iter_extract_pages() path, including the non-zero offset0 handling
+ * that the patch reworked. Place the buffer at a non-page-aligned address
+ * spanning into the next page to make sure multi-page pinning works too.
+ */
+TEST_F(rds, info_counters_snapshot)
+{
+	struct rds_info_counter *ctr;
+	socklen_t need = 0, len;
+	long pagesz = sysconf(_SC_PAGESIZE);
+	size_t offset, map_len;
+	unsigned int i, n;
+	char *region, *buf;
+	int ret;
+
+	/* Probe for the required size. */
+	getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL, &need);
+	ASSERT_GT(need, 0);
+
+	/*
+	 * Place the buffer at a non-page-aligned offset that runs past the
+	 * first page boundary, and size the mapping from the probed length so
+	 * the test keeps working if the counter set grows.
+	 */
+	offset = pagesz - 64;
+	map_len = ((offset + need + pagesz - 1) / pagesz) * pagesz;
+
+	region = mmap(NULL, map_len, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, region);
+
+	buf = region + offset;
+
+	/*
+	 * On success the RDS_INFO path returns the positive per-element size
+	 * (lens.each) rather than 0, and writes the full snapshot length back
+	 * into optlen.
+	 */
+	len = need;
+	ret = getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, buf, &len);
+	ASSERT_GE(ret, 0) {
+		TH_LOG("getsockopt snapshot failed: errno %d", errno);
+	}
+	EXPECT_EQ(sizeof(struct rds_info_counter), ret);
+	EXPECT_EQ(need, len);
+
+	/* The counter names must be NUL-terminated, non-empty strings. */
+	ctr = (struct rds_info_counter *)buf;
+	n = len / sizeof(*ctr);
+	ASSERT_GT(n, 0);
+	for (i = 0; i < n; i++) {
+		size_t namelen = strnlen((char *)ctr[i].name,
+					 sizeof(ctr[i].name));
+
+		EXPECT_GT(namelen, 0);
+		EXPECT_LT(namelen, sizeof(ctr[i].name));
+	}
+
+	munmap(region, map_len);
+}
+
+/*
+ * A non-zero but too-small buffer must report ENOSPC and the full required
+ * length, without corrupting memory past the buffer.
+ */
+TEST_F(rds, info_counters_short_buffer)
+{
+	socklen_t need = 0, len;
+	char small[sizeof(struct rds_info_counter)];
+
+	getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL, &need);
+	ASSERT_GT(need, 0);
+
+	/* Ask with a buffer guaranteed smaller than the full snapshot. */
+	if (need <= (socklen_t)sizeof(small))
+		SKIP(return, "snapshot fits in one record; nothing to test");
+
+	len = 1; /* < sizeof(struct rds_info_counter) */
+	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, small,
+				 &len));
+	EXPECT_EQ(ENOSPC, errno);
+	EXPECT_EQ(need, len);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0-Meta


