Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A92156FF
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgGFMEj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:04:39 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:24950 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFMEj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 08:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594037079; x=1625573079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/8xbb4VS6eZrl6aqFOUBJp4+0l/22OusksppYvzhQNc=;
  b=OrzJhUfn+ACbQFMKSTlnl5bOunFDdSU5r5qnKpv+aqxFbfNixUtIOPPO
   YoBHbD7nRqsrgIuDY5Sl+ktz7jorrqLE/ojCz77nfbw9Y8bBVlrAPt9K0
   0m13W1nuP9Ma+GcrYXT68r09pjzNRLCAB1R4YUBfgmQBYVuGQCU186A0f
   4=;
IronPort-SDR: smZeyJ9yRiDJ3/arxg8Jojax9i1NtxA8aiUaDbzuVYPNEl6FfCOdy/NRdS46okDNlLEoqruoNj
 ofjjbSqf+upA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="40366590"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Jul 2020 12:04:35 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 5E871A2399;
        Mon,  6 Jul 2020 12:04:33 +0000 (UTC)
Received: from EX13D06UWC001.ant.amazon.com (10.43.162.91) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:24 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D06UWC001.ant.amazon.com (10.43.162.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:24 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.24) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 6 Jul 2020 12:04:17 +0000
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
Subject: [PATCH for-next 1/3] RDMA/core: Check for error instead of success in alloc MR function
Date:   Mon, 6 Jul 2020 15:03:41 +0300
Message-ID: <20200706120343.10816-2-galpress@amazon.com>
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

The common kernel pattern is to check for error, not success.
Flip the if statement accordingly and keep the main flow unindented.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/verbs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 7232e6ec2e91..759de1372c59 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2133,18 +2133,19 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 	}
 
 	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg, udata);
-	if (!IS_ERR(mr)) {
-		mr->device  = pd->device;
-		mr->pd      = pd;
-		mr->dm      = NULL;
-		mr->uobject = NULL;
-		atomic_inc(&pd->usecnt);
-		mr->need_inval = false;
-		mr->res.type = RDMA_RESTRACK_MR;
-		rdma_restrack_kadd(&mr->res);
-		mr->type = mr_type;
-		mr->sig_attrs = NULL;
-	}
+	if (IS_ERR(mr))
+		goto out;
+
+	mr->device  = pd->device;
+	mr->pd      = pd;
+	mr->dm      = NULL;
+	mr->uobject = NULL;
+	atomic_inc(&pd->usecnt);
+	mr->need_inval = false;
+	mr->res.type = RDMA_RESTRACK_MR;
+	rdma_restrack_kadd(&mr->res);
+	mr->type = mr_type;
+	mr->sig_attrs = NULL;
 
 out:
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
-- 
2.27.0

