Return-Path: <linux-rdma+bounces-6869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E8A037D4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C98F1885889
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DBB1DED5F;
	Tue,  7 Jan 2025 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="l74CRL8z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6AA1DE4CC;
	Tue,  7 Jan 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230843; cv=none; b=W8HsQeReyHJl2+kj5DLPKEbs7RfzqqMscZxB2OyghrN3CfjMZgzsADEhWDp5chbt7LaeLzh+mrHl2+at6UghU1zIMpIc6RxzJfvxNOwGq+8rg0Nd49okCn6xVxuMCth2HQQfiSXeAq3nukXjm+g2qvtwqkl+KFVeuWGn7uHzQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230843; c=relaxed/simple;
	bh=ZgUPLUm6NtAJ7G1MkU1q5K8vw4t1y80egxcgYXDWINc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnshkTyZHefZ8IVN+Z5P3T7phzzPRYAIrZUpnk3g9oFssEbJuJokAbYNiTyVxYmu78TW6D6mLLMKcRpT+H5OdRCfZZuwRi3R0h2ogy/s6Y/JrQm2mJxfMjlKqadtkdkuLN7gYIacosqOlTsJl6+sKkNYxSM9NtSWZcqXpbTSJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=l74CRL8z; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230840; x=1767766840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZgUPLUm6NtAJ7G1MkU1q5K8vw4t1y80egxcgYXDWINc=;
  b=l74CRL8zsP45gbNamjJSmBVR0diqocBHfPj+jykPt0cspK3oAdf5mRkK
   2atfwoirklzY389g5AfJFMw2kemKR/vkUPN7cwnynIQ+f5Hat5pS/8NKD
   N4Ny9bIQCrxqCHif5jAAWgIgVCqaMUfkt2AVUK88qLUAiNU6unVQFX7/A
   EEN9P3ES6XSPr0494E/G2hQ1WcpTF8PJWXVMDyMQfYFKlXhgzSx+923kI
   PBzjPkyV5XEExN7VRTOH+srSLlQ0xZd8sVF0vOnLEL9Xb/rOZ0PnKhqge
   GFqOprWPj6USjNGM41CiKZQOsozPbgVclywZsb+La1kCJpUvH9GVQbOLi
   Q==;
X-CSE-ConnectionGUID: hIj0CKxETrmNgqDW/Gsd3g==
X-CSE-MsgGUID: +CMN7YNJQHmlBeXMyDaz9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="173126637"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="173126637"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:19:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 67602D4C39;
	Tue,  7 Jan 2025 15:19:22 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 40C09BF4AB;
	Tue,  7 Jan 2025 15:19:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D24F1200930D0;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6427B1A0071;
	Tue,  7 Jan 2025 14:19:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests 3/4] common, new, tests: Get rid of _have_scsi_debug
Date: Tue,  7 Jan 2025 14:19:04 +0800
Message-Id: <20250107061905.91316-4-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--10.855800-10.000000
X-TMASE-MatchedRID: i9okT3N59sRyeiFPOFIChAKDWtq/hHcNZR+OFNkbtdotferJ/d7Ab4dY
	wzPgNbi6WRXM1BNPHVMl9+c89RK6DT4xnGicftABPKN38CLPK0EJlr1xKkE5ucC5DTEMxpeQfiq
	1gj2xET9lzP9S78W1g/LrCuvw7b1ajFPmi+lHwssM6z3iDvziB1G+BHSGRsbgrSvLRRRfRG3ynQ
	xWKo+F0WLmeWLY1Nl9VIzQ5SmwuhfNR0Df05Sd2azGfgakLdjaWfgivgcUPZO4GyTmeN+AbBy7M
	kaYvOFgIqkJ48VX5FCnyJ66hArF5gzyMxeMEX6wFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHukA8s
	tzMxEw20lv6gyFgQgophNKO2oMBJCLN8McZaXwJLDBwYotNgRw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

