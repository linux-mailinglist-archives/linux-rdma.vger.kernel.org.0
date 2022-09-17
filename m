Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5945BB5CF
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIQDL4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIQDLU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:20 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D6BD0B1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-127dca21a7dso54672401fac.12
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/yphHfq1fscJdeg9GonHY1UqInv08T/3vgxuCO7wSGA=;
        b=cVWL4ZPoU3G2cQ7Pqdz9mJQP4ZV90j1VUPXBE0XpDWNIDZfqVLkgn209Bj0gQQ2ugg
         pt40MrPy/Ri6GQwmZLFZZ6F5StYtkhOtPbv13p7o6t5PZqe5jI7ci2BPzHbhO9sSUp+E
         zSZ2WELfYLPYTnff8XOb60DgeeVY1EJCQzlCVqDfPekieThHgMh2ejLiP2t3NwGrhyVc
         EMFKSSyn6psZ2OxvLU/ZHfxSpzHMOsdCmGRFuBdS1KYkkwCZ3wbqkqeJETYXdozYQDgu
         YWvu7mMgAXHY4rKFFLT7GP9m4nAEd3Hocnci+42s8E2Q1iA1g3cvG7vtHHK8+TxXB3+d
         vLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/yphHfq1fscJdeg9GonHY1UqInv08T/3vgxuCO7wSGA=;
        b=7NL+aFE+kx6gA4Nx2vQcDJ8BZB+a3lP6o/b3fZnxT++9PHdFktT5x3C+W7PC8diKbH
         piomgcdD60h6wXWdL7kJm+AkntCr5FX4yyraYyy+nTVSGRVvX8Nn94uWlP+5Boe0Co1t
         CEnH926xYPZjtwfefgMCRKOIOpT8GizAsBHOZdYjentEpIkDwx7onJ03wMV3fXXJPHqh
         WF4aOthOfAp4y5Kli1SJiUzyBOL3P+LUGfGNkjii1JWrYIcX3WA53l3f+WRBwMyU4w2x
         b8IiJS6p7fbegDXRvL5JBR1yLJQz4stfw65Lwpb4Gx8ua2maRPAwrv6AdyeTTahgySJ0
         bVww==
X-Gm-Message-State: ACgBeo0elPyUOMzRRskj9etl5clf8xm2K/O1byZyMBC0vK8cw+5fFgiq
        69JvgN6u5XoVe6tcCXL5DH8=
X-Google-Smtp-Source: AA6agR6LHmibP0B2httn7D3KlNiTpdUb/SPkPUzgI55/BrhopDmZXs4xvsH3/tKbIQ8sntJ0KsiNDw==
X-Received: by 2002:a05:6870:f110:b0:127:3735:8e19 with SMTP id k16-20020a056870f11000b0012737358e19mr10217738oac.273.1663384273478;
        Fri, 16 Sep 2022 20:11:13 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 06/13] RDMA/rxe: Implement open_xrcd and close_xrcd
Date:   Fri, 16 Sep 2022 22:10:57 -0500
Message-Id: <20220917031104.21222-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

Add rxe_open_xrcd() and rxe_close_xrcd() and add xrcd objects
to rxe object pools to implement ib_open_xrcd() and ib_close_xrcd().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe_param.h |  3 +++
 drivers/infiniband/sw/rxe/rxe_pool.c  |  8 ++++++++
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 23 +++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 +++++++++++
 6 files changed, 48 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 51daac5c4feb..acd22980836e 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -23,6 +23,7 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->uc_pool);
 	rxe_pool_cleanup(&rxe->pd_pool);
 	rxe_pool_cleanup(&rxe->ah_pool);
+	rxe_pool_cleanup(&rxe->xrcd_pool);
 	rxe_pool_cleanup(&rxe->srq_pool);
 	rxe_pool_cleanup(&rxe->qp_pool);
 	rxe_pool_cleanup(&rxe->cq_pool);
@@ -120,6 +121,7 @@ static void rxe_init_pools(struct rxe_dev *rxe)
 	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC);
 	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD);
 	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH);
