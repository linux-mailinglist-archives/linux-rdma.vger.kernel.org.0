Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDBB6A6653
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 04:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCADKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 22:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCADKv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 22:10:51 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4537737
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:50 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so6823661otm.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TniLffpyCgHkUgRabzidVT07H3CKHA6Trs2Hwl6tk4=;
        b=OrQJj/clS64bOhqpa946dskrvRwWDoaWmAEeE30Hba4WJDrg6jWLPKN+DOGdIIVtBi
         ss4UNT9Rq48pujlpoYX7dmwffYVQ84l840MpYFV2VMhF/rzOimHorO3qW76RCuUnFdc7
         Yxm2MNQSDnNSOh4+lJHcLNZWbOmcV+AsVserv/+9NRxL22dovNyDSHEm05M0lguj88Xh
         wy9ofcilsPUMRHzqK7s9abiAQ0zcbACpquGkTfZvAwDrz3i8uLC3Mm6+lDrkDLR9zkwh
         8/CH1z/lRlSE4ozciqs/iDbrqvsbTOEjEWxCOiOzgI0qiMzYFDO+OC2s6JvqOAvc/US5
         6rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TniLffpyCgHkUgRabzidVT07H3CKHA6Trs2Hwl6tk4=;
        b=xRGwaTqw7tRmSXiBB5wVbwnJU2gGCjw7DxLTs8yNmYktM7AZl1mId+fomGelpvj8cX
         PlFuRueslxXpgP3tBF/8x+QCe0+Vhy0Rahhde68CnnTApqmzAKeAU7l/1YNjwSoeLwWf
         XkUGVyUdmYVPLGodxrPKXw2QWjPlH+BLRKTNOjTmEbbN4nFlvFMCvns1PF2MJkTMJb0+
         1cTElV/AgkyPB3q0sm9re2nnrVsU4B4O544pq/5gcEcm3RCtYHQzGi+iQujIibokjhK3
         /PiAE7NYo+UBP272oIEtaatPVKX0t0l9axjWIaHukmDJ3dQXWSz4BdVQgBj89qWv+9US
         fTyQ==
X-Gm-Message-State: AO0yUKXJkEUudKJZKNj6gsi30z0D/GtY3hia35/rTwniZ3JcQ5iSnTEI
        UMaJqizTfuiVAWh8iT86ICW/32U+fNo=
X-Google-Smtp-Source: AK7set/g7zGiNMKSvRGnuxEN1bQ/ko57zvhPVhRnfe4eBqQfAoh3ix6Zibrpn9pMCOgSgzlIaQZNrA==
X-Received: by 2002:a05:6830:4128:b0:68b:b532:f411 with SMTP id w40-20020a056830412800b0068bb532f411mr3068377ott.27.1677640249684;
        Tue, 28 Feb 2023 19:10:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id e7-20020a05683013c700b00684152e9ff2sm4484942otq.0.2023.02.28.19.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:10:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 1/4] RDMA/rxe: Replace exists by rxe in rxe.c
Date:   Tue, 28 Feb 2023 21:10:36 -0600
Message-Id: <20230301031038.10851-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301031038.10851-1-rpearsonhpe@gmail.com>
References: <20230301031038.10851-1-rpearsonhpe@gmail.com>
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

