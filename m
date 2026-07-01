Return-Path: <linux-rdma+bounces-22659-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fe49IKstRWoN8QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22659-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 17:09:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7656EF1FE
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 17:09:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RI7M2kOe;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22659-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22659-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D61F303BB3E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5593B3C0D;
	Wed,  1 Jul 2026 15:05:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F153FC5A5
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 15:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918340; cv=none; b=WmdYukPaFS2cDLsK02SwAghBna70MQzPbFhTvi9i6TUU0sLLQWi+kpi6pa33u8xNfcLd9OIvaMLCcenlQ/NfN+IIZIdRlItKgMQ45k62EjdHSPHKlSCErR0tPCzgoQujQgOr1J2CuenDM9PnwQGsFziHxzC9CAaJRk60WrAeWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918340; c=relaxed/simple;
	bh=xYNdTWnXeripZYYz6mSqBnuyLPvpALUISenCFbR+cAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UECsPcIaHLl+f3oJgTUtEbziGB7Hsvu0QjmHTM4Nac/eUYLpbrq2gvTUY3pmrrWMLp/vPo85U9/l3lj99zT8GwQKRs7YJtiXQmz1e0V25qt3NfT1KLtfyaM31PqdfYNTY9jU57C3hSMPD5XLHg4y024Ww+AlikLrOzvUBJr0yuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RI7M2kOe; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782918335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MimyNnXScLG49di/SrvtVWpajaYcqU0fepgLz8t+KfQ=;
	b=RI7M2kOeGc6na+tD/A3r5mouOqC56KucRfgEIc9C56hzrLdkVaUgIRoyOv0dO++4NNuOvu
	OcED+1Or0Fbdk+yHgvTuLwSvqxeYduAolijbPItbqPCGMxzjoJgPickR8+bl5A4oRowdMY
	w26q90ZSl4xSytz1R0zU/gRNh9kcIb4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-qKUGUe9OOemZfUE3VzhPeg-1; Wed,
 01 Jul 2026 11:05:32 -0400
X-MC-Unique: qKUGUe9OOemZfUE3VzhPeg-1
X-Mimecast-MFC-AGG-ID: qKUGUe9OOemZfUE3VzhPeg_1782918331
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EA8D1944B10;
	Wed,  1 Jul 2026 15:05:31 +0000 (UTC)
Received: from mschmidt-thinkpadp1gen4i.tpbc.com (unknown [10.44.33.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90B7E1955D53;
	Wed,  1 Jul 2026 15:05:29 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH for-next] RDMA/hfi1: Remove unused non-user-accessible device class
Date: Wed,  1 Jul 2026 17:05:10 +0200
Message-ID: <20260701150510.384858-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22659-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mschmidt@redhat.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA7656EF1FE

The driver defines two device classes: "hfi1" (mode 0600) and
"hfi1_user" (mode 0666), selected by a user_accessible parameter to
hfi1_cdev_init(). The only caller always passes user_accessible=true,
so the "hfi1" class is registered but never used.

The 0600 class was originally used by the diagnostics UI char device
(hfi1_ui*), but that was removed over 10 years ago in commit
7312f29d8ee5 ("IB/hfi1: Remove UI char device"). The class and the
user_accessible parameter were left behind.

Remove the unused class and the user_accessible parameter.

Now that there's only one class, it might make sense to change its name
from "hfi1_user" to just "hfi1", but not knowing whether userspace would
mind, keep the name as is.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/infiniband/hw/hfi1/device.c   | 32 ++-------------------------
 drivers/infiniband/hw/hfi1/device.h   |  1 -
 drivers/infiniband/hw/hfi1/file_ops.c |  2 +-
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index a98a4175e53b..adcfb80d52d4 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -10,18 +10,6 @@
 #include "hfi.h"
 #include "device.h"
 
-static char *hfi1_devnode(const struct device *dev, umode_t *mode)
-{
-	if (mode)
-		*mode = 0600;
-	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
-}
-
-static const struct class class = {
-	.name = "hfi1",
-	.devnode = hfi1_devnode,
-};
-
 static char *hfi1_user_devnode(const struct device *dev, umode_t *mode)
 {
 	if (mode)
@@ -38,7 +26,6 @@ static dev_t hfi1_dev;
 int hfi1_cdev_init(int minor, const char *name,
 		   const struct file_operations *fops,
 		   struct cdev *cdev, struct device **devp,
-		   bool user_accessible,
 		   struct kobject *parent)
 {
 	const dev_t dev = MKDEV(MAJOR(hfi1_dev), minor);
@@ -57,10 +44,7 @@ int hfi1_cdev_init(int minor, const char *name,
 		goto done;
 	}
 
-	if (user_accessible)
-		device = device_create(&user_class, NULL, dev, NULL, "%s", name);
-	else
-		device = device_create(&class, NULL, dev, NULL, "%s", name);
+	device = device_create(&user_class, NULL, dev, NULL, "%s", name);
 
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
@@ -100,33 +84,21 @@ int __init dev_init(void)
 	ret = alloc_chrdev_region(&hfi1_dev, 0, HFI1_NMINORS, DRIVER_NAME);
 	if (ret < 0) {
 		pr_err("Could not allocate chrdev region (err %d)\n", -ret);
-		goto done;
-	}
-
-	ret = class_register(&class);
-	if (ret) {
-		pr_err("Could not create device class (err %d)\n", -ret);
-		unregister_chrdev_region(hfi1_dev, HFI1_NMINORS);
-		goto done;
+		return ret;
 	}
 
 	ret = class_register(&user_class);
 	if (ret) {
 		pr_err("Could not create device class for user accessible files (err %d)\n",
 		       -ret);
-		class_unregister(&class);
 		unregister_chrdev_region(hfi1_dev, HFI1_NMINORS);
-		goto done;
 	}
 
-done:
 	return ret;
 }
 
 void dev_cleanup(void)
 {
-	class_unregister(&class);
 	class_unregister(&user_class);
-
 	unregister_chrdev_region(hfi1_dev, HFI1_NMINORS);
 }
diff --git a/drivers/infiniband/hw/hfi1/device.h b/drivers/infiniband/hw/hfi1/device.h
index a91bea426ba5..3e2d21770e6c 100644
--- a/drivers/infiniband/hw/hfi1/device.h
+++ b/drivers/infiniband/hw/hfi1/device.h
@@ -9,7 +9,6 @@
 int hfi1_cdev_init(int minor, const char *name,
 		   const struct file_operations *fops,
 		   struct cdev *cdev, struct device **devp,
-		   bool user_accessible,
 		   struct kobject *parent);
 void hfi1_cdev_cleanup(struct cdev *cdev, struct device **devp);
 const char *class_name(void);
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 56031becb273..dc548e6802e2 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1689,7 +1689,7 @@ static int user_add(struct hfi1_devdata *dd)
 	snprintf(name, sizeof(name), "%s_%d", class_name(), dd->unit);
 	ret = hfi1_cdev_init(dd->unit, name, &hfi1_file_ops,
 			     &dd->user_cdev, &dd->user_device,
-			     true, &dd->verbs_dev.rdi.ibdev.dev.kobj);
+			     &dd->verbs_dev.rdi.ibdev.dev.kobj);
 	if (ret)
 		user_remove(dd);
 
-- 
2.54.0


