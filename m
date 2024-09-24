Return-Path: <linux-rdma+bounces-5061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730099845CA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 14:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE23280C42
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E71A7269;
	Tue, 24 Sep 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GwUL/IRP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F6126C04
	for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180174; cv=none; b=mH1nN5ehfSn06zIGUxoR2cEFOHQSgOFkc9S/sLYL6yApaF09LTUaPHW0soCCbR1dmgunQxE8Murm0HGYgwOiDenY40Mif+56/hcYhuH/SdPS55dbdha0xymu+RURHYQ2+wS6el9APO8DTblLrM2y3vFDIkemSI1hRoavUmNfJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180174; c=relaxed/simple;
	bh=A7Ntf2gE2KHp91cmnQcm+VToe48T8LFpVZmCwU9VpDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p5anGepVyXzaOoHriaHq5x32xfN6EyHvb4n36cNJCgNOfKEL+Rd7Pdoh+JP8jEQPatNcjEm+zgJlXyj/RxlJfWDMYHskPFhBpRqxfVuAF75vxbF3UTdX8uGrP+vf/Pa9ZLxkS0IE0CrcObJFR3gDr6+2AOLn/q5Xc8NuiLbfIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GwUL/IRP; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727180172; x=1758716172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wvCeiNF21ha29S6aWIo1cJIfMlAZlRhZPZ3su/1pR1s=;
  b=GwUL/IRPmvZYrWOthcifgIAoedl75T+i3HcMpRprqmBFS4kAWmNx9+M5
   fq+IxaKKtGylA3q1qxt63mI7yfcCIEPyKL5zWQwtD5Qt7Tzo3oazddopG
   epHTqK+abIb6x3SzDaoW9FoorMY58C1mD/gia6zPVYQ2Q8NGXtEM6YQGT
   E=;
X-IronPort-AV: E=Sophos;i="6.10,254,1719878400"; 
   d="scan'208";a="234148128"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 12:16:09 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:8916]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.173:2525] with esmtp (Farcaster)
 id d8e90b54-e8d0-439d-8263-d1a4cdc93e36; Tue, 24 Sep 2024 12:16:07 +0000 (UTC)
X-Farcaster-Flow-ID: d8e90b54-e8d0-439d-8263-d1a4cdc93e36
Received: from EX19D011EUB003.ant.amazon.com (10.252.51.108) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 24 Sep 2024 12:16:07 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D011EUB003.ant.amazon.com (10.252.51.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 24 Sep 2024 12:16:06 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 24 Sep 2024 12:16:06 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com (dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com [10.253.103.172])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id 857F6C04E3;
	Tue, 24 Sep 2024 12:16:04 +0000 (UTC)
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "kernel
 test robot" <lkp@intel.com>, Yehuda Yitschak <yehuday@amazon.com>, "Yonatan
 Nachum" <ynachum@amazon.com>
Subject: [PATCH] RDMA/efa: Fix node guid compiler warning
Date: Tue, 24 Sep 2024 12:16:03 +0000
Message-ID: <20240924121603.16006-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The GUID is received in big-endian so align types accordingly to avoid
compiler warnings.

Closes: https://lore.kernel.org/oe-kbuild-all/202409032113.bvyVfsNp-lkp@intel.com/

Fixes: 04e36fd27a2a ("RDMA/efa: Add support for node guid")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 5a774925cdea..5754da4e6ff8 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -465,7 +465,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->db_bar = resp.u.device_attr.db_bar;
 	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
 	result->device_caps = resp.u.device_attr.device_caps;
-	result->guid = resp.u.device_attr.guid;
+	result->guid = (__force __be64)resp.u.device_attr.guid;
 
 	if (result->admin_api_version < 1) {
 		ibdev_err_ratelimited(
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 668d033f7477..56382cd1b7c4 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -112,7 +112,7 @@ struct efa_com_get_device_attr_result {
 	u8 addr[EFA_GID_SIZE];
 	u64 page_size_cap;
 	u64 max_mr_pages;
-	u64 guid;
+	__be64 guid;
 	u32 mtu;
 	u32 fw_version;
 	u32 admin_api_version;
-- 
2.40.1


