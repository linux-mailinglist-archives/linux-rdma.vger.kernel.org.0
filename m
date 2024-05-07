Return-Path: <linux-rdma+bounces-2327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2F8BEC1E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 21:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB7285FF9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FAD16D9BA;
	Tue,  7 May 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BUPpBvir"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2116D9A7;
	Tue,  7 May 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108478; cv=none; b=PJro4YcPNXzD6jUurmyjruHo8vHqF01APRL0Bo45xCv7LNAMYTYgqB6vNQNckWOrnNNkS/ajPHcmgt+9YBop8Eujkyh60DA7szubqUyUUrNJfynblYS1XaAbUYqWFLfcyOPppyl7uz5ADuJZF2vJQRbYq/csSduLhJ2Udr+sj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108478; c=relaxed/simple;
	bh=g1veQz9dJ3sVo0hMDOXcpFezi7Iobr9bX5G1zVUCr2s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=imZZucoDpcIDsqWHkVP5dF96HrH27uz+tS1OaVRJbIYeGQcImUxCRnaYRz6Ex61kATBOiHHJi32rGTnJYPLODWol1o+tKASsIhLHfrCmJVXbCzQRxEGm7ZseFxBH4bts0ff93ARohdgn2iiseG5zPuztSrAlWCsH0Y2Cg0gVSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BUPpBvir; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id BFE4A20B2C82;
	Tue,  7 May 2024 12:01:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFE4A20B2C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715108476;
	bh=VWE6ZXP3AIBJkn4ZrcnxCPzQUxLvW0RGUuO+DHKq/oQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BUPpBvirSU0EX4pKl+Phr89hCZNIv0k0Az22vm7KuGi0USH0e7qWgzZ6Udw0XYCc1
	 f8c0XlYsrfpY1Wu1Ayb0yKlIz14J+IO8Qd/dOrTV+O1rq/zlwl5rywcIUO15zHBLb9
	 uqJP7Ip9O/vzxFMcysGpkWIAo+IBXQpmPcE44qGY=
From: Allen Pais <apais@linux.microsoft.com>
To: netdev@vger.kernel.org
Cc: jes@trained-monkey.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
	dougmill@linux.ibm.com,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com,
	cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	mlindner@marvell.com,
	stephen@networkplumber.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	borisp@nvidia.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com,
	richardcochran@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com
Subject: [PATCH 0/1] Convert tasklets to BH workqueues in ethernet drivers
Date: Tue,  7 May 2024 19:01:10 +0000
Message-Id: <20240507190111.16710-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This series focuses on converting the existing implementation of
tasklets to bottom half (BH) workqueues across various Ethernet
drivers under drivers/net/ethernet/*.

Impact:
 The conversion is expected to maintain or improve the performance
of the affected drivers. It also improves the maintainability and
readability of the driver code.

Testing:
 - Conducted standard network throughput and latency benchmarks
   to ensure performance parity or improvement.
 - Ran kernel regression tests to verify that changes do not introduce new issues.

I appreciate your review and feedback on this patch series.
And additional tested would be really helpful.

Allen Pais (1):
  [RFC] ethernet: Convert from tasklet to BH workqueue

 drivers/infiniband/hw/mlx4/cq.c               |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  2 +-
 drivers/net/ethernet/alteon/acenic.c          | 26 +++----
 drivers/net/ethernet/alteon/acenic.h          |  7 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 30 ++++----
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 16 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 16 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 11 +--
 drivers/net/ethernet/broadcom/cnic.c          | 19 ++---
 drivers/net/ethernet/broadcom/cnic.h          |  2 +-
 drivers/net/ethernet/cadence/macb.h           |  3 +-
 drivers/net/ethernet/cadence/macb_main.c      | 10 +--
 .../net/ethernet/cavium/liquidio/lio_core.c   |  4 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   | 25 +++----
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 +--
 .../ethernet/cavium/liquidio/octeon_droq.c    |  4 +-
 .../ethernet/cavium/liquidio/octeon_main.h    |  5 +-
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 12 ++--
 drivers/net/ethernet/cavium/thunder/nic.h     |  5 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++----
 .../ethernet/cavium/thunder/nicvf_queues.c    |  5 +-
 .../ethernet/cavium/thunder/nicvf_queues.h    |  3 +-
 drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 41 +++++------
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +-
 drivers/net/ethernet/dlink/sundance.c         | 41 +++++------
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 17 +++--
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |  2 +-
 drivers/net/ethernet/ibm/ehea/ehea.h          |  3 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     | 14 ++--
 drivers/net/ethernet/ibm/ibmvnic.c            | 24 +++----
 drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
 drivers/net/ethernet/jme.c                    | 72 +++++++++----------
 drivers/net/ethernet/jme.h                    |  9 +--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  2 +-
 drivers/net/ethernet/marvell/skge.c           | 12 ++--
 drivers/net/ethernet/marvell/skge.h           |  3 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    | 12 ++--
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |  3 +-
 drivers/net/ethernet/mellanox/mlx4/cq.c       | 42 +++++------
 drivers/net/ethernet/mellanox/mlx4/eq.c       | 10 +--
 drivers/net/ethernet/mellanox/mlx4/mlx4.h     | 11 +--
 drivers/net/ethernet/mellanox/mlx5/core/cq.c  | 38 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 12 ++--
 .../ethernet/mellanox/mlx5/core/fpga/conn.c   | 15 ++--
 .../ethernet/mellanox/mlx5/core/fpga/conn.h   |  3 +-
 .../net/ethernet/mellanox/mlx5/core/lib/eq.h  | 11 +--
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 29 ++++----
 drivers/net/ethernet/micrel/ks8842.c          | 29 ++++----
 drivers/net/ethernet/micrel/ksz884x.c         | 37 +++++-----
 drivers/net/ethernet/microchip/lan743x_ptp.c  |  2 +-
 drivers/net/ethernet/natsemi/ns83820.c        | 10 +--
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c  |  7 +-
 .../net/ethernet/netronome/nfp/nfd3/nfd3.h    |  2 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c  |  6 +-
 .../net/ethernet/netronome/nfp/nfdk/nfdk.h    |  3 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  4 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   | 12 ++--
 .../net/ethernet/netronome/nfp/nfp_net_dp.h   |  4 +-
 drivers/net/ethernet/ni/nixge.c               | 19 ++---
 drivers/net/ethernet/qlogic/qed/qed.h         |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_int.c     |  6 +-
 drivers/net/ethernet/qlogic/qed/qed_int.h     |  4 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c    | 20 +++---
 drivers/net/ethernet/sfc/falcon/farch.c       |  4 +-
 drivers/net/ethernet/sfc/falcon/net_driver.h  |  2 +-
 drivers/net/ethernet/sfc/falcon/selftest.c    |  2 +-
 drivers/net/ethernet/sfc/net_driver.h         |  2 +-
 drivers/net/ethernet/sfc/selftest.c           |  2 +-
 drivers/net/ethernet/sfc/siena/farch.c        |  4 +-
 drivers/net/ethernet/sfc/siena/net_driver.h   |  2 +-
 drivers/net/ethernet/sfc/siena/selftest.c     |  2 +-
 drivers/net/ethernet/silan/sc92031.c          | 47 ++++++------
 drivers/net/ethernet/smsc/smc91x.c            | 16 ++---
 drivers/net/ethernet/smsc/smc91x.h            |  3 +-
 include/linux/mlx4/device.h                   |  2 +-
 include/linux/mlx5/cq.h                       |  2 +-
 83 files changed, 501 insertions(+), 473 deletions(-)

-- 
2.17.1


