Return-Path: <linux-rdma+bounces-117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1B7FBA1C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A29F1C214A4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34656479;
	Tue, 28 Nov 2023 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCzQmT7A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8232C70;
	Tue, 28 Nov 2023 12:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CEDC433C7;
	Tue, 28 Nov 2023 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174611;
	bh=rW81soh58JgFvypfkt5SGdoRGcE0mbtnlO8fcf3y+/0=;
	h=From:To:Cc:Subject:Date:From;
	b=NCzQmT7AUM/87VPexPPppbe1DTHgRpvkYs0UPr4Jg8TZiVfNJ7u5iNrjtqRIXumy4
	 rD9CIpp9t1JOUamcGCZFYHi2I5iw1FocWyHcaSWxDyiGlaCc8GqhQyL/pmxgLqPkWO
	 EUxDTFcRvW7V1T8tRcIoCIFYopx49vawn5btRVyH3ouL0iRsh93hkF8/CKy+d0oYi/
	 8dSvKDI6BxWtMNAEBkEE/8UHeXmr5Iu4CDyWZQCTKoU8MIRD60WrJ3rIgaWTXsDyl4
	 KJGWOZJ3RbM39mOq6js/J1jszvl/wdVpe75eCLn9a1xYO/l+t5bQxhh6Y217EM7BGo
	 CW4653ZSc3UUQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shun Hao <shunh@nvidia.com>
Subject: [PATCH mlx5-next 0/5] Expose c0 and SW encap ICM for RDMA
Date: Tue, 28 Nov 2023 14:29:44 +0200
Message-ID: <cover.1701172481.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

These two series from Mark and Shun extend RDMA mlx5 API.

Mark's series provides c0 register used to match egress
traffic sent by local device.

Shun's series adds new type for ICM area.

Thanks

Mark Bloch (2):
  net/mlx5: E-Switch, expose eswitch manager vport
  RDMA/mlx5: Expose register c0 for RDMA device

Shun Hao (3):
  net/mlx5: Introduce indirect-sw-encap icm properties
  net/mlx5: Manage ICM type of SW encap
  RDMA/mlx5: Support handling of SW encap ICM area

 drivers/infiniband/hw/mlx5/dm.c               |  5 +++
 drivers/infiniband/hw/mlx5/main.c             | 24 ++++++++++++
 drivers/infiniband/hw/mlx5/mr.c               |  1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ----
 .../net/ethernet/mellanox/mlx5/core/lib/dm.c  | 38 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 include/linux/mlx5/eswitch.h                  |  8 ++++
 include/linux/mlx5/mlx5_ifc.h                 |  9 ++++-
 include/uapi/rdma/mlx5-abi.h                  |  2 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |  1 +
 10 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.43.0


