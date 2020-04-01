Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10B19B8A6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 00:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgDAWt2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Apr 2020 18:49:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388966AbgDAWt2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Apr 2020 18:49:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jJmAj-0004nz-QG; Wed, 01 Apr 2020 22:49:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, sindhu.devale@intel.com,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] i40iw: fix null pointer dereference on a null wqe pointer
Date:   Wed,  1 Apr 2020 23:49:21 +0100
Message-Id: <20200401224921.405279-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the null check for wqe is incorrect and lets a null wqe
be passed to set_64bit_val and this indexes into the null pointer
causing a null pointer dereference.  Fix this by fixing the null
pointer check to return an error if wqe is null.

Addresses-Coverity: ("dereference after a null check")
Fixes: 4b34e23f4eaa ("i40iw: Report correct firmware version")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index e8b4b3743661..688f19667221 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -1046,7 +1046,7 @@ i40iw_sc_query_rdma_features(struct i40iw_sc_cqp *cqp,
 	u64 header;
 
 	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
-	if (wqe)
+	if (!wqe)
 		return I40IW_ERR_RING_FULL;
 
 	set_64bit_val(wqe, 32, feat_mem->pa);
-- 
2.25.1

