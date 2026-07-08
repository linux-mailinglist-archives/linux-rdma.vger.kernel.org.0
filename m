Return-Path: <linux-rdma+bounces-22884-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BIaYLhYrTmqrEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22884-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:48:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A10477247B2
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CuMG50HZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22884-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22884-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB9C03028B35
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD21432BFE;
	Wed,  8 Jul 2026 10:47:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5A423A72;
	Wed,  8 Jul 2026 10:46:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507630; cv=none; b=pi6AjWdTOB+ftTQ6135T4kROAddQjZmX3TcVsky+permxA92MDrmIcGhNi0dVepUvy0AP3itEutdd2v7Cz5v8mpnBTRW5/cuxOMHcuFmmDp55c68YIFTGmeZnRQH86kGw3Q320EgE+pcO/Qc6nTKhRTHHeI3YR8n72lNGXrqUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507630; c=relaxed/simple;
	bh=G8YKIp4MjPR2gjSoN7tjv0/83LNxK8t8fh17lKL1xdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ph+pemxUn2mQSPktbN0+XkXIGZW7QODChNjEK6Y+O0AvxLzXocMyg9XXvIlz2OigYJQ+GqgGD58ka2+VFA33tVZ5anuMDeKRRRKt3tzzWimvWHSsmp1mpHe8Upe15bLs8UTjxRDzSnt+XLlrNoi2X2kZvUOTgEYjhI/yd+dYKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuMG50HZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FA01F00A3A;
	Wed,  8 Jul 2026 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507617;
	bh=Js4cEaVq+i2IIo3UuwfDpTdf5q+yAx0/nkn6tYzd9QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CuMG50HZ7JBM+3P8b7A0JxnOIk7UOixiI1nauvvF8HkDpH+KOPrNb3w91Ij0r0nOA
	 NDC0xAKgVZ0a6nGhBZVZQ0te+hXkGRlVzoRG5krhDHxilIMNqjxB0byhX0ZRN8V19R
	 caB/kO30XKQzn9A8MejNwjx6Pd9OY6cK8KGu4bedg8HLUWGQI4Mg/4W7PQnfSRhQXE
	 6XV/wq50xrb/6PZcgevQJHIJrJLK8lvP0xJ0jgNw2wnD0ZFSUEHXaoAo6BtfraWsp6
	 lMlsU0h7DlrAorAMtMB0xCkusjjy89mEvd9UhfVqXDhu3XlsJpHwII++bM15qrA5IT
	 Ior/u1hzAGqjA==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Sadanand Warrier <sadanand.warrier@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Dean Luick <dean.luick@intel.com>,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Jubin John <jubin.john@intel.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH rdma-next 04/13] RDMA/hfi1: Pass PCI device to hfi1_pcie_init()
Date: Wed,  8 Jul 2026 13:45:42 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-4-b9e9641268a5@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
References: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:iweiny@kernel.org,m:dledford@redhat.com,m:willy@infradead.org,m:grzegorz.andrejczuk@intel.com,m:mike.marciniszyn@intel.com,m:sadanand.warrier@intel.com,m:michael.j.ruhl@intel.com,m:dean.luick@intel.com,m:sebastian.sanchez@intel.com,m:jubin.john@intel.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dennis.dalessandro@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22884-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A10477247B2

From: Leon Romanovsky <leonro@nvidia.com>

hfi1_pcie_init() only needs hfi1_devdata to reach the PCI device. This
unnecessary dependency prevents common PCI setup from running before
hfi1_devdata is allocated.

Pass pci_dev directly and report failures with dev_err(), preserving the
device BDF needed to identify the failing adapter on multi-device systems.
Use %pe while changing the messages so errno values are decoded.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/hfi.h  |  2 +-
 drivers/infiniband/hw/hfi1/init.c |  2 +-
 drivers/infiniband/hw/hfi1/pcie.c | 12 +++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 5a0310f758dc..95f86a002a3d 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2132,7 +2132,7 @@ void hfi1_verbs_unregister_sysfs(struct hfi1_devdata *dd);
 /* Hook for sysfs read of QSFP */
 int qsfp_dump(struct hfi1_pportdata *ppd, char *buf, int len);
 
-int hfi1_pcie_init(struct hfi1_devdata *dd);
+int hfi1_pcie_init(struct pci_dev *pdev);
 void hfi1_pcie_cleanup(struct pci_dev *pdev);
 int hfi1_pcie_ddinit(struct hfi1_devdata *dd, struct pci_dev *pdev);
 void hfi1_pcie_ddcleanup(struct hfi1_devdata *);
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 7c0383657ad0..a37a875736f7 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1620,7 +1620,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* restrict value of hfi1_rcvarr_split */
 	hfi1_rcvarr_split = clamp_val(hfi1_rcvarr_split, 0, 100);
 
-	ret = hfi1_pcie_init(dd);
+	ret = hfi1_pcie_init(pdev);
 	if (ret)
 		goto bail;
 
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 7133964749f8..7ca8f07ba43e 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -21,10 +21,9 @@
 /*
  * Do all the common PCIe setup and initialization.
  */
-int hfi1_pcie_init(struct hfi1_devdata *dd)
+int hfi1_pcie_init(struct pci_dev *pdev)
 {
 	int ret;
-	struct pci_dev *pdev = dd->pcidev;
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
@@ -40,13 +39,15 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 		 * about that, it appears.  If the original BAR was retained
 		 * in the kernel data structures, this may be OK.
 		 */
-		dd_dev_err(dd, "pci enable failed: error %d\n", -ret);
+		dev_err(&pdev->dev, "pci enable failed: error %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = pci_request_regions(pdev, DRIVER_NAME);
 	if (ret) {
-		dd_dev_err(dd, "pci_request_regions fails: err %d\n", -ret);
+		dev_err(&pdev->dev, "pci_request_regions fails: err %pe\n",
+			ERR_PTR(ret));
 		goto bail;
 	}
 
@@ -59,7 +60,8 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 		 */
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
-			dd_dev_err(dd, "Unable to set DMA mask: %d\n", ret);
+			dev_err(&pdev->dev, "Unable to set DMA mask: %pe\n",
+				ERR_PTR(ret));
 			goto bail;
 		}
 	}

-- 
2.54.0


