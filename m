Return-Path: <linux-rdma+bounces-8340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E281A4EFA3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 22:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953911891A29
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2812277817;
	Tue,  4 Mar 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IYJN1450"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C524EAA8;
	Tue,  4 Mar 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125404; cv=none; b=vFtoyAjzbOVlLLLBRwQOtp+wvvl1b9gUMLuNV+tyjjTw08ivSL1JURn66O0TEar8zUqh+50Eff/wYzDwV8SAGvUrVDuN2RveIByGPw5PXyABMMNldbu6wmB984aTksW6gWUZqzY5xe3Ag9FHXSKjwuN6RPHpNoK/tDvOBq5dRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125404; c=relaxed/simple;
	bh=uGzPPWORNkzjJHKcH4MLXQ9q3pRn2Ha+pyfPZiUoj18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgZ87eyo95HALAur09ymNRdqeuDXU9uQ189cLdM0nXMLuNtI4uqrF2R9sEqoQx44ajgd0xLhNO8EtIE2Z7h4sX9Zqh893wXSOKtJsx2px1/RlZ5Wv0hlrODjAl7qEyLOzIq0CzXvepjTbPJXF1og988Wc6/nkz0k6yq4DJ9mBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IYJN1450; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=EonlkIdhc9iF91UeJx88CcwdpNRXjvyUfwnoMhn+ogE=; b=IYJN1450OjxNRwsw
	AMwhNNEOU7AGUICSS8ovH8L4lhqwXTpWAXcUdg0PgE9/c1SqC5sb2M/0fDnJGLDGZJnLoL3xumOr4
	Fd3lLpG3jYFNau3gh4ZXCqYNFJJf2BQIFWlOWXvD+48YhuR1MrqsJcnbG752Q1l4JoBBJKaFa3BAM
	Qvu5MDlbydWnXq15IdVA/itdss6hBIHKBr8zHQtN9vjznqE8v08iO1ZBQqV/Zi5ieTRrnKODMSQOM
	NnInLN0nRdE3uUC/0rW2s+PAQtP4I9FshPZ1eVcdgAvRIVjCDm7U45sSlUs9PYmaBWq5sIbVtPAO3
	D4mPqKAX1Kasm8qMgQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpaFh-002fPg-1w;
	Tue, 04 Mar 2025 21:56:37 +0000
From: linux@treblig.org
To: bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/vmw_pvrdma: Remove unused pvrdma_modify_device
Date: Tue,  4 Mar 2025 21:56:36 +0000
Message-ID: <20250304215637.68559-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pvrdma_modify_device() was added in 2016 as part of
commit 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
but accidentally it was never wired into the device_ops struct.

After some discussion the best course seems to be just to remove it,
see discussion at:
https://lore.kernel.org/all/Z8TWF6coBUF3l_jk@gallifrey/

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 28 -------------------
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 --
 2 files changed, 30 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index 9f54aa90a35a..bcd43dc30e21 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -237,34 +237,6 @@ enum rdma_link_layer pvrdma_port_link_layer(struct ib_device *ibdev,
 	return IB_LINK_LAYER_ETHERNET;
 }
 
-int pvrdma_modify_device(struct ib_device *ibdev, int mask,
-			 struct ib_device_modify *props)
-{
-	unsigned long flags;
-
-	if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
-		     IB_DEVICE_MODIFY_NODE_DESC)) {
-		dev_warn(&to_vdev(ibdev)->pdev->dev,
-			 "unsupported device modify mask %#x\n", mask);
-		return -EOPNOTSUPP;
-	}
-
-	if (mask & IB_DEVICE_MODIFY_NODE_DESC) {
-		spin_lock_irqsave(&to_vdev(ibdev)->desc_lock, flags);
-		memcpy(ibdev->node_desc, props->node_desc, 64);
-		spin_unlock_irqrestore(&to_vdev(ibdev)->desc_lock, flags);
-	}
-
-	if (mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID) {
-		mutex_lock(&to_vdev(ibdev)->port_mutex);
-		to_vdev(ibdev)->sys_image_guid =
-			cpu_to_be64(props->sys_image_guid);
-		mutex_unlock(&to_vdev(ibdev)->port_mutex);
-	}
-
-	return 0;
-}
-
 /**
  * pvrdma_modify_port - modify device port attributes
  * @ibdev: the device to modify
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 4b9edc03d73d..fd47b0b1df5c 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -356,8 +356,6 @@ int pvrdma_query_pkey(struct ib_device *ibdev, u32 port,
 		      u16 index, u16 *pkey);
 enum rdma_link_layer pvrdma_port_link_layer(struct ib_device *ibdev,
 					    u32 port);
-int pvrdma_modify_device(struct ib_device *ibdev, int mask,
-			 struct ib_device_modify *props);
 int pvrdma_modify_port(struct ib_device *ibdev, u32 port,
 		       int mask, struct ib_port_modify *props);
 int pvrdma_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
-- 
2.48.1


