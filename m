Return-Path: <linux-rdma+bounces-21167-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMssIv3QEGpyeAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21167-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:56:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA05BACEB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230AB3028EE6
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B543905EA;
	Fri, 22 May 2026 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YboC3JBS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90B38F926;
	Fri, 22 May 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486875; cv=none; b=LwO8JddeZbXmo741Bk3oFi0TldlWdGsNBeYSIVatuNF9C0VDL8ZonGZkTW5E3yFcIVdIV02VtyTpu1Q5LBb+ASriir7s01/4+igxfEr6+/Y1O/hgHVD8i5RuScDjVtQmAUSK8qFxXXDEL8if7EOe4XS01zq7k3BAN1k/3gplNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486875; c=relaxed/simple;
	bh=GgVz6mqUKYuCPCw9PAGYZypOY0vEblhSwnfTfFs+vBc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcPPiZ5BDIDufxfqMs7wdChAdVZmhp/pAamnpD8po7iZif1S1UWxkPzN5tE5NNJvnqnSUicc55dUlsx9qsIfwkJRN/atNK+2mS0ERbUwixLU+FCT7GuLRjvG23hNOAqSaUuXwW6PWfkW7YRuVz0abzetlO6a/scRMO0SHv8xxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YboC3JBS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287121F000E9;
	Fri, 22 May 2026 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486873;
	bh=Y7T53dr0VjlpunpDWs+IH7/+oHsZ7PTfP26P1R8z0RM=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=YboC3JBSE1bVRWLykwLHGJIRtakF4RhQZt7g/ezdOQkhZnprqGGJCFsR+3rMu/yHl
	 yC9ExTR4mOMYftXmIxlUOejNt3rr1o1toY0tTrZEvGIWtBMC4ksMd+NkEFOddZ4loX
	 5xZApBzhFs5SB8rYtGu+soAV1qTNjBIdh/98yle5HnP6PCjg5dICQJ7viSambAxCmH
	 gn8khtxnF9WDebBR9FlAHGdYqDHcQGZkDynFMatXiCYsCqtvKRTXABiOzVpcIXXnPw
	 Tw4Gw8zDh6q4J00FYbaDzLscn+0ReGwBU7EM0BnQWq/ILiXbz83rBwljRZfvhj5u7i
	 hfaAhq8zvQMiA==
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
Subject: [PATCH net-next v1 3/3] selftests: rds: support RDS built as loadable modules
Date: Fri, 22 May 2026 14:54:30 -0700
Message-Id: <20260522215430.3748226-4-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522215430.3748226-1-achender@kernel.org>
References: <20260522215430.3748226-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21167-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,run.sh:url]
X-Rspamd-Queue-Id: F3EA05BACEB
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
modular (=m).

rds.ko itself is auto-loaded on socket creation, and rds_rdma.ko is
auto-loaded when SO_RDS_TRANSPORT is set with RDS_TRANS_IB, but the
TCP transport (rds_tcp.ko) is not auto-loaded on the bind path, so
the backing modules are loaded explicitly here.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/config     |  1 -
 tools/testing/selftests/net/rds/rds_run.sh | 59 ++++++++++++++--------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/selftests/net/rds/config
index 3d62d0c750a80..97db7ecb892aa 100644
--- a/tools/testing/selftests/net/rds/config
+++ b/tools/testing/selftests/net/rds/config
@@ -1,4 +1,3 @@
-CONFIG_MODULES=n
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_NETEM=y
 CONFIG_RDS=y
diff --git a/tools/testing/selftests/net/rds/rds_run.sh b/tools/testing/selftests/net/rds/rds_run.sh
index ef16039be1ae5..ff11cc7cc9773 100755
--- a/tools/testing/selftests/net/rds/rds_run.sh
+++ b/tools/testing/selftests/net/rds/rds_run.sh
@@ -93,38 +93,57 @@ check_gcov_conf()
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
+	echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
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
+	echo "To enable, run " \
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
@@ -139,8 +158,8 @@ check_rdma_conf()
 
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


