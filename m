Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C76185E3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiKCRLu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiKCRKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:50 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDE10F4
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:49 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13c2cfd1126so2871303fac.10
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCEfxEkils71RYcvaHdWSSGot5DikQ5MmHIK2QvP17o=;
        b=KVln0ZOK87J8aH69CS1DLU5/i9Sl9ofahdE/yT/+4x25b0NuPbJIdMqyA3VyhwP4k/
         YdhAbF1TwL47F8ErdTFtdLZzmStbgkv7zzj22S4PPoelPpgKxTs0sIT5cuJ6Q9QOMViD
         QP+VHzcdUPnRI1ywk25+WkeZrEy3G9eLNvdeancy+/lQHeeQUKQJve1gvY6mCXRDGhrk
         aQNGE9Slb+AwMlCB+5AvqRqzgcUo1YTcXBi2H6vyHDwQGHfERFgKi0/xhnamGSIk9C3Y
         tjl91FL26Mnd1F0HMSF4glhsfaur5YHHNPLoVBErUuwERWP2VtBTXR26iQhu+WwitoEv
         QSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCEfxEkils71RYcvaHdWSSGot5DikQ5MmHIK2QvP17o=;
        b=u4m0uESNfSSpO6kGudNdrI5zdzABTnPBCrBrF8vfIbxAU7NOST1MMyeSyCVYLQlrzn
         AbsViYxKQR/uMJCStHFFCRjQK2t+LzbetKtCzIkZ9sXFOLuG54EVPxUZksD2aDuh5H8a
         aSC9RByGwztZ6ABltb7FFxPrYiPHP0AIYz+9bzfEvpH7IgWD6xwsTRnpOoSAzb6HjiV7
         B2sZ6Wq4l1mEiOrqN/p5F/MaNhIVxm/GirCq2EJY54004iQgNFHqHMYTkKy3GC/kaHuJ
         GaW5Ec7JckkNCTKAMyd7z/gA9T80ROExBVnuenHYwNVLzaW0gXxw0PYUsuvnj8UwMUKQ
         Xv4A==
X-Gm-Message-State: ACrzQf3ssQaf/4O9VI36xuM7JfhJwh/NWFcZ5eblGu5jP4sSAtO0cfT3
        DBrlRLdIMaLdTlQSvIWFxmk=
X-Google-Smtp-Source: AMsMyM4zzIOkE3iGe+ReSYxG7ZTngepO2SVQlpyFJ+Sbe7RyavvcUNkN1wjayepUvC/dv51pmbtVVA==
X-Received: by 2002:a05:6870:f6a6:b0:13c:c80:6d7d with SMTP id el38-20020a056870f6a600b0013c0c806d7dmr27745169oab.221.1667495449108;
        Thu, 03 Nov 2022 10:10:49 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 14/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c
Date:   Thu,  3 Nov 2022 12:10:12 -0500
Message-Id: <20221103171013.20659-15-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe.c with rxe_dbg_xxx().
Calls with a rxe device not yet in scope are left as is.

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

