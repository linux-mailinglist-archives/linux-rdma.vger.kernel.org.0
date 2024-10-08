Return-Path: <linux-rdma+bounces-5303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F499421E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667D91C246AD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0689F1EB9F7;
	Tue,  8 Oct 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NS9z3awv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096F1EB9F3
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374585; cv=none; b=aqt1a8bx/Ii7abmzjeTaQ3I7k1gnrvKP6HZxaBKEyaea4D6PS0PAgW9aKHS72bNHSGbweq7+Ea6uKHL4AQiTBrNxx/C4Uy3sSZhjgSvctXVWOasMjnLRA/F00b2RIdKJwgfcxh8SbPfaU9fdZ7vUnJLkQwyOgnDEVYBxw2Y+q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374585; c=relaxed/simple;
	bh=OCT11lcjA21jVWmrFYmXJ+ncbdW0sKC+AZk9S/UkfUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MeB3gANLpvFL1YIw/pLwOJLPXg35A3JXK4cI4nztMCUvue6HTujk/h2Mc6/4zGTfBt1SRAlmdcTUaBihsQ+buoKEiHigIN8Nxe8Bj8MqsgVYP9uDr5fmbbPlJaPrYH2YD4B7D33Xot3CM/UOpugL/o5s4AggLHk5kxIV+Y0i62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NS9z3awv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so4472816a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374584; x=1728979384; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JgySFIZselsz4WY2/sAXKF7ImiI6hJAWKQh+nzp8Izw=;
        b=NS9z3awv4Ow9bcdDiIG7a1c8xS7e6R1h/4Z7w/T+DG5gMbayZp+NYVTizqaQ/jVd40
         QwiyBwLCfFAYuXe+dKny9kSpX2Zwt/H8mVzp3wkyaeZ9Fmdz/Va3r1ESNOtVVWCNdoa5
         YOD3Uo+y7qdMQpafhTx2zKUZ7ZJ3Wvr+maZfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374584; x=1728979384;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgySFIZselsz4WY2/sAXKF7ImiI6hJAWKQh+nzp8Izw=;
        b=PmEaVCS4/178fElyTFlyFbEmw6ljVgPQj4uQBjU9cRDOKeJhXIfNlGIqAsHzt7k7FE
         nxDNfk80iaHaNo8hsPuWsOjzey4tOkjzm2ub//Log1xobp6IsJ+E0c/KIRiPA2Ah0Az5
         n1niR+LLMAVopyinc85NpzeqqfcGf7VOsyf1LaAY6v11Iu4EbZv/MVsUokkBLlZ2CLRd
         YC6V+u00mWcar9ogSkNEHyifm9cvHgHA9e0wPfvvguKcarRiBfueRnjhbFvM/Eima7B5
         Ph34BLA3tdMoX2k1dsziqfdMxpkMafsSSlu1LCjhj3IP0NIJH5usyXx3gPvSmoVi63fr
         zX1Q==
X-Gm-Message-State: AOJu0Yz5rqpQK9b1nPl2D2kQPH5cvVzMKUigR69yAyD4tx38tRJKAEA6
	Szxbhk0opwLegcK2FmEjiXiEJ9MmFsKQrJ/fCUFBFQL01yET4xZVR2D1wyp/saxXX1+8LMj5ebo
	uDw==
X-Google-Smtp-Source: AGHT+IEGP2Sup5wP29t/vJsgzXqECp21sCEb55VZqnx9uOV2JtVSpI4bdPxKxB7JdlJbOrwxZle08Q==
X-Received: by 2002:a17:90b:364f:b0:2e0:d8cd:195a with SMTP id 98e67ed59e1d1-2e1e6367761mr19135787a91.39.1728374583672;
        Tue, 08 Oct 2024 01:03:03 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:03:03 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 09/10] RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages
Date: Tue,  8 Oct 2024 00:41:41 -0700
Message-Id: <1728373302-19530-10-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>

Avoid memory corruption while setting up Level-2 PBL
pages for the non MR resources when num_pages > 256K.

There will be a single PDE page address (contiguous
pages in the case of > PAGE_SIZE), but, current logic
assumes multiple pages, leading to invalid memory
access after 256K PBL entries in the PDE.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Signed-off-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 1fdffd6..96ceec1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -257,22 +257,9 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			dst_virt_ptr =
 				(dma_addr_t **)hwq->pbl[PBL_LVL_0].pg_arr;
 			src_phys_ptr = hwq->pbl[PBL_LVL_1].pg_map_arr;
-			if (hwq_attr->type == HWQ_TYPE_MR) {
-			/* For MR it is expected that we supply only 1 contigous
-			 * page i.e only 1 entry in the PDL that will contain
-			 * all the PBLs for the user supplied memory region
-			 */
-				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
-				     i++)
-					dst_virt_ptr[0][i] = src_phys_ptr[i] |
-						flag;
-			} else {
-				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
-				     i++)
-					dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
-						src_phys_ptr[i] |
-						PTU_PDE_VALID;
-			}
+			for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[0][i] = src_phys_ptr[i] | flag;
+
 			/* Alloc or init PTEs */
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_2],
 					 hwq_attr->sginfo);
-- 
2.5.5


