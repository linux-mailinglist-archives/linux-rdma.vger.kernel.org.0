Return-Path: <linux-rdma+bounces-7018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A6A1131B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 22:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B268188AD54
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3A213236;
	Tue, 14 Jan 2025 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="K3M0+wYB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DB1D516A;
	Tue, 14 Jan 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890353; cv=none; b=HV17Pd6rwq9kj6keiEbXhe95BfVb1rY3C+B+PKyN2ClnankXwji9+09g6HJjlEt5JmcpfsElbAtFzz3jcT4IlU7EJdNsggBDwBhnNlrJO0ckihpqAGKTnnLtEFWJpC6LyAl1PywJC/mo2WMM6qwjySZ8+vkDsPvOam9MLi0cImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890353; c=relaxed/simple;
	bh=Ubtln1nuhXVXdzBoCLl0VVvDm7xPL2/e9NupIy2VLa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV/bdBb5KAButBuTuGNULP32SkQxj6/L6pQUYY3jSnGLNTnNZc3ZNLM1ahEeZHhCtXY/iPNTgtFJrgfGgJkHQ7P3frT9KQQnT4HhyNGMZbJl3tUh7D+acW2bMjhZWCLPQV8DJyThKR8Gf87pwBabc1UXol3nX7NVEhuV4vg0rBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=K3M0+wYB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1736890347;
	bh=Ubtln1nuhXVXdzBoCLl0VVvDm7xPL2/e9NupIy2VLa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K3M0+wYBxdFry5Kj1pyJl7dodunQhyui3WDKInN9IAoVRvGm+hP8KCYwsUrP7rHKc
	 9LkgOtPwWZp7OZSAfmEkTih141b1z2Ddp/EZQs4XpHWbsbhK7Nzkq8uEykQpftwSK8
	 gvJZgpzX3mdmnUNFigasUfrieRrRMAJDd84lrVAQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jan 2025 22:32:14 +0100
Subject: [PATCH 2/2] RDMA/qib: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-sysfs-const-bin_attr-infiniband-v1-2-397aaa94d453@weissschuh.net>
References: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
In-Reply-To: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736890346; l=2654;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ubtln1nuhXVXdzBoCLl0VVvDm7xPL2/e9NupIy2VLa4=;
 b=SXyIae0D/aChk15EqhHVLEWRzdpnfit1rBREp53teSiyLxRbY3hAQbFbNiyjeAjj3DB3snH+s
 e1muhZYRHk2Ctl6hMM4tL85CDxf/cD6zxTinLd9fDrhbCK45wexlRyY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index ba2cd68b53e6c240f1afc65c64012c75ccf488e0..805e37dc7621179c94320759f8259144950c2e68 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -214,8 +214,8 @@ static const struct attribute_group port_linkcontrol_group = {
  * Congestion control table size followed by table entries
  */
 static ssize_t cc_table_bin_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr, char *buf,
-				 loff_t pos, size_t count)
+				 const struct bin_attribute *bin_attr,
+				 char *buf, loff_t pos, size_t count)
 {
 	struct qib_pportdata *ppd = qib_get_pportdata_kobj(kobj);
 	int ret;
@@ -241,7 +241,7 @@ static ssize_t cc_table_bin_read(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
+static const BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
 
 /*
  * Congestion settings: port control, control map and an array of 16
@@ -249,8 +249,8 @@ static BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
  * trigger threshold and the minimum injection rate delay.
  */
 static ssize_t cc_setting_bin_read(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr, char *buf,
-				   loff_t pos, size_t count)
+				   const struct bin_attribute *bin_attr,
+				   char *buf, loff_t pos, size_t count)
 {
 	struct qib_pportdata *ppd = qib_get_pportdata_kobj(kobj);
 	int ret;
@@ -274,9 +274,9 @@ static ssize_t cc_setting_bin_read(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR_RO(cc_setting_bin, PAGE_SIZE);
+static const BIN_ATTR_RO(cc_setting_bin, PAGE_SIZE);
 
-static struct bin_attribute *port_ccmgta_attributes[] = {
+static const struct bin_attribute *const port_ccmgta_attributes[] = {
 	&bin_attr_cc_setting_bin,
 	&bin_attr_cc_table_bin,
 	NULL,
@@ -295,7 +295,7 @@ static umode_t qib_ccmgta_is_bin_visible(struct kobject *kobj,
 static const struct attribute_group port_ccmgta_attribute_group = {
 	.name = "CCMgtA",
 	.is_bin_visible = qib_ccmgta_is_bin_visible,
-	.bin_attrs = port_ccmgta_attributes,
+	.bin_attrs_new = port_ccmgta_attributes,
 };
 
 /* Start sl2vl */

-- 
2.48.0


