Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE38178C58
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 09:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgCDIKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 03:10:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgCDIKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 03:10:50 -0500
Received: from [217.110.231.98] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j9P77-00008i-MD; Wed, 04 Mar 2020 08:10:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/hns: fix spelling mistake "attatch" -> "attach"
Date:   Wed,  4 Mar 2020 09:10:45 +0100
Message-Id: <20200304081045.81164-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 2a7535534ea8..bddae625f447 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -812,7 +812,7 @@ static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list, hr_qp->regions,
 				  region_count);
 	if (ret)
-		ibdev_err(ibdev, "Failed to attatch WQE's mtr\n");
+		ibdev_err(ibdev, "Failed to attach WQE's mtr\n");
 
 	goto done;
 
-- 
2.25.0

