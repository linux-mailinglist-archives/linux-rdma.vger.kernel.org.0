Return-Path: <linux-rdma+bounces-1994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7F8ABD02
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Apr 2024 22:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A74B209FD
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Apr 2024 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857C446D5;
	Sat, 20 Apr 2024 20:05:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF421E552;
	Sat, 20 Apr 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643506; cv=none; b=KFNzOnLqeU3WHpwgRYuIQFdJyyyWTkgjRP/Nrn7BOq7vOkYj0rSv2A0TuuGCnl7YhaFfefu9Fa//tFrySSgenI2FtqXPxt3f3xFQRZkwlyg77VlENB+pHGwocz4SIKVByevVvhMT4taNwoLuhwmQIEFOIy6ZUgyexh/1nbWIM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643506; c=relaxed/simple;
	bh=tZW+d2o3rJTJsOwQCingLnGoWaHIDq1joNIfMmZASPg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=CxjYB3ln7bF1FtmKVYYrG+njAK2Q12FhJ3/kztAoh8CFoB2Qtm3U/6q9F6eiJ/1wqv62Hewnf1zFcNUeEycM1MsJn4mokGuRmATFI7Ca6Q8M3/ypxsk84nvhVRsycYRMjJqLWy/vLXiec6HigYPuK/1IGT9IXiLVPgwjjNrHFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6075330008CA3;
	Sat, 20 Apr 2024 22:05:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 59FA8120701; Sat, 20 Apr 2024 22:05:02 +0200 (CEST)
Message-ID: <185a88dd3e6e18bf508a875d87c95ea2a5c3fa13.1713608122.git.lukas@wunner.de>
In-Reply-To: <cover.1713608122.git.lukas@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 20 Apr 2024 22:00:03 +0200
Subject: [PATCH 3/6] IB/qib: Use device_show_string() helper for sysfs
 attributes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Deduplicate sysfs ->show() callbacks which expose a string at a static
memory location.  Use the newly introduced device_show_string() helper
in the driver core instead by declaring those sysfs attributes with
DEVICE_STRING_ATTR_RO().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/infiniband/hw/qib/qib.h        |  1 -
 drivers/infiniband/hw/qib/qib_driver.c |  6 ------
 drivers/infiniband/hw/qib/qib_sysfs.c  | 10 ++--------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 26c615772be3..8ee4edd7883c 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1359,7 +1359,6 @@ static inline u32 qib_get_rcvhdrtail(const struct qib_ctxtdata *rcd)
  * sysfs interface.
  */
 
-extern const char ib_qib_version[];
 extern const struct attribute_group qib_attr_group;
 extern const struct attribute_group *qib_attr_port_groups[];
 
diff --git a/drivers/infiniband/hw/qib/qib_driver.c b/drivers/infiniband/hw/qib/qib_driver.c
index bf3fa12fe935..4fcbef99e400 100644
--- a/drivers/infiniband/hw/qib/qib_driver.c
+++ b/drivers/infiniband/hw/qib/qib_driver.c
@@ -44,12 +44,6 @@
 
 #include "qib.h"
 
-/*
- * The size has to be longer than this string, so we can append
- * board/chip information to it in the init code.
- */
-const char ib_qib_version[] = QIB_DRIVER_VERSION "\n";
-
 DEFINE_MUTEX(qib_mutex);	/* general driver use */
 
 unsigned qib_ibmtu;
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 41c272980f91..53ec7510e4eb 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -585,13 +585,7 @@ static ssize_t hca_type_show(struct device *device,
 static DEVICE_ATTR_RO(hca_type);
 static DEVICE_ATTR(board_id, 0444, hca_type_show, NULL);
 
-static ssize_t version_show(struct device *device,
-			    struct device_attribute *attr, char *buf)
-{
-	/* The string printed here is already newline-terminated. */
-	return sysfs_emit(buf, "%s", (char *)ib_qib_version);
-}
-static DEVICE_ATTR_RO(version);
+static DEVICE_STRING_ATTR_RO(version, 0444, QIB_DRIVER_VERSION);
 
 static ssize_t boardversion_show(struct device *device,
 				 struct device_attribute *attr, char *buf)
@@ -721,7 +715,7 @@ static struct attribute *qib_attributes[] = {
 	&dev_attr_hw_rev.attr,
 	&dev_attr_hca_type.attr,
 	&dev_attr_board_id.attr,
-	&dev_attr_version.attr,
+	&dev_attr_version.attr.attr,
 	&dev_attr_nctxts.attr,
 	&dev_attr_nfreectxts.attr,
 	&dev_attr_serial.attr,
-- 
2.43.0


