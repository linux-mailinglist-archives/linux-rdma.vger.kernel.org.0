Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F402E72D2
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfJ1Now (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfJ1Now (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 09:44:52 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE13C214B2;
        Mon, 28 Oct 2019 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572270291;
        bh=CGqs/u/p/caXhOcPnsweYruW9mJguHyU7Kt89sicNbc=;
        h=From:To:Cc:Subject:Date:From;
        b=nAoxdA2xWztF0bN1E45JV3kzU18Z/6DOpQFBTWq3y+PfyoeooFB+obR6Q9gD7BTSY
         3eTMOKgVvL1+dBpTyjyRNgSKo157JcG/HVvzB2GTNLMvp+zcx673X0EBRZrcaF7VNA
         0YdLjmGZJFi8rRsZS/ksZaOePPDz+qNt0M6TSVTM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than declared in IBTA
Date:   Mon, 28 Oct 2019 15:44:44 +0200
Message-Id: <20191028134444.25537-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

IBTA declares QPN as 24bits, mask input to ensure that kernel
doesn't get higher bits.

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 * Not fully tested yet, passed sanity tests for now.
---
 drivers/infiniband/core/ucma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 0274e9b704be..57e68491a2fd 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
 	dst->retry_count = src->retry_count;
 	dst->rnr_retry_count = src->rnr_retry_count;
 	dst->srq = src->srq;
-	dst->qp_num = src->qp_num;
+	dst->qp_num = src->qp_num & 0xFFFFFF;
 	dst->qkey = (id->route.addr.src_addr.ss_family == AF_IB) ? src->qkey : 0;
 }

--
2.20.1

