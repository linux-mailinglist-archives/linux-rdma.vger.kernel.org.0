Return-Path: <linux-rdma+bounces-7227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E2A1CAF0
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE6416680F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1120CCF5;
	Sun, 26 Jan 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MES3kO4/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E220CCE1;
	Sun, 26 Jan 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903756; cv=none; b=K8BYDWZyYmHTNGfR1JyHrd+HXDAXekQYugG26bytYtJ9s9RQ4YkNG0I4NZZJawBPLSmxeETwc6kiO5+GeaA07qGoFL7UDbFeIW6rqxMAa8BLfdYiXcLdYBG4QU+nR0uLorCJb3owsH4DmGK8dSNiOGwHMZCPBDjNpJAoQl/XSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903756; c=relaxed/simple;
	bh=x5HEzfVjfPgScwjQW4t9B4jP8nrF/lQqkAuNX0jRhYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fF8AoVPxgxXwCuZuMJZQ1CWUWmTkaZwrzVzpcJyleflQm+5CvIewby0tMVchFWAMNr8SByHPbZgkFzHXbTNTVDt6fhHr5+DDHgbWiuQSfBhTSXkW9/0Ce51owTwWt0hrvyu2DXB+5r3YpXumcwaFBi7anvgjkVwnX/WYs+2i/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MES3kO4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A19C4CED3;
	Sun, 26 Jan 2025 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903756;
	bh=x5HEzfVjfPgScwjQW4t9B4jP8nrF/lQqkAuNX0jRhYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MES3kO4/lNoat/k3sQY+EQ/CxmE5xBjBdzJgrLEyTmb3we9cynzfyEHFgeCb1605+
	 pXRsHitP7jR27AEjqlq2NeWAR8t2XyDqklh5SbAn+pq8lhxhbRMGUgJV7lEhiL1QB7
	 UGy0TLzzrAq2DrJYELZ/E6/h4/zUihhehgo1Ol+BtrwMN7F9GhLrBid6/yRtx4l5ac
	 sUlo5feCivf55woJjoULpLI6n+wwoVOQGZWtxPWv8YGcnQfhhxzwJsQDYsMaw9qTAH
	 ctg0VaI+kf7F4tSUeLXwWJ14Sx0MNJjV+khdnusYiwV4ifVkJrTc8IKSEzodHXq3Or
	 sGgoyh8sZ5lPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vadim Fedorenko <vadfed@meta.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	rrameshbabu@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/29] net/mlx5: use do_aux_work for PHC overflow checks
Date: Sun, 26 Jan 2025 10:01:54 -0500
Message-Id: <20250126150210.955385-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Vadim Fedorenko <vadfed@meta.com>

[ Upstream commit e61e6c415ba9ff2b32bb6780ce1b17d1d76238f1 ]

The overflow_work is using system wq to do overflow checks and updates
for PHC device timecounter, which might be overhelmed by other tasks.
But there is dedicated kthread in PTP subsystem designed for such
things. This patch changes the work queue to proper align with PTP
subsystem and to avoid overloading system work queue.
The adjfine() function acts the same way as overflow check worker,
we can postpone ptp aux worker till the next overflow period after
adjfine() was called.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250107104812.380225-1-vadfed@meta.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 24 ++++++++++---------
 include/linux/mlx5/driver.h                   |  1 -
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index b306ae79bf97a..863196ad0ddc7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
 	}
 }
 
-static void mlx5_timestamp_overflow(struct work_struct *work)
+static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
 	struct mlx5_core_dev *mdev;
 	struct mlx5_timer *timer;
 	struct mlx5_clock *clock;
 	unsigned long flags;
 
-	timer = container_of(dwork, struct mlx5_timer, overflow_work);
-	clock = container_of(timer, struct mlx5_clock, timer);
+	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	timer = &clock->timer;
 
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
 		goto out;
@@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
 out:
-	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
+	return timer->overflow_period;
 }
 
 static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
@@ -521,6 +520,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	timer->cycles.mult = mult;
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+	ptp_schedule_worker(clock->ptp, timer->overflow_period);
 
 	return 0;
 }
@@ -856,6 +856,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_info = {
 	.settime64	= mlx5_ptp_settime,
 	.enable		= NULL,
 	.verify		= NULL,
+	.do_aux_work	= mlx5_timestamp_overflow,
 };
 
 static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
@@ -1056,12 +1057,11 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
 	do_div(ns, NSEC_PER_SEC / HZ);
 	timer->overflow_period = ns;
 
-	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
-	if (timer->overflow_period)
-		schedule_delayed_work(&timer->overflow_work, 0);
-	else
+	if (!timer->overflow_period) {
+		timer->overflow_period = HZ;
 		mlx5_core_warn(mdev,
-			       "invalid overflow period, overflow_work is not scheduled\n");
+			       "invalid overflow period, overflow_work is scheduled once per second\n");
+	}
 
 	if (clock_info)
 		clock_info->overflow_period = timer->overflow_period;
@@ -1176,6 +1176,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 
 	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
 	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+
+	if (clock->ptp)
+		ptp_schedule_worker(clock->ptp, 0);
 }
 
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
@@ -1192,7 +1195,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	}
 
 	cancel_work_sync(&clock->pps_info.out_work);
-	cancel_delayed_work_sync(&clock->timer.overflow_work);
 
 	if (mdev->clock_info) {
 		free_page((unsigned long)mdev->clock_info);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 82c7056e27599..d4b2c09cd5fec 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -722,7 +722,6 @@ struct mlx5_timer {
 	struct timecounter         tc;
 	u32                        nominal_c_mult;
 	unsigned long              overflow_period;
-	struct delayed_work        overflow_work;
 };
 
 struct mlx5_clock {
-- 
2.39.5


