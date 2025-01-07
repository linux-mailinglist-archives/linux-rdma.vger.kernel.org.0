Return-Path: <linux-rdma+bounces-6865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E381A037CC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92611885A33
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73113B58C;
	Tue,  7 Jan 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="boOwIFwv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D815ECC;
	Tue,  7 Jan 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230771; cv=none; b=sI5oazhqZhy5TNPTnozIEcQHpPKkE57nFbpFDXKn1oRHCps2kZmG/iSbdgMQ0BfPCA1TTjRe4acoXkyDtVHdCcbBryEgVyvpaHQLOh+YgcaQXoEalL3XYJrqsPI9ovfaofimXjXWwuBG00HVAjGfIjXbSbh3e/v5DfL3AXLjrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230771; c=relaxed/simple;
	bh=NI6JH9iT5qHVXHDP/LOTawpHG9ll45C7goXtbBd1IFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzSr5UIyyyLgU1hjYmWT0m0EI8TWUABeYUIsEAoGG03C4zTM1ngnGZb1zQqLtEQxhIpaER/DMqQa19zH5oCh3bibxS/nfrgV2be90GGPYwTSH6626jCe9UAWrzBCXZ+Ss0ihUR5+wjcRuc64EfxIqix+Am8dVs4PY7YBvq4Fgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=boOwIFwv; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230769; x=1767766769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NI6JH9iT5qHVXHDP/LOTawpHG9ll45C7goXtbBd1IFY=;
  b=boOwIFwvKyH/BLAsQ/8/3ltZzTziZ//38a0vthMFrMQNvjndDKjoPipp
   LTSEYQzeOuLxL2GNIB1IC9f3ffiGLsRBLTfkdRG0xOHHr8QpQOxmLiS2M
   Zl4Lvfn62rFXQqkzPq+wRuluAVlI1bqrTyRNtb9uAD5B6B6b/rkrEDOJR
   0Rs5A7KTIDZqHZACc03PsQcC7WjMMAoQFJ78WnSs0pXdHd/EGjuYm/dpa
   HeAb+BA+Z0F7IVoE9ATfjbhRp03pduPjQiBHOddjhyGqC78D3FHR+7Chl
   BhhQjTRO93hec4jz+qBMqxZMZWYFdr87raop/AXDcBUXXBaHU2i3HnH5e
   Q==;
X-CSE-ConnectionGUID: 4TQ4CIkeQFOawhOeaczQqA==
X-CSE-MsgGUID: q8zN211AR8WBQ2M4jwsxlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="165252572"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="165252572"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:19:25 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id CAA2EC2264;
	Tue,  7 Jan 2025 15:19:22 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F133D4BC0;
	Tue,  7 Jan 2025 15:19:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 30745216F79;
	Tue,  7 Jan 2025 15:19:22 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B7C451A006C;
	Tue,  7 Jan 2025 14:19:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests 4/4] tests: Remove unnecessary '&&' in requires() functions
Date: Tue,  7 Jan 2025 14:19:05 +0800
Message-Id: <20250107061905.91316-5-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--11.205000-10.000000
X-TMASE-MatchedRID: RKkR8WK0E1pzKOD0ULzeCUocPLxXXRnc2FA7wK9mP9fVjNsehGf0vYCM
	NBUmTo/EbHP8nE7bb5lqbopjo8dma4grKnsJ1GRgTuctSpiuWyUUi4Ehat05499RlPzeVuQQhFA
	nTzcsrmXg8q4Y37zKTYU/92886D4nfDPEC/yQgPTX3j/lf1V8LI5UafLmrvaGWH7Bxw4ADCMteS
	BVDS/hE/4d9MHlVjaYI+TRxIThX/6TPnkx1lLj8iZm6wdY+F8KWQ3R4k5PTnDkHRyu9DvWvaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrRnOS8UsoNM+oThT7rELRkxVf8g5JXXW7OPezYdPWyvXtNUO
	mYw1+Do=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The '&&' operator should only be used when the second operand
is dependent on the first. In the context of requires() functions,
we prefer to evaluate all conditions independently to display
all SKIP_REASONS at once. This change separates the conditions
into individual lines to ensure each condition is evaluated
regardless of the others.

After this patch, only 2 '&&' remain
$ git grep -wl 'requires()' | xargs -I {} sed -n '/^requires() *{/,/}/p' {} | grep '&&'
        _have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload
        _have_program mkfs.btrfs && have_good_mkfs_btrfs

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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
index da909c2a0dca..d7b295938301 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -15,7 +15,8 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_module_param null_blk blocking && _have_fio
+	_have_module_param null_blk blocking
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
index 4214c17e83a5..a85b138d6912 100755
--- a/tests/block/010
+++ b/tests/block/010
@@ -15,7 +15,8 @@ TIMED=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_module_param null_blk shared_tags && _have_fio
+	_have_module_param null_blk shared_tags
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
index a59e73bdffb8..a8bbb3585d0f 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -14,7 +14,8 @@ QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
-	_have_driver null_blk && _have_fio
+	_have_driver null_blk
+	_have_fio
 }
 
 test() {
diff --git a/tests/block/029 b/tests/block/029
index 487ebc9ec326..d9a9003a503e 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -11,7 +11,8 @@ DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
 QUICK=1
 
 requires() {
-	_have_fio && _have_driver null_blk
+	_have_fio
+	_have_driver null_blk
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


