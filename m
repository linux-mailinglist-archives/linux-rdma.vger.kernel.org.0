Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00594D8955
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 09:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJPHXA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 03:23:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33875 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJPHXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Oct 2019 03:23:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so3982465wmc.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2019 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nLBDNnI2ytUN/R+LaCECQ51HAzPdQVxI7fwxKBAxkk=;
        b=fh1m6/aK7UZaTL2ZvmcUBF4qsHh9/mZ4IrZ+3XQE5l7dDECw+lF6HlH+UFcXuYBBv3
         76Uty9LDcCTsTbIqdZqt7UIuz5GXSDpa3+hx1z4o0KwpiZjnmpQFeTWfzsjUXSOomXzj
         2w/fvbkyWZq6kCXrXWLROr+EsbNp4q5YznKTFqSHXZd+724mQVr9FEKsUl/jM3HgqAmC
         /EsrQKnC8lw1leu0a2nQ4FBL7jtY8r5PFE4aLiR9iA4u19O+zMDeHkXJdjwZBX79mtdz
         PXXdoYuF3DHPdQCvcFDfPDA83BbZCUDPQqlA6aXSh5tvsqZMDlUudBMqAt5O9l/ZtDoD
         HQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nLBDNnI2ytUN/R+LaCECQ51HAzPdQVxI7fwxKBAxkk=;
        b=gIIsVr8Qp1qBx89Ukes57wrfEvrW6CM/xe2uAHl2dcy1QgIKtQJwsacOz9QIsnpkej
         WkXQmUqhpcntjnEPdzwQywJ7lTCbIpqu41s4wxUMtZMbA/zf+VsG/r0qDP4xckn5Yh80
         htdLNNEtSYNnJAnPRQSYHTylU4PL2omNtsmWgtx7JQKiU9B98yBXF1a/WdSBcx7XrmXw
         ksC4ZrYQmOjvpuECUT7HwJD0AD/CFa8DUXFLJJvhg7atEeljoVqsS0eCKEUHd1zlz7ci
         l4QXDEZSH4YHT07oAvjC0iCerR66+cE0bFPMpW4b9Xb61m2g1pH3/iaJImJVXMKniJyK
         6d2A==
X-Gm-Message-State: APjAAAUrOuSgHwlNehH+gIW8c/kcLVfbW+UdCeuIN+Dyx5GdNPNcf0jT
        aqifOrpqoboSjDcpYbWiCR3w6B4X
X-Google-Smtp-Source: APXvYqwnlBr5BolU+0Nx+3cqBKBKkJbXYnNMkEuqhy77+xUnhqNKa0maTaBja/LgAt0yvtcFLoYeEA==
X-Received: by 2002:a1c:9d4c:: with SMTP id g73mr2205259wme.92.1571210578801;
        Wed, 16 Oct 2019 00:22:58 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id r140sm1687046wme.47.2019.10.16.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:22:58 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2 3/4] RDMA/ocrdma: Remove unsupported modify_port callback
Date:   Wed, 16 Oct 2019 10:22:33 +0300
Message-Id: <20191016072234.28442-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016072234.28442-1-kamalheib1@gmail.com>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
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

