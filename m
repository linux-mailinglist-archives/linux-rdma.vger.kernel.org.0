Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67014355B6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJTWJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTWJp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46FAC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:30 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so8759028ote.6
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPersv+1bSjKGYzblCBC5jYPMG1NT6+omf3MmqVlrak=;
        b=fQWDxNSQxAtrw2O8p6IXZSNk47sPNuS3D9uKF2h1pvb/bB4PC86je+lZyUuc2cP4dd
         9v1dIUyg2CE9dWj6AiDzMuqH4PJz6u3Tj6h69opQ8Bo0iby37k4kwgZdRE9stYiOSg6g
         aMsFeeNH/6r0Q2NfSUG0BdQAygDvN05QMD2TWEwqsh/2G41Set40yfbU39b5lFHvvlZa
         cXeK4cvc8YJelNdcpAGzq3fk0WXPsbd29C1lBO/zub8JgimHMgs7+zRMpSKPeDEr8OyY
         NQdHp/gxe6nTETcEN4kAAEooU9fblhP790EI0+iOiu0yJTsABNkNFYeQkPZDRgCaDyd5
         zLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPersv+1bSjKGYzblCBC5jYPMG1NT6+omf3MmqVlrak=;
        b=i64CpPWtM1pqaufcAScEU3PtlOQCOPHtfB9R5FFB4rsrdPxZXGKudOxCGCa8IFNqjs
         jBAHI5B3GbarUnROQxqvKEsMk+sLDLqKTTN5D7H9ELskcLNCaLEGovhQrzsZ1KroJTnW
         kIZCd3Emd20niHje+C5LuT1zZ6IH/y07WIw0mNNkyFqOc17BybBB6ix0DSCddXsW6zUI
         N26dzlm4PuARXYYOudTN2Fs9LAAdhByLeRlxwgGvxlir8OklAHhitIFMnvecsKlkKlnR
         90GqgxMMN1iMJVWV0LZjVTYjmbLLva2Ns1KgjF8h+DV6/zYEALZsx8nCudlVH863ONir
         ahAQ==
X-Gm-Message-State: AOAM531ELwCwDM7FRiZ/Ui63xoZO1QMAbXgGQPs7no81TPoR+p4gn2Dj
        JgBR88Hm58xsglZCRenDHmg/DCWEP7M=
X-Google-Smtp-Source: ABdhPJzEOq1UHNqS/qgBVtfLlX540dycaJGrDK1iX90w/8WMGr46iWWKZz3/WComUCdIbnsG0RiRbA==
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr1512744oti.139.1634767650096;
        Wed, 20 Oct 2021 15:07:30 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/7] RDMA/rxe: Convert remaining pools to xarrays
Date:   Wed, 20 Oct 2021 17:05:48 -0500
Message-Id: <20211020220549.36145-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020220549.36145-1-rpearsonhpe@gmail.com>
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch converts the remaining pools with RXE_POOL_INDEX set to
RXE_POOL_XARRAY.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 1b7269dd6d9e..364449c284a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -25,7 +25,6 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		//.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
@@ -35,7 +34,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.cleanup	= rxe_srq_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -44,7 +43,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -60,7 +59,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_XARRAY,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
 	},
@@ -69,7 +68,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 	},
-- 
2.30.2

