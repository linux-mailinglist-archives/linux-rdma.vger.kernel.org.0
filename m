Return-Path: <linux-rdma+bounces-6738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E89FC46D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 10:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25BF7A1719
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D715359A;
	Wed, 25 Dec 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Btq6fP5m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA871494C9;
	Wed, 25 Dec 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735119524; cv=none; b=fc3WATNh8yEeVZy4r7WVr42lNkSzHw5Rv8blB1a0+25c8+M/hrUeptLROJAtBr2d5PUs9nqcSpH3G/w8u/QAYB30t2GzULA3ENVgO26QTtc/odoAAf3xoIwUnndNghV7eByoFWgYGgWbFS0PEQivs4icRKOOl6S/OaFYojDyr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735119524; c=relaxed/simple;
	bh=cfo6KNlbX/45+d05FvY9vFNPfRns+srwEAMbMSoshZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ui6OV5ak51vLWz/30UsKuKccoynLwqgtJ2zzXaz589LNg+c+tP4rGcR96o/qSl0pdGsRektyJml2KDyGg0XknA/zgs6do/xkLCYeIOhIl7wUBMpmQR4s5om1Rk2LWImx0WdSAgksxQ3O50aSBFglB+hNWRVT6p8+WsKVE4fFi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Btq6fP5m; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735119522; x=1766655522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cfo6KNlbX/45+d05FvY9vFNPfRns+srwEAMbMSoshZY=;
  b=Btq6fP5mArUY3Lj9Me1fKNmXhQVknHRlB0n9Btj2QRGbKHH9E/SeFxDO
   7mRde7M/A3NYpFrFRAJxblUXOhKuGfv18dDeaxV91WNahoUMlD05lP+be
   uVBNMzHyac62Mt8HC9sbBrfx+o1f4g7so3iBw1/sfyGr4SxkazVSdr7eB
   0oWgLUOPDZC2JDr1u//5iKESGYaG2v7BLho+UTSqvyF/YBF5h/SB4Rh/3
   nPcQgKqdbo+InPbG321pFee9d7ybL3bE+yFpgkIT6iqOXbUDvt8vSF9s2
   h4xjOAJDFq1PYuem/jxmHN2wsqHM+VqyIslbXgls7Y2e5dI0GKl8uJI/P
   A==;
X-CSE-ConnectionGUID: lQqgfA0gSCSmUnvq32oN/A==
X-CSE-MsgGUID: skwuURSMR++OtK+GmCViQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="185123655"
X-IronPort-AV: E=Sophos;i="6.12,262,1728918000"; 
   d="scan'208";a="185123655"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 18:38:33 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D090D4C36;
	Wed, 25 Dec 2024 18:38:31 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 15EA8D5C2A;
	Wed, 25 Dec 2024 18:38:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EB23200838A4;
	Wed, 25 Dec 2024 18:38:30 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8447B1A006C;
	Wed, 25 Dec 2024 17:38:29 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH blktests v2 1/2] tests/rnbd: Implement RNBD regression test
Date: Wed, 25 Dec 2024 17:37:50 +0800
Message-Id: <20241225093751.307267-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28880.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28880.006
X-TMASE-Result: 10--14.015900-10.000000
X-TMASE-MatchedRID: 1rz8YgpJmagvt8akOOKRVrPx3rO+jk2QPYWAASIMdr/kMnUVL5d0EyBd
	jvfSqXgxiEMe1XiiIvM26w1VKWEcTZO8e+qccBn+vHKClHGjjr34qCLIu0mtIEOgo9xF1gRNv4i
	GaCPo3FaPwkZh4yPwy/qxXporkUKJWjws5pdLmBZO5y1KmK5bJSkDYTG6KmZaq8KsbROd9VSArq
	oIZrVn12xeoKLN1RJD6L2S69zMjXlZ9E0F9cXPfjo39wOA02LhF4r8H5YrEqxLWMri+QqmsZQNd
	SgLxtlLGf9KswubdQeORb4v49hLs6ZY4PxfRMWEdXu122+iJtpHyz3bB5kG5y3euai/vqCs9wtP
	c2egeGy+2oJEbBvPQcxA3bFYW11SRGPq1SoWksCeAiCmPx4NwGmRqNBHmBveovSVS26nOBcqtq5
	d3cxkNY9VbVgm9IO5HhDDxig+KrwiUxAhFs/34jJoBvMikpL3yaNI/QS1Yvc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This test case has been in my possession for quite some time.
