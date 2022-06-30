Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476F35622A3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiF3TFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiF3TFM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:12 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7737A32
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:11 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-101ab23ff3fso536157fac.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ln8t+yJCM/V15DKVa+5JWZsTKpmaN58ItH631HbFTxU=;
        b=FLoIotsT4S8bjvgtudqUF4rM05QSKqDaGkJfObLvbjsjqjbwevK1bAyGqjYi7HRSSw
         7ax16CMx0TiknF5BUK3EiMsaXugu7/Us5fiNXC3S9vN9jFA5a8aDFkVkGo9mT1qhqy+3
         COvUaXPd9JqtslwDtEGHmkhnIGNatsHU41dcFsloMtbiGCAwP8M3gEsqnsphPqH1e9b8
         H+pfldgIfLMLD/M5vt49VZ5/2RwoUTYfA5hByJxEHnqBYOtViTzqqLeHYxQUWgT5VQ4x
         4j7TP7EsoqD+wrHQVhnhw17lJd/OHyE7o47KF4yvuwN1ZjPS3k50UrRh4t+YXVwsNrzP
         2AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ln8t+yJCM/V15DKVa+5JWZsTKpmaN58ItH631HbFTxU=;
        b=dud82qTMlQq7YrYal8cLyhHJaOuHNmVCaEVGs5QDYqthp9Pabmcy2zrauOxuGKu3Yb
         qKVqHYS1anaonbPMzTAU3f/JFiPR9J+Btf3IsCy5pboVKkAd7/FCk71WnecwMlEgiTCA
         2pvmjYqgxQ3MiWOVvelLymae96A53edQTx6wTE3IAKqICCMTBTMXKfwFM6h/1Wm8U6P2
         dBlkOxCtCEX3y2gDYaJeF5Dr+aWDyGY0AxIfof0/bZp+/hTcspy8FjqxbvDx+a/fVaEP
         xX9C3Ix01ff5YyaIphUg2NGdtFiePQGO2uMwbxXYyvpJs+oovnD5LEZw4O+UMs8qWu7Z
         kANA==
X-Gm-Message-State: AJIora/FjhZPPdysy0J9pzgY+XkawaEy6a6O/SOgUGdVKaowvExA90EK
        aevLJIse1LCJH7BcL1snA1M=
X-Google-Smtp-Source: AGRyM1tMckgj/TShfko7ncxCXDNKN2RAPy0/9TSdG3lsQ9/HJzuX3TWxQLFnN8hUsZoEuun4v3ibcg==
X-Received: by 2002:a05:6870:51cb:b0:fb:5c97:bd1b with SMTP id b11-20020a05687051cb00b000fb5c97bd1bmr6178120oaj.104.1656615911493;
        Thu, 30 Jun 2022 12:05:11 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Frank Zago <frank.zago@hpe.com>
Subject: [PATCH for-next v2 4/9] RDMA/rxe: Replace include statement
Date:   Thu, 30 Jun 2022 14:04:21 -0500
Message-Id: <20220630190425.2251-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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

rxe_queue.h currently includes <uapi/rdma/rdma_user_rxe.h> for
a definition of struct rxe_queue_buf. But it is only used as
a pointer so the definition is not needed.

This patch replaces the include statement with the declaration

struct rxe_queue_buf;

Reported-by: Frank Zago <frank.zago@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 6227112ef7a2..ed44042782fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -7,9 +7,6 @@
 #ifndef RXE_QUEUE_H
 #define RXE_QUEUE_H
 
-/* for definition of shared struct rxe_queue_buf */
-#include <uapi/rdma/rdma_user_rxe.h>
-
 /* Implements a simple circular buffer that is shared between user
  * and the driver and can be resized. The requested element size is
  * rounded up to a power of 2 and the number of elements in the buffer
@@ -53,6 +50,8 @@ enum queue_type {
 	QUEUE_TYPE_FROM_DRIVER,
 };
 
+struct rxe_queue_buf;
+
 struct rxe_queue {
 	struct rxe_dev		*rxe;
 	struct rxe_queue_buf	*buf;
-- 
2.34.1

