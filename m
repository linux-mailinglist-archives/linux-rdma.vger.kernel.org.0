Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501103D39A4
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhGWK7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 06:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhGWK7h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 06:59:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A992608FE;
        Fri, 23 Jul 2021 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627040411;
        bh=gVSQ/YeQ1MMaDZCW2lOow3B0ynjImk/fL65vA11Rx9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvpeEC0OG13mIs8tRxvqKtynXrnDqxlDeCZTKOLBrF4yu4dYKP+eNpXvXZ/o7OahN
         7FNUj5/VE+gpMChl0QYYd3vh60PFpGnC5MsQlvLRAh8OKiK2RIezi/ESVmYW/sU1V9
         qLc8Xo98IPdLanHSTG8Q2d6LEHBdbvyE0ZL7nQ0Sh+8CQCfVL1z2+1aK1olEMR7BF/
         Yerj6n/XL13kHtophY46VN1Ml0y8VzDRvAfjKqZLTBdPFzjjssjN0nzfLCE6ZCJyp9
         DGdYQLE1CTO7u97oHZh7JPVxgaZWwbnPAo5TAVK9p6a9t/Y05LuqzntmPx7y1pgJzl
         CaYyjh/Byg/Cg==
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
Subject: [PATCH rdma-next v1 3/9] RDMA/efa: Remove double QP type assignment
Date:   Fri, 23 Jul 2021 14:39:45 +0300
Message-Id: <838c40134c1590167b888ca06ad51071139ff2ae.1627040189.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627040189.git.leonro@nvidia.com>
References: <cover.1627040189.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The QP type is set by the IB/core and shouldn't be set in the driver.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Acked-by: Gal Pressman <galpress@amazon.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index b4cfb656ddd5..b1c4780e86be 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -727,7 +727,6 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 
 	qp->qp_handle = create_qp_resp.qp_handle;
 	qp->ibqp.qp_num = create_qp_resp.qp_num;
-	qp->ibqp.qp_type = init_attr->qp_type;
 	qp->max_send_wr = init_attr->cap.max_send_wr;
 	qp->max_recv_wr = init_attr->cap.max_recv_wr;
 	qp->max_send_sge = init_attr->cap.max_send_sge;
-- 
2.31.1

