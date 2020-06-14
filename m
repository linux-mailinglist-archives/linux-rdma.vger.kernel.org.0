Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5736D1F886C
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2020 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFNKgK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jun 2020 06:36:10 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:41731 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgFNKgJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jun 2020 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592130969; x=1623666969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cR8VxQ8Db3EG4TNNK7IV7kH3TYpNqN+XjC9hLD45Q5k=;
  b=UfOSrmsQbsDj6/M868SUow2IYe2rq5sWUJ7jA0U1TjRFmocPZt8viYBA
   f8roZmo5p5a3/OPI8/7E8jQeGnfk/Z9Bp2wPyHiQmX0weFznJ9BR5xzf9
   ES78LBtt6X3SnQGP3Regdm8HCWjdRpx+8pqd/gIqrAtu+NlPc1mwzQUs5
   o=;
IronPort-SDR: f04bCYY77T6zARcwI2AaZOC4LlOaydHYlblwvKoR3/wwdRDRgMM2lqSoqjFVcYMRxQ6lIO2Efm
 pf0gsZ9FAFUg==
X-IronPort-AV: E=Sophos;i="5.73,510,1583193600"; 
   d="scan'208";a="43803466"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 14 Jun 2020 10:35:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 0E11CA05EE;
        Sun, 14 Jun 2020 10:35:55 +0000 (UTC)
Received: from EX13D13EUA003.ant.amazon.com (10.43.165.25) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 14 Jun 2020 10:35:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUA003.ant.amazon.com (10.43.165.25) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 14 Jun 2020 10:35:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.11) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 14 Jun 2020 10:35:51 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Set maximum pkeys device attribute
Date:   Sun, 14 Jun 2020 13:35:34 +0300
Message-ID: <20200614103534.88060-1-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The max_pkeys device attribute was not set in query device verb, set it
to one in order to account for the default pkey (0xffff).

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 5c57098a4aee..3420c7742486 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -209,6 +209,7 @@ int efa_query_device(struct ib_device *ibdev,
 	props->max_send_sge = dev_attr->max_sq_sge;
 	props->max_recv_sge = dev_attr->max_rq_sge;
 	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
+	props->max_pkeys = 1;
 
 	if (udata && udata->outlen) {
 		resp.max_sq_sge = dev_attr->max_sq_sge;

base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
-- 
2.27.0

