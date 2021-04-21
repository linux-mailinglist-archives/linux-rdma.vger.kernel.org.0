Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00A83664BA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhDUFVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUFVX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 01:21:23 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F12C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v6so13505733oiv.3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=Ca9M3fthzvNXnOZgJl2RIIyE5+n5ttY/4N+YiFwzQ/Ug5x7mX8odNKbyRFHVH1kocK
         e0fhqR+hdzICuWr2MCELlAEYdSArxQed8C6EahowUmZvDjNt86MlHnRVFalvLJQDcXMe
         fpbcoA2/aFkbONxB2UjssGIoTI+NLd9CWXYGVxOJ8iD/cWk7EDBFMITR4O7T38Amz1Il
         +JlMMXlaeaPpPKJY19gvddwz6MqInF+8yMnOvyjoy1/yawIk6EfUFM7gyIS8XFZ5ytPF
         DaXgBzeUDfzyjW5mBdnEceg1kpPFd6SdqYvLZkTQIibni6fL/6DENzFNvfotV+64hFqc
         IidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=ok91jRuIjyE03eYbARkDpJGaiAtvTK00FswmofNnQLSsKu/fxq/EVYylDbd0Lm4M6Y
         TM29zTxA2CC/IAOWimhi79/xBPJd2eM2k5wwYlDkc3aK5l3OnWBEThcN0Fza8pmETwYj
         Bv45sZ3HLjW+X7zJBwuZtgnriL6J9ahtD2Tlqa3Bz3uRgDrrN0R81xCDTBGFa4sO5YTB
         QkTiWs/WblCmmt/HBS0i7oiRGYve5t77ys1vYQ0mJZZuwY/9ZX63uvULAjaIynd1F6EZ
         nhnLqizMLl8+2iUtFV5Rng2R70JUMk08xEq236Zc59jC660oqopIW4AxuK4hiqyNqxAX
         KbgA==
X-Gm-Message-State: AOAM5333qozR6KY0EX4DORT8B8K33I5YRQKgY17KBzu7Vlr+gkL9TXxE
        RffKkXG06nqBoaw8h6dRbPA=
X-Google-Smtp-Source: ABdhPJxLPU7ncSnuMeFBLPZUoZ7Op0coDWdAGIaSEH2E6RTiMOXCKnIoVGVX9ii++8dEqisbAGpbag==
X-Received: by 2002:aca:309:: with SMTP id 9mr5499871oid.12.1618982450416;
        Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-eeb0-9b2d-35df-5cd9.res6.spectrum.com. [2603:8081:140c:1a00:eeb0:9b2d:35df:5cd9])
        by smtp.gmail.com with ESMTPSA id m127sm285457oib.32.2021.04.20.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Wed, 21 Apr 2021 00:20:08 -0500
Message-Id: <20210421052015.4546-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210421052015.4546-1-rpearson@hpe.com>
References: <20210421052015.4546-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to
support bind MW work requests

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 068433e2229d..b8f408ceb1a8 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,7 +99,17 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32		mr_lkey;
+			__u32		mw_rkey;
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} mw;
 		/* reg is only used by the kernel and is not part of the uapi */
+#ifdef __KERNEL__
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -108,6 +118,7 @@ struct rxe_send_wr {
 			__u32	     key;
 			__u32	     access;
 		} reg;
+#endif
 	} wr;
 };
 
-- 
2.27.0

