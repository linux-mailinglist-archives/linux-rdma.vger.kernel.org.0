Return-Path: <linux-rdma+bounces-9400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61B0A87B3C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6293AEA66
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87525E82A;
	Mon, 14 Apr 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o4OMuZBE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAA3C38;
	Mon, 14 Apr 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621242; cv=none; b=AWbFGXvnlaXNrw8FnHmQDUlyQI/7OM8E4V34ml0ylrFCh2in+/GdxdEWS3Jkn3iilcYHQNaBBroXCKg5wgCbUshy1xOEvnoyMaHghz9E5WzGpRHdtni0mpUKzQieXrYe4H8L1cT75jHaPjWAvsFGnxEsPPyBfWYvMmmSp3Jtx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621242; c=relaxed/simple;
	bh=vtUO3I0GfR3soW4psczNy/v5iTEKL5+K9N1+eicoi9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AyAI4sxKhyhXpSC9rIOQz7M0fdGu+x0BcEm2mY7Ko760qLxylgyge1mpht37t8Na4IR9Jv61TbrvFnoWzmLpLw82UzxYISOZixptUHfJfpuiUkUcsDLICCQhygb5IRLLhlF2UWNx84Sothy1bCNF8hq3bZ529GxHcNKTkLZpeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o4OMuZBE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id C431021180D2; Mon, 14 Apr 2025 02:00:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C431021180D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744621234;
	bh=FKKQQzJvIk0F8xIfgA7X5Zz753fbLzvsg6P9j7X+2sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4OMuZBEAn9ummbKs75iGaC1lQYCEU598W/uzVwS5vxmgRRUMoZg5y6jOe1GHmUub
	 Olu0bCbHObhhRvhVvhduwA0HM0tcAVn0TRKwjX9HNKCG3vhvrfgpW0up1/oryiMoTF
	 gKSmWOHB0O4P4NQkVpS4J34Vq1tKCp3AdKZQ2c9w=
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
Subject: [PATCH rdma-next v2 2/3] RDMA/mana_ib: support of the zero based MRs
Date: Mon, 14 Apr 2025 02:00:33 -0700
Message-Id: <1744621234-26114-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add IB_ZERO_BASED to the valid flags and use
the corresponding MR creation request for the zero
based memory.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mr.c | 24 +++++++++++++++++-------
 include/net/mana/gdma.h         | 11 ++++++++++-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index e4a9f53..6d974d0 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -6,7 +6,7 @@
 #include "mana_ib.h"
 
 #define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
-			IB_ACCESS_REMOTE_ATOMIC)
+			IB_ACCESS_REMOTE_ATOMIC | IB_ZERO_BASED)
 
 #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
 
@@ -51,7 +51,10 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 		req.gva.virtual_address = mr_params->gva.virtual_address;
 		req.gva.access_flags = mr_params->gva.access_flags;
 		break;
-
+	case GDMA_MR_TYPE_ZBVA:
+		req.zbva.dma_region_handle = mr_params->zbva.dma_region_handle;
+		req.zbva.access_flags = mr_params->zbva.access_flags;
+		break;
 	default:
 		ibdev_dbg(&dev->ib_dev,
 			  "invalid param (GDMA_MR_TYPE) passed, type %d\n",
@@ -147,11 +150,18 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		  dma_region_handle);
 
 	mr_params.pd_handle = pd->pd_handle;
-	mr_params.mr_type = GDMA_MR_TYPE_GVA;
-	mr_params.gva.dma_region_handle = dma_region_handle;
-	mr_params.gva.virtual_address = iova;
-	mr_params.gva.access_flags =
-		mana_ib_verbs_to_gdma_access_flags(access_flags);
+	if (access_flags & IB_ZERO_BASED) {
+		mr_params.mr_type = GDMA_MR_TYPE_ZBVA;
+		mr_params.zbva.dma_region_handle = dma_region_handle;
+		mr_params.zbva.access_flags =
+			mana_ib_verbs_to_gdma_access_flags(access_flags);
+	} else {
+		mr_params.mr_type = GDMA_MR_TYPE_GVA;
+		mr_params.gva.dma_region_handle = dma_region_handle;
+		mr_params.gva.virtual_address = iova;
+		mr_params.gva.access_flags =
+			mana_ib_verbs_to_gdma_access_flags(access_flags);
+	}
 
 	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
 	if (err)
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 50ffbc4..3db506d 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -812,6 +812,8 @@ enum gdma_mr_type {
 	 * address that is set up in the MST
 	 */
 	GDMA_MR_TYPE_GVA = 2,
+	/* Guest zero-based address MRs */
+	GDMA_MR_TYPE_ZBVA = 4,
 };
 
 struct gdma_create_mr_params {
@@ -823,6 +825,10 @@ struct gdma_create_mr_params {
 			u64 virtual_address;
 			enum gdma_mr_access_flags access_flags;
 		} gva;
+		struct {
+			u64 dma_region_handle;
+			enum gdma_mr_access_flags access_flags;
+		} zbva;
 	};
 };
 
@@ -838,7 +844,10 @@ struct gdma_create_mr_request {
 			u64 virtual_address;
 			enum gdma_mr_access_flags access_flags;
 		} gva;
-
+		struct {
+			u64 dma_region_handle;
+			enum gdma_mr_access_flags access_flags;
+		} zbva;
 	};
 	u32 reserved_2;
 };/* HW DATA */
-- 
2.43.0


