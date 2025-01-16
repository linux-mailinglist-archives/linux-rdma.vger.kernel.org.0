Return-Path: <linux-rdma+bounces-7034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB978A131E1
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 05:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976077A27D4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 04:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9178F2E;
	Thu, 16 Jan 2025 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="X+ltxZ1r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D241C6A;
	Thu, 16 Jan 2025 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737000347; cv=none; b=Yc0MALmodl2N1TJFYXL8icxxFv0XuF7PrH3Gfd47Y7NEvq/DpfCWy9V7T1lxbR5h59Mta8M9jqs9r30ezR7PBH7v8HC8EiZye6leM/wYedrPbDUFzwuPjebUryQ2aBpcq/O5P85efRY3hlT1/pREzc/87mC6WaKmULMToarsTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737000347; c=relaxed/simple;
	bh=7lIrF7oO4Pwd4L12BlIXY2/1HqjaOPrMQyk1MFQIJpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XRFSdISoV1Lh2mHZcp33KdM0AjVqFk23/tOcCAOwLcKK1OBa9jdDoBv3RCALnHtk5Lh1ffIi6pRhKBrr5pfo9Qz9bXjbYa3Q2RUyOSup0+MCTUTRsGi+19mZlMJqNb1Has9l3MaI3d2no/ThN3YcJX19G/B6XU8Cu6RAhSKwv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=X+ltxZ1r; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1737000345; x=1768536345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7lIrF7oO4Pwd4L12BlIXY2/1HqjaOPrMQyk1MFQIJpI=;
  b=X+ltxZ1rFtUJNYQ6K0eiVMKddIfcb/GjMQVWh1SBiAV9jSrlCrUes1pY
   lg3FujVXH5gUkUnEXZ6NQ9sdPWJXlN+pHil8+v0xQbIYxKTBmfVjICXua
   4XyWFFMAqdlI/X+6hISNnmnw5K2RQ3k6dV08J5MAbGpDovb0RtlNWYWbu
   /skP0frtCnou5DgBwqWtE9TtniodAWat7pmC4BrHlRby6IB579h20bmpb
   xxJu/X8LlNH+NviqIEednTG7CAXX0BwhmUXdd71xzSwXSr4CB6Vdn3SZ9
   5gueYHrtgw5RwZaYqj8yDSksFbJ0FILil63HnD4AI1NIMD9mgEu9mfpah
   w==;
X-CSE-ConnectionGUID: LFpgde60Tu2cebYlAAIQDA==
X-CSE-MsgGUID: OXDBUgpQSY21Sxg2zEepSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="165642541"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; 
   d="scan'208";a="165642541"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:05:36 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DAE34C2260;
	Thu, 16 Jan 2025 13:05:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B30FBD8AF6;
	Thu, 16 Jan 2025 13:05:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EE0D6B64B;
	Thu, 16 Jan 2025 13:05:33 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 915171A0073;
	Thu, 16 Jan 2025 12:05:30 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests v2] tests: Remove unnecessary '&&' in requires() functions
Date: Thu, 16 Jan 2025 12:05:25 +0800
Message-Id: <20250116040525.173256-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.004
X-TMASE-Result: 10--12.800000-10.000000
X-TMASE-MatchedRID: yLHOPqhdQyVzKOD0ULzeCUocPLxXXRnc2FA7wK9mP9fVjNsehGf0vTos
	Lf1kH5Cf4QymIl443zKoQPOGYWh+VYV0mK0vUjwHAiwTe0IqjZfFmmMdIwjrDqr4vEVTsLe2i3G
	OCGgGiOaPHlfcV0jhQOaffHI8kAmiHY/bzRmIaZGqh5pv1eDPz0xUJyPnqTyGzAdJD7JeNMPIvl
	CZY6Ax8LX80TaNz00Y2kWu1n9CuOHyq/cli2hvDTllFsU0CXSPwJjn8yqLU6LIFck3f6fvyA57Z
	+qS9uMQTbaQJuvVgicxBm2TrrWsvOVHGbcDbAq6FEUknJ/kEl7dB/CxWTRRu25FeHtsUoHu64m6
	9tDAKAacGLKN1Nr+/fLxngnWo/hwDYPL3ugnpjY+kK598Yf3Mg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The '&&' operator should only be used when the second operand
