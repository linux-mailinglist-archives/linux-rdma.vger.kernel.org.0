Return-Path: <linux-rdma+bounces-21613-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C2GAhFlHmrCiwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21613-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:07:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC646285E7
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA043301435E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 05:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00694306774;
	Tue,  2 Jun 2026 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBsDfV0V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD282F8E94;
	Tue,  2 Jun 2026 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376822; cv=none; b=sm9ZD7qdqIv564akxi6QaT4h0m3v8sRby/mt5O7055iso+oEJcjjOnzpaFrc5D5sdt/znNCBpqxaJgeomQ2fkYgwW0s1SzpbqzojqmyPI5bIscznyFVajIzI4vpWQD3wpKXL1Cv+OlXdU1oUKf6MTbXHp7YCcdY8uLjQ6Aot0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376822; c=relaxed/simple;
	bh=CNgjG8SV6Pq4+/vr+VXh9zDfz3VVxkcCurCut7tIjHQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uERKgvolqT4zuSABP2hJACdd4gOoydMj02TzaPq/6R8hTbCfP1NfwniuEU7FV5V3TvRqfCXZOq0V8FWz7B5wjc42bN0kwd/jrRks5qY34cpdilvLo9jbVxOCEQBU1JcAO/mDM7T1unfS71aYBEk9NLs3SzgEmj8PxL2iiXYIN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBsDfV0V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9271F00899;
	Tue,  2 Jun 2026 05:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780376821;
	bh=yAMKPTUjtBEliG+62lAUdZD0yrg9IiiJfCa+lSi9HHE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=eBsDfV0V7UPvdaiWUl1jFd60rwxehazIKUoHorYO9znCGi0R8LCWNWIHBU4x9bqET
	 8y/oMcdUcJ0xPjB0h5LbLFbYxOoKgxf202DDJqYqwZRr6oqx6kjVhErQ/nWnD3QnIb
	 nkPzFFs7ZfRS3PljKXrVcu6SletDKHkEBgsq016I96GVu830CvpWBk8UeLSeRYCSF3
	 uC4muYCjlP8cpCBZiVq4eJlTI6Q8gII5lCSjg3x0RXQrgZb+q3ONOoohAParVEtA+M
	 Lgy1D8z9tKtoD6qF5WwiaYAXE0TTBbiZzx7EWKFxKTMikXX3a5eSjjFz1ECMdd8m7J
	 oDjk9FUoCBtEg==
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
Subject: [PATCH net-next v3 3/4] selftests: rds: support RDS built as loadable modules
Date: Mon,  1 Jun 2026 22:06:56 -0700
Message-Id: <20260602050657.26389-4-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260602050657.26389-1-achender@kernel.org>
References: <20260602050657.26389-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21613-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.sh:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,run.sh:url]
X-Rspamd-Queue-Id: ABC646285E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 92cc6708f4a2 ("selftests: rds: config: disable modules") set
CONFIG_MODULES=n since run.sh required this kconfig. But disabling
modules also forces every =m option to =n rather than =y, which can
silently drop unrelated features.

This patch removes CONFIG_MODULES=n from the rds selftest config and
updates the check_*conf_enabled() routines to accept a config as
either built-in (=y) or modular (=m). A new probe_module() function
is added to load the backing module when a component is set to be
modular (=m).  config.sh no longer forces CONFIG_MODULES=n, so a user
who follows the SKIP message to run config.sh does not silently end
up with modules disabled again.

rds.ko itself is auto-loaded on socket creation, and rds_rdma.ko is
auto-loaded when SO_RDS_TRANSPORT is set with RDS_TRANS_IB, but the
TCP transport (rds_tcp.ko) is not auto-loaded on the bind path, so
the backing modules are loaded explicitly here.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/config     |  1 -
 tools/testing/selftests/net/rds/config.sh  |  3 --
 tools/testing/selftests/net/rds/rds_run.sh | 60 ++++++++++++++--------
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/selftests/net/rds/config
index 3d62d0c750a80..97db7ecb892aa 100644
--- a/tools/testing/selftests/net/rds/config
+++ b/tools/testing/selftests/net/rds/config
@@ -1,4 +1,3 @@
-CONFIG_MODULES=n
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_NETEM=y
 CONFIG_RDS=y
diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
index be0668359a070..2df2226310efe 100755
--- a/tools/testing/selftests/net/rds/config.sh
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -37,9 +37,6 @@ if [[ "$CONF_FILE" != "" ]]; then
 	FLAGS=(--file "$CONF_FILE")
 fi
 
-# no modules
-scripts/config "${FLAGS[@]}" --disable CONFIG_MODULES
-
 # enable RDS
 scripts/config "${FLAGS[@]}" --enable CONFIG_RDS
 scripts/config "${FLAGS[@]}" --enable CONFIG_RDS_TCP
diff --git a/tools/testing/selftests/net/rds/rds_run.sh b/tools/testing/selftests/net/rds/rds_run.sh
index 63080fef492b7..f01c81415331f 100755
--- a/tools/testing/selftests/net/rds/rds_run.sh
+++ b/tools/testing/selftests/net/rds/rds_run.sh
@@ -93,38 +93,58 @@ check_gcov_conf()
 	fi
 }
 
+# Checks if a kconfig is enabled (set to =y or =m)
+# $1: kconfig symbol to check
+# $2: (optional) module name backing $1
+#     Ex: check_conf_enabled CONFIG_RDS_TCP rds_tcp
+#     Modules for configs set to  =m will be probed
+#     If omitted, only a built-in (=y) config is accepted.
+# Returns on success.  exits 4 on failure
 # Kselftest framework requirement - SKIP code is 4.
 check_conf_enabled() {
-	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
-		echo "selftests: [SKIP] This test requires $1 enabled"
-		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
-		exit 4
+	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		return
 	fi
+	if [ -n "${2:-}" ] && grep -x "$1=m" "$kconfig" > /dev/null 2>&1; then
+		probe_module "$2"
+		return
+	fi
+	echo "selftests: [SKIP] This test requires $1 enabled"
+	echo "Please run" \
+	     "tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
+	exit 4
 }
 
 check_rdma_conf_enabled() {
-	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
-		echo "selftests: [SKIP] rdma transport requires $1 enabled"
-		echo "To enable, run " \
-		     "tools/testing/selftests/net/rds/config.sh -r and rebuild"
-		exit 4
+	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		return
+	fi
+	if [ -n "${2:-}" ] && grep -x "$1=m" "$kconfig" > /dev/null 2>&1; then
+		probe_module "$2"
+		return
 	fi
+	echo "selftests: [SKIP] rdma transport requires $1 enabled"
+	echo "To enable, run" \
+	     "tools/testing/selftests/net/rds/config.sh -r and rebuild"
+	exit 4
 }
 
-check_conf_disabled() {
-	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
-		echo "selftests: [SKIP] This test requires $1 disabled"
-		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
+# Load the module backing a config that is built as a loadable module
+# (=m).  Built-in (=y) configs are already available and don't reach
+# here.  Exits with the SKIP code if a required module cannot be loaded.
+probe_module() {
+	if ! modprobe -q "$1"; then
+		echo "selftests: [SKIP] could not load required module $1"
 		exit 4
 	fi
 }
+
 check_conf() {
-	check_conf_enabled CONFIG_NET_SCH_NETEM
-	check_conf_enabled CONFIG_VETH
+	check_conf_enabled CONFIG_NET_SCH_NETEM sch_netem
+	check_conf_enabled CONFIG_VETH veth
 	check_conf_enabled CONFIG_NET_NS
-	check_conf_enabled CONFIG_RDS_TCP
-	check_conf_enabled CONFIG_RDS
-	check_conf_disabled CONFIG_MODULES
+	check_conf_enabled CONFIG_RDS_TCP rds_tcp
+	check_conf_enabled CONFIG_RDS rds
 }
 
 # Check kernel config and host environment for RDS-RDMA support.
@@ -139,8 +159,8 @@ check_rdma_conf()
 
 	# Kconfig will enforce CONFIG_INFINIBAND_* as dependencies
 	# of CONFIG_RDMA_RXE
-	check_rdma_conf_enabled CONFIG_RDMA_RXE
-	check_rdma_conf_enabled CONFIG_RDS_RDMA
+	check_rdma_conf_enabled CONFIG_RDMA_RXE rdma_rxe
+	check_rdma_conf_enabled CONFIG_RDS_RDMA rds_rdma
 
 	if ! which rdma > /dev/null 2>&1; then
 		echo "selftests: [SKIP] rdma transport requires the 'rdma'" \
-- 
2.25.1


