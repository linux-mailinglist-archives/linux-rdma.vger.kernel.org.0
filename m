Return-Path: <linux-rdma+bounces-1519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE33889EA8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA42029547C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8D16F840;
	Mon, 25 Mar 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUpBhcU4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390D180A75;
	Mon, 25 Mar 2024 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350627; cv=none; b=Y6nZr5ErM9usZlm2BeBY5dzg/Vkc8ZqvU9YTrCTITDes+ilZGCJZjAdUWXlxgAO5HPZA5NlRSWyDDftI1G92mJ/F7kXs6R/6Cd7rEcwtBaJvktfjnSv/eYmkF4A9bXWVO7Bf3uCV/RVriso1k8qS3x4n7fCC+bC0spPIRLzDRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350627; c=relaxed/simple;
	bh=BOO5AFiKarAvKdN17nScbLEokRrc/g2D/BQM9yhP4d4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/PqwWcoxR9Fj2dukxxsnA9cxMn5dkYwG5HfXJ4NM3U9SYpI/qQsQ8GNpcVbvzpIvkJEiYkVePMmKxA4rLJ7lww/SoH+GZum4X4SukNWpOeNfGwoQEu4bSPBfwiL0oNbPwpLVDos8/FEAQdcW4kWMRpcKerWcFfzvGOY5Z67O/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUpBhcU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56255C433C7;
	Mon, 25 Mar 2024 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350626;
	bh=BOO5AFiKarAvKdN17nScbLEokRrc/g2D/BQM9yhP4d4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XUpBhcU4GiganFQWfcpsbaYVp+TsJUR7YCqoseHr5vZC0zMb+B2R5tSiJS9wEGs5i
	 l26JyR1LurvCl22zfC9wlGhYjNiqb1/jW6GwMWiXDulr1ECjCaxKJ8GHElD9typr/r
	 xIr9JRV3OtQWryAMUNEdkuaH/PTVfMxSpYdbaTtPW3CyrD74V8fYHhcIYa/M5LDqsC
	 ilHVHSVTcdeMBjMzZvGW1r4QgrqqyC+auJ1ZQKC5IZwmlSEfiTLs6V3c2PDFCco7c7
	 cHziWs6eB2Saz+fTKwatFYcm6UIv455fJxW0zdPpbBvMfjw0aFu6iR2GhrSOelQsk7
	 nY5UqTzGjEMoQ==
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
Subject: [PATCH 10/28] drm: amdgpu: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:21 +0900
Message-ID: <20240325070944.3600338-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 7e6d09730e6d..d18113017ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -279,7 +279,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	adev->irq.msi_enabled = false;
 
 	if (!amdgpu_msi_ok(adev))
-		flags = PCI_IRQ_LEGACY;
+		flags = PCI_IRQ_INTX;
 	else
 		flags = PCI_IRQ_ALL_TYPES;
 
-- 
2.44.0


