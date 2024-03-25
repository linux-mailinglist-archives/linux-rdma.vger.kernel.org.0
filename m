Return-Path: <linux-rdma+bounces-1544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A382488AE3E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79941C3FBC3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9788B86650;
	Mon, 25 Mar 2024 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fftc+ZYk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4358109;
	Mon, 25 Mar 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389584; cv=none; b=k8MILfWEPXJElGPYSJTA9MIbUT1csKgGk7VL4YFeguCcWDw7Z2NHdoVcABzTXJxQewkzGgwU0WSxZzF6wNpBVORiIAhk5q+ZZXawEL59HcEp5fJ1C9s4gn1irXD3VlLitlWDmoe7YbFBSnz1hcH0i4E+HK1FPFK1P3qNuWiYQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389584; c=relaxed/simple;
	bh=wXPwR8AWQ/l5POkeyRm4pjnxElVQugxHc5xn97XdOt8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mwSWCal1ciRKVbKK1fL+kXJeF/cgGfRZHGrVsDw1g6YRjBYR6QH05A5jE/xYsoUk1gDVeDiQGNP0RiLH2/kn8mwCVE08GtOxxAS9suifmW/w7oxKZ2zf9RcVPrmkvWZQTwXNfWKr/LcImQKuNtL+DKqFdfH9giZUWKnvt/dGViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fftc+ZYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB4DC433C7;
	Mon, 25 Mar 2024 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389583;
	bh=wXPwR8AWQ/l5POkeyRm4pjnxElVQugxHc5xn97XdOt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fftc+ZYkkbAwFHlbCa37SyMisbtr/6H45opy0Mf+j5xkS4yQN6nnqvgzKIwN5cMkS
	 JGU7aXj8A44g1kqohrtMvyr8BQtkUKYBcOayA6qCJgtTMwTf/kelwo9pOgN/8QnLsu
	 UIE6DWfAS1/sVyHXWVKOrMu+RyfOd97ka0hzS3t6wyaEXAFGZi62fjzM3UJynqbbgU
	 H0lYPyz92L3C3sMx1f4eQH4DhoUNr+56b45xuwEGRsR2xenSlkm1nQPE1Iz9puf+bD
	 H1LGwlI9nP2qDWP/0zv6RAwWAEhOMg0Ubz9A62rXnjwgOVqq9DoYLXgjg373B75r7y
	 KgU8mvhg/2W5A==
Date: Mon, 25 Mar 2024 12:59:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/28] Remove PCI_IRQ_LEGACY
Message-ID: <20240325175941.GA1443646@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>

