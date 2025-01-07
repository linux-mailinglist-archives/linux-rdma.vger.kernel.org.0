Return-Path: <linux-rdma+bounces-6868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93545A037D2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5407A2470
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77501DA0E0;
	Tue,  7 Jan 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q2UYDZXD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9386329;
	Tue,  7 Jan 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230839; cv=none; b=gjUv8R1vwWDwovM2hY6DO06AHOqoolux7p7NRND1DV003Q6Lhumou7vhSMNpeNnZg4e+DZRD8Zg26IuUt/viZ12AHB4ICjhz/pXEC1o1Qvv6NAK0Dukp6h+xhz5mH8Pj29YcQ80hTqbWYy0nVO+4y9SEgOa+la8nt7yP+eg7l3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230839; c=relaxed/simple;
	bh=e2Rj+DQG/pBTm9D3jPt/irqJ5vne+xaM8vK+c6hIKL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Olgb7unjMFBNYzWiWj67SVcrrznGlpAPvtHg9RSrCgtAqwZ0imsGNCY/FhVHJ1OVVoflm04EwYv1ut3jRo6nNDbrRou/KIjYml4yHsDeyj9YWsewMLUAvH8oQzNob/lfIRdr4l/gkhoFqzg1wS0jvo0BKpK8nQ1/8+zhr2ribB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q2UYDZXD; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230836; x=1767766836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2Rj+DQG/pBTm9D3jPt/irqJ5vne+xaM8vK+c6hIKL8=;
  b=q2UYDZXD5yKHsmJfj+CtEYJ4KU36LRwdR8zdNsH2gsWq1s0F+gG8RJZP
   ZRA7waZJR3VbKP5uLVbcCdvjhsjTAJwzkAeVzH02wce5B1I5MfKB2rw0h
   cbSGFuuIeQfnOJw/Gu238TY+lbgSrHW/PdJdwXc1NU+lTkiXfejV6+3ts
   NcF4FgOWub5gB+EpfoplivFFpWhdTz7OHLjSJB6bF0oBqqeSe5cETynzE
   FhI+kqZYGvR33UvfZkHJCpBhBNFiJTFDf2ROI64oRy6FgFkXp8FQcBkT7
   SzzwcO4hQotRXltLgbNCc4vHcgKIHFkNuXqP/e+TomfGiAeEBHSeuAWjs
   Q==;
X-CSE-ConnectionGUID: ZmUt9ss9Tv6yxw3MAuRzpw==
X-CSE-MsgGUID: Fc4SeRyfSrW1KVyFC9nIWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="173126636"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="173126636"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:19:24 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1ABBAD4809;
	Tue,  7 Jan 2025 15:19:22 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E70DBD4BCD;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7FBD4200930D0;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1221A1A006C;
	Tue,  7 Jan 2025 14:19:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests 2/4] tests, common: Get rid of _have_null_blk
Date: Tue,  7 Jan 2025 14:19:03 +0800
Message-Id: <20250107061905.91316-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250107061905.91316-1-lizhijian@fujitsu.com>
References: <20250107061905.91316-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28908.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28908.002
X-TMASE-Result: 10--7.091600-10.000000
X-TMASE-MatchedRID: JSyNGQLhEAZyeiFPOFIChErOO5m0+0gEZR+OFNkbtdotferJ/d7Ab4dY
	wzPgNbi6WRXM1BNPHVMl9+c89RK6DYAiks/+pdsZuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVU2d8
	mtRIRsUOV1ZW035iRJPkLBfx1t6AMJnckDi37jO4gaafg6U60IwkhiZGnJS0/33Nl3elSfsoRSW
	zkeVnBm7lMXBKuvIsD2w7R+xUnlM5oSyaikAlECRmCYUYerLHrfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtGM6W3U+LnncAN/AD9AMFlpn/OQV3eSN/lKM57Su5PQ12IEuUjPaWsQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

- _have_null_blk is same with _have_driver null_blk, it seems there is no
a strong opinion to keep it.
- In addition, '_have_module_param null_blk' will test _have_driver first,
  that means it's safe to remove its former _have_driver in require()

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 common/null_blk | 4 ----
 tests/block/006 | 2 +-
 tests/block/010 | 2 +-
 tests/block/014 | 2 +-
 tests/block/015 | 2 +-
 tests/block/016 | 2 +-
 tests/block/017 | 2 +-
 tests/block/018 | 2 +-
 tests/block/020 | 2 +-
 tests/block/021 | 2 +-
 tests/block/022 | 2 +-
 tests/block/023 | 2 +-
 tests/block/024 | 2 +-
 tests/block/029 | 2 +-
 tests/block/030 | 2 +-
 tests/block/031 | 2 +-
 tests/block/038 | 2 +-
 tests/throtl/rc | 2 +-
 tests/zbd/rc    | 2 +-
 19 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 164125df562d..2b5f57721c25 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -6,10 +6,6 @@
 
 . common/shellcheck
 
