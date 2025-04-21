Return-Path: <linux-rdma+bounces-9640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07678A951A1
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074CB3A688C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7982265CCC;
	Mon, 21 Apr 2025 13:27:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3963FB640
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242077; cv=none; b=CnxtLcDdCQLzkZUQk7OSc1CNfPZG7AqklqYXCqjVr5ZvfIAKYnV31CRL9QDvD58I4mNKo/7j+KGrGIfBtogEwLrBBf+dFj3oxpv6DbXvH3WksBqh7Padt8W5ZZH1+SxW/tEtisEeZt9XH1qkCozJJBPa7Bs4BIIdVveBir7ccF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242077; c=relaxed/simple;
	bh=oNW7zfV3ebTCaHniD32GGJeHOut7azIDhz9gfc0LL/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RvPsTwc/ltml4EZNJfJLBch2FZgzNRSccpJtedlnyQL5jMmmdOFffqSbCKDLWUZobCkGZ86NujlwYP2Pun0Ch/O3tVC0757/bXIDdbZKvLzsA+IFKcOeVZTUDfZaCgAZBBu9bYQKjo5QDDRZxy6D6Nf7u0hi/BDMQ1w+uPSxzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zh5kR27Xvz1d0rp;
	Mon, 21 Apr 2025 21:26:55 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id BA77B180080;
	Mon, 21 Apr 2025 21:27:51 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:27:51 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 0/6] RDMA/hns: Add trace support
Date: Mon, 21 Apr 2025 21:27:44 +0800
Message-ID: <20250421132750.1363348-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add trace support for hns. Set tracepoints for flushe CQE, WQE,
AEQE, MT/MTR and CMDQ.

Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
otherwise there will be a compilation error when hns_roce_hw_v2.h
is included in hns_roce_trace.h in patch #6.

v1 -> v2:
* Add 'hns' prefix to the name of trace events

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


