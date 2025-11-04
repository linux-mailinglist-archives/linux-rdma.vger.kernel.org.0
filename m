Return-Path: <linux-rdma+bounces-14220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0AAC2EEB2
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 03:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D53B89B4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F2239E60;
	Tue,  4 Nov 2025 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D02qVAPh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C71FFC6D
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222150; cv=none; b=EaLhNR70dvmpm1UglClOb9QK4Hq+2GZUg8NCVLC92q1hRYioBbHHf33Sn5WEvH2TKgP8ldD2n4LjgR/973epJ+cpcZ72LcspEW921F3wRHT6MUj3tykVAJcS+Ej/jRMpc7gS2T6GzKhSynRRlGpJ4tITL1cXb5P4TWryeLk1Pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222150; c=relaxed/simple;
	bh=eFv2ruM9fXx6x5yw7Makx1ITgPiYPhyJbQeU1Q7CC7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULpn05SdUCfNfHr59L4Xe6YHAkGs2Amik6UD7AMoURzl5hu5Sjn58CNwDiNGpdC5GaFPialF7q/P/jZ8h5a6ZWdSqKcweDNJgOtHXg5mkxFlPFzb0f4hBJz+cMqborm2EEFXSRRRRe/WfbMM6sfuEk3D8CKKVfQqjb9pRJV9yO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D02qVAPh; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762222146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oo9cF9E0b9V6kLZXhQRE2b0FSFanJauMoA2hTlxy5Ag=;
	b=D02qVAPhksmeg1VbZcWWSPzGjQtqN+c33hZa35LiuZ/NAu3ZMIAkrFzn0O4MpZkuWvqu+r
	0XM7rQzDEWcYVrkbhA+M1K7YdZ1DqryIrKBA0qQEkDMdLpz2//qlIW79dQLn3Uo72CRiIK
	T+/+zpJQL30i82pH9zKAzztUGhkh2HQ=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: "Zhu Yanjun" <yanjun.zhu@linux.dev>,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: [PATCH rdma-next 1/1] RDMA/core: Fix WARNING in gid_table_release_one
Date: Mon,  3 Nov 2025 18:08:45 -0800
Message-ID: <20251104020845.254870-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Zhu Yanjun" <yanjun.zhu@linux.dev>

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

The release_gid_table() function also waits for a short period; if the
GID still exists after that, a GID leak warning will be triggered.

Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/cache.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 81cf3c902e81..451325ce6fa5 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -800,13 +800,24 @@ static void release_gid_table(struct ib_device *device,
 		return;
 
 	for (i = 0; i < table->sz; i++) {
+		int cnt = 200;
+
 		if (is_gid_entry_free(table->data_vec[i]))
 			continue;
 
-		WARN_ONCE(true,
-			  "GID entry ref leak for dev %s index %d ref=%u\n",
+		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
+			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
 			  dev_name(&device->dev), i,
-			  kref_read(&table->data_vec[i]->kref));
+			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
+
+		while ((kref_read(&table->data_vec[i]->kref) > 0) && (cnt > 0)) {
+			cnt--;
+			msleep(10);
+		}
+
+		if (cnt <= 0)
+			pr_warn_ratelimited("Possibly kref leak, ref:%u, state: %d\n",
+				kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
 	}
 
 	mutex_destroy(&table->lock);
-- 
2.51.0


