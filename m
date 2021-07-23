Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221573D39A1
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhGWK7b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 06:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhGWK7a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 06:59:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2576F608FE;
        Fri, 23 Jul 2021 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627040404;
        bh=GJuYpZMRTHfFLNa7JNXRDusueVpqq8y27R1sbmIH9FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFkR/IEBtHv3gXJDthIGGAK9NbgCHu57fq/9glayPEKWjT3HDXbjlC0N5YdAhuZGW
         h/z6TnLUoK56DBtgg3p0KZ/l185HRlLy3e3cu2XclnfNw7OSrrFyEgTDYyvebBQCq9
         h9C1Yqyz129Dxr7RfStuXfuFFIqnbo1yBkAyGsXLt9GO31OmPWHWSItnnFZEWCPhM4
         bxEtqJwb2bJIQL/lKzthHz9QkSLnhS2+cM+tyJe9a+aMWpQkJzBt/cADLUzdiVDdqD
         iYBLVU8DlotiJGumxktTKU2fPGSV8JIE+0z+2gYAhFstgii+U78mN/Z/KBFF+Ee7E5
         V7qIC0XAgDt4A==
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
Subject: [PATCH rdma-next v1 2/9] RDMA/hns: Don't overwrite supplied QP attributes
Date:   Fri, 23 Jul 2021 14:39:44 +0300
Message-Id: <5987138875e8ade9aa339d4db6e1bd9694ed4591.1627040189.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627040189.git.leonro@nvidia.com>
References: <cover.1627040189.git.leonro@nvidia.com>
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

