Return-Path: <linux-rdma+bounces-6835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C24A0241F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 12:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB723A4DC2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308521DAC97;
	Mon,  6 Jan 2025 11:19:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F21D9A62;
	Mon,  6 Jan 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162359; cv=none; b=KLXgRxhASwI8nmsh7L+bjub1GDh3rBJS00fqPvmv48QiPT212+IF9nJh6Zqv5c/0b+dKiBKhiBX3VHPS0hN49zi99Eq2zZlBtssxyj2g5ATPwqB8Eu+dgDAfcTzf6WyPm/RkjSukPTA4PR1xYRbeMTBHayvlM7b9WTTTwUVn/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162359; c=relaxed/simple;
	bh=ToiI0AflnTS5sP1lUq08LYyT5D8YwuNYaXUyj8P6Zak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebGgi2tIt55nlLC8b/gPzjVUo8jfu54aKuN3z+87BlvTW6pYzYvEwmJH37gcDfFXwYRkthxUO4hALV0CzRp93kZTjnXN7+6pq4iGfEgigtXc3edqPnTW8PRQG+lJ6+oyPRQHc4sF9TfT2/18oOl8+SmDiqPQrE7LskTnyhzWkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YRWpw3QvHzRkwm;
	Mon,  6 Jan 2025 19:16:56 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A1A01800D9;
	Mon,  6 Jan 2025 19:19:09 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 19:19:09 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: RDMA/hns: Clean up the legacy CONFIG_INFINIBAND_HNS
Date: Mon, 6 Jan 2025 19:12:11 +0800
Message-ID: <20250106111211.3945051-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

hns driver used to support hip06 and hip08 devices with
CONFIG_INFINIBAND_HNS_HIP06 and CONFIG_INFINIBAND_HNS_HIP08
respectively, which both depended on CONFIG_INFINIBAND_HNS.

But we no longer provide support for hip06 and only support
hip08 and higher since the commit in fixes line, so there is
no need to have CONFIG_INFINIBAND_HNS any more. Remove it and
only keep CONFIG_INFINIBAND_HNS_HIP08.

Fixes: 38d220882426 ("RDMA/hns: Remove support for HIP06")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/Makefile     |  2 +-
 drivers/infiniband/hw/hns/Kconfig  | 20 +++++---------------
 drivers/infiniband/hw/hns/Makefile |  9 +++------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index 1211f4317a9f..aba96ca9bce5 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_INFINIBAND_OCRDMA)		+= ocrdma/
 obj-$(CONFIG_INFINIBAND_VMWARE_PVRDMA)	+= vmw_pvrdma/
 obj-$(CONFIG_INFINIBAND_USNIC)		+= usnic/
 obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
-obj-$(CONFIG_INFINIBAND_HNS)		+= hns/
+obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index ab3fbba70789..44cdb706fe27 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -1,21 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config INFINIBAND_HNS
-	tristate "HNS RoCE Driver"
-	depends on NET_VENDOR_HISILICON
-	depends on ARM64 || (COMPILE_TEST && 64BIT)
-	depends on (HNS_DSAF && HNS_ENET) || HNS3
-	help
-	  This is a RoCE/RDMA driver for the Hisilicon RoCE engine.
-
-	  To compile HIP08 driver as module, choose M here.
-
 config INFINIBAND_HNS_HIP08
-	bool "Hisilicon Hip08 Family RoCE support"
-	depends on INFINIBAND_HNS && PCI && HNS3
-	depends on INFINIBAND_HNS=m || HNS3=y
+	tristate "Hisilicon Hip08 Family RoCE support"
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on PCI && HNS3
 	help
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
 	  The RoCE engine is a PCI device.
 
-	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
-	  module will be called hns-roce-hw-v2.
+	  To compile this driver, choose M here. This module will be called
+	  hns-roce-hw-v2.
diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index be1e1cdbcfa8..7917af8e6380 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -5,12 +5,9 @@
 
 ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
-hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
+hns-roce-hw-v2-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o \
-	hns_roce_debugfs.o
+	hns_roce_debugfs.o hns_roce_hw_v2.o
 
-ifdef CONFIG_INFINIBAND_HNS_HIP08
-hns-roce-hw-v2-objs := hns_roce_hw_v2.o $(hns-roce-objs)
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v2.o
-endif
+obj-$(CONFIG_INFINIBAND_HNS_HIP08) += hns-roce-hw-v2.o
-- 
2.33.0


