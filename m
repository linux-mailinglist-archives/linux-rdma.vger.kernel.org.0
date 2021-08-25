Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FE3F6DAB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 05:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhHYDXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 23:23:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8925 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHYDXM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 23:23:12 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GvWQJ67V8z8tsP;
        Wed, 25 Aug 2021 11:18:16 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 11:22:25 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 11:22:25 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] RDMA/irdma: Remove the repeated declaration
Date:   Wed, 25 Aug 2021 11:21:14 +0800
Message-ID: <1629861674-53343-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Functions 'irdma_alloc_ws_node_id' and 'irdma_free_ws_node_id' are
declared twice, so remove the repeated declaration.

Cc: Mustafa Ismail <mustafa.ismail@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/infiniband/hw/irdma/protos.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
index e3f5173706fe..78f598fdbccf 100644
--- a/drivers/infiniband/hw/irdma/protos.h
+++ b/drivers/infiniband/hw/irdma/protos.h
@@ -71,8 +71,6 @@ void irdma_qp_rem_qos(struct irdma_sc_qp *qp);
 struct irdma_sc_qp *irdma_get_qp_from_list(struct list_head *head,
 					   struct irdma_sc_qp *qp);
 void irdma_reinitialize_ieq(struct irdma_sc_vsi *vsi);
-u16 irdma_alloc_ws_node_id(struct irdma_sc_dev *dev);
-void irdma_free_ws_node_id(struct irdma_sc_dev *dev, u16 node_id);
 /* terminate functions*/
 void irdma_terminate_send_fin(struct irdma_sc_qp *qp);
 
-- 
2.7.4

