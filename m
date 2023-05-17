Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3B707415
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 23:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjEQVWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjEQVWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 17:22:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929061B9
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 14:21:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6aaf43edb78so344674a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684358477; x=1686950477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ6LkhIlrbVPljmP2o+GhQSq4Vo5UcJA4k1uFTakM34=;
        b=eE17rWhHJNC8rin2CAf740WrrUQALScsL3ZPpMLxI47PI468F+BI/W9bXOlJkf7UQH
         ExzhKPj3w42c8zYUz0EhJiLQ4dL7XsjpSmMA74wuYRbo2wed47nN8/NtW822WH24Kgjy
         OqECad7C9HwFihUl2A4J+eKthYLg0KJ9fVbGh8cafCBygAFBk+LycP/pHI9Ss6TGRraO
         VGZXgX4rRI4Qhd3MsQuPdXea6zgkNRU8DeJPPVYT94DdtG9iwf/gUghknpWElg0vSjj8
         S5uH+Np6Z6N/1eWJRzAfwMajmuB9+bFzAIV5+xDPQK4nJs9Y6/RGY7F4hV5rdOk5RCN7
         O+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358477; x=1686950477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ6LkhIlrbVPljmP2o+GhQSq4Vo5UcJA4k1uFTakM34=;
        b=Oxm8mY4T9irVvK5qh77eQ32MgyUl5WlYfULJBfAUWDVwrJnWT40rKH1U+2YgBtOGGG
         q8Z8rJZB3ZZ5qMfDp0E1trQ098DJt9OFjKg/ijA05rBXiurtV6tl4zUnWqJfXNbuAwyA
         3jVF2Oc6cdfJ5rLNmglNFU8RA+iqhJ8jk0yiiragymbFNb0lp25LT0oHy8CA7f3lp90V
         sMnpmU3VNHMy2oLHsmLI851lIiNZpBrw5PSRc6PlJPYh13mZaMYO4WcFQZ2jDa8EuBLd
         P3NYZXcXkQzg7ov3ypVskww5B/p/N9QokClXHdMGG+wn+lgrCh7auwaGEnGGw5tz7hpQ
         pPbQ==
X-Gm-Message-State: AC+VfDycNaQ+1EhjeJtgEct0Y/aRcAEU8IEEy/GJbiL4vQXRliKlcK9G
        yEoUU7i63Ie9TEVzvWMf5wE=
X-Google-Smtp-Source: ACHHUZ7VzLvpNxXdDwgvIBWtkYydUWv7OkFXD1/+hzOhKmv4I7mVzM4KM8NOKZBbxIV5cqA5yj/8dw==
X-Received: by 2002:a9d:4816:0:b0:6ab:d7a:ceba with SMTP id c22-20020a9d4816000000b006ab0d7acebamr73976otf.0.1684358477110;
        Wed, 17 May 2023 14:21:17 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e2d1-92d9-dfd0-d039.res6.spectrum.com. [2603:8081:140c:1a00:e2d1:92d9:dfd0:d039])
        by smtp.gmail.com with ESMTPSA id h8-20020a9d7988000000b006ab1ea1af9esm24599otm.68.2023.05.17.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:21:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix ref count error in check_rkey()
Date:   Wed, 17 May 2023 16:15:10 -0500
Message-Id: <20230517211509.1819998-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
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

There is a reference count error in error path code and a
potential race in check_rkey() in rxe_resp.c. When looking
up the rkey for a memory window the reference to the mw from
rxe_lookup_mw() is dropped before a reference is taken on the
mr referenced by the mw. If the mr is destroyed immediately
after the call to rxe_put(mw) the mr pointer is unprotected
and may end up pointing at freed memory. The rxe_get(mr) call
should take place before the rxe_put(mw) call.

All errors in check_rkey() call rxe_put(mw) if mw is not NULL
but it was already called after the above. The mw pointer
should be set to NULL after the rxe_put(mw) call to prevent
this from happening.

This patch corrects these errors.

Fixes: cdd0b85675ae ("RDMA/rxe: Implement memory access through MWs")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 68f6cd188d8e..5d8d336c402d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -489,8 +489,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		if (mw->access & IB_ZERO_BASED)
 			qp->resp.offset = mw->addr;
 
-		rxe_put(mw);
 		rxe_get(mr);
+		rxe_put(mw);
+		mw = NULL;
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
-- 
2.37.2

