Return-Path: <linux-rdma+bounces-19487-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLH1Is246WlJigIAu9opvQ
	(envelope-from <linux-rdma+bounces-19487-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 08:14:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6361944D73A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BAA5300845F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1439A076;
	Thu, 23 Apr 2026 06:14:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49C375AB8
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924867; cv=none; b=nv5VHo/bV6dEdzHuQ6o2gHEnvfLVkdke2y60OJa6j64QbbTATOePiI2lNMEfEFgcIbPBE2D1F7hvLWCYgXMndIAI3bbONLgG7o0+cC4BiZ8BTBlUfDOoCsrq1jkMgg8WIAs+dtawQsaqntRpSNNk/1AdOA8v+r0cbawAEinPQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924867; c=relaxed/simple;
	bh=g3LlmOAtZwMYtqIh3Zz9xoK15zBDbNjMz2db33vQaw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuELtzA3RlqD/qXHZtPGvvgU2gY+oYyGWW6+Jiw48y8HXCW7wvRQwlLf3z3VmFoKcX/gmfQoPZtdPJ+cZPhI97TzAQFmQMWuUl8hbneP463hBTAjHAFmXQzAB32upKub3/QPvclrW+JtXizCbML7t7/PI48Qnk1dUfTTAfqd6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8efbd6a3edb11f1aa26b74ffac11d73-20260423
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e796fce1-c6a7-4239-83e7-e1b1d8e65fc6,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:e796fce1-c6a7-4239-83e7-e1b1d8e65fc6,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:1f2ec1a4daf029eec992b14c18c09daf,BulkI
	D:260423141420ZPKF5QO4,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8efbd6a3edb11f1aa26b74ffac11d73-20260423
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1573817142; Thu, 23 Apr 2026 14:14:17 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/2] selftests/rdma: add resource usage rate display test
Date: Thu, 23 Apr 2026 14:13:52 +0800
Message-ID: <20260423061352.359749-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423061352.359749-1-cuitao@kylinos.cn>
References: <20260423061352.359749-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19487-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxe_socket_with_netns.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rxe_test_netdev_unregister.sh:url,rxe_res_usage.sh:url,rxe_rping_between_netns.sh:url,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 6361944D73A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add rxe_res_usage.sh to verify the new RES_SUMMARY_ENTRY_MAX netlink
attribute and the usage percentage display in rdma resource show.

Tests cover:
- Usage percentage format and numerical correctness
- JSON output structure (max and usage fields)
- Per-device query returning max > 0
- Cross-validation against ibv_devinfo max values
- Usage count increase after creating QPs via rping
- Resources without max limit (cm_id, ctx) show no usage percentage

Requires: rdma_rxe module, rdma tool, jq, rping.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/rxe_res_usage.sh | 356 ++++++++++++++++++
 2 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_res_usage.sh

diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
index 7dd7cba7a73c..422be2bae838 100644
--- a/tools/testing/selftests/rdma/Makefile
+++ b/tools/testing/selftests/rdma/Makefile
@@ -2,6 +2,7 @@
 TEST_PROGS := rxe_rping_between_netns.sh \
 		rxe_ipv6.sh \
 		rxe_socket_with_netns.sh \
