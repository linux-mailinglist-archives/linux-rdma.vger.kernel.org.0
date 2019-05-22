Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45925F04
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfEVIHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 04:07:08 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:62220 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEVIHI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 04:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558512427; x=1590048427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sc/T7Nv/sBPAujJoHpH6MzyH+yKNFBvhEnYrgxxkJe0=;
  b=eRdzBXKyF5wUx4DKTd5sEbigqboy22x4brV5Hbe4KJ894Bv1Jc+xTsH/
   ZhhFlaoYcMMvwt1dZ9X5eLo7dSmDOz7M7lvGDmAszpt7eXkjHwhegQ+AB
   A+/HM+zSlnNSsnPU6wPB6X8sdgDoAYOX+v4dnXGOW18a0DzHr/9UgHGav
   4=;
X-IronPort-AV: E=Sophos;i="5.60,498,1549929600"; 
   d="scan'208";a="767141595"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 May 2019 08:07:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4M873TC029279
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 22 May 2019 08:07:05 GMT
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 May 2019 08:07:04 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D13EUB001.ant.amazon.com (10.43.166.101) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 May 2019 08:07:03 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.140) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 22 May 2019 08:07:01 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-rc] RDMA/uverbs: Pass udata on uverbs error unwind
Date:   Wed, 22 May 2019 11:06:43 +0300
Message-ID: <20190522080643.52654-1-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When destroy_* is called as a result of uverbs create cleanup flow a
cleared udata should be passed instead of NULL to indicate that it is
called under user flow.

Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
Fixes: 42849b2697c3 ("RDMA/uverbs: Export ib_open_qp() capability to user space")
Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 9 +++++----
 drivers/infiniband/core/uverbs_std_types_cq.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a9b32ebb9beb..63fe14c7c68f 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1053,7 +1053,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	return obj;
 
 err_cb:
-	ib_destroy_cq(cq);
+	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
 
 err_file:
 	if (ev_file)
@@ -1489,7 +1489,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 err_cb:
-	ib_destroy_qp(qp);
+	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
 
 err_put:
 	if (!IS_ERR(xrcd_uobj))
@@ -1622,7 +1622,7 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 
 err_destroy:
-	ib_destroy_qp(qp);
+	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
 err_xrcd:
 	uobj_put_read(xrcd_uobj);
 err_put:
@@ -2464,7 +2464,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	return uobj_alloc_commit(uobj, attrs);
 
 err_copy:
-	rdma_destroy_ah(ah, RDMA_DESTROY_AH_SLEEPABLE);
+	rdma_destroy_ah_user(ah, RDMA_DESTROY_AH_SLEEPABLE,
+			     uverbs_get_cleared_udata(attrs));
 
 err_put:
 	uobj_put_obj_read(pd);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index db5c46a1bb2d..07ea4e3c4566 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -135,7 +135,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 
 	return 0;
 err_cq:
-	ib_destroy_cq(cq);
+	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
 
 err_event_file:
 	if (ev_file)
-- 
2.21.0

