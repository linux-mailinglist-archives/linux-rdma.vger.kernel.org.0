Return-Path: <linux-rdma+bounces-13509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C311B87C11
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB9F4E0037
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 02:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924D259CAC;
	Fri, 19 Sep 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g35c4Ak6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D835942
	for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250372; cv=none; b=TUunnObk4DVRMIKClBXy5Fr4P/3nYbcJkkUy3gI/5N6H7VKan4hGSzLC5XTdmtPXLGBYfDL5jPRnOi/0AtVSWDgVnlYbu/9CzgBPkY8nC/bVgsvU6dk7j+ZjedlrGmBTpBx2Z+69rdJF9eqewA92h2b1PfV3bC2clzscdIvVPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250372; c=relaxed/simple;
	bh=98yvKwH2UtIVCSKMJziEGfp4kYGQhk/YviYY9MS7FD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oBK3G1dDl2jn4dxtdU93h1hJdKFYV1oH0eXAVqbK9C0rT7L3kZ7YFXLEuG4rJL7rmbJ178L9AdygqbvJz4T8FaGL03CYgOe1xcAOQfLLTHVZRxQGcUbPq8y/oDkC+rq6VMMuwkHMkRK2DnJac8z+FdOjF7fa5d+f0oju+oPx49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g35c4Ak6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26c209802c0so437935ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 19:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758250371; x=1758855171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWHSM8M5PEdLO5mZG9/ihvJhFYCqF9T0YZiDT0RrxmE=;
        b=g35c4Ak6GAov6YXceSt7+wXavS6MTWDLwP32+0z5dG6ADxtry1+X/HK/Oz9SLvD3gT
         dyI3T4lolf8PTpFgCMcLc+giBNhpfp1TSjEnJPQuKgi0ip2HTxu3BLBqgYG2IIF/JKVe
         PJ/Dzmnq7cjV2dAXNfZ/FBXt1YGIH49jg2XKKsoLYFvrDwh5EsBf/Oe7s0ZXKUCzLEdD
         tdXIuedMZEpghfJiDE77BhBBx1vzRUjiIfNHUUy8hoH9LT0vIpxlfwJj4px7yVFjjmnR
         MdpdOfH2vI/KaQ49DuGWdRNp0WCVmzNoelGvqoVhX+r3J1+LotKeLPbKEhpru+43ZW0u
         P9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758250371; x=1758855171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWHSM8M5PEdLO5mZG9/ihvJhFYCqF9T0YZiDT0RrxmE=;
        b=IuDkaZwM2htgy+WsuHVSyRgOcSPg7p0yMSMKaHNZxLj1rZ0SNmYhN9grpnS2503FuL
         hAU1LBxDiYlTg/Pa71BMzt+vSc05AXpIR1lIITG/l9jLo8oV4t9yhK7NEJ07aLm++aTH
         0EHfF+6n5QD8zBXYc2cBEnfVDVOK/FIToQP1rPjJ5DpoR54OuG5nBRlOBkshg2Co67+s
         9idoFEUju/8L1tW93sHbooFdJtzU71nf9C+LOxsjdXPDV687E/2h5nfwVLF+BfcTp3bc
         MZK1PRRJ8EGy1SxFN495hw2Vy0QlvRxs89EnjOkjMTiJaHoXu9HpFlIV7ZdjrMVsBhqT
         JIYQ==
X-Gm-Message-State: AOJu0YxwdWfkWNqfLTznbKkBFZtVeMaQaJ1XoeYhVhxphH2AmOdcosZp
	ZjWzvVIcnESH8mB1G2CK2B/YHItEvkJrnVC4QBAeQCMe6QuYdJqEEySq
X-Gm-Gg: ASbGncsfd00hhGHwA7arnWdnrSX7FcCWlLKTrbwDcNtRy3MA7K7ENQyWoKn88cV30U/
	NpwLH6j/lQi0aMNMvkfGqy2mWsGNqlCnGQtiWa4+V9Zp8D+yTkxPhVEFAXefpLJFdfqhfEKzJCC
	3V4eb9rn8lGeBCPuqL9qOUUvQ77ZiHH8qec91weVfbKKDVagNmrM5r/iQxv7R1ia2y1rJE6iahH
	tjUSWEEQ3yKI9jXqypwkx87SnaLVKVROnMF7BJ0VpgzDPeS8Mv3e2Z8nMSvweSPh201FKSM2vtG
	ftKaRfoXgKvTWlDYzvZ1q9Ph93AHW+Nm5vGmDnRVd/CaenDER1XlM/blCUMeNrkUGS/jyfoDPn7
	MZOp76ZSMt+TAPx+GsvBEaf9ue1urOog9orM=
X-Google-Smtp-Source: AGHT+IHEmNw6zHNNZODOfJtrO3dxHRaOi6uO7+rK6qSFuOnxsr+E4gymoo7BQxMey8Irv6HpdcmwNg==
X-Received: by 2002:a17:902:fc8f:b0:267:f7bc:673c with SMTP id d9443c01a7336-269ba51ed72mr22845625ad.44.1758250370330;
        Thu, 18 Sep 2025 19:52:50 -0700 (PDT)
Received: from localhost.localdomain ([115.42.62.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26afe6385afsm4393875ad.39.2025.09.18.19.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:52:49 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	yanjun.zhu@linux.dev
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	rpearsonhpe@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: Fix race in do_task() when draining
Date: Fri, 19 Sep 2025 02:52:12 +0000
Message-Id: <20250919025212.1682087-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When do_task() exhausts its iteration budget (!ret), it sets the state
to TASK_STATE_IDLE to reschedule, without a secondary check on the
current task->state. This can overwrite the TASK_STATE_DRAINING state
set by a concurrent call to rxe_cleanup_task() or rxe_disable_task().

While state changes are protected by a spinlock, both rxe_cleanup_task()
and rxe_disable_task() release the lock while waiting for the task to
finish draining in the while(!is_done(task)) loop. The race occurs if
do_task() hits its iteration limit and acquires the lock in this window.
The cleanup logic may then proceed while the task incorrectly
reschedules itself, leading to a potential use-after-free.

This bug was introduced during the migration from tasklets to workqueues,
where the special handling for the draining case was lost.

Fix this by restoring the original pre-migration behavior. If the state is
TASK_STATE_DRAINING when iterations are exhausted, set cont to 1 to
force a new loop iteration. This allows the task to finish its work, so
that a subsequent iteration can reach the switch statement and correctly
transition the state to TASK_STATE_DRAINED, stopping the task as intended.

Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
Cc: stable@vger.kernel.org
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
v2:
* Rewrite commit message for clarity. Thanks to Zhu Yanjun for the review.
---
 drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 6f8f353e9583..f522820b950c 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
 		 * yield the cpu and reschedule the task
 		 */
 		if (!ret) {
-			task->state = TASK_STATE_IDLE;
-			resched = 1;
+			if (task->state != TASK_STATE_DRAINING) {
+				task->state = TASK_STATE_IDLE;
+				resched = 1;
+			} else {
+				cont = 1;
+			}
 			goto exit;
 		}
 
-- 
2.25.1