I am upstreaming it now because it has once again detected a regression in
a recent kernel release [1].

It's just stupid to connect and disconnect RNBD on localhost and expect
no dmesg exceptions, with some attempts actually succeeding.

Please note that currently, only RTRS over RXE is supported.

[1] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
  - address comments from Shinichiro
  - minor fixes

Copy to the RDMA/rtrs guys:

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
---
 tests/rnbd/001     | 47 +++++++++++++++++++++++++++++++++
 tests/rnbd/001.out |  2 ++
 tests/rnbd/rc      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100755 tests/rnbd/001
 create mode 100644 tests/rnbd/001.out
 create mode 100644 tests/rnbd/rc

diff --git a/tests/rnbd/001 b/tests/rnbd/001
new file mode 100755
index 000000000000..ef8dff93a94a
--- /dev/null
+++ b/tests/rnbd/001
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+#
+# Regression test for the following patch
+#  RDMA/ulp: Add missing deinit() call
+#
+# It assists in detecting a 'list_add corruption' kernel warning by repeatedly
+# connecting and disconnecting the RNBD.
+#
+. tests/rnbd/rc
+
+DESCRIPTION="Start Stop RNBD"
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
+		_start_rnbd_client "${loop_dev}" &>/dev/null &&
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
diff --git a/tests/rnbd/001.out b/tests/rnbd/001.out
new file mode 100644
index 000000000000..c1f9980d0f7b
--- /dev/null
+++ b/tests/rnbd/001.out
@@ -0,0 +1,2 @@
+Running rnbd/001
+Test complete
diff --git a/tests/rnbd/rc b/tests/rnbd/rc
new file mode 100644
index 000000000000..577cdbad61ef
--- /dev/null
+++ b/tests/rnbd/rc
@@ -0,0 +1,66 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+#
+# RNBD tests.
+
+. common/rc
+. common/multipath-over-rdma
+
+declare RNBD_ENTRY
+
+_have_rnbd() {
+	if [[ "$USE_RXE" != 1 ]]; then
+		SKIP_REASONS+=("Only USE_RXE=1 is supported")
+	fi
+	_have_driver rdma_rxe
+	_have_driver rnbd_server
+	_have_driver rnbd_client
+}
+
+_setup_rnbd() {
+	modprobe -q rnbd_server
+	modprobe -q rnbd_client
+	start_soft_rdma
+	for i in $(rdma_network_interfaces)
+	do
+		ipv4_addr=$(get_ipv4_addr "$i")
+		if [[ -n "${ipv4_addr}" ]]; then
+			def_traddr=${ipv4_addr}
+		fi
+	done
+}
+
+_cleanup_rnbd()
+{
+	stop_soft_rdma
+}
+
+_start_rnbd_client() {
+	local a b
+	local blkdev=$1
+	local before after
+
+	before=$(ls -d /sys/block/rnbd* 2>/dev/null)
+	if ! echo "sessname=blktest path=ip:$def_traddr device_path=$blkdev" > /sys/devices/virtual/rnbd-client/ctl/map_device; then
+		return 1
+	fi
+
+	# Retrieve the newly added rnbd entry
+	after=$(ls -d /sys/block/rnbd* 2>/dev/null)
+	for a in $after
+	do
+		[[ -n "$before" ]] || break
+
+		for b in $before
+		do
+			[[ "$a" = "$b" ]] || break
+		done
+	done
+
+	RNBD_ENTRY=$a
+}
+
+_stop_rnbd_client() {
+	echo "normal" > "$RNBD_ENTRY"/rnbd/unmap_device
+}
-- 
2.47.0


