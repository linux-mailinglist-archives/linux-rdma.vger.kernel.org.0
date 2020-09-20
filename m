Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1A27143B
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Sep 2020 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgITMQ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Sep 2020 08:16:26 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33993 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbgITMQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Sep 2020 08:16:24 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612191"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Gal Pressman <galpress@amazon.com>
Cc:     kernel-janitors@vger.kernel.org,
        Yossi Leybovich <sleybo@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] RDMA/efa: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:17 +0200
Message-Id: <1600601186-7420-6-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

sg_init_table zeroes its first argument, so the allocation of that argument
doesn't have to.

the semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,n,flags;
@@

x = 
- kcalloc
+ kmalloc_array
  (n,sizeof(*x),flags)
...
sg_init_table(x,n)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/infiniband/hw/efa/efa_verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1157,7 +1157,7 @@ static struct scatterlist *efa_vmalloc_b
 	struct page *pg;
 	int i;
 
-	sglist = kcalloc(page_cnt, sizeof(*sglist), GFP_KERNEL);
+	sglist = kmalloc_array(page_cnt, sizeof(*sglist), GFP_KERNEL);
 	if (!sglist)
 		return NULL;
 	sg_init_table(sglist, page_cnt);

