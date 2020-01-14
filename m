Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BB13A356
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgANI5i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:38 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21800 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANI5h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992257; x=1610528257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+2EtPHFChTSVRnONr9ltb8bldATgz35fPILfjutqIY=;
  b=psWwJZn1QF0V7l71Ntco0hOkL7uvE6Q5lo2eGCuqRXN0uUtWGX5K2SlR
   477iXyzWvNHN4z9W43onLRyp9C7dtIXM//uAUfYlvUnXxWX+hwNWDYvSo
   ErAmyestWYzPDQ9EVDdffMik2nOW1UdsNtBbQ2UFGLari+opythfuPMdv
   g=;
IronPort-SDR: onx6C8ZSSReraTjnKDfzgmoEDEFA9q/SOZBanXrywrpva6mO0dmKeR5bj1C8k7uV3qCTQgh6Jy
 OxB0V/IqoL8Q==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="18572469"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 Jan 2020 08:57:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 1162D1417E1;
        Tue, 14 Jan 2020 08:57:30 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:30 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:29 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:26 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 5/6] RDMA/efa: Remove unused ucontext parameter from efa_qp_user_mmap_entries_remove
Date:   Tue, 14 Jan 2020 10:57:05 +0200
Message-ID: <20200114085706.82229-6-galpress@amazon.com>
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

The ucontext parameter is unused, remove it.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ce89c0b9c315..9a6cff718c49 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -387,8 +387,7 @@ static int efa_destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
 	return efa_com_destroy_qp(&dev->edev, &params);
 }
 
-static void efa_qp_user_mmap_entries_remove(struct efa_ucontext *uctx,
-					    struct efa_qp *qp)
+static void efa_qp_user_mmap_entries_remove(struct efa_qp *qp)
 {
 	rdma_user_mmap_entry_remove(qp->rq_mmap_entry);
 	rdma_user_mmap_entry_remove(qp->rq_db_mmap_entry);
@@ -398,8 +397,6 @@ static void efa_qp_user_mmap_entries_remove(struct efa_ucontext *uctx,
 
 int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
-	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
-		struct efa_ucontext, ibucontext);
 	struct efa_dev *dev = to_edev(ibqp->pd->device);
 	struct efa_qp *qp = to_eqp(ibqp);
 	int err;
@@ -418,7 +415,7 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 				 DMA_TO_DEVICE);
 	}
 
-	efa_qp_user_mmap_entries_remove(ucontext, qp);
+	efa_qp_user_mmap_entries_remove(qp);
 	kfree(qp);
 	return 0;
 }
@@ -510,7 +507,7 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	return 0;
 
 err_remove_mmap:
-	efa_qp_user_mmap_entries_remove(ucontext, qp);
+	efa_qp_user_mmap_entries_remove(qp);
 
 	return -ENOMEM;
 }
@@ -719,7 +716,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 	return &qp->ibqp;
 
 err_remove_mmap_entries:
-	efa_qp_user_mmap_entries_remove(ucontext, qp);
+	efa_qp_user_mmap_entries_remove(qp);
 err_destroy_qp:
 	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
 err_free_mapped:
-- 
2.24.1

