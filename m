Return-Path: <linux-rdma+bounces-19697-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBGQBjA18WltegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19697-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:31:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A948C9D3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46FE6311406B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC7387371;
	Tue, 28 Apr 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/hkkis9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBA3822A1;
	Tue, 28 Apr 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415242; cv=none; b=T61dS/jKc566HJlP/oPqVqZvj4Ba6WFc91x+YYFoctM7rSCH2LyBYLSgE0ggxODEKOowMqxXTuMtxHFSX+xVjCc/0NJmUco25McEUPpv1b9XSfBY5WLhCuIhRxYh4m4etn+z8NzwoARP2aT8RTkTd9rvrBhxrXythGJY7eBGEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415242; c=relaxed/simple;
	bh=QqLIPFFrNU4pGo791LfTUzK8uXHG4Bv2RCgS+awKohs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ivd73R9FASmL6ErfIoZgbeHaJWyqvurahmxYJGXwkoQW/de9VA6+9DK0s5oeznvPz0pormOLHm0JhQ3t3v7WOx0x7eIYSWhNw6TNmXypHwAMNAvK6E5VMB3mTCqfBjYuChcMycruZdtFwb5McpWnlz+fuHST7cYUrC6Mgwe7veY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/hkkis9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2A1C2BCF5;
	Tue, 28 Apr 2026 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415242;
	bh=QqLIPFFrNU4pGo791LfTUzK8uXHG4Bv2RCgS+awKohs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E/hkkis93Qc+42CbpIYMb0vxOcl1XMbqSGYUHJpNklaeqRT/NLdH4ZfkqKwKg0iCu
	 Vk+SFupeBPc/U7wLWKaUGrX4TYtFlumx5zJJ4pHVezjwnOOWBSCYl/FdpDNDP+E8/+
	 s79ahVlDrjiditV0yglbCIWCyPLr6QKFuys9D3xteOY+r/8kaNegviqGXrAOTG15/Q
	 GD1TtmllvtEP6k/nrX2a5CWj7wgqCbPxQEVZyieiye8YcPSuB4hsX2cPIAj4A4ypl+
	 zdY4bdYR+mC/SEFidpX7q3dwKdd8usJsaqZYH3a99yIFGgflnxChpG2mUsWgDb0Pmu
	 x4uJ/4XB68AQQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v2 5/7] selftests: rds: Fix gcov and pcap collection
Date: Tue, 28 Apr 2026 15:27:14 -0700
Message-Id: <20260428222716.2960871-6-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428222716.2960871-1-achender@kernel.org>
References: <20260428222716.2960871-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 695A948C9D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19697-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The vng guest shares the host filesystem via 9p and runs a minimal
systemd inherited from the host's /lib/systemd/system/. As a result,
which filesystems get auto-mounted in the guest depends on the host OS
and its systemd version.

The tcpdump pcaps are initially saved to /tmp because 9p does not support
chown which tcpdump requires. But whether /tmp is already a tmpfs depends
on the host's systemd configuration and may still sometimes fail if /tmp
is not mounted by default. Fix this by mounting tmpfs on /tmp in run.sh
when it is not already a separately mounted filesystem.

A similar dependency exists for gcov. debugfs is not mounted automatically
in vng guest, so the gcov data copy from /sys/kernel/debug/gcov/
silently finds nothing depending on whether debugfs is mounted by default
on the host OS. Fix this by mounting debugfs in run.sh before copying the
gcda files.

Finally, when invoked through the kselftest runner, the working directory
is the test directory rather than the kernel source root. gcovr defaults
--root to the current working directory, causing it to filter out all
coverage data for files under net/rds/ since they are not under the test
directory. Fix this by passing --root to gcovr explicitly.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/run.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index bc2e53126aab..3fc116d23410 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -197,6 +197,13 @@ COVR_DIR="${LOG_DIR}/coverage/"
 mkdir -p  "$LOG_DIR"
 mkdir -p "$COVR_DIR"
 
+# tcpdump saves pcaps to /tmp because it requires chown to save the
+# pcap but chown is not supported by 9p.  Mount tmpfs on /tmp if it is
+# not already a separate filesystem
+if ! mountpoint -q /tmp 2>/dev/null; then
+	mount -t tmpfs tmpfs /tmp
+fi
+
 set +e
 echo running RDS tests...
 echo Traces will be logged to "$TRACE_FILE"
@@ -210,6 +217,12 @@ dmesg > "${LOG_DIR}/dmesg.out"
 
 if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
        echo saving coverage data...
+
+       # Ensure debugfs is mounted
+       if ! test -d /sys/kernel/debug/gcov; then
+               mount -t debugfs debugfs /sys/kernel/debug 2>/dev/null || true
+       fi
+
        (set +x; cd /sys/kernel/debug/gcov; find ./* -name '*.gcda' | \
        while read -r f
        do
@@ -218,7 +231,7 @@ if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
 
        echo running gcovr...
        gcovr -s --html-details --gcov-executable "$GCOV_CMD" --gcov-ignore-parse-errors \
-             -o "${COVR_DIR}/gcovr" "${ksrc_dir}/net/rds/"
+             --root "${ksrc_dir}" -o "${COVR_DIR}/gcovr" "${ksrc_dir}/net/rds/"
 else
        echo "Coverage report will be skipped"
 fi
-- 
2.25.1


