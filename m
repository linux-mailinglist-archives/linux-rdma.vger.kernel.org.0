Return-Path: <linux-rdma+bounces-13605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E368EB974C2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9332A19C60EE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB2302754;
	Tue, 23 Sep 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ+nVNRq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDA2DE70D
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654546; cv=none; b=OyO+RGbtqQYASEYMmC2EmA0IQRj0ICIpjc7zPf23LM3tgAsrWKCw9ORAVBVhMd1iMKcr4t160TmsU37KTLLre+AjcxwdHFWrT7/zfSY9pTEFwNU7hPGuVHdqLBzxAO1zY3Ch76OAYfTwtUCVZRC+aQsyRzoYEXU7UMhBDpO5WXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654546; c=relaxed/simple;
	bh=gcFGl/Fm+DhzznOcLL8F36KJ+0HaV4LgvQUKOFDnEpg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qrenNj6c1luMIWk5w6F44v7hsMbcprKLzPGUAwMRPNCZfq/ea6bshQ8a1JnOBwgSCMOkkLNPIYOFts/ShxqzrJct7/5qENZstduuGJfjL0M1K3nJV4qcEAkfygugdE1MZJpPfZEvEd99Ps3X3aUDAcS1Bnljg2cmYRlBz5Vq5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ+nVNRq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-74717169ab5so33402107b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654544; x=1759259344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E6pwkj+69Ks2peJYBqHl+jfSrACnQXZrWCs3WBH0xZo=;
        b=XQ+nVNRqISmohGBe4uOHzBtGB3mRyHE5O8+Zsy8dgVom6pwsmNl+HEvKxGOk1u8+aj
         5VoeNrVTYpWumfwIPvDb8+/GZUTvNH48hiugiN6Y3R35AQMp9gSibDgdE0Zr8FnSYBcq
         vak4L93ipECmmgwXeLI77bcyI8Dn1Ke/HWG4BxtbQyU+eD1iMcYRwC/2t+pjNz4gp1sz
         286hbPzg2+loidmnLJucOBc34aGXSc2Y5zhWZFqOiztHOW23VAfrkkGf8E1wAMmOdI3B
         KAcKXJuvbEUWjeeukEZcsozaje60RcSueLaWm64CeLWYyujDYXccRV4Q9MYvKRcClkSE
         d+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654544; x=1759259344;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6pwkj+69Ks2peJYBqHl+jfSrACnQXZrWCs3WBH0xZo=;
        b=IhCD/krb7FIt3H2Ecq05yueKNEuJ9/sSfLDxzi4P1j1cghkXJON+kXXiflUnnpyD4M
         mWmFUNY4+RKRjt0rdYWQsrT/H32PWuT3CihRimsL86dT0eKkW18PPBSVVScqWM5Sx5Rh
         oqVwndDcFebuWaZLD7h/VOQ3o46crkx6zC+j9e3Aq3CDFKQsC72edpYVNJig2iNkVsDa
         op1+gODhCmSfPopw03mW59/fgf1dVZnrNG14ZFPI8OP9HeE+P1zKeohiuu9P+9o/q/me
         2PaCvfcDt8FRu8L8ikD2hqVJ1rsRtzBgfXdpP8LXMCUUnYX+APJ1YXCC5CxAkjB4+IdS
         tF8w==
X-Forwarded-Encrypted: i=1; AJvYcCWqGb1paohP/INr7U/FILPaZDScO82fHMHroNmFNzx6lI6Tq0cW7MGGL88yEisGXujSsmx5Gh+6EZ63@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8wQwG0N5ZnjOHs/eU2mel1eaEcyNVqwuTGHwma0Vuj16AQuT
	rukEYofQABLNUnL89aIVUhQjzUlRLwpuiEr5KO4VYmq99+oGYDokZJcaUdT1+8GBxZt61Pdlrjr
	ZmGY3A0HjZA==
X-Google-Smtp-Source: AGHT+IHBtBt0melMP/941oYXa0vVH7OZH3aenL4Kw9O2PYK6hxNi4eRNYIrP05gwMoXtmU/UJybZs08dZIpK
X-Received: from ywbhu13.prod.google.com ([2002:a05:690c:490d:b0:735:7dc7:a248])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:b88:b0:734:d4e4:aa7f
 with SMTP id 00721157ae682-758a66e1ed7mr27117837b3.48.1758654543965; Tue, 23
 Sep 2025 12:09:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:08:50 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923190850.1022773-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Fix SD index calculation
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

In some cases, it is possible for pble_rsrc->next_fpm_addr to be
larger than u32, so remove the u32 cast to avoid unintentional
truncation.

This fixes the following error that can be observed when registering
massive memory regions:

[  447.227494] (NULL ib_device): cqp opcode = 0x1f maj_err_code = 0xffff min_err_code = 0x800c
[  447.227505] (NULL ib_device): [Update PE SDs Cmd Error][op_code=21] status=-5 waiting=1 completion_err=1 maj=0xffff min=0x800c

Fixes: e8c4dbc2fcac ("RDMA/irdma: Add PBLE resource manager")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/pble.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index 3091f9345..fa6325ada 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -71,7 +71,7 @@ int irdma_hmc_init_pble(struct irdma_sc_dev *dev,
 static void get_sd_pd_idx(struct irdma_hmc_pble_rsrc *pble_rsrc,
 			  struct sd_pd_idx *idx)
 {
-	idx->sd_idx = (u32)pble_rsrc->next_fpm_addr / IRDMA_HMC_DIRECT_BP_SIZE;
+	idx->sd_idx = pble_rsrc->next_fpm_addr / IRDMA_HMC_DIRECT_BP_SIZE;
 	idx->pd_idx = (u32)(pble_rsrc->next_fpm_addr / IRDMA_HMC_PAGED_BP_SIZE);
 	idx->rel_pd_idx = (idx->pd_idx % IRDMA_HMC_PD_CNT_IN_SD);
 }
-- 
2.51.0.534.gc79095c0ca-goog