+	rxe_pool_init(rxe, &rxe->xrcd_pool, RXE_TYPE_XRCD);
 	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ);
 	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP);
 	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ);
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 86c7a8bf3cbb..fa4bf177e123 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -86,6 +86,9 @@ enum rxe_device_param {
 	RXE_MAX_QP_INDEX		= DEFAULT_MAX_VALUE,
 	RXE_MAX_QP			= DEFAULT_MAX_VALUE - RXE_MIN_QP_INDEX,
 
+	RXE_MIN_XRCD_INDEX		= 1,
+	RXE_MAX_XRCD_INDEX		= 128,
+	RXE_MAX_XRCD			= 128,
 	RXE_MIN_SRQ_INDEX		= 0x00020001,
 	RXE_MAX_SRQ_INDEX		= DEFAULT_MAX_VALUE,
 	RXE_MAX_SRQ			= DEFAULT_MAX_VALUE - RXE_MIN_SRQ_INDEX,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f50620f5a0a1..b54453b68169 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -42,6 +42,14 @@ static const struct rxe_type_info {
 		.max_index	= RXE_MAX_AH_INDEX,
 		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
 	},
+	[RXE_TYPE_XRCD] = {
+		.name		= "xrcd",
+		.size		= sizeof(struct rxe_xrcd),
+		.elem_offset	= offsetof(struct rxe_xrcd, elem),
+		.min_index	= RXE_MIN_XRCD_INDEX,
+		.max_index	= RXE_MAX_XRCD_INDEX,
+		.max_elem	= RXE_MAX_XRCD_INDEX - RXE_MIN_XRCD_INDEX + 1,
+	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "srq",
 		.size		= sizeof(struct rxe_srq),
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 9d83cb32092f..35ac0746a4b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -11,6 +11,7 @@ enum rxe_elem_type {
 	RXE_TYPE_UC,
 	RXE_TYPE_PD,
 	RXE_TYPE_AH,
+	RXE_TYPE_XRCD,
 	RXE_TYPE_SRQ,
 	RXE_TYPE_QP,
 	RXE_TYPE_CQ,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9ebe9decad34..4a5da079bf11 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -281,6 +281,26 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	return err;
 }
 
+static int rxe_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
+{
+	struct rxe_dev *rxe = to_rdev(ibxrcd->device);
+	struct rxe_xrcd *xrcd = to_rxrcd(ibxrcd);
+	int err;
+
+	err = rxe_add_to_pool(&rxe->xrcd_pool, xrcd);
+
+	return err;
+}
+
+static int rxe_dealloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
+{
+	struct rxe_xrcd *xrcd = to_rxrcd(ibxrcd);
+
+	rxe_cleanup(xrcd);
+
+	return 0;
+}
+
 static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 			  struct ib_udata *udata)
 {
@@ -1055,6 +1075,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.alloc_mw = rxe_alloc_mw,
 	.alloc_pd = rxe_alloc_pd,
 	.alloc_ucontext = rxe_alloc_ucontext,
+	.alloc_xrcd = rxe_alloc_xrcd,
 	.attach_mcast = rxe_attach_mcast,
 	.create_ah = rxe_create_ah,
 	.create_cq = rxe_create_cq,
@@ -1065,6 +1086,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.dealloc_mw = rxe_dealloc_mw,
 	.dealloc_pd = rxe_dealloc_pd,
 	.dealloc_ucontext = rxe_dealloc_ucontext,
+	.dealloc_xrcd = rxe_dealloc_xrcd,
 	.dereg_mr = rxe_dereg_mr,
 	.destroy_ah = rxe_destroy_ah,
 	.destroy_cq = rxe_destroy_cq,
@@ -1103,6 +1125,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp),
+	INIT_RDMA_OBJ_SIZE(ib_xrcd, rxe_xrcd, ibxrcd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
 	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a51819d0c345..6c4cfb802dd4 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -93,6 +93,11 @@ struct rxe_rq {
 	struct rxe_queue	*queue;
 };
 
+struct rxe_xrcd {
+	struct ib_xrcd		ibxrcd;
+	struct rxe_pool_elem	elem;
+};
+
 struct rxe_srq {
 	struct ib_srq		ibsrq;
 	struct rxe_pool_elem	elem;
@@ -383,6 +388,7 @@ struct rxe_dev {
 	struct rxe_pool		uc_pool;
 	struct rxe_pool		pd_pool;
 	struct rxe_pool		ah_pool;
+	struct rxe_pool		xrcd_pool;
 	struct rxe_pool		srq_pool;
 	struct rxe_pool		qp_pool;
 	struct rxe_pool		cq_pool;
@@ -432,6 +438,11 @@ static inline struct rxe_ah *to_rah(struct ib_ah *ah)
 	return ah ? container_of(ah, struct rxe_ah, ibah) : NULL;
 }
 
+static inline struct rxe_xrcd *to_rxrcd(struct ib_xrcd *ibxrcd)
+{
+	return ibxrcd ? container_of(ibxrcd, struct rxe_xrcd, ibxrcd) : NULL;
+}
+
 static inline struct rxe_srq *to_rsrq(struct ib_srq *srq)
 {
 	return srq ? container_of(srq, struct rxe_srq, ibsrq) : NULL;
-- 
2.34.1

