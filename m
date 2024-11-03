Return-Path: <linux-rdma+bounces-5713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8679BA6F8
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458111C216B0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEF18C930;
	Sun,  3 Nov 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TONv6hNY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665418BBA3;
	Sun,  3 Nov 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653485; cv=none; b=HE6pgGZMl6KplpY1gw58AMYNx7ibcvEvGasnTOvIdvjjw6A8Nn2tB7UoNeh66QyunkX5dCoqs7hd5jV/97cPGokJSno2IGSb8uFU/3/Wszl+W6fQdrnu7kQ28x6LXIYJefVo1KdtbV7VubHIVPa73b2vCMd7wqBkebdOqR3mzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653485; c=relaxed/simple;
	bh=Knwg+Z2CkMm4IK1d+HsEFrKnqSyqDlXFkrBwo+TwWXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDuj+utISlNTKbO4lK02EdjFu7Af5G2VMVX4PHWAV+aCc+VWZmr0Z90dZbbSfrn8OqsAILEyUQzUI9M7z3e0TkaBQ+bQ/UKevaE6YgOBr6dP38esIkqEj2J5nrmYo1chG5aFjeMeTJbIJLJhRgM0FEx4p3pwKQdacSeiFZWhb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TONv6hNY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653480;
	bh=Knwg+Z2CkMm4IK1d+HsEFrKnqSyqDlXFkrBwo+TwWXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TONv6hNY4AEVVeYa1wAXVcccuLRstwqknXThdzM9t+2fLKSDfr6hOT9tkgsug1A0R
	 NQmPlMzUKxHgxqKaUcuzhx8QEk1xWpSBNDdcvPixAP6olLbraqAsAKdcjrcKNYe27q
	 9VoKF1eN13NjIkU6TSC12VKX/ebe7oE07QuN/730=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:36 +0000
Subject: [PATCH v2 07/10] sysfs: treewide: constify attribute callback of
 bin_attribute::llseek()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-7-71110628844c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=1737;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Knwg+Z2CkMm4IK1d+HsEFrKnqSyqDlXFkrBwo+TwWXc=;
 b=7BBy1cB2402AMdsGbWDhocbKrbJW2MgG/pXJPZgbbTP5a7oCuUuoE2vbVvQiK5iVSTaOOfRv6
 UmT00qXCNvtDaYwwoMp7tKP4VGZJJQhLqLk6CjFCbnS/F84qc7ejcEm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The llseek() callbacks should not modify the struct
bin_attribute passed as argument.
Enforce this by marking the argument as const.

As there are not many callback implementers perform this change
throughout the tree at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/pci-sysfs.c | 2 +-
 include/linux/sysfs.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0ad3427228b12aa95325c6fc00e9686740559238..49bee70f7d375bca056476acd6528d19ead2c419 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -841,7 +841,7 @@ static const struct attribute_group pci_dev_config_attr_group = {
 static __maybe_unused loff_t
 pci_llseek_resource(struct file *filep,
 		    struct kobject *kobj __always_unused,
-		    struct bin_attribute *attr,
+		    const struct bin_attribute *attr,
 		    loff_t offset, int whence)
 {
 	return fixed_size_llseek(filep, offset, whence, attr->size);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 9fcdc8cd3118f359742bfd8b708d5c3eff511042..cb2a5e277c2384f2e8add8fbf2907e8a819576ec 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -307,7 +307,7 @@ struct bin_attribute {
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
 			 char *, loff_t, size_t);
-	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
+	loff_t (*llseek)(struct file *, struct kobject *, const struct bin_attribute *,
 			 loff_t, int);
 	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,
 		    struct vm_area_struct *vma);

-- 
2.47.0


