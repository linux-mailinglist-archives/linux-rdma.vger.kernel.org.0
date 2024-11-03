Return-Path: <linux-rdma+bounces-5709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D750B9BA6E2
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BCE1C210F0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9818A6B7;
	Sun,  3 Nov 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jCGf7P5s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71051AD2D;
	Sun,  3 Nov 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653482; cv=none; b=XGoz222FxafVypl8u5eGe5KP+e4OfBnba8e+E4VUo8P0bFqAvyD3Oxg+DDQe1RDDtFGlOgarvEY2+uJyPFEKSrpDfNvc7lVibg0g+mbSW920140I/IjiEBS+8HIzO5yIWD+5on+rYo92TlFyzouiIrI6+/h8mua+/4cvT3KZVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653482; c=relaxed/simple;
	bh=iCkq/n0ScNs19XGEBHP6SQ4H+TMRU4fkw8iLrhzrW/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4oibU+1VeBBkpLHfCHnFTM3r5JjKJM+q5JBZRA09UeqsK/CFRJtVSryxKVfAkcWZ3+4Frq4hGENVLaL7x+A8nCcu52sJ4bV9UzuU6uJGqBDYEpgaOoah8RYqUWshjihaA2lsy6h/bwvkaQX/toJxlJNOJFgvvtRwwLXfy8pY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jCGf7P5s; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730653474;
	bh=iCkq/n0ScNs19XGEBHP6SQ4H+TMRU4fkw8iLrhzrW/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jCGf7P5s53Ta360TJbHbjEX0UBWW3nHAglDu578tyRJB0eZgE5NN8zYQ0kFtr1Svt
	 pCp484/NqdkNGcCiZ9riHzuo/LXlzlPqaqdK9SPb5smzV52zn2yNPWdP3DIa10iyOa
	 KeTiE8N08tCGK9uD6gJjB4S2MSPfd5jAPy1fJsj8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:30 +0000
Subject: [PATCH v2 01/10] sysfs: explicitly pass size to
 sysfs_add_bin_file_mode_ns()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-1-71110628844c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=3118;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iCkq/n0ScNs19XGEBHP6SQ4H+TMRU4fkw8iLrhzrW/Q=;
 b=sZzl6wOvr0Sxq3DUY1GJqR+qhFx4JBDN7tgJGJz8989wTSFCjglU0coA3+lhHK8A4oBqQa8cP
 HbptlDNYnPABVHa2o+5ifoWR29tK6teGa/60gJsy0hPwKXqLXrvxd4C
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Upcoming changes to the sysfs core require the size of the created file
to be overridable by the caller.
Add a parameter to enable this.
For now keep using attr->size in all cases.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/file.c  | 8 ++++----
 fs/sysfs/group.c | 3 ++-
 fs/sysfs/sysfs.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c943a644ff9f34cf2488864d57daf81..6d39696b43069010b0ad0bdaadcf9002cb70c92c 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -315,7 +315,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 }
 
 int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
-		const struct bin_attribute *battr, umode_t mode,
+		const struct bin_attribute *battr, umode_t mode, size_t size,
 		kuid_t uid, kgid_t gid, const void *ns)
 {
 	const struct attribute *attr = &battr->attr;
@@ -340,7 +340,7 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 #endif
 
 	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  battr->size, ops, (void *)attr, ns, key);
+				  size, ops, (void *)attr, ns, key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
@@ -580,8 +580,8 @@ int sysfs_create_bin_file(struct kobject *kobj,
 		return -EINVAL;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	return sysfs_add_bin_file_mode_ns(kobj->sd, attr, attr->attr.mode, uid,
-					   gid, NULL);
+	return sysfs_add_bin_file_mode_ns(kobj->sd, attr, attr->attr.mode,
+					  attr->size, uid, gid, NULL);
 }
 EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
 
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d22ad67a0f3291f4702f494939528d5d13c31fae..45b2e92941da1f49dcc71af3781317c61480c956 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -87,6 +87,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 	if (grp->bin_attrs) {
 		for (i = 0, bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
 			umode_t mode = (*bin_attr)->attr.mode;
+			size_t size = (*bin_attr)->size;
 
 			if (update)
 				kernfs_remove_by_name(parent,
@@ -104,7 +105,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 
 			mode &= SYSFS_PREALLOC | 0664;
 			error = sysfs_add_bin_file_mode_ns(parent, *bin_attr,
-							   mode, uid, gid,
+							   mode, size, uid, gid,
 							   NULL);
 			if (error)
 				break;
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 3f28c9af57562f61a00a47935579f0939cbfd4dc..8e012f25e1c06e802c3138cc2715b46c1f67fa48 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -31,7 +31,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		const struct attribute *attr, umode_t amode, kuid_t uid,
 		kgid_t gid, const void *ns);
 int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
-		const struct bin_attribute *battr, umode_t mode,
+		const struct bin_attribute *battr, umode_t mode, size_t size,
 		kuid_t uid, kgid_t gid, const void *ns);
 
 /*

-- 
2.47.0


