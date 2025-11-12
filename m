Return-Path: <linux-rdma+bounces-14424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC0C516B9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 10:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6C4F4FF7F4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0852FFF98;
	Wed, 12 Nov 2025 09:35:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884A274B55
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940117; cv=none; b=X0ehwSf6/m5PLAewqaZFJR0q3JDQU93azrp/AVwLGs7LBBONh9OOq39djsLflo7WQ55R5JpSGxfi+CX3EWBhOY2k5Tng6QzyDvd8+cREYmuy3RcEjZXr03GG+SXY1XrttLyVkMxu713bTcci8fDgC97erpwfOTIZZIP8+v2SJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940117; c=relaxed/simple;
	bh=8+qux21HJ4Ug1WDOlFhNjo7ekSlmVYXF51g7CiTwjI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SUtdPQbGUE0wQUmv+Eb50fPIsDf9B+WQwoh+dr1A7c36PC/3i2v5xoOaehdTKTISXaUFmf9YwbeaCM7zWi3k4/ytPGSP15Mn0mdJrobZVizTHD0lOVsHd9uPQHvGBj9qRD5z1izVCgpbZoTlFc5eJrG3jAi+B6aqITUZaTkGoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d5yrg4sMjz12LGF;
	Wed, 12 Nov 2025 17:33:39 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 31AE31402EB;
	Wed, 12 Nov 2025 17:35:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 17:35:10 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v3 for-next 0/8] RDMA/hns: Support RoCE bonding
Date: Wed, 12 Nov 2025 17:35:02 +0800
Message-ID: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Changelog:
v3:
* Fix unused variables in patch 5 hns_roce_unregister_device() and
  patch 7 hns_roce_hw_v2_link_status_change().
* Fix wrong link state in patch 7 hns_roce_query_port() when the device
  doesn't hold the cap flag of bonding.

v2: https://lore.kernel.org/linux-rdma/20251016132023.3043538-1-huangjunxian6@hisilicon.com/
* Hold the refcount when returning from hns_roce_get_hrdev_by_netdev()
  and get_upper_dev_from_ndev().
* Remove check_vf_support() as we've moved the check into FW now.

v1: https://lore.kernel.org/linux-rdma/20250913090615.212720-1-huangjunxian6@hisilicon.com/T/#t

Junxian Huang (8):
  RDMA/hns: Add helpers to obtain netdev and bus_num from hr_dev
  RDMA/hns: Initialize bonding resources
  RDMA/hns: Add bonding event handler
  RDMA/hns: Add bonding cmds
  RDMA/hns: Implement bonding init/uninit process
  RDMA/hns: Add delayed work for bonding
  RDMA/hns: Support link state reporting for bond
  RDMA/hns: Support reset recovery for bond

 drivers/infiniband/hw/hns/Makefile          |    4 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c     |    1 -
 drivers/infiniband/hw/hns/hns_roce_bond.c   | 1012 +++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_bond.h   |   95 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |   16 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  141 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   20 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |  185 +++-
 drivers/infiniband/hw/hns/hns_roce_pd.c     |    1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     |    5 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |    1 -
 11 files changed, 1429 insertions(+), 52 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.h

--
2.33.0


