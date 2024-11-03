Return-Path: <linux-rdma+bounces-5716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD51E9BA706
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 18:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8481A1F2388B
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F46AD2D;
	Sun,  3 Nov 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="je9uI76l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505218BC05;
	Sun,  3 Nov 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653486; cv=none; b=Zz+WPkP96qVS3AaJZPnF+1gB8qjmO6WM+tdgsF6geIOZxT0H8LF4FMEZT90nNVH5S1XptV0r1MC9mjA5FNhxcjd4Q/3Nioh2M9meX+FwXnQ/IBpG6jtq00h5dmEmicKD0/OWwDlFkRxz+WfhRvpssT46d0rUadlh4YYwnJ9nww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653486; c=relaxed/simple;
	bh=vzqsMVfnVQ7g+xXQgYvHKh8WFOGMi08tymfd1lvAle8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVs+qYp/nmA3OGaq9vd0mrAFPhuj89u6vrpQYzqzg2+S1z/OMLfW+z17ddvn/kTQkWGQXKtM46DZtnHZbRQAqo6Utl9bGOghgXDUGjzk/VLTXZJBe3vFXBXNpMsMaXN6H63WUy+B3sM4fxw61dHROMUCgNEvdqBmjL3nYKqaj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=je9uI76l; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653482;
	bh=vzqsMVfnVQ7g+xXQgYvHKh8WFOGMi08tymfd1lvAle8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=je9uI76lLR4y9OXxsJTuqI38lHi8HkhGJIFV6ZCs4146zr8UDcocsdPRPe5LeFYf8
	 /nzEaxpdd3g714OGoLTEVmDBSxSym4/0fJdP/ILanUgGd1lsKi+YxvHlrL3KGnTUxy
	 25OKvRhJ/iyvI2r1fL0kAV2rjeU/P1lDltJe/xCQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:31 +0000
Subject: [PATCH v2 02/10] sysfs: introduce callback
 attribute_group::bin_size
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-2-71110628844c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=2296;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vzqsMVfnVQ7g+xXQgYvHKh8WFOGMi08tymfd1lvAle8=;
 b=+c8c3AK6YNFtR/f5MlFDxfac5E4AdcTfe/LYH8cKiLv+aN2C4MrR8vpsa2SsTXy5NHtfEpdBh
 t4Y6vgc31e8BINAGXwLU2VEDayYxRmKzGs5LRvtEfi4Ux875Z1qlOu8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Several drivers need to dynamically calculate the size of an binary
attribute. Currently this is done by assigning attr->size from the
is_bin_visible() callback.

This has drawbacks:
* It is not documented.
* A single attribute can be instantiated multiple times, overwriting the
  shared size field.
* It prevents the structure to be moved to read-only memory.

Introduce a new dedicated callback to calculate the size of the
attribute.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/group.c      | 2 ++
 include/linux/sysfs.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 45b2e92941da1f49dcc71af3781317c61480c956..8b01a7eda5fb3239e138372417d01967c7a3f122 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -98,6 +98,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 				if (!mode)
 					continue;
 			}
+			if (grp->bin_size)
+				size = grp->bin_size(kobj, *bin_attr, i);
 
 			WARN(mode & ~(SYSFS_PREALLOC | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c4e64dc112063f7cb89bf66059d0338716089e87..4746cccb95898b24df6f53de9421ea7649b5568f 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -87,6 +87,11 @@ do {							\
  *		SYSFS_GROUP_VISIBLE() when assigning this callback to
  *		specify separate _group_visible() and _attr_visible()
  *		handlers.
+ * @bin_size:
+ *		Optional: Function to return the size of a binary attribute
+ *		of the group. Will be called repeatedly for each binary
+ *		attribute in the group. Overwrites the size field embedded
+ *		inside the attribute itself.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -97,6 +102,9 @@ struct attribute_group {
 					      struct attribute *, int);
 	umode_t			(*is_bin_visible)(struct kobject *,
 						  struct bin_attribute *, int);
+	size_t			(*bin_size)(struct kobject *,
+					    const struct bin_attribute *,
+					    int);
 	struct attribute	**attrs;
 	struct bin_attribute	**bin_attrs;
 };

-- 
2.47.0


