Return-Path: <linux-rdma+bounces-1531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C44889EBF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CA1F3761F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9F174942;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa/X5yWD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605A1802C4;
	Mon, 25 Mar 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350600; cv=none; b=Bq+sjz4gPAsR30Lg6OWNo4CP0Fzc3oilurWYQ4L0TOYEn3ascsufDMenxnXD+0ibkzCttktXYtpa2q88K/r6HEiBPxhl6I9wxAzVs8MAUfj2KzpmJlQx5c+SEcvtq9ple2eW/qSwWSEqHdb6MOuZLuOGczBUVzl1/fsBvnVFJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350600; c=relaxed/simple;
	bh=25LpLFDUK7yCKsArH1FwhXbVER4eRwrvFSgeehcEArs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULmtWOzo1ksRYt1y2LOMHUaYeWym2te7MKEXIrGtFJhQOlsAv6/oQuGRShKUbL006IO29Uba0/fagE/63vihSzqrYLOoc3NxhnCchNn3rCMZdUTV8IeDFgtUVCAXshd3BnfaeVtXyl0H8SICvW4bXZcIgLN46HnAT9rfbiQmfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa/X5yWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8644C433C7;
	Mon, 25 Mar 2024 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350600;
	bh=25LpLFDUK7yCKsArH1FwhXbVER4eRwrvFSgeehcEArs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qa/X5yWDz6dwe5dMyQx+NAYSgAguUFLGgjV7qf/kSfDLz28KlIGCuz4ecgRcuRYEh
	 MhMiBUGzmFjtWmCAW0g9zX1kk2TOIKNVnDVC1T3sPMaChkpUjwVoK66HXkjzQXaxwj
	 obD0t0C9/R5oKN4/8kDBhoa/ji2zAPXTS5eoEIB2xHuTLdip8GhIUzq4NDe0OHtYxO
	 /4MgNB27YKEAwlbKfQlIOeH+HtbNt+CqYPkNeLL6SQY8VeocEspxjnKCMtA8Hcxi7g
	 e0qJ/Vo/kdc3N0oBfTC4d6XUKQkha+tp1pJ6MfAqLplXdY4MJZaC2hvLasDeZ7E+SA
	 lWK7hbwqZQHCg==
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
Subject: [PATCH 03/28] PCI: documentation: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:14 +0900
Message-ID: <20240325070944.3600338-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change all references to PCI_IRQ_LEGACY to PCI_IRQ_INTX in the PCI
documentation to reflect that PCI_IRQ_LEGACY is deprecated.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/PCI/msi-howto.rst                    | 2 +-
 Documentation/PCI/pci.rst                          | 2 +-
 Documentation/translations/zh_CN/PCI/msi-howto.rst | 2 +-
 Documentation/translations/zh_CN/PCI/pci.rst       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index 783d30b7bb42..0692c9aec66f 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -103,7 +103,7 @@ min_vecs argument set to this limit, and the PCI core will return -ENOSPC
 if it can't meet the minimum number of vectors.
 
 The flags argument is used to specify which type of interrupt can be used
-by the device and the driver (PCI_IRQ_LEGACY, PCI_IRQ_MSI, PCI_IRQ_MSIX).
+by the device and the driver (PCI_IRQ_INTX, PCI_IRQ_MSI, PCI_IRQ_MSIX).
 A convenient short-hand (PCI_IRQ_ALL_TYPES) is also available to ask for
 any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
 pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index cced568d78e9..dd7b1c0c21da 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -335,7 +335,7 @@ causes the PCI support to program CPU vector data into the PCI device
 capability registers. Many architectures, chip-sets, or BIOSes do NOT
 support MSI or MSI-X and a call to pci_alloc_irq_vectors with just
 the PCI_IRQ_MSI and PCI_IRQ_MSIX flags will fail, so try to always
-specify PCI_IRQ_LEGACY as well.
+specify PCI_IRQ_INTX as well.
 
 Drivers that have different interrupt handlers for MSI/MSI-X and
 legacy INTx should chose the right one based on the msi_enabled
diff --git a/Documentation/translations/zh_CN/PCI/msi-howto.rst b/Documentation/translations/zh_CN/PCI/msi-howto.rst
index 1b9b5ea790d8..95baadf767e4 100644
--- a/Documentation/translations/zh_CN/PCI/msi-howto.rst
+++ b/Documentation/translations/zh_CN/PCI/msi-howto.rst
@@ -88,7 +88,7 @@ MSI功能。
 如果设备对最小数量的向量有要求，驱动程序可以传递一个min_vecs参数，设置为这个限制，
 如果PCI核不能满足最小数量的向量，将返回-ENOSPC。
 
-flags参数用来指定设备和驱动程序可以使用哪种类型的中断（PCI_IRQ_LEGACY, PCI_IRQ_MSI,
+flags参数用来指定设备和驱动程序可以使用哪种类型的中断（PCI_IRQ_INTX, PCI_IRQ_MSI,
 PCI_IRQ_MSIX）。一个方便的短语（PCI_IRQ_ALL_TYPES）也可以用来要求任何可能的中断类型。
 如果PCI_IRQ_AFFINITY标志被设置，pci_alloc_irq_vectors()将把中断分散到可用的CPU上。
 
diff --git a/Documentation/translations/zh_CN/PCI/pci.rst b/Documentation/translations/zh_CN/PCI/pci.rst
index 83c2a41d38d3..347f5c3f5ce9 100644
--- a/Documentation/translations/zh_CN/PCI/pci.rst
+++ b/Documentation/translations/zh_CN/PCI/pci.rst
@@ -304,7 +304,7 @@ MSI-X可以分配几个单独的向量。
 的PCI_IRQ_MSI和/或PCI_IRQ_MSIX标志来启用MSI功能。这将导致PCI支持将CPU向量数
 据编程到PCI设备功能寄存器中。许多架构、芯片组或BIOS不支持MSI或MSI-X，调用
 ``pci_alloc_irq_vectors`` 时只使用PCI_IRQ_MSI和PCI_IRQ_MSIX标志会失败，
-所以尽量也要指定 ``PCI_IRQ_LEGACY`` 。
+所以尽量也要指定 ``PCI_IRQ_INTX`` 。
 
 对MSI/MSI-X和传统INTx有不同中断处理程序的驱动程序应该在调用
 ``pci_alloc_irq_vectors`` 后根据 ``pci_dev``结构体中的 ``msi_enabled``
-- 
2.44.0


