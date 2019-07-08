Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF061D55
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfGHK7S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 06:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHK7S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 06:59:18 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133BB2086D;
        Mon,  8 Jul 2019 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562583556;
        bh=ru9IT8C7yrYWJNT0B/5r1p7VMxtUzvhLAzRTfbPxRqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUYJlb4jpjzFTECmaj6BxScCpTDNNWkV8M+ECtbh0QNSoDIRyW3NEDSOQx67GH0U7
         XG2PFWDFyYllK3C5mMdti6HLANkaY/iD5zftj/jVAxNTQxdVK96Ib9/52hFwU5pHug
         YH1qMbBZ/tJ98DixVgf2OioPxVs7IS86kM8GLcHc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH rdma-next v5 1/4] linux/dim: Implement RDMA adaptive moderation (DIM)
Date:   Mon,  8 Jul 2019 13:59:02 +0300
Message-Id: <20190708105905.27468-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708105905.27468-1-leon@kernel.org>
References: <20190708105905.27468-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

RDMA DIM implements a different algorithm from net DIM and is based on
completions which is how we can implement interrupt moderation in RDMA.

The algorithm optimizes for number of completions and ratio between
completions and events. In order to avoid long latencies, the
implementation performs fast reduction of moderation level when the
traffic changes.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/linux/dim.h |  36 +++++++++++++++
 lib/dim/Makefile    |   6 +--
 lib/dim/rdma_dim.c  | 108 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 4 deletions(-)
 create mode 100644 lib/dim/rdma_dim.c

