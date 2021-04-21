Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B125B3664BD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhDUFVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUFVY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 01:21:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C8C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so37952405otn.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=oy8MPaNwrY8cudppKnbK4f8WYzXpXfXV510oVM40s79+8l1XlVx/H8SiokfIhO2mO2
         qsbr1o15obWlKUqZrfxlTPdDr/YqHtGvoU7T7pQ39eBSC6y4A88uk+LH7ZfYx7vAP2cE
         sieJvBtB0K8GTpHYF/IOMbaxv6YycGgAoxPQhi2IjteICuCK47xoBP0rW8i2AbjOfhom
         8hrqKnNZvEdxWiWX4ZEwETzjrrjLNVhOHcHhQog4d34Yxpi5GWDt4l/BZQF/OgR7LCrI
         LhOk6hYG9X/oecQNQAX1dd9jrzYecTu3oxOSJfQrcbh7zerAo4iOBs6SVJ98kSBK/5Mu
         x/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=AJl7J8l+5Oe41z4GZOjmwm2yfvFR4u07KmiTa3mXDcZyANBYfbvfz7VoX5bzkn6fvW
         xBYnIx4g5wqfEx9HG9XevAseQcEMeWbYdpYI/JYanvH31gEJv3HbuFFxmypIOdL6GYPq
         tNQuj2pHUI2H/a5v0ujmEKdgM1qKquV0dHKX+C6CjTrJfS60UJiU4QxurvDT+WXgYk9g
         1et1qadHL6auScn6DjqzUdUX7D9eCat9NChaNW6hc3eecH6845/iKOs35iw7QTn91KlY
         khegDPsVxOUtRDujo1CSqk5nmEonioPHfi87bqSjF2v+XHmQdR6GNZ47yOj3+sWcIbz4
         /mYA==
X-Gm-Message-State: AOAM530x3j2yqgscYV2ibbyCAxbyme6C3mf4u8bBa7JNkzjZZJ/0ed9r
        B4VVyTy7C6UHYZmXtA40lwc=
X-Google-Smtp-Source: ABdhPJzsUj+Qoadt1dUCuv+ptFCVAnjadpIEGNut3sluBwmY5pV2uqAxXzxMxTCSkhxZ+0S3gQOm1g==
X-Received: by 2002:a9d:4e05:: with SMTP id p5mr21894129otf.264.1618982451978;
        Tue, 20 Apr 2021 22:20:51 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-eeb0-9b2d-35df-5cd9.res6.spectrum.com. [2603:8081:140c:1a00:eeb0:9b2d:35df:5cd9])
        by smtp.gmail.com with ESMTPSA id d6sm283588oom.33.2021.04.20.22.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:20:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 3/9] RDMA/rxe: Enable MW object pool
Date:   Wed, 21 Apr 2021 00:20:10 -0500
Message-Id: <20210421052015.4546-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210421052015.4546-1-rpearson@hpe.com>
References: <20210421052015.4546-1-rpearson@hpe.com>
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

