Return-Path: <linux-rdma+bounces-6786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C5A00318
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 04:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325DC1883F1B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03737185B62;
	Fri,  3 Jan 2025 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NsBBP7FZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7414F9CC;
	Fri,  3 Jan 2025 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874450; cv=none; b=Uh4+qMdp2JfwbMRzaA66/xgkgNzzZeUgc0XuhoVK6CDLOAHRiijB161ETjudq4jamIkGtNYlfzFv7U6LODSTSaVVIPpVyjIM+gB4Oy1WQvZMv10SGYDmKfJ5jCUANR9Ct7VZCSyrIzy8i4FtsmZoqy35YPZ4s96MUICjDNhsFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874450; c=relaxed/simple;
	bh=VY/DZvQ7xxG17pv9B+6tSdMOli3NPVxZ+1o5uUXxVEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/3EHB3CEO4lXf+p5ZlJxpPUjdAK0F+tEhdo3dfftGXNEK+CGgqooVyblX01HcymNCiY6d/yYxHzXrU4A9xDWP5PjOLBTDUnVUBl+uVepLHh378wJNHjBDp6SZZ9cyYekYyo9IgQkxW1AykHTC9OR19IRTWivUSfmxLPkkL4Mro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NsBBP7FZ; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735874450; x=1767410450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VY/DZvQ7xxG17pv9B+6tSdMOli3NPVxZ+1o5uUXxVEo=;
  b=NsBBP7FZy4rpJZBoXnXYErlEcSxMb30WUkqYxV8z3oM+doevsLSYkx8h
   xiE5hYDPUV+/6fyloOFvq2d09aFnK7KjcwCBWJFMjnlpygDLuQ700KwrY
   EKmQtJoZps/9Gt8JqrdFbdrtwWg3Sj0mFtna/cD2OjHLaucmvynkUl649
   uXY/bTnN4IKC4QggqC9T9WjiU5YffIMFBcvS0e1pDv94eg4VXnLT9fmWK
   7M62/iW1+1kG9hPt8iYwzH+hh4TaRaON+vSd4UItqI/KJI3yFhDAcQF8b
   zalRGitlIdKeezbGF+9wz0iaAhmg44Wul4FtVqa3mWnp/Dv3m7Qu0jHLY
   g==;
X-CSE-ConnectionGUID: 43OuyuT1TVWaBXVR7hIKHw==
X-CSE-MsgGUID: CtdEMU9nQp2lpE3SyV+dkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="164934654"
X-IronPort-AV: E=Sophos;i="6.12,286,1728918000"; 
   d="scan'208";a="164934654"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 12:19:38 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E57EED4F43;
	Fri,  3 Jan 2025 12:19:34 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id ADC54D5050;
	Fri,  3 Jan 2025 12:19:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 438F120076D0E;
	Fri,  3 Jan 2025 12:19:34 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 72C2D1A006C;
	Fri,  3 Jan 2025 11:19:33 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH blktests v3 1/2] tests/rnbd: Add a basic RNBD test
Date: Fri,  3 Jan 2025 11:19:19 +0800
Message-Id: <20250103031920.2868-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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
X-TMASE-Result: 10--10.419300-10.000000
X-TMASE-MatchedRID: ZAkTtSyZ7B4IT+bl0YsmPsaw71DJbaIE9LMB0hXFSehiJsO4rdorwRk5
	KK4/zwVMZRUjkVFROF4pVSN22QMNplK4l8RZlJB8qoeab9Xgz88yhLY8urUHvownGKAoIKJLdTe
	gpK7QnXFSHmZoogkDH+affHI8kAmiHY/bzRmIaZEZgmFGHqyx6x+KaaVwAG43J8lOf52acVAaZW
	50SGemhDZM29W+gPjuxiCFVySb1XRIh3lzWiNI44knvYO5kHScJ7AUYFBH3aZ1l69bBW+lDFC3w
	t5mVI6EuxYW/imZLK2dqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8CIH00BBjDgQjgbS
	npB9VHWRDJJHdMqrs4TsYuhBnTQ1RDIvEhuXQz0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

It attempts to connect and disconnect the rnbd service on localhost.
Actually, It also reveals a real kernel issue[0].

Please note that currently, only RTRS over RXE is supported.

[0] https://lore.kernel.org/linux-rdma/20241231013416.1290920-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  new patch, add a seperate basic rnbd test and simplify the _start_rnbd_client

Copy to the RDMA/rtrs guys:

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/rnbd/001     | 39 +++++++++++++++++++++++++++++++++++
 tests/rnbd/001.out |  2 ++
 tests/rnbd/rc      | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100755 tests/rnbd/001
 create mode 100644 tests/rnbd/001.out
 create mode 100644 tests/rnbd/rc

diff --git a/tests/rnbd/001 b/tests/rnbd/001
new file mode 100755
index 000000000000..ace2f8ea8a2b
--- /dev/null
+++ b/tests/rnbd/001
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+#
+# Basic RNBD test
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
+	local loop_dev
+	loop_dev="$(losetup -f)"
+
+	if _start_rnbd_client "${loop_dev}"; then
+		sleep 0.5
+		_stop_rnbd_client || echo "Failed to disconnect rnbd"
+	else
+		echo "Failed to connect rnbd"
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
index 000000000000..1cf98ad5c498
--- /dev/null
+++ b/tests/rnbd/rc
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+#
+# RNBD tests.
+
+. common/rc
+. common/multipath-over-rdma
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
+_stop_rnbd_client() {
+	local s sessions
+
+	sessions=$(ls -d /sys/block/rnbd* 2>/dev/null)
+	for s in $sessions
+	do
+		grep -qx blktest "$s"/rnbd/session && echo "normal" > "$s"/rnbd/unmap_device
+	done
+}
+
+_start_rnbd_client() {
+	local blkdev=$1
+
+	# Stop potential remaining blktest sessions first
+	_stop_rnbd_client
+	echo "sessname=blktest path=ip:$def_traddr device_path=$blkdev" > /sys/devices/virtual/rnbd-client/ctl/map_device
+}
-- 
2.47.0


