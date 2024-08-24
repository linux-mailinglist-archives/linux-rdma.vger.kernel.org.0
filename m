Return-Path: <linux-rdma+bounces-4559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1DF95DD23
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 11:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868801F229CD
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF41547CA;
	Sat, 24 Aug 2024 09:19:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF68488;
	Sat, 24 Aug 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491170; cv=none; b=h+V1gShWxVZbVsxsr9quADzT5gP95b7GBW93IGebR8PmCBNdEj7AKDj5pBktmz5hQMg9T1RQ5Ae4MEiySyf9+Lhi3y/P5c/YaZFaQmfgmuiB2yTF26gfFOe6dquA/kytk/fl1DtF4qE1QsAogXFc3X9i2Am5o9Wipi8ScIDW7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491170; c=relaxed/simple;
	bh=YFGeTqPgX1m16VOPkTzPyLijKgw+QIAEwCrlvf48do0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XbHFoAa6oz6JW1vVYkY6YcYQitQcGn47FEw2lnPOhpSKgZ+DQv3kWjpwXoloH/k5tFCUDD4wqItI95FXIFeclqzqh+0cwb4BEIQqPKuPhO9I4Z3jH6p36Y43abIb2jPH/7x9Gx8RSPelyURutCYvqSrY9ykhQQjfYnEocv5Nuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WrWbV1Yb0z2CnKj;
	Sat, 24 Aug 2024 17:19:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F8AC1A016C;
	Sat, 24 Aug 2024 17:19:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 17:19:23 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<anumula@chelsio.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/cxgb4: Remove unused declarations
Date: Sat, 24 Aug 2024 17:16:29 +0800
Message-ID: <20240824091629.3659565-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit be4c9bad9d0e ("MAINTAINERS: Add cxgb4 and iw_cxgb4 entries")
c4iw_post_terminate() declaration is not used anymore.

And other declarations were never implenmented since introduction in
commit cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index bedd5ca96fdd..5b3007acaa1f 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -972,7 +972,6 @@ u32 c4iw_get_resource(struct c4iw_id_table *id_table);
 void c4iw_put_resource(struct c4iw_id_table *id_table, u32 entry);
 int c4iw_init_resource(struct c4iw_rdev *rdev, u32 nr_tpt,
 		       u32 nr_pdid, u32 nr_srqt);
-int c4iw_init_ctrl_qp(struct c4iw_rdev *rdev);
 int c4iw_pblpool_create(struct c4iw_rdev *rdev);
 int c4iw_rqtpool_create(struct c4iw_rdev *rdev);
 int c4iw_ocqp_pool_create(struct c4iw_rdev *rdev);
@@ -980,7 +979,6 @@ void c4iw_pblpool_destroy(struct c4iw_rdev *rdev);
 void c4iw_rqtpool_destroy(struct c4iw_rdev *rdev);
 void c4iw_ocqp_pool_destroy(struct c4iw_rdev *rdev);
 void c4iw_destroy_resource(struct c4iw_resource *rscp);
-int c4iw_destroy_ctrl_qp(struct c4iw_rdev *rdev);
 void c4iw_register_device(struct work_struct *work);
 void c4iw_unregister_device(struct c4iw_dev *dev);
 int __init c4iw_cm_init(void);
@@ -1042,8 +1040,6 @@ int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp);
 int c4iw_flush_rq(struct t4_wq *wq, struct t4_cq *cq, int count);
 int c4iw_flush_sq(struct c4iw_qp *qhp);
 int c4iw_ev_handler(struct c4iw_dev *rnicp, u32 qid);
-u16 c4iw_rqes_posted(struct c4iw_qp *qhp);
-int c4iw_post_terminate(struct c4iw_qp *qhp, struct t4_cqe *err_cqe);
 u32 c4iw_get_cqid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx);
 void c4iw_put_cqid(struct c4iw_rdev *rdev, u32 qid,
 		struct c4iw_dev_ucontext *uctx);
-- 
2.34.1


