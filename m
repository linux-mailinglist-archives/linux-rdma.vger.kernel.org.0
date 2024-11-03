Return-Path: <linux-rdma+bounces-5708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B0F9BA6E0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0BA280A53
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D518A6B0;
	Sun,  3 Nov 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nF+i3TO1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5617A597;
	Sun,  3 Nov 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653482; cv=none; b=sRUeK3jaPUB1yaKtyEd4UaInJR2R0507nMGvDWHRaMxv+peVyN2n6N7+B2sSr2a2a7ocovRHun/tQ8UjSBghp9gCYHOBfqHMm12BNXQO5ZMosdKocGHW56zLjeFcZMYrH7/Ayri9/3ECmoInHpxilawOxjBv4bnnydLfjIYmlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653482; c=relaxed/simple;
	bh=zDhPVchfMys7HnsVtwZsrXjRXhl5fZsRZ1XGARPtegE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfgqPLxWN0c81iG+Gt15h0UpdJGuJh6IRYvzzXjuX6CS09rcT3jb4fWBwbXho35KEYUmsn+pC+r7fa8qYrymOefJFhLcLuc+YRPeBMfKt4I5TZROGQNhkYOtScgeLhgpPNeUT+qSdLwYAKzd289p+Wp+Yj4IQwzn3DFEaLso3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nF+i3TO1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653478;
	bh=zDhPVchfMys7HnsVtwZsrXjRXhl5fZsRZ1XGARPtegE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nF+i3TO19zkqViLZBPElPKvX/TvhJJeS1cvvIzeKcupp4M59PZzI/dmxNU82/FOOD
	 b1PHpxxOeHOMATRE4iVFCkW9eR13J9JRa9AZRjbs61ruzxDt43px/4jqbxYk0GryTq
	 17bNoP+ivw6mKFg334qDOC+P5FikSoHeR2wGq+Bo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:33 +0000
Subject: [PATCH v2 04/10] nvmem: core: calculate bin_attribute size through
 bin_size()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-4-71110628844c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=1407;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zDhPVchfMys7HnsVtwZsrXjRXhl5fZsRZ1XGARPtegE=;
 b=LIJoZnee0F8KxWypgifoxx5C03UWzUsfKRD3mTuXEg8GZQDzU4bKngbG7gE6mho+vvHyDPpYb
 T0csHWK0CZAA7NKHFKir+h35XqhjNK7+x/o8Rk9YXpQi/8Q7SU3s9Ua
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Stop abusing the is_bin_visible() callback to calculate the attribute
size. Instead use the new, dedicated bin_size() one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c1152398ec66b8dd7b30384c5346a6e..63370c76394ee9b8d514da074779617cef67c311 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -303,11 +303,19 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
-	attr->size = nvmem->size;
-
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
+static size_t nvmem_bin_attr_size(struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return nvmem->size;
+}
+
 static umode_t nvmem_attr_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int i)
 {
@@ -383,6 +391,7 @@ static const struct attribute_group nvmem_bin_group = {
 	.bin_attrs	= nvmem_bin_attributes,
 	.attrs		= nvmem_attrs,
 	.is_bin_visible = nvmem_bin_attr_is_visible,
+	.bin_size	= nvmem_bin_attr_size,
 	.is_visible	= nvmem_attr_is_visible,
 };
 

-- 
2.47.0