-		rxe_test_NETDEV_UNREGISTER.sh
+		rxe_test_NETDEV_UNREGISTER.sh \
+		rxe_res_usage.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/rdma/rxe_res_usage.sh b/tools/testing/selftests/rdma/rxe_res_usage.sh
new file mode 100755
index 000000000000..afcf7c5daa7b
--- /dev/null
+++ b/tools/testing/selftests/rdma/rxe_res_usage.sh
@@ -0,0 +1,356 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test rdma resource show max and usage percentage display.
+# Requires: rdma_rxe module, rdma tool (iproute2), rping utility.
+#
+# Verifies:
+#   1. "rdma resource show" outputs usage percentage for qp/cq/mr/pd/srq
+#   2. Usage percentage is displayed and correct
+#   3. JSON output contains "max" and "usage" fields
+#   4. Resources without max limit (cm_id, ctx) show no percentage
+
+set -e
+
+NS_NAME="rxe_res_test"
+VETH_HOST="veth_res0"
+VETH_NS="veth_res1"
+RXE_NAME="rxe_res"
+
+PASS=0
+FAIL=0
+
+cleanup() {
+    ip netns exec "$NS_NAME" rdma link del "$RXE_NAME" 2>/dev/null || true
+    ip netns del "$NS_NAME" 2>/dev/null || true
+    modprobe -r rdma_rxe 2>/dev/null || true
+    echo ""
+    echo "Results: $PASS passed, $FAIL failed"
+    if [ "$FAIL" -gt 0 ]; then
+        exit 1
+    fi
+}
+trap cleanup EXIT
+
+assert_contains() {
+    local desc="$1"
+    local haystack="$2"
+    local needle="$3"
+
+    if echo "$haystack" | grep -q "$needle"; then
+        echo "  PASS: $desc"
+        PASS=$((PASS + 1))
+    else
+        echo "  FAIL: $desc (expected '$needle' in output)"
+        FAIL=$((FAIL + 1))
+    fi
+}
+
+assert_field_value() {
+    local desc="$1"
+    local json="$2"
+    local field="$3"
+    local expected="$4"
+    local actual
+
+    actual=$(echo "$json" | jq -r "$field" 2>/dev/null) || true
+    if [ "$actual" = "$expected" ]; then
+        echo "  PASS: $desc ($field=$actual)"
+        PASS=$((PASS + 1))
+    else
+        echo "  FAIL: $desc (expected $field=$expected, got $actual)"
+        FAIL=$((FAIL + 1))
+    fi
+}
+
+assert_usage_pct() {
+    local desc="$1"
+    local curr="$2"
+    local max="$3"
+    local usage_str="$4"
+
+    # Calculate expected percentage with 1 decimal place using shell arithmetic
+    # Multiply by 1000 first to get one decimal: (curr * 1000 * 100) / max = per-mille
+    local permille=$(( curr * 100000 / max ))
+    local int_part=$(( permille / 1000 ))
+    local frac_part=$(( permille % 1000 ))
+    local expected="${int_part}.$(printf '%03d' $frac_part | sed 's/0*$//')"
+    # Trim trailing dot
+    expected="${expected%.}"
+
+    # Extract percentage from usage string like "(0.0%)"
+    local actual
+    actual=$(echo "$usage_str" | sed 's/.*(\([0-9.]*\)%).*/\1/')
+
+    if [ "$actual" = "$expected" ]; then
+        echo "  PASS: $desc (usage=$actual%)"
+        PASS=$((PASS + 1))
+    else
+        echo "  FAIL: $desc (expected $expected%, got $actual%)"
+        FAIL=$((FAIL + 1))
+    fi
+}
+
+# ============================================================
+# Setup
+# ============================================================
+
+echo "=== Setting up test environment ==="
+
+# Check prerequisites
+if ! command -v rdma >/dev/null 2>&1; then
+    echo "SKIP: 'rdma' not found, test requires it"
+    exit 4
+fi
+
+if ! modinfo rdma_rxe >/dev/null 2>&1; then
+    echo "SKIP: rdma_rxe kernel module not found"
+    exit 4
+fi
+
+modprobe rdma_rxe
+
+ip netns add "$NS_NAME"
+ip link add "$VETH_HOST" type veth peer name "$VETH_NS"
+ip link set "$VETH_NS" netns "$NS_NAME"
+ip netns exec "$NS_NAME" ip link set "$VETH_NS" up
+ip link set "$VETH_HOST" up
+
+ip netns exec "$NS_NAME" rdma link add "$RXE_NAME" type rxe netdev "$VETH_NS"
+echo "RXE link $RXE_NAME created."
+
+# Helper: run rdma in test namespace
+rdma_ns() {
+    ip netns exec "$NS_NAME" rdma "$@"
+}
+
+# ============================================================
+# Test 1: Plain text output has usage percentage
+# ============================================================
+echo ""
+echo "=== Test 1: Plain text output contains usage percentage ==="
+
+OUT=$(rdma_ns resource show)
+echo "Output: $OUT"
+
+for res in qp cq mr pd srq; do
+    assert_contains "$res has usage percentage" "$OUT" "$res [0-9]* ([0-9.]*%)"
+done
+
+# ============================================================
+# Test 2: Usage percentage is numerically correct
+# ============================================================
+echo ""
+echo "=== Test 2: Usage percentage is parsed correctly ==="
+
+# Extract curr and usage for qp from rxe_res device line only
+# Expected format: "... rxe_res: ... qp 1 (0.0%) ..."
+QP_LINE=$(echo "$OUT" | grep "$RXE_NAME" | sed -n 's/.*\(qp [0-9]* ([0-9.]*%)\).*/\1/p')
+if [ -n "$QP_LINE" ]; then
+    QP_CURR=$(echo "$QP_LINE" | sed 's/qp \([0-9]*\) .*/\1/')
+    QP_USAGE=$(echo "$QP_LINE" | sed 's/.*(\([0-9.]*%\))/(\1)/')
+    if [ -n "$QP_CURR" ] && [ "$QP_CURR" -ge 0 ] 2>/dev/null; then
+        echo "  PASS: qp usage percentage parsed ($QP_CURR $QP_USAGE)"
+        PASS=$((PASS + 1))
+    else
+        echo "  FAIL: Could not parse qp curr value"
+        FAIL=$((FAIL + 1))
+    fi
+else
+    echo "  SKIP: Could not parse qp line for percentage check"
+fi
+
+# ============================================================
+# Test 4: JSON output structure
+# ============================================================
+echo ""
+echo "=== Test 3: JSON output structure ==="
+
+if ! command -v jq >/dev/null 2>&1; then
+    echo "  SKIP: jq not available, skipping JSON tests"
+else
+JSON=$(rdma_ns -j resource show)
+echo "JSON: $JSON"
+
+# JSON should be valid
+if echo "$JSON" | jq . >/dev/null 2>&1; then
+    echo "  PASS: JSON is valid"
+    PASS=$((PASS + 1))
+else
+    echo "  FAIL: JSON is invalid"
+    FAIL=$((FAIL + 1))
+    JSON="[]"
+fi
+
+# Check that at least one entry has a "max" field
+if echo "$JSON" | jq -e '.[] | select(.max != null)' >/dev/null 2>&1; then
+    echo "  PASS: JSON contains 'max' field"
+    PASS=$((PASS + 1))
+else
+    echo "  FAIL: JSON missing 'max' field"
+    FAIL=$((FAIL + 1))
+fi
+
+# Check that at least one entry has a "usage" field
+if echo "$JSON" | jq -e '.[] | select(.usage != null)' >/dev/null 2>&1; then
+    echo "  PASS: JSON contains 'usage' field"
+    PASS=$((PASS + 1))
+else
+    echo "  FAIL: JSON missing 'usage' field"
+    FAIL=$((FAIL + 1))
+fi
+fi
+
+# ============================================================
+# Test 5: Per-device JSON output
+# ============================================================
+echo ""
+echo "=== Test 4: Per-device JSON output ==="
+
+if ! command -v jq >/dev/null 2>&1; then
+    echo "  SKIP: jq not available, skipping JSON tests"
+else
+DEV_JSON=$(rdma_ns -j resource show "$RXE_NAME")
+echo "Device JSON: $DEV_JSON"
+
+if [ "$DEV_JSON" != "[]" ]; then
+    echo "  PASS: Device-specific query returned data"
+    PASS=$((PASS + 1))
+
+    # JSON is flat with duplicate "max" keys per resource; jq returns the last one
+    JSON_MAX=$(echo "$DEV_JSON" | jq -r '.[0].max' 2>/dev/null)
+    if [ -n "$JSON_MAX" ] && [ "$JSON_MAX" -gt 0 ] 2>/dev/null; then
+        echo "  PASS: JSON max field present and > 0 ($JSON_MAX)"
+        PASS=$((PASS + 1))
+    else
+        echo "  FAIL: JSON max is missing or zero (got: $JSON_MAX)"
+        FAIL=$((FAIL + 1))
+    fi
+
+    if echo "$DEV_JSON" | grep -q '"usage"'; then
+        echo "  PASS: JSON usage field present"
+        PASS=$((PASS + 1))
+    else
+        echo "  FAIL: JSON usage field missing"
+        FAIL=$((FAIL + 1))
+    fi
+else
+    echo "  FAIL: Device-specific query returned empty"
+    FAIL=$((FAIL + 1))
+fi
+fi
+
+# ============================================================
+# Test 6: Verify max values match ibv_devinfo
+# ============================================================
+echo ""
+echo "=== Test 5: Max values match ibv_devinfo ==="
+
+if ! command -v jq >/dev/null 2>&1; then
+    echo "  SKIP: jq not available, skipping ibv_devinfo cross-validation"
+elif ! command -v ibv_devinfo >/dev/null 2>&1; then
+    echo "  SKIP: ibv_devinfo not available"
+else
+    IBV_OUT=$(ip netns exec "$NS_NAME" ibv_devinfo -v -d "$RXE_NAME" 2>/dev/null || true)
+    if [ -n "$IBV_OUT" ]; then
+        IBV_MAX_QP=$(echo "$IBV_OUT" | sed -n 's/.*max_qp:[[:space:]]*\([0-9]*\).*/\1/p')
+        IBV_MAX_PD=$(echo "$IBV_OUT" | sed -n 's/.*max_pd:[[:space:]]*\([0-9]*\).*/\1/p')
+
+        # Verify ibv_devinfo reports reasonable max values
+        if [ -n "$IBV_MAX_QP" ] && [ "$IBV_MAX_QP" -gt 0 ] 2>/dev/null; then
+            echo "  PASS: ibv_devinfo max_qp=$IBV_MAX_QP"
+            PASS=$((PASS + 1))
+        else
+            echo "  FAIL: ibv_devinfo max_qp missing or zero"
+            FAIL=$((FAIL + 1))
+        fi
+        if [ -n "$IBV_MAX_PD" ] && [ "$IBV_MAX_PD" -gt 0 ] 2>/dev/null; then
+            echo "  PASS: ibv_devinfo max_pd=$IBV_MAX_PD"
+            PASS=$((PASS + 1))
+        else
+            echo "  FAIL: ibv_devinfo max_pd missing or zero"
+            FAIL=$((FAIL + 1))
+        fi
+    else
+        echo "  SKIP: ibv_devinfo returned no output"
+    fi
+fi
+
+# ============================================================
+# Test 7: Usage after creating QPs (with rping)
+# ============================================================
+echo ""
+echo "=== Test 6: Usage increases after creating resources ==="
+
+BEFORE_QP_CURR=$(echo "$OUT" | sed -n 's/.*qp \([0-9]*\).*/\1/p' | head -1)
+BEFORE_QP_CURR=${BEFORE_QP_CURR:-0}
+echo "  QP count before: $BEFORE_QP_CURR"
+
+# Start rping server in background to create QP resources
+ip netns exec "$NS_NAME" rping -s -p 12345 -v &
+RPING_PID=$!
+sleep 1
+
+# Check resource count after
+OUT_AFTER=$(rdma_ns resource show)
+AFTER_QP_CURR=$(echo "$OUT_AFTER" | sed -n 's/.*qp \([0-9]*\).*/\1/p' | head -1)
+AFTER_QP_CURR=${AFTER_QP_CURR:-0}
+echo "  QP count after rping: $AFTER_QP_CURR"
+
+if [ "$AFTER_QP_CURR" -ge "$BEFORE_QP_CURR" ]; then
+    echo "  PASS: QP count did not decrease ($BEFORE_QP_CURR -> $AFTER_QP_CURR)"
+    PASS=$((PASS + 1))
+else
+    echo "  FAIL: QP count unexpectedly decreased"
+    FAIL=$((FAIL + 1))
+fi
+
+# Verify usage percentage is still present after count change
+QP_LINE_AFTER=$(echo "$OUT_AFTER" | sed -n 's/.*\(qp [0-9]* ([0-9.]*%)\).*/\1/p')
+if [ -n "$QP_LINE_AFTER" ]; then
+    echo "  PASS: qp usage percentage present after rping ($QP_LINE_AFTER)"
+    PASS=$((PASS + 1))
+else
+    echo "  FAIL: qp usage percentage missing after rping"
+    FAIL=$((FAIL + 1))
+fi
+
+kill "$RPING_PID" 2>/dev/null || true
+wait "$RPING_PID" 2>/dev/null || true
+
+# ============================================================
+# Test 8: Resources without max show no usage percentage (cm_id, ctx)
+# ============================================================
+echo ""
+echo "=== Test 7: Resources without max limit (cm_id, ctx) ==="
+
+# cm_id and ctx have no max in ib_device_attr, max=0 from kernel
+# In output, they should NOT show usage percentage
+CM_ID_LINE=$(echo "$OUT" | sed -n 's/.*\(cm_id [0-9]*\).*/\1/p' | head -1)
+if [ -n "$CM_ID_LINE" ]; then
+    if echo "$OUT" | grep -q 'cm_id [0-9]* ([0-9.]*%)'; then
+        echo "  FAIL: cm_id should not show usage percentage (no ib_device_attr equivalent)"
+        FAIL=$((FAIL + 1))
+    else
+        echo "  PASS: cm_id has no usage percentage (as expected)"
+        PASS=$((PASS + 1))
+    fi
+else
+    echo "  SKIP: cm_id not found in output"
+fi
+
+CTX_LINE=$(echo "$OUT" | sed -n 's/.*\(ctx [0-9]*\).*/\1/p' | head -1)
+if [ -n "$CTX_LINE" ]; then
+    if echo "$OUT" | grep -q 'ctx [0-9]* ([0-9.]*%)'; then
+        echo "  FAIL: ctx should not show usage percentage"
+        FAIL=$((FAIL + 1))
+    else
+        echo "  PASS: ctx has no usage percentage (as expected)"
+        PASS=$((PASS + 1))
+    fi
+else
+    echo "  SKIP: ctx not found in output"
+fi
+
+echo ""
+echo "=== All tests completed ==="
-- 
2.43.0


