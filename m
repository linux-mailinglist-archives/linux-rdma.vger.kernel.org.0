Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E207ED8954
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJPHW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 03:22:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfJPHW7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Oct 2019 03:22:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so10828724wrm.8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2019 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAZ2TrIIVcLEbxIdOVbHEBWi4WBUQuacFKnyYRaMGgU=;
        b=LRoYd8su0OKNWCuZu6EaDj4g4SiQTR78JrYL27rstQSGprPXEud8FvUfzDOYKe/SZE
         ngM5MKfh1bG87Xco/aEpCvZwt0tOP7XjwJOvT5ftbCZs69X7nnOdpwQf0wSzNR46KleC
         dXjLny9qNZyHnkEz3JwMkN5c7oye2I5DdSQrcXvbtEtdIHtKMir+lnnJbR92prI+lUbg
         AeH7J3ircMzb1BfI1j6e9hfAFwHUqJRhqMvQkEkrcMrWOac/c5C9KpN758VmcmqNdHYc
         PcVZA/PWbc/98Zo/01M+qlvDR35DJJvdQd/NTH3sQGdj3gjUvscxWKGjhH+aEhF5T0CO
         Z1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAZ2TrIIVcLEbxIdOVbHEBWi4WBUQuacFKnyYRaMGgU=;
        b=FH06u6A8CHIyHVeMq7mWnTLmLUkr/ochCqyiXPJzNdccWb37p4PZaJ7zyCGpXYyXeG
         0J+VdkxOl5eHl1rNyT+Ggot5SvohbYw2H2zgA915CSIiCn1XG/JaXWohQE5kWdKL8IWw
         AQkqN6NXTrYCQcmApSyttllwOZ0Hj3oqP575e7zM3uUBGLG04vHqYuy38wiULDGrbTXf
         rPqcVVlM7PnDfFRuwbxqwHZD4slfSdnmTRFZjHy1WMJad3yMcpAhhE2jGg//egO8HsYw
         mVyiFpEHAKGCSxGHHK2jZT5Plsvray1+YHq/HZCkCET05Zmj5WtWXos04PZ656xRu2Gq
         1tQw==
X-Gm-Message-State: APjAAAWqcWc6rJQjiNcygPpU+Cp9Kl7Z4NHheAsOwUgKwGPlQVIbxOlp
        Z9Owb2wN2Vf7ZM3AiGdKC7OkpK79
X-Google-Smtp-Source: APXvYqwO9BDndMKz/JOZFExJfmsq2QfA/1e2z0LAloxtyknKHxPwyGG2FgjDoTxYrQ8mjfSJxzjKBw==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr1374990wrx.105.1571210577430;
        Wed, 16 Oct 2019 00:22:57 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id r140sm1687046wme.47.2019.10.16.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:22:57 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2 2/4] RDMA/hns: Remove unsupported modify_port callback
Date:   Wed, 16 Oct 2019 10:22:32 +0300
Message-Id: <20191016072234.28442-3-kamalheib1@gmail.com>
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

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c119ee..b241f74a7e3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -301,12 +301,6 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
-static int hns_roce_modify_port(struct ib_device *ib_dev, u8 port_num, int mask,
-				struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
@@ -438,7 +432,6 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.get_port_immutable = hns_roce_port_immutable,
 	.mmap = hns_roce_mmap,
 	.modify_device = hns_roce_modify_device,
-	.modify_port = hns_roce_modify_port,
 	.modify_qp = hns_roce_modify_qp,
 	.query_ah = hns_roce_query_ah,
 	.query_device = hns_roce_query_device,
-- 
2.20.1

