Return-Path: <linux-rdma+bounces-13331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ADEB55FB3
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD401B2665A
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA392EA49C;
	Sat, 13 Sep 2025 09:06:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9F2E9731
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754388; cv=none; b=n0OGCgWE1GLQJ78DdM/yl49LKSo6VElGQp7D0bLkk0zRTlg8eQ7pkpuxnl2ur3gj8G6XrIJDyGYbw1qSYH0M1rc+LeHi8X12FxeOWDiRaGCY5nEF+ae7g9jc3lAKhTwx9RpG7T7374A8ylz1Lw/kMQmZGrRAuTNn/29mBQS59yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754388; c=relaxed/simple;
	bh=WHlkCmLxcq/7UITc1pa7RCSfOx0c+fcSRcaCeWvaFcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jCrPmLQldfF01QUc0Q60bBlZ/DA6QB+yhKDBfPixVDPRAUFSiOun3gd5e/F7+qB1hKkhPd8Wu0qV1nGCF3PXmDYi1waJk5Nmhnp2vGGQGD7fia5uXxCmYKPAszDzIAZZ6Se/Wlbs92cTWVsrMB/nIGDoHBR9VTjFZFIJZHzmXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cP53j3lwmztTXF;
	Sat, 13 Sep 2025 17:05:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 287B918006C;
	Sat, 13 Sep 2025 17:06:16 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:15 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 0/8] RDMA/hns: Support RoCE bonding
Date: Sat, 13 Sep 2025 17:06:07 +0800
Message-ID: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)

This series adds support for RoCE bonding. The bond mode is active
when multiple PF netdevs are enslaved to a bond master while all
following rules are met:
  * All the slaves are on the same card, i.e., they share the same
    bus number.
  * The bond mode are set to mode 1 (active-backup), 2 (XOR) or
    4 (802.3ad).
  * None of the slaves have generated a VF.

In bond mode, a bond ibdev "hns_bond_*" is registered instead of the
regular PF ibdev "hns_*". For RoCE traffic, HW chooses the same active
port as netdev bonding in mode 1, while in mode 2/4, the port selection
is determined by the hash algorithm.

Junxian Huang (8):
  RDMA/hns: Add helpers to obtain netdev and bus_num from hr_dev
  RDMA/hns: Initialize bonding resources
  RDMA/hns: Add bonding event handler
  RDMA/hns: Add bonding cmds
  RDMA/hns: Implement bonding init/uninit process
  RDMA/hns: Add delayed work for bonding
  RDMA/hns: Support link state reporting for bond
  RDMA/hns: Support reset recovery for bond

 drivers/infiniband/hw/hns/Makefile          |   4 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_bond.c   | 996 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_bond.h   |  95 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |  16 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 175 +++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 +
 drivers/infiniband/hw/hns/hns_roce_main.c   | 176 +++-
 drivers/infiniband/hw/hns/hns_roce_pd.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   5 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   1 -
 11 files changed, 1438 insertions(+), 52 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.h

--
2.33.0


