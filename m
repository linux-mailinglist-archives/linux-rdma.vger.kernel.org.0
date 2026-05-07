Return-Path: <linux-rdma+bounces-20140-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMtoJtuK/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20140-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:51:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCE94E87FB
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 177D73017E7B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F73F1646;
	Thu,  7 May 2026 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmOTSwXF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700983AB275;
	Thu,  7 May 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158274; cv=none; b=fAVCMaeM+QMXeODoF7LnsU61z+fNKgDWLFYLEopNAYoddBG9ULChkvRp6+QqgHHbDyPlTBmKRo1y5MLizjyUxc/dsI+FgFHE8Ecd+HYnb/7zpU0NmvoAc7wTE2p9WcVwIThMkKxJFZoPx3X6zy0iJihqfg77K19Q0PltXNO2GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158274; c=relaxed/simple;
	bh=1lnrq1fNp6vpO52lnRddsXLflsbrNwQL37aAeCzE3xM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HLBK3ummZpwRZDYMjb8hygsFSlZ4Ue3TOoUvGJ6lbLt3ipdm5xuSgls/5CPUPqi/V4k5Z5l6hOPrqe1hNFcMEsGFYtZUdcb+GFQHtVW2yyiIeoRbV06TGAeV+qn73+kS74VgJP0iMQnzT5ZPGyV6lHQuxADifj63oxFW9rKG+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmOTSwXF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778158273; x=1809694273;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1lnrq1fNp6vpO52lnRddsXLflsbrNwQL37aAeCzE3xM=;
  b=KmOTSwXFPwgnetc4ok2JrBWJ4eqmPo4v4NBybOOwtoCWZsf8cZuaLgw/
   99NKu2FOWGWvV4eAWkxTlL7PRuIvri3iagQH+PTwcx6EByRK/D4HiKRT7
   5xjD5KlohxA4+ioIJ0UhO4ys0ZLPJoOURJGOqqPAvwN1xtKbnbZPsGevl
   bV2sZv6EGszTv1GPAcLxzL56Uzsg+cSdTIIkphPfOMXOjNlPBahI6Frsg
   nNXA5UZtDw+bjpACAfWyq1pB8VKuNPPVyMbyUGH448JtUUtFU1DY47N24
   xp/dtSOQwjtK73jsakq7AwY7DLAk3YoVpEeSQw+N5pGrpha5EzEnAEwR8
   A==;
X-CSE-ConnectionGUID: vkQwE2PtT8iMStqiVgvlOQ==
X-CSE-MsgGUID: 4fel3f4nQTuxDimJDfMotQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78823039"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="78823039"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 05:51:12 -0700
X-CSE-ConnectionGUID: xXtSLtBmSpGmWRbpO6dMZA==
X-CSE-MsgGUID: ZdvvuSkKR8CXthyymtC8HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="236371396"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by orviesa008.jf.intel.com with ESMTP; 07 May 2026 05:51:09 -0700
From: Yi Lai <yi1.lai@intel.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi1.lai@linux.intel.com,
	yi1.lai@intel.com
Subject: [PATCH] selftests/rdma: explicitly skip tests when required modules are missing
Date: Thu,  7 May 2026 20:51:06 +0800
Message-ID: <20260507125106.3114167-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CCE94E87FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,linux.intel.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20140-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi1.lai@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Currently, the rdma rxe selftests fail with an exit code of 1 when
required kernel modules are not present. This causes spurious failures
in environments where these modules might not be compiled or available.

Include the standard kselftest 'ktap_helpers.sh' and replace the
hardcoded error exits with '$KSFT_SKIP'. This ensures the tests are
properly marked as skipped rather than failed.

Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 tools/testing/selftests/rdma/rxe_ipv6.sh                   | 6 ++++--
 tools/testing/selftests/rdma/rxe_rping_between_netns.sh    | 7 +++++++
 tools/testing/selftests/rdma/rxe_socket_with_netns.sh      | 6 ++++++
 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh | 6 ++++--
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rdma/rxe_ipv6.sh b/tools/testing/selftests/rdma/rxe_ipv6.sh
index b7059bfd6d7c..32dad687a044 100755
--- a/tools/testing/selftests/rdma/rxe_ipv6.sh
+++ b/tools/testing/selftests/rdma/rxe_ipv6.sh
@@ -8,6 +8,8 @@ RXE_NAME="rxe6"
 PORT=4791
 IP6_ADDR="2001:db8::1/64"
 
+source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
+
 exec > /dev/null
 
 # Cleanup function to run on exit (even on failure)
@@ -21,8 +23,8 @@ trap cleanup EXIT
 # 1. Prerequisites check
 for mod in tun veth rdma_rxe; do
     if ! modinfo "$mod" >/dev/null 2>&1; then
-        echo "Error: Kernel module '$mod' not found."
-        exit 1
+        echo "SKIP: Kernel module '$mod' not found." >&2
+        exit $KSFT_SKIP
     fi
 done
 
diff --git a/tools/testing/selftests/rdma/rxe_rping_between_netns.sh b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
index e5b876f58c6e..e7554fbb8951 100755
--- a/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
+++ b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
@@ -8,6 +8,8 @@ IP_A="1.1.1.1"
 IP_B="1.1.1.2"
 PORT=4791
 
+source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
+
 exec > /dev/null
 
 # --- Cleanup Routine ---
@@ -27,6 +29,11 @@ if [[ $EUID -ne 0 ]]; then
    exit 1
 fi
 
+if ! modinfo rdma_rxe >/dev/null 2>&1; then
+    echo "SKIP: Kernel module 'rdma_rxe' not found." >&2
+    exit $KSFT_SKIP
+fi
+
 modprobe rdma_rxe || { echo "Failed to load rdma_rxe"; exit 1; }
 
 # --- Setup Network Topology ---
diff --git a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
index 002e5098f751..9478657c02c1 100755
--- a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
+++ b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
@@ -4,6 +4,8 @@
 PORT=4791
 MODS=("tun" "rdma_rxe")
 
+source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
+
 exec > /dev/null
 
 # --- Helper: Cleanup Routine ---
@@ -26,6 +28,10 @@ if [[ $EUID -ne 0 ]]; then
 fi
 
 for m in "${MODS[@]}"; do
+    if ! modinfo "$m" >/dev/null 2>&1; then
+        echo "SKIP: Kernel module '$m' not found." >&2
+        exit $KSFT_SKIP
+    fi
     modprobe "$m" || { echo "Error: Failed to load $m"; exit 1; }
 done
 
diff --git a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
index 021ca451499d..8c18cea7535c 100755
--- a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
+++ b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
@@ -5,6 +5,8 @@ DEV_NAME="tun0"
 RXE_NAME="rxe0"
 RDMA_PORT=4791
 
+source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
+
 exec > /dev/null
 
 # --- Cleanup Routine ---
@@ -19,8 +21,8 @@ trap cleanup EXIT
 
 # 1. Dependency Check
 if ! modinfo rdma_rxe >/dev/null 2>&1; then
-    echo "Error: rdma_rxe module not found."
-    exit 1
+    echo "SKIP: rdma_rxe module not found." >&2
+    exit $KSFT_SKIP
 fi
 
 modprobe rdma_rxe
-- 
2.43.0


