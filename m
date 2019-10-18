Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54751DC18E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404496AbfJRJlh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 05:41:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50838 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390553AbfJRJlg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 05:41:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so5474063wmg.0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nLBDNnI2ytUN/R+LaCECQ51HAzPdQVxI7fwxKBAxkk=;
        b=CpxitlkK2kw5eHHRk/N7OrnkoOy+P0zGzG0FmJIMB2MbV3WrohuYgu7VeCT965LXix
         NsZnPXvMHendhlQKMBHMM13Dg/KFMrCQgJFOPY4CCdxQFthi7MZcqfpMkNlRz9zTd+qQ
         Oh2/5es82icn3vZ5EFLWilirGhZhIYQjtPNWTeAWB22tg3NGT3gswexcw7O+ZPWCruPn
         rBf6fm+clg2SdQQkY5OM721xQqj/D5L38EazyMnHi5AM5cA837XLDFlVu/FXmoRhT/Z2
         A1dVma2RrKxwVUI5eX97Zn1Hit+/cpTJjAN48ZFYAqnc0KItIaj69Q8vuh6Dhdi3Sdbx
         x5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nLBDNnI2ytUN/R+LaCECQ51HAzPdQVxI7fwxKBAxkk=;
        b=Qwo3to1Ju1P5MiIBSo7c/dOZei0e9eVOXtEKIeoDmHZo5eZjA1XyYdjkUamt0Vnz1H
         DBbLXoy1dgW5a9pChm5QSzcvTorpMcNW3hFQ1wJ9/00wf2UIAPstSqP1XG3YeyeNC0zB
         WFwHIY4swo6KtKKfjaVlKiOVYHbJvsMzCl687yVQcG0Dd61qY9S4rrjqo7c/i5vI4Z1+
         zZnSHYUUkomGjAh3PHQc2/JG59pSDOfeF/KV3/vbWtdo1uYmldEx38rH+WBDX/PQ3Qbq
         M/7vSRUDoL5spck7cjmLlUZ0j2P0XFCAlY/zDAj9GBNME7zb3rF1sfqiU6jNOczVlT7h
         RjzQ==
X-Gm-Message-State: APjAAAWS4g4wSwRrJ2IL/Vlj+IJbUxhT7xVCBps+TwTI6XNzTPxJnjMr
        fvu1InqsMNeBuXQPveuaenDghJDL
X-Google-Smtp-Source: APXvYqwXFdQwrnCRkItvWKX2IOgKa7qdfY8yNC+MyyKM7doWRl9fMd9AkCIW/wAUphjNVfS7XS2bPw==
X-Received: by 2002:a05:600c:2185:: with SMTP id e5mr6970504wme.78.1571391694848;
        Fri, 18 Oct 2019 02:41:34 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 126sm2186111wma.48.2019.10.18.02.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:41:34 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v3 3/4] RDMA/ocrdma: Remove unsupported modify_port callback
Date:   Fri, 18 Oct 2019 12:41:14 +0300
Message-Id: <20191018094115.13167-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018094115.13167-1-kamalheib1@gmail.com>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMAadapter")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 ------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index c15cfc6cef81..d8c47d24d6d6 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -166,7 +166,6 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.get_port_immutable = ocrdma_port_immutable,
 	.map_mr_sg = ocrdma_map_mr_sg,
 	.mmap = ocrdma_mmap,
-	.modify_port = ocrdma_modify_port,
 	.modify_qp = ocrdma_modify_qp,
 	.poll_cq = ocrdma_poll_cq,
 	.post_recv = ocrdma_post_recv,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index e8267e590772..e72050de5734 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -190,12 +190,6 @@ int ocrdma_query_port(struct ib_device *ibdev,
 	return 0;
 }
 
-int ocrdma_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		       struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int ocrdma_add_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 			   unsigned long len)
 {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 32488da1b752..3a5010881be5 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -54,8 +54,6 @@ int ocrdma_arm_cq(struct ib_cq *, enum ib_cq_notify_flags flags);
 int ocrdma_query_device(struct ib_device *, struct ib_device_attr *props,
 			struct ib_udata *uhw);
 int ocrdma_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int ocrdma_modify_port(struct ib_device *, u8 port, int mask,
-		       struct ib_port_modify *props);
 
 enum rdma_protocol_type
 ocrdma_query_protocol(struct ib_device *device, u8 port_num);
-- 
2.20.1

