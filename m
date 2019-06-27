Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1192D588A9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfF0Rhr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:37:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfF0Rhr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 13:37:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so1564542pfq.12;
        Thu, 27 Jun 2019 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uTZc6f0h9EMyQCFtj3vnQUeGctU2DdoLfjBSU8zYAdw=;
        b=gcg6aEdIlo7oQ4OQ/6BtGSmv778c6oLCYpKkU/01UgTx0yZyFKHscAjqmDT9bdjbXA
         j8gtKhAdI5L1WAsRDDmYReZ2T7kbW2auHGDpZWKhfjfGMAJxEdFPTZZ/JqF5yojHkAfE
         P5nVu+68+n5ohsbWNEoyZRIigKsQVXl2NDtcF8MCJNQbZP9XsaZjv7ZHZ70ExePKikzu
         ebvCIJtiYGTB+P6MahjTrLOQyayjvwlBlQ/oPXwEa9ta9j9cHDfq2DaoTzOXf5AQxzdU
         h89np8oL/zHEaEFJ6KQiFiWhpdEcSRYljUQYRiuHXGmTDXgPhp9nvHFqa3j6L7y0iMB9
         xrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uTZc6f0h9EMyQCFtj3vnQUeGctU2DdoLfjBSU8zYAdw=;
        b=cIDbeA5LQn4vgAJx2uZNgKtixWN9uGo/4JzkuNK6UCxkU4rbbWDrZ9nSvdDKYUYTOk
         U6Pc50eajxLzp2tw4nNTnCeC4izTy1MOfLmGFqWw7j2kULRgOMwjLwRSv0lfIzyQHhb/
         8ZDynVRykKQba0qkSL8mWukLVZ1bmgMncSveyTR0W5Xh/g45V/znqOsRa3k5NRsqINSX
         T5GvJifTBMPkfEShMwkeERoervU1xNNO3sgBeHgvYPPKby5dBV1KPZVLwuATuMaL77wD
         7Y3L6/1+T5QkKz+MgbYTmzncXxgxOvOjPthJNRF0goyQUT63R5Nm6qQJ1YU6CTBmf32P
         0RBQ==
X-Gm-Message-State: APjAAAWdLBrlW8vxftfl7WHvSSFRmeITDPem2svcoJaAwjibqGTbsE3n
        XzsyXtsGDOK7fekh230ZnlY=
X-Google-Smtp-Source: APXvYqz+wiXOpTPddZ7i3gVLpx/PXbq0IbKQ7LG3FDpu8+AsVfcBBGMRaZyh8RPH3qdUrVfNSv5lmQ==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr5090549pgj.61.1561657066571;
        Thu, 27 Jun 2019 10:37:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 14sm2564554pgp.37.2019.06.27.10.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:46 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/87] infiniband: mthca: remove memset after dma_alloc_coherent in mthca_allocator.c
Date:   Fri, 28 Jun 2019 01:37:40 +0800
Message-Id: <20190627173741.3147-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/mthca/mthca_allocator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aaf10dd5364d..aef1d274a14e 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -214,8 +214,6 @@ int mthca_buf_alloc(struct mthca_dev *dev, int size, int max_direct,
 
 		dma_unmap_addr_set(&buf->direct, mapping, t);
 
-		memset(buf->direct.buf, 0, size);
-
 		while (t & ((1 << shift) - 1)) {
 			--shift;
 			npages *= 2;
-- 
2.11.0

