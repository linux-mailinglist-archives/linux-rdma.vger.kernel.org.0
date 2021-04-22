Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC41436848E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbhDVQO0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhDVQOX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 12:14:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D4C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:48 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k25so46335540oic.4
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=IW/mPVUJufkGue/67Mtdq0NwhZxifMkb8SuDdD2lu8yuE0MiHUk8hMjU+9Oyrw79+Z
         No7SiuotmRBftWMgnfCkZeSdFnUvlJep649PO84HtjXtgoIKsQctqJpJjiuBB7hUH004
         OfQkOaCPgH7/hngDAqNNJ/nU71Ij1x5cdGFwEiM3L/m8f7trO5mx/svaZtg+0illiN9U
         KNyPg0SEA9Db0RtSVxvJneKdYySolorldOvDIptc00zwDk0CaU33hvhiBqP/TQael/ul
         Mg2CJrnqQjdBK2TFMCGJ+urmOHmHYHRyWlqBMSjTWE+EjMLijTm9OzTUqeFWMN1RChLd
         CguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oK6GdjgEoldENJJRDmDumo1Lxa+DQ2oSoWDS5c4v9I=;
        b=a+Y4H1hwy+W9uBKNFQHYo0RpeFNBVNzyeWyDIejTQv6E3DBGaQ2+7I4k/X+ICgBefi
         MBNG/GI/Hiohk3In6Y1DzCn0gmhSCnUtEvBZCRDgC/Edilz2bdS+9gJ+ZhQP59rUm3vr
         4v1OAlGfmokMdEEGTCbo3AcT9hEs/kJcajRzlzxY89PWp6SlWHj2xYMZEuHsKyl1hdDR
         R1i2NVQ8ZA22Pz1s+yweRnU43lnTltOwHKYBw0GvLGd12ybk0voYTadACpvwl7SMxWm6
         iM5kFH2/VyAPuDbb3yx56xoL5O4bUwNgU3wb3ofQut6Xe+PsG076+tc2HJQWEQ6OJv1v
         7JYQ==
X-Gm-Message-State: AOAM530MW4L1L+5uXTXBf38VM7SlpTiTPavYwvc7k8dflaMaUySx9wjd
        veyxlHD9ZvNRhtyYKS2gBU8=
X-Google-Smtp-Source: ABdhPJzMcdzx6787v8ikpnWLa7+fuk7dL7toQqyMpU1udlDgFbbpsWCjF10j0HGbYU5VWphCXUslTg==
X-Received: by 2002:aca:5395:: with SMTP id h143mr2649552oib.27.1619108027565;
        Thu, 22 Apr 2021 09:13:47 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id k8sm630312oig.6.2021.04.22.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:13:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 03/10] RDMA/rxe: Enable MW object pool
Date:   Thu, 22 Apr 2021 11:13:34 -0500
Message-Id: <20210422161341.41929-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422161341.41929-1-rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
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

