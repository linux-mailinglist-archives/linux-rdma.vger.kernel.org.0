Return-Path: <linux-rdma+bounces-2686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59518D4B1A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7621C283B60
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD117FAAB;
	Thu, 30 May 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PnA+xJCo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D417E478;
	Thu, 30 May 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070125; cv=none; b=ZhE0s9EnMdGOMLrCKS0xfJSsi1tOAmDm0YvmgpExBjJXTdokfHyLSKPSKzSLddFV/ZSeelrurHsBz2iw8t/ol8gEgJgIKsvnjjJXvDOWScyeCoFcZNwSzpgC6iPcHpbTpjJdtQhBerelk1Z6bGStRU/ZFzYvez/Da7ia9XjM86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070125; c=relaxed/simple;
	bh=QLjiQw7NqssbLJLK2uetUPdOfYeFKGuAmahS5JMoJ/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lw6pXv4VI/sZ5EgbkLr3VcBnb7ANDnufbkbfeyMnCumaVaxKlhm8/02CHeqg8RSbmXZhJVCr41CYYq0SgUaNnWk++3jAUaozoNWP/xGBAA06XCXjg6vr7vzKl0TeBpQQxQ7ay57AU5B8qB2g5wlgfFsI9vYOYCrFeTu0ugDdWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PnA+xJCo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57B2C20B915B;
	Thu, 30 May 2024 04:55:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57B2C20B915B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717070123;
	bh=UBCU0OT+/KidNJ3GcZj3+bBFsfX2yHeRnRPCUIDpm+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnA+xJCoS71RGwaE3/4twvUHXOWjMHPfS5b6Iqo0XEBC//LXDOXJdPQcZVurVUPrZ
	 v1d4gKpm9CYG+7pbM1kCtOiLT8iFRx8ZqBfzWMbsSDTZhCURtInZbX1doXfD6rbr1E
	 u5dQJsFfO1ZrQ2HujyIMVNWeM7jK8qFOIAGwkDUQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/2] RDMA/mana_ib: set node_guid
Date: Thu, 30 May 2024 04:55:16 -0700
Message-Id: <1717070117-1234-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1717070117-1234-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1717070117-1234-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use the mac address for the node_guid of the IB device.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
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


