Return-Path: <linux-rdma+bounces-6303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6839E57D3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98894286601
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC5219A60;
	Thu,  5 Dec 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZHeXhK2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B271218EBF
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406650; cv=none; b=r1nyFTVy6IAdBoB41flWEBmaOIGc72bfUCqiG+MJ2BfpVZlyG4a5+qTu9XwOYXrvOQfgOeNMcT8oeJL6lWoXRiVI5y+fw5x4tB24mu+5fg+wrFDNk3BfFYX/vEmHRQ7ymo+FJs60L2ZFEAb1vPbuQwVGT8SHYgXx3IY5jePalCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406650; c=relaxed/simple;
	bh=CmxZO7CQEOtmJYZObt8DTER46vuplNhU5pZf2Un0/JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyAR61hSbPqJk3qYfm+sf7QZDodM44P3xCexbpCEkDRMZgNEkGYHg2/S301h4RcpIIO+6lMG0EOmebdpok/5YItMa2XLNo51qJM/bBMoXlojToVoOH9gJcIBY2LU9lma05gVtBG/6WfPoI2YfSjWdqrP4cPzZY/A9H5mAHW/3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZHeXhK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCFFC4CED1;
	Thu,  5 Dec 2024 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406648;
	bh=CmxZO7CQEOtmJYZObt8DTER46vuplNhU5pZf2Un0/JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZHeXhK2qE7lGW3UmKRYWcUNDS5vf2n1/58eL3faQergkJNU8CmoK7JGzKX0n5ExM
	 IYBBN7/HeHha07arEBJk7kufza4Y65GCGirDt/onNYrNyzzPFN4UrYkpWaqyPPb62b
	 bh2Y+wmTUf1kd/Yt2A8qBfgbd5X5EyYST+84rl7CBnjD4A0OQ9CSVM5A+NGs3rDY6l
	 Qj427VGorJzAefWfR4JgUXYHN+SuwMg9gx5G9QD4eVUs84cB1UcthojxFZl0agcXpj
	 DADWbK3oJK5y1O7DMu5Ehm53juqCjW49uYos4KcsXzcen9w89eaTMInTo0KZJEdXan
	 TLUDYSRaJ08fQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 3/9] RDMA/sa_query: Enforce min retry interval and deadline
Date: Thu,  5 Dec 2024 15:49:33 +0200
Message-ID: <eae3b880eba41734d7fe9604d7f871960a27cb26.1733405453.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733405453.git.leon@kernel.org>
References: <cover.1733405453.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

SA query users, both in-kernel and userspace (via rdma_resolve_route),
pass in a total timeout and expect the SA query layer to handle retries.
SA query relies on the MAD layer to issue a fixed number of 10 retries
at the specified interval (timeout), set to 1/10 of the requested total
timeout.

When the caller-requested total timeout is low (e.g., 1s for IPoIB), the
resulting retry interval (e.g., 100ms) to too aggressive.  There have
been reports of overloaded SA receivers.  Hence, enforce a minimum.  A
follow-up change will make this configurable via rdma tool (netlink) at
per-port granularity.

Continue to enforce the caller's total timeout by using the new MAD
layer deadline option.

Remove small-timeout special case - the total timeout option will take
care of stopping the send even when more retries are left.  Moreover,
this special case results in an extremely aggressive 1ms retries, which
is definitely not desirable.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sa_query.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 53571e6b3162..ac0d53bf91c4 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
+#include <linux/minmax.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/if_ether.h>
@@ -59,6 +60,7 @@
 #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
 #define IB_SA_CPI_MAX_RETRY_CNT			3
 #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
+#define IB_SA_MIN_TIMEOUT_MS_DEFAULT		500
 static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
 
 struct ib_sa_sm_ah {
@@ -96,6 +98,7 @@ struct ib_sa_port {
 	spinlock_t                   classport_lock; /* protects class port info set */
 	spinlock_t           ah_lock;
 	u32		     port_num;
+	u32                  min_timeout_ms;
 };
 
 struct ib_sa_device {
@@ -1344,13 +1347,14 @@ static int send_mad(struct ib_sa_query *query, unsigned long timeout_ms,
 	if (ret < 0)
 		return ret;
 
-	query->mad_buf->timeout_ms  = timeout_ms / nmbr_sa_query_retries;
+	query->mad_buf->timeout_ms =
+		max(READ_ONCE(query->port->min_timeout_ms),
+		    timeout_ms / nmbr_sa_query_retries);
 	query->mad_buf->retries = nmbr_sa_query_retries;
-	if (!query->mad_buf->timeout_ms) {
-		/* Special case, very small timeout_ms */
-		query->mad_buf->timeout_ms = 1;
-		query->mad_buf->retries = timeout_ms;
-	}
+	ret = ib_set_mad_deadline(query->mad_buf, timeout_ms);
+	if (ret)
+		goto out;
+
 	query->mad_buf->context[0] = query;
 	query->id = id;
 
@@ -1364,18 +1368,22 @@ static int send_mad(struct ib_sa_query *query, unsigned long timeout_ms,
 	}
 
 	ret = ib_post_send_mad(query->mad_buf, NULL);
-	if (ret) {
-		xa_lock_irqsave(&queries, flags);
-		__xa_erase(&queries, id);
-		xa_unlock_irqrestore(&queries, flags);
-	}
 
 	/*
 	 * It's not safe to dereference query any more, because the
 	 * send may already have completed and freed the query in
 	 * another context.
 	 */
-	return ret ? ret : id;
+
+out:
+	if (ret) {
+		xa_lock_irqsave(&queries, flags);
+		__xa_erase(&queries, id);
+		xa_unlock_irqrestore(&queries, flags);
+		return ret;
+	}
+
+	return id;
 }
 
 void ib_sa_unpack_path(void *attribute, struct sa_path_rec *rec)
@@ -2192,6 +2200,8 @@ static int ib_sa_add_one(struct ib_device *device)
 		INIT_DELAYED_WORK(&sa_dev->port[i].ib_cpi_work,
 				  update_ib_cpi);
 
+		sa_dev->port[i].min_timeout_ms = IB_SA_MIN_TIMEOUT_MS_DEFAULT;
+
 		count++;
 	}
 
-- 
2.47.0


