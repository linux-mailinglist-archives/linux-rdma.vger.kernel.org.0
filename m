Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2120D3CC8EF
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhGRMEJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233207AbhGRMEJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B30661040;
        Sun, 18 Jul 2021 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609671;
        bh=GJuYpZMRTHfFLNa7JNXRDusueVpqq8y27R1sbmIH9FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ5pskIiwy0XBmI3ZM4T3/ZaEDaoRPcfq4decPldtSAUqxIcEIClJrI+NpEF9qosj
         1jVcZmbcBH+YUJVxuBP4n3Ms8X7wqI8zXwg2QT6pIB1pfXmAwMR43rd9Et4f2bjP2L
         segjRptxmvUCYhcw9gwEnp83w0zOl1aM5UtCbbSpjqyI1+4AhiUeu2SSiIFigvNhbz
         CoI1anJRd1gcZSSQMi1ECnkBSjE4wgeURdIjDzm/OPEy05m/A8JdRWxjW6KJ19ImkI
         xY1ve2BaRKnkb5NWMjc6JbcA9Ia34i66v+G9Ayr3Srco4AJPhsKWy6wFms8q7kR6YL
         PAS0pGyGavtDQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 2/9] RDMA/hns: Don't overwrite supplied QP attributes
Date:   Sun, 18 Jul 2021 15:00:52 +0300
Message-Id: <c508c5d599d691c4757be25a6a9a577e19b53e6c.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626609283.git.leonro@nvidia.com>
References: <cover.1626609283.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

QP attributes that were supplied by IB/core already have all parameters
set when they are passed to the driver. The drivers are not supposed to
change anything in struct ib_qp_init_attr.

Fixes: 66d86e529dd5 ("RDMA/hns: Add UD support for HIP09")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index b101b7e578f2..c3e2fee16c0e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1171,14 +1171,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	if (!hr_qp)
 		return ERR_PTR(-ENOMEM);
 
-	if (init_attr->qp_type == IB_QPT_XRC_INI)
-		init_attr->recv_cq = NULL;
-
-	if (init_attr->qp_type == IB_QPT_XRC_TGT) {
+	if (init_attr->qp_type == IB_QPT_XRC_TGT)
 		hr_qp->xrcdn = to_hr_xrcd(init_attr->xrcd)->xrcdn;
-		init_attr->recv_cq = NULL;
-		init_attr->send_cq = NULL;
-	}
 
 	if (init_attr->qp_type == IB_QPT_GSI) {
 		hr_qp->port = init_attr->port_num - 1;
-- 
2.31.1

