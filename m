Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9A22EF90
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgG0ORV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 10:17:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43625 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbgG0ORS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 10:17:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k03wG-0002jX-Uz; Mon, 27 Jul 2020 14:17:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Igor Russkikh <irusskikh@marvell.com>,
        Alexander Lobakin <alobakin@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix assignment of n_rq_elems to incorrect params field
Date:   Mon, 27 Jul 2020 15:17:12 +0100
Message-Id: <20200727141712.112906-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently n_rq_elems is being assigned to params.elem_size instead of the
field params.num_elems.  Coverity is detecting this as a double assingment
to params.elem_size and reporting this as an usused value on the first
assignment.  Fix this.

Addresses-Coverity: ("Unused value")
Fixes: b6db3f71c976 ("qed: simplify chain allocation with init params struct")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 5a80471577a6..4ce4e2eef6cc 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1930,7 +1930,7 @@ qedr_roce_create_kernel_qp(struct qedr_dev *dev,
 	in_params->sq_pbl_ptr = qed_chain_get_pbl_phys(&qp->sq.pbl);
 
 	params.intended_use = QED_CHAIN_USE_TO_CONSUME_PRODUCE;
-	params.elem_size = n_rq_elems;
+	params.num_elems = n_rq_elems;
 	params.elem_size = QEDR_RQE_ELEMENT_SIZE;
 
 	rc = dev->ops->common->chain_alloc(dev->cdev, &qp->rq.pbl, &params);
-- 
2.27.0

