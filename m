Return-Path: <linux-rdma+bounces-2597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341528CD2F1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A361F21D88
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C4A14AD3A;
	Thu, 23 May 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G27a6hD/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9B14A623;
	Thu, 23 May 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469145; cv=none; b=Rbe99STJPYT1vONWMmLl6iGxXSXZaCnVLFJ6aLM+PgrFcfrZZaO/4ELP6Nd+zC4hgJnQo2E5iVvM0rm60Faah8S3DIGQ0hD9TL+4a6OwJj4bxpI1oN2j45cjd1gOlS7E+pHkJWP1dGZMUfOJuxJB2aXHhMMRGDrG3XvRdVJlCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469145; c=relaxed/simple;
	bh=qrtMfi29nOPCDGguwmLI+rIX8nriV0m4167KbZpCAww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=blOz2Xgb/tLd89sWPrgdJm6/btizsjepLvRRwVxaO5VLJdzyW9y96DW8xweeM1WfTbiYzeDZdOgKWaEKp2EBo5uQH5UstFLgRWjHCLzuVwjC4QaE1Kk6xVgzUaiq6F4tkj81P3biCNws7LXTAD98VpnLXbsCMcb3quk6r/OvxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G27a6hD/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9407220B9260;
	Thu, 23 May 2024 05:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9407220B9260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716469143;
	bh=SijCuv+QFkMCbbHDkAAt7AU3QROLkXxz8bUCBmDqLoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G27a6hD/FuhFPiHIzMbEXNRWq7si4t1q8rXR/+Y6d1fpVyHO0AT40S1otS4u5ojuI
	 fxaLJ4FdygcyTsPE16bLcuOxXnGof3PrZJtrd1AiM0VwbLtkv43q38JwbH6yHDGto9
	 n3T5Ud/l1XuYCYQnLFJvusSHnsFhspSmRzkuefrU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/mana_ib: set node_guid
Date: Thu, 23 May 2024 05:58:56 -0700
Message-Id: <1716469137-16844-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use the mac address for the node_guid of the IB device.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 7e09ceb..9a7da2e 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -5,6 +5,7 @@
 
 #include "mana_ib.h"
 #include <net/mana/mana_auxiliary.h>
+#include <net/addrconf.h>
 
 MODULE_DESCRIPTION("Microsoft Azure Network Adapter IB driver");
 MODULE_LICENSE("GPL");
@@ -92,6 +93,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto free_ib_device;
 	}
 	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
+	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, upper_ndev->dev_addr);
 	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
 	rcu_read_unlock();
 	if (ret) {
-- 
2.43.0


