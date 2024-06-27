Return-Path: <linux-rdma+bounces-3551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDCF91AEF2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 20:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F041D1C20E26
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023D19AA4B;
	Thu, 27 Jun 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij/Msw2t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DE13A276;
	Thu, 27 Jun 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512639; cv=none; b=Q4qNnYu6OZ0RyedyS/1XX9QDSjedeYrD0/D2/wgbP9HxvJeD5p93/VvlHGxoemhMRODxBfJWNjGI0TuCql+pRuzdJobJtOIOjqkgsyT3BC5O7aNfIV+r4ulZIg2bq01ZxfpAfLx8sS2i5unu/xZP5xFyZsQk49xpjJZLjLSOrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512639; c=relaxed/simple;
	bh=4TQh1N5RbBd9ls9AZROG5SAjKAcoFUzwxKsHEb1Q90A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQv3gHtGjyyuL+es6ObQlzIpZOK3cd9oGvw5JkA7WSz9vomzOleoax/QdXkde8zibZSMQMLVmlNOM0roy4zTKzaTc5SLq4TYPgBP3pkyZ0Hdgl7lAzPJe1gl8amKCeSidwK7kAM1T4x/v7kCcUqfuEomrnJ2RfROxXpy/l9dIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij/Msw2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEECBC4AF09;
	Thu, 27 Jun 2024 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512638;
	bh=4TQh1N5RbBd9ls9AZROG5SAjKAcoFUzwxKsHEb1Q90A=;
	h=From:To:Cc:Subject:Date:From;
	b=ij/Msw2tHMFSGgIZr4ihyp3GZqy6epukg+yefplh5Hu7IKZG5Icvm1fj/yJuiP7zg
	 Gu/VfRF7AX4wKKFWvZzv6YgrdEdUGU/pBhkOKZzZqx1ccvnyK6kevvo0t4YTKzEvJC
	 hakw9AXtNIbJSbHMSH9h4b+HDRCmuyMOa81tgCVxNMDLt691qvrA6gznv3G48gl7hM
	 l8ngDF+ledhKy6jPUXT6xKkHBc7AyFay2ouVDvw5TfRcv4peVEI17XaKgpRwFWtmqq
	 crKEE7i+wHWaYa0HwLu6BsBeM885bllykcToPLF625o8WrmKJJdPO8KdZWMCkBKPAs
	 Wz0uQc6M8jdfQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v2 0/2] Extend mlx5 CQ creation with large UAR page index
Date: Thu, 27 Jun 2024 21:23:48 +0300
Message-ID: <cover.1719512393.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
 * Another fix to compilation errors in first patch
v1: https://lore.kernel.org/all/cover.1719244483.git.leon@kernel.org
 * Fixed compilation errors in first patch
 * Changed new attribute name as Jason suggested
v0: https://lore.kernel.org/all/cover.1718554263.git.leon@kernel.org/

------------------------------------------------------------------------
Hi,

This series from Akiva extends the mlx5 private field with the UAR page
index which is larger than 16 bits as was before.

As this is first time, we extend ioctl API with private data field after
it already has UHW object, we need to change create CQ API signature to
support it.

Thanks

Akiva Goldberger (2):
  RDMA: Pass entire uverbs attr bundle to create cq function
  RDMA/mlx5: Send UAR page index as ioctl attribute

 drivers/infiniband/core/uverbs_cmd.c          |  2 +-
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  3 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
 drivers/infiniband/hw/cxgb4/cq.c              |  3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
 drivers/infiniband/hw/efa/efa.h               |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  3 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  3 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
 drivers/infiniband/hw/irdma/verbs.c           |  5 +--
 drivers/infiniband/hw/mana/cq.c               |  3 +-
 drivers/infiniband/hw/mana/mana_ib.h          |  2 +-
 drivers/infiniband/hw/mlx4/cq.c               |  3 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               | 31 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c             |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c            |  3 +-
 drivers/infiniband/hw/qedr/verbs.h            |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  5 +--
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 +-
 drivers/infiniband/sw/rdmavt/cq.c             |  6 ++--
 drivers/infiniband/sw/rdmavt/cq.h             |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |  5 +--
 drivers/infiniband/sw/siw/siw_verbs.h         |  2 +-
 include/rdma/ib_verbs.h                       |  2 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  7 ++---
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 +++
 37 files changed, 89 insertions(+), 45 deletions(-)

-- 
2.45.2


