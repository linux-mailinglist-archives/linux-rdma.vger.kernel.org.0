Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF63CCAD5
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhGRVai (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhGRVah (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:30:37 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66615C061764
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso3963758ooc.5
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0Y/ocDdRQ4XTDM8mFWl3U3xVeDb3pxbEATe5M1rfu8=;
        b=P+Pcp6VV0oOVpwZb0Fhky3M1wT1jN4l5pZbXEN8C0C3iEn4v2W6MefSKfZUl7cjuJF
         r/nUkN402KNF/gnUHMXqc6kcBMEjdOnPMuTt0xUnPi2cc3ANMQ1MPfKsYOZeVbLOzwyP
         GiHwwLw3Tc8b1l5PmaPLDU1e9jHL9moB7WnibeMFloWm4ySnw1nKC/DiGkv5nhgTRgdt
         Us/XB7SlWo+k+wP4tSMgZMbKKdNfJMKx3HPaTFGco3E7Sc8vdNnuE4/z26M80A26DRG6
         KztqxIQ0JNpAvzzZ2/3hlta/1t2SpD+YhSQ9MIiD0Vm3szCUroNrgTjoQKona0tu9Wq0
         jZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0Y/ocDdRQ4XTDM8mFWl3U3xVeDb3pxbEATe5M1rfu8=;
        b=dlY/02MmqsOp/xdX4bDUxO81hV3vmIEgPGnIP3vrz/yOtU72X6OcFgM3R9ZQg1d9hm
         Cs1Z9h+vIIioT344EcAlcMQ1J6DyuqVoFjG7jE5lWB3kvzMxN8K7DvQ2Xc+yPFT/Ytd1
         GTzog3x7fqvyXlQL4uy/Hz6NjEE5zsRaZGiP8a+cQMp/5GxfPq8pyHS4YGXBPKcPwyON
         2qjOHhU9xe4BnIrcoiMHlL0cA9722nRBH7WY7WkB6hlcmcYk2/YKjhRGk0P9pwdbrjmv
         WZyC0fLqEiR7uqw3n3n8e2ESaQnH/qttKWstT0wQcaC98sD/tJUJ91eXjcVmuCeLtigw
         +ETw==
X-Gm-Message-State: AOAM531NPZYGrVLkjuylnUjAaO3X7XePVckBhQR1TM/OnGYt0/BYCmaP
        +I6K9M6FwAeJW4dks6Hd5Zg=
X-Google-Smtp-Source: ABdhPJxY7xmLVGJbCGK8eMs5AhMZ8dCBjWkjeSwyw9K2dIeNsPcbrdCEFGb03zxhvuPg+tylRvnEpw==
X-Received: by 2002:a4a:98b0:: with SMTP id a45mr15598616ooj.22.1626643658863;
        Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id z3sm1268376oti.29.2021.07.18.14.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/5] RDMA/rxe: Change AH objects to indexed
Date:   Sun, 18 Jul 2021 16:27:01 -0500
Message-Id: <20210718212703.21471-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718212703.21471-1-rpearsonhpe@gmail.com>
References: <20210718212703.21471-1-rpearsonhpe@gmail.com>
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
index 742e6ec93686..ec5c6331bee8 100644
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
index 0b8e7c6255a2..342f090152d1 100644
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

