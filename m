Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3333BB25B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436676AbfIWKmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 06:42:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407110AbfIWKmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 06:42:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so13311297wrv.13
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cz1LJdzWH/OvFVqiHLE6dIfJX3wb7zA3QsLXTXfoV6Q=;
        b=afQaDIJy8BnDcvLiZI6vNYIqtGQfBC4n+Nlmz1KCnsRdZOusBicXqDtFduEB8zu1hw
         b3T0j3px87Rf61+QvQtExGD4N2Rftnl9Fb5RudnOvWO4UMF1yElTZoKlJy4it2pXzASd
         OlZdepVjbSr/UOvq+HU17nG0TfsOq6g8IeLE/cLZthTACEOm20LpB/gmGGm3idd+tD36
         +G+2R0xUbX0+UNVQqyEHIFa9NzY8PIy0REJ56RGGFac/7Bl4TXFSJLgmtRLy9mlh0HXV
         LwaJlkUJNNKyFrkUwzZnMC3gP5uTNF92ZqC16UcnlNwqFSwjJgoY8ngc2qYXRV4IPqpj
         dQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cz1LJdzWH/OvFVqiHLE6dIfJX3wb7zA3QsLXTXfoV6Q=;
        b=Be+pYU2bBvZ6WF8ifgJeuzoLTuuEaAYkSq3b96nZIjrrwa0eLcVRVjEWU7TyUxSk5n
         nxCbEdIYtDTaQsNQZkuSFDSrSmLFhGzcp4H5FOpbKJf9bpFimo6wzRfYoQfQ5SpJ2aD/
         WQ4pRmInBNLnbK2c98ZZrlH1xqYorKlRpN2waXEh6jsTNiQalHmvjWvnoqrbXebQws63
         xPINbLzMhng/4VO55JsT9zTBTIDAa3GvBgLrKcBFy0cwDXlOd3hlxEP0E18xBjU1WSF9
         sNG0V0VKdwkkHGoMhEDb8XLnkVZvdJ7zfkXhz0lxpa2Jh0drvkJ/drZNZ1qUyoInv6TF
         N/hw==
X-Gm-Message-State: APjAAAUZ58AIzSynHc+qR10w6WnKhb+MsQgxICZ2jzAMcH8mBwsPFuC/
        8jYeC9Cza4ADfVCzunAbIJjDJBte
X-Google-Smtp-Source: APXvYqxDtnJAxUQ54t88uwkFecvDf0qAzf8Ft9bQlO/UFMWwOgjTzUATVMCjvEudEAm994gLUs6zKg==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr20047666wru.48.1569235333823;
        Mon, 23 Sep 2019 03:42:13 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-41-92.red.bezeqint.net. [79.181.41.92])
        by smtp.gmail.com with ESMTPSA id u22sm18508427wru.72.2019.09.23.03.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:42:13 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Moni Shoua <monis@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 2/3] RDMA/bnxt_re: Remove unsupported modify_device callback
Date:   Mon, 23 Sep 2019 13:41:57 +0300
Message-Id: <20190923104158.5331-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923104158.5331-1-kamalheib1@gmail.com>
References: <20190923104158.5331-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not supported.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 ------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 ---
 drivers/infiniband/hw/bnxt_re/main.c     |  1 -
 3 files changed, 22 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b4149dc9e824..8afd7d93cfe4 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -191,24 +191,6 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	return 0;
 }
 
-int bnxt_re_modify_device(struct ib_device *ibdev,
-			  int device_modify_mask,
-			  struct ib_device_modify *device_modify)
-{
-	switch (device_modify_mask) {
-	case IB_DEVICE_MODIFY_SYS_IMAGE_GUID:
-		/* Modify the GUID requires the modification of the GID table */
-		/* GUID should be made as READ-ONLY */
-		break;
-	case IB_DEVICE_MODIFY_NODE_DESC:
-		/* Node Desc should be made as READ-ONLY */
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
 /* Port */
 int bnxt_re_query_port(struct ib_device *ibdev, u8 port_num,
 		       struct ib_port_attr *port_attr)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 31662b1ee35a..23d972da5652 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -145,9 +145,6 @@ struct bnxt_re_ucontext {
 int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_device_attr *ib_attr,
 			 struct ib_udata *udata);
-int bnxt_re_modify_device(struct ib_device *ibdev,
-			  int device_modify_mask,
-			  struct ib_device_modify *device_modify);
 int bnxt_re_query_port(struct ib_device *ibdev, u8 port_num,
 		       struct ib_port_attr *port_attr);
 int bnxt_re_get_port_immutable(struct ib_device *ibdev, u8 port_num,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 30a54f8aa42c..7b914bdd7c13 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -625,7 +625,6 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.map_mr_sg = bnxt_re_map_mr_sg,
 	.mmap = bnxt_re_mmap,
 	.modify_ah = bnxt_re_modify_ah,
-	.modify_device = bnxt_re_modify_device,
 	.modify_qp = bnxt_re_modify_qp,
 	.modify_srq = bnxt_re_modify_srq,
 	.poll_cq = bnxt_re_poll_cq,
-- 
2.20.1

