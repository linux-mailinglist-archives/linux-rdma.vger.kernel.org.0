Return-Path: <linux-rdma+bounces-22957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GUobN3VyT2qjgwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 12:05:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4272F553
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 12:05:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=rZ0sIeyO;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22957-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22957-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 223723137BC2
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F138404BC0;
	Thu,  9 Jul 2026 09:56:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68E403EAE
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 09:56:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590982; cv=none; b=nC8AOTfMntT70HvUhPscGRPsqABxja2HdqpDxHfiLFyZJ2ZPEndWKdUfuxv7UkvDArsRQ40FiirhbHP3KxN5UQW2AxZPZyPGePZ3EhpOIO+YQgChXbDE2JBi9EPl4r7stBmyFCRvtCFPElZzVoiAqaOtWKOtB/co0+6ApihNdng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590982; c=relaxed/simple;
	bh=2weJseZmfhhuMkVl4mobPkyhlKlV9CmmuBH9aDTWvdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNjXKJi4CZEefJxKAp1KWQsnTgtj23FfcvWPs9336afhqe2oqpBTCS3JNRPMD4N6pBascx0M1f0YciOOrOIo0/E/XLXOEZPykyf6ekBYzOauL5ZJwJEiWTQkstNwTrRQw74J8zFquUnNPb2MZYAKt4Jz0ryO3X4DurEu7PZ1rsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=rZ0sIeyO; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1529957f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590979; x=1784195779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/tf5HNf/pTiFtMMkWJrXjHDGjF4y30NaNB9JlvlgwM=;
        b=rZ0sIeyOYmmDsf/qxuuinDtT6eXIk2Hm9TFIhDQ7VecjW/VKkcklSxIQD0MVpRYij5
         jRIwAAUz6cY1WhECaMa1OZ2eGVygtrE+hSaKRB0XbujkoHLIhD8uZ8rZ71l0tFDbJB5I
         1M05jxn2hNYqmelNZzHThr8Qd+MT0yuWRRdUQ9z+hVjWIFRJcsrU894zHVtW1CAW7Dp5
         rQfCxzxCllSEF+M5r/CrOkrJj3/oD4gL7b39zZSgWa4vy4JA32Rf2Xmyfbe8Qe0FhZNp
         OvaX0/ipUrhc0ckw4AQ+X26eYJrz2dQTNDG3VCltI8n/NDaJ252w/2bsjHXFIoIxvN2l
         YfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590979; x=1784195779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/tf5HNf/pTiFtMMkWJrXjHDGjF4y30NaNB9JlvlgwM=;
        b=mGW4/VwuuFM39GFubYUIFIWTYcpi3Ms3Udz3N0iWFow1Qt3cfrtDQIyssUlz+JSiJ/
         kBMc6NqDVqdpnC/MURuySCI7dg9Ogy7XvZysUd/hdu3uN7omYfZ0mqek1Rf5p9/z7WQp
         XPcTCZIlV1i6tIqPAK5rc7x74jfft0x37EL8giVkaz6UFsKLI+y6SNprfHJHUA3WZPDR
         1cfALqLPsrlQgpPolIfdh3UYQNkqgPvj1kh018yOEr2A/x58SyOaWoP2sqTatqgPioYW
         OJ0IBhp8g2TRYOHxOfW5Zxh2K4GO1ohd1bR8hR/Ep2BEPmpjAG9WfH9iRtWzleJum1Sw
         lghA==
X-Gm-Message-State: AOJu0YxbgYFBlUQbH4rh/WLiRvZMvzUm/RnYVvUed3lVcpl6/Yhrfhh9
	N4tYMpWmVofR7QY4PBG2xH++FEFI8XYybXg8uAtnF+fYXIO8p1Oz3JFyFMBZ4wWF5vJJhaEpB0q
	5XIp5
