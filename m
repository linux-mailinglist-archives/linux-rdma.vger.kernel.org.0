Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08446AA441
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Mar 2023 23:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjCCWZc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Mar 2023 17:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjCCWZO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Mar 2023 17:25:14 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7820982125
        for <linux-rdma@vger.kernel.org>; Fri,  3 Mar 2023 14:17:45 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17213c961dfso4793436fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Mar 2023 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677881805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TniLffpyCgHkUgRabzidVT07H3CKHA6Trs2Hwl6tk4=;
        b=lJAAGmcDWeM4KbBLl82ND6vecMKcFJ0A/MjB3Qw8x4JneTve8bWVqk4GhPJc7wQvGS
         INRb07R6EV0Ze29a2RpnrSR4fEFDZ92UKMywQvOOjigDYD6/76hYt3/hxQyqL5/GPGvL
         TrBnGGAouPADWSneeOYorPGTavcz9bBt276qsIN1fc8C979SqqLcvZnSbuCYE2DADYCs
         S5V/FkoOJE0qTL1lRDh333FgKZqZfHXDZECUpk5ph1D5zgf5j2OWPnZUsrQwAMqP34dk
         2M/Cgy5twwvtk3s68xkytI8HgONTLFy1iik7ES/Vf6jRdsXI4l6g0v2F6JKk0RrkRTHf
         JDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TniLffpyCgHkUgRabzidVT07H3CKHA6Trs2Hwl6tk4=;
        b=dmRbEfjZx4qn5CJl8Q4MHa7RlygRyBsDifJN0vfEdL5Wwt+k7ZgvS2bnMD0FjFBcbg
         H0wBl5zslUpGV7aZcOETrM0Z2VXzPf47Wg8eox+rCUaDs9XJqVHCQk+5rGcmL2UbOESz
         dA6v7X5lyG++SXkccj9h5Hp7x621ROHaR0USKzCLzwOXutrKX6/aNSpyxu3cwLVVDGSN
         o+UNq5Olqkaa3XD0D14YoAs9RiV9G7M9T0svD4iQ3SqmeOwof/NNYy5MCflx23DMgU0F
         Wr5gP6NJ/tGK60hA+p0egP8rvzHHqdZdnnTLojR/WTPrbtPJ8dtqMlouUQznqAf/n5dh
         J7ZA==
X-Gm-Message-State: AO0yUKVl4VdVSEyrXitII5iTmKoZ/Upm/R3c5gSt8DdIlnclQMg3LBu0
        a7/xkP4AOh99/9VOS6HAAwLYnlelWQU=
X-Google-Smtp-Source: AK7set8aFSEPzrSI17/x6SmnLQRvr7Pp/wJZExqK6rUCcl1j1KNzk2CKKSGUbQUZNZ3gt7jrNGWXNA==
X-Received: by 2002:a05:6871:14d:b0:176:6c0b:cd5c with SMTP id z13-20020a056871014d00b001766c0bcd5cmr2447965oab.22.1677881805306;
        Fri, 03 Mar 2023 14:16:45 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-de65-7c8e-0940-8c68.res6.spectrum.com. [2603:8081:140c:1a00:de65:7c8e:940:8c68])
        by smtp.gmail.com with ESMTPSA id zd34-20020a05687127a200b001730afaeb63sm1480740oab.19.2023.03.03.14.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:16:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 1/4] RDMA/rxe: Replace exists by rxe in rxe.c
Date:   Fri,  3 Mar 2023 16:16:21 -0600
Message-Id: <20230303221623.8053-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303221623.8053-1-rpearsonhpe@gmail.com>
References: <20230303221623.8053-1-rpearsonhpe@gmail.com>
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

'exists' looks like a boolean. This patch replaces it by the
normal name used for the rxe device, 'rxe', which should be a
little less confusing. The second rxe_dbg() message is
incorrect since rxe is known to be NULL and this will cause a
seg fault if this message were ever sent. Replace it by pr_debug
for the moment.

Fixes: c6aba5ea0055 ("RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 136c2efe3466..a3f05fdd9fac 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -175,7 +175,7 @@ int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 
 static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 {
-	struct rxe_dev *exists;
+	struct rxe_dev *rxe;
 	int err = 0;
 
 	if (is_vlan_dev(ndev)) {
@@ -184,17 +184,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
-	exists = rxe_get_dev_from_net(ndev);
-	if (exists) {
-		ib_device_put(&exists->ib_dev);
-		rxe_dbg(exists, "already configured on %s\n", ndev->name);
+	rxe = rxe_get_dev_from_net(ndev);
+	if (rxe) {
+		ib_device_put(&rxe->ib_dev);
+		rxe_dbg(rxe, "already configured on %s\n", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
 
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
-		rxe_dbg(exists, "failed to add %s\n", ndev->name);
+		pr_debug("failed to add %s\n", ndev->name);
 		goto err;
 	}
 err:
-- 
2.37.2

