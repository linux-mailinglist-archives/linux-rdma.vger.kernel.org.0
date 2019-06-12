Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01C41DB9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbfFLH3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 03:29:09 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1273 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404659AbfFLH3I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 03:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560324547; x=1591860547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3HBzbqQpB53/PLprpo5NO+weJB6oHALm3yWVRLkmy0=;
  b=KlHeNowyT5BLrntZuD15curr076eT5tT0NdOm+fiy2GZIUi3dIO0of13
   ocxhfGv+16TQSC37E+86n2Zf7iH7jAaNEI7oe7kkFNqBoaLAQlzPxc1je
   D1+1EZrxUIA5TOXYJOPB1lf1r9QiUjcxXU93VQi4MkvIJb6yRq3rh60Eq
   U=;
X-IronPort-AV: E=Sophos;i="5.62,363,1554768000"; 
   d="scan'208";a="679454626"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Jun 2019 07:28:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id D3750A274A;
        Wed, 12 Jun 2019 07:28:55 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 07:28:55 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 07:28:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 07:28:52 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc 2/2] RDMA/efa: Handle mmap insertions overflow
Date:   Wed, 12 Jun 2019 10:28:42 +0300
Message-ID: <20190612072842.99285-3-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612072842.99285-1-galpress@amazon.com>
References: <20190612072842.99285-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When inserting a new mmap entry to the xarray we should check for
'mmap_page' overflow as it is limited to 32 bits.

While at it, make sure to advance the mmap_page stored on the ucontext
only after a successful insertion.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0fea5d63fdbe..c463c683ae84 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
 			     void *obj, u64 address, u64 length, u8 mmap_flag)
 {
 	struct efa_mmap_entry *entry;
+	u32 next_mmap_page;
 	int err;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
@@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
 	entry->mmap_flag = mmap_flag;
 
 	xa_lock(&ucontext->mmap_xa);
+	if (check_add_overflow(ucontext->mmap_xa_page,
+			       (u32)(length >> PAGE_SHIFT),
+			       &next_mmap_page))
+		goto err_unlock;
+
 	entry->mmap_page = ucontext->mmap_xa_page;
-	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
 	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
 			  GFP_KERNEL);
+	if (err)
+		goto err_unlock;
+
+	ucontext->mmap_xa_page = next_mmap_page;
 	xa_unlock(&ucontext->mmap_xa);
-	if (err){
-		kfree(entry);
-		return EFA_MMAP_INVALID;
-	}
 
 	ibdev_dbg(
 		&dev->ibdev,
@@ -232,6 +237,12 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		entry->obj, entry->address, entry->length, get_mmap_key(entry));
 
 	return get_mmap_key(entry);
+
+err_unlock:
+	xa_unlock(&ucontext->mmap_xa);
+	kfree(entry);
+	return EFA_MMAP_INVALID;
+
 }
 
 int efa_query_device(struct ib_device *ibdev,
-- 
2.22.0