- _have_scsi_debug is same with _have_driver scsi_debug, it seems there
is no a strong opinion to keep it.
- In addition, '_have_module_param scsi_debug' will test _have_driver first,
that means it's safe to remove its former _have_driver in requires()

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 common/scsi_debug | 4 ----
 new               | 2 +-
 tests/block/001   | 2 +-
 tests/block/002   | 2 +-
 tests/block/027   | 2 +-
 tests/block/037   | 2 +-
 tests/scsi/004    | 2 +-
 tests/scsi/005    | 1 -
 8 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index 594883c95713..9997afa0154c 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,10 +4,6 @@
 #
 # scsi_debug helper functions.
 
-_have_scsi_debug() {
-	_have_driver scsi_debug
-}
-
 SD_PARAM_PATH=/sys/module/scsi_debug/parameters
 SD_PSEUDO_PATH=/sys/bus/pseudo/drivers/scsi_debug
 
diff --git a/new b/new
index d84f01d62e30..fe2cb6a12242 100755
--- a/new
+++ b/new
@@ -261,7 +261,7 @@ test() {
 #   E.g., TEST_NAME and GROUPS. Variables local to the test are lowercase
 #   with underscores.
 # - Functions defined by the testing framework or group scripts, including
-#   helpers, have a leading underscore. E.g., _have_scsi_debug. Functions local
+#   helpers, have a leading underscore. E.g., _have_driver. Functions local
 #   to the test should not have a leading underscore.
 # - Both [[ ]] form and [ ] form are fine for tests. [[ ]] is preferred.
 # - Always quote variable expansions unless the variable is a number or inside of
diff --git a/tests/block/001 b/tests/block/001
index 32dd22f8481a..3f576fa0e1b5 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -13,7 +13,7 @@ DESCRIPTION="stress device hotplugging"
 TIMED=1
 
 requires() {
-	_have_scsi_debug
+	_have_driver scsi_debug
 	_have_kernel_option BLK_DEV_SD
 	_have_driver sr_mod
 }
diff --git a/tests/block/002 b/tests/block/002
index 65b0fbdd9800..c57e27dee30d 100755
--- a/tests/block/002
+++ b/tests/block/002
@@ -13,7 +13,7 @@ QUICK=1
 
 requires() {
 	_have_blktrace
-	_have_scsi_debug
+	_have_driver scsi_debug
 }
 
 test() {
diff --git a/tests/block/027 b/tests/block/027
index f59dad2f231c..317c06db0fa9 100755
--- a/tests/block/027
+++ b/tests/block/027
@@ -20,7 +20,7 @@ CAN_BE_ZONED=1
 
 requires() {
 	_have_cgroup2_controller io
-	_have_scsi_debug
+	_have_driver scsi_debug
 	_have_fio
 }
 
diff --git a/tests/block/037 b/tests/block/037
index 6ecbe3731194..bdffcae13a9a 100755
--- a/tests/block/037
+++ b/tests/block/037
@@ -19,7 +19,7 @@ QUICK=1
 
 requires() {
 	_have_cgroup2_controller io
-	_have_scsi_debug
+	_have_driver scsi_debug
 }
 
 scsi_debug_rebind() {
diff --git a/tests/scsi/004 b/tests/scsi/004
index 7d0af54415de..4fe48182425a 100755
--- a/tests/scsi/004
+++ b/tests/scsi/004
@@ -18,7 +18,7 @@ DESCRIPTION="ensure repeated TASK SET FULL results in EIO on timing out command"
 CAN_BE_ZONED=1
 
 requires() {
-	_have_scsi_debug
+	_have_driver scsi_debug
 }
 
 test() {
diff --git a/tests/scsi/005 b/tests/scsi/005
index bfa1014d4ea3..f8d9b30c6894 100755
--- a/tests/scsi/005
+++ b/tests/scsi/005
@@ -11,7 +11,6 @@ DESCRIPTION="test SCSI device blacklisting"
 QUICK=1
 
 requires() {
-	_have_scsi_debug
 	_have_module_param scsi_debug inq_vendor
 }
 
-- 
2.47.0


