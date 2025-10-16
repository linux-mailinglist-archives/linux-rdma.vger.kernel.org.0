Return-Path: <linux-rdma+bounces-13890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7FBE3A87
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F214503963
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3781E633C;
	Thu, 16 Oct 2025 13:20:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904851E5201
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620830; cv=none; b=eCuAU+N6TPNM5kyXpjVwrJjLkQy7Z9mU42d2Pw2+C2bqb3KAVT0JuR5KfH29d3UZvHrBYLRQwH/77zDcOKAXkj+Df11BxLlUSiybY+NZ1/Ywd1ofcCSKpOQGHCBoLwCtRnSrux3HEKUo3uDQITexMYR729q2osaJ0uQjJEIaMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620830; c=relaxed/simple;
	bh=iLV6ZLnK3yCy/M4vGAhIF4qI76wAkkMIApNk8X+nBVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljSDOOkxsMELCSvw1VAGeAJ/EF+SG6S22VWaYU6C5U3w0WxabTKErFYhNSMmR6VclgI0F0oDAnT0bjFTlK0NccxO7cUqqXWY0QoEze7Gm1muwY2P18aS3DaADI7k+vI9cspVgdrzh0S9rnNCs/WaI2bViTtFHTKHtEJhDPqkUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cnT8M4qYWzRhR6;
	Thu, 16 Oct 2025 21:20:03 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DB663140156;
	Thu, 16 Oct 2025 21:20:24 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 21:20:24 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 0/8] RDMA/hns: Support RoCE bonding
Date: Thu, 16 Oct 2025 21:20:15 +0800
Message-ID: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

v1 -> v2:
https://lore.kernel.org/linux-rdma/20250913090615.212720-1-huangjunxian6@hisilicon.com/T/#t
* Hold the refcount when returning from hns_roce_get_hrdev_by_netdev()
  and get_upper_dev_from_ndev().
* Remove check_vf_support() as we've moved the check into FW now.

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
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  143 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   20 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |  176 +++-
 drivers/infiniband/hw/hns/hns_roce_pd.c     |    1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     |    5 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |    1 -
 11 files changed, 1422 insertions(+), 52 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.h

--
2.33.0


