Return-Path: <linux-rdma+bounces-9155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5BA7BFD3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A5A17BEC2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B41F4C8E;
	Fri,  4 Apr 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GQ6LMU49"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE381F419D;
	Fri,  4 Apr 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777965; cv=none; b=mW0y5Me1vPh8nipuFGubaRkKaPb8arz4dDQyGKp2K32Luyd9p31nhALy0fUCtD8lNlfbmTTS/lvXwZ5fNhkr9fFBylsL6aiyszbR2VFKtV+x03xZOaK3sjo+AF0lrLjlaxOs3Am9x4riONElHi13rddJXhSBDbrxBpwRhA1ABP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777965; c=relaxed/simple;
	bh=vtUO3I0GfR3soW4psczNy/v5iTEKL5+K9N1+eicoi9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NCPFTp6z0KEjPUiYSE+w43F3mVA6w5dlakb/ln6xurZqRjkgTDZO12Gl++ld9miCnA8IeqgYK6Z3ECv43Gv5BufCfcQXcvss3NGvDAt8oat5ZHlE4nb6Z93laJlcU//wDFXxTjjHMK506t3o4I+vxvkDEsVHvvwhGBK9t/llHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GQ6LMU49; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id EEA822027E10; Fri,  4 Apr 2025 07:45:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEA822027E10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743777955;
	bh=FKKQQzJvIk0F8xIfgA7X5Zz753fbLzvsg6P9j7X+2sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQ6LMU49zajhWDVDAUM2smqu4cnxFVKPt+1KlMC8/dQZMGh8y41gawsf1PkdYlHey
	 +W0xc6nzsYR9lfrj/wCPXcRvylnw8og3H0ZMaWlAbburm0DXltAPjwS5l88rMrekzd
	 pU9t6SRGL1R2E0MDUY9Slc1MCcyEsa8Dym0rgJbU=
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
Subject: [PATCH rdma-next 2/3] RDMA/mana_ib: support of the zero based MRs
Date: Fri,  4 Apr 2025 07:45:54 -0700
Message-Id: <1743777955-2316-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
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


