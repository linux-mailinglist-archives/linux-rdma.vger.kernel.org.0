Return-Path: <linux-rdma+bounces-6863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5EA037AA
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A601648E0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A61DC046;
	Tue,  7 Jan 2025 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Zm2sNqxi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEA1DDC3A;
	Tue,  7 Jan 2025 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230122; cv=none; b=lY2rfjCpK0uY23vKXjDaE4pPHJ3fPBtifVo8P1d1oSqt1wXBZVX8EmPFGWDjbS3coec7H+INA6h2scK69zFBzFDQWGKrGwEK+6MKhA4+J3AKWApZXluthjHqilQy3pJ0wd6t7+uKNCkSz3SteDBwwfUcD6/4iLpaJBG4HG43HyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230122; c=relaxed/simple;
	bh=ms2lhcj64js36UcB9V2Y6unDC3Br/fF4TSpdFW3VyNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=src1q/keopiHdkvUntYRgjqB9uf6hYvLQGG0S2Vs2ekuY1knHsKVsEv2lg4tTlYKa7Nw2hoBG+3b2XrM5zTqOJ0maRwUW4TVMUcR+MMLTOCgelPLlQEtatlyRaQZmm5RsKgFto5VISKevDYHOgzj9yeyB/ufp8VsC8ycNq5xzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Zm2sNqxi; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230119; x=1767766119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ms2lhcj64js36UcB9V2Y6unDC3Br/fF4TSpdFW3VyNM=;
  b=Zm2sNqxibdMEO0D/Usblv2SFGOYgwss8HztF11mEKFvmkCe7Kz1HuUPx
   rCmAmlQEhAXN6m7wBFxa9RbEiSfAXT47en8S3gipF0bX2DXj88Qs504d+
   AztfimYZpYeFY1RBjC5UgRPjcLRSR7QJ8gYGlKOjeIesFGbiE3oWs8Zgj
   vxLTMGPQITV/Nudu7nnLggiaEDpuPSl35c2NZoUwVnGPdmiHpubO577Bd
   pXcBbjPriNTcdqbt3ganPZrcduEhckvfWHgZwPinB+2CLhsSU/5NeqIzL
   UxVJ82potzCiq4nPnuAjz2i28XmKvYXW3veJOwrsx3MGr6E3+WknC/duu
   Q==;
X-CSE-ConnectionGUID: tJGI+QSATSK+nTHqeJ8MQw==
X-CSE-MsgGUID: Q6lhQSzNTvC78LB3RbXonQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="165250884"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="165250884"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:08:30 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E9E68DBB80;
	Tue,  7 Jan 2025 15:08:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C025DD729C;
	Tue,  7 Jan 2025 15:08:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4953541192;
	Tue,  7 Jan 2025 15:08:27 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id DA4D01A0071;
	Tue,  7 Jan 2025 14:08:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH blktests v4 2/2] tests/rnbd: Implement RNBD regression test
Date: Tue,  7 Jan 2025 14:08:10 +0800
Message-Id: <20250107060810.91111-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250107060810.91111-1-lizhijian@fujitsu.com>
References: <20250107060810.91111-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--18.353400-10.000000
X-TMASE-MatchedRID: OoGyGKJIUKkvt8akOOKRVrPx3rO+jk2QPYWAASIMdr/kMnUVL5d0EyBd
	jvfSqXgxiEMe1XiiIvM26w1VKWEcTZO8e+qccBn+HPYwOJi6PLlUENBIMyKD0RHfiujuTbedPsL
	bOLnF04TVzTwOl2S/RoCzFvXiMRrlxB13Y/+OC6Y8o3fwIs8rQQmWvXEqQTm5vn+2qfQyWg3s+3
	eqT4BLa/mNDPvp636/ytuC65NNIO5MGF0Ua9spp7cPsR57JkIzX098A7fr3VeiC7BD4niBmAvzn
	YJVXoOYnUY+WM9pU6r77xI1nIlx8ldjnN7rNQ8pSHCU59h5KrHVBDonH99+VoDpStszePepujko
	/YabujJlfaF/BQ/timzNhvRhOypXM58Povq2gqP+xRIVoKNMvEfLPdsHmQbnr29kEVJDJAMYQb1
	oGZV/vOLzNWBegCW2wgn7iDBesS28QIu4z6HhEH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This test case has been in my possession for quite some time.
I am upstreaming it now because it has once again detected a regression in
a recent kernel release[0].

It's just stupid to connect and disconnect RNBD on localhost and expect
no dmesg exceptions, with some attempts actually succeeding.

rnbd/002 (Start Stop RNBD repeatedly)                        [passed]
    runtime                   13.252s  ...  13.099s
    start/stop success ratio  100/100  ...  100/100

[0] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4:
  - Fix a typo and update the passed condition # Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
  - rename test_start_stop() to test_start_stop_repeatedly()

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
---
 tests/rnbd/002     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/rnbd/002.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/rnbd/002
 create mode 100644 tests/rnbd/002.out

diff --git a/tests/rnbd/002 b/tests/rnbd/002
new file mode 100755
index 000000000000..7d7da9401974
--- /dev/null
+++ b/tests/rnbd/002
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+#
+# Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduced a
+# new element .deinit but never used it at all that lead to a
+# 'list_add corruption' kernel warning.
+#
+# This test is intended to check whether the current kernel is affected.
+# The following patch resolves this issue.
+#  RDMA/rtrs: Add missing deinit() call
+#
+. tests/rnbd/rc
+
+DESCRIPTION="Start Stop RNBD repeatedly"
+CHECK_DMESG=1
+QUICK=1
+
+requires() {
+	_have_rnbd
+	_have_loop
+}
+
+test_start_stop_repeatedly()
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
+	TEST_RUN["start/stop success ratio"]="${j}/${i}"
+
+	_cleanup_rnbd
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	test_start_stop_repeatedly
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


