Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8B5BB5DF
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIQDQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIQDQU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:16:20 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A57BD0B1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:16:18 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1278a61bd57so54708805fac.7
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yGra/tWI/2UpBx5qn/FvxZDQywqiIOUOasnBpJ1jLGA=;
        b=T2r1ikU16NK9vzEk6+N2RtWhVSV+F2NPvLm44rKDx0+vDOi0RHNhGhYB52iLETjjpU
         VTD9ItP4yZ/fbBLSCBSLFAqu8gRo25HtF9P/Xh4nX+ojM0nszML+VrROqovJ5ThHvUyL
         HQk6i4UyfLa4bteLinRO8icdt2nhuzk2O4QfW9M46uV16fUtyAMmSIaFAGXbx7rGPN7w
         vgQMQfHvPtUUuKuB+t61lVylQKlo1j6nPXpmQrYPtOA4HQ6PCy2Ms9cOWIFmeMei1GAw
         sJaSZwfV0rVWGzX8C7Hg4YjvU36F3SOkKr/vYZ1OgIjc3p+3+2UaIQplUqN3RQUEvwQG
         537w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yGra/tWI/2UpBx5qn/FvxZDQywqiIOUOasnBpJ1jLGA=;
        b=am0nDyqmlzzwxgcgOXeVMOtjgLBCYeTaSMyGK7BaqddvG2SlOrgvdkWL/TCejK+Th6
         ygl+lg/RRriuiiKL8X5V0Ae3rRfFJnHgExJT0YMjrNli+Oa/WzYl+SYn2Bd/VM8rLlT8
         9zlOqH+k56VYwAhJkVPRVi3nfKYh7dOceHh5IXuyl8Fx7jO6QoYxK1dt4R4L92CVnJ/g
         OT7+LOooENQ6OpBFsA9803/r8HQY+aZPwu8StJnMWHnErb8PqiFjxD4wGywDDzGFRwIG
         Hhs8fW4lBwpi/RMZ1V8L22mCGqcrJw76KZGSwnl5g4dQgJYyJg5rvOlkMC2ZJZ1Fqw07
         IxXQ==
X-Gm-Message-State: ACrzQf3RdmyLVf9ig1yFqoRGkh33seFKCn15eByLhOeAYVv1m0D/xw3P
        nIqr5Dsv0kONjYNnP+hgAD4=
X-Google-Smtp-Source: AMsMyM5fMmWtIFRxaszLMVCuj7EpGqa6gXDNxAJkR4WBLlt0fL/G9ApWu5Vo2WiBdCZOr+Hq2lnAGw==
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id w24-20020a056870339800b001137f43d0e9mr4575529oae.33.1663384577421;
        Fri, 16 Sep 2022 20:16:17 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056870428400b0010d5d5c3fc3sm4240314oah.8.2022.09.16.20.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:16:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/2] Update kernel headers
Date:   Fri, 16 Sep 2022 22:15:36 -0500
Message-Id: <20220917031536.21354-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031536.21354-1-rpearsonhpe@gmail.com>
References: <20220917031536.21354-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/rxe: Extend rxe_resp.c to support xrc qps").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h       | 14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index 73f679df..c44db5fa 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -74,7 +74,7 @@ struct rxe_av {
 
 struct rxe_send_wr {
 	__aligned_u64		wr_id;
-	__u32			reserved;
+	__u32			srq_num;	/* xrc only */
 	__u32			opcode;
 	__u32			send_flags;
 	union {
@@ -166,7 +173,7 @@ struct rxe_send_wqe {
 
 struct rxe_recv_wqe {
 	__aligned_u64		wr_id;
-	__u32			reserved;
+	__u32			num_sge;
 	__u32			padding;
 	struct rxe_dma_info	dma;
 };
@@ -191,8 +198,7 @@ struct rxe_create_qp_resp {
 
 struct rxe_create_srq_resp {
 	struct mminfo mi;
-	__u32 srq_num;
-	__u32 reserved;
+	__u32 reserved[2];
 };
 
 struct rxe_modify_srq_cmd {
-- 
2.34.1

