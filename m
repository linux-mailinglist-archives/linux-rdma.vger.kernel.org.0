Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA5D689A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2019 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfJNRio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Oct 2019 13:38:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50873 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfJNRio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Oct 2019 13:38:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so18158391wmg.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2019 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuCmTl5VzUxy3QDinOpzJbSFYV8O12fP4R6UuCOy2n0=;
        b=XTFbNAnCkaLz71nVRS/N0V3D4Fehve93csLuqwj9Qm0u6EZQ1JWignJp+LI2coq6he
         ZqRINwSjXqopyN7VOjqAbjhc/vwrSggcbQ8CNyW+eW/6sgRYhYohyPhYYXgNIwEKHl79
         n6yqr2O68atGt+PCNT/y7qtSMwiqAfSRHMmNN6V1o/8ZPqVnfIy4QipGfh/xmh7TpPUy
         RrzTOImGQvgFDlE/RSCgU3UXC7irlQGjkOEEDnh+3Unxt4UoU84Poghc/2U6cOIc+i0G
         iWyVT+nL2WqN+6GLHwNVzRm8skHlLJhqowVpUcNftIQQFedL8+kjEyTDF/TD8sSSX1Qj
         vc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuCmTl5VzUxy3QDinOpzJbSFYV8O12fP4R6UuCOy2n0=;
        b=hsAOA5r3evbFK4A+NFn/Zj6A+d1phHJZaSu7vhh2QL+O72Jp86jvA2i6wzaG1WtzNz
         qQNrwYEIcg/VxYGZlWox2lmqyx8kvNtKT2ADC2fo0piofn0+PCIuhv/Oz4Pgbr93pcYq
         zQdY5R4KCoXWM+LgSjWdbp+fn3sAx+XR1LTdkdXg0LoaXrIpWQwJ/6tZBBgcuR0ynr0a
         RUH8k6Pwzzah8WDDykKvyhs42Bq7fDas2P1MIHerkqjqigbeGzYzg6z6ri3bPfyXBg/i
         dcL0i90LWudBbElNYodWOQu4bA9pmto73spLjCKLmPyHYlEvywJ7peMqKzeEzd3bpJOn
         0ccQ==
X-Gm-Message-State: APjAAAW1h6mrLQk0WFHisgMuRpDQP5k7ryJVfz6nhWdu5FITstFZqFa5
        OY/KLEiRbOs01CSOzXEwCI+/BMi3
X-Google-Smtp-Source: APXvYqzG+XOpS5CAQCc0nqj67CaiucsRSeyxD74wJTLFQbS0HjktGJoY5zLNuGDfv7iy72GHRG8hog==
X-Received: by 2002:a1c:e455:: with SMTP id b82mr15736493wmh.41.1571074721940;
        Mon, 14 Oct 2019 10:38:41 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 36sm24981585wrp.30.2019.10.14.10.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:38:40 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 4/4] RDMA/qedr: Remove unsupported modify_port callback
Date:   Mon, 14 Oct 2019 20:38:17 +0300
Message-Id: <20191014173817.10596-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014173817.10596-1-kamalheib1@gmail.com>
References: <20191014173817.10596-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

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

