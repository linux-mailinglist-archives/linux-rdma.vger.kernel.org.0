Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C1C607D7C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJUR0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJUR0v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 13:26:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F8222F2D;
        Fri, 21 Oct 2022 10:26:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f11so5607869wrm.6;
        Fri, 21 Oct 2022 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1smLvhc00vFSRdt9cQe6UrqqjkSr7Vg1lie+4ZRJvM=;
        b=gEdY+/fwPGaYwRLX2p1Ry+f9Zj352n1wHYERAWT65eInaE8Z71Q5tg0NITXQbVWc97
         2ELglneSc7tC1fjuoE3rHTZkXaHfOOIsAn0c42dODBbT4Q2F9Culs4z1KDuLU5on/4oV
         NkpqbcCXprEcVnpB3mo5m82dY3c8oa2dEIVqEz5Fz4Id7lc8tGOSi0V1PuJVwdAOdxSh
         /Sj+jCkhTu081p3iuPivJv0CTeDkt30+cDlpQ/3xrZFl16GJucXDqiu9YlNmFRK7gYU+
         Q0DJDcNrVYsD6jRABrzG32arjOT3u4XGMQrMUlPjvpe78+mRu5K57qJXF9bX6cAcRqyN
         muzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1smLvhc00vFSRdt9cQe6UrqqjkSr7Vg1lie+4ZRJvM=;
        b=5Hlr7B5QR5SVHUgoygWi+vs+EV7hAt7v8Cwxij5ONgjagJOrhlfle5paNqxPzdht4y
         CBX4h7adFQMxB1hVSxTaP72IyX/CQ0NeHeel8kCOlHgJ+6RE3k9RJP9k2Nb2kixvUaL5
         X01I4c3otRoL/3CJxj7jo0kYPHjyc3ZVz90ljQVE39Qkx1fuda/06k2gyW0ELEZFmH9z
         Eizk6kOJqHHNSFAhB/LeYiYkUjjjxGKuMJ0wgkx2NhVRMWxzVftWuD1g8bwVcLuokl1n
         m0aRfe292wAAmnNCOGrEBUp8ofEx95+6jAuCC3yybYQjugg5Rcod3QFnG2HBzrUjBZ3u
         MlDA==
X-Gm-Message-State: ACrzQf3oHpUvEN24LPpmgQ87rlDzuPh1gwd6RgVDOVB0tPFKqtA8jeLY
        L+gA1eWbyAAdSYvDaeKWDDEZQNgLfkvdgpb2
X-Google-Smtp-Source: AMsMyM52nOLyNVcwIomZHFgFXumH/m4iMVhBwFwSwWc+G1mfAnrDPWTgblfPwH65bSn0giZT2YWcDQ==
X-Received: by 2002:adf:e549:0:b0:230:6d12:fc84 with SMTP id z9-20020adfe549000000b002306d12fc84mr13066908wrm.64.1666373172479;
        Fri, 21 Oct 2022 10:26:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm19431961wrt.41.2022.10.21.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:26:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hw/qib/qib_tx: Remove variable n
Date:   Fri, 21 Oct 2022 18:26:11 +0100
Message-Id: <20221021172611.26763-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable n being incremented but it is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/hw/qib/qib_tx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_tx.c b/drivers/infiniband/hw/qib/qib_tx.c
index 6a8148851f21..1325110237cd 100644
--- a/drivers/infiniband/hw/qib/qib_tx.c
+++ b/drivers/infiniband/hw/qib/qib_tx.c
@@ -82,7 +82,6 @@ int qib_disarm_piobufs_ifneeded(struct qib_ctxtdata *rcd)
 	struct qib_devdata *dd = rcd->dd;
 	unsigned i;
 	unsigned last;
-	unsigned n = 0;
 
 	last = rcd->pio_base + rcd->piocnt;
 	/*
@@ -102,10 +101,8 @@ int qib_disarm_piobufs_ifneeded(struct qib_ctxtdata *rcd)
 	}
 	spin_lock_irq(&dd->pioavail_lock);
 	for (i = rcd->pio_base; i < last; i++) {
-		if (__test_and_clear_bit(i, dd->pio_need_disarm)) {
-			n++;
+		if (__test_and_clear_bit(i, dd->pio_need_disarm))
 			dd->f_sendctrl(rcd->ppd, QIB_SENDCTRL_DISARM_BUF(i));
-		}
 	}
 	spin_unlock_irq(&dd->pioavail_lock);
 	return 0;
-- 
2.37.3

