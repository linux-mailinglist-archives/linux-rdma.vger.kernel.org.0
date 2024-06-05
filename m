Return-Path: <linux-rdma+bounces-2874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF378FC5DA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7C22846B6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A349648;
	Wed,  5 Jun 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cruCb8e5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C349645;
	Wed,  5 Jun 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575374; cv=none; b=iCrRKGI0mrrX2DmLhvOAVWVzYn4Cc7HQbBF9/kfdys8U8vPtB3pIP2u/wJnoh/nuvPjXif8fL36Y23S9gLUf9ZVr1/bhUi0BhQQB0ZSrnn8OzAtdmANmtUhsLnLtBiIK9UGQKP2PrQZiLO2xK+ae2uCo68oE1OiSTmWkAtNOXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575374; c=relaxed/simple;
	bh=VT5Llm+2/FTQqOqTjcgziNNCx9sgvtmzD5/CyBJnOBQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tWvcwxOktaU/dahjc5eWpnaaL6+swJPR5kMJ63cl1Jaci5lR9kmwJam7d5eE1TMdjahu2fwpxJMRDfU2EWsq5exfcJhBIf4H+bXvECs+lQGEnZcuexoqhi0uTU9Y/R12NNC+vphuZhflARngDMNXfFmToSOXDK+RPAZPUkfZPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cruCb8e5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1436920B915A;
	Wed,  5 Jun 2024 01:16:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1436920B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717575373;
	bh=+JwQCIbY5Ypjq42XxDaHhXz0TTOqxXdVtHlpkzmkxj0=;
	h=From:To:Cc:Subject:Date:From;
	b=cruCb8e5Yt0eL+ZPUYxpc65sDvjMh0io76wH3+4/dc7mf9Q+miaxc6yuDUVinWLa2
	 hT/R/ZWTMauRHajAbVRLG6vdBH6g9OJ2A57qqt21tiWTuHhyuQNxSESAtmN7l8wxkt
	 M4fefR8ORqL8dThg+F92rp06OUDJHS9pMP3WNGB0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Date: Wed,  5 Jun 2024 01:16:08 -0700
Message-Id: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Ignore optional ib_access_flags when an MR is created.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 4f13423..887b09d 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -112,6 +112,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		  "start 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
 		  start, iova, length, access_flags);
 
+	access_flags &= ~IB_ACCESS_OPTIONAL;
 	if (access_flags & ~VALID_MR_FLAGS)
 		return ERR_PTR(-EINVAL);
 
-- 
2.43.0


