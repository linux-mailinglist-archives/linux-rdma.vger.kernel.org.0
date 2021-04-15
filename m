Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF5360024
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhDOCza (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOCz3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97355C061574
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:07 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso7227895otm.4
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MK42KVbA3kvbffxu8KFqlSIa4lI0MxcKuZHovFZqVm4=;
        b=CSH0De3Y6VLCFzAiDURJZ6WpKWQvCfg741ZQgyLuP4q21Kpi+7nAt3RhNPFafWPbO/
         8OnqfWnYHsS+mZTjNOs3IBMKT7wzR6L2hR4QCU/F3f1LcHVpNpkoiXXTyNMr0v8+6p2z
         RtuXuK9GheT8kGCAz6FVofV8ITHpyW3SrVtgde5HXZyTt6n4nvcKvOGDcexOvWM20oba
         Lch8Pfv9EGTGxmLREM+Z0wFUfwXYPSXn8pLZfG5lbKJVUv8XZHOsL887syEeA9TBrm01
         w+r5h7fbuR22yXuN18SQo8jm59ntFXludQ2XfXiEAQv0n7FUtOa8yMlwlI00WTwZMosa
         RzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MK42KVbA3kvbffxu8KFqlSIa4lI0MxcKuZHovFZqVm4=;
        b=q08rl05IaALXJlyiIEC3GLV6jildApuqRrgoSLfOPtYPoKAijjyKrifjN5g9VmnXmy
         Yr51sx1b2XCJQmKvx4bWlHZv2W2ZLfPKfvA6cFqrvu6T3DyLaWWmU9YBJ84d3K0gl88n
         GAE5+ESwtI7uzolaH5cl8HVBc8RmJ0GTZic/fUFscvKU/TjGXJM/qSzBIUufnKu73dck
         XrEx2aWkms7OvDGxs8xn6rZdMXXgh5WKiCpmpA9lROASJVRa0O6/wpcVhxSq9ZAlmDVV
         l1Qq+dLLiqYrc0Nvpy0740Bm65sosurHIERV/RZOjl40xuHoEb5yKflf1h8CpErp2nmx
         khnA==
X-Gm-Message-State: AOAM532pmuVSPMwVjIjKy9zMtZ6cODPdGZlIjZGbxcxQANqPJNFbx9cU
        /AIBQnWIjqwOr+13iTDt+Y8=
X-Google-Smtp-Source: ABdhPJwxEOvP900GlMgMQvF+Hqp87p5vqUPThShHR7in0MbVkoo1ACGABIJzPvLzB3fpIXgv2QGaKA==
X-Received: by 2002:a9d:d0d:: with SMTP id 13mr877813oti.134.1618455307118;
        Wed, 14 Apr 2021 19:55:07 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id s84sm337044oie.39.2021.04.14.19.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Wed, 14 Apr 2021 21:54:22 -0500
Message-Id: <20210415025429.11053-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210415025429.11053-1-rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to
support bind MW work requests

Link: https://lore.kernel.org/linux-rdma/eba02326-013f-1707-0db7-209413d2cd6f@gmail.com/
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v2:
  Replaced umw and kmw by mw which will work for user space
  and kernel space if ever needed. Not currently.

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

