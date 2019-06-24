Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45951D49
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfFXVqS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:46:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfFXVqQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:46:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hfWmv-00068c-40; Mon, 24 Jun 2019 21:46:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/hns: fix potential integer overflow on left shift
Date:   Mon, 24 Jun 2019 22:46:08 +0100
Message-Id: <20190624214608.11765-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a potential integer overflow when int i is left shifted
as this is evaluated using 32 bit arithmetic but is being used in
a context that expects an expression of type dma_addr_t.  Fix this
by casting integer i to dma_addr_t before shifting to avoid the
overflow.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 2ac0bc5e725e ("RDMA/hns: Add a group interfaces for optimizing buffers getting flow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 14fcc359599c..2c8defa94107 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -257,7 +257,7 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	for (i = start; i < end; i++)
 		if (buf->nbufs == 1)
 			bufs[total++] = buf->direct.map +
-					(i << buf->page_shift);
+					((dma_addr_t)i << buf->page_shift);
 		else
 			bufs[total++] = buf->page_list[i].map;
 
-- 
2.20.1

