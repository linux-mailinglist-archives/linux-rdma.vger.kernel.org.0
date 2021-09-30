Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9741D262
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbhI3E27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347778AbhI3E25 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:57 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A90C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:15 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso1456214ooq.8
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ln2CICo8MaUfdlYX/StcL4ROVFBeevggZ31VqY1hkwM=;
        b=AdYUQ+L/aOETahwfp8KyKdKjl/m9cE3+KGu9vvbeW3BQBY2ie6HMgEL5nbyUNtQ+gJ
         c58CG04lE67zWgLoD1luKAd3U3AZ1fAwVzzoPcwHAgnx3SQyy//lA/6hjVjMImMdmmSg
         ThFZQJWZULiDHl+9+ZVvHn5Lf/tQP/jv9Mv7z2PltUGE/MuEHglLqUQ2vc7g5zUJ8W4N
         46DlSJcz6gkIzqBftXDh8QSYDXBKqs6uX/f0XJmA4jeuUZ3MGl6nAzFRykHe+rCPOXlU
         hIv926d1q3uJ7wTgO0HU/C+yiyD0jAMytITRdK28yZLnn1zUY6d0Vaupt/li32ITVJRO
         /Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ln2CICo8MaUfdlYX/StcL4ROVFBeevggZ31VqY1hkwM=;
        b=bi7mBNb9FvVMB1bGeTrxqQdCouiJ1InwUn2htUkFPWGdali0tVR8f9DOG60oOUfzMH
         +5QP696S5VLvK+phajFYZy/iGV+ZdaR9VsgxEmwTEhp87Czv5qUQ9rjswj2CzWCo6D41
         5969LwE35Myt962976Lr/YQelR1pK80d+/1avOrLh8KNfe0IOPD5Q5F/ORyvHcqovmPh
         315Vnx002PCxUXdvr3klEacHsu9kh8Nqs6E6QLjcOxb6KzUpVTnxni4D0Ww5brivEWm7
         AQqGpSKXwa6qDW956Iw307kmOznYpch0WmJRxhS5vm47Wz5tQIClAx+kTnLrFlGixe1P
         Rq5g==
X-Gm-Message-State: AOAM530nv8Fwq/zNlmyQ/NBhVYyUX6kro7pMUbRGcVFK3Zah9MCJ4/EE
        bW0l8ALGeElAzDfc94+TBqk=
X-Google-Smtp-Source: ABdhPJznPgBENUs41cA7tEpRnfFegGC9esdb5y5gfQNSHPfEQzXadfnl0e5on2QVX+Seq9CN1YgOcA==
X-Received: by 2002:a4a:d883:: with SMTP id b3mr2984461oov.82.1632976034903;
        Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 2/6] RDMA/rxe: Change AH objects to indexed
Date:   Wed, 29 Sep 2021 23:26:00 -0500
Message-Id: <20210930042603.4318-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
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

