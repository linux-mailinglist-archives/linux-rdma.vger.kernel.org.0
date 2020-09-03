Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C673625CDC6
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 00:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICWlz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbgICWlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 18:41:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC067C061244
        for <linux-rdma@vger.kernel.org>; Thu,  3 Sep 2020 15:41:42 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a65so4213781otc.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swjhoPychMlfdrobhEzYkeT+tWWpVO8N0DpdxGGbEs4=;
        b=qsB1z7abkOl9Ghn2XH2acW/NI68GWkvvmVpWxJ7b1MnHcbBbhAn3q8asY0kXYFhbnj
         zIbHZn//TB58cWVUohsMzkJJc5U59pxLrAxBWfFaFXdgi+TpLSRu05iceVtTgGG/dElu
         ADQt5VNZR0xCGa5ODH5Zg5Ci22WYKWMHAWJuUmGHif8j3E2HiYHNmNQNB9GmT/eQQFsm
         2Kua1zG+3uAtF1D/iLUwtISJ3JXgtrFjXv7KuzIAeZHr+eooy23bkE+pDzlhSkuE/wdH
         rZlpBq7mosuQm3IY8H1/rYdExP9kdUXyxedQoWjbIZnwJ1FIiLMOM1mwCnNQ2ieDwPKu
         0W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swjhoPychMlfdrobhEzYkeT+tWWpVO8N0DpdxGGbEs4=;
        b=H6o2E6JT9jRabJsYNozAQANYmO9xHO5Hb/2atUBDvwNSO7u9eC/l+/244enG1gM7bV
         P2sX77/Hd1pWvTlLD/6iC3XnJ6F9zbdRKSxX6ZZJplzASf+YYiD90hwysjjGREBdpVSZ
         GP6cAi58nxPAJedtYosxBi7B6UbfAUI1rByTtt9ICkKg4Ce2k8AX9Cly/uWnyN1OA023
         dzVlTIrIDJFKBKU4R6AEW88engrkDgIW6q9m0yHsEoBMs9wZ4pbvuobwWoq1V+dISFYd
         DtZd/3Tz4rVmDHXq7vP8hNwUpewyvvuCIJQEG+BZEMtdMZ0maQhzpA83ILaIDHkxniXk
         KRpA==
X-Gm-Message-State: AOAM532WnuLUDd9eL9xakQXsVfAQ7NNvmrnS/l5pFkaJmwfktw7MoRoC
        7NzwT06lasI9aqBWKNlqRvI=
X-Google-Smtp-Source: ABdhPJyhSkJVfPBG2sbdfhYKqLa/EdoS858aJI0BXLMh8TEde1RQkyyoVy3J5V8CufmT6daAMFyC2Q==
X-Received: by 2002:a05:6830:2302:: with SMTP id u2mr3242347ote.181.1599172902331;
        Thu, 03 Sep 2020 15:41:42 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:6a3a:fc5c:851c:306a])
        by smtp.gmail.com with ESMTPSA id v35sm818658otb.32.2020.09.03.15.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:41:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v4 for-next 3/7] rdma_rxe: enabled MW objects
Date:   Thu,  3 Sep 2020 17:40:36 -0500
Message-Id: <20200903224039.437391-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903224039.437391-1-rpearson@hpe.com>
References: <20200903224039.437391-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changed parameters in rxe_param.h so that MAX_MW is the same as MAX_MR.
Set device attribute in rxe.c so max_mw = MAX_MW.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_param.h | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 43b327b53e26..fab291245366 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -52,6 +52,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_cq			= RXE_MAX_CQ;
 	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
 	rxe->attr.max_mr			= RXE_MAX_MR;
+	rxe->attr.max_mw			= RXE_MAX_MW;
 	rxe->attr.max_pd			= RXE_MAX_PD;
 	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 25ab50d9b7c2..4ebb3da8c07d 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -58,7 +58,8 @@ enum rxe_device_param {
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
-	RXE_MAX_MR			= 256 * 1024,
+	RXE_MAX_MR			= 0x40000,
+	RXE_MAX_MW			= 0x40000,
 	RXE_MAX_PD			= 0x7ffc,
 	RXE_MAX_QP_RD_ATOM		= 128,
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
@@ -87,9 +88,10 @@ enum rxe_device_param {
 	RXE_MAX_SRQ_INDEX		= 0x00040000,
 
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00040000,
-	RXE_MIN_MW_INDEX		= 0x00040001,
-	RXE_MAX_MW_INDEX		= 0x00060000,
+	RXE_MAX_MR_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR - 1,
+	RXE_MIN_MW_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR,
+	RXE_MAX_MW_INDEX		= RXE_MIN_MW_INDEX + RXE_MAX_MW - 1,
+
 	RXE_MAX_PKT_PER_ACK		= 64,
 
 	RXE_MAX_UNACKED_PSNS		= 128,
-- 
2.25.1

