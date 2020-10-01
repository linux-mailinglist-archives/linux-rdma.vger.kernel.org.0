Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDE2805D0
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgJARs5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARs4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:48:56 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C99C0613E2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:48:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c2so6313917otp.7
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Orjx+oyJBYrvIhnGLKRbdepxwiKwvSv5S446kYztnyc=;
        b=BNrKjzqpPDyMPPE7ORmhjBTVLEgb7YpI+n1iup3o3XvsUWn+jZgBHi2sD7ke2A1CyO
         cto7JIGeKXorL/Q6yFapOTegd7VClXkyhh9mhwztw6obllD1x32847yZGy2FGXd3gIB4
         ivFmdIUxicdp6fP74Abge/cOdCx/lrbYzThd5oCeYIczMul8owZxTTsLpGgJKdN3fMff
         2CCQOz5YjSyEgloToD8uDQ3B5OYdlh8RNwzeP3TGUKvbQUwUfEe7GUUbb1SwvQC9t8p0
         LU//ebqPIN/0F6S5+NlqriuJt+jxvIwrDSQakEwW4aW68NnR/TzlWtAh9LOQLEGpRo4g
         hCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Orjx+oyJBYrvIhnGLKRbdepxwiKwvSv5S446kYztnyc=;
        b=hcxONY9RMXJkYUx6xDmYP+O3t8yGBH0pKQJJQ/+qNA+5ZB6Q2B++8KpAgZFuIIb1hO
         f7dZA/qkYNQdzWsJ+w30GDenFnJjhHxUIkhGbmRLTfXATLGTXQUuDC7iwonxd4EpiYHq
         9uHjHfii/dbs01tGWP/3hiWx/w80+duUwOZyg3fFZoHqri9M+GftcAoJSXfQ7LD1MCUN
         Qyh+YlIFj9JrCRQqSatB/e3spSfyMJi/G5JtHUeC0e1IsNjJWFqnAnFMJt5paQ3pcclb
         Gg2gb7tdo5DKREWMMqJ4b91AqfO+jCzcFZoN8h3aHXWD0+q1jPzJ7hIdpOtWXrfzFPgc
         JLfA==
X-Gm-Message-State: AOAM53112Mvu/Fkywfx6S1zvRcMrBDofdSkQZ8Nu+Rx6vfU0IGzMNqBK
        uO9w7+PX5M+DUpZLEbI0iVQ=
X-Google-Smtp-Source: ABdhPJzF+HofadERLIjk9fjoUSRfy+43ZW/LnwTC6Esm4F6Z8teF11ZJ8OsLXrCvg/70OHqSBeTVbQ==
X-Received: by 2002:a9d:4b18:: with SMTP id q24mr5536304otf.265.1601574536186;
        Thu, 01 Oct 2020 10:48:56 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id p20sm1360015oth.48.2020.10.01.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:48:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 02/19] rdma_rxe: Enable MW objects
Date:   Thu,  1 Oct 2020 12:48:30 -0500
Message-Id: <20201001174847.4268-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change parameters in rxe_param.h so that MAX_MW is the same as MAX_MR.
Set device attribute in rxe.c so max_mw = MAX_MW.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_param.h | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

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

