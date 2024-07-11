Return-Path: <linux-rdma+bounces-3835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C072492F125
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2361F23EC3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091419EEB7;
	Thu, 11 Jul 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTIJqwsB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29D12F385;
	Thu, 11 Jul 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733517; cv=none; b=YOGo14kpSFcZvNNqSWMcxVrF+u0IAp0tEp8HGR/UU4HK9JkRZCKEnyT+37FYUe7PMJHGvV8wFcbBteQvgaig167rYzOW0OgfyMbMX7ceDRvVBQunVCf7iRbrzn+NpXLHeIRVOXOLUm9FHWqEPtVXDZNXF5G8jx0ll/Vxs/xRgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733517; c=relaxed/simple;
	bh=cmzILsofv3wnDXHqreZHYrqZp0j3PJNUAku/F48ywFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7uYdJMU7Ddak6MmWfmhUbSEJ4QOQFpPgqqrLRQk4QVtW3E7A1aOPY3qFQ/qUX2uI48U2fNHy1Zvezo1SgbtTbg+lptvbRDE7MB/orbk8d3dnauB9oQMdS1G32XBJFKTQa8B17wIPyfJR+WxBGOAnULmeFUTdvDHw+MNKSMKCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTIJqwsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0BC116B1;
	Thu, 11 Jul 2024 21:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720733517;
	bh=cmzILsofv3wnDXHqreZHYrqZp0j3PJNUAku/F48ywFI=;
	h=From:To:Cc:Subject:Date:From;
	b=WTIJqwsB980TwBMttfwMkjaC0b1Jxkj1x6Atyb9K4U3gSXqxDL/yo/M2uYSJXSYls
	 7xVivshU1V63jZjQ5xafdVJ5AYT+r0jbgXOIZTV0ZvZ58tcFbCtXMZUATquOf2PlO+
	 UclJ8BtbjpjRYXf7uwnJO48y6DVLV7IdZ9cnMPMY7EoNYg0q+q0rXmk4ygKXGoc5a+
	 iwBlSiyvvI6iBZvESWQ7JC7O7ugmjvP1xd5L7WK/F0T4ugxqR5Zi9urBOCM1szJwJM
	 SrSxWdAQhF7HZYVsib3uEmNqa3qZQcH2UVUKxg3CRWnX0QUapPnN4UujsG/dbROmk7
	 f2lr2i+aDx7mA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [GIT PULL mlx5-next] Introduce auxiliary bus IRQs sysfs
Date: Thu, 11 Jul 2024 14:31:38 -0700
Message-ID: <20240711213140.256997-1-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Hi Jakub and Greg,

Following the review of v10 and Greg's request to send this via netdev.
This is a pull request that includes the 2 patches of adding IRQs sysfs
to aux dev subsystem based on mlx5-next tree (6.10-rc3).

v10: https://lore.kernel.org/all/2024071041-frosted-stonework-2c60@gregkh/

Please pull and let me know if there's any problem.

The following changes since commit b339e0a39dc37726712b9f0485d78fe4306d1667:

  RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded (2024-06-16 18:53:23 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/aux-sysfs-irqs

for you to fetch changes up to 587aebb80370c9cdea106e5870025ad70114a2ed:

  net/mlx5: Expose SFs IRQs (2024-07-11 13:52:16 -0700)

----------------------------------------------------------------
aux-sysfs-irqs

Shay Says:
==========
Introduce auxiliary bus IRQs sysfs

Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files.  PCI
subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
on the auxiliary bus. However, these PCI SFs lack such IRQ information
on the auxiliary bus, leaving users without visibility into which IRQs
are used by the SFs. This absence makes it impossible to debug
situations and to understand the source of interrupts/SFs for
performance tuning and debug.

Additionally, the SFs are multifunctional devices supporting RDMA,
network devices, clocks, and more, similar to their peer PCI PFs and
VFs. Therefore, it is desirable to have SFs' IRQ information available
at the bus/device level.

To overcome the above limitations, this short series extends the
auxiliary bus to display IRQ information in sysfs, similar to that of
PFs and VFs.

It adds an 'irqs' directory under the auxiliary device and includes an
<irq_num> sysfs file within it.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58

Patch summary:
patch-1 adds auxiliary bus to support irqs used by auxiliary device
patch-2 mlx5 driver using exposing irqs for PCI SF devices via auxiliary
        bus

==========

----------------------------------------------------------------
Shay Drory (2):
      driver core: auxiliary bus: show auxiliary device IRQs
      net/mlx5: Expose SFs IRQs

 Documentation/ABI/testing/sysfs-bus-auxiliary      |   9 ++
 drivers/base/Makefile                              |   1 +
 drivers/base/auxiliary.c                           |   1 +
 drivers/base/auxiliary_sysfs.c                     | 113 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   6 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  18 +++-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   6 ++
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |  12 ++-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  12 ++-
 include/linux/auxiliary_bus.h                      |  24 +++++
 10 files changed, 191 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