-_have_null_blk() {
-	_have_driver null_blk
-}
-
 _have_null_blk_feature() {
 	# Ensure that null_blk driver is built-in or loaded
 	if ! [[ -d /sys/module/null_blk ]]; then
diff --git a/tests/block/006 b/tests/block/006
index 7d05b1113fb9..da909c2a0dca 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -15,7 +15,7 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk blocking && _have_fio
+	_have_module_param null_blk blocking && _have_fio
 }
 
 test() {
diff --git a/tests/block/010 b/tests/block/010
index ed5613525255..4214c17e83a5 100755
--- a/tests/block/010
+++ b/tests/block/010
@@ -15,7 +15,7 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk shared_tags && _have_fio
+	_have_module_param null_blk shared_tags && _have_fio
 }
 
 run_fio_job() {
diff --git a/tests/block/014 b/tests/block/014
index cac779b5e0f2..b118dce8f6f4 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -10,7 +10,7 @@
 DESCRIPTION="run null-blk with blk-mq and timeout injection configured"
 
 requires() {
-	_have_null_blk && _have_module_param null_blk timeout
+	_have_module_param null_blk timeout
 }
 
 test() {
diff --git a/tests/block/015 b/tests/block/015
index afb4b82ccb5b..f5b2592542e4 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -12,7 +12,7 @@ DESCRIPTION="run null-blk on different schedulers with requeue injection configu
 QUICK=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk requeue
+	_have_module_param null_blk requeue
 }
 
 test() {
diff --git a/tests/block/016 b/tests/block/016
index 775069c386bf..4a66218de42b 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -14,7 +14,7 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 }
 
 test() {
diff --git a/tests/block/017 b/tests/block/017
index 59429b0f1359..52ed0056e37c 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -14,7 +14,7 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 }
 
 show_inflight() {
diff --git a/tests/block/018 b/tests/block/018
index e7ac44521cae..e076714d76e0 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -11,7 +11,7 @@ DESCRIPTION="do I/O and check iostats times"
 QUICK=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 }
 
 init_times() {
diff --git a/tests/block/020 b/tests/block/020
index 5ffa23248804..a59e73bdffb8 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -14,7 +14,7 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk && _have_fio
+	_have_driver null_blk && _have_fio
 }
 
 test() {
diff --git a/tests/block/021 b/tests/block/021
index 525d707bce8a..b5b0ee82cbfc 100755
--- a/tests/block/021
+++ b/tests/block/021
@@ -14,7 +14,7 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 }
 
 test() {
diff --git a/tests/block/022 b/tests/block/022
index 10851ff06ac1..42032c6c1ce0 100755
--- a/tests/block/022
+++ b/tests/block/022
@@ -12,7 +12,7 @@ DESCRIPTION="Test hang caused by freeze/unfreeze sequence"
 TIMED=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk shared_tags
+	_have_module_param null_blk shared_tags
 	_require_min_cpus 2
 }
 
diff --git a/tests/block/023 b/tests/block/023
index db1cbe04d5d8..ef48a7a77ed5 100755
--- a/tests/block/023
+++ b/tests/block/023
@@ -13,7 +13,7 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 }
 
 test() {
diff --git a/tests/block/024 b/tests/block/024
index 2a7c934a42ca..8a303e24b6d6 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -13,7 +13,7 @@ DESCRIPTION="do I/O faster than a jiffy and check iostats times"
 QUICK=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 }
 
 init_times() {
diff --git a/tests/block/029 b/tests/block/029
index b9a897dbf830..487ebc9ec326 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -11,7 +11,7 @@ DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
 QUICK=1
 
 requires() {
-	_have_fio && _have_null_blk
+	_have_fio && _have_driver null_blk
 }
 
 modify_nr_hw_queues() {
diff --git a/tests/block/030 b/tests/block/030
index 82330c2736b2..b9974b5d18e4 100755
--- a/tests/block/030
+++ b/tests/block/030
@@ -13,7 +13,7 @@ DESCRIPTION="trigger the blk_mq_realloc_hw_ctxs() error path"
 QUICK=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk init_hctx
+	_have_module_param null_blk init_hctx
 }
 
 test() {
diff --git a/tests/block/031 b/tests/block/031
index 99615ec12c34..58503e6db905 100755
--- a/tests/block/031
+++ b/tests/block/031
@@ -12,7 +12,7 @@ TIMED=1
 
 requires() {
 	_have_fio
-	_have_null_blk
+	_have_driver null_blk
 	if ! _have_null_blk_feature shared_tag_bitmap; then
 		_have_module_param null_blk shared_tag_bitmap
 	fi
diff --git a/tests/block/038 b/tests/block/038
index 56272bebb14c..fbe240c89429 100755
--- a/tests/block/038
+++ b/tests/block/038
@@ -12,7 +12,7 @@ DESCRIPTION="Test null-blk concurrent power/submit_queues operations"
 QUICK=1
 
 requires() {
-	_have_null_blk
+	_have_driver null_blk
 	if ! _have_null_blk_feature submit_queues; then
 		SKIP_REASONS+=("null_blk does not support submit_queues")
 	fi
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 9c264bd39f07..4cf275216cc2 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -15,7 +15,7 @@ declare THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO
 
 group_requires() {
 	_have_root
-	_have_null_blk
+	_have_driver null_blk
 	_have_kernel_option BLK_DEV_THROTTLING
 	_have_cgroup2_controller io
 	_have_program bc
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 570928b37c88..b748d55da2c1 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -14,7 +14,7 @@
 
 group_requires() {
 	_have_root && _have_program blkzone && _have_program dd &&
-		_have_kernel_option BLK_DEV_ZONED && _have_null_blk &&
+		_have_kernel_option BLK_DEV_ZONED && _have_driver null_blk &&
 		_have_module_param null_blk zoned
 }
 
-- 
2.47.0


