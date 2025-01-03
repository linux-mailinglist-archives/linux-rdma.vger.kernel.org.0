Return-Path: <linux-rdma+bounces-6787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D95A0031A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 04:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775921633A0
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 03:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8A192B96;
	Fri,  3 Jan 2025 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bUCmcXOZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD6155322;
	Fri,  3 Jan 2025 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874450; cv=none; b=ORrlzX5gkaYu9qPbkvi5lUDI8Elbv0OSjmQTwRVGOFIhKyrVS4+p9htAxw5WvtSgWKapzw5x8laWwQpFcoFLPonoBVVcqk6tyU35Pcx73bVqUiVi4sV8oHYmmK5Gz4XkokZUbYyP9TOpL5kszt/vhe1DJH6g2AWUMcMU3GtZ3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874450; c=relaxed/simple;
	bh=KniUodeo34hOam1NVJUQVtnZbKx0RR7nF0BaSVvLONY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X15BdwtJru/MvVYzBWMyaRfjOgYFS5zAtgXIC8UVgDFC4lHR/k3Lxm6IJp3LVy+XOFmAUmbno6kOcc0DlUMn17Nb8ipnmwgcfHoMw6R1lSOoBSs5n6lpjkHH0+BIpJsYOLtO8vF8QFxxNeOS4cUxqH0zY1f098FmW2PK3EGnh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bUCmcXOZ; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735874449; x=1767410449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KniUodeo34hOam1NVJUQVtnZbKx0RR7nF0BaSVvLONY=;
  b=bUCmcXOZ0Wvy2hK66UJoa/l0DrYeK6xcVUPwxpZCKWQCUY8l1yLCnA+h
   yj/hRODrTNgL+tlcgnobONpz9HcNkYvanCA0tMpHE0vuQDAML1mn1kWnB
   9sDoVL4zlPJxVb+xlxc6HBxl63FgSMsNEGRhiFRti6UHjUHgZfxcjLC0Q
   G7VAAvo9bqbmNSnie1xUQtYxy2vkt5yH9eW2rv94Zwfx5uNnAw5px5k3w
   /oXR43dhFjL2eUquZuc+qKMCGy1HJgppyB4UKYpSiZ4S7Qsojn3tsiqoM
   pU9ostWh5Xe+Ml3y2j3LpxZHA1vXWK5PnGl7OjQZ/PsCJDoyqMgZhpJFg
   g==;
X-CSE-ConnectionGUID: hTt2ByKuRsGaxAcqyLRsAg==
X-CSE-MsgGUID: FBeNm4A7SfKWYvw+g57MLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="173471325"
X-IronPort-AV: E=Sophos;i="6.12,286,1728918000"; 
   d="scan'208";a="173471325"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 12:19:37 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75F98D4F43;
	Fri,  3 Jan 2025 12:19:35 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4222CD5050;
	Fri,  3 Jan 2025 12:19:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A7D7720079DFB;
	Fri,  3 Jan 2025 12:19:34 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 10ED61A0071;
	Fri,  3 Jan 2025 11:19:34 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH blktests v3 2/2] tests/rnbd: Implement RNBD regression test
Date: Fri,  3 Jan 2025 11:19:20 +0800
Message-Id: <20250103031920.2868-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250103031920.2868-1-lizhijian@fujitsu.com>
References: <20250103031920.2868-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28898.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28898.004
X-TMASE-Result: 10--18.550900-10.000000
X-TMASE-MatchedRID: xSdrm2HKzRgvt8akOOKRVrPx3rO+jk2QPYWAASIMdr/kMnUVL5d0EyBd
	jvfSqXgxiEMe1XiiIvM26w1VKWEcTZO8e+qccBn+nVTWWiNp+v+Siza26cvwNEOgo9xF1gRNv4i
	GaCPo3FaPwkZh4yPwy/qxXporkUKJWjws5pdLmBZO5y1KmK5bJSkDYTG6KmZaq8KsbROd9VSArq
	oIZrVn12xeoKLN1RJD6L2S69zMjXlZ9E0F9cXPfsYv//yaWh0D/OuUJVcMZhv8gmFVD37LXYnO/
	I/i7S2AhhWw3FFEQSVatvUzMDckKg8rYO92b9NmKsurITpSv+PKrKWVfpQki673LMce7RmJgPgG
	+3CAdGmbpZ8QUEHE+n237mlWhg4Rh3+CL8/F/s3mOliryhGWU685fLDYlgpSmyiLZetSf8mfop0
	ytGwvXiq2rl3dzGQ1A/3R8k/14e0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This test case has been in my possession for quite some time.
I am upstreaming it now because it has once again detected a regression in
a recent kernel release[0].

It's just stupid to connect and disconnect RNBD on localhost and expect
no dmesg exceptions, with some attempts actually succeeding.

[0] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  - Always stop the rnbd regardless of the result of start

V2:
  - address comments from Shinichiro
  - minor fixes

Copy to the RDMA/rtrs guys:

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/rnbd/002     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/rnbd/002.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/rnbd/002
 create mode 100644 tests/rnbd/002.out

diff --git a/tests/rnbd/002 b/tests/rnbd/002
new file mode 100755
index 000000000000..9ebec927db72
--- /dev/null
+++ b/tests/rnbd/002
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+#
+# Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduced a
+# new element .deinit but never used it at all that lead to a
+# 'list_add corruption' kernel warning.
+#
+# This test is intended to check whether the current kernel is affected.
+# The following patch is able to fix this issue.
+#  RDMA/rtrs: Add missing deinit() call
+#
+. tests/rnbd/rc
+
+DESCRIPTION="Start Stop RNBD repeatly"
+CHECK_DMESG=1
+QUICK=1
+
+requires() {
+	_have_rnbd
+	_have_loop
+}
+
+test_start_stop()
+{
+	_setup_rnbd || return
+
+	local loop_dev i j=0
+	loop_dev="$(losetup -f)"
+
+	for ((i=0;i<100;i++))
+	do
+		_start_rnbd_client "${loop_dev}" &>/dev/null
+		# Always stop it so that the next start has change to work
+		_stop_rnbd_client &>/dev/null && ((j++))
+	done
+
+	# We expect at least 10% start/stop successfully
+	if [[ $j -lt 10 ]]; then
+		echo "Failed: $j/$i"
+	fi
+
+	_cleanup_rnbd
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	test_start_stop
+	echo "Test complete"
+}
diff --git a/tests/rnbd/002.out b/tests/rnbd/002.out
new file mode 100644
index 000000000000..2f055b8c82f9
--- /dev/null
+++ b/tests/rnbd/002.out
@@ -0,0 +1,2 @@
+Running rnbd/002
+Test complete
-- 
2.47.0


