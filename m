Return-Path: <linux-rdma+bounces-2022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549B78AE945
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D631C2231A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1C13B2B8;
	Tue, 23 Apr 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JT8g8/3x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A813C810;
	Tue, 23 Apr 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881766; cv=none; b=QPr/6uhyYVBVFZEoTpf+Fdv3kUSgEt+KpLr2FPGAOhzDKLlGIPdCsZOXHaLSV1EJeAlJdnwULFxzgwmWnXacmHdR5BHjS0g314cpB0vPtfGAV1F0EOq7LN7oYy0ZiHpplMwKbAkiJFb9PFwgm7l+qNid1OXFW1zgnlg0gJebL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881766; c=relaxed/simple;
	bh=+KHG3DtqLql0y+mvhcNwWBsrn4ZTxO3OwoCLAoy4VFQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qWXxLfYXiYZ8rMe3bBvCm+XTv3QQzKFffzw3HM/ezSuY/Ujjyl8WYn0tIp3wTL9cNrNs92P5Q/w0dFtWHCsavbzLohgwEyA5lWr7hjAFu6Gfqa/gqVwLi+j5RF7ywV1ppJGiS3wPQ9nt2R6DYdQz4StVBKViWnc6FepzOwTPobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JT8g8/3x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF2120FFC0F;
	Tue, 23 Apr 2024 07:15:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF2120FFC0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713881757;
	bh=uozpRzWYBjgm8cTbZvOLXzh8DyhfyNM9Ds5e5SaprAA=;
	h=From:To:Cc:Subject:Date:From;
	b=JT8g8/3xmhtBy/ejF8Ff/NoOKx2yMOZBd9sFg94nakQz4JgiJp5zKFMAJXB95e+zN
	 u9qQlFA6dz8q2aurMKRdS4ZyglmI/GK5KbprEKcOir1AEyLcyAQa+5vsWcb1z0sIsl
	 42aaCLt40kdFKvfMWeIJeV21sZzFNV34rfaINebs=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: nathan@kernel.org,
	kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: fix missing ret value
Date: Tue, 23 Apr 2024 07:15:51 -0700
Message-Id: <1713881751-21621-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Set ret to -ENODEV when netdev_master_upper_dev_get_rcu
returns NULL.

Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index fca4d0d85c64..7e09ceb3da53 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -87,6 +87,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
 	if (!upper_ndev) {
 		rcu_read_unlock();
+		ret = -ENODEV;
 		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
 		goto free_ib_device;
 	}
-- 
2.43.0


