Return-Path: <linux-rdma+bounces-8418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D4A54A0C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0382B169645
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA3205AAF;
	Thu,  6 Mar 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWfurdml"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C138156225;
	Thu,  6 Mar 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261936; cv=none; b=KP6HBpj6ea7JnmY7wuPzKG2t7/mYgBmmIPu2fgR3mn5bjetp8owJjPMF2y20RuU/+NjXYNqpMp6G++VumSzfz27XDZsqGbnKp2rU9670bxgvsi+XEAdy8ph2+XeGUVODBHdgb1clhcK3m1kQ95DMDRoWnkvjUwkrqi7Cv05LLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261936; c=relaxed/simple;
	bh=G9qw8yU2JYwrSJd80gP5IXYjnfL0h1O2hrprO7bOI9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArsIZwMLDMnEY9MOwHzViNoFRN2U37nNvlkTxO+gluTIg6BATzOolqD5/wQ4Ng9dyTqSnXlKkWtQq0eXSw592VfNgz0SamcnKlD8lZR1sXWv2ugPuS+yLXUEQp2u3wWSLoueY5ZozriOAUc4DbYsGPoXMCueOgIBt/8hi1AGmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWfurdml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43663C4CEE0;
	Thu,  6 Mar 2025 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261934;
	bh=G9qw8yU2JYwrSJd80gP5IXYjnfL0h1O2hrprO7bOI9s=;
	h=From:To:Cc:Subject:Date:From;
	b=eWfurdmlMMoXS1Rdf1BpyqqF2x1Y05Uyb6/bhqwS6/MSOpVuOLMeOqigqZikQu+YV
	 wha8RO5po7/3h2K/e9j+UjF8Bm7bwSLwd0JIUF1mZMUXHX0UAZFR+RjFDo/ZEDHHhc
	 aJtDCrECwZ58EEzmSVDKuFiRzE5YY38T12NAjietkr7yXSokRZB9wIhcxm2OrCw4ei
	 Qv+n3PUXvOS6W7x8tafqqdy54U6OuXZoaa1ZVKFOtsgIsbW3mR6p0cO1gW4sT0Vzpi
	 TwXsmCpiT5GvufKVAfn2hPa+ae3StD2FBlLqyI3pR/aKwTdCo1rB1csCm9YEbfioIU
	 buv+8Z9Z9VZsQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 0/6] Introduce UCAP API and usage in mlx5
Date: Thu,  6 Mar 2025 13:51:25 +0200
Message-ID: <cover.1741261611.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1:
 * Used kref primitives instead of open-coded variant
 * Check return value from dev_set_name()
 * Added extra brackets around type in UCAP_ENABLED macro
v0: https://lore.kernel.org/all/cover.1740574943.git.leon@kernel.org

--------------------------------------------------------------------------
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
 drivers/infiniband/core/ucaps.c               | 267 ++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c          |  19 ++
 drivers/infiniband/core/uverbs_main.c         |   2 +
 .../infiniband/core/uverbs_std_types_device.c |   4 +
 drivers/infiniband/hw/mlx5/devx.c             |  31 +-
 drivers/infiniband/hw/mlx5/devx.h             |   5 +-
 drivers/infiniband/hw/mlx5/fs.c               | 154 +++++++++-
 drivers/infiniband/hw/mlx5/fs.h               |   2 +
 drivers/infiniband/hw/mlx5/main.c             |  77 ++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +
 include/rdma/ib_ucaps.h                       |  25 ++
 include/rdma/ib_verbs.h                       |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |   2 +
 18 files changed, 647 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/infiniband/ucaps.rst
 create mode 100644 drivers/infiniband/core/ucaps.c
 create mode 100644 include/rdma/ib_ucaps.h

-- 
2.48.1


