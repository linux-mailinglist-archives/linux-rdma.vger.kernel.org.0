Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B342AA09E
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgKFXB4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgKFXB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:01:56 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6CC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:01:56 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f16so2813515otl.11
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7I1Xj/6njXLU1TK0BCYtaI5uX5fD5BW8jEIxK0Qk/k=;
        b=BW8pOjCSWLgDpeP4pr0iLOo6imLBZIOeEflKCspYKvsYqdBM/hiDJpaA/5gcO7m3OK
         3xtOTGZrlu1dvoDs08E/LvlVaUrkPyRnRMHOdKVUFC/mvJ+MrIbecKsg2Cq4ByCVmpMe
         V/E6er6LQTdAG4dmdNT1hg5EZaCZ+XN68aJHm1kOAbbgsqPfsLvSM5XfurMT5vXLWACO
         iRRH/+/fphn5w+ftB35EwHRoml4WP1nExm5k5GkB1MvJIi1iB3QqmqkHUiszDIS1asoK
         xuuQmE+gmUeG9uCKx1XBcypKmUOT5N8J5w7QVHiSEiMFMe8jSoWaChkuKc32kip8ytzn
         GaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7I1Xj/6njXLU1TK0BCYtaI5uX5fD5BW8jEIxK0Qk/k=;
        b=KNGY6zeEP5mJpc7axJ42Otxz0j4ttqds8Am6/HWz+tWInYDbfcp/nCAEMXGxGW7Av2
         MeLsPxPHb0CXXBU+d44enS3Gk60H4kC3n9lFfX6mG6oVZiJ4jnmvUIu3nGKwPox89yti
         dpQDmdrpzZmYoiWGwcUioFfaR7jhMa9n6+0bpcaObGs/nV8o8j5FgzFoeih8Ws3Ai/pR
         kMRIlsuJOE8mf3zj/P3DLRA2qkI2diB6USlKy5PmM9kUse8X8qa/Nqi/UISafWaZPEim
         y8Ldbpjroh0yfvZP2DYCgVGiiODNiaoUe9GjZ4mrwDqIUDeXGDeoWaQ8reXIVpz/b8F9
         UDBw==
X-Gm-Message-State: AOAM53062+KbLFwtdiDAFPQSfCUnq8VOIa7JJNxge1Cigt0y5kluRInD
        yC55XNrw6YgSRELtAyxgwx4=
X-Google-Smtp-Source: ABdhPJys1haPKQODXCcoCjbaaP3WwjzZjCgGb41UO8jV+Cq/P4+l61jNeK73J7VD7qhQezLBDepTdA==
X-Received: by 2002:a9d:6641:: with SMTP id q1mr2732574otm.190.1604703715539;
        Fri, 06 Nov 2020 15:01:55 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id h32sm639090oth.2.2020.11.06.15.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:01:55 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 1/4] Provider/rxe: Exchange capabilities with driver
Date:   Fri,  6 Nov 2020 17:01:19 -0600
Message-Id: <20201106230122.17411-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106230122.17411-1-rpearson@hpe.com>
References: <20201106230122.17411-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Exchange capability masks between provider and driver
during alloc_context verb.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 18 ++++++++++++++++++
 providers/rxe/rxe-abi.h             |  2 ++
 providers/rxe/rxe.c                 | 12 ++++++++----
 providers/rxe/rxe.h                 |  5 +++++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index d8f2e0e4..70ac031e 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -152,6 +158,18 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+enum rxe_capabilities {
+	RXE_CAP_NONE		= 0,
+};
+
+struct rxe_alloc_context_cmd {
+	__aligned_u64		provider_cap;
+};
+
+struct rxe_alloc_context_resp {
+	__aligned_u64		driver_cap;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index b4680a24..0b0b4b38 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -39,6 +39,8 @@
 #include <rdma/rdma_user_rxe.h>
 #include <kernel-abi/rdma_user_rxe.h>
 
+DECLARE_DRV_CMD(urxe_alloc_context, IB_USER_VERBS_CMD_GET_CONTEXT,
+		rxe_alloc_context_cmd, rxe_alloc_context_resp);
 DECLARE_DRV_CMD(urxe_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		empty, rxe_create_cq_resp);
 DECLARE_DRV_CMD(urxe_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index ca881304..c29b7de5 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -865,18 +865,22 @@ static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
 					       void *private_data)
 {
 	struct rxe_context *context;
-	struct ibv_get_context cmd;
-	struct ib_uverbs_get_context_resp resp;
+	struct urxe_alloc_context cmd = {};
+	struct urxe_alloc_context_resp resp = {};
 
 	context = verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
 					       RDMA_DRIVER_RXE);
 	if (!context)
 		return NULL;
 
-	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd, sizeof(cmd),
-				&resp, sizeof(resp)))
+	cmd.provider_cap = RXE_PROVIDER_CAP;
+
+	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd.ibv_cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp)))
 		goto out;
 
+	context->capabilities = cmd.provider_cap & resp.driver_cap;
+
 	verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops);
 
 	return &context->ibv_ctx;
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 96f4ee9c..736cc30e 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -48,6 +48,10 @@ enum rdma_network_type {
 	RDMA_NETWORK_IPV6
 };
 
+enum rxe_provider_cap {
+	RXE_PROVIDER_CAP	= RXE_CAP_NONE,
+};
+
 struct rxe_device {
 	struct verbs_device	ibv_dev;
 	int	abi_version;
@@ -55,6 +59,7 @@ struct rxe_device {
 
 struct rxe_context {
 	struct verbs_context	ibv_ctx;
+	uint64_t		capabilities;
 };
 
 struct rxe_cq {
-- 
2.27.0

