Return-Path: <linux-rdma+bounces-19642-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAegFOpf8GnDSQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19642-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 09:21:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958D47EB58
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6615312550C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBF83D5672;
	Tue, 28 Apr 2026 07:12:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6B3B3886;
	Tue, 28 Apr 2026 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360348; cv=none; b=WGp38lVtLH2G0ARAXPbOFk2gWIXzaC5BPEZBBREODcCDIg7RVL94R9R5MhgP4I7UVqOhOqpSNNqjvQHk+LNV18Fzfqqep4CcYTk9PBnjTLEn84skbgIpQ8HPHZ4CN7sDB3SoOxMM+csHJMx/WjbeXsW2CTQiWUxxiGjJv0287Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360348; c=relaxed/simple;
	bh=Jp6tf7veak5eB6qrk/55Llzw9FUBZkO5tYFza6qE930=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FEO8KRz8kjpBV6E7NXz4mQ0s+3EaVmFGvCmK/bBgL1YR8ihi2/rQAa7/nUKwvt8wY7dfsb9B0aJLmCrxr6LtKAjLJvbaJgbqVVIhbWrS8is3GE89fylDAR6mpwM4SiiWWLnExwtYRnHHg09pIisOsYvni/1q+ctr52ND9PpEXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 96aa439c42d111f1aa26b74ffac11d73-20260428
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cffba7c3-b236-473d-a96b-c1109ceafe60,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:cffba7c3-b236-473d-a96b-c1109ceafe60,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:d3b0a6aa501562170cc1a1032156759c,BulkI
	D:260428151219195SWNA9,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96aa439c42d111f1aa26b74ffac11d73-20260428
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.160.128.123)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 453808135; Tue, 28 Apr 2026 15:12:16 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] RDMA/CM: add RDMA CM observability regression scripts
Date: Tue, 28 Apr 2026 15:12:16 +0800
Message-Id: <20260428071216.1212775-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8958D47EB58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19642-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.918];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rdma_cm_baseline.sh:url,rdma_cm_fault_injection.sh:url]

This adds a minimal RDMA CM selftest suite that captures observability
baselines and runs trace, counter-delta, and fault-injection-oriented
checks, plus a review-loop helper for repeated validation rounds.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 v2:
 - Move the test scripts to tools/testing/selftests/rdma
   as suggested by Leon. 

 - rdma_cm_baseline.sh:rdma_cm_baseline.sh: Captures baseline 
   observability data for RDMA CM, establishing a reference
   point for testing.

 - rdma_cm_counter_delta.sh: Monitors and reports counter deltas
   during RDMA operations to detect unexpected behavior

 - rdma_cm_fault_injection.sh: Performs fault injection to test
   RDMA CM's handling of failures and error scenarios.

 - rdma_cm_review_loop.sh: Automates repeated testing for continuous
   validation of RDMA CM functionality.

 - rdma_cm_trace_sequence.sh: Captures a trace sequence of RDMA
   operations to ensure proper flow and aid in troubleshooting.

 - rdma_common.sh: Contains shared utility functions used across
   the above scripts for consistency and reusability.
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/rdma/Makefile         |  10 ++
 tools/testing/selftests/rdma/config           |   6 +
 .../selftests/rdma/rdma_cm_baseline.sh        |  58 ++++++++
 .../selftests/rdma/rdma_cm_counter_delta.sh   |  72 ++++++++++
 .../selftests/rdma/rdma_cm_fault_injection.sh |  95 +++++++++++++
 .../selftests/rdma/rdma_cm_review_loop.sh     |  35 +++++
 .../selftests/rdma/rdma_cm_trace_sequence.sh  |  83 ++++++++++++
 tools/testing/selftests/rdma/rdma_common.sh   | 126 ++++++++++++++++++
 9 files changed, 486 insertions(+)
 create mode 100755 tools/testing/selftests/rdma/rdma_cm_baseline.sh
 create mode 100755 tools/testing/selftests/rdma/rdma_cm_counter_delta.sh
 create mode 100755 tools/testing/selftests/rdma/rdma_cm_fault_injection.sh
 create mode 100755 tools/testing/selftests/rdma/rdma_cm_review_loop.sh
 create mode 100755 tools/testing/selftests/rdma/rdma_cm_trace_sequence.sh
 create mode 100755 tools/testing/selftests/rdma/rdma_common.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..5794d55a92b2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -22,6 +22,7 @@ TARGETS += drivers/ntsync
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
+TARGETS += rdma
 TARGETS += drivers/net/netconsole
 TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
