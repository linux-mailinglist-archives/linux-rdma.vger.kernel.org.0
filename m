Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7393B8E6FC
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfHOIix (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIix (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:38:53 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7E522387;
        Thu, 15 Aug 2019 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858332;
        bh=L11hKorvZW28GkqLNvqA7712NVQnrQhNz6gTBU98o08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W41x+rE595eTdj27//nC1F35v6/U4pzuF3ytySOOZMMxa3XFmTW+vgLaga27Wke1x
         ve2IV8g28t3wEA8+AVddID0sccZHTY9YZF6wWy/HSJOXNXwBkc62ufScJ2FgvW8bVg
         CF4GXahJMS7mJFt96ZV4Gxw3E0xepXVtL8j9zKIQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 3/8] RDMA/restrack: Rewrite PID namespace check to be reliable
Date:   Thu, 15 Aug 2019 11:38:29 +0300
Message-Id: <20190815083834.9245-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

task_active_pid_ns() is wrong API to check PID namespace because it
posses some restrictions and return PID namespace where the process
was allocated. It created mismatches with current namespace, which
can be different.

Rewrite whole rdma_is_visible_in_pid_ns() logic to provide reliable
results without any relation to allocated PID namespace.

Fixes: 8be565e65fa9 ("RDMA/nldev: Factor out the PID namespace check")
Fixes: 6a6c306a09b5 ("RDMA/restrack: Make is_visible_in_pid_ns() as an API")
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c    |  3 +--
 drivers/infiniband/core/restrack.c | 15 +++++++--------
 include/rdma/restrack.h            |  3 +--
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 87d40d1ecdde..020c26976558 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -382,8 +382,7 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device)
 	for (i = 0; i < RDMA_RESTRACK_MAX; i++) {
 		if (!names[i])
 			continue;
-		curr = rdma_restrack_count(device, i,
-					   task_active_pid_ns(current));
+		curr = rdma_restrack_count(device, i);
 		ret = fill_res_info_entry(msg, names[i], curr);
 		if (ret)
 			goto err;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index bddff426ee0f..a07665f7ef8c 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -107,10 +107,8 @@ void rdma_restrack_clean(struct ib_device *dev)
  * rdma_restrack_count() - the current usage of specific object
  * @dev:  IB device
  * @type: actual type of object to operate
- * @ns:   PID namespace
  */
-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
-			struct pid_namespace *ns)
+int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type)
 {
 	struct rdma_restrack_root *rt = &dev->res[type];
 	struct rdma_restrack_entry *e;
@@ -119,10 +117,9 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 
 	xa_lock(&rt->xa);
 	xas_for_each(&xas, e, U32_MAX) {
-		if (ns == &init_pid_ns ||
-		    (!rdma_is_kernel_res(e) &&
-		     ns == task_active_pid_ns(e->task)))
-			cnt++;
+		if (!rdma_is_visible_in_pid_ns(e))
+			continue;
+		cnt++;
 	}
 	xa_unlock(&rt->xa);
 	return cnt;
@@ -360,5 +357,7 @@ bool rdma_is_visible_in_pid_ns(struct rdma_restrack_entry *res)
 	 */
 	if (rdma_is_kernel_res(res))
 		return task_active_pid_ns(current) == &init_pid_ns;
-	return task_active_pid_ns(current) == task_active_pid_ns(res->task);
+
+	/* PID 0 means that resource is not found in current namespace */
+	return task_pid_vnr(res->task);
 }
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index b0fc6b26bdf5..83df1ec6664e 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -105,8 +105,7 @@ struct rdma_restrack_entry {
 };
 
 int rdma_restrack_count(struct ib_device *dev,
-			enum rdma_restrack_type type,
-			struct pid_namespace *ns);
+			enum rdma_restrack_type type);
 
 void rdma_restrack_kadd(struct rdma_restrack_entry *res);
 void rdma_restrack_uadd(struct rdma_restrack_entry *res);
-- 
2.20.1

