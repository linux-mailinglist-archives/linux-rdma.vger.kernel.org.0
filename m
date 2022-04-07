Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6614F8747
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiDGSrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiDGSrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 14:47:01 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A41AE
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 11:44:59 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e1dcc0a327so7368454fac.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA9+xCOe6tKiBBn5hG+X8vGQ5A0RjrIvhzbRoKnRnTc=;
        b=YadZpsrzdXweApWSFDGzmpipAwWQjTPSihUHKn4cospWIg7SHdEj+dpHBFs+OZY1z+
         Phh52kTBJIQhodErE8bFD7h9N8MtDCM3XyurNBGW92IHPTw0OVnKglmy/Cz+epbPTIXr
         PIdmNWQcGsO8Rya58L/hVOw28cRAxpBRtTCZ+0pedAFt783a/T+UxnxEbOQt/ANyGg9J
         TPX2l9271OM+v+A4XoFzKDTojet8fddAHvA5x3NRXft3UcaZhw0Od/OKgorS0yIgfxlX
         NetLVaoC1cC+ClWpcTOIQMOK/ql6cynckSFNE0zIh392CAiQs0lqB5sSLIdJBTz476Eg
         PXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA9+xCOe6tKiBBn5hG+X8vGQ5A0RjrIvhzbRoKnRnTc=;
        b=mjgpajowaTF+g28c8YOzU3bdlMRyWa7cJ9/yy5KbOxo10zdy45t7iZtkX4NDbjlmsV
         VrdJt7lfr5mqCng6aMKFsLNrKxLluFJgVaxS+Ey0Qw/QK8eBiOt5Jy6W1+DpP8I6rCCG
         chqQ94vYsfNFcxwQ3JHPRIvxyObFdkpgwWq1/9GJbviwGbCDdTrgFTUa8oC5CeIJV+1j
         gk6icbET3mxH4IOjprclNKua0rs1LWlbH17lkoADLEpdxDZLOCncOfjzlkfpx36KNwOM
         +ck4n1gPKFukpj3oaNtZ15UnvsRmEkiB12rOAkhN8gnOHOOjWhdIkpKZ7AxJV84tWCZV
         uqPg==
X-Gm-Message-State: AOAM5321F9i5ZuQnGKMOhZ9vXu9WoPgo3pKrJ+VdWmsBfbrcjSn5Kqzu
        uWxw5KT+7XxqU3ZOq6Xd+iqUAzcWwuY=
X-Google-Smtp-Source: ABdhPJwNgt++8L/pG0jOApL9Y5psIrvbcYzYCpk5nS9j6pI1NX0AYf0K+RFFIoDJdanEEDuQ+TXO1A==
X-Received: by 2002:a05:6870:e249:b0:e1:fba7:fd85 with SMTP id d9-20020a056870e24900b000e1fba7fd85mr6996186oac.98.1649357098772;
        Thu, 07 Apr 2022 11:44:58 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-417c-5508-fb92-9ab4.res6.spectrum.com. [2603:8081:140c:1a00:417c:5508:fb92:9ab4])
        by smtp.googlemail.com with ESMTPSA id f50-20020a9d03b5000000b005c959dd643csm8304128otf.3.2022.04.07.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:44:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove type 2A memory window capability
Date:   Thu,  7 Apr 2022 13:43:22 -0500
Message-Id: <20220407184321.14207-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver claims to support both 2A and 2B type
memory windows. But the IBA requires

	010-37.2.31: If an HCA supports the Base Memory Management
	extensions, the HCA shall support either Type 2A or Type 2B
	MWs, but not both.

This commit removes the device capability bit for type 2A memory windows
and adds a clarifying comment to rxe_mw.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c    | 8 ++++++++
 drivers/infiniband/sw/rxe/rxe_param.h | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c86b2efd58f2..f29829efd07d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -3,6 +3,14 @@
  * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
  */
 
+/*
+ * The rdma_rxe driver supports type 1 or type 2B memory windows.
+ * Type 1 MWs are created by ibv_alloc_mw() verbs calls and bound by
+ * ibv_bind_mw() calls. Type 2 MWs are also created by ibv_alloc_mw()
+ * but bound by bind_mw work requests. The ibv_bind_mw() call is converted
+ * by libibverbs to a bind_mw work request.
+ */
+
 #include "rxe.h"
 
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 918270e34a35..07cdde3faedc 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -52,7 +52,6 @@ enum rxe_device_param {
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_ALLOW_USER_UNREG
 					| IB_DEVICE_MEM_WINDOW
-					| IB_DEVICE_MEM_WINDOW_TYPE_2A
 					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
-- 
2.32.0

