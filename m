Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4A2C9C79
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgLAJS0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 04:18:26 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57437 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390534AbgLAJSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 04:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606814303; x=1638350303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ml4G4M2LEhtVJo/pXUQI7dB7bgPOcLvYuxeIOe4NG3o=;
  b=YFZa785dq8QRclIGCz1Q/Z10anP6wDZLhof/5OFZM/okHeQDHIxYwtlq
   m6uw9HWKoyUjQZr9Wg+nCBlLbEBncQpEsWf0enBJFD6fKgP0pk1EDFWk1
   0/VuLCFbcYLgdy9MuF7PT2Nkq39BHidcXd7w6dMiZ4De6OLyao1ihHCQN
   0=;
X-IronPort-AV: E=Sophos;i="5.78,384,1599523200"; 
   d="scan'208";a="100704108"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-16425a8d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Dec 2020 09:17:35 +0000
Received: from EX13D19EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-16425a8d.us-east-1.amazon.com (Postfix) with ESMTPS id 47F44100F52;
        Tue,  1 Dec 2020 09:17:33 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 09:17:32 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.17) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 09:17:30 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Use the correct current and new states in modify QP
Date:   Tue, 1 Dec 2020 11:17:24 +0200
Message-ID: <20201201091724.37016-1-galpress@amazon.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The local variables cur_state and new_state hold the state that should
be used for the modify QP operation instead of the ones in the
ib_qp_attr struct.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 191e0843f090..4e940fc50bba 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -940,8 +940,8 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 			1);
 		EFA_SET(&params.modify_mask,
 			EFA_ADMIN_MODIFY_QP_CMD_CUR_QP_STATE, 1);
-		params.cur_qp_state = qp_attr->cur_qp_state;
-		params.qp_state = qp_attr->qp_state;
+		params.cur_qp_state = cur_state;
+		params.qp_state = new_state;
 	}
 
 	if (qp_attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY) {

base-commit: 17475e104dcb74217c282781817f8f52b46130d3
-- 
2.29.2

