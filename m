Return-Path: <linux-rdma+bounces-1515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507F889EA1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3831F2EC43
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC914B097;
	Mon, 25 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE/7hIf4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637717F392;
	Mon, 25 Mar 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350589; cv=none; b=jXBZJ1+KbfrRXyBjnPMCeCNSRXu8Tvo8slJLIgomnHd/EEZpiYdygxkqdazrOacidZVMEnvluvkkZXtKAcvR+QJqSX67fbXRSi1rZuY65W9XlIya3qwcXEkhg8XrXy/tHfL7uihtVClBbTuz0so4g4T0jKLeakwwGTbeLcq+dAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350589; c=relaxed/simple;
	bh=dGJkJbFdBqM1o9IeFZ+PlOQFJCVwRbT/Iii7yFVFMSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XDYBAoZaCPis8y3DEnsXsrSM0trJV9sr2/VkpCkwR28fKJCQq4WRLYybrydHxEXccBzh3Txrs82BW+U5L7bemhxNFTcgm3BazX1JDo7xqFqwlwZ0pLnuj9cdYwhk1yTQItiO59ylIs2OPKsEkcx7Lp7w1tNdLgCQ1UEm82UhtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE/7hIf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7946AC433F1;
	Mon, 25 Mar 2024 07:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350588;
	bh=dGJkJbFdBqM1o9IeFZ+PlOQFJCVwRbT/Iii7yFVFMSI=;
	h=From:To:Subject:Date:From;
	b=QE/7hIf4k1WdMYvCLYH6NWECK80CO9rFwUlKJkwfZ3wfMTBHrGASomESh4jVHXrIM
	 QpknjzOPFaMLXXYDFsWUzeEjTgmzhhGoh2uEYo6ZaDnMv9KkNibR5UwQMPbzQWhjge
	 4U/VOeJdCnGli7BcYDHsW1gEbczyXFxPW6Ouc/cZG194BBgVdKEra/Ri8v12n71hRy
	 yxHTeeLcfPlZ0eYRVyOfM4PT0y5mXYStStFcX/563oqrleQ+x1z/BtOj2RklJxNr4G
	 lE24FyJC+G1TiuwTkDXCNeL044b8fAkOJt1ES3F/I+1YxhlZB4bkmFEMKHpzoaZvPC
	 5yzMMFW9kDEcg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/28] Remove PCI_IRQ_LEGACY
Date: Mon, 25 Mar 2024 16:09:11 +0900
Message-ID: <20240325070944.3600338-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes the use of the depracated PCI_IRQ_LEGACY macro
and replace it with PCI_IRQ_INTX. No functional change.

Damien Le Moal (28):
  PCI: msi: Use PCI_IRQ_INTX
  PCI: portdrv: Use PCI_IRQ_INTX
  PCI: documentation: Use PCI_IRQ_INTX
  sound: intel: Use PCI_IRQ_INTX
  usb: hcd-pci: Use PCI_IRQ_INTX
  tty: 8250_pci: Use PCI_IRQ_INTX
  platform: intel_ips: Use PCI_IRQ_INTX
  ntb: Use PCI_IRQ_INTX
  mfd: intel-lpss-pci: Use PCI_IRQ_INTX
  drm: amdgpu: Use PCI_IRQ_INTX
  infiniband: qib: Use PCI_IRQ_INTX
  infiniband: vmw_pvrdma: Use PCI_IRQ_INTX
  misc: vmci_guest: Use PCI_IRQ_ALL_TYPES
  net: xgbe: Use PCI_IRQ_INTX
  net: aquantia atlantic: Use PCI_IRQ_INTX
  net: atheros: alx: Use PCI_IRQ_INTX
  net: realtek: r8169: Use PCI_IRQ_INTX
  net: wangxun: Use PCI_IRQ_INTX
  net: wireless: ath10k: Use references to INTX instead of LEGACY
  net wireless; realtec: Use PCI_IRQ_INTX
  scsi: arcmsr: Use PCI_IRQ_INTX
  scsi: hpsa: Use PCI_IRQ_INTX
  scsi: ipr: Use PCI_IRQ_INTX
  scsi: megaraid: Use PCI_IRQ_INTX
  scsi: mpt3sas: Use PCI_IRQ_INTX
  scsi: pmcraid: Use PCI_IRQ_INTX
  scsi: vmw_pvscsi: Do not use PCI_IRQ_LEGACY
  PCI: Remove PCI_IRQ_LEGACY

 Documentation/PCI/msi-howto.rst               |  2 +-
 Documentation/PCI/pci.rst                     |  2 +-
 .../translations/zh_CN/PCI/msi-howto.rst      |  2 +-
 Documentation/translations/zh_CN/PCI/pci.rst  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c       |  2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c       |  5 ++-
 drivers/infiniband/hw/qib/qib_pcie.c          |  2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  2 +-
 drivers/mfd/intel-lpss-pci.c                  |  2 +-
 drivers/misc/vmw_vmci/vmci_guest.c            |  3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  2 +-
 .../net/ethernet/aquantia/atlantic/aq_cfg.h   |  2 +-
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |  2 +-
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  2 +-
 .../ethernet/aquantia/atlantic/aq_pci_func.c  |  9 ++---
 .../aquantia/atlantic/hw_atl/hw_atl_a0.c      |  2 +-
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      |  2 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       |  2 +-
 drivers/net/ethernet/atheros/alx/main.c       |  2 +-
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  8 ++---
 drivers/net/wireless/ath/ath10k/ahb.c         | 18 +++++-----
 drivers/net/wireless/ath/ath10k/pci.c         | 36 +++++++++----------
 drivers/net/wireless/ath/ath10k/pci.h         |  6 ++--
 drivers/net/wireless/realtek/rtw88/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |  2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c               |  2 +-
 drivers/pci/msi/api.c                         |  8 ++---
 drivers/pci/pcie/portdrv.c                    |  8 ++---
 drivers/platform/x86/intel_ips.c              |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c              |  2 +-
 drivers/scsi/hpsa.c                           |  2 +-
 drivers/scsi/ipr.c                            |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     |  4 +--
 drivers/scsi/mpt3sas/mpt3sas_base.c           |  2 +-
 drivers/scsi/pmcraid.c                        |  2 +-
 drivers/scsi/vmw_pvscsi.c                     |  2 +-
 drivers/tty/serial/8250/8250_pci.c            |  2 +-
 drivers/usb/core/hcd-pci.c                    |  3 +-
 include/linux/pci.h                           |  7 ++--
 sound/soc/intel/avs/core.c                    |  2 +-
 42 files changed, 84 insertions(+), 91 deletions(-)

-- 
2.44.0


