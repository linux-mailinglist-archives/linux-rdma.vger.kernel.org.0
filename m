Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44F4A1B0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfFRNHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:07:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:20157 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRNHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560863273; x=1592399273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tzViaEeDu91i5Xqgr1u81R1ilHwq3pz0JjrJIIsMnA8=;
  b=ixSggYluFJiDe3/BTj7uHLuN8DNDCV3Pc5CwpdR0MYfedLDQ5/n/br8l
   Re5a6lwWXkky4DVcUfypWqk9Jsvp/1Igxu/BUkaUad62GyPpKgDNDdGba
   wjpZ+gQoHNK2wX3onjDM8yB/Bz2HvDkSDk4jiIE+GctuUBDqEuI+4aO3G
   0=;
X-IronPort-AV: E=Sophos;i="5.62,389,1554768000"; 
   d="scan'208";a="401204472"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Jun 2019 13:07:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 56493A19F3;
        Tue, 18 Jun 2019 13:07:51 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Jun 2019 13:07:50 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Jun 2019 13:07:49 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 18 Jun 2019 13:07:46 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc v2] RDMA/efa: Handle mmap insertions overflow
Date:   Tue, 18 Jun 2019 16:07:32 +0300
Message-ID: <20190618130732.20895-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When inserting a new mmap entry to the xarray we should check for
'mmap_page' overflow as it is limited to 32 bits.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
Changelog:
v1->v2
* Bring back the ucontext->mmap_xa_page assignment before __xa_insert
---
 drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0fea5d63fdbe..fb6115244d4c 100644
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
+	ucontext->mmap_xa_page = next_mmap_page;
 	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
 			  GFP_KERNEL);
+	if (err)
+		goto err_unlock;
+
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