diff --git a/include/linux/dim.h b/include/linux/dim.h
index aa9bdd47a648..aa69730c3b8d 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -82,6 +82,7 @@ struct dim_stats {
  * @prev_stats: Measured rates from previous iteration (for comparison)
  * @start_sample: Sampled data at start of current iteration
  * @work: Work to perform on action required
+ * @priv: A pointer to the struct that points to dim
  * @profile_ix: Current moderation profile
  * @mode: CQ period count mode
  * @tune_state: Algorithm tuning state (see below)
@@ -95,6 +96,7 @@ struct dim {
 	struct dim_sample start_sample;
 	struct dim_sample measuring_sample;
 	struct work_struct work;
+	void *priv;
 	u8 profile_ix;
 	u8 mode;
 	u8 tune_state;
@@ -363,4 +365,38 @@ struct dim_cq_moder net_dim_get_def_tx_moderation(u8 cq_period_mode);
  */
 void net_dim(struct dim *dim, struct dim_sample end_sample);
 
+/* RDMA DIM */
+
+/*
+ * RDMA DIM profile:
+ * profile size must be of RDMA_DIM_PARAMS_NUM_PROFILES.
+ */
+#define RDMA_DIM_PARAMS_NUM_PROFILES 9
+#define RDMA_DIM_START_PROFILE 0
+
+static const struct dim_cq_moder
+rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
+	{1,   0, 1,  0},
+	{1,   0, 4,  0},
+	{2,   0, 4,  0},
+	{2,   0, 8,  0},
+	{4,   0, 8,  0},
+	{16,  0, 8,  0},
+	{16,  0, 16, 0},
+	{32,  0, 16, 0},
+	{32,  0, 32, 0},
+};
+
+/**
+ * rdma_dim - Runs the adaptive moderation.
+ * @dim: The moderation struct.
+ * @completions: The number of completions collected in this round.
+ *
+ * Each call to rdma_dim takes the latest amount of completions that
+ * have been collected and counts them as a new event.
+ * Once enough events have been collected the algorithm decides a new
+ * moderation level.
+ */
+void rdma_dim(struct dim *dim, u64 completions);
+
 #endif /* DIM_H */
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index 160afe288df0..1d6858a108cb 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -2,8 +2,6 @@
 # DIM Dynamic Interrupt Moderation library
 #
 
-obj-$(CONFIG_DIMLIB) = net_dim.o
+obj-$(CONFIG_DIMLIB) += dim.o
 
-net_dim-y = \
-	dim.o		\
-	net_dim.o
+dim-y := dim.o net_dim.o rdma_dim.o
diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
new file mode 100644
index 000000000000..f7e26c7b4749
--- /dev/null
+++ b/lib/dim/rdma_dim.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2019, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <linux/dim.h>
+
+static int rdma_dim_step(struct dim *dim)
+{
+	if (dim->tune_state == DIM_GOING_RIGHT) {
+		if (dim->profile_ix == (RDMA_DIM_PARAMS_NUM_PROFILES - 1))
+			return DIM_ON_EDGE;
+		dim->profile_ix++;
+		dim->steps_right++;
+	}
+	if (dim->tune_state == DIM_GOING_LEFT) {
+		if (dim->profile_ix == 0)
+			return DIM_ON_EDGE;
+		dim->profile_ix--;
+		dim->steps_left++;
+	}
+
+	return DIM_STEPPED;
+}
+
+static int rdma_dim_stats_compare(struct dim_stats *curr,
+				  struct dim_stats *prev)
+{
+	/* first stat */
+	if (!prev->cpms)
+		return DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpms, prev->cpms))
+		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
+						DIM_STATS_WORSE;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
+		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
+						DIM_STATS_WORSE;
+
+	return DIM_STATS_SAME;
+}
+
+static bool rdma_dim_decision(struct dim_stats *curr_stats, struct dim *dim)
+{
+	int prev_ix = dim->profile_ix;
+	u8 state = dim->tune_state;
+	int stats_res;
+	int step_res;
+
+	if (state != DIM_PARKING_ON_TOP && state != DIM_PARKING_TIRED) {
+		stats_res = rdma_dim_stats_compare(curr_stats,
+						   &dim->prev_stats);
+
+		switch (stats_res) {
+		case DIM_STATS_SAME:
+			if (curr_stats->cpe_ratio <= 50 * prev_ix)
+				dim->profile_ix = 0;
+			break;
+		case DIM_STATS_WORSE:
+			dim_turn(dim);
+			/* fall through */
+		case DIM_STATS_BETTER:
+			step_res = rdma_dim_step(dim);
+			if (step_res == DIM_ON_EDGE)
+				dim_turn(dim);
+			break;
+		}
+	}
+
+	dim->prev_stats = *curr_stats;
+
+	return dim->profile_ix != prev_ix;
+}
+
+void rdma_dim(struct dim *dim, u64 completions)
+{
+	struct dim_sample *curr_sample = &dim->measuring_sample;
+	struct dim_stats curr_stats;
+	u32 nevents;
+
+	dim_update_sample_with_comps(curr_sample->event_ctr + 1, 0, 0,
+				     curr_sample->comp_ctr + completions,
+				     &dim->measuring_sample);
+
+	switch (dim->state) {
+	case DIM_MEASURE_IN_PROGRESS:
+		nevents = curr_sample->event_ctr - dim->start_sample.event_ctr;
+		if (nevents < DIM_NEVENTS)
+			break;
+		dim_calc_stats(&dim->start_sample, curr_sample, &curr_stats);
+		if (rdma_dim_decision(&curr_stats, dim)) {
+			dim->state = DIM_APPLY_NEW_PROFILE;
+			schedule_work(&dim->work);
+			break;
+		}
+		/* fall through */
+	case DIM_START_MEASURE:
+		dim->state = DIM_MEASURE_IN_PROGRESS;
+		dim_update_sample_with_comps(curr_sample->event_ctr, 0, 0,
+					     curr_sample->comp_ctr,
+					     &dim->start_sample);
+		break;
+	case DIM_APPLY_NEW_PROFILE:
+		break;
+	}
+}
+EXPORT_SYMBOL(rdma_dim);
-- 
2.20.1

