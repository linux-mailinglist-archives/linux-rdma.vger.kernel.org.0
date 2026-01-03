Return-Path: <linux-rdma+bounces-15276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF2CF0358
	for <lists+linux-rdma@lfdr.de>; Sat, 03 Jan 2026 18:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D203F3011439
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jan 2026 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D1225762;
	Sat,  3 Jan 2026 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuhTrnmO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F96165F1A
	for <linux-rdma@vger.kernel.org>; Sat,  3 Jan 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767461122; cv=none; b=W5AFhALrLgTfpgreW47MDZHrYpEOxo4CzbKvquyjYBh2zsbk/rSiyNA5v2q3Y1LOpjE0Uad4GB32GIFnK6YJum4GaB6qM1LNF6u5XBUKPM7siEcnWB3iP9XwH70Mk/xwhQfCIXNNBTf8c3rzVvQGpTrwaTmNQNGNfC63Y+bZSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767461122; c=relaxed/simple;
	bh=D3bfjDNY+Vmy3ZoExdyGW4T0MwdvuluZDUtEU10XUGc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iWJCF20lsc0k0mGd2MR/nL06l/bwM73LRph4r8fGuFk3DBRF+iAOTDtDuWccjJxb9PLSgvFMW55kuF8qCrV3j36BdfRoZO7AlMzNuzgP+EbpoI1aoQuKgbkmj9QxizfW5/HploVNza5nurIG8F7xJEZx+Z9IGUWz5sOj+JwSk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuhTrnmO; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-63e35e48a1aso15053937d50.0
        for <linux-rdma@vger.kernel.org>; Sat, 03 Jan 2026 09:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767461120; x=1768065920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXHy+RSGraglwUlI+0od3QooEbr2KOG3D+83WoaVSug=;
        b=uuhTrnmO9+XDX8+HAV1A58dYIADYSs5sDpBNQq2zt1XAGV7YcxVRchW06J9j0KE60Q
         YBDuNTdie7o/nyzW4rwOuMt4dK84f4EIiSN8t87J4jspf5Qi8k7k6ukC4SWEz2clBTnk
         JhMnp1hyi7YfbdaGqOGDY71zPE7XHKCmkFdaYu2B35AIU5w8dSnVmwu08bsFGcXa/efj
         g/3ZprJb27PBmtBC6EEoEit56gQ6ZbIX7kLv8Z3AeR2eIuQXWf5pQBcYVi0/jkXltE7Y
         hKST/1b4j9ADNfAKE9u6KeoWihmPM2QPLiy1x7fviG2rkqlZeUbQQ9rXxa61uXlNGC7J
         LmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767461120; x=1768065920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXHy+RSGraglwUlI+0od3QooEbr2KOG3D+83WoaVSug=;
        b=pdW2jTko+BvQSM3HSDGcR5IB+CSNMqjPyTqbAYMOkXeBFUGNAv6jYMb+KFXSrp9zNv
         +fGE3If7VKGMSDTAynaKfKz2dKbhPVJg7/mSp4bC3bagDMifUFuHSEGe0zodsrl5VInQ
         dONPft5khOGqZwJzkJg35lAi3Nt+Q1KcRzUdftqfoSFeQzEM5fjxlvKATK42MnmiTfij
         addHEb865ddy6YNiZiIG2K6iI2J2IImYKejrDolj10qShEwY9lvys4MECndbF3MtbLRI
         8WiJO251/rckZBQ8Fj8rhBKTi4cGZmht5agfbcFKPqERxaF81rmn9LMGPOMe2WYLEJ4k
         m/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTBoHk+S14JHvZA4lRflZLQKnWmTVw3wsqcOMXk4/TC+D2xSmaaoaKz0V2THMN1zCaU09nraupVeqX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Uup92fnLUr2vGuaakaOAu1z1z7D4DwypeazdfdVUwFaBH5YZ
	+LE2hybcb2YuXqcbWXZ+3sCfzMxE5o3lex4kvPb5SJqyvzjsklhuHG7bAl8cL4zBDwsM8in3U9N
	9AWXDdsLb3w==
X-Google-Smtp-Source: AGHT+IFFcDmdcWx3Cxz7CFBmkFe5XHBOTkEZzyYMWOtaeIZvWn7oa6U+REOTzvLgDBM69L2uqciz+XQHgdcN
X-Received: from yxza40.prod.google.com ([2002:a05:690e:ee8:b0:645:4f29:c441])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a53:c587:0:b0:645:5bfc:8bd3
 with SMTP id 956f58d0204a3-6466a8be941mr31683031d50.72.1767461119961; Sat, 03
 Jan 2026 09:25:19 -0800 (PST)
Date: Sat,  3 Jan 2026 17:25:17 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260103172517.2088895-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Remove redundant dma_wmb() before writel()
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

A dma_wmb() is not necessary before a writel() because writel()
already has an even stronger store barrier. A dma_wmb() is only
required to order writes to consistent/DMA memory whereas the
barrier in writel() is specified to order writes to DMA memory as
well as MMIO.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 2 --
 drivers/infiniband/hw/irdma/uk.c   | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ce5cf89c463c..eec5b3d7a703 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3887,8 +3887,6 @@ void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 	set_64bit_val(ccq->cq_uk.shadow_area, 32, temp_val);
 	spin_unlock_irqrestore(&ccq->dev->cqp_lock, flags);
 
-	dma_wmb(); /* make sure shadow area is updated before arming */
-
 	writel(ccq->cq_uk.cq_id, ccq->dev->cq_arm_db);
 }
 
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index f0846b800913..d651f9210f13 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -114,7 +114,6 @@ void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)
  */
 void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 {
-	dma_wmb();
 	writel(qp->qp_id, qp->wqe_alloc_db);
 }
 
@@ -1107,8 +1106,6 @@ void irdma_uk_cq_request_notification(struct irdma_cq_uk *cq,
 
 	set_64bit_val(cq->shadow_area, 32, temp_val);
 
-	dma_wmb(); /* make sure WQE is populated before valid bit is set */
-
 	writel(cq->cq_id, cq->cqe_alloc_db);
 }
 
-- 
2.52.0.223.gf5cc29aaa4-goog


