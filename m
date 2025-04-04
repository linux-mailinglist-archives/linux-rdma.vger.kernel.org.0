Return-Path: <linux-rdma+bounces-9153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BBA7BFCD
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8450C3B5533
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF711F4295;
	Fri,  4 Apr 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IOZzVapm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1D339A8;
	Fri,  4 Apr 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777964; cv=none; b=HRT6+yqlsiVFBSJiLIns9LVINRW6R6w1k79h91+jgGCd3Hqby5IhVceShdYeSthAGCJbLdfwazTlPn380mpICckSaL65Ed3hKnmaeIv2xidRLtQzmrMwwHZIX7h/AGS0MbiYBffDMFDFvvtdeE2CpGVnKEZnnbcE+PUdOVMd4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777964; c=relaxed/simple;
	bh=GfzipUVy5RaTdAOqBjCv6TrYY3q+oixO4mtRqKujpGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EJ9HfcMifD9JoZHsBpeZowGFAMR+zPET60C4oK1F9PHOdvrnuQ1VoCNPCGx3ZQFzpivm9k6bRJ2gXNrpwfRZyECba3GJQZIdsVdUGESW4KwIIX6SiiW35+OfDaQX6nTSDmAoqMX43/ByNcIVvEaHT3yy51G0Wiv56/BZdpDYPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IOZzVapm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id E1CC12027E0F; Fri,  4 Apr 2025 07:45:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1CC12027E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743777955;
	bh=Hu0kugxBiz8/p6dDvzQx99KKmNT1Fzl3KzmqCbUqqmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOZzVapmnRolUzmp6jWU28IWXOdmgSg8IlNOdynqkq3sQidRriXSRkiBmaD+MgmGU
	 +nL3YtRl8k2hv4GNb5f7I4d+OpnmklaWGQ6ubto7awCY82d5pD9iO7CKEwwSIBm9zo
	 3XYhJP56MduhRrIEX5sK+7KstMXTTAwJUDOWaxuM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote atomic for MRs
Date: Fri,  4 Apr 2025 07:45:53 -0700
Message-Id: <1743777955-2316-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add IB_ACCESS_REMOTE_ATOMIC to the valid flags for MRs and use
the corresponding flag bit during MR creation in the HW.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index f99557e..e4a9f53 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -5,8 +5,8 @@
 
 #include "mana_ib.h"
 
-#define VALID_MR_FLAGS                                                         \
-	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ)
+#define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
+			IB_ACCESS_REMOTE_ATOMIC)
 
 #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
 
@@ -24,6 +24,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
 	if (access_flags & IB_ACCESS_REMOTE_READ)
 		flags |= GDMA_ACCESS_FLAG_REMOTE_READ;
 
+	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
+		flags |= GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
+
 	return flags;
 }
 
-- 
2.43.0


