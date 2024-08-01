Return-Path: <linux-rdma+bounces-4151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49055944AC5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7581C20E76
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F17196DA1;
	Thu,  1 Aug 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTvg8+OZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F016DC20;
	Thu,  1 Aug 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513931; cv=none; b=FXoJTSpsog+xMizrr2aVRRVlfrG5VWMKcoM50isCbvRTTPTAD/TPmFOfMYxg20VrE+GoLwsOxeYypa7KV4DUu2qwFhpTPIGOaNvvPrF+90k5O9aHfJQr8rjcPHOCyLTeV2Du7t823I5vYhlpQmR82ALX2qNMK0sdwRC/8NETJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513931; c=relaxed/simple;
	bh=xrmm8vq48Turuhl+MYV5VwfRqiYgHDIYm72LgCbH1lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1wbyJQUqfFC6ihu1BMS/+HpP4R4nkCYvTHLd3Hsp5iyVmbFszTPTV6q8z7oK2tfOe6XOKjOv8iE25SWJND9zfrmPD8Lr643zGx4tKp0URzpcYuQSVDZKNi9Cce09aawpGgusKXhF3CbGHiwJLAwriWMSzdGBsyYH+5Jhmhgmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTvg8+OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23627C32786;
	Thu,  1 Aug 2024 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722513930;
	bh=xrmm8vq48Turuhl+MYV5VwfRqiYgHDIYm72LgCbH1lU=;
	h=From:To:Cc:Subject:Date:From;
	b=bTvg8+OZJV69EIq4IxRBqp9dfc6y/u9kWm+xw9EFbJQjCtGm/UcFRMTsSiul0eqRA
	 G1uDAZfhZ9TUmV4dy8tbbbxXhLFGDT9lrOc+bymDfNJGT+beG7sHBHtBQk0rOJW3zH
	 yQTqXwxCvOn8I43hDhUDD2l+9gOqREEUYMHgZ2c7tkTViB+iu6RePr0NnnB27Annav
	 +eP333ZCtfBXqo8qAegZ9RYVEm7YKemBWXwieFxVdf/xYmF2vWuSCSzvjkyvd6A+SY
	 tIjsSrZg5VceoSgba2wOLQsmlPbHo1+s8lGZ6WajKsWqmWfHgl8Dp88597sOWlI8lk
	 vC2KwTjZBx2lg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/8] Introducing Multi-Path DMA Support for mlx5 RDMA Driver
Date: Thu,  1 Aug 2024 15:05:09 +0300
Message-ID: <cover.1722512548.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

From Yishai,

Overview
--------
This patch series aims to enable multi-path DMA support, allowing an
mlx5 RDMA device to issue DMA commands through multiple paths. This
feature is critical for improving performance and reaching line rate
in certain environments where issuing PCI transactions over one path
may be significantly faster than over another. These differences can
arise from various PCI generations in the system or the specific system
topology.

To achieve this functionality, we introduced a data direct DMA device
that can serve the RDMA device by issuing DMA transactions on its behalf.

The main key features and changes are described below.

Multi-Path Discovery
--------------------
API Implementation:
 * Introduced an API to discover multiple paths for a given mlx5 RDMA device.
IOCTL Command: 
 * Added a new IOCTL command, MLX5_IB_METHOD_GET_DATA_DIRECT_SYSFS_PATH, to
   the DEVICE object. When an affiliated Data-Direct/DMA device is present,
   its sysfs path is returned.

Feature Activation by mlx5 RDMA Application
-------------------------------------------
UVERBS Extension:
 * Extended UVERBS_METHOD_REG_DMABUF_MR over UVERBS_OBJECT_MR to include
   mlx5 extended flags.
Access Flag: 
 * Introduced the MLX5_IB_UAPI_REG_DMABUF_ACCESS_DATA_DIRECT flag, allowing
   applications to request the use of the affiliated DMA device for DMABUF
   registration.

Data-Direct/DMA Device
----------------------
New Driver:
 * Introduced a new driver to manage the new DMA PF device ID (0x2100).
   Its registration/un-registration is handled as part of the mlx5_ib init/exit
   flows, with mlx5 IB devices as its clients.
Functionality: 
 * The driver does not interface directly with the firmware (no command interface,
   no caps, etc.) but works over PCI to activate its DMA functionality. It serves
   as the DMA device for efficiently accessing other PCI devices (e.g., GPU PF) and
   reads its VUID over PCI to handle NICs registrations with the same VUID.

mlx5 IB RDMA Device
---------------------------
VUID Query: 
 * Reads its affiliated DMA PF VUID via the QUERY_VUID command with the data_direct
   bit set.
Driver Registration:
 * Registers with the DMA PF driver to be notified upon bind/unbind.
Application Request Handling: 
 * Uses the DMA PF device upon application request as described above.

DMABUF over Umem
----------------
Introduced an option to obtain a DMABUF UMEM using a different DMA
device instead of the IB device, allowing the device to register over
IOMMU with the expected DMA device for a given buffer registration.

Further details are provided in the commit logs of the patches in this
series.

Thanks

Yishai Hadas (8):
  net/mlx5: Add IFC related stuff for data direct
  RDMA/mlx5: Introduce the 'data direct' driver
  RDMA/mlx5: Add the initialization flow to utilize the 'data direct'
    device
  RDMA/umem: Add support for creating pinned DMABUF umem with a given
    dma device
  RDMA/umem: Introduce an option to revoke DMABUF umem
  RDMA: Pass uverbs_attr_bundle as part of '.reg_user_mr_dmabuf' API
  RDMA/mlx5: Add support for DMABUF MR registrations with Data-direct
  RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl

 drivers/infiniband/core/umem_dmabuf.c         |  66 +++-
 drivers/infiniband/core/uverbs_std_types_mr.c |   2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |   3 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   2 +-
 drivers/infiniband/hw/efa/efa.h               |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |   4 +-
 drivers/infiniband/hw/irdma/verbs.c           |   2 +-
 drivers/infiniband/hw/mlx5/Makefile           |   1 +
 drivers/infiniband/hw/mlx5/cmd.c              |  21 ++
 drivers/infiniband/hw/mlx5/cmd.h              |   2 +
 drivers/infiniband/hw/mlx5/data_direct.c      | 227 +++++++++++++
 drivers/infiniband/hw/mlx5/data_direct.h      |  23 ++
 drivers/infiniband/hw/mlx5/main.c             | 125 +++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  22 +-
 drivers/infiniband/hw/mlx5/mr.c               | 304 +++++++++++++++---
 drivers/infiniband/hw/mlx5/odp.c              |   5 +-
 drivers/infiniband/hw/mlx5/std_types.c        |  55 +++-
 drivers/infiniband/hw/mlx5/umr.c              |  93 ++++--
 drivers/infiniband/hw/mlx5/umr.h              |   1 +
 include/linux/mlx5/mlx5_ifc.h                 |  51 ++-
 include/rdma/ib_umem.h                        |  18 ++
 include/rdma/ib_verbs.h                       |   2 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   9 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |   4 +
 24 files changed, 944 insertions(+), 100 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/data_direct.c
 create mode 100644 drivers/infiniband/hw/mlx5/data_direct.h

-- 
2.45.2


