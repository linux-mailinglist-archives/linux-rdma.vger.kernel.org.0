Return-Path: <linux-rdma+bounces-7232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2482A1CD00
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C73A7F47
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2616DC3C;
	Sun, 26 Jan 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpZUMq3N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E1165F01;
	Sun, 26 Jan 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909928; cv=none; b=DkQ+2wPVPBEOsK5CM2z7Ib31OnLitBiRkd4oSUH/eYzX6XFliST3nZ1Mv1pJnV0ZWLDIILOG3H5c/RgP36ntq5y3GGSGcAETGSmuNK+GfuJW1hir6+EjDE8FPB4L14QYmOjhcK/NLKfCw/T+9ZmHXDpttErdmILY91paqvx2d0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909928; c=relaxed/simple;
	bh=Fvbo3UwreLlL541vKtBHY27Zn1LjVTBWmk37IrD4u1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qibwg33YDSg1bQfyUsZCUW7Y9uVPq4ts+zJasksyLFfG2J7M9ScEOiupaKjBiymsvpRn0n+ZHEX9lPu+L5KCFaRLIn6c89Nt1SPYgHdKsC5EU1ZBiXG9Xw9csGwvLGQj9wyWka5dR3wux8NJjlY4UNsExc5Bl9+fEttUoJu4f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpZUMq3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F859C4CEE3;
	Sun, 26 Jan 2025 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909927;
	bh=Fvbo3UwreLlL541vKtBHY27Zn1LjVTBWmk37IrD4u1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpZUMq3N6cRV6ZMP27PLBzMcWfj1GETHTfNAF/O8kPlmThf1sS8BasZEGm1qSUAUQ
	 WMvohOUIjEB7++cfmdkNMBFRtIKLq9ccrqqdr/0z74SJGQNdKT2OiO+pE4ty91MTwP
	 48+V9XghVPiKusW/pPVEd7ev9e6SnhDkcHCpTpCgN0gDmgJX7ifKstHhGabO+Qcjko
	 rRA+QV4YFgY1JxR8SvG8r1bT9EhDVj76mm4mLkui7jRpTYWLJj/6TJu1wuls0kNEPw
	 noHwjtIC6lPcw5Z0uJjmqEhazpC6a2eRarp2u3RMIRQEidNPlho/hhxG3DoDdEat3g
	 +fFoWVV3he+Lw==
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
Subject: [PATCH AUTOSEL 6.13 2/8] RDMA/efa: Reset device on probe failure
Date: Sun, 26 Jan 2025 11:45:17 -0500
Message-Id: <20250126164523.963930-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126164523.963930-1-sashal@kernel.org>
References: <20250126164523.963930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index ad225823e6f2f..45a4564c670c0 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -470,7 +470,6 @@ static void efa_ib_device_remove(struct efa_dev *dev)
 	ibdev_info(&dev->ibdev, "Unregister ib device\n");
 	ib_unregister_device(&dev->ibdev);
 	efa_destroy_eqs(dev);
-	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_NORMAL);
 	efa_release_doorbell_bar(dev);
 }
 
@@ -643,12 +642,14 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
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
@@ -676,7 +677,7 @@ static int efa_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_remove_device:
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_INIT_ERR);
 	return err;
 }
 
@@ -685,7 +686,7 @@ static void efa_remove(struct pci_dev *pdev)
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 
 	efa_ib_device_remove(dev);
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_NORMAL);
 }
 
 static void efa_shutdown(struct pci_dev *pdev)
-- 
2.39.5


