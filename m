Return-Path: <linux-rdma+bounces-3416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3716914376
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CB71C22D06
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFD381B1;
	Mon, 24 Jun 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2xPC8LG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430E18AE4;
	Mon, 24 Jun 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213680; cv=none; b=IOpqIr/4ZHpFmiQ6TmE2PMX2RF4iKqKHXNgg1gBJyQRYVuc4y2I6Hq4Xr4NN7qQsLfUF5K6O+0dchhKgAv6sv47Bx9bEOPHlwHGOxi1+t9lRzMFGAdnWKdZiIkMDmQpY2E/8f9ETHphOB1zHXIDZfKBOgokoSWQyUj9v8aZxTKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213680; c=relaxed/simple;
	bh=UqTNpMPv9Au1QNY0/qPLXKj+m6DdxTulR24aZJ3g2Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqiAu7ML5I0RGZ8yNSOYnUeL7xX3Cfv1mq2TdQcp+3VrFKIfob712/VZzdwBC3CUzqwHebaVmRj0iJQ/5H18mdpZqcdL8sedKdKjFJ4GE0d2bH+ZJJUwt7z2GfYg/7L1AVl6a1b6WaeyDnB6DZ7UC06EKkH5H5+zZw+Gw6xwDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2xPC8LG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719213678; x=1750749678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UqTNpMPv9Au1QNY0/qPLXKj+m6DdxTulR24aZJ3g2Qg=;
  b=i2xPC8LGSCVG/hmTbUSTf1R7yV+UnEy0pKlNWZZIDGGQpPi7Tv0MGJ0Z
   mQZA27Gy63LaqCCVFt7UMH6mUUXBeE0gR0Ae35Fxr38C4XqRqgbTmIPWV
   jFfxqGr2Ytu2Mlceu8wwua85pYjXmtB0H3HvKfaXVdJ9uIFmQIbCDUkLQ
   qfJsJ7/tqm81YNNg2Mu+s6+F2oS0ZLpGA7nXg/PEtiY/Fu9h21Mn1Hfnt
   RUFa7rZkgGGgJtOpEweXd3xY30o/BJTS7GD3jL1y6CHF7Y/ZOBw2REmb/
   cKXl5lSvjbqib0sZJrTcHLuM+JN7m8N5XsahPZdCvUCiVHGB3iBe4PwhY
   g==;
X-CSE-ConnectionGUID: Peo2D4MITG2Pzsvo4Ede4A==
X-CSE-MsgGUID: CFa+umnmTpSnj4vE9/fCiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="41574842"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="41574842"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:21:17 -0700
X-CSE-ConnectionGUID: CHlNj0UQRi+imeKHeudEiw==
X-CSE-MsgGUID: 2JD8MfOZRU+hKE60SVjGfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43085338"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:21:17 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org,
	kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v2 0/3] vfio/pci: Allow MMIO regions to be exported through dma-buf
Date: Sun, 23 Jun 2024 23:53:08 -0700
Message-ID: <20240624065552.1572580-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an attempt to revive the patches posted by Jason Gunthorpe at:
https://patchwork.kernel.org/project/linux-media/cover/0-v2-472615b3877e+28f7-vfio_dma_buf_jgg@nvidia.com/

Here is the cover letter text from Jason's original series:
"dma-buf has become a way to safely acquire a handle to non-struct page
memory that can still have lifetime controlled by the exporter. Notably
RDMA can now import dma-buf FDs and build them into MRs which allows for
PCI P2P operations. Extend this to allow vfio-pci to export MMIO memory
from PCI device BARs.

This series supports a use case for SPDK where a NVMe device will be owned
by SPDK through VFIO but interacting with a RDMA device. The RDMA device
may directly access the NVMe CMB or directly manipulate the NVMe device's
doorbell using PCI P2P.

However, as a general mechanism, it can support many other scenarios with
VFIO. I imagine this dmabuf approach to be usable by iommufd as well for
generic and safe P2P mappings."

In addition to the SPDK use-case mentioned above, the capability added
in this patch series can also be useful when a buffer (located in device
memory such as VRAM) needs to be shared between any two dGPU devices or
instances (assuming one of them is bound to VFIO PCI) as long as they
are P2P DMA compatible.

The original series has been augmented to include a mmap handler to
provide CPU access to the dmabuf and support for creating the dmabuf
from multiple ranges of a region.

Changelog:

v1 -> v2:
- Rebase on 6.10-rc4
- Update the copyright year in dma_buf.c (Zhu Yanjun)
- Check the revoked flag during mmap() and also revoke the mappings
  as part of move when access to the MMIO space is disabled (Alex)
- Include VM_ALLOW_ANY_UNCACHED and VM_IO flags for mmap (Alex)
- Fix memory leak of ranges when creation of priv fails (Alex)
- Check return value of vfio_device_try_get_registration() (Alex)
- Invoke dma_buf move for runtime PM and FLR cases as well (Alex)
- Add a separate patch to have all the feature functions take
  the core device pointer instead of the main device ptr (Alex)
- Use the regular DMA APIs (that were part of original series) instead
  of PCI P2P DMA APIs while mapping the dma_buf (Jason)
- Rename the region's ranges from p2p_areas to dma_ranges (Jason)
- Add comments in vfio_pci_dma_buf_move() to describe how the locking
  is expected to work (Jason)

This series is available at:
https://gitlab.freedesktop.org/Vivek/drm-tip/-/commits/vfio_dmabuf_2

along with additional patches for Qemu and Spice here:
https://gitlab.freedesktop.org/Vivek/qemu/-/commits/vfio_dmabuf_2
https://gitlab.freedesktop.org/Vivek/spice/-/commits/encode_dmabuf_v8

This series is tested using the following method:
- Run Qemu with the following relevant options:
  qemu-system-x86_64 -m 4096m ....
  -device vfio-pci,host=0000:03:00.0
  -device virtio-vga,max_outputs=1,blob=true,xres=1920,yres=1080
  -spice port=3001,gl=on,disable-ticketing=on,preferred-codec=gstreamer:h264
  -object memory-backend-memfd,id=mem1,size=4096M
  -machine memory-backend=mem1 ...
- Run upstream Weston with the following options in the Guest VM:
  ./weston --drm-device=card1 --additional-devices=card0

where card1 is a DG2 dGPU (assigned to vfio-pci and using xe driver
in Guest VM), card0 is virtio-gpu.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>

Vivek Kasireddy (3):
  vfio: Export vfio device get and put registration helpers
  vfio/pci: Share the core device pointer while invoking feature
    functions
  vfio/pci: Allow MMIO regions to be exported through dma-buf

 drivers/vfio/pci/Makefile          |   1 +
 drivers/vfio/pci/dma_buf.c         | 438 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |  22 +-
 drivers/vfio/pci/vfio_pci_core.c   |  50 ++--
 drivers/vfio/pci/vfio_pci_priv.h   |  23 ++
 drivers/vfio/vfio_main.c           |   2 +
 include/linux/vfio.h               |   2 +
 include/linux/vfio_pci_core.h      |   1 +
 include/uapi/linux/vfio.h          |  25 ++
 9 files changed, 542 insertions(+), 22 deletions(-)
 create mode 100644 drivers/vfio/pci/dma_buf.c

-- 
2.45.1