is dependent on the first. In the context of requires() functions,
we prefer to evaluate all conditions independently to display
all SKIP_REASONS at once. This change separates the conditions
into individual lines to ensure each condition is evaluated
regardless of the others.

After this patch, there are a few '&&' remain
$ git grep -wl 'requires()' | xargs -I {} sed -n '/^requires() *{/,/}/p' {} | grep '&&'
        _have_null_blk && _have_module_param null_blk blocking
        _have_null_blk && _have_module_param null_blk shared_tags
        _have_null_blk && _have_module_param null_blk timeout
        _have_null_blk && _have_module_param null_blk requeue
        _have_null_blk && _have_module_param null_blk shared_tags
        _have_null_blk && _have_module_param null_blk init_hctx
        _have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload
        _have_program mkfs.btrfs && have_good_mkfs_btrfs

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
  rebase and
  Even though '_have_null_blk &&  _have_module_param null_blk' can be simplify to
  '_have_module_param null_blk', I keep it as it's so that we are safe to
  have updates in _have_null_blk() in the future.
---
 tests/block/006 | 3 ++-
 tests/block/008 | 3 ++-
 tests/block/010 | 3 ++-
 tests/block/011 | 3 ++-
 tests/block/019 | 3 ++-
 tests/block/020 | 3 ++-
 tests/block/029 | 3 ++-
 tests/loop/002  | 4 +++-
 tests/nbd/001   | 4 +++-
 tests/nbd/002   | 3 ++-
 tests/nbd/003   | 3 ++-
 tests/nvme/005  | 3 ++-
 tests/nvme/010  | 3 ++-
 tests/nvme/039  | 4 ++--
 tests/nvme/056  | 4 +++-
 tests/scsi/001  | 3 ++-
 tests/scsi/002  | 3 ++-
 17 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/tests/block/006 b/tests/block/006
