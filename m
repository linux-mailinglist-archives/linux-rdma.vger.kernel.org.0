Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287A6A155D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Feb 2023 04:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBXD3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Feb 2023 22:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXD3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Feb 2023 22:29:35 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F784FCB0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 19:29:34 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v17-20020a0568301bd100b0068dc615ee44so3171056ota.10
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 19:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TniLffpyCgHkUgRabzidVT07H3CKHA6Trs2Hwl6tk4=;
        b=GniEH/FzG72MFCsiSNqCKlIq2PPu3DrNp6qgytsfW05qaEzOXs/njJVZIIQWVOAPwZ
         P4k5rM8daspEP99u8i4ywXYxcGNkg4/mvg2TQnlU4HrTqqq7iBpHQyaeP4BqswwA0ZMs
         xY4mNFXnAzAdWJHeulfU71pbVzDrskZE+3k8qsZZ7Zp71lSiO3m8Jhf+WOGa35CDpciV
         +vLwAx4e/Rh9iHqjgIQKZMfOIedjqRsbB5rrYQDgJ+Glv2GNBmMLp8d+RpCzuoqdxMfo
         uQQ9QKesDR7SG0N8QiTcilOypswGkgIt3e/tHuawmY0iFZNqb11QWTo2zTCJn9Y3qirG
         7x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TniLffpyCgHkUgRabzidVT07H3CKHA6Trs2Hwl6tk4=;
        b=r8hA/u3ttkn7z5tMCTrhSsLFsqkA+2XcGxgSdR7rc/gAuwRJNgqYo4pwqGRWAplW7W
         TORcLVGTDGKT4mxKM+BZMyt/aAz5ydQQeBF5ZAmNvgc8Yawdk1JKNqZHlk4D5hbjjHTO
         8tb+pdBhwukR3ZqUsM6AdUoGqZzsfXaaVctdjXv2yNFjIAV71ps1Ti70ce4EJMabsjjn
         oQrROH7m0Nw0CcSmjl/usb5Mz3s5re44Aq0wFdZicYr1AuYaxnNZTLm9laRIt3L9GSJ3
         XTR/C+DeZtTnDdWIxnumBvov+XzDDVIjIIG+0gqTh3Dy/Ig4glD4ObFY+vLoZDkztqDD
         Do4A==
X-Gm-Message-State: AO0yUKUiyfnhYz5VukcUEqx7aa2ezgM/OsNZ3sFc0GomU/4gxcOkpMC/
        QOrm9NZx9mrKQMdjFMzY1HUDIvxyRck=
X-Google-Smtp-Source: AK7set+iyMs7IxTP4Y7vwERT6XEiB8BKLyCD4tnYmFtmsCBJgkC1rFToBRRRm/7VK7TghHJN4HUvBA==
X-Received: by 2002:a05:6830:1f35:b0:688:4c9c:d45f with SMTP id e21-20020a0568301f3500b006884c9cd45fmr3217725oth.20.1677209374135;
        Thu, 23 Feb 2023 19:29:34 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-07e1-19cc-c957-ef10.res6.spectrum.com. [2603:8081:140c:1a00:7e1:19cc:c957:ef10])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d550f000000b0068d3f341dd9sm2587561oth.62.2023.02.23.19.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 19:29:33 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/4] RDMA/rxe: Replace exists by rxe in rxe.c
Date:   Thu, 23 Feb 2023 21:29:15 -0600
Message-Id: <20230224032916.151490-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230224032916.151490-1-rpearsonhpe@gmail.com>
References: <20230224032916.151490-1-rpearsonhpe@gmail.com>
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

