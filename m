Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C266E8057
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbfJ2G2l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732531AbfJ2G2l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:41 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785EA21479;
        Tue, 29 Oct 2019 06:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330521;
        bh=SIjQfQycpkkaHhKyczJrk7mCqEEgo7hxOqmvozAzXtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqsc//0lbhVOzPhmbF3AQMbkj41P+HfTFyW16RqVUh1KJKD7PfS5SHCvZ583z1hOD
         A+cQMXoJzbaU2/i9RsIduIzrVG9adcGw+v97Cr2ArCstCrOlOvbAp33uy2CH52BVq7
         265lYZN1LruMOPTS+4m6PLVDSalw04Xj1Lv2FYkY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 15/16] RDMA/qib: Delete unused variable in process_cc call
Date:   Tue, 29 Oct 2019 08:27:44 +0200
Message-Id: <20191029062745.7932-16-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Trivial cleanup to the following compilation warning:
drivers/infiniband/hw/qib/qib_mad.c: In function _process_cc_:
drivers/infiniband/hw/qib/qib_mad.c:2296:21: warning: unused variable _ibp_ [-Wunused-variable]
 2296 |  struct qib_ibport *ibp = to_iport(ibdev, port);
      |                     ^~~

Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/qib/qib_mad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index ba8c81e486be..b259aaf85d4a 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2293,7 +2293,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			struct ib_mad *out_mad)
 {
 	struct ib_cc_mad *ccp = (struct ib_cc_mad *)out_mad;
-	struct qib_ibport *ibp = to_iport(ibdev, port);
 	int ret;
 
 	*out_mad = *in_mad;
-- 
2.20.1

