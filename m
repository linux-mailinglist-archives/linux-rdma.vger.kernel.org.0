Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE7F367940
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhDVF3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhDVF3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA4C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n184so18703739oia.12
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=hPvMfKiIqx8HMfG0g1M2kB8E8NpoMRvILYy68NhqcYmkjaEJ2YnJllcZGAIpKaTCdi
         JqkmN462WN/2zMJtvrKPvNXTneAs1/n568mM42VCB6DJe2G9b0/9A93bYpvYcie1vcsU
         T7h7r9Le+sFci3zKcl9uaLiV99n6vXpRkGL0FrtqEctnSuY/ZWTjGo79FfEYa3cx2cUo
         tnd2S4RuFAGKPZFfvAjpoDGRgn6OT5JpfUpRHCMoLelpKsbW06wafesf+JvTeD16gPO3
         jnbocZ+xMrUt1nbKxQJc5vwNi3JX7v6KAp0C3QdEf/ODvlY1/IampE/PLOSBjWq8YLz/
         AWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=JXEDmFMfQFYW/ryzKwkM9FnXBJHMqa40BDu1HWRlXHkyvhNXYrG+aB2Z9CtFqzs+mp
         Xa5+mFcQDmRpqUZEtBin188mVnmJWiu5jMmIk8vMagW/60c+SVuG9IIkFhSuxt+VuAAb
         OS9UpWZm34tZLC82JNm/9wu/fHE/YTL3qgMI+C5eibgLCrMFzrPKNwGoVSmTqIVLdXAe
         mmFUcXE1LORKJN3uUISca6yTufDrmvne6nIC4gpYc7D2AJy+vrAO/cVKadMoXsFVJjxw
         P8KGvblM8C3tRkb+08jc0xTCYddA2MEuGk1ZP8ozZPDCOmR5cdUCVUWM9TUphMQsGjxy
         YpIg==
X-Gm-Message-State: AOAM530sdcpS4vAf1euTq/0QwtBhoLLsPUugSBHcbHhF3pyScKJxC05X
        9x3qbJDpIVSJ5qvY8o8VMa4=
X-Google-Smtp-Source: ABdhPJzlBpbYbZIbeL7K00/3wHEYwSeq5TlQIW1X0z1HO1ucky36iQAoY+y8qPDi5Xex6Dzp7OltzQ==
X-Received: by 2002:aca:4107:: with SMTP id o7mr1067449oia.122.1619069329371;
        Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id p11sm398358oti.53.2021.04.21.22.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 01/10] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Thu, 22 Apr 2021 00:28:14 -0500
Message-Id: <20210422052822.36527-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422052822.36527-1-rpearson@hpe.com>
References: <20210422052822.36527-1-rpearson@hpe.com>
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