index 7dd7cba7a73c..04c52db4b9d9 100644
--- a/tools/testing/selftests/rdma/Makefile
+++ b/tools/testing/selftests/rdma/Makefile
@@ -4,4 +4,14 @@ TEST_PROGS := rxe_rping_between_netns.sh \
 		rxe_socket_with_netns.sh \
 		rxe_test_NETDEV_UNREGISTER.sh
 
+TEST_PROGS += \
+	rdma_cm_baseline.sh \
+	rdma_cm_trace_sequence.sh \
+	rdma_cm_counter_delta.sh \
+	rdma_cm_fault_injection.sh
+
+TEST_FILES += \
+	rdma_common.sh \
+	rdma_cm_review_loop.sh
+
 include ../lib.mk
diff --git a/tools/testing/selftests/rdma/config b/tools/testing/selftests/rdma/config
index 4ffb814e253b..e22141838c19 100644
--- a/tools/testing/selftests/rdma/config
+++ b/tools/testing/selftests/rdma/config
@@ -1,3 +1,9 @@
 CONFIG_TUN
 CONFIG_VETH
 CONFIG_RDMA_RXE
+CONFIG_DEBUG_KERNEL
+CONFIG_FAULT_INJECTION
+CONFIG_SYSFS
+CONFIG_DEBUG_FS
+CONFIG_FAULT_INJECTION_DEBUG_FS
+CONFIG_FAILSLAB
diff --git a/tools/testing/selftests/rdma/rdma_cm_baseline.sh b/tools/testing/selftests/rdma/rdma_cm_baseline.sh
new file mode 100755
index 000000000000..b0d8b3e46470
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_cm_baseline.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -euo pipefail
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+source "${SCRIPT_DIR}/rdma_common.sh"
+
+require_root
+require_cmd date
+require_cmd uname
+
+trace_dir="$(tracefs_dir || true)"
+counter_root="$(find_cm_counter_root || true)"
+out_dir="/tmp/rdma_cm_baseline.$(date +%s)"
+dmesg_lines=400
+dmesg_pattern="ib_cm|infiniband|rdma|roce|mlx|hns_roce|irdma|siw|rxe"
+
+mkdir -p "${out_dir}"
+
+log_info "writing baseline to ${out_dir}"
+
+{
+	echo "timestamp=$(date -u +%FT%TZ)"
+	echo "kernel=$(uname -r)"
+	echo "hostname=$(uname -n)"
+	echo "dmesg_lines=${dmesg_lines}"
+	echo "dmesg_pattern=${dmesg_pattern}"
+} >"${out_dir}/env.txt"
+
+if [[ -n "${trace_dir}" && -d "${trace_dir}/events/ib_cma" ]]; then
+	find "${trace_dir}/events/ib_cma" -maxdepth 2 -name enable -print \
+		>"${out_dir}/trace_events.list" 2>/dev/null || true
+else
+	log_warn "tracefs or ib_cma trace events are unavailable"
+fi
+
+if [[ -n "${counter_root}" ]]; then
+	{
+		echo "counter_root=${counter_root}"
+		for group in "${RDMA_COUNTER_GROUPS[@]}"; do
+			for attr in "${RDMA_COUNTER_ATTRS[@]}"; do
+				value="$(read_cm_counter "${counter_root}" "${group}" "${attr}")"
+				echo "${group}.${attr}=${value}"
+			done
+		done
+	} >"${out_dir}/cm_counters.before"
+else
+	log_warn "cm counters are unavailable under /sys/class/infiniband"
+fi
+
+if command -v dmesg >/dev/null 2>&1; then
+	dmesg | tail -n "${dmesg_lines}" | grep -E "${dmesg_pattern}" \
+		>"${out_dir}/dmesg.rdma.tail" || true
+fi
+
+log_info "baseline collection completed"
+exit 0
diff --git a/tools/testing/selftests/rdma/rdma_cm_counter_delta.sh b/tools/testing/selftests/rdma/rdma_cm_counter_delta.sh
new file mode 100755
index 000000000000..060adf9fe78a
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_cm_counter_delta.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -euo pipefail
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+source "${SCRIPT_DIR}/rdma_common.sh"
+
+require_root
+counter_root="$(find_cm_counter_root || true)"
+counter_wait_sec=2
+
+if [[ -z "${counter_root}" ]]; then
+	log_warn "cm counters are unavailable under /sys/class/infiniband"
+	exit "${ksft_skip}"
+fi
+
+declare -A before after
+
+for group in "${RDMA_COUNTER_GROUPS[@]}"; do
+	for attr in "${RDMA_COUNTER_ATTRS[@]}"; do
+		key="${group}.${attr}"
+		before["${key}"]="$(read_cm_counter "${counter_root}" "${group}" "${attr}")"
+	done
+done
+
+if [[ "${counter_wait_sec}" != "0" ]]; then
+	log_info "waiting ${counter_wait_sec}s before workload"
+	sleep "${counter_wait_sec}"
+fi
+
+workload_rc=0
+run_workload || workload_rc=$?
+if [[ "${workload_rc}" -eq "${ksft_skip}" ]]; then
+	exit "${ksft_skip}"
+fi
+if [[ "${workload_rc}" -ne 0 ]]; then
+	log_err "workload failed with rc=${workload_rc}"
+	exit "${workload_rc}"
+fi
+
+for group in "${RDMA_COUNTER_GROUPS[@]}"; do
+	for attr in "${RDMA_COUNTER_ATTRS[@]}"; do
+		key="${group}.${attr}"
+		after["${key}"]="$(read_cm_counter "${counter_root}" "${group}" "${attr}")"
+		delta=$((after["${key}"] - before["${key}"]))
+		echo "${key}.delta=${delta}"
+		if ((delta < 0)); then
+			log_err "counter regressed: ${key}"
+			exit 1
+		fi
+	done
+done
+
+dup_limit=10
+retry_limit=10
+
+for attr in "${RDMA_COUNTER_ATTRS[@]}"; do
+	dup_delta=$((after["cm_rx_duplicates.${attr}"] - before["cm_rx_duplicates.${attr}"]))
+	retry_delta=$((after["cm_tx_retries.${attr}"] - before["cm_tx_retries.${attr}"]))
+
+	if ((dup_delta > dup_limit)); then
+		log_err "duplicate counter exceeds limit: ${attr}=${dup_delta}"
+		exit 1
+	fi
+	if ((retry_delta > retry_limit)); then
+		log_err "retry counter exceeds limit: ${attr}=${retry_delta}"
+		exit 1
+	fi
+done
+
+exit 0
diff --git a/tools/testing/selftests/rdma/rdma_cm_fault_injection.sh b/tools/testing/selftests/rdma/rdma_cm_fault_injection.sh
new file mode 100755
index 000000000000..0202ee901386
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_cm_fault_injection.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -euo pipefail
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+source "${SCRIPT_DIR}/rdma_common.sh"
+
+require_root
+
+debugfs_fail="/sys/kernel/debug/failslab"
+recovery_wait_sec=2
+if [[ ! -d "${debugfs_fail}" ]]; then
+	log_warn "failslab is unavailable: ${debugfs_fail}"
+	exit "${ksft_skip}"
+fi
+
+for knob in probability interval times task-filter; do
+	if [[ ! -f "${debugfs_fail}/${knob}" ]]; then
+		log_warn "failslab knob missing: ${knob}"
+		exit "${ksft_skip}"
+	fi
+done
+
+orig_probability="$(cat "${debugfs_fail}/probability")"
+orig_interval="$(cat "${debugfs_fail}/interval")"
+orig_times="$(cat "${debugfs_fail}/times")"
+orig_task_filter="$(cat "${debugfs_fail}/task-filter")"
+
+restore_knobs()
+{
+	echo "${orig_probability}" >"${debugfs_fail}/probability" || true
+	echo "${orig_interval}" >"${debugfs_fail}/interval" || true
+	echo "${orig_times}" >"${debugfs_fail}/times" || true
+	echo "${orig_task_filter}" >"${debugfs_fail}/task-filter" || true
+}
+
+trap restore_knobs EXIT
+
+log_failslab_state()
+{
+	local state="$1"
+	local task_filter probability interval times
+
+	task_filter="$(cat "${debugfs_fail}/task-filter")"
+	probability="$(cat "${debugfs_fail}/probability")"
+	interval="$(cat "${debugfs_fail}/interval")"
+	times="$(cat "${debugfs_fail}/times")"
+
+	log_info "failslab ${state}: task-filter=${task_filter} probability=${probability}"
+	log_info "failslab ${state}: interval=${interval} times=${times}"
+}
+
+echo 1 >"${debugfs_fail}/task-filter"
+echo 1 >"${debugfs_fail}/probability"
+echo 100 >"${debugfs_fail}/interval"
+echo 1 >"${debugfs_fail}/times"
+log_failslab_state "enabled"
+
+if [[ -z "${CM_WORKLOAD_CMD:-}" && -n "${CM_VALIDATE_RECOVERY_CMD:-}" ]]; then
+	CM_WORKLOAD_CMD="${CM_VALIDATE_RECOVERY_CMD}"
+	log_warn "CM_WORKLOAD_CMD is not set; fallback to CM_VALIDATE_RECOVERY_CMD"
+fi
+
+injected_rc=0
+run_workload || injected_rc=$?
+if [[ "${injected_rc}" -eq "${ksft_skip}" ]]; then
+	exit "${ksft_skip}"
+fi
+log_info "workload rc under injection=${injected_rc}"
+
+echo 0 >"${debugfs_fail}/probability"
+echo 0 >"${debugfs_fail}/times"
+echo 0 >"${debugfs_fail}/task-filter"
+log_failslab_state "disabled"
+
+recovery_cmd="${CM_VALIDATE_RECOVERY_CMD:-${CM_WORKLOAD_CMD:-}}"
+if [[ -z "${recovery_cmd}" ]]; then
+	log_warn "CM_VALIDATE_RECOVERY_CMD and CM_WORKLOAD_CMD are both unset"
+	exit "${ksft_skip}"
+fi
+
+if [[ "${recovery_wait_sec}" != "0" ]]; then
+	log_info "waiting ${recovery_wait_sec}s before recovery workload"
+	sleep "${recovery_wait_sec}"
+fi
+
+log_info "running recovery workload: ${recovery_cmd}"
+if ! bash -c "${recovery_cmd}"; then
+	log_err "recovery workload failed after disabling fault injection"
+	log_err "hint: ensure remote server is restarted and listening for a second connection"
+	exit 1
+fi
+
+exit 0
diff --git a/tools/testing/selftests/rdma/rdma_cm_review_loop.sh b/tools/testing/selftests/rdma/rdma_cm_review_loop.sh
new file mode 100755
index 000000000000..c156090b17e3
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_cm_review_loop.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -euo pipefail
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+cd "${SCRIPT_DIR}"
+
+declare -A rc
+
+run_step()
+{
+	local name="$1"
+	local cmd="$2"
+
+	echo "==== ${name} ===="
+	if bash -c "${cmd}"; then
+		rc["${name}"]=0
+	else
+		rc["${name}"]=$?
+	fi
+	echo "==== ${name} rc=${rc["${name}"]} ===="
+}
+
+run_step baseline "./rdma_cm_baseline.sh"
+run_step trace "./rdma_cm_trace_sequence.sh"
+run_step counters "./rdma_cm_counter_delta.sh"
+run_step fault_injection "./rdma_cm_fault_injection.sh"
+
+echo "==== summary ===="
+for name in baseline trace counters fault_injection; do
+	echo "${name}=${rc["${name}"]}"
+done
+
+exit 0
diff --git a/tools/testing/selftests/rdma/rdma_cm_trace_sequence.sh b/tools/testing/selftests/rdma/rdma_cm_trace_sequence.sh
new file mode 100755
index 000000000000..7e68289345e8
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_cm_trace_sequence.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -euo pipefail
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+source "${SCRIPT_DIR}/rdma_common.sh"
+
+require_root
+require_cmd bash
+require_cmd grep
+
+trace_dir="$(tracefs_dir || true)"
+if [[ -z "${trace_dir}" ]]; then
+	log_warn "tracefs is unavailable"
+	exit "${ksft_skip}"
+fi
+
+if [[ ! -d "${trace_dir}/events/ib_cma" ]]; then
+	log_warn "ib_cma trace events are unavailable"
+	exit "${ksft_skip}"
+fi
+
+workload_rc=0
+
+cleanup_trace()
+{
+	local event
+
+	for event in icm_send_req icm_send_rep icm_send_rtu icm_recv_unknown_attr; do
+		[[ -f "${trace_dir}/events/ib_cma/${event}/enable" ]] && \
+			echo 0 >"${trace_dir}/events/ib_cma/${event}/enable"
+	done
+	[[ -f "${trace_dir}/events/ib_cma/enable" ]] && echo 0 >"${trace_dir}/events/ib_cma/enable"
+	echo 0 >"${trace_dir}/tracing_on"
+}
+
+trap cleanup_trace EXIT
+
+echo 0 >"${trace_dir}/tracing_on"
+echo >"${trace_dir}/trace"
+echo 1 >"${trace_dir}/events/ib_cma/enable"
+
+for event in icm_send_req icm_send_rep icm_send_rtu; do
+	if [[ -f "${trace_dir}/events/ib_cma/${event}/enable" ]]; then
+		echo 1 >"${trace_dir}/events/ib_cma/${event}/enable"
+	fi
+done
+
+echo 1 >"${trace_dir}/tracing_on"
+run_workload || workload_rc=$?
+echo 0 >"${trace_dir}/tracing_on"
+
+if [[ "${workload_rc}" -eq "${ksft_skip}" ]]; then
+	exit "${ksft_skip}"
+fi
+
+trace_log="/tmp/rdma_cm_trace.$(date +%s).log"
+cat "${trace_dir}/trace" >"${trace_log}"
+log_info "captured trace at ${trace_log}"
+
+if ! grep -Eq "icm_send_(req|rep|rtu)" "${trace_log}"; then
+	log_err "missing CM send trace events (req/rep/rtu)"
+	exit 1
+fi
+
+err_lines="$(grep "icm_.*_err" "${trace_log}" || true)"
+if [[ -n "${err_lines}" ]]; then
+	# DREP send failure while already in TIMEWAIT is a common teardown
+	# race and is tolerated for this smoke-style validation script.
+	untolerated_err_lines="$(
+		printf '%s\n' "${err_lines}" | \
+			grep -Ev "icm_send_drep_err: .*state=TIMEWAIT" || true
+	)"
+	if [[ -n "${untolerated_err_lines}" ]]; then
+		log_err "error trace event detected in ib_cma path"
+		printf '%s\n' "${untolerated_err_lines}" >&2
+		exit 1
+	fi
+	log_warn "only tolerated TIMEWAIT drep errors observed"
+fi
+
+exit 0
diff --git a/tools/testing/selftests/rdma/rdma_common.sh b/tools/testing/selftests/rdma/rdma_common.sh
new file mode 100755
index 000000000000..ee3d8b0d86b2
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_common.sh
@@ -0,0 +1,126 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ksft_skip=4
+RET=0
+
+RDMA_COUNTER_GROUPS=(
+	cm_tx_msgs
+	cm_tx_retries
+	cm_rx_msgs
+	cm_rx_duplicates
+)
+
+RDMA_COUNTER_ATTRS=(
+	req
+	mra
+	rej
+	rep
+	rtu
+	dreq
+	drep
+	sidr_req
+	sidr_rep
+	lap
+	apr
+)
+
+log_info()
+{
+	echo "INFO: $*"
+}
+
+log_warn()
+{
+	echo "WARN: $*" >&2
+}
+
+log_err()
+{
+	echo "ERROR: $*" >&2
+}
+
+require_root()
+{
+	if [[ "$(id -u)" -ne 0 ]]; then
+		log_warn "this test requires root privileges"
+		exit "${ksft_skip}"
+	fi
+}
+
+require_cmd()
+{
+	local cmd="$1"
+
+	command -v "${cmd}" >/dev/null 2>&1 || {
+		log_warn "missing required command: ${cmd}"
+		exit "${ksft_skip}"
+	}
+}
+
+tracefs_dir()
+{
+	if [[ -d /sys/kernel/tracing ]]; then
+		echo /sys/kernel/tracing
+	elif [[ -d /sys/kernel/debug/tracing ]]; then
+		echo /sys/kernel/debug/tracing
+	else
+		return 1
+	fi
+}
+
+find_cm_counter_root()
+{
+	local base
+	local port
+	local candidate
+
+	for base in /sys/class/infiniband/*; do
+		[[ -d "${base}" ]] || continue
+
+		for port in "${base}"/ports/*; do
+			[[ -d "${port}" ]] || continue
+			# RoCE / newer sysfs: cm_* groups live directly under ports/<N>/
+			if [[ -d "${port}/cm_tx_msgs" ]]; then
+				echo "${port}"
+				return 0
+			fi
+			# Legacy layout: under counters/ or hw_counters/
+			for candidate in "${port}/counters" "${port}/hw_counters"; do
+				[[ -d "${candidate}/cm_tx_msgs" ]] || continue
+				echo "${candidate}"
+				return 0
+			done
+		done
+	done
+
+	return 1
+}
+
+read_cm_counter()
+{
+	local root="$1"
+	local group="$2"
+	local attr="$3"
+	local path="${root}/${group}/${attr}"
+
+	if [[ -f "${path}" ]]; then
+		cat "${path}" 2>/dev/null
+	else
+		echo 0
+	fi
+}
+
+run_workload()
+{
+	local cmd="${CM_WORKLOAD_CMD:-}"
+
+	if [[ -z "${cmd}" ]]; then
+		log_warn "CM_WORKLOAD_CMD is not set"
+		return "${ksft_skip}"
+	fi
+
+	log_info "running workload: ${cmd}"
+	bash -c "${cmd}"
+}
+
-- 
2.25.1


