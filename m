Return-Path: <linux-rdma+bounces-6706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54079FAA12
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 06:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5153D163F8A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 05:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9A84A22;
	Mon, 23 Dec 2024 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="N1QQsgNb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02A1392;
	Mon, 23 Dec 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734932764; cv=none; b=Xuw39NbE+QonAN+cWPVRnAPi/ked7iXLFwn25PGvTkb8HjrgPTbYtMqXfeUphUAbdJKK3yyRLH1QrBRK+8XPBIjTC8Rb2tIeWiMQawHKkCjW0jNhCBKICgQq+8Oxq3XZG7ejOHlXOJRZkvOO+dHAou7rpkFHNwsgw3bxMTH7Q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734932764; c=relaxed/simple;
	bh=kwh8yt7QrtrmbLFLEnSzLcgMG/3xNk4QproYhsIu8AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RzRpaOwFN0irDG0wc/yUhj2KykDjF5HUYwvfUexSG33K+o9MHH8vlrLvVHfh76Knymi7BsOyc9gCZ+JA5HI0+Y30w5j9BIuUMqMXRfaIbHyWPRUjEINiBi2lauRwq8Mh/IhUxPHaF2CF/NJ/mRtsZWvf4CszSHDVTjYL8emw0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=N1QQsgNb; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734932759; x=1766468759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kwh8yt7QrtrmbLFLEnSzLcgMG/3xNk4QproYhsIu8AI=;
  b=N1QQsgNbAzush2JI4XGZlq3ZSFA8UD4Vsky90Maom1HW68Xx947DD3jU
   csTIH2qX3TC/uYrPlfScuS33VgxLS46QDz3QV6RTt8lGpajvWaE2HuxI5
   DN3Cex2VnQOFQmeN3W4XOKclD5PTdGiJzT6xgcCmtzcQVI7luUA8zd/Jh
   HeVmylTXiDFbE2cNeZ35IHk2oxYbvR6LqjzzXOqThuzdb28AoQzCJ15uo
   pA6T9PpqdQQJXPQbvIHQlwq202JFbgoRV83KNIxkD9ySwSjxhXyDgJOi3
   XZ6DgRIYkOUOP8XO/bHjVr/Hhz/5UczZ2DjOZB+jGuqMBk2hu7NkQLv3i
   Q==;
X-CSE-ConnectionGUID: 8h2mBt3eQvW9ldElNEkrXA==
X-CSE-MsgGUID: 25zEAtcRRdaO9DUalJ04zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="163567376"
X-IronPort-AV: E=Sophos;i="6.12,256,1728918000"; 
   d="scan'208";a="163567376"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 14:45:50 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 088B2DBB87;
	Mon, 23 Dec 2024 14:45:50 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D6145D8ADF;
	Mon, 23 Dec 2024 14:45:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D20340306;
	Mon, 23 Dec 2024 14:45:49 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 336701A006C;
	Mon, 23 Dec 2024 13:45:48 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH blktests] tests/rnbd: Implement RNBD regression test
Date: Mon, 23 Dec 2024 13:45:35 +0800
Message-Id: <20241223054535.295371-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28876.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28876.005
X-TMASE-Result: 10--7.771600-10.000000
X-TMASE-MatchedRID: B9/cONLFiGgvt8akOOKRVrPx3rO+jk2QPYWAASIMdr/kMnUVL5d0EyBd
	jvfSqXgxiEMe1XiiIvM26w1VKWEcTZO8e+qccBn+vHKClHGjjr34qCLIu0mtIL54YCapH5tAi3G
	OCGgGiOYppiuzBwGFPv+EMOr9fJmZr8SWmHOl/UsReM8i8p3vgEyQ5fRSh265uBsk5njfgGyLzF
	PtiZmry+gN+fRudlV6jkW+L+PYS7OmWOD8X0TFhHV7tdtvoibaR8s92weZBuct3rmov76grPcLT
	3NnoHhsvtqCRGwbz0HMQN2xWFtdUkRj6tUqFpLAngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiAq
	rjYtFiSfWhurbevooodJtkBf4H9CAWidOnfRxpXQ7EKDnf7m537cGd19dSFd
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
Copy to the RDMA/rtrs guys:

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
---
 tests/rnbd/001     | 37 ++++++++++++++++++++++++++++
 tests/rnbd/001.out |  2 ++
 tests/rnbd/rc      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100755 tests/rnbd/001
 create mode 100644 tests/rnbd/001.out
 create mode 100644 tests/rnbd/rc

diff --git a/tests/rnbd/001 b/tests/rnbd/001
new file mode 100755
index 000000000000..220468f0f5b4
--- /dev/null
+++ b/tests/rnbd/001
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright 2024, Fujitsu
+#
+. tests/rnbd/rc
+
+DESCRIPTION="Start Stop RNBD"
+CHECK_DMESG=1
+
+requires() {
+	_have_rnbd
+}
+
+test_start_stop()
+{
+	_setup_rnbd || return
+
+	local loop_dev i j
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
index 000000000000..143ba0b59f38
--- /dev/null
+++ b/tests/rnbd/rc
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright 2024, Fujitsu
+#
+# RNBD tests.
+
+. common/rc
+. common/multipath-over-rdma
+
+_have_rnbd() {
+	if [[ "$USE_RXE" != 1 ]]; then
+		SKIP_REASONS+=("Only USE_RXE=1 is supported")
+		return 1
+	fi
+	_have_driver rdma_rxe || return
+	_have_driver rnbd_server || return
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
+	rnbd_node=$a
+}
+
+_stop_rnbd_client() {
+	echo "normal" > "$rnbd_node"/rnbd/unmap_device
+}
-- 
2.47.0


