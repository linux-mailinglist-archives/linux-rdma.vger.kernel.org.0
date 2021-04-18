Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF12B36359C
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhDRNmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhDRNmD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:42:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDDDE61001;
        Sun, 18 Apr 2021 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753294;
        bh=SOFpCGBIwUXE4yfvAK0X2Qcs2wI/OMmsQvZrtcvxtm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kP7jop/kn3lDJwnUp2G1SNKOLZP7NnHwBD16oSlBHqdlkCgem/WcRsk0tfLp+dFR/
         bNcGbmHFwImOmQsrSszMoxKqILqGoCCZnd/ht9wqZKdfLvIE0aat11/XniVufRGPY/
         BTngILdYhtNP3kT9voX9WMJfJfZfMR4XSk2xwfGLd2cvTuTAkEO1sgi9fKfH7UkkYb
         Xi5e0zV29AJ3IYy0ZfxzadH+7LHxfiEIZhk9/qJX4uWau5r2/OYVVR5mqVJ0M3zd4O
         +uxrH3FycIXh70QinVuP0N2VFEzoo4O+a3UEPdd+w3meCuH4znXN6xdorU0WM3eLDU
         2ydxpTY/kQZoQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 2/4] RDMA/restrack: Add support to get resource tracking for SRQ
Date:   Sun, 18 Apr 2021 16:41:24 +0300
Message-Id: <0db71c409f24f2f6b019bf8797a8fed96fe7079c.1618753110.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753110.git.leonro@nvidia.com>
References: <cover.1618753110.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

In order to track SRQ resources, a new restrack object is initialized
and added to the resource tracking database.

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/restrack.c | 3 +++
 drivers/infiniband/core/verbs.c    | 7 +++++++
 include/rdma/ib_verbs.h            | 5 +++++
 include/rdma/restrack.h            | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index def0c5b0efe9..1f935d9f6178 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -47,6 +47,7 @@ static const char *type2str(enum rdma_restrack_type type)
 		[RDMA_RESTRACK_MR] = "MR",
 		[RDMA_RESTRACK_CTX] = "CTX",
 		[RDMA_RESTRACK_COUNTER] = "COUNTER",
+		[RDMA_RESTRACK_SRQ] = "SRQ",
 	};
 
 	return names[type];
@@ -141,6 +142,8 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 		return container_of(res, struct ib_ucontext, res)->device;
 	case RDMA_RESTRACK_COUNTER:
 		return container_of(res, struct rdma_counter, res)->device;
+	case RDMA_RESTRACK_SRQ:
+		return container_of(res, struct ib_srq, res)->device;
 	default:
 		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
 		return NULL;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 5b6214b803a2..2b0798151fb7 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1039,8 +1039,12 @@ struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
 	}
 	atomic_inc(&pd->usecnt);
 
+	rdma_restrack_new(&srq->res, RDMA_RESTRACK_SRQ);
+	rdma_restrack_parent_name(&srq->res, &pd->res);
+
 	ret = pd->device->ops.create_srq(srq, srq_init_attr, udata);
 	if (ret) {
+		rdma_restrack_put(&srq->res);
 		atomic_dec(&srq->pd->usecnt);
 		if (srq->srq_type == IB_SRQT_XRC)
 			atomic_dec(&srq->ext.xrc.xrcd->usecnt);
@@ -1050,6 +1054,8 @@ struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
 		return ERR_PTR(ret);
 	}
 
+	rdma_restrack_add(&srq->res);
+
 	return srq;
 }
 EXPORT_SYMBOL(ib_create_srq_user);
@@ -1088,6 +1094,7 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 	if (ib_srq_has_cq(srq->srq_type))
 		atomic_dec(&srq->ext.cq->usecnt);
+	rdma_restrack_del(&srq->res);
 	kfree(srq);
 
 	return ret;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c596882893ae..7e2f3699b898 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1610,6 +1610,11 @@ struct ib_srq {
 			} xrc;
 		};
 	} ext;
+
+	/*
+	 * Implementation details of the RDMA core, don't use in drivers:
+	 */
+	struct rdma_restrack_entry res;
 };
 
 enum ib_raw_packet_caps {
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 05e18839eaff..79d109c47242 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -49,6 +49,10 @@ enum rdma_restrack_type {
 	 * @RDMA_RESTRACK_COUNTER: Statistic Counter
 	 */
 	RDMA_RESTRACK_COUNTER,
+	/**
+	 * @RDMA_RESTRACK_SRQ: Shared receive queue (SRQ)
+	 */
+	RDMA_RESTRACK_SRQ,
 	/**
 	 * @RDMA_RESTRACK_MAX: Last entry, used for array dclarations
 	 */
-- 
2.30.2

