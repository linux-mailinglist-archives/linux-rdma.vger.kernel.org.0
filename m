Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D1615325
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiKAUXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKAUXk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:40 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23D1C416
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:39 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so2217165oog.12
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTc8DYxRHwrx7moBbowmcIUIPuxWr0WrNqCa5fecqEg=;
        b=LV5C6tRwzTbc+wm+Z9RveiIjmjgeb5ydhQmPaT4xjU5uumoG3aOn0JQW+Zt6yRvDE7
         ZShVEQ8xvktau0EFXXlksgc4J5p+KcjeLt8TiSHtpMAkVgThKMDAJQFiIwd/mBwj5AYJ
         uaa93vLoPuP4ZJyMD/HkrbXIMyD6qtrRVsBytJHK/tNgDf2SrbsDOgWSAiCFssMfopbs
         fDmDlwGA5FhKayV2O9hymuZtKfpKDBxX45d2MqR3kKy6k1yTsE9yYj8Rwm+adNZr4qqb
         5qanVT5j1i++zPexQOxlzJiQC/w/yWx6uGDfPXramB8nE5bN4eN5fp8dYmSesQYGYVyy
         MmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTc8DYxRHwrx7moBbowmcIUIPuxWr0WrNqCa5fecqEg=;
        b=3UpRygws1di3gSYFqyCnS7swI3rmznkJVIQtMT78SZ147VQdNrsWiw5HK7h18tVb5Q
         bjbVBBqgdMliM+7syBRo9spSTnzT01UHXElj7SkZkJopNXChwVSkBpvUZjJq90UzTA85
         5JplOdzzixYn5AkXzxt5wMIisKGU48IDSfPPtyagNWnAblAczRSzeyNk87h8hqTSihxz
         Y6WA7YaguP6hwTg78SX+tQwDtEok+GCKYUaSgHwyfwsUtHz7D/KWhcORzhEOImYvkAB5
         FVTsFw+tCVLIevusxiVRp+HS9mM2KtU2L6wnyvoQyhknL4xDl3+e/7yWwm2KezxaNIjz
         fQ3w==
X-Gm-Message-State: ACrzQf0mcoBcwL60qhLUrwoP81MO+daTGArpSkNogSW9UjS1QfqXBsXG
        H/c4oJLBWOXp5ZKP5kPKic8=
X-Google-Smtp-Source: AMsMyM5BZTOfwi8Dt09OMIxLi3UlZU4y8d8/ueferawvA7/zzC4vRGReF3His7mqZuiVB4ABQngdkQ==
X-Received: by 2002:a4a:b648:0:b0:47f:90bb:e7e8 with SMTP id f8-20020a4ab648000000b0047f90bbe7e8mr8924993ooo.32.1667334218760;
        Tue, 01 Nov 2022 13:23:38 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 01/16] RDMA/rxe: Add ibdev_dbg macros for rxe
Date:   Tue,  1 Nov 2022 15:22:25 -0500
Message-Id: <20221101202238.32836-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Add macros borrowed from siw to call dynamic debug macro ibdev_dbg.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 30fbdf3bc76a..1c5186c26bce 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,6 +38,25 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
+#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&rxe->ib_dev,			\
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg(uc->ibpd.device,		\
+		"uc#%d %s: " fmt, uc->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_pd(pd, fmt, ...) ibdev_dbg(pd->ibpd.device,		\
+		"pd#%d %s: " fmt, pd->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_ah(ah, fmt, ...) ibdev_dbg(ah->ibah.device,		\
+		"ah#%d %s: " fmt, ah->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_srq(srq, fmt, ...) ibdev_dbg(srq->ibsrq.device,	\
+		"srq#%d %s: " fmt, srq->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_qp(qp, fmt, ...) ibdev_dbg(qp->ibqp.device,		\
+		"qp#%d %s: " fmt, qp->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_cq(cq, fmt, ...) ibdev_dbg(cq->ibcq.device,		\
+		"cq#%d %s: " fmt, cq->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_mr(mr, fmt, ...) ibdev_dbg(mr->ibmr.device,		\
+		"mr#%d %s:  " fmt, mr->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg(mw->ibmw.device,		\
+		"mw#%d %s:  " fmt, mw->elem.index, __func__, ##__VA_ARGS__)
+
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
-- 
2.34.1

