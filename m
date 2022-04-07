Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81544F8757
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiDGSvg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiDGSvg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 14:51:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B93EACA4
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 11:49:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 12so6547125oix.12
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01tNA6Epj6msXNDp09HJPBpwJfVO4T20qhqa+8rIWfA=;
        b=bCrIF1glQjS0Nm3irQui2TKLlEipAs8HA1BQe7HUDr93WEpID8RNPKTlE7MiDwxo4E
         KAtOhu3u/0IjjEPj+cjfZOwmcaVK5MMCw7W7iHXP/Yrpg8cGFnIO1cHeLU0xtfnQot7l
         yxcS1O9OBricpUj1N42x0c/xMav6zlBaU92hcE5Vx3da0JzaVvNTx0IwofPkZGccDEi8
         zhH4QmEuVr9uVxN5gMBKvyWcfa4WjqB1Lx4PlLsdVlDEeF/vTzO/pvB33ehpkj+PfTpz
         mMtgOwFC5m+z1/T9oxid/Iax4P3OPkXs0SrKdmEJsEEBaGYl6394vKVuI43UUi9jk0kT
         mSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01tNA6Epj6msXNDp09HJPBpwJfVO4T20qhqa+8rIWfA=;
        b=XAtS8Sh2f0Fw96TuvqZudA1GHskHwTBR2lNnPn1BBcLTE63Kw2oTj/P9/rr2H76qMm
         o9hRlyTK04/G5SpMT19Sz9pcepyhk4yv/xQJJDHpkBbN2q1G9aIx30dFhA3vnK7OyGYd
         V7Hk7RKkVy5xtun1GzwIi0dn8SJdu18WC4A45yk4lHWh2QAa5HKviyjm40au8gSNPcfy
         to3QiKarlPZA9wEafB4/aCKJsBE3K2D7E12vWyFHbIsTQXHICVFPsCVlnjaKvmK0cT+m
         11RGzcXumMoGvyEKVkBUS+u0AlzO9u54YkAOcrUDYif6ER7lH6hHIhgVJZUl8uUqsHJu
         lxgw==
X-Gm-Message-State: AOAM5336SZ45fxTG1EwXyhsGd94GW+h0OeI41vUZHc2Yow1Rl9Uf/tQU
        dtHz0I9WIywYzDP+Mn5/uswvv++H6X4=
X-Google-Smtp-Source: ABdhPJyhk2xub9BRMWwvES2RTrmGuWxDi9PIwkRaZQVkB82FRX/z9bWYidR6T1BHLRALTwx1P1zdMw==
X-Received: by 2002:a05:6808:1985:b0:2da:3515:9486 with SMTP id bj5-20020a056808198500b002da35159486mr6454615oib.205.1649357375181;
        Thu, 07 Apr 2022 11:49:35 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-417c-5508-fb92-9ab4.res6.spectrum.com. [2603:8081:140c:1a00:417c:5508:fb92:9ab4])
        by smtp.googlemail.com with ESMTPSA id e9-20020aca3709000000b002ed1930b253sm7831418oia.30.2022.04.07.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:49:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove mc_grp_pool from struct rxe_dev
Date:   Thu,  7 Apr 2022 13:48:50 -0500
Message-Id: <20220407184849.14359-1-rpearsonhpe@gmail.com>
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

Remove struct rxe_dev mc_grp_pool field. This field is no longer used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e7eff1ca75e9..adae01458606 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -394,7 +394,6 @@ struct rxe_dev {
 	struct rxe_pool		cq_pool;
 	struct rxe_pool		mr_pool;
 	struct rxe_pool		mw_pool;
-	struct rxe_pool		mc_grp_pool;
 
 	/* multicast support */
 	spinlock_t		mcg_lock;
-- 
2.32.0

