Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B752BE91
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbiERPXb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 11:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiERPXa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 11:23:30 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A5199B36
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 08:23:29 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-f17f1acffeso3137601fac.4
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S82V2k8xLNZUjcMt1WsmA964lMW/mTEg1/F59m0lsKE=;
        b=cYeTSvdpiA2EgoxcG+bqi2vkOf2H6O9hIiAtLexAKHiB+6fi4rjHajSW9FhnBdw/6m
         7rpR1/HbF8YCDJ9k947M+VD9nZFX7N+T0GwJ4RxPNmNEnnHpsm3wEzmOYmKxV/PNwjJL
         fuN51TPLb6C3XY83602dz0uZ9TAivx6swr9turaJTtAJtJm3MFiXrBzGF7zsBQS5TwfZ
         O1FLBikuPN4BoIbynZjYFFhGSmK7KKgCj5y9Fvr95A++PQRyH4VEkcRL1FRBWKNEswL6
         W1XvdkwdEEi5kr7s00Y3BY7OO1J5qe/arW94pBdw/+3JyXS2V6/zD5LSLBq7yk6MjnE7
         zuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S82V2k8xLNZUjcMt1WsmA964lMW/mTEg1/F59m0lsKE=;
        b=Uo6kUo2FEzAnTptb0Q5BySe0ST99F+4Ku0z/lyPiBo4rB8tIMcVi5aaSWn6qXByNmn
         B1tMtv3gJle6PYFjMaEfllLY48oxo711ISfvs1FgHyn85votWnJKA7CzB6pIcAm9cVfs
         iyrJQdT20nyttxvzCiiLtYVOyS2XcZDBvb4LjUqDvNaFQax4FpA17t2lwG2lG3s53gF2
         qA7aRp0Kzzpxa0bWHK/qPRnDxguoe8tWT1vVdyE76qz9gSmpF3LkIv91N7h+GjEMMlCt
         8gwnnWwU6XNsAQ0EWbtnvPoa+kAacYZA8KQ/34/yEAG85aZY7Qgv6U/zpE8gy2qbxAv1
         FxrA==
X-Gm-Message-State: AOAM531kUGGhks66eKRvggSRum/iTn+ZJpbgHkgoEbhq2wm6WO4qiu9a
        n+YXGY8K5a42+lJv6lAxsOc=
X-Google-Smtp-Source: ABdhPJxpblgGiMCiE1s2ZsEG03/5t0aukUkEI4Z7NDIZ/twj4HJo16sQeweSDqDng12z/OURsIN3Xg==
X-Received: by 2002:a05:6870:4188:b0:d9:eed0:5a41 with SMTP id y8-20020a056870418800b000d9eed05a41mr12836oac.161.1652887408410;
        Wed, 18 May 2022 08:23:28 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-e8c5-4d15-83a3-c730.res6.spectrum.com. [2603:8081:140c:1a00:e8c5:4d15:83a3:c730])
        by smtp.googlemail.com with ESMTPSA id k20-20020a056830151400b00606aa21608esm851180otp.17.2022.05.18.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:23:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     edwards@nvidia.com, leon@kernel.org, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/core: Fix wrong rkey in test_qp_ex_rc_bind_mw
Date:   Wed, 18 May 2022 10:23:10 -0500
Message-Id: <20220518152310.20866-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The current test_qp_ex_rc_bind_mw in tests/test_qpex.py uses an incorrect
value for the new_rkey based on the old mr.rkey. This patch fixes that
behavior by basing the new rkey on the old mw.rkey instead.

Before this patch the test will fail for the rxe driver about 1 in 256
tries since randomly that is the freguency of new_rkeys which have the
same 8 bit key portion as the current mw which is not allowed. With
this patch those errors do not occur.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 tests/test_qpex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test_qpex.py b/tests/test_qpex.py
index 8f3f338e..a4c99910 100644
--- a/tests/test_qpex.py
+++ b/tests/test_qpex.py
@@ -300,7 +300,7 @@ class QpExTestCase(RDMATestCase):
             if ex.error_code == errno.EOPNOTSUPP:
                 raise unittest.SkipTest('Memory Window allocation is not supported')
             raise ex
-        new_key = inc_rkey(server.mr.rkey)
+        new_key = inc_rkey(mw.rkey)
         server.qp.wr_bind_mw(mw, new_key, bind_info)
         server.qp.wr_complete()
         u.poll_cq(server.cq)
-- 
2.34.1

