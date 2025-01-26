Return-Path: <linux-rdma+bounces-7235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00104A1CD37
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B6A7A2AC9
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0E19E97F;
	Sun, 26 Jan 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3folyR2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2B19E96A;
	Sun, 26 Jan 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909980; cv=none; b=XekMdLspuZWi6740T5ZuCSqiRvrAg/Y7IQ5G2EscYhmBStLqngahmeIDtxcVRmSJUGqfvBSIUxW+tb7M0vagHZbiYD7cg8SghdvYbLPGipSou9IKahhByU1CeiPlDxu51jO5LhYQuSkh7TClyk1oTk4JeeHxhUoEgbABocZfS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909980; c=relaxed/simple;
	bh=c/z8Fqyndj1hHrx1Q0bB/JSDepO/52l2S2hAJuhZz64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SS+8ySCwz+xETSsCVPsNnTm4+cMPbVsiyKYYRTYem232upA3Q50BvyAcJE1/O3/JWbYbKWYo9XDtIVGtLxyc8RgptHQzxLU5H/RamxNpk/1N/U606RItePpVbVbaZZjwoYAW3XCVQeOC5BoCacNywqb1iqBSTW188XrjlVUuqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3folyR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA3EC4CED3;
	Sun, 26 Jan 2025 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909980;
	bh=c/z8Fqyndj1hHrx1Q0bB/JSDepO/52l2S2hAJuhZz64=;
	h=From:To:Cc:Subject:Date:From;
	b=K3folyR2iKV35fJCJAQ43M3CxiLA2q0HxtF9+zKNCziUEoLSPPRcyeZzKlVZQSZjt
	 ylqqJfje28G8RmDbFEsI8dEBqiIpTFPhMyssM4M8ob5cgqEn2BTCqpdmHcnu59G5gD
	 KEoEtdNmpqfOZZWsXduBR5n3d9vnVEkSi2WJF3aWyQ7VFHyCYvD9ZinExzu8lCHAF8
	 DHJZO9g/MIxvmG0Wkj7TNtGZbiMBrvAcb3sOr/Xs9r6NTFL5tkteXkUb86YKuHr/pG
	 KUDCOM/NV4ZCgGiLXLf3MtjrvK0S6vxDk4uir+ZGba8c77rEVnyden0ucW//NkKQyA
	 Yk30AvD/KTzqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Margolin <mrgolin@amazon.com>,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/2] RDMA/efa: Reset device on probe failure
Date: Sun, 26 Jan 2025 11:46:17 -0500
Message-Id: <20250126164618.964225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Michael Margolin <mrgolin@amazon.com>

[ Upstream commit 123c13f10ed3627ba112172d8bd122a72cae226d ]

Make sure the device is being reset on driver exit whatever the reason
is, to keep the device aligned and allow it to close shared resources
(e.g. admin queue).

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
Link: https://patch.msgid.link/20241225131548.15155-1-mrgolin@amazon.com
Reviewed-by: Gal Pressman <gal.pressman@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 15ee920811187..924940ca9de0a 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -452,7 +452,6 @@ static void efa_ib_device_remove(struct efa_dev *dev)
 	ibdev_info(&dev->ibdev, "Unregister ib device\n");
 	ib_unregister_device(&dev->ibdev);
 	efa_destroy_eqs(dev);
-	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_NORMAL);
 	efa_release_doorbell_bar(dev);
 }
 
@@ -623,12 +622,14 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	return ERR_PTR(err);
 }
 
-static void efa_remove_device(struct pci_dev *pdev)
+static void efa_remove_device(struct pci_dev *pdev,
+			      enum efa_regs_reset_reason_types reset_reason)
 {
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 	struct efa_com_dev *edev;
 
 	edev = &dev->edev;
+	efa_com_dev_reset(edev, reset_reason);
 	efa_com_admin_destroy(edev);
 	efa_free_irq(dev, &dev->admin_irq);
 	efa_disable_msix(dev);
@@ -656,7 +657,7 @@ static int efa_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_remove_device:
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_INIT_ERR);
 	return err;
 }
 
@@ -665,7 +666,7 @@ static void efa_remove(struct pci_dev *pdev)
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 
 	efa_ib_device_remove(dev);
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_NORMAL);
 }
 
 static struct pci_driver efa_pci_driver = {
-- 
2.39.5


