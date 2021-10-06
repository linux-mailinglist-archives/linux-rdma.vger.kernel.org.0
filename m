Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DD4235A1
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhJFCAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFCAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:15 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C9C061749
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:24 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c6-20020a9d2786000000b005471981d559so1236950otb.5
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ln2CICo8MaUfdlYX/StcL4ROVFBeevggZ31VqY1hkwM=;
        b=XGW/8Xkv/uddut++lyRdHr+L2fNwkYIUZQJDvMpBEi81Mp+cD2dum10LEZpadqlB4S
         0Kj5odIuN6Iii6Z3LFO9CiY7AK81QLLWLW228ZEGU25VInIZ7M4Sm8YwdbFlC8kHuVIe
         6nm1l31XA8slAVK47PRrwGI4XBLrWIVmIjFrSghI0iodgGFGjh0bdOmLy1mbmbLAJEki
         kNaZezUkmfYtvVZz1RXA9XY2UlG6tj6atpHqA1cA5QyP6mogGT/KdDCu0k8PPMqveCem
         JpOVShVvCtFD55GPXcSqKdcaMm6QqbP8IUtVnkTn48LOWoWPxyJQvtD9ck1ltBdmFYpR
         7GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ln2CICo8MaUfdlYX/StcL4ROVFBeevggZ31VqY1hkwM=;
        b=L6ZdXbJuUuHXEjHe+PqlgQf7K9TYWe7t7IGsiXp/BeseaqRCh7ibRIHhgmd/6ibUDy
         FCKq6h9qasddAC7v02qiDc01jEnjNPzbK6UXJBAzYu8Ys8GDGoBBCrLGHGngToMNTLBv
         V1lGz7caMpu5HwTDjd+xZbPpLrzRbnykkb9Wsu8lFR982vkCJ93nCAaG9ToSBTE5e98L
         b2E/dQmO5HosDH4dnoF/SOAGaUlRbDyiyyv9pF3gRLfWYG9nxyrdR4YoCJ69Unykyd9v
         8KORK3aBlUoAQUrsZ5sdDSL00mYMZK+8uhQ12Vbxxx1DOn+uGG534nAJSZUp+HHaH90P
         g8og==
X-Gm-Message-State: AOAM531g/7B6KPEbQFQ79KIODrjAH+iM7dF78jtnKSHlWlZR7xh94lgR
        i+qkzksRIK6yMfJBO5Hzq/U=
X-Google-Smtp-Source: ABdhPJyTinWVupIbu+RpFPOc8bvKbhzxSeHCw/+1zQ5Fm5OtjPeOTSv+ctOdUET+1Ef+0XYg7vrHzg==
X-Received: by 2002:a9d:bb1:: with SMTP id 46mr17261979oth.243.1633485503842;
        Tue, 05 Oct 2021 18:58:23 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 2/6] RDMA/rxe: Change AH objects to indexed
Date:   Tue,  5 Oct 2021 20:58:11 -0500
Message-Id: <20211006015815.28350-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rxe_param.h and rxe_pool.c to allow indexing of AH
objects. Valid indices are non-zero so older providers can be detected.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index b5a70cbe94aa..d92d7edd712b 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -67,7 +67,9 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_GRP		= 8192,
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
-	RXE_MAX_AH			= 100,
+	RXE_MAX_AH			= 16383,
+	RXE_MIN_AH_INDEX		= 1,
+	RXE_MAX_AH_INDEX		= 16383,
 	RXE_MAX_SRQ_WR			= 0x4000,
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

