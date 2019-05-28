Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C412C6EC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfE1Mqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:46:55 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:61544 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1Mqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047614; x=1590583614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zjMlzFlv/3VI6Mc2RTvWrZqPvR16n2SUpRZxYWIPkCI=;
  b=r9CUomj3MIJ12khuP+ZaHR1k8MS6fVEo85fYx0DyDXhzTut8VU5NgdRz
   o+HM3DaLQZ374i66nZ+Z+f+RcqJmVwNlt0dK8Ix8rpU5sEGeFY8e8a+rs
   ZftN8GvRTUTJDAObL4RbDpcGg598yk+btQUZZdbnjese8KnTVGVpdzAKD
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="398337588"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:46:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SCkjSJ076386
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:46:50 GMT
Received: from EX13D19EUB004.ant.amazon.com (10.43.166.61) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:50 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB004.ant.amazon.com (10.43.166.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:48 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:46:45 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc 1/6] RDMA/efa: Remove MAYEXEC flag check from mmap flow
Date:   Tue, 28 May 2019 15:46:13 +0300
Message-ID: <20190528124618.77918-2-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528124618.77918-1-galpress@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

MAYEXEC test was mistakenly added, remove it.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 6d6886c9009f..0fea5d63fdbe 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1728,7 +1728,6 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
 		return -EPERM;
 	}
-	vma->vm_flags &= ~VM_MAYEXEC;
 
 	return __efa_mmap(dev, ucontext, vma, key, length);
 }
-- 
2.21.0

