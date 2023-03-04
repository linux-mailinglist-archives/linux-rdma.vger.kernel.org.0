Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D656AABA8
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCDRqr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCDRqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:46 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68101B337
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:45 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3185628otp.6
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t+RYCR+GPDypYJCw/mzDu3u7+tUDxfIXpU6DUOVASg=;
        b=qoF52apaze6NQBt4j6FqyFN44B6CS5pRdBWQUQ6bM0/5ybXGCTWLClVqfs3e6Z5Z3w
         lpBvloC99nrumGEX2gar8cSt0cqKH3A4R+2IIL3+oRzR533MwQesc1yHs2khElWS6q4E
         rZ44wV5S7MtEG+YPiIb3qP/Ofhupk5sO/jwVyURE525ZqZso2flOpEU8XLEsmBlZofiS
         yZKm2QzxA8g3R6ObZdVhXhdrUOs+HxuZReDWSspTZeS7MxQrA7RltlSg+TaizHXNmqZy
         IRGqyY8ElUL5Ox+tKOCfKtUb8VBkTtP/+D5ys5iYq6Qy9WiERSFozS+emcoYNn0d7hJ1
         rX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t+RYCR+GPDypYJCw/mzDu3u7+tUDxfIXpU6DUOVASg=;
        b=3w86GnHaGLUT9wAAFCBVFwr2l6IiCEcX9as1TBcAwzLi0+YpE1sK9k8tmieIgTEAa4
         hK8+hNrhiWxLepCQxc8DjGnQJIBR2ul5/wh6gzDPf5ZBno9ootzVR9pjxTrBziD/I/ZT
         JGj2GKy35hB3X7LuDYOk+DFiPM1Mf3r0w2HKm+SDDFYngfsGpOD9/yt6498/2e/FJzyO
         qHHutAnYh6/Q9E72A/BJghT9OLg1AAlnsLtey2hdd3QVbLJffolfo7fPHg9mQOiJhSQv
         TY7b9EA1/lJFmG12s8C8h6Tg5ymzlgUXS/qnRQRh5Z0Q8j8G8t0aiE41hZQ/iOdAlvLo
         6Pjw==
X-Gm-Message-State: AO0yUKWCbegn7TPl8DJM9EQnR9SF/IC0nqZYN0UqsdphwFlXA8CNwqdX
        JrXCUmNvLjssXdVIS9x0A/M=
X-Google-Smtp-Source: AK7set+dp47XvDTpj9DPNl2rlXANWhTvgyKCMY+vcB2S4e32HNpmovHh2Lv/DyVkyUdL61FTyN+8pA==
X-Received: by 2002:a9d:7307:0:b0:693:bdd8:819f with SMTP id e7-20020a9d7307000000b00693bdd8819fmr4828216otk.1.1677952005062;
        Sat, 04 Mar 2023 09:46:45 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 2/8] RDMA/rxe: Warn if refcnt zero in rxe_put
Date:   Sat,  4 Mar 2023 11:45:28 -0600
Message-Id: <20230304174533.11296-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
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

This patch adds a WARN_ON if the reference count of the object
passed to __rxe_put() is <= 0. This can only happen if there is a
bug in the rxe driver but has bad consequences if there is.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 3f6bd672cc2d..1b160e36b751 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -244,6 +244,8 @@ int __rxe_get(struct rxe_pool_elem *elem)
 
 int __rxe_put(struct rxe_pool_elem *elem)
 {
+	if (WARN_ON(kref_read(&elem->ref_cnt) <= 0))
+		return 0;
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
-- 
2.37.2

