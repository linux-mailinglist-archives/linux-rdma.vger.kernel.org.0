Return-Path: <linux-rdma+bounces-14249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF9C33657
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC37428282
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B96346FAC;
	Tue,  4 Nov 2025 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ceUjJz9z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647233892B
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299391; cv=none; b=JKF+PqdDxipRi934z5RKdBZcV/1YKJNWDk1oXCuYrIt7aKVC0QeTBqsY4CbwC/xNUH4BmhAcFEXGyPthUGGTIaEO8Heu+KiFwD9mIH2vFkjLSr044bRMYp6b3dPAM5ix1bn/sRYEWY+xVYLOWb1neamisH/7mSv0s18vAyZ2h60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299391; c=relaxed/simple;
	bh=F26rfSSN1x7KeaPgbqhaghuk20JZMAp2Jes70pEFDnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2yOA5ws0Nx7DJBWGFHuMP+2IOrZNYcOz86Llcy4wClu55Wn4+QLnZsOS9+GCULjgSkwvZ/IHlAC7/KvWjGC3tNxPMf5KrlBV3LZLEWAR1JNTnQTqxrmvYlP5hv00tyjTcdkbraaAnPm/U4G9jkTwPM5BQsfowBJ6zOpN2BK57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ceUjJz9z; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762299387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PfA4jxHfYnfbyzECoSzkW9jzJrwryJPXI6HWQQW/13Q=;
	b=ceUjJz9zhLNI1RrtIYr/APXkhgXf00pTf2CDbLAgo10rLX5juN48dknPac9xMm+4J/F+45
	asAhmjny11EuZm6qWO5F5FAa2RLaX6iNOBTgJP8Nit1lT8BzyOIqmzp3mArkmvgbdOvoij
	v1XDhiS49Htle+YbbLZ+xKRaFmV67xU=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: [PATCH rdma-next v2 1/1] RDMA/core: Fix WARNING in gid_table_release_one
Date: Tue,  4 Nov 2025 15:36:01 -0800
Message-ID: <20251104233601.1145-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

GID entry ref leak for dev syz1 index 2 ref=615
...
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

When the state of a GID is GID_TABLE_ENTRY_PENDING_DEL, it indicates
that the GID is about to be released soon. Therefore, it does not
appear to be a leak.

Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Use flush_workqueue instead of while loop
---
 drivers/infiniband/core/cache.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 81cf3c902e81..74211fb37020 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -799,16 +799,26 @@ static void release_gid_table(struct ib_device *device,
 	if (!table)
 		return;
 
+	mutex_lock(&table->lock);
 	for (i = 0; i < table->sz; i++) {
 		if (is_gid_entry_free(table->data_vec[i]))
 			continue;
 
-		WARN_ONCE(true,
-			  "GID entry ref leak for dev %s index %d ref=%u\n",
+		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
+			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
 			  dev_name(&device->dev), i,
-			  kref_read(&table->data_vec[i]->kref));
+			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
+		/*
+		 * The entry may be sitting in the WQ waiting for
+		 * free_gid_work(), flush it to try to clean it.
+		 */
+		mutex_unlock(&table->lock);
+		flush_workqueue(ib_wq);
+		mutex_lock(&table->lock);
 	}
 
+	mutex_unlock(&table->lock);
+
 	mutex_destroy(&table->lock);
 	kfree(table->data_vec);
 	kfree(table);
-- 
2.51.2


