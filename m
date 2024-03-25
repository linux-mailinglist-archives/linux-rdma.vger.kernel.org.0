Return-Path: <linux-rdma+bounces-1510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F448889F51
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0AE2E0093
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA712883D;
	Mon, 25 Mar 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/+LXerr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F2181305;
	Mon, 25 Mar 2024 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350653; cv=none; b=K7IhsjEBlACBe3e75Hr1NcIkD7rz8q0ppu1VUBcRJTEuoWkMY4dZQzuRXTTsxiqhpF15wEOI9rTun04WW8c0HPQEcGSrTP/EcidtO2DxLYS+cVQJdPNXx2eq2emmLqvInoFD6Tq9EDDVq3xWIlShY/oAIQIQohq+kozDCFVkC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350653; c=relaxed/simple;
	bh=L9+oMgTqns9sw9ne/My/DZdwn60k6w1jk+fymbaNaYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IStUSYMqhKSJvitKT0tVdguACEAUJYVWwaKcjSyLDxMFohP8N+/h7u562c5GXBjOaxiq5989aeVjftDovPpTocEK0Gt4VATtVXnadBaLFa8xcyW3ZQAq3jZ546QDCHjmsNvyAyb6vTRQZON5vnL11BsPkdlsayzP/572jXD3Hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/+LXerr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49E2C433C7;
	Mon, 25 Mar 2024 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350653;
	bh=L9+oMgTqns9sw9ne/My/DZdwn60k6w1jk+fymbaNaYE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s/+LXerrViBpnwV64FJRv7v83te1MPyMxomjHLvPDg/M1H1aOVEJ0hSAHGUv+riMl
	 R8MjtDZABIUAZjV7OAFyndyVVnE0jRIQ6ekZMJvqX9M7y8clwA4+Xgym6OmUvDYQjK
	 glW3Sc8DN/6jtzxPlP1XHWs4YyTJlY2mQBIPPu3oFiYovgLwB/sjGFQDHSBhU8Mg+6
	 6lh6wernnvtghNv84/NCrQwZJKR2SFsEKwiCN49vhL84wcaGHJXGBG1EsJ/ZEFrwDY
	 RsTgnbN7NI/RWAekJ1A7+P8iodcmZfevRfAssCW1980tgPJ8fJknHKzZkuYb4Yfr3c
	 YS/hXzUDvbb9A==
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
Subject: [PATCH 17/28] net: realtek: r8169: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:28 +0900
Message-ID: <20240325070944.3600338-18-dlemoal@kernel.org>
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
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5c879a5c86d7..7288afcc8c94 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5076,7 +5076,7 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		rtl_lock_config_regs(tp);
 		fallthrough;
 	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
-		flags = PCI_IRQ_LEGACY;
+		flags = PCI_IRQ_INTX;
 		break;
 	default:
 		flags = PCI_IRQ_ALL_TYPES;
-- 
2.44.0


