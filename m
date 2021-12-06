Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8746A976
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 22:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350654AbhLFVRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 16:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350541AbhLFVRi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 16:17:38 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4422C0613FE
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:14:09 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id m6so23866345oim.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 13:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1us2qZX+gf/MenFGjy9vWQwRK3b/AStIBzbqn7qx5A=;
        b=czqh+0PYq3yNM35BwqGlJbfHCBsaqRWsSWcaqKoi+p/0UH2OGeq5cgImKQc5+3K+c/
         n/iR9JJrloM3bngifdO3Aja7JmSPGlUfBTPVhGyOYOPj2daNsE1ypxWu2+OxROh0s6Pv
         uLxH3S+AU1QMmUtm8FJz84mW/mJubThI8zrPMiaWkQGvtkNfcBKKKye10/WCdTe194zx
         SFLjtc+WDHk631o+Kpf/mG61+zp6oX5FuT5xq1KyYiNOIkMPbUB7jyX8GNG6bYpvGpbf
         pmuWgEc5Ghcq/YM3nkXE3epaLNbo9ykhKGByxNxGMTgMoqHkUel94/MJOCND3Cak/tqN
         K7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1us2qZX+gf/MenFGjy9vWQwRK3b/AStIBzbqn7qx5A=;
        b=eNrxFdYgT/heGdoY+pkBd3WCvC3ZWeTiMchpxpexBvXGQRqfwfvJcSf4cQ6415Sv1v
         bt5Tbs4mnpXrYfB2iBhZR/8iCfQXbNs2VlIgum4mqUFStDMBwZBNH7e40s63wbp1OCYl
         XwmtCZlWj6lBVB1uwuO3ZQqRTu79lK9lI+SsSjWU6B+rWShLlaveQc/1syndBQt7+jzH
         1fwu3/EdJ7hxqdkBY6hW/JLwJSYIv2xOZWeFJaQ0QISf3Ulehw5ROF7pnyjnF1YgN/JA
         astwtmkcw4tRIx0QJPjiEdeoC5BLlShKHxhOv6tBg7T0RlUdvf7F0wD4Acn8HzxCrpF7
         2bcg==
X-Gm-Message-State: AOAM531NuCVNZSH1OHJxudPvKHC2EHNFHl2SsFjRSQpVyESsSXyfTw95
        XQDaSIWIX3EdgL444Pajvd6V5wFSkm8=
X-Google-Smtp-Source: ABdhPJzfGUxncyfalDQVUjh7p9qBQ0vct1iHT9JQCb+TcFujyzyoBDCBE5MEx46q7AMZ6OI7Hp8IbQ==
X-Received: by 2002:a54:4614:: with SMTP id p20mr1198200oip.39.1638825249200;
        Mon, 06 Dec 2021 13:14:09 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-07ad-dbeb-c616-747c.res6.spectrum.com. [2603:8081:140c:1a00:7ad:dbeb:c616:747c])
        by smtp.googlemail.com with ESMTPSA id y28sm2819111oix.57.2021.12.06.13.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:14:08 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 6/8] RDMA/rxe: Minor cleanups in rxe_pool.c/rxe_pool.h
Date:   Mon,  6 Dec 2021 15:12:41 -0600
Message-Id: <20211206211242.15528-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206211242.15528-1-rpearsonhpe@gmail.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch includes a couple of minor cleanups in rxe_pool.c and rxe_pool.h

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 10 +++-------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index eb3566b2ce01..ab48b4dec9cf 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -97,11 +97,8 @@ static const struct rxe_type_info {
 	},
 };
 
-void rxe_pool_init(
-	struct rxe_dev		*rxe,
-	struct rxe_pool		*pool,
-	enum rxe_elem_type	type,
-	unsigned int		max_elem)
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+		   enum rxe_elem_type type, unsigned int max_elem)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
 
@@ -109,7 +106,6 @@ void rxe_pool_init(
 
 	pool->rxe		= rxe;
 	pool->name		= info->name;
-	pool->type		= type;
 	pool->max_elem		= max_elem;
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
@@ -222,7 +218,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 }
 
 /**
- * rxe_pool_get_index - lookup object from index
+ * rxe_pool_get_index() - lookup object from index
  * @pool: the object pool
  * @index: the index of the object
  *
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 01f23f57d666..62e9e439c99c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,7 +46,6 @@ struct rxe_pool {
 	int			(*init)(struct rxe_pool_elem *elem);
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
-	enum rxe_elem_type	type;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
-- 
2.32.0

