Return-Path: <linux-rdma+bounces-8154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30E6A4624F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190931740B0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291322170B;
	Wed, 26 Feb 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+YCSgWH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063022A1C5;
	Wed, 26 Feb 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579468; cv=none; b=f1TOTSvPYZQ5+09rdBxP3J/wjJhKK4NdNfATeaOL5+cGhm70GPEq+m3eXg18Z+v4ixNT5oM65xwOaWDgxgtr6bmndFwhllRLf52O46KRtOR9zj0nAiZiUt3AH2Qn599Uu5EF0sBriJDU/2EyHMUyUnZ1TosebKDyalLaFAz4Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579468; c=relaxed/simple;
	bh=048124pTYbVIZJiv9XG1+VmzSgOqnJf8lUUPOOZdDrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ikrs0VGKdAToDwy9X+ByEnBbQohv6Xd7PXxlPEfXvcJd6XLJ+ybMtiML1Sf0Cc+BFxcPgEd/APFToYaxL5O6zOg5gATUKW6DdwtcS398EqTV8EwNcHeDShIfOqwmwL3xzx4IYQywU4U+vQs4YREOFmd/oICcjvEEMW85TQHMEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+YCSgWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC8DC4CED6;
	Wed, 26 Feb 2025 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579467;
	bh=048124pTYbVIZJiv9XG1+VmzSgOqnJf8lUUPOOZdDrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=D+YCSgWHRqGAw6O/JiB2Aqg70g5ZNOmYxfduK32VJXaq9Uci3fzE4AqoMw02sBIAK
	 bWvuCFSU7NZucy4yjArMHcMqzPXcCIOaa1YMWJlIrCTTQzpgiQaAZ02A55E1Ct+WG1
	 Jwmp9fUcOsd5SxnSf6JqXPaGYAEFSEsZLy5xwq4RH4+Dg4oiYyjP0R6noEbH40eQ0q
	 H/p3F/d6EQLNAsvdZIRv/VHAJjaDro1m2vc5vpCLUSYnJRCl84ttyOqcZE/rvqXAP8
	 zFc/ai45g/onQJhKq8aR6Db7gsCruPr4Xr2AzcxHPo4yepE1t7GYBWDvxyMOJfC/gk
	 vXBbsc/ZfVLpw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/6] Introduce UCAP API and usage in mlx5
Date: Wed, 26 Feb 2025 16:17:26 +0200
Message-ID: <cover.1740574943.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the User CAPability (UCAP) API that allows
creating user contexts with various firmware privileges.

The UCAP API provides fine-grained control over specific firmware
features by representing each capability as a character device with root
read-write access. Root processes can grant users special privileges by
allowing access to these character devices. User contexts created using
a file descriptor of a UCAP will have specific UCAP privileges.

Two UCAP character devices are created for mlx5, and user contexts
opened with at least one of these UCAPs are considered privileged. To
ensure that privileged commands can always proceed, non-privileged
commands are limited when a privileged user is present on the device.

Thanks

Chiara Meiohas (5):
  RDMA/uverbs: Introduce UCAP (User CAPabilities) API
  RDMA/mlx5: Create UCAP char devices for supported device capabilities
  RDMA/uverbs: Add support for UCAPs in context creation
  RDMA/mlx5: Check enabled UCAPs when creating ucontext
  docs: infiniband: document the UCAP API

Patrisious Haddad (1):
  RDMA/mlx5: Expose RDMA TRANSPORT flow table types to userspace

 Documentation/infiniband/index.rst            |   1 +
 Documentation/infiniband/ucaps.rst            |  71 +++++
 drivers/infiniband/core/Makefile              |   3 +-
 drivers/infiniband/core/ucaps.c               | 255 ++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c          |  19 ++
 drivers/infiniband/core/uverbs_main.c         |   2 +
 .../infiniband/core/uverbs_std_types_device.c |   4 +
 drivers/infiniband/hw/mlx5/devx.c             |  31 ++-
 drivers/infiniband/hw/mlx5/devx.h             |   5 +-
 drivers/infiniband/hw/mlx5/fs.c               | 154 ++++++++++-
 drivers/infiniband/hw/mlx5/fs.h               |   2 +
 drivers/infiniband/hw/mlx5/main.c             |  77 +++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +
 include/rdma/ib_ucaps.h                       |  25 ++
 include/rdma/ib_verbs.h                       |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |   2 +
 18 files changed, 635 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/infiniband/ucaps.rst
 create mode 100644 drivers/infiniband/core/ucaps.c
 create mode 100644 include/rdma/ib_ucaps.h

-- 
2.48.1


