Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4762DC18F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409690AbfJRJli (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 05:41:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38599 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390553AbfJRJli (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 05:41:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so5416967wmi.3
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TycqH6hRWVQcQ82ZcSfaibr4XzfZ5J5iKsyxzuflrxg=;
        b=oAsxnhlPVGpHefr/4yMqNpIhoKlf2k08+Du8VIFBo4P9CGN3BmM6uYZvfAjS0BSswH
         i5OPotMzrYoYg84hUt5isPlj4T1tQ/LGiLqUUeFQGJEtKoyhNI9lisar5E54hrY8kxUK
         va8kpu5HSXM/JvjPiUrDCRF+M16RBunL/Ocbt/89I6K0QZwD1+Tf30zoCK17Oh/OxABk
         qT0r5yPVhxRIkX5jXeIv6QF3LOVuetjui85P7Mt11kwXTh0kE+0iXhbqaGZuqgefMaHr
         0pYUzUaIQoNZ/qosB1lhENBVm2MmRE181CwwJ2kl82LZdByf2SjWOV5RZuiaCkLtBViW
         JFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TycqH6hRWVQcQ82ZcSfaibr4XzfZ5J5iKsyxzuflrxg=;
        b=e0OtRbhXJopBNRol5c1z1S+p5EQZPd7a2+vzlu6MpzbcgKKI6wPke6r9p4hFcfe61J
         Oj/vzUFGWG2v93Iak2RKXoUpIpu7UiVlH9cKTnThfbvlK8auluFRm3v6xriv0vOTvIJG
         7Sohl097yNiw21B9kVhLa9CW3ltH5q0dpTmuLwQUjn09pfNe1qSgtROk4Lgs1px8Sr+N
         lc8G3a4iWU+9zz9EoMVQWksxzdpsaSCzw9ewxFJ7q/NcwcxstgmivJtqfNcJykfvrcjT
         fdngFfvlQyVyF/Kg1sBa+t/n1HMmGvDBtzHkp+Mr3jduAh/QNhhrl5pgdgVZm00/ur7i
         jk6Q==
X-Gm-Message-State: APjAAAUj1pyp/9uwv3VGllaTvC/F43G/5ssJn2NDRDaGfLCHSy0GYJMr
        tBr8YiR5nkiQbGjM+NI/BJLM8P04
X-Google-Smtp-Source: APXvYqzwH1BHvW+dm7MmuJtQokcRtVatCs1JbxdkIgOuX+C/tfqN/SAasTtw5t/8GiFH0FeUqDucKg==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr6734186wmb.55.1571391696189;
        Fri, 18 Oct 2019 02:41:36 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 126sm2186111wma.48.2019.10.18.02.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:41:35 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v3 4/4] RDMA/qedr: Remove unsupported modify_port callback
Date:   Fri, 18 Oct 2019 12:41:15 +0300
Message-Id: <20191018094115.13167-5-kamalheib1@gmail.com>
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

