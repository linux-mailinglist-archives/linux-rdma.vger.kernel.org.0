Return-Path: <linux-rdma+bounces-6070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D256B9D5DDB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B67BB22122
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802B1D7E4A;
	Fri, 22 Nov 2024 11:16:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58503142E83;
	Fri, 22 Nov 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274166; cv=none; b=V9+L2xt4MH8DWO8cR/pO+kiLLmhl8FKiTKp/2FuqX3NbXtxjD7ljVBcRf9JNubbRWLsreoUs2sxQiFwhkIOgevtnrq3raOjSbsM7gmH6hEudCphdZwfvCdpxMcKzu9mdPss5YlkM2zoD322KsaRGqiKop77VkWPYoWBl9RenLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274166; c=relaxed/simple;
	bh=I7PUxhs247KXZ+vsf/vOCRF2Oe/G5iESOA2fOqgwK5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cNIdxIn9hRWUvyG6dmOfl8PPpA/3Z/lWfeZhT/vriPj2bFDJwCHxPPICMRPXEclZW2zS3f82pvofpob02NcvuVjTfnZCKem6kxBgeD/hhQeQkovht6ftSQkYPhl26Xa3jcL2QZOe6HEa5Tx3SeopPfZQPUdKURbNFoXN5IbtREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XvsX80HVtzQv3P;
	Fri, 22 Nov 2024 18:58:16 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B892180214;
	Fri, 22 Nov 2024 18:59:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:39 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <selvin.xavier@broadcom.com>,
	<chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
	<mustafa.ismail@intel.com>, <tatyana.e.nikolova@intel.com>,
	<yishaih@nvidia.com>, <benve@cisco.com>, <neescoba@cisco.com>,
	<bryan-bt.tan@broadcom.com>, <vishnu.dasa@broadcom.com>,
	<zyjzyj2000@gmail.com>, <bmt@zurich.ibm.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>, <liyuyu6@huawei.com>
Subject: [PATCH RFC 00/12] RDMA: Support link status events dispatching in ib_core
Date: Fri, 22 Nov 2024 18:52:56 +0800
Message-ID: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

This series is to integrate a common link status event handler in
ib_core as this functionality is needed by most drivers and
implemented in very similar patterns. This is not a new issue but
a restart of the previous work of our colleagues from several years
ago, please see [1] and [2].

[1]: https://lore.kernel.org/linux-rdma/1570184954-21384-1-git-send-email-liweihang@hisilicon.com/
[2]: https://lore.kernel.org/linux-rdma/20200204082408.18728-1-liweihang@huawei.com/

With this series, ib_core can handle netdev events of link status,
i.e. NETDEV_UP, NETDEV_DOWN and NETDEV_CHANGE, and dispatch ib port
events to ULPs instead of drivers. However some drivers currently
have some private processing in their handler, rather than simply
dispatching events. For these drivers, this series provides a new
ops report_port_event(). If this ops is set, ib_core will call it
and the events will still be handled in the driver.

Events of LAG devices are also not handled in ib_core as currently
there is no way to obtain ibdev from upper netdev in ib_core. This
can be a TODO work after the core have more support for LAG. For
now mlx5 is the only driver that supports RoCE LAG, and the events
handling of mlx5 RoCE LAG will remain in mlx5 driver.

In this series:

Patch #1 adds a new helper to query the port num of a netdev
associated with an ibdev. This is used in the following patch.

Patch #2 adds support for link status events dispatching in ib_core.

Patch #3-#7 removes link status event handler in several drivers.
The port state setting in erdma, rxe and siw are replaced with
ib_get_curr_port_state(), so their handler can be totally removed.

Patch #8-#10 add support for report_port_event() ops in usnic, mlx4
and pvrdma as their current handler cannot be perfectly replaced by
the ib_core handler in patch #2.

Patch #11 adds a check in mlx5 that only events of RoCE LAG will be
handled in mlx5 driver.

Patch #12 adds a fast path for link-down events dispatching in hns by
getting notified from hns3 nic driver directly.

Yuyu Li (12):
  RDMA/core: Add ib_query_netdev_port() to query netdev port by IB
    device.
  RDMA/core: Support link status events dispatching
  RDMA/bnxt_re: Remove deliver net device event
  RDMA/erdma: Remove deliver net device event
  RDMA/irdma: Remove deliver net device event
  RDMA/rxe: Remove deliver net device event
  RDMA/siw: Remove deliver net device event
  RDMA/usnic: Support report_port_event() ops
  RDMA/mlx4: Support report_port_event() ops
  RDMA/pvrdma: Support report_port_event() ops
  RDMA/mlx5: Handle link status event only for LAG device
  RDMA/hns: Support fast path for link-down events dispatching

 drivers/infiniband/core/device.c              | 99 +++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/main.c          | 59 -----------
 drivers/infiniband/hw/erdma/erdma.h           |  2 -
 drivers/infiniband/hw/erdma/erdma_main.c      |  8 --
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  8 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 13 +++
 drivers/infiniband/hw/irdma/utils.c           |  3 -
 drivers/infiniband/hw/mlx4/main.c             | 58 +++++------
 drivers/infiniband/hw/mlx5/main.c             |  3 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c   | 71 +++++++------
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 42 +++++---
 drivers/infiniband/sw/rxe/rxe_net.c           | 22 +----
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  1 +
 drivers/infiniband/sw/siw/siw.h               |  3 -
 drivers/infiniband/sw/siw/siw_main.c          | 16 ---
 drivers/infiniband/sw/siw/siw_verbs.c         |  6 +-
 include/rdma/ib_verbs.h                       | 19 ++++
 17 files changed, 239 insertions(+), 194 deletions(-)

--
2.33.0


