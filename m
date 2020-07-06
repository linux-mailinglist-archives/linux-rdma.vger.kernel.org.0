Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90A215700
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgGFMEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:04:43 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:21584 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFMEn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 08:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594037083; x=1625573083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mukYHkfMJ7V9A3tOn8Tr7ZdAv4uehUvO1+QttgONbsA=;
  b=PoMX14KM0gG4X8K0HJj/vLxbb4x1R2ODYjphdBy1IOajDGsA+giqPqE7
   r41BgCLHSe/YaWmi+JozDey316fBmKxCKjt4cX3cDDrGGV+IHU/gn6vWt
   SBZlZwYcLryMlzeVoiokqpJ1Mwgo0i14nVUu1JGw8i5xgwOhBCg4oeyHa
   Q=;
IronPort-SDR: WbYz3x+TunGmA+c2r5BNwTla61AU0MVf511z2/9Q/itGo3qf/a0MZ4gKhQtbf0ah4+53XeoXfs
 TEnxPl+mY9OA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="40229871"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 06 Jul 2020 12:04:40 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 233E7A1D27;
        Mon,  6 Jul 2020 12:04:38 +0000 (UTC)
Received: from EX13D14UWC004.ant.amazon.com (10.43.162.99) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:32 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D14UWC004.ant.amazon.com (10.43.162.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.24) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 6 Jul 2020 12:04:24 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Adit Ranadive <aditr@vmware.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 2/3] RDMA/core: Remove ib_alloc_mr_user function
Date:   Mon, 6 Jul 2020 15:03:42 +0300
Message-ID: <20200706120343.10816-3-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706120343.10816-1-galpress@amazon.com>
References: <20200706120343.10816-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allocating an MR flow can only be initiated by kernel users, and not
from userspace. As a result, the udata parameter is always being passed
as NULL. Rename ib_alloc_mr_user function to ib_alloc_mr and remove the
udata parameter.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/verbs.c | 11 +++++------
 include/rdma/ib_verbs.h         | 10 ++--------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 759de1372c59..5242155ced47 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2104,11 +2104,10 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 EXPORT_SYMBOL(ib_dereg_mr_user);
 
 /**
- * ib_alloc_mr_user() - Allocates a memory region
+ * ib_alloc_mr() - Allocates a memory region
  * @pd:            protection domain associated with the region
  * @mr_type:       memory region type
  * @max_num_sg:    maximum sg entries available for registration.
- * @udata:	   user data or null for kernel objects
  *
  * Notes:
  * Memory registeration page/sg lists must not exceed max_num_sg.
@@ -2116,8 +2115,8 @@ EXPORT_SYMBOL(ib_dereg_mr_user);
  * max_num_sg * used_page_size.
  *
  */
-struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata)
+struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
+			  u32 max_num_sg)
 {
 	struct ib_mr *mr;
 
@@ -2132,7 +2131,7 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 		goto out;
 	}
 
-	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg, udata);
+	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg, NULL);
 	if (IS_ERR(mr))
 		goto out;
 
@@ -2151,7 +2150,7 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
 	return mr;
 }
-EXPORT_SYMBOL(ib_alloc_mr_user);
+EXPORT_SYMBOL(ib_alloc_mr);
 
 /**
  * ib_alloc_mr_integrity() - Allocates an integrity memory region
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1e902a8f1713..3b53fdc975f6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4268,14 +4268,8 @@ static inline int ib_dereg_mr(struct ib_mr *mr)
 	return ib_dereg_mr_user(mr, NULL);
 }
 
-struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata);
-
-static inline struct ib_mr *ib_alloc_mr(struct ib_pd *pd,
-					enum ib_mr_type mr_type, u32 max_num_sg)
-{
-	return ib_alloc_mr_user(pd, mr_type, max_num_sg, NULL);
-}
+struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
+			  u32 max_num_sg);
 
 struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 				    u32 max_num_data_sg,
-- 
2.27.0

