Return-Path: <linux-rdma+bounces-5712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C829BA6F3
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D8A1F23046
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45418C03C;
	Sun,  3 Nov 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ELP3bYub"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DF18BB93;
	Sun,  3 Nov 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653485; cv=none; b=a1gXic6p21w7H1Ot2SJkuwl/IYbtzB/RA0/8CEad8UFeliP0JYPSeWmUOvb39r2wAiw6f73S1qn1uF2h68Z/KoJarrqkjLnYSZ6mpoPECqCdosF5swLRPkYGYjsaHS35kHbvSZS1mA0vjkcd4iDnlJlaN+2ZGKLqx5R+gfxMDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653485; c=relaxed/simple;
	bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZ09XCeffZa9c9eUgzzT+FtOM4UFtEwci/UKo0rbFjKk2KdLFW0UwIi7TXtaJWzl8+W9mXacT7+h2M4AK2Bsdx0MpwTsSJ+ZcSuCH5zUoOKdAe24pWgiJwhh7UaXaUngkla7e4BWiBSmsmE0G9HBSZSMK6JiGtpdWOeX38N38w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ELP3bYub; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653478;
	bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ELP3bYubSPoehjiKV9LwVGa0LECLFMv30PiKWRP+XEfsqygiG8XRoBrNn7C2nyC/C
	 VupEgMPEw5QRr5cyBiVj2Zl8aR/LlWWMGQU+UvLgZt4h9SCxl/glKuJjStidVMK+Uv
	 9gUi0GlcCALNBuvpPYJ2W06Z7+6FuuUB4jD+cpXY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:32 +0000
Subject: [PATCH v2 03/10] PCI/sysfs: Calculate bin_attribute size through
 bin_size()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-3-71110628844c@weissschuh.net>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org, 
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=2359;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
 b=QEHmCC4IyJCPeU5OBXq34EhCHkpPKQglOlOaOSow6b0xRNSB6n8UoneN+GL6/CGyBOY6ZhYUm
 LOb4xWNOB8AC0VTvIPxtVY0ZKdQGGSIFQEaRXg1966rzLgUpCbB+31p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Stop abusing the is_bin_visible() callback to calculate the attribute
size. Instead use the new, dedicated bin_size() one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/pci-sysfs.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab78674c5e5906f321bf7a57b742983..040f01b2b999175e8d98b05851edc078bbabbe0d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -818,21 +818,20 @@ static struct bin_attribute *pci_dev_config_attrs[] = {
 	NULL,
 };
 
-static umode_t pci_dev_config_attr_is_visible(struct kobject *kobj,
-					      struct bin_attribute *a, int n)
+static size_t pci_dev_config_attr_bin_size(struct kobject *kobj,
+					   const struct bin_attribute *a,
+					   int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	a->size = PCI_CFG_SPACE_SIZE;
 	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		a->size = PCI_CFG_SPACE_EXP_SIZE;
-
-	return a->attr.mode;
+		return PCI_CFG_SPACE_EXP_SIZE;
+	return PCI_CFG_SPACE_SIZE;
 }
 
 static const struct attribute_group pci_dev_config_attr_group = {
 	.bin_attrs = pci_dev_config_attrs,
-	.is_bin_visible = pci_dev_config_attr_is_visible,
+	.bin_size = pci_dev_config_attr_bin_size,
 };
 
 /*
@@ -1330,21 +1329,26 @@ static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
 					   struct bin_attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	size_t rom_size;
 
 	/* If the device has a ROM, try to expose it in sysfs. */
-	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	if (!rom_size)
+	if (!pci_resource_end(pdev, PCI_ROM_RESOURCE))
 		return 0;
 
-	a->size = rom_size;
-
 	return a->attr.mode;
 }
 
+static size_t pci_dev_rom_attr_bin_size(struct kobject *kobj,
+					const struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_resource_len(pdev, PCI_ROM_RESOURCE);
+}
+
 static const struct attribute_group pci_dev_rom_attr_group = {
 	.bin_attrs = pci_dev_rom_attrs,
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
+	.bin_size = pci_dev_rom_attr_bin_size,
 };
 
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,

-- 
2.47.0


