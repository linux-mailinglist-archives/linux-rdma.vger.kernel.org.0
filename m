Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6F425DBA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhJGUn1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGUn1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC8C061570
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:33 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so9046138otv.4
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsIAYwzznZD6Db2echMgTKqJJdNRBioS0R3C8i4z0Z4=;
        b=p8gJvYiwqfpvt1LUHe9wPYO6YVCxlaVTy2v/WHeWuWXutwaGunphksDIS3fxJWn15d
         kKr2WYeTTxwplt6SgngFtS3x86ecM3T+HoehjoD3+s9+b6Qt25Ac+qscRQDYfglQQCzu
         I+IYWW9h1MputM2ekdSr4Pyz9HEUlhqR3zV3f5tKtxU+nmTVvjutglGerZ1AY07kQ0iP
         Fkoaq2VM2+d/8sS+lBje0JXDexO1a8cIcu2Ye8bR8aGdMJ7okozSfKAUBKDsNJPf0Fc7
         UjLRc+7641LpU0yGymbVCju57rjJKJfN7nc7obSmEdqpQQ8jO5P7SWi+l/KGOmVwEBc1
         AOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsIAYwzznZD6Db2echMgTKqJJdNRBioS0R3C8i4z0Z4=;
        b=omO3Cbn35WqmcOflarNvE92aAmajxXlb6qlxa+HbzCYMXwaZdB1ni/k46fFKp5XK/T
         zi206XGeiseIuEpkgyB6P609X8Bim+H1FayzIQKqiWvhyew8IQyRD2qGz0S3nDskavQp
         wCbOSsu0Z8yg2TnLrrbrGN3kyu7zCGAfWEGxGzuPd6IzYDa9iZ8RNZqDhEvsno69lwE4
         B3rtAUALpdWWqNM+2H3qSvN3DhTqJFPtsDatqNpEzsFDHwQledrVnzhHeEl18aOLJW9y
         2xVSXqQKwYAVd4nCeCd5KDK0uBaMMsWUBw4defD0ky1qnZ84vxybeHKOpihr5YRXGtEU
         LiPw==
X-Gm-Message-State: AOAM532mNx76RRWakgbHFuLu22JelyRI7Xq6C+zVMvn3xwBnGHlmIlPk
        hTt8FYKYZxYEgF8dETuhDM2IVxI/Pkk=
X-Google-Smtp-Source: ABdhPJy7NQMU4BGk8yWbqJMy/peyVDtmKOinmhxwFqzgrR/QkFrQpyb0jy7jn+ftKkpbTrDa3OA/Hg==
X-Received: by 2002:a9d:3e15:: with SMTP id a21mr5601375otd.60.1633639292931;
        Thu, 07 Oct 2021 13:41:32 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 2/6] RDMA/rxe: Change AH objects to indexed
Date:   Thu,  7 Oct 2021 15:40:48 -0500
Message-Id: <20211007204051.10086-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rxe_param.h and rxe_pool.c to allow indexing of AH
objects. Valid indices are non-zero so older providers can be detected.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v6:
  Reduced the max number of AH to 32K to limit the size of the
  index bit map.
---
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index aeffaef8f381..918270e34a35 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -69,7 +69,9 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_GRP		= 8192,
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
-	RXE_MAX_AH			= DEFAULT_MAX_VALUE,
+	RXE_MAX_AH			= (1<<15) - 1,	/* 32Ki - 1 */
+	RXE_MIN_AH_INDEX		= 1,
+	RXE_MAX_AH_INDEX		= RXE_MAX_AH,
 	RXE_MAX_SRQ_WR			= DEFAULT_MAX_VALUE,
 	RXE_MIN_SRQ_WR			= 1,
 	RXE_MAX_SRQ_SGE			= 27,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ffa8420b4765..7b4cb46edfd9 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -26,7 +26,9 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, pelem),
-		.flags		= RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.min_index	= RXE_MIN_AH_INDEX,
+		.max_index	= RXE_MAX_AH_INDEX,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
-- 
2.30.2

