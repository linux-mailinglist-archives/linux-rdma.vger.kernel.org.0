Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C136EFAA
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhD2SuA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhD2SuA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 14:50:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EBAC06138B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso29303603otp.7
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=dzkkKSYsZ32V9R8D0SBD8X5d9Nu5ZthmUosFH8AzjOYDjpf1NaXGeYmtiED97Dr9d2
         FumxLu2b2MgioGcxdDdNiRIE6l/dz2evZ5nbOdomAEpeBfVwEmVvYxyM78eDcwRwrZGQ
         FlfNiLVY4koxaGh3nqw6dqODlzuvVV668rpglUCTkg9VeZVplg+hsrdQFpQYx2cD40U6
         2PvCUety4J6actF1EApyr6Afr5itdko4BZDfVFFuFCnBPYEogK3Tke5DV7gdugkNwajz
         /s6OXA9kVSRA0xj4023kF9WfUo5vBOyGMLwbeaA5sz4XFY2+k+kVU6TgatdbUIvUPMQ1
         lZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=sHZET/hDzQgiUGW6MtB4ZB4p9cNhRk19V3lZYvsaXGnwjyCZ7j0GN8gs6UoZxozM9o
         oQAzDL2YT3ZThaNgqpZj9HXzFIBSETc4PoDcYf6keR9Vk4+KAN4y9U17HrU5Qyl1lKo+
         /ZmGqpzydVbtpsFqPnn7ybOstcTE2K2BXe4rIgoJBjtchdJWNtXz0RJOB9YSk3nYYgFp
         6hsb4TpeVI0cwD7gv1Q/PnWlvVNACl3UTQloSHW6xp1LqQYVUzNOi4icrSWTW07MUPve
         2Qf7mJAu549rPpiNRZWPaJ7K5gFpEPd3IQsRPgJMi+V+0gqTYS+2jwB8Oam9JKLv0fZM
         cYKA==
X-Gm-Message-State: AOAM531pX9diZlX5O57Wv1nrY/KZYYMdFmqZXw23GPYnwqeEw1coNz3v
        AhKVdNkoT1gvb+IqYYBT4vY=
X-Google-Smtp-Source: ABdhPJxmAyNsbQy0m+QE5io6xn9AJ6rjES9cqgJmvnBNZA6O4RSlZ/y36H2ngEez8kLTytziHCFHiQ==
X-Received: by 2002:a9d:d05:: with SMTP id 5mr649132oti.312.1619722152711;
        Thu, 29 Apr 2021 11:49:12 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a63d-9643-fc29-df2a.res6.spectrum.com. [2603:8081:140c:1a00:a63d:9643:fc29:df2a])
        by smtp.gmail.com with ESMTPSA id r12sm140657otq.28.2021.04.29.11.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:49:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 03/10] RDMA/rxe: Enable MW object pool
Date:   Thu, 29 Apr 2021 13:48:48 -0500
Message-Id: <20210429184855.54939-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
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

