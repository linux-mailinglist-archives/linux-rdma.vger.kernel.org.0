Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E971E1AB0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 07:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEZFUe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgEZFUe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 01:20:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37443C03E96B
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 22:20:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so2399914wro.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 22:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgRGqPWFACxtLji7QENFAvWGb9sS86YebxHqcxZ06Ms=;
        b=VnRaQ0z8/nfrX1FwyzbakQI+e6mEqMFvRHDHnu675GAjNRtx+s7u1t7cAsFWN/rmng
         1XCXEWQ7LZwt2K9Q/eTDbo0z1877ODDp+A/bh9WIQ3PJkfUPlJLUK1e7wbQ5nsSjxFOO
         AvnPQ4crg1UXRp8+qaLVII+6abJlgVRX5xSmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zgRGqPWFACxtLji7QENFAvWGb9sS86YebxHqcxZ06Ms=;
        b=GXNwG8rT+lbUxEt9FfbpoJoCPg/CkeU2SM3xOi5b7C1d9LY4WEkE1+WkebNv/VqteQ
         EBf4CE9jPAo0Pi/7N2yBcoQB5FyNeJtGGLz0YdR8x8eoYM9PgxPNKe2WwPEX6J0sxKqW
         OtBiJaSjA+m5uiOtuF6R9EC+LEPbHP7VCdl+hlTs38TGcJT/tilalEBUO6EgrJsBSxFu
         5mKELoYG8fEUjGxEgqHeHLNumy823UvLwk8kKXrLDQ2v6s0Sh6X15K234gAxrnEnyLVy
         PyISyETvgNwSXRdbx74+2i63oYyOcxTOzhl0zIovnsgkXwObEZDaORJRwauJjAgSoV1e
         pqDw==
X-Gm-Message-State: AOAM532hjZQeZJOWkmjgyUsCOiWwDdM+bhFTuFeA87dpCXKRp2TDkAnL
        HIG489HO3IiChlAdPkFlOmqWIQK0phB/chfIy2evskAjPjaXwUoN5yICoGn0taGC5inolieQYlR
        LeKtuoVcc4aNeyfiUlSX4YmgWRHjkFqEtM3dZdBPpuq5n8oe2zKIqNZ1yMxVP19uWYUVjqQhw4O
        Cl4AY=
X-Google-Smtp-Source: ABdhPJy1hvkNPTMM2+FZUF06Ot55yXbtwVkygMs8maiY4UodVwBU4ilAyYjQ3LCYoOlnUSCOobBRTQ==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr14894547wrt.104.1590470432488;
        Mon, 25 May 2020 22:20:32 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 40sm19807069wrc.15.2020.05.25.22.20.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2020 22:20:32 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: update ABI to pass wqe-mode to user space
Date:   Tue, 26 May 2020 01:20:02 -0400
Message-Id: <1590470402-32590-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
References: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changing ucontext ABI response structure to pass wqe_mode
to user library.
A flag in comp_mask has been set to indicate presence of
wqe_mode.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
 include/uapi/rdma/bnxt_re-abi.h          | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e1dbdf0..153708d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3935,6 +3935,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.max_cqd = dev_attr->max_cq_wqes;
 	resp.rsvd    = 0;
 
+	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
+	resp.mode = rdev->chip_ctx->modes.wqe_mode;
+
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
 	if (rc) {
 		ibdev_err(ibdev, "Failed to copy user context");
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index dc52e3c..52205ed 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -49,7 +49,8 @@
 #define BNXT_RE_CHIP_ID0_CHIP_MET_SFT		0x18
 
 enum {
-	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL
+	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL,
+	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL
 };
 
 struct bnxt_re_uctx_resp {
@@ -62,6 +63,8 @@ struct bnxt_re_uctx_resp {
 	__aligned_u64 comp_mask;
 	__u32 chip_id0;
 	__u32 chip_id1;
+	__u32 mode;
+	__u32 rsvd1; /* padding */
 };
 
 /*
-- 
1.8.3.1

