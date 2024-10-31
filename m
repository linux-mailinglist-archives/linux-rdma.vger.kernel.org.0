Return-Path: <linux-rdma+bounces-5657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833D9B799C
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 12:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D1B1F230EE
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0919ABAB;
	Thu, 31 Oct 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRgEipVg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7C155322;
	Thu, 31 Oct 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373780; cv=none; b=tpbsPFk2RYQmhmNvg72xhl6YumHyQazpubqzO5BztY4PUqbNY5vZNcNDmJ4Jn1HET6sa0z+dYcodxIL9Nxvbv9GQeDtEOCYSpDztYAU7/AZw/DMkt3xePmYDLz2PK6F92vgeLMR1XpXveHX/EuUQcjTeJeF0jgq9sXX7Xem4Yf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373780; c=relaxed/simple;
	bh=aOZwsyCLGCU7JzC/uzE0mNVWXhPROsadhd8w6/goA3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlIW/x1HGuLrYdoWXl66iAByVPWU80WhsT2nuHMpUTxrhOCWS/HMtdzwQWqmvhoJmdOQHuJg/A5fZ2oo5m0KBoHpAu2LsMfYgX2YXxtIerVxjSQvfANXR57N1ZlyQUlW1FPzHXxex8urDFsBdJXWz0zUZLprp4O73ePXhC6frdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRgEipVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AACC4CED0;
	Thu, 31 Oct 2024 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730373779;
	bh=aOZwsyCLGCU7JzC/uzE0mNVWXhPROsadhd8w6/goA3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=dRgEipVg/N2bFt5EmmY0+qSrUHms181drVAqRAEl+TckYEoDvESiezbVb5+Xxsz3S
	 3mpe9/iXnCUKxWP66E+TgmJsC/Ii4yi8u7AHAw3efAYM4ldmZJ7LNGv4Sy8assJM2m
	 6B5exv2SbX6rLyhjaPO5FwGdan/U+pL7iWLBjOBdZPn0gwrn8hJRS3s9tf+Mltbt6d
	 LPpc7DZ/Uo4myZ6zGFWqqSSllJhMz8Y7EnsxiFCHjDUJBzK5zkm47R8/NRn/zN+fgT
	 OOlhkz3Gv3u7MWBvc8wK4jZOr8UW36ySeL1A8KfkgsEUHqrOJyhccXsLES2IW5/TYq
	 iRuWg1VztF5Dw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-next 0/3] Allow parallel cleanup of HW objects
Date: Thu, 31 Oct 2024 13:22:50 +0200
Message-ID: <cover.1730373303.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series from Patrisious adds a new device operation to allow the
driver to cleanup HW objects in parallel to the ufile cleanup. This is
useful for drivers that have HW objects that are not associated with a
kernel structures and doesn't have any dependencies on other objects.

In mlx5 case, we are using this new operation to cleanup DEVX QP
objects, which are independent from the rest verbs objects (like PD, CQ,
e.t.c).

Thanks

Patrisious Haddad (3):
  RDMA/core: Add device ufile cleanup operation
  RDMA/core: Move ib_uverbs_file struct to uverbs_types.h
  RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation

 drivers/infiniband/core/device.c    |  1 +
 drivers/infiniband/core/rdma_core.c | 12 +++-
 drivers/infiniband/core/uverbs.h    | 31 ----------
 drivers/infiniband/hw/mlx5/devx.c   | 93 ++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/devx.h   |  4 ++
 drivers/infiniband/hw/mlx5/main.c   |  1 +
 include/rdma/ib_verbs.h             |  6 ++
 include/rdma/uverbs_types.h         | 33 ++++++++++
 8 files changed, 146 insertions(+), 35 deletions(-)

-- 
2.46.2


