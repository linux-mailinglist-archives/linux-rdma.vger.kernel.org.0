Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82906358F5A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhDHVlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhDHVlR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:17 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993E6C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so3734037oty.12
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=IEFBGvxnmGAfFdQoLX08xc+guVu3e6xhxxy93Gwnji5KgVXj+4f2Llhr7SgD11a8Fr
         cuf58Up13HmSoycFrfn+nK3w8GGqhneTK4oBNPLDtDn2XFEUQm/Layi6nQpgyKlf2ZaG
         0Hm1riVKBJKgqqfUrDvAKQy5LtZouQ+QU7lnqo6w7IbOizbyYsWmmmioXQb67T7uR/hW
         RH4irX6tXAM1VGfIbhdo/IFSktg3ThOpdwGIrwQhDet12/MmOADVlxIRLnQiXj0JJcrj
         OleLHSHwPsMsLhv5x1IL2uAgnNaGv76MLc8Vz9GKH7c9wDgGdMIf1BpojyY1sWeGVabx
         NyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=A8mkmIAJO81YT7hcvu7tkGUy3KS68Xq05939V82dmVSJJ4lQU0HY9anZPnzAT2xZ/0
         m7rs0oMqYGOxyxlTN2XuWPp3b8eggQTSXYwmdFxcsr8+IGjjrcFrWDDHdv+tqiXqSBkZ
         89mP9g4KgRmBbu4JKGsVVqnHYyWCRQlr4YQ2qF9D+Z/tK4SB+PMZwpeHn6MLanxDqwBg
         WRn++lm0ye396psjzcsP4U90MAthB1036H0yFPn+s/Rq7Zn85F0rm+WWHFWrYcLwGcCT
         FAXHXtnPVmDjYCyFQnt7ScNphISr6O2LjsFW0/J+2fmu65YPZmRHnMZQGoB1vt7FBpTF
         WrcQ==
X-Gm-Message-State: AOAM533+JUuVEaFmMJZK63zvbxSKFWRhbGorilII4mMHwiMBNrIuObzU
        p3LpJH9zrrEI0CW9Sb72PkalpBiXdAE=
X-Google-Smtp-Source: ABdhPJwmt4qTcczS4JoJMPpreo0wrub3BFYEn/KFHmKU13zlfsRud+yzWILpfZoWEtsoE0LVykoNDQ==
X-Received: by 2002:a9d:1d26:: with SMTP id m35mr9645215otm.266.1617918065051;
        Thu, 08 Apr 2021 14:41:05 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id i15sm139756oou.10.2021.04.08.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 3/9] RDMA/rxe: Enable MW object pool
Date:   Thu,  8 Apr 2021 16:40:35 -0500
Message-Id: <20210408214040.2956-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver has a rxe_mw struct object but
nothing about memory windows is enabled. This patch
turns on memory windows and some minor cleanup.

Set device attribute in rxe.c so max_mw = MAX_MW.
Change parameters in rxe_param.h so that MAX_MW is the same as MAX_MR.
Reduce the number of MRs and MWs to 4K from 256K.
Add device capability bits for 2a and 2b memory windows.
Removed RXE_MR_TYPE_MW from the rxe_mr_type enum.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_param.h | 19 ++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 95f0de0c8b49..8e0f9c489cab 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -54,6 +54,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_cq			= RXE_MAX_CQ;
 	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
 	rxe->attr.max_mr			= RXE_MAX_MR;
+	rxe->attr.max_mw			= RXE_MAX_MW;
 	rxe->attr.max_pd			= RXE_MAX_PD;
 	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 25ab50d9b7c2..742e6ec93686 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -37,7 +37,6 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
 enum rxe_device_param {
 	RXE_MAX_MR_SIZE			= -1ull,
 	RXE_PAGE_SIZE_CAP		= 0xfffff000,
-	RXE_MAX_QP			= 0x10000,
 	RXE_MAX_QP_WR			= 0x4000,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
@@ -49,7 +48,10 @@ enum rxe_device_param {
 					| IB_DEVICE_RC_RNR_NAK_GEN
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
-					| IB_DEVICE_ALLOW_USER_UNREG,
+					| IB_DEVICE_ALLOW_USER_UNREG
+					| IB_DEVICE_MEM_WINDOW
+					| IB_DEVICE_MEM_WINDOW_TYPE_2A
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
@@ -58,7 +60,6 @@ enum rxe_device_param {
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
-	RXE_MAX_MR			= 256 * 1024,
 	RXE_MAX_PD			= 0x7ffc,
 	RXE_MAX_QP_RD_ATOM		= 128,
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
@@ -67,7 +68,6 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
 	RXE_MAX_AH			= 100,
-	RXE_MAX_SRQ			= 960,
 	RXE_MAX_SRQ_WR			= 0x4000,
 	RXE_MIN_SRQ_WR			= 1,
 	RXE_MAX_SRQ_SGE			= 27,
@@ -80,16 +80,21 @@ enum rxe_device_param {
 
 	RXE_NUM_PORT			= 1,
 
+	RXE_MAX_QP			= 0x10000,
 	RXE_MIN_QP_INDEX		= 16,
 	RXE_MAX_QP_INDEX		= 0x00020000,
 
+	RXE_MAX_SRQ			= 0x00001000,
 	RXE_MIN_SRQ_INDEX		= 0x00020001,
 	RXE_MAX_SRQ_INDEX		= 0x00040000,
 
+	RXE_MAX_MR			= 0x00001000,
+	RXE_MAX_MW			= 0x00001000,
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00040000,
-	RXE_MIN_MW_INDEX		= 0x00040001,
-	RXE_MAX_MW_INDEX		= 0x00060000,
+	RXE_MAX_MR_INDEX		= 0x00010000,
+	RXE_MIN_MW_INDEX		= 0x00010001,
+	RXE_MAX_MW_INDEX		= 0x00020000,
+
 	RXE_MAX_PKT_PER_ACK		= 64,
 
 	RXE_MAX_UNACKED_PSNS		= 128,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 11eba7a3ba8f..8d32e3f50813 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -273,7 +273,6 @@ enum rxe_mr_type {
 	RXE_MR_TYPE_NONE,
 	RXE_MR_TYPE_DMA,
 	RXE_MR_TYPE_MR,
-	RXE_MR_TYPE_MW,
 };
 
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
-- 
2.27.0

