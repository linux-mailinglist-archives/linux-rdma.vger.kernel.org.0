Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6755BE75B5
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfJ1QAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:00:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731619AbfJ1QAK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:00:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so10466166wro.7
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TycqH6hRWVQcQ82ZcSfaibr4XzfZ5J5iKsyxzuflrxg=;
        b=iuWEyiobUP9puSRAbKS1qbroa23dq8GlnO2OjxXb6vcPm7LQAyvNPbhZM0z8Birjcu
         7hiqW6egcpx2a5i7/uMIYCJA6kBjbrxgIjWv3udSU8iRrs0hUO5VPqdd4uIdZProNmXN
         OSoQCTroO6de/wJMYRL5aRxtqv6nXKjiYQE+gocZ5c5X0gySXvWY7C+7VwufLRl8dU3Q
         nivIY6KOW3f1qMlgFFcfSZxzbVvZRdOMznd4iY2i8enEjOtqrzMn/lVZG+Hk09Pqanjs
         iXBCRcrkLxrpq7j0sPQpQ+TVy0sItCYc2Vu0PGr4VmXtyuOzgvWieC45A9u740pR6LVa
         yrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TycqH6hRWVQcQ82ZcSfaibr4XzfZ5J5iKsyxzuflrxg=;
        b=B7Q/Eam9p8HAYrEj5wBf5hUTnF4FOX7nP95R4CFq/CiSysHTuLarGNxcc2HbWirXTe
         GsRZOWWGM0H0sz6my1c+HX0uuu9dPAGkBj92ZwrgYJhKWxQYChWK7MCwMICloq4MQD44
         ggRORgWW4wRzoxr2mcgJutmKRn27UuR6ZpPjB99pxMjh5MNpJXyFksXSKIwbrk2ZXLvh
         1wV1E2fJQe67ieKO8k2nMqIiW1JX4trgfn1lK83z5d19OiNmBaue/Dq8wq+2+twqEaXQ
         4pEkqVrC/MeUmgKK0wpIpOslb42L42TNbJln1H1plJnn/llMH8D6WRD01FBwP9ZDagjc
         zYdA==
X-Gm-Message-State: APjAAAUtYD8JMu9wFiHsVsfI35zo0lLJz2tmHZuoGL9hFraFFdVqFXXF
        2sJupA23Cj5dGt06ebf2DjQxv+6Tbp8=
X-Google-Smtp-Source: APXvYqzNE6N5MaNJ5GMXkKvE54QGHMPHNsNg3s6CM43Ofm67yZiwpimJZU1dzgXtAB26eDTOJhEsvQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr15437475wrp.315.1572278408097;
        Mon, 28 Oct 2019 09:00:08 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id a2sm11871600wrv.39.2019.10.28.09.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:00:07 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [for-next v4 4/4] RDMA/qedr: Remove unsupported modify_port callback
Date:   Mon, 28 Oct 2019 17:59:31 +0200
Message-Id: <20191028155931.1114-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028155931.1114-1-kamalheib1@gmail.com>
References: <20191028155931.1114-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: ac1b36e55a51 ("qedr: Add support for user context verbs")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/main.c  | 1 -
 drivers/infiniband/hw/qedr/verbs.c | 6 ------
 drivers/infiniband/hw/qedr/verbs.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5136b835e1ba..e5f36adb0120 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -212,7 +212,6 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.get_link_layer = qedr_link_layer,
 	.map_mr_sg = qedr_map_mr_sg,
 	.mmap = qedr_mmap,
-	.modify_port = qedr_modify_port,
 	.modify_qp = qedr_modify_qp,
 	.modify_srq = qedr_modify_srq,
 	.poll_cq = qedr_poll_cq,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 6f3ce86019b7..fee02ac47f32 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -250,12 +250,6 @@ int qedr_query_port(struct ib_device *ibdev, u8 port, struct ib_port_attr *attr)
 	return 0;
 }
 
-int qedr_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		     struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int qedr_add_mmap(struct qedr_ucontext *uctx, u64 phy_addr,
 			 unsigned long len)
 {
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9aaa90283d6e..d81b81f86f0a 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -35,8 +35,6 @@
 int qedr_query_device(struct ib_device *ibdev,
 		      struct ib_device_attr *attr, struct ib_udata *udata);
 int qedr_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int qedr_modify_port(struct ib_device *, u8 port, int mask,
-		     struct ib_port_modify *props);
 
 int qedr_iw_query_gid(struct ib_device *ibdev, u8 port,
 		      int index, union ib_gid *gid);
-- 
2.20.1