On Mon, Mar 25, 2024 at 04:09:11PM +0900, Damien Le Moal wrote:
> This patch series removes the use of the depracated PCI_IRQ_LEGACY macro
> and replace it with PCI_IRQ_INTX. No functional change.
> 
> Damien Le Moal (28):
>   PCI: msi: Use PCI_IRQ_INTX
>   PCI: portdrv: Use PCI_IRQ_INTX
>   PCI: documentation: Use PCI_IRQ_INTX
>   sound: intel: Use PCI_IRQ_INTX
>   usb: hcd-pci: Use PCI_IRQ_INTX
>   tty: 8250_pci: Use PCI_IRQ_INTX
>   platform: intel_ips: Use PCI_IRQ_INTX
>   ntb: Use PCI_IRQ_INTX
>   mfd: intel-lpss-pci: Use PCI_IRQ_INTX
>   drm: amdgpu: Use PCI_IRQ_INTX
>   infiniband: qib: Use PCI_IRQ_INTX
>   infiniband: vmw_pvrdma: Use PCI_IRQ_INTX
>   misc: vmci_guest: Use PCI_IRQ_ALL_TYPES
>   net: xgbe: Use PCI_IRQ_INTX
>   net: aquantia atlantic: Use PCI_IRQ_INTX
>   net: atheros: alx: Use PCI_IRQ_INTX
>   net: realtek: r8169: Use PCI_IRQ_INTX
>   net: wangxun: Use PCI_IRQ_INTX
>   net: wireless: ath10k: Use references to INTX instead of LEGACY
>   net wireless; realtec: Use PCI_IRQ_INTX
>   scsi: arcmsr: Use PCI_IRQ_INTX
>   scsi: hpsa: Use PCI_IRQ_INTX
>   scsi: ipr: Use PCI_IRQ_INTX
>   scsi: megaraid: Use PCI_IRQ_INTX
>   scsi: mpt3sas: Use PCI_IRQ_INTX
>   scsi: pmcraid: Use PCI_IRQ_INTX
>   scsi: vmw_pvscsi: Do not use PCI_IRQ_LEGACY
>   PCI: Remove PCI_IRQ_LEGACY
> 
>  Documentation/PCI/msi-howto.rst               |  2 +-
>  Documentation/PCI/pci.rst                     |  2 +-
>  .../translations/zh_CN/PCI/msi-howto.rst      |  2 +-
>  Documentation/translations/zh_CN/PCI/pci.rst  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
>  drivers/infiniband/hw/qib/qib_iba7220.c       |  2 +-
>  drivers/infiniband/hw/qib/qib_iba7322.c       |  5 ++-
>  drivers/infiniband/hw/qib/qib_pcie.c          |  2 +-
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  2 +-
>  drivers/mfd/intel-lpss-pci.c                  |  2 +-
>  drivers/misc/vmw_vmci/vmci_guest.c            |  3 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  2 +-
>  .../net/ethernet/aquantia/atlantic/aq_cfg.h   |  2 +-
>  .../net/ethernet/aquantia/atlantic/aq_hw.h    |  2 +-
>  .../net/ethernet/aquantia/atlantic/aq_nic.c   |  2 +-
>  .../ethernet/aquantia/atlantic/aq_pci_func.c  |  9 ++---
>  .../aquantia/atlantic/hw_atl/hw_atl_a0.c      |  2 +-
>  .../aquantia/atlantic/hw_atl/hw_atl_b0.c      |  2 +-
>  .../aquantia/atlantic/hw_atl2/hw_atl2.c       |  2 +-
>  drivers/net/ethernet/atheros/alx/main.c       |  2 +-
>  drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  8 ++---
>  drivers/net/wireless/ath/ath10k/ahb.c         | 18 +++++-----
>  drivers/net/wireless/ath/ath10k/pci.c         | 36 +++++++++----------
>  drivers/net/wireless/ath/ath10k/pci.h         |  6 ++--
>  drivers/net/wireless/realtek/rtw88/pci.c      |  2 +-
>  drivers/net/wireless/realtek/rtw89/pci.c      |  2 +-
>  drivers/ntb/hw/idt/ntb_hw_idt.c               |  2 +-
>  drivers/pci/msi/api.c                         |  8 ++---
>  drivers/pci/pcie/portdrv.c                    |  8 ++---
>  drivers/platform/x86/intel_ips.c              |  2 +-
>  drivers/scsi/arcmsr/arcmsr_hba.c              |  2 +-
>  drivers/scsi/hpsa.c                           |  2 +-
>  drivers/scsi/ipr.c                            |  2 +-
>  drivers/scsi/megaraid/megaraid_sas_base.c     |  4 +--
>  drivers/scsi/mpt3sas/mpt3sas_base.c           |  2 +-
>  drivers/scsi/pmcraid.c                        |  2 +-
>  drivers/scsi/vmw_pvscsi.c                     |  2 +-
>  drivers/tty/serial/8250/8250_pci.c            |  2 +-
>  drivers/usb/core/hcd-pci.c                    |  3 +-
>  include/linux/pci.h                           |  7 ++--
>  sound/soc/intel/avs/core.c                    |  2 +-
>  42 files changed, 84 insertions(+), 91 deletions(-)

I applied all these to pci/enumeration for v6.10, thanks!

I added acks and reviewed-by and will update if we receive more, and
adjusted subject lines to add "... instead of PCI_IRQ_LEGACY" and in
some cases to match history of the file.

Bjorn