index 7d05b1113fb9..8601397f4bf8 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -15,7 +15,8 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk blocking && _have_fio
+	_have_null_blk && _have_module_param null_blk blocking
+	_have_fio
 }
 
 test() {
diff --git a/tests/block/008 b/tests/block/008
index cd0935259157..859c0fe7d85e 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -12,7 +12,8 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_cpu_hotplug && _have_fio
+	_have_cpu_hotplug
+	_have_fio
 }
 
 test_device() {
diff --git a/tests/block/010 b/tests/block/010
index ed5613525255..5b52fdb948c7 100755
--- a/tests/block/010
+++ b/tests/block/010
@@ -15,7 +15,8 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk shared_tags && _have_fio
+	_have_null_blk && _have_module_param null_blk shared_tags
+	_have_fio
 }
 
 run_fio_job() {
diff --git a/tests/block/011 b/tests/block/011
index 63212122a736..662f41c301ce 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -24,7 +24,8 @@ pci_dev_mounted() {
 }
 
 requires() {
-	_have_fio && _have_program setpci
+	_have_fio
+	_have_program setpci
 }
 
 device_requires() {
diff --git a/tests/block/019 b/tests/block/019
index 58aca4cc1020..723eb61350f9 100755
--- a/tests/block/019
+++ b/tests/block/019
@@ -11,7 +11,8 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_fio && _have_program setpci
+	_have_fio
+	_have_program setpci
 }
 
 device_requires() {
diff --git a/tests/block/020 b/tests/block/020
index 5ffa23248804..66f380edfc61 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -14,7 +14,8 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_null_blk && _have_fio
+	_have_null_blk
+	_have_fio
 }
 
 test() {
diff --git a/tests/block/029 b/tests/block/029
index b9a897dbf830..c00bdeba28e1 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -11,7 +11,8 @@ DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
 QUICK=1
 
 requires() {
-	_have_fio && _have_null_blk
+	_have_fio
+	_have_null_blk
 }
 
 modify_nr_hw_queues() {
diff --git a/tests/loop/002 b/tests/loop/002
index d0ef964989e6..07b9c6c53c9c 100755
--- a/tests/loop/002
+++ b/tests/loop/002
@@ -15,7 +15,9 @@ DESCRIPTION="try various loop device block sizes"
 QUICK=1
 
 requires() {
-	_have_program xfs_io && _have_src_program loblksize && _have_loop_set_block_size
+	_have_program xfs_io
+	_have_src_program loblksize
+	_have_loop_set_block_size
 }
 
 test() {
diff --git a/tests/nbd/001 b/tests/nbd/001
index 0975af0543e2..cc083e3ce6ed 100755
--- a/tests/nbd/001
+++ b/tests/nbd/001
@@ -11,7 +11,9 @@ DESCRIPTION="resize a connected nbd device"
 QUICK=1
 
 requires() {
-	_have_nbd && _have_program parted && _have_src_program nbdsetsize
+	_have_nbd
+	_have_program parted
+	_have_src_program nbdsetsize
 }
 
 test() {
diff --git a/tests/nbd/002 b/tests/nbd/002
index 8e4e062eba66..00701b11236d 100755
--- a/tests/nbd/002
+++ b/tests/nbd/002
@@ -17,7 +17,8 @@ DESCRIPTION="tests on partition handling for an nbd device"
 QUICK=1
 
 requires() {
-	_have_nbd_netlink && _have_program parted
+	_have_nbd_netlink
+	_have_program parted
 }
 
 test() {
diff --git a/tests/nbd/003 b/tests/nbd/003
index 57fb63a9e70f..4fabdebc8f6a 100755
--- a/tests/nbd/003
+++ b/tests/nbd/003
@@ -11,7 +11,8 @@ DESCRIPTION="mount/unmount concurrently with NBD_CLEAR_SOCK"
 QUICK=1
 
 requires() {
-	_have_nbd && _have_src_program mount_clear_sock
+	_have_nbd
+	_have_src_program mount_clear_sock
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index 66c12fdb7d8d..8fc1f574ce3d 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -12,7 +12,8 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_loop && _have_module_param_value nvme_core multipath Y
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index a5ddf581ecc9..58c8693b1373 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -11,7 +11,8 @@ TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_fio && _have_loop
+	_have_fio
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/039 b/tests/nvme/039
index eca8ba35475e..ab58f3b91c7d 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -14,8 +14,8 @@ QUICK=1
 
 requires() {
 	_have_program nvme
-	_have_kernel_option FAULT_INJECTION && \
-	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_kernel_option FAULT_INJECTION
+	_have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
 
 device_requires() {
diff --git a/tests/nvme/056 b/tests/nvme/056
index d4dda2d98b91..958c2e31165c 100755
--- a/tests/nvme/056
+++ b/tests/nvme/056
@@ -30,7 +30,9 @@ requires() {
 	_have_fio
 	_have_program ip
 	_have_program ethtool
-	_have_kernel_source && _have_program python3 && have_netlink_cli
+	_have_kernel_source
+	_have_program python3
+	have_netlink_cli
 	have_iface
 }
 
diff --git a/tests/scsi/001 b/tests/scsi/001
index 54ca58227659..9e43c8dfbd11 100755
--- a/tests/scsi/001
+++ b/tests/scsi/001
@@ -11,7 +11,8 @@ DESCRIPTION="try triggering a kernel GPF with 0 byte SG reads"
 QUICK=1
 
 requires() {
-	_have_scsi_generic && _have_src_program sg/syzkaller1
+	_have_scsi_generic
+	_have_src_program sg/syzkaller1
 }
 
 test_device() {
diff --git a/tests/scsi/002 b/tests/scsi/002
index b38706447f83..82e9d8a554ca 100755
--- a/tests/scsi/002
+++ b/tests/scsi/002
@@ -11,7 +11,8 @@ DESCRIPTION="perform a SG_DXFER_FROM_DEV from the /dev/sg read-write interface"
 QUICK=1
 
 requires() {
-	_have_scsi_generic && _have_src_program sg/dxfer-from-dev
+	_have_scsi_generic
+	_have_src_program sg/dxfer-from-dev
 }
 
 test_device() {
-- 
2.47.0


