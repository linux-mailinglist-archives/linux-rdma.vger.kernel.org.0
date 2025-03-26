Return-Path: <linux-rdma+bounces-8975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99EA71859
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A4E189D77E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E41F1510;
	Wed, 26 Mar 2025 14:20:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557E1B4132;
	Wed, 26 Mar 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998807; cv=none; b=acAUIXgO3tM9PGftSSv+RCTOnvaILcTZS45wjuLOjNOiQyUu+UMZmsGmxkPaUY6FrKqIH9y7XW16J9qqsIzdMwpI7TtgLBNt3XgtoaCLoE9UZKbQX96h3i4zx0/fmSukvaw7LJ7+WcARD6dFrFT2nP0fD/LeVIceyYhoRm2Wlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998807; c=relaxed/simple;
	bh=PM9RdmhtSz0Ds1dbVBa+7sDzqP7P586CQYhhr5hryOc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Nag65VBlDPe4qBeNTGCbZk2uUHCK+fdKpfcwgtW8CnCsPqcb2dVRU6/22XjIV1XOanii8v4oVVORsskyc0eJKMSSFhsEFgsVWBVU+ZuGsyyWPX/QUrtxmh/OquHo8AmPpqYeAhrkO+8CRCNhIlZogY/dKoNgm+bv9cW9IrL3dHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZN87j4QqFz8R040;
	Wed, 26 Mar 2025 22:20:01 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 52QEJrrh028468;
	Wed, 26 Mar 2025 22:19:53 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 26 Mar 2025 22:19:55 +0800 (CST)
Date: Wed, 26 Mar 2025 22:19:55 +0800 (CST)
X-Zmail-TransId: 2afc67e40d0bfffffffffab-d87e9
X-Mailer: Zmail v1.0
Message-ID: <20250326221955611qu6Ix3Pt5WgKvhL6sTySX@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <leon@kernel.org>
Cc: <yishaih@nvidia.com>, <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBSRE1BOiBSZXBsYWNlIG1zZWNzX3RvX2ppZmZpZXMgd2l0aCBzZWNzX3RvX2ppZmZpZXMgZm9ywqB0aW1lb3V0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52QEJrrh028468
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E40D11.004/4ZN87j4QqFz8R040

From: Peng Jiang <jiang.peng9@zte.com.cn>

In drivers/infiniband/hw/mlx4/mcg.c and drivers/infiniband/hw/mlx5/mr.c,
`msecs_to_jiffies` is used to convert milliseconds to jiffies.
For constant milliseconds, using `msecs_to_jiffies` introduces additional
computational overhead. For example, it is unnecessary to check
if m > jiffies_to_msecs(MAX_JIFFY_OFFSET) or (int)m < 0 for constants,
while using `secs_to_jiffies` can avoid these extra calculations.

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/infiniband/hw/mlx4/mcg.c | 8 ++++----
 drivers/infiniband/hw/mlx5/mr.c  | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mcg.c b/drivers/infiniband/hw/mlx4/mcg.c
index 33f525b744f2..e279e69b9a51 100644
--- a/drivers/infiniband/hw/mlx4/mcg.c
+++ b/drivers/infiniband/hw/mlx4/mcg.c
@@ -43,7 +43,7 @@

 #define MAX_VFS		80
 #define MAX_PEND_REQS_PER_FUNC 4
-#define MAD_TIMEOUT_MS	2000
+#define MAD_TIMEOUT_SEC	2

 #define mcg_warn(fmt, arg...)	pr_warn("MCG WARNING: " fmt, ##arg)
 #define mcg_error(fmt, arg...)	pr_err(fmt, ##arg)
@@ -270,7 +270,7 @@ static int send_join_to_wire(struct mcast_group *group, struct ib_sa_mad *sa_mad
 	if (!ret) {
 		/* calls mlx4_ib_mcg_timeout_handler */
 		queue_delayed_work(group->demux->mcg_wq, &group->timeout_work,
-				msecs_to_jiffies(MAD_TIMEOUT_MS));
+				   secs_to_jiffies(MAD_TIMEOUT_SEC));
 	}

 	return ret;
@@ -309,7 +309,7 @@ static int send_leave_to_wire(struct mcast_group *group, u8 join_state)
 	if (!ret) {
 		/* calls mlx4_ib_mcg_timeout_handler */
 		queue_delayed_work(group->demux->mcg_wq, &group->timeout_work,
-				msecs_to_jiffies(MAD_TIMEOUT_MS));
+				   secs_to_jiffies(MAD_TIMEOUT_SEC));
 	}

 	return ret;
@@ -1091,7 +1091,7 @@ static void _mlx4_ib_mcg_port_cleanup(struct mlx4_ib_demux_ctx *ctx, int destroy
 	for (i = 0; i < MAX_VFS; ++i)
 		clean_vf_mcast(ctx, i);

-	end = jiffies + msecs_to_jiffies(MAD_TIMEOUT_MS + 3000);
+	end = jiffies + secs_to_jiffies(MAD_TIMEOUT_SEC + 3);
 	do {
 		count = 0;
 		mutex_lock(&ctx->mcg_table_lock);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b7c8c926c578..7943f183267a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -525,7 +525,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 		ent->fill_to_high_water = false;
 		if (ent->pending)
 			queue_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					   msecs_to_jiffies(1000));
+					   secs_to_jiffies(1));
 		else
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
 	}
@@ -576,7 +576,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 					"add keys command failed, err %d\n",
 					err);
 				queue_delayed_work(cache->wq, &ent->dwork,
-						   msecs_to_jiffies(1000));
+						   secs_to_jiffies(1));
 			}
 		}
 	} else if (ent->mkeys_queue.ci > 2 * ent->limit) {
@@ -2051,7 +2051,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 			ent->in_use--;
 		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					 msecs_to_jiffies(30 * 1000));
+					 secs_to_jiffies(30));
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-- 
2.25.1

