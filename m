Return-Path: <linux-rdma+bounces-18464-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJiPInVnvWnL9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18464-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:27:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039532DCA75
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F17830C3330
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3673B961D;
	Fri, 20 Mar 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKFNpLfG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87E3C4564;
	Fri, 20 Mar 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019753; cv=none; b=d0aVpwTBVK2sHkrigR0pyJ03MJHcet3wH+nhcpQmL4QWAL4qLvkEJRE0nhKGsblpUQOAKXKByiycCLJ2v4UHCPWJll+wRL87RtapOhx7uhfvDpHvRZyLkt4gfB6LjjVpYUl/DGpAKUDHranOGYj8zOrlsj4AL9h4yYg/L4aYKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019753; c=relaxed/simple;
	bh=nB71Rw44hB+a2c7ZWowvMAQoTvQVtyinquCr8g9mCMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5QHEQujBIeC7ZSJVlC5BOCeYApdlWxGIdT1lpAPTTRRjx7x5NaHWQQQCXP9TNF8yjCQguJCtq1j92pcimyfxcmAsRB8mjDeNy6kWrpwqVnpGpQpfUSyKEBrlRrio74uUP0Uyw1YIBHqnEohFiDAdOTEwkuvXT5hmyXjWElZ8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKFNpLfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69508C4CEF7;
	Fri, 20 Mar 2026 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019753;
	bh=nB71Rw44hB+a2c7ZWowvMAQoTvQVtyinquCr8g9mCMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKFNpLfGp5gdcREBtkfUn97xTbQWcab3fyVHXTFPiiavXW1Pwp+12s4QOX+gc8gr4
	 KQXibq34ozWFnIwWpdRQCndKiTGup6vYhqJYUMrvTLVA9L/j4h9Uf23mnWjNtpisml
	 LvJqffvBrrG/YSQ1vYyhiCaxuahWu/8DDCA1ZhYd50db2nEXGp8vVxmjjAmXTTLesW
	 HLustQodNjD+V/B8lxyUBDC3TJKOt4AppUqs2UOV4rBSWi3o75xLfi06kH2khwWbVx
	 HDBTHaKaBT6dF/n63PfCJzbt5PxNAdt+fFwpsARCOpCBpeXXdvZOk6CmokIsYQMwi/
	 HWyUQtpMZ5WVQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] RDMA/hfi1: reduce namespace pollution
Date: Fri, 20 Mar 2026 16:12:39 +0100
Message-Id: <20260320151511.3420818-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260320151511.3420818-1-arnd@kernel.org>
References: <20260320151511.3420818-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18464-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 039532DCA75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

While looking at an unrelated bug, I noticed that the global "class_name"
function is not suitable for a driver-internal interface. The same
file that declares this also has dev_init() and dev_exit() functions,
which are equally problematic.

Remove the class_name() function entirely and just hardcode the string
where it is used, and rename the other two functions to fit into the
hfi1 namespace.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
The driver contains many more functions that should not be in the global
namespace, but I decided not to fix the other ones. Maybe the maintainers
can continue renaming the rest.
---
 drivers/infiniband/hw/hfi1/debugfs.c  |  2 +-
 drivers/infiniband/hw/hfi1/device.c   | 11 ++---------
 drivers/infiniband/hw/hfi1/device.h   |  5 ++---
 drivers/infiniband/hw/hfi1/file_ops.c |  2 +-
 drivers/infiniband/hw/hfi1/init.c     |  8 ++++----
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index ac37ab7f8995..24346b74d5e0 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1161,7 +1161,7 @@ void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd)
 
 	if (!hfi1_dbg_root)
 		return;
-	snprintf(name, sizeof(name), "%s_%d", class_name(), unit);
+	snprintf(name, sizeof(name), "hfi1_%d", unit);
 	snprintf(link, sizeof(link), "%d", unit);
 	root = debugfs_create_dir(name, hfi1_dbg_root);
 	ibd->hfi1_ibdev_dbg = root;
diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index 1aac6c2f45b4..a26b71867a2a 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -86,14 +86,7 @@ void hfi1_cdev_cleanup(struct cdev *cdev, struct device **devp)
 	}
 }
 
-static const char *hfi1_class_name = "hfi1";
-
-const char *class_name(void)
-{
-	return hfi1_class_name;
-}
-
-int __init dev_init(void)
+int __init hfi1_dev_init(void)
 {
 	int ret;
 
@@ -123,7 +116,7 @@ int __init dev_init(void)
 	return ret;
 }
 
-void dev_cleanup(void)
+void hfi1_dev_cleanup(void)
 {
 	class_unregister(&class);
 	class_unregister(&user_class);
diff --git a/drivers/infiniband/hw/hfi1/device.h b/drivers/infiniband/hw/hfi1/device.h
index a91bea426ba5..d7775f92e0b1 100644
--- a/drivers/infiniband/hw/hfi1/device.h
+++ b/drivers/infiniband/hw/hfi1/device.h
@@ -12,8 +12,7 @@ int hfi1_cdev_init(int minor, const char *name,
 		   bool user_accessible,
 		   struct kobject *parent);
 void hfi1_cdev_cleanup(struct cdev *cdev, struct device **devp);
-const char *class_name(void);
-int __init dev_init(void);
-void dev_cleanup(void);
+int __init hfi1_dev_init(void);
+void hfi1_dev_cleanup(void);
 
 #endif                          /* _HFI1_DEVICE_H */
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 56031becb273..2fe7f7df7d09 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1686,7 +1686,7 @@ static int user_add(struct hfi1_devdata *dd)
 	char name[10];
 	int ret;
 
-	snprintf(name, sizeof(name), "%s_%d", class_name(), dd->unit);
+	snprintf(name, sizeof(name), "hfi1_%d", dd->unit);
 	ret = hfi1_cdev_init(dd->unit, name, &hfi1_file_ops,
 			     &dd->user_cdev, &dd->user_device,
 			     true, &dd->verbs_dev.rdi.ibdev.dev.kobj);
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index fb0a8325a43d..28213ddcf2e9 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1236,7 +1236,7 @@ static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
 	 * to work by setting the name manually here.
 	 */
 	ibdev = &dd->verbs_dev.rdi.ibdev;
-	dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
+	dev_set_name(&ibdev->dev, "hfi1_%d", dd->unit);
 	strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
 
 	/*
@@ -1387,7 +1387,7 @@ static int __init hfi1_mod_init(void)
 {
 	int ret;
 
-	ret = dev_init();
+	ret = hfi1_dev_init();
 	if (ret)
 		goto bail;
 
@@ -1460,7 +1460,7 @@ static int __init hfi1_mod_init(void)
 
 bail_dev:
 	hfi1_dbg_exit();
-	dev_cleanup();
+	hfi1_dev_cleanup();
 bail:
 	return ret;
 }
@@ -1479,7 +1479,7 @@ static void __exit hfi1_mod_cleanup(void)
 
 	WARN_ON(!xa_empty(&hfi1_dev_table));
 	dispose_firmware();	/* asymmetric with obtain_firmware() */
-	dev_cleanup();
+	hfi1_dev_cleanup();
 }
 
 module_exit(hfi1_mod_cleanup);
-- 
2.39.5


