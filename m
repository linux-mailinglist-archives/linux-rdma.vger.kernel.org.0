Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72D13A357
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANI5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:40 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:8202 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANI5k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992261; x=1610528261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHWSWdy6lxK8fJQ/BaOVQZ0/4S9gN2Q1AO23vqAHrRc=;
  b=h0MD8dv1+anD9p4IebdGUwYu3rzBeZ0QJQECOg9aPZi7tUO1MZCXFxWD
   /7ioaUgIyyzK0MB/AaC+/5e45CfUcCNA2rmP/L4HtOZC9ULCWTfIn68IH
   FsrODL7yGGdmry27otL0oSBEvqs58W6S9bk+Z7iZaheb1ZiPONWsdYYrE
   E=;
IronPort-SDR: QGpAxPEDge9GQf/a/JEKKOYgp5rpzMUFVqeCd22vTFB3WqYpIn3YnSwS3YRkYJKbJc3cYswAxM
 tioPES429kGQ==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="19943008"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 14 Jan 2020 08:57:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 38DBEA1EAF;
        Tue, 14 Jan 2020 08:57:27 +0000 (UTC)
Received: from EX13D22EUA002.ant.amazon.com (10.43.165.125) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:27 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D22EUA002.ant.amazon.com (10.43.165.125) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:26 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:23 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-next 4/6] RDMA/efa: Remove {} brackets from single statement if
Date:   Tue, 14 Jan 2020 10:57:04 +0200
Message-ID: <20200114085706.82229-5-galpress@amazon.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114085706.82229-1-galpress@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The {} brackets are not needed according to the Linux coding style.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 50c22575aed6..ce89c0b9c315 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1608,13 +1608,12 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		err = -EINVAL;
 	}
 
-	if (err) {
+	if (err)
 		ibdev_dbg(
 			&dev->ibdev,
 			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
 			entry->address, rdma_entry->npages * PAGE_SIZE,
 			entry->mmap_flag, err);
-	}
 
 	rdma_user_mmap_entry_put(rdma_entry);
 	return err;
-- 
2.24.1

