Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C871DA554
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 01:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgESXZb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 19:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESXZa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 19:25:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD06B20823;
        Tue, 19 May 2020 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589930730;
        bh=ccZOuYZdXY28saLbk0F9wAgyg3BGaSBjnFIUUWFi3p8=;
        h=Date:From:To:Cc:Subject:From;
        b=WpViHFEp1zeBQoJT+Vue+cgK/g9yG8v6Fc2Je0uUdIEbaEu4Tr3bxZs+t43lq+QDn
         X3H0lsLYoWet2tE0+FkAMA3eJ6RvreN8q5hPxVmFYZdFKXv/TcN4b3m0YXnef92pla
         is2O8WwOY/8IggV0NmGzVdePDHYvlKsgUCsNi09w=
Date:   Tue, 19 May 2020 18:30:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] RDMA/siw: Replace one-element array and use struct_size()
 helper
Message-ID: <20200519233018.GA6105@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current codebase makes use of one-element arrays in the following
form:

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

but the preferred mechanism to declare variable-length types such as
these ones is a flexible array member[1][2], introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on. So, replace
the one-element array with a flexible-array member.

Also, make use of the new struct_size() helper to properly calculate the
size of struct siw_pbl.

This issue was found with the help of Coccinelle and, audited and fixed
_manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/sw/siw/siw.h     | 2 +-
 drivers/infiniband/sw/siw/siw_mem.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index af5e9f8c0fcd0..5a58a1cc7a7e8 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -139,7 +139,7 @@ struct siw_pble {
 struct siw_pbl {
 	unsigned int num_buf;
 	unsigned int max_buf;
-	struct siw_pble pbe[1];
+	struct siw_pble pbe[];
 };
 
 /*
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index e2061dc0b043c..87117781d6374 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -349,14 +349,11 @@ dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx)
 struct siw_pbl *siw_pbl_alloc(u32 num_buf)
 {
 	struct siw_pbl *pbl;
-	int buf_size = sizeof(*pbl);
 
 	if (num_buf == 0)
 		return ERR_PTR(-EINVAL);
 
-	buf_size += ((num_buf - 1) * sizeof(struct siw_pble));
-
-	pbl = kzalloc(buf_size, GFP_KERNEL);
+	pbl = kzalloc(struct_size(pbl, pbe, num_buf), GFP_KERNEL);
 	if (!pbl)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.26.2

