Return-Path: <linux-rdma+bounces-3183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F83909E73
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679971C20A91
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87FC11CAB;
	Sun, 16 Jun 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF3f/Ald"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AD1CA8D;
	Sun, 16 Jun 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554565; cv=none; b=JtPpY4n2coKKqTzZlSdyZXZhdUkL9hYfDQOI498Rfm36tSvHJL970ymGLD/KHDDc5v/l8/oCEEBVZsmeo7H+J4OmtweXMcgjDA5VF8KoN4vbyPDTgljAM58Bh7xvfSBRa3k0FVQHUwaSv5vo6geL7xJ9kD/98mDI7wT50K3fr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554565; c=relaxed/simple;
	bh=/AaohLLZ87QYZSC3kY38NZRdOqHUfIjkxZWocMAI+6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCHr5wQuVtEajCT90RepummxOui+VAJqfT/h+WOxRDECyuZXRpx5uRwuP8XYrBFHnzWoCSeUI7FQRYEMIFnMTKTH87YYfgje8cfgF4nLVkn3uxmJmJvPLnZSkmc+JsfkI1Gsm3ib8nEdWhLRwoOYlub9psm4GiGGJDQ8Zm2xDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF3f/Ald; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEC8C4AF1D;
	Sun, 16 Jun 2024 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554564;
	bh=/AaohLLZ87QYZSC3kY38NZRdOqHUfIjkxZWocMAI+6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=RF3f/AldZiGFkepxeQcAjl5LH9UHNK6YiI/aukiXaYHMr2D++dKc7pzauFbzruLCL
	 ivVlKAxhuI2eNK+LD/b1Xy7osz2xXqGh++80CphcnytlNv++lUHLgjnux0lqzf/MGr
	 geBz0MbsFdxnwvHYJU98OzcYTax9zTwedoSfb+BIFhluPLoizW4okrkDYV6nisVz9X
	 +PV4gC3PbMK5zhH2VTm8VYmV3HtOZCui/IfVFaYqy83xuGDeovIGm8abeemj6IdBSE
	 q0RAf4h6eNkH9SvYyhFKkVjkbXZjXnQfgkgBtrU0XvFevZBp8GaJyUK6e2ERhQo5UL
	 +Z1oCVPEFDlxA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 0/2] Extend mlx5 CQ creation with large UAR page index
Date: Sun, 16 Jun 2024 19:15:56 +0300
Message-ID: <cover.1718554263.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series from Akiva extends the mlx5 private field with the UAR page index
which is larger than 16 bits as was before.

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
 drivers/infiniband/hw/mana/cq.c               |  2 +-
 drivers/infiniband/hw/mana/mana_ib.h          |  2 +-
 drivers/infiniband/hw/mlx4/cq.c               |  3 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               | 31 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c             |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |  2 +-
 drivers/infiniband/sw/siw/siw_verbs.h         |  2 +-
 include/rdma/ib_verbs.h                       |  2 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 +++
 27 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.45.2


