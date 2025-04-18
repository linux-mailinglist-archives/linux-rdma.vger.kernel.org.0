Return-Path: <linux-rdma+bounces-9576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B57A934F4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D927B1C8F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C501F26FA6C;
	Fri, 18 Apr 2025 08:56:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3426F451
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966614; cv=none; b=VBsUhMMajBsrbCHRuSKo3x/krLN5FOl/b8gNLEJEu52H6x9SOX9+dF0HTosIua5LkNgiDsLV3aBteH/TvN/P3068nN9bMAOFOfWLpQxZKhGkkRCLWR47tsUt8sJsBzwZQiyle2IBm1Oxt0ezVmD7BQ06tt0+YQJOivtx6G40n8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966614; c=relaxed/simple;
	bh=OIuTwftyzYlbaYow7beiV0+pWIv45XFk6fvDiHt5Ck4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tizsETAUCEnf3hB1zso49sBnigdr21ZmHrvTTKD4oasHUXbzNCmB+c901na4Mp+ZDKG1hxe7NFd6NT7fRb0zlGoVayIeCYkegGL9dgsNbzj2FC5CRToyeTKMeAECZ1aHDfo/WQP7pIJEJWT5grDVOqtA5gio2G4rMawyjoQAsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zf7p93pZszHrDN;
	Fri, 18 Apr 2025 16:53:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DC3141402E9;
	Fri, 18 Apr 2025 16:56:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:48 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Add trace support
Date: Fri, 18 Apr 2025 16:56:41 +0800
Message-ID: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
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

Add trace support for hns. Set tracepoints for flushe CQE, WQE,
AEQE, MT/MTR and CMDQ.

Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
otherwise there will be a compilation error when hns_roce_hw_v2.h
is included in hns_roce_trace.h in patch #6.

Junxian Huang (6):
  RDMA/hns: Add trace for flush CQE
  RDMA/hns: Add trace for WQE dumping
  RDMA/hns: Add trace for AEQE dumping
  RDMA/hns: Add trace for MR/MTR attribute dumping
  RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
  RDMA/hns: Add trace for CMDQ dumping

 drivers/infiniband/hw/hns/hns_roce_ah.c       |   1 -
 drivers/infiniband/hw/hns/hns_roce_device.h   |  20 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  19 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_mr.c       |   3 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c |   1 -
 drivers/infiniband/hw/hns/hns_roce_trace.h    | 213 ++++++++++++++++++
 8 files changed, 255 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_trace.h

--
2.33.0


