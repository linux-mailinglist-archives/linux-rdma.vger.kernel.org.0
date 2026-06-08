Return-Path: <linux-rdma+bounces-21948-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2d9bCm2PJmoDYwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21948-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:46:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EF654B62
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:46:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=BVufzDzR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21948-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21948-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F36DF300B44B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA543B7757;
	Mon,  8 Jun 2026 09:46:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1603128D7;
	Mon,  8 Jun 2026 09:46:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911969; cv=none; b=IKyRefRVnAf73RAvMe50MZvzvIa/VL7y39+6w6wvkzQmqOaswkzR1wTg3vyZigdHaACu2KjhPXDHktL4OzQhx/BO0csyKPvOi0NUI+msw/8r3ClAAJfunvL1kuqFYEejzJAwhTnT4at0DU28FvHqgv5cs6zrfTn/OyeYz4DtXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911969; c=relaxed/simple;
	bh=7Lnff3lrOykS37Nvu7sljWuliyhmiN5l5Y3E6FSLzhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUK4fK0vIDrFwqJgV6K1BuO7VVP1Z8N9QAchvhvMtsrBVJsVDflMPrZG3H5/wJO5S0OdFIRkK8AeUZgir6Oc1nK1/VxrQgnrwYsSKGEjhjUAI76s2yanR674qAveiTJdoRM2Ytnb20bDXWjHtjd57dWmtZRT4OsFGqGu2ZUlL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BVufzDzR; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ITrB8xKMHtvrcVWLyBW/3/P/PHbL1WS8+urkrZKIf7g=; b=BVufzDzRuRtyCI0RZyXw805eCx
	L2krLPmTfvDLrjbUJDCvFleNV78y7nYp3ISWeNuDdXVB3tFKNoBAxFrhR3JNxAoGmDI1D5/kBWcLr
	sdYRuO17O34fOGC6BA6YFB+X/GaiMLmhTGUlwvxCW0ocD9TQS8YFlY2PXR2072R9va3N5hTcqsQCx
	3qbhCgbD0d+U4fLZjAjNKU6jiN22qkPa9YvF1aAT++RARSJCkfVBGHII+1wfzph+psO6YmPlUO9+I
	h7iIBzITnJcJgOU7hE4i4Vy/mSc0cOHWd2EgDgGxh17B9Ucx7FZ7BpYTOxBD9NJPz1a9rK1vmMupe
	qtSuQSzQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWWYW-007XGV-2O;
	Mon, 08 Jun 2026 09:46:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 08 Jun 2026 02:44:57 -0700
Subject: [PATCH net-next v3 1/2] selftests: net: rds: add getsockopt()
 conversion test
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-getsock_more-v3-1-706ecf2ea332@debian.org>
References: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
In-Reply-To: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Andy Grover <andy.grover@oracle.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7956; i=leitao@debian.org;
 h=from:subject:message-id; bh=7Lnff3lrOykS37Nvu7sljWuliyhmiN5l5Y3E6FSLzhw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJo9UchojaNQM7ENoq5zv/C7SqvqxjsS2jgqYm
 /xH+bm8FPSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiaPVAAKCRA1o5Of/Hh3
 bUpGEACJaHqqoGblszhnp9+u1ghjnL7Xyv6If8p+45k1rq5LUIimRYHU9Ms3lGGpGYQAWS+jjjB
 ivDiQgE7m8KaoQOWY6Z5TqbV+/J0rQOSVHfXEKuWDixkBp5uegu7w49v357NgPE88bekZvQvSWO
 DIdm67ss+SMNIgwKHYA0vjZXoJNHzLRmsDnM0/tDo8XZM2QvNAlqtuRTsugL+TjhUAnQCgHgFbP
 RFziiwd6go6cJ/6j5RiIi8u0rSntxoStXJp1DRD8cPjhVohBrF98XW58HYpeW+7pGrNyyrqqGw3
 NJLy3vQvK1+lwAH6r3On18r4j0XvqNJ7SEpfENPI25uUyhmn2C8FKyMTbYjeyKe40Ual72IzFHs
 MuGmYmLSN2NRb5j2G1l1KGfLPsVE+bLpSRwvsJDHdJMkUhBiyfK5dbRuRMoFJxVtsgfPWkmRgak
 PpeuG0RhNOxQIH/O6LADxmNjhzUe+yN+117P4asMYEU6Ykvtsj0BufQL3UPnYDg0zdz9s/0PhzI
 8c5Oh6b4e1wnujaKqSTj9aVutk3yFeKTSyBZGqFsdm89f/CPIJXJicM4ZIvk8TD+pmmJCNRivGH
 0ppV5vm8QqDKxAGtcS4hM2VGV7oTV8+F0423m0Ku/6JvOP0+KUi4fWPhrr3SB7vruyGi3PLT7Wn
 us2oCtcUxrDK2Ew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andy.grover@oracle.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21948-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,rds_run.sh:url,include.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B50EF654B62

Add a kselftest that exercises the RDS getsockopt() paths converted to
the getsockopt_iter() / sockopt_t callback:

- RDS_RECVERR and SO_RDS_TRANSPORT, which return their int value through
  copy_to_iter() and report the written length in opt->optlen.

- RDS_INFO_*, which obtains the userspace buffer pages with
  iov_iter_extract_pages() (including a non-zero starting page offset)
  and lets the info producers copy the snapshot in under a spinlock.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
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
index ec10ae24e4cf..ab9e92399a6d 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -5,6 +5,8 @@ all:
 
 TEST_PROGS := rds_run.sh
 
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


