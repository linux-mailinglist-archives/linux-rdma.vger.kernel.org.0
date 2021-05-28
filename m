Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029D5394025
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhE1Jjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:39:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2448 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbhE1Jjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:39:31 -0400
Received: from dggeml767-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fs00612hDz66qP;
        Fri, 28 May 2021 17:35:02 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml767-chm.china.huawei.com (10.1.199.177) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:55 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 02/12] RDMA/core: Use refcount_t instead of atomic_t on refcount of iwpm_admin_data
Date:   Fri, 28 May 2021 17:37:33 +0800
Message-ID: <1622194663-2383-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks. Increase refcount_t from 0 to 1 is
regarded as there is a risk about use-after-free. So it should be set to 1
directly during initialization.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/iwpm_util.c | 12 ++++++++----
 drivers/infiniband/core/iwpm_util.h |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index f80e555..b8f40e6 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -61,7 +61,7 @@ int iwpm_init(u8 nl_client)
 {
 	int ret = 0;
 	mutex_lock(&iwpm_admin_lock);
-	if (atomic_read(&iwpm_admin.refcount) == 0) {
+	if (!refcount_read(&iwpm_admin.refcount)) {
 		iwpm_hash_bucket = kcalloc(IWPM_MAPINFO_HASH_SIZE,
 					   sizeof(struct hlist_head),
 					   GFP_KERNEL);
@@ -77,8 +77,12 @@ int iwpm_init(u8 nl_client)
 			ret = -ENOMEM;
 			goto init_exit;
 		}
+
+		refcount_set(&iwpm_admin.refcount, 1);
+	} else {
+		refcount_inc(&iwpm_admin.refcount);
 	}
-	atomic_inc(&iwpm_admin.refcount);
+
 init_exit:
 	mutex_unlock(&iwpm_admin_lock);
 	if (!ret) {
@@ -105,12 +109,12 @@ int iwpm_exit(u8 nl_client)
 	if (!iwpm_valid_client(nl_client))
 		return -EINVAL;
 	mutex_lock(&iwpm_admin_lock);
-	if (atomic_read(&iwpm_admin.refcount) == 0) {
+	if (!refcount_read(&iwpm_admin.refcount)) {
 		mutex_unlock(&iwpm_admin_lock);
 		pr_err("%s Incorrect usage - negative refcount\n", __func__);
 		return -EINVAL;
 	}
-	if (atomic_dec_and_test(&iwpm_admin.refcount)) {
+	if (refcount_dec_and_test(&iwpm_admin.refcount)) {
 		free_hash_bucket();
 		free_reminfo_bucket();
 		pr_debug("%s: Resources are destroyed\n", __func__);
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index eeb8e60..5002ac6 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -90,7 +90,7 @@ struct iwpm_remote_info {
 };
 
 struct iwpm_admin_data {
-	atomic_t refcount;
+	refcount_t refcount;
 	atomic_t nlmsg_seq;
 	int      client_list[RDMA_NL_NUM_CLIENTS];
 	u32      reg_list[RDMA_NL_NUM_CLIENTS];
-- 
2.7.4

