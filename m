Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C8615334
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKAUYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKAUYJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:24:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999CE1EED5
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:24:03 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id k59-20020a9d19c1000000b0066c45cdfca5so4724929otk.10
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2pSdTKM7iQu0Jk8e7av42NZMTW0FwfFiXKtcz2t9Rk=;
        b=ApYbHbmZEzGOl3tT+R9mtAD65/gm/Anyi07HYUA3OVjSFjw/cX4WDjhQV2a4KEZVQv
         nWDvM6hGGhblDVRZulQCzv1p14huW3cB/Oc+16sFE/cudpiba4FlTDvGWAvVQKoBgtoh
         Yp2mJ2O6HZdpEcfi6g6xybl/RxLRrMWzZFb90cHJnaws+aPcZsd3IGpPZtc2kpbnFTfX
         DNY0QCGfMu4oQjJsdDX8B5lpOR1kt8JFtggI1gCjRVDvqd8AykYqN58T7JYmLT4RzSAZ
         chKPa1a5VgOtMhW/CkHRBxgyODg37snSLettP6T++qM2Gx8qM1IHxPIYnT4ea53srdkm
         HKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2pSdTKM7iQu0Jk8e7av42NZMTW0FwfFiXKtcz2t9Rk=;
        b=TRX9ZD1TPueoUSsenIY2BZ4RahHMJMVxn93O3HQLQcvaMv6nq3g1RmfHb3Nm7cp+cP
         bWsmmOOnLCQQymDhuRaEO2ZX+68MGhuxPlozHXQIC52Aq8c0J42d9StCYCQ95/lH4c/Y
         HTTPqkLlDJfCHbn6KFNsCDSPH3VXFI4uC6yjnFQRJeYOKUoJa7IMMMFeToOxk8owKKn2
         0FWWAGAfPU3PXJ4NQozWIQpnrSYGxKonDhfOPnBhmX/4QShsPvORz6xHk2aB8qOQLPnN
         Tj2KHusiahL02qU3/Dn74qF/fsYBQVNl4vPuLtCAXX4GMxzAIAKXCZ1Ocd/OrtjvBWeh
         MPrw==
X-Gm-Message-State: ACrzQf0lFNzJPgclJXLoTk9mzaayvU/NXcFC4NNV3IO55vRYvBsNpMvx
        5bdW5nop5vHcNDTiZiAlYZ0=
X-Google-Smtp-Source: AMsMyM54FrZuUoqOMoQnn/ZzfJdsQJZ2Hv04nLRKyM2wygZfzpvSBNOEyd3KYoMtd0wy/iJpUkhcVQ==
X-Received: by 2002:a05:6830:4c9:b0:661:e80b:bd4b with SMTP id s9-20020a05683004c900b00661e80bbd4bmr10361871otd.22.1667334242677;
        Tue, 01 Nov 2022 13:24:02 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:24:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 14/16] RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe.c
Date:   Tue,  1 Nov 2022 15:22:39 -0500
Message-Id: <20221101202238.32836-15-rpearsonhpe@gmail.com>
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

Replace calls to pr_err() in rxe.c with rxe_dbg().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 51daac5c4feb..136c2efe3466 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -187,14 +187,14 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	exists = rxe_get_dev_from_net(ndev);
 	if (exists) {
 		ib_device_put(&exists->ib_dev);
-		pr_err("already configured on %s\n", ndev->name);
+		rxe_dbg(exists, "already configured on %s\n", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
 
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
-		pr_err("failed to add %s\n", ndev->name);
+		rxe_dbg(exists, "failed to add %s\n", ndev->name);
 		goto err;
 	}
 err:
-- 
2.34.1

