Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2A213CA2
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 17:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGCPe4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPe4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 11:34:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5CC061794
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 08:34:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so32406752wmi.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vfq+dt2Ndtwz+iv8SBbAEN0bU6YUaM+BMcTgsk78z2I=;
        b=jvJIbJKB6br84752kikUiyuoEh92TjCbmOb8RYFRgmFdrvpzHZMx1j+GHxUpCnPfK3
         S2YPR1W/aPmLXWVT4Es0SMmtglgiMllbYCcoe+wlUc4EvNgeRyGi6JkFGwXbpMRbgGcw
         Ry/USL4gFug7wTP9PW2B47KoXn8/ts3f6C62OLKUvrEiREOMsu6nRKHKd1nAgS7By5Hc
         6x7OTiZcTRFEBz1IcadUvhBudTygHBo45PS0Z08jzYqADDl7/Flj9HVrZ9OVcVixlkQf
         vlYgYq8fpAVwDn00eMxykbSZudb0gBsFTUBzRaPg5FyF8U+xuKTHYaaWktrlgXiUyi1r
         kFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vfq+dt2Ndtwz+iv8SBbAEN0bU6YUaM+BMcTgsk78z2I=;
        b=CpqQaZVlKjk5TNH+T49BpzgBx3cNIZHGPJ4xD15V82LPvijzy3BTjS7sWncQ/Obk+b
         89h1AT9B7s0bUsh3jkapXHUSqvE5TW18+xuUssjxjqQhOCQYx0oCM2+usC6e9XUHQ/gJ
         cSeedgm3XOBsZp5mP+eG0IdK4xFHsIgt2/N9hysrLkQTaQgdgNao5LhMVUOQzJ9EtkFR
         qPxhBSny6+nYbiCIY8fbpPHWXAqf+Qryk29bVLYErAPyt7ZBROo/fbrB1QXR0mSJQCgZ
         PHaj/HP9Ms3DWeNCeGL82XjQ3+l4kbP4vD6qBTBiOGIX2ZydOJ877+IQAtabhDdBfjpk
         L5Kw==
X-Gm-Message-State: AOAM5334/K7nwWezETQpV53qd1ETBkwJuK45SAJhJ/s5qyOxL4I8pjpu
        iUQt1RPnG2OfEp94JX8XmVwQ4zWv99Y=
X-Google-Smtp-Source: ABdhPJzMPC+bmVXUAWW9iHWgzJekX0TUZVkV3YeGZKVvgkvBm6QQxJsGRTmuCaBsbP/5nN9TaTf9TQ==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr6990347wmg.90.1593790494364;
        Fri, 03 Jul 2020 08:34:54 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r1sm14083225wrt.73.2020.07.03.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:34:53 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 1/4] RDMA/rxe: Drop pointless checks in rxe_init_ports
Date:   Fri,  3 Jul 2020 18:34:25 +0300
Message-Id: <20200703153428.173758-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703153428.173758-1-kamalheib1@gmail.com>
References: <20200703153428.173758-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Both pkey_tbl_len and gid_tbl_len are set in rxe_init_port_param() - so
no need to check if they aren't set.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 5642eefb4ba1..c7191b5e04a5 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -147,9 +147,6 @@ static int rxe_init_ports(struct rxe_dev *rxe)
 
 	rxe_init_port_param(port);
 
-	if (!port->attr.pkey_tbl_len || !port->attr.gid_tbl_len)
-		return -EINVAL;
-
 	port->pkey_tbl = kcalloc(port->attr.pkey_tbl_len,
 			sizeof(*port->pkey_tbl), GFP_KERNEL);
 
-- 
2.25.4

