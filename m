Return-Path: <linux-rdma+bounces-6864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC0A037B7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A63A48ED
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1540157493;
	Tue,  7 Jan 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OXorDvBO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA232AEE3;
	Tue,  7 Jan 2025 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230185; cv=none; b=OI68xb5dqhvkd2rINs9jiy57c5wNoU370r9eb0jqmazdItgCBbYomPs5Zn/Rn3SJJeQcT2bpPBFaHPZEAC9LTtnHADB25KKeVqAC3X5uS1w3gHINcgIgPTAyCMh9+n76g1rQNb1CkC2hjt/+6eobHrK25FW5N0ENiHPF1g8Ka2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230185; c=relaxed/simple;
	bh=HPdc+dn+9OTSivWxAIsYJIPiHKS8j0kqIdWCL77c5XM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ir/fII6HvhIaLwg7AtnfIiJgceaLTpw8+KRBnDrO9LP85WAEbpgJJC/2octpF1ANmViKYLUrdb3ZoQNk+58Oqr0TKuB25d1hsBmYmQ4Rc6XlLDa+CX5vmTrqvCOgQmRSSH+3urfEj5NX9uVCqT0T8A2Rj9sg4d2PQnbZETT64XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OXorDvBO; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230181; x=1767766181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HPdc+dn+9OTSivWxAIsYJIPiHKS8j0kqIdWCL77c5XM=;
  b=OXorDvBOsZUR31/r5BrF3iZomz9oJ+k1RjP5Sv7gLEPdF+d9JrGy3DEv
   i21E5vf+X6bFPAO9XPflPr82WtFsfw1dZSg8PDkMp2f/Nl9SZhpme60o2
   11BikUjCIBkiMQly/4WAN6mpLga8Xfd9uMFwjD5YyUQUVOQ8i/YRMciT/
   mqWOFWEVnVmiC9D3KGWo3fai5MhgVZdAWKIz5BQYCwdK1AMFtM0gngs/2
   xO5M+N1+mFt5V6LWNWsgT6fTX7g4brBv8DtoPhS0jfn/3pkrxQr9bHTnP
   3LaLy5afzX3ehuGOYHsqZ+6H8miwvA4jw3fX4QY1Nl87zUkr2OsVb93T4
   w==;
X-CSE-ConnectionGUID: eeQWw69jQuWm2Px50/SBaQ==
X-CSE-MsgGUID: Ua0sZB1CRtu78jnt0tZXVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="185822157"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="185822157"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:08:30 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F228BD4807;
	Tue,  7 Jan 2025 15:08:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C5EF4D4BCF;
	Tue,  7 Jan 2025 15:08:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4BA561EB6AE;
	Tue,  7 Jan 2025 15:08:27 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1C50D1A006C;
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
Subject: [PATCH blktests v4 1/2] tests/rnbd: Add a basic RNBD test
Date: Tue,  7 Jan 2025 14:08:09 +0800
Message-Id: <20250107060810.91111-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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
X-TMASE-Result: 10--10.419300-10.000000
X-TMASE-MatchedRID: ZAkTtSyZ7B4IT+bl0YsmPsaw71DJbaIE9LMB0hXFSehiJsO4rdorwXwZ
	JvXBnaQ91w2oUru1aWFRS7xjEb+dxIdhJvvq7rh/CtzGvPCy/m7VBDonH99+VuTpBuL72LoPqCf
	eIlEscU6XE+xHCJjkvLwc7WEBS4b74FG4Cyz4VuYReM8i8p3vgFK6+0HOVoSoUfeuS/NtY8zghv
	PcIfe8J4i4DWKFrRIOwoeVJAYvYhNIh3lzWiNI44knvYO5kHScJ7AUYFBH3aZ1l69bBW+lDFC3w
	t5mVI6EuxYW/imZLK2dqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8ELR9u8p1o5bpQTM
	SD4vSxkC5niqepyKc5SJnW2KfWvQIDCCVYmXyuc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

It attempts to connect and disconnect the rnbd service on localhost.
Actually, It also reveals a real kernel issue[0].

rnbd/001 (Start Stop RNBD)                                   [passed]
    runtime  1.425s  ...  1.157s

Please note that currently, only RTRS over RXE is supported.

[0] https://lore.kernel.org/linux-rdma/20241231013416.1290920-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4:
  test start_soft_rdma # Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
V3:
  new patch, add a seperate basic rnbd test and simplify the _start_rnbd_client

Copy to the RDMA/rtrs guys:

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
---
 tests/rnbd/001     | 39 ++++++++++++++++++++++++++++++++++
 tests/rnbd/001.out |  2 ++
 tests/rnbd/rc      | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
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
index 000000000000..a5edc2e5ad9c
--- /dev/null
+++ b/tests/rnbd/rc
@@ -0,0 +1,52 @@
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
+	start_soft_rdma || return $?
+
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


