Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0335664E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhDGISt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 04:18:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16370 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbhDGISt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 04:18:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFcgS3t4nzjYZp;
        Wed,  7 Apr 2021 16:16:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 16:18:30 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 7/7] RDMA/core: Remove redundant BUG_ON
Date:   Wed, 7 Apr 2021 16:15:53 +0800
Message-ID: <1617783353-48249-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's ok if the refcount of cm_id is zero when release the reference of it,
there is no need to call BUG_ON.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/iwcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index da8adad..654ac72 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -211,7 +211,6 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
  */
 static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
 {
-	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
 	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
 		BUG_ON(!list_empty(&cm_id_priv->work_list));
 		free_cm_id(cm_id_priv);
-- 
2.8.1

