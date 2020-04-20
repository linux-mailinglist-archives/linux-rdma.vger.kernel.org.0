Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3563D1B0184
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 08:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDTGWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 02:22:36 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26065 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTGWg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Apr 2020 02:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587363755; x=1618899755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2qmFQPCd5E4cLGOy1XkrogJJ+GBgpYuvpH9ER3modpU=;
  b=nWjzIr6fiVV5mZrgsiMkUvdJ2oo5i0kjKckU8pN2Fq5AJ3/+kSQkLhQA
   RC31nLrMszTcNg7s2m9sqdFCOMMExwnAfVDezhWwtXt5jcR2reE5vSspO
   PIHutJAYJHK9hAaEzgadgIzt7LOIuK66tMUZhfOC2ZhGbNpKUvaORTGsZ
   4=;
IronPort-SDR: VlsFDG69WENvMKC/+WMV7V+89eJDZ0HrVuTSximR9ytW+LNT0mGKRJ/Yu3O7dEzXc0ibNaCB84
 mF5EfoyARplw==
X-IronPort-AV: E=Sophos;i="5.72,405,1580774400"; 
   d="scan'208";a="39425476"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Apr 2020 06:22:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 8BD16A0605;
        Mon, 20 Apr 2020 06:22:32 +0000 (UTC)
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 06:22:31 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 06:22:30 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.20) by
 mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Apr 2020 06:22:28 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 2/3] RDMA/efa: Count mmap failures
Date:   Mon, 20 Apr 2020 09:22:12 +0300
Message-ID: <20200420062213.44577-3-galpress@amazon.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420062213.44577-1-galpress@amazon.com>
References: <20200420062213.44577-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a new stat that counts mmap failures, which might help when
debugging different issues.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h       | 3 ++-
 drivers/infiniband/hw/efa/efa_verbs.c | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index aa7396a1588a..77c9ff798117 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
@@ -40,6 +40,7 @@ struct efa_sw_stats {
 	atomic64_t reg_mr_err;
 	atomic64_t alloc_ucontext_err;
 	atomic64_t create_ah_err;
+	atomic64_t mmap_err;
 };
 
 /* Don't use anything other than atomic64 */
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index b555845d6c14..75eef1ec2474 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -44,7 +44,8 @@ struct efa_user_mmap_entry {
 	op(EFA_CREATE_CQ_ERR, "create_cq_err") \
 	op(EFA_REG_MR_ERR, "reg_mr_err") \
 	op(EFA_ALLOC_UCONTEXT_ERR, "alloc_ucontext_err") \
-	op(EFA_CREATE_AH_ERR, "create_ah_err")
+	op(EFA_CREATE_AH_ERR, "create_ah_err") \
+	op(EFA_MMAP_ERR, "mmap_err")
 
 #define EFA_STATS_ENUM(ename, name) ename,
 #define EFA_STATS_STR(ename, name) [ename] = name,
@@ -1569,6 +1570,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		ibdev_dbg(&dev->ibdev,
 			  "pgoff[%#lx] does not have valid entry\n",
 			  vma->vm_pgoff);
+		atomic64_inc(&dev->stats.sw_stats.mmap_err);
 		return -EINVAL;
 	}
 	entry = to_emmap(rdma_entry);
@@ -1604,12 +1606,14 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		err = -EINVAL;
 	}
 
-	if (err)
+	if (err) {
 		ibdev_dbg(
 			&dev->ibdev,
 			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
 			entry->address, rdma_entry->npages * PAGE_SIZE,
 			entry->mmap_flag, err);
+		atomic64_inc(&dev->stats.sw_stats.mmap_err);
+	}
 
 	rdma_user_mmap_entry_put(rdma_entry);
 	return err;
@@ -1758,6 +1762,7 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	stats->value[EFA_REG_MR_ERR] = atomic64_read(&s->sw_stats.reg_mr_err);
 	stats->value[EFA_ALLOC_UCONTEXT_ERR] = atomic64_read(&s->sw_stats.alloc_ucontext_err);
 	stats->value[EFA_CREATE_AH_ERR] = atomic64_read(&s->sw_stats.create_ah_err);
+	stats->value[EFA_MMAP_ERR] = atomic64_read(&s->sw_stats.mmap_err);
 
 	return ARRAY_SIZE(efa_stats_names);
 }
-- 
2.26.1

