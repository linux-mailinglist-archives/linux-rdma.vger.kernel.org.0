Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88117F32E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCJJOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJOu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:14:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F283F20674;
        Tue, 10 Mar 2020 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831689;
        bh=or3mMeHU0VxFlTf55SEF3D2iz5kaIcvsxi/phGBy4AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGZ1u75DrvPHIh2Yf3xhH4RTowJx19DTjga0b/PgpZe9ThK6JoyleMsJDfmu9/G/U
         KModobpymYGvKd59Mf2WQFf0A7URgsA+2KjyYBwotqGqSGZ6/6uRGX1UctpczT5hN7
         iwLSqu1+zSJKC63omqDYCUeagct9tuceaFwFxj68=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend() to check field availability
Date:   Tue, 10 Mar 2020 11:14:30 +0200
Message-Id: <20200310091438.248429-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
References: <20200310091438.248429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Remove custom and duplicated variant of offsetofend().

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index bf3120f140f7..5c57098a4aee 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
 	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
 }
 
-#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
-				 sizeof_field(typeof(x), fld) <= (sz))
-
 #define is_reserved_cleared(reserved) \
 	!memchr_inv(reserved, 0, sizeof(reserved))
 
@@ -609,7 +606,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 	if (err)
 		goto err_out;
 
-	if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
+	if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, no input udata\n");
 		err = -EINVAL;
@@ -896,7 +893,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		goto err_out;
 	}
 
-	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
+	if (offsetofend(typeof(cmd), num_sub_cqs) > udata->inlen) {
 		ibdev_dbg(ibdev,
 			  "Incompatible ABI params, no input udata\n");
 		err = -EINVAL;
-- 
2.24.1