X-Gm-Gg: AfdE7cmh/KeJ6xWyB+4XPplQXRqYBHR3aGXb42p36m10sco3wkL4tBabATBqswmTtHU
	capTgY/lxvR60GJGBWCgcHKdqT+q3K/ZUwiOtteFj0ddcsG3t89fqIMBaZxgeYLMu5ysMihkqGr
	0sfUD4X3Cn1b3HLcsIHFOH1UkGr8c8s48+Sj6Jo/usu0d4TlgkiGVsmD8v6oHMHSUx5961W0AOV
	lryZPU6uGK4Bcv7BvxVwvCokOxzVz+hdSX3snMU2wYlCqjgPLoD8+VRutVlsRj1P9B0UoO3DXeZ
	bcEGH4+GdsDzxXDKnsTac6aAgAONy18MGrTIAUWojru6vZDmnsrU9e88bzBugpfVBgO345Gad6K
	YxAzADXxBuek2mV0jIWhGcKVjzOB99yY1ljy9+I3m6rpkyS4eUb96XDJPiolmVWXtWTvz/099E7
	s/NRqXrC1ruZX81ow8nR0LBw==
X-Received: by 2002:a05:6000:2582:b0:46d:d5da:f0a8 with SMTP id ffacd0b85a97d-47df07a9985mr6724774f8f.47.1783590978626;
        Thu, 09 Jul 2026 02:56:18 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm49320207f8f.14.2026.07.09.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names test
Date: Thu,  9 Jul 2026 11:55:32 +0200
Message-ID: <20260709095532.855647-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22957-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rxe_test_netdev_unregister.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35F4272F553

From: Jiri Pirko <jiri@nvidia.com>

Add a kselftest script that exercises per-netns RDMA device naming
with RXE. Cover duplicate names across namespaces, move conflict
handling, move-with-rename, and same-namespace rename requests.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/config           |   2 +
 .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh

diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
index 07af7f15c1bf..a91c14c45006 100644
--- a/tools/testing/selftests/rdma/Makefile
+++ b/tools/testing/selftests/rdma/Makefile
@@ -3,6 +3,7 @@ TEST_PROGS := rxe_rping_between_netns.sh \
 		rxe_ipv6.sh \
 		rxe_socket_with_netns.sh \
 		rxe_test_NETDEV_UNREGISTER.sh \
-		rxe_sent_rcvd_bytes.sh
+		rxe_sent_rcvd_bytes.sh \
+		rxe_netns_names.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/rdma/config b/tools/testing/selftests/rdma/config
index 4ffb814e253b..e1ff54ec0f57 100644
--- a/tools/testing/selftests/rdma/config
+++ b/tools/testing/selftests/rdma/config
@@ -1,3 +1,5 @@
 CONFIG_TUN
 CONFIG_VETH
+CONFIG_DUMMY
+CONFIG_NET_NS
 CONFIG_RDMA_RXE
diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
new file mode 100755
index 000000000000..a7e57706fdff
--- /dev/null
+++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
@@ -0,0 +1,282 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Exercise RDMA device name handling across network namespaces.
+
+source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
+
+NAME_PREFIX="rxe_netns_names_$$"
+NETDEV_PREFIX="rxn$$"
+NS1="${NAME_PREFIX}ns1"
+NS2="${NAME_PREFIX}ns2"
+RXE_A="${NAME_PREFIX}rxe_a"
+RXE_B="${NAME_PREFIX}rxe_b"
+RXE_SAME="${NAME_PREFIX}rxe_same"
+RXE_NEW="${NAME_PREFIX}rxe_new"
+DUMMY_A="${NETDEV_PREFIX}a"
+DUMMY_B="${NETDEV_PREFIX}b"
+OLD_MODE=""
+MODE_CHANGED=0
+MODS=("dummy" "rdma_rxe")
+TEST_SAME_NAMES="same RDMA device name can exist in two net namespaces"
+TEST_MOVE_CONFLICT="move without rename fails on destination name conflict"
+TEST_MOVE_RENAME="move then rename succeeds"
+TEST_COMBINED_MOVE_RENAME="move with requested destination name succeeds"
+TEST_SAME_NETNS_DUP_RENAME="same-netns rename rejects duplicate name"
+TEST_TEARDOWN_RETURN="netns delete returns device to init_net and renames on conflict"
+
+ksft_skip()
+{
+	ktap_skip_all "$*"
+	exit "$KSFT_SKIP"
+}
+
+fail()
+{
+	ktap_exit_fail_msg "$*"
+}
+
+need_cmd()
+{
+	command -v "$1" >/dev/null 2>&1 || ksft_skip "missing command: $1"
+}
+
+rdma_ns()
+{
+	local ns=$1
+
+	shift
+	ip netns exec "$ns" rdma "$@"
+}
+
+rdma_dev_exists()
+{
+	local ns=$1
+	local dev=$2
+
+	if [ -n "$ns" ]; then
+		rdma_ns "$ns" dev show "$dev" >/dev/null 2>&1
+	else
+		rdma dev show "$dev" >/dev/null 2>&1
+	fi
+}
+
+add_dummy()
+{
+	local netdev=$1
+
+	ip link add "$netdev" type dummy || return 1
+	ip link set "$netdev" up || return 1
+}
+
+add_rxe()
+{
+	local dev=$1
+	local netdev=$2
+
+	rdma link add "$dev" type rxe netdev "$netdev"
+}
+
+rdma_dev_on_netdev()
+{
+	local netdev=$1
+
+	rdma link show 2>/dev/null | awk -v want="$netdev" '
+		{
+			for (i = 1; i < NF; i++)
+				if ($i == "netdev" && $(i + 1) == want) {
+					dev = $2
+					sub(/\/.*/, "", dev)
+					print dev
+					exit
+				}
+		}'
+}
+
+wait_rdma_dev_on_netdev()
+{
+	local netdev=$1
+	local dev
+	local i
+
+	for i in $(seq 1 50); do
+		dev=$(rdma_dev_on_netdev "$netdev")
+		if [ -n "$dev" ]; then
+			echo "$dev"
+			return 0
+		fi
+		sleep 0.1
+	done
+
+	return 1
+}
+
+setup_devs()
+{
+	cleanup_devs
+
+	add_dummy "$DUMMY_A" || return 1
+	add_dummy "$DUMMY_B" || return 1
+
+	add_rxe "$RXE_A" "$DUMMY_A" || return 1
+	add_rxe "$RXE_B" "$DUMMY_B" || return 1
+}
+
+cleanup_devs()
+{
+	ip link del "$DUMMY_A" 2>/dev/null
+	ip link del "$DUMMY_B" 2>/dev/null
+}
+
+setup()
+{
+	OLD_MODE=$(rdma system show 2>/dev/null |
+		   sed -n 's/.*netns \([^ ]*\).*/\1/p')
+	[ -n "$OLD_MODE" ] || ksft_skip "failed to read RDMA netns mode"
+
+	rdma system set netns exclusive >/dev/null 2>&1 ||
+		ksft_skip "rdma netns exclusive mode is not supported"
+	MODE_CHANGED=1
+
+	ip netns add "$NS1" || return 1
+	ip netns add "$NS2" || return 1
+}
+
+cleanup()
+{
+	cleanup_devs
+
+	ip netns del "$NS1" 2>/dev/null
+	ip netns del "$NS2" 2>/dev/null
+
+	if [ "$MODE_CHANGED" -eq 1 ]; then
+		rdma system set netns "$OLD_MODE" 2>/dev/null
+	fi
+
+	for m in "${MODS[@]}"; do
+		modprobe -r "$m" 2>/dev/null
+	done
+}
+
+rdma_supports_combined_move_rename()
+{
+	rdma dev help 2>&1 | grep -Eq 'netns .*name|name .*netns'
+}
+
+[ "$(id -u)" -eq 0 ] || ksft_skip "must be run as root"
+need_cmd ip
+need_cmd rdma
+need_cmd modprobe
+
+trap cleanup EXIT
+
+for m in "${MODS[@]}"; do
+	modinfo "$m" >/dev/null 2>&1 || ksft_skip "module $m not found"
+	modprobe "$m" || fail "failed to load $m"
+done
+
+setup || fail "failed to create net namespaces"
+
+ktap_print_header
+ktap_set_plan 7
+
+if setup_devs &&
+   rdma dev set "$RXE_A" netns "$NS1" &&
+   rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" &&
+   rdma dev set "$RXE_B" netns "$NS2" &&
+   rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" &&
+   rdma_dev_exists "$NS1" "$RXE_SAME" &&
+   rdma_dev_exists "$NS2" "$RXE_SAME"; then
+	ktap_test_pass "$TEST_SAME_NAMES"
+else
+	ktap_test_fail "$TEST_SAME_NAMES"
+fi
+cleanup_devs
+
+if ! setup_devs ||
+   ! rdma dev set "$RXE_A" netns "$NS1" ||
+   ! rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" ||
+   ! rdma dev set "$RXE_B" netns "$NS2" ||
+   ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME"; then
+	ktap_test_fail "$TEST_MOVE_CONFLICT"
+elif rdma_ns "$NS1" dev set "$RXE_SAME" netns "$NS2" >/dev/null 2>&1; then
+	ktap_test_fail "$TEST_MOVE_CONFLICT"
+elif rdma_dev_exists "$NS1" "$RXE_SAME" &&
+     rdma_dev_exists "$NS2" "$RXE_SAME"; then
+	ktap_test_pass "$TEST_MOVE_CONFLICT"
+else
+	ktap_test_fail "$TEST_MOVE_CONFLICT"
+fi
+cleanup_devs
+
+if ! setup_devs; then
+	ktap_test_fail "$TEST_MOVE_RENAME"
+elif rdma dev set "$RXE_A" netns "$NS2" &&
+     rdma_ns "$NS2" dev set "$RXE_A" name "$RXE_NEW"; then
+	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
+	   ! rdma_dev_exists "" "$RXE_A"; then
+		ktap_test_pass "$TEST_MOVE_RENAME"
+	else
+		ktap_test_fail "$TEST_MOVE_RENAME"
+	fi
+else
+	ktap_test_fail "$TEST_MOVE_RENAME"
+fi
+cleanup_devs
+
+if ! rdma_supports_combined_move_rename; then
+	ktap_test_skip "$TEST_COMBINED_MOVE_RENAME"
+elif ! setup_devs; then
+	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
+elif rdma dev set "$RXE_A" netns "$NS2" name "$RXE_NEW"; then
+	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
+	   ! rdma_dev_exists "" "$RXE_A"; then
+		ktap_test_pass "$TEST_COMBINED_MOVE_RENAME"
+	else
+		ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
+	fi
+else
+	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
+fi
+cleanup_devs
+
+if ! setup_devs; then
+	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+elif rdma dev set "$RXE_A" name "$RXE_SAME" &&
+     rdma dev set "$RXE_B" name "$RXE_NEW"; then
+	if rdma dev set "$RXE_A" name "$RXE_NEW" >/dev/null 2>&1; then
+		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+	elif rdma_dev_exists "" "$RXE_SAME" &&
+	     rdma_dev_exists "" "$RXE_NEW"; then
+		ktap_test_pass "$TEST_SAME_NETNS_DUP_RENAME"
+	else
+		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+	fi
+else
+	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+fi
+cleanup_devs
+
+if ! setup_devs; then
+	ktap_test_fail "$TEST_TEARDOWN_RETURN"
+elif ! rdma dev set "$RXE_A" name "$RXE_SAME" ||
+     ! rdma dev set "$RXE_B" netns "$NS2" ||
+     ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" ||
+     ! rdma_dev_exists "$NS2" "$RXE_SAME"; then
+	ktap_test_fail "$TEST_TEARDOWN_RETURN"
+else
+	ip netns del "$NS2"
+	returned=$(wait_rdma_dev_on_netdev "$DUMMY_B")
+	ktap_print_msg "device returned to init_net as '${returned:-<missing>}'"
+	if rdma_dev_exists "" "$RXE_SAME" &&
+	   [ -n "$returned" ] &&
+	   [ "$returned" != "$RXE_SAME" ] &&
+	   [ "${returned#ibdev}" != "$returned" ]; then
+		ktap_test_pass "$TEST_TEARDOWN_RETURN"
+	else
+		ktap_test_fail "$TEST_TEARDOWN_RETURN"
+	fi
+fi
+cleanup_devs
+
+ktap_finished
-- 
2.54.0


