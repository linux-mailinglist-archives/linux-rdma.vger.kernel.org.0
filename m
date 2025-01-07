Return-Path: <linux-rdma+bounces-6867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A6A037D0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB069164311
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918717E00E;
	Tue,  7 Jan 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IrybJdSv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397D6A009;
	Tue,  7 Jan 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230837; cv=none; b=pZyKzC/lWseWEEdfUlGIBnlhGbFfzKjY/9B2rKfCOFz5R0DaeK3JTTgUf8X96+8jUdJNp3mjVRH93Fycu0Wg3nyehHxXT3KrVepj7RowzCIO+LSmr2BPHEYWSAmqRiRm7vyQA9S9qN8FydcjP5/KAVUMqgTPynX19wfM9DVR388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230837; c=relaxed/simple;
	bh=yFynUNkpKAf6YUgfxcI3keF2XwhxVGotQTLRvdG6SjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwgajw+piXbwzAD/9QLXiwNubZ/R71U/CU8fUa58a/xVxFVgvxhuG3TK46PnRDeGLp4lSVQGKSwC6Khi/WdIhDnRIhy/PajgxgkhDHhbclfSjZFHWf5gm1sGBhELijcfNF4tCNHN9fMUiK1AYQnegHwFvlu0V/525BX0j5gFAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IrybJdSv; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230835; x=1767766835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yFynUNkpKAf6YUgfxcI3keF2XwhxVGotQTLRvdG6SjQ=;
  b=IrybJdSv6bq0ZlLM4ohq9bSEJ3ZmHGk4PSLyey0Qv0FHzFwZHSSdu1bT
   qWn9mqXgEyV6+0kmu8lOnCA/cbOBYnwaLdCKGA0EWQsju5LA/EQCcilbf
   A2RZpF3ln4S9U4fZxXWf5skyhd80wfOj2KTnD8vlwyfmAlCik3ypqZoBS
   hdHifnDCJu05tkcVDT8SEKBgi7CYx4d+AI18LLxaVc+IOYXHuKLBPDmzo
   afrIOmwT4nTqZZUJDdJKyU5qvIeYRj3z5id99J1Msf7GR8fHwkhgwMakb
   PGXcjUOCJZn+Zl5Z9NZ9ROqyPOq2o7+8zSvoaR8J3/6zedP0ZCFvNJNRB
   A==;
X-CSE-ConnectionGUID: 90zJUEvWTwysBG8f9FqA2g==
X-CSE-MsgGUID: vk+ZNfzoSRS6oRy6cAYfQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="184978465"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="184978465"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:19:23 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 812D2D4C42;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AE94BF4AB;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D508AE293A;
	Tue,  7 Jan 2025 15:19:20 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5487D1A006C;
	Tue,  7 Jan 2025 14:19:20 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests 0/4] Cleanup and Optimization in requires()
Date: Tue,  7 Jan 2025 14:19:01 +0800
Message-Id: <20250107061905.91316-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--5.004900-10.000000
X-TMASE-MatchedRID: pP0QRqyMqWmjKsNTK0N17IqCtN91iZApGEfoClqBl85XPwnnY5XL5HNf
	Eo8eh30ht51G676eQJPJzjbZ5a3RIDK6IRa3S8GfOIQ9GP2P2u8nhzAhgvoq50Yx760ONDcWTbI
	v25NGrv1omvfIlwYKJxWl0kOLdJUyKbJ/ZHUTjGkCg1rav4R3DdU4lPn+3Ym4e9u3LPgWWUZpik
	/9hPBw3Te0EXf1LMyuHwKv2UdT81cTCsslFbOpzO0/o+/4D7DzpR+m8tBi6ZK7/wrt2eyflRFUq
	B8ulcbQbn+bq+W8j6VvcmY92rn2+R8TzIzimOwPC24oEZ6SpSkgbhiVsIMQK9LdHHLXgng30f64
	jMJmKFi67ZvNjEZWMAP3e+tJ/cp8QjUf0Hmc/xVgO21BQaodlQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

(Most of the this cover letter was generated by the chatgpt)
Hello,

This patch series aims to enhance the efficiency and clarity of the
requires() by optimizing the way module driver and remove unnecessary '&&'

Here's a brief summary of each patch included in this series:

1. **Patch 1/4: common/rc: Test `have_driver` before checking its driver parameter**
   - This patch optimizes the `_have_module_param()` function by first
verifying the presence of a driver with `_have_driver()`. This change reduces
unnecessary checks and error logs when a driver is not available, improving
test efficiency.

2. **Patch 2/4: tests, common: Get rid of `_have_null_blk`**
   - The `_have_null_blk` function has been removed since it duplicates the
functionality of `_have_driver null_blk`. This helps streamline the
codebase by eliminating redundancy.

3. **Patch 3/4: common, new, tests: Get rid of `_have_scsi_debug`**
   - Similar to the previous patch, `_have_scsi_debug` was also redundant.
This patch removes it to ensure consistency and reduce code complexity.

4. **Patch 4/4: tests: Remove unnecessary '&&' in `requires()` functions**
   - This patch refactors `requires()` functions to evaluate conditions
independently. The change aims to improve diagnostic clarity by displaying
all unmet conditions and their respective skip reasons.

These changes should collectively improve the test scripts' readability
and efficiency, making module checks faster and less error-prone.
Please review the patches and provide feedback.

Thank you for your time and consideration.

Best regards,
Li Zhijian


Li Zhijian (4):
  common/rc: test have_driver before check its driver parameter
  tests, common: Get rid of _have_null_blk
  common, new, tests: Get rid of _have_scsi_debug
  tests: Remove unnecessary '&&' in requires() functions

 common/null_blk   | 4 ----
 common/rc         | 6 ++----
 common/scsi_debug | 4 ----
 new               | 2 +-
 tests/block/001   | 2 +-
 tests/block/002   | 2 +-
 tests/block/006   | 3 ++-
 tests/block/008   | 3 ++-
 tests/block/010   | 3 ++-
 tests/block/011   | 3 ++-
 tests/block/014   | 2 +-
 tests/block/015   | 2 +-
 tests/block/016   | 2 +-
 tests/block/017   | 2 +-
 tests/block/018   | 2 +-
 tests/block/019   | 3 ++-
 tests/block/020   | 3 ++-
 tests/block/021   | 2 +-
 tests/block/022   | 2 +-
 tests/block/023   | 2 +-
 tests/block/024   | 2 +-
 tests/block/027   | 2 +-
 tests/block/029   | 3 ++-
 tests/block/030   | 2 +-
 tests/block/031   | 2 +-
 tests/block/037   | 2 +-
 tests/block/038   | 2 +-
 tests/loop/002    | 4 +++-
 tests/nbd/001     | 4 +++-
 tests/nbd/002     | 3 ++-
 tests/nbd/003     | 3 ++-
 tests/nvme/005    | 3 ++-
 tests/nvme/010    | 3 ++-
 tests/nvme/039    | 4 ++--
 tests/nvme/056    | 4 +++-
 tests/scsi/001    | 3 ++-
 tests/scsi/002    | 3 ++-
 tests/scsi/004    | 2 +-
 tests/scsi/005    | 1 -
 tests/throtl/rc   | 2 +-
 tests/zbd/rc      | 2 +-
 41 files changed, 59 insertions(+), 51 deletions(-)

-- 
2.47.0


