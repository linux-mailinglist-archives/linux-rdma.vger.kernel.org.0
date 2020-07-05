Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00E1214BDD
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGEKnb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKna (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:43:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2A3C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:43:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so37618108wrw.12
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vfq+dt2Ndtwz+iv8SBbAEN0bU6YUaM+BMcTgsk78z2I=;
        b=sjc8S7xepNktrmWUleqyeqSjq4Khe3HLVtA9JQ7qw4kqdhuQotP+FI1TyduTpm6qSL
         jH9iYyWYVLnxvbEY295uVAA7kq+r++fJTGWo3IaGQaAPSf7oOzBXwmrKlCgw5WbbF4uu
         qqF+N9kfQV/3v42IBtABZNMtNh0KGd4XGE7bnUk6ArYRyW/hFfmscHZ12TuOJ0iePMwo
         mgHVTLhRdIV2+M5BJhKp6TW1RjAf5HmQN8mhB8eNDDzbJnTqjJIbIKszZW9ptYLhwC3J
         q7BnPoxhOgCyDyXsjExlls9kg8e+JtE5kX2iRH9iVK3gwpqfdYbBpilDjZylXXi4lgfi
         UVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vfq+dt2Ndtwz+iv8SBbAEN0bU6YUaM+BMcTgsk78z2I=;
        b=P0b6i2nKH8BOmo13FAfRJfjFk/kdOz1LE7V3b3+lzuH9OYW20p1EnhtWtjAEeb2bEL
         Gz+ZMugvLqPfdW12fdmvELSLYnjlitkID5hRNcMsFjHfDcwucoMEh8fS6Ol75fZYNHuz
         MrxePIc15fcYyqZAmzZIIFPxDIlbF1o4ezEhvJ6kT1LAuj34PvAXASkyJomzy8IQnbhm
         eooBjVaqbEUvPb+piItcyMzqLGciywG/xHtAVMzzCvxG+pyAt4f7X73SP9U4KDvzQ6MW
         9QY8d1dtdI+06m+YQBHSWoMtbFzb4ZiFHTWHSjQRAH+1Pwwwo1WTt/AulnNtmCAkc6dL
         Codg==
X-Gm-Message-State: AOAM533oK5MX+iVCYc1bWUcJXt6FUI4xVd5f7VQMMJPBCnarhgoNCzEK
        QT+t0hreVf6x+CdzlfwxlWDkjKzHdFM=
X-Google-Smtp-Source: ABdhPJwIeqSl0IEoYVgW6noQtGrUHyz0F5algDZjhCgCDGezC0w8zAlQPakueI0ZfS3Tx2HWBdbXYQ==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr41587608wrm.146.1593945808981;
        Sun, 05 Jul 2020 03:43:28 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 51sm14828083wrc.44.2020.07.05.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:43:28 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 1/4] RDMA/rxe: Drop pointless checks in rxe_init_ports
Date:   Sun,  5 Jul 2020 13:43:10 +0300
Message-Id: <20200705104313.283034-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200705104313.283034-1-kamalheib1@gmail.com>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
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

