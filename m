Return-Path: <linux-rdma+bounces-2447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8A8C3CE7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C69D281E4B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D61146D61;
	Mon, 13 May 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Equ8ZS2W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967133CA
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587827; cv=none; b=EpaL84jU0njHIuq578MliFr4hFm2ShSjugl/7s0ZH/fBVOGtHSp5cE1AHhYbUuuIkCkR16MKWZ96mRKZhy961fbUhfdFHVCY2HllFVSx2vpKph6Y3GJuz7oq5WOWCeBcU3rr/mjSlOIxgtK1bG3he33xQ9f/u41wm/oAW2OFBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587827; c=relaxed/simple;
	bh=bR2Qffyo6I6J7+g3EjVrxZK/rIRFOl23+FwgOVGCS+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ls9KfOXZenzDYlt7trwpxS5QevSJrZBQ7ZWtyO4UvbGt6XC3PW6vvXGmeOtyKwjiNLo4OMknXmLzGrNi1Uz5ys6aCiTcx/u8Y/wlG0CCvI0v/UXc3zcE0JGFZq9PUSIQerzhMRB/nAlC9GP7cmITMG2sWkuyXBw7XdAqQEhEax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Equ8ZS2W; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715587826; x=1747123826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/fkDyKxvQqWLrKg8pxZBaMoEAlkLAr67GgLh5evvJwA=;
  b=Equ8ZS2WIa5ROmO+pxU7CPWGHt/t5Q2gvREDT8Y82GQYvfBsgdW0ixnU
   T/kmegt4RO4UJwJZdmdY5H14gDJ7+x+7G3bWTAbdLsHfqoEP17qS8PDMx
   7NpaC5gs5kP2TM3hG+bhdQsxtzsewFciewIb8RRR3fvT9aPRu2QkK6bAn
   4=;
X-IronPort-AV: E=Sophos;i="6.08,157,1712620800"; 
   d="scan'208";a="653709861"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 08:10:24 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:11940]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.131:2525] with esmtp (Farcaster)
 id 3089abd9-d9a6-4faa-b5c1-a23e6018062d; Mon, 13 May 2024 08:10:22 +0000 (UTC)
X-Farcaster-Flow-ID: 3089abd9-d9a6-4faa-b5c1-a23e6018062d
Received: from EX19D022EUA003.ant.amazon.com (10.252.50.138) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 08:10:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D022EUA003.ant.amazon.com (10.252.50.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 08:10:21 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 13 May 2024 08:10:19
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Fail probe on missing BARs
Date: Mon, 13 May 2024 08:10:19 +0000
Message-ID: <20240513081019.26998-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In case any of PCI BARs is missing during device probe we would like to
fail as early as possible. Fail if any of the required BARs isn't listed
as a memory BAR.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas Jahjah <firasj@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 30 ++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index d1a48f988f6c..99f9ac23c721 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -190,15 +190,23 @@ static int efa_request_doorbell_bar(struct efa_dev *dev)
 {
 	u8 db_bar_idx = dev->dev_attr.db_bar;
 	struct pci_dev *pdev = dev->pdev;
-	int bars;
+	int pci_mem_bars;
+	int db_bar;
 	int err;
 
-	if (!(BIT(db_bar_idx) & EFA_BASE_BAR_MASK)) {
-		bars = pci_select_bars(pdev, IORESOURCE_MEM) & BIT(db_bar_idx);
+	db_bar = BIT(db_bar_idx);
+	if (!(db_bar & EFA_BASE_BAR_MASK)) {
+		pci_mem_bars = pci_select_bars(pdev, IORESOURCE_MEM);
+		if (db_bar & ~pci_mem_bars) {
+			dev_err(&pdev->dev,
+				"Doorbells BAR unavailable. Requested %#x, available %#x\n",
+				db_bar, pci_mem_bars);
+			return -ENODEV;
+		}
 
-		err = pci_request_selected_regions(pdev, bars, DRV_MODULE_NAME);
+		err = pci_request_selected_regions(pdev, db_bar, DRV_MODULE_NAME);
 		if (err) {
-			dev_err(&dev->pdev->dev,
+			dev_err(&pdev->dev,
 				"pci_request_selected_regions for bar %d failed %d\n",
 				db_bar_idx, err);
 			return err;
@@ -531,7 +539,7 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 {
 	struct efa_com_dev *edev;
 	struct efa_dev *dev;
-	int bars;
+	int pci_mem_bars;
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -556,8 +564,14 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	dev->pdev = pdev;
 	xa_init(&dev->cqs_xa);
 
-	bars = pci_select_bars(pdev, IORESOURCE_MEM) & EFA_BASE_BAR_MASK;
-	err = pci_request_selected_regions(pdev, bars, DRV_MODULE_NAME);
+	pci_mem_bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (EFA_BASE_BAR_MASK & ~pci_mem_bars) {
+		dev_err(&pdev->dev, "BARs unavailable. Requested %#x, available %#x\n",
+			(int)EFA_BASE_BAR_MASK, pci_mem_bars);
+		err = -ENODEV;
+		goto err_ibdev_destroy;
+	}
+	err = pci_request_selected_regions(pdev, EFA_BASE_BAR_MASK, DRV_MODULE_NAME);
 	if (err) {
 		dev_err(&pdev->dev, "pci_request_selected_regions failed %d\n",
 			err);
-- 
2.40.1


