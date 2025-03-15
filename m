Return-Path: <linux-rdma+bounces-8717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B7A62740
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 07:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FBA16D3F6
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059E19F130;
	Sat, 15 Mar 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leO4yQm3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DE19E994;
	Sat, 15 Mar 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742019924; cv=none; b=Of8ca/Rii+FoeS90qtsy3Oba/z82tTzBoKapOe/AW962BFh9TYHKL6ObuAZ9wYfnc++pwKR8qsoGlz9U3483udJGlg2ZkhGMd44TU5np8QJwe3Bm2qWoISyqQ2R7M4PmTlXCltvUkC0lxlzhhS8RMD7GHGRtZe1zNnt85Ps9Osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742019924; c=relaxed/simple;
	bh=nWAkIYVQP75R8U7rNTUhYN7mb1xk4mK4d5YywW0AYpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cjm2qM9ZneNMTF8I/nR5EN1NxNbV7406BFbaNZ05QhNKzCxw8qWtWihpoo9e6JNUd+CijrQwgBuIb+rKHLpgpVcL0EPjvloRao1dip6kLprOtgjMKjhjSXDRD1/ha76epa5yjwkDcySHk3hEcE3scQfuv+0Tnd3JV7i4Ul7KIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leO4yQm3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22435603572so46198935ad.1;
        Fri, 14 Mar 2025 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742019922; x=1742624722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8cTPPc6gqUNZEA7H8LPqEukzOiIdQFuKMBLubQ698k=;
        b=leO4yQm3pXF7uNwxh7lg30U2Q92kGSbw0wY7wSBKC4WW3ODaCzof/mpbqd+Mu94MHs
         qF9NW1sP3h03RrwqkQ2hRbLf88hKc0t9VRl8s65mr+kXg7dYD2F/dCmIBomRzNHK3MBk
         h/vUthYOmX5zbFx3UP+G0bKW8ooUwIX5q5IGYGL6CpmLZOs33KLlfz+UoFkFZI0qSJaQ
         WU2nZUc5k7prWkXSuLZOqO5m2H53RRxXDebFJDd452eigH+5VHmJXAxeGV9JR2dhrKBs
         GSLIKKEE2qEdlxe78D186Z+0edD1o5wuEM+pIXHWzGbBRMv3YuCc3/Q9pzVmWnQdzL8F
         7YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742019922; x=1742624722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8cTPPc6gqUNZEA7H8LPqEukzOiIdQFuKMBLubQ698k=;
        b=h0C8JaALHwV2tO0xOk57/FSdg0ofwxX9TKkz+QVsqg/pneb3HFE6JGv7cO4eIag1Xo
         RdqtUApOlRjUALxk6zN0zDsqW04msOqtx+QjGGcKnCe1ZQOLfKByE6Mmm1GgPVRLKHad
         dhCE+NY9OPL3I1q0gfnHvti8+T885+Kq2wU7wuSrQszX+fBuh9PFO5AR0beJm/lwo/wC
         Zy82aOMcM/trYfiQA78PBZYnunGnUrAdr5HSaAuc8kTyPWhIdArJhgLedqImQs5+Qnqd
         Y59RLHN8Db6kaKm/gV2aU/oUCO8RTciuYM4eBm/Ce6D28Hmc0eqfoetYwFqqxOokCmZy
         X7pg==
X-Forwarded-Encrypted: i=1; AJvYcCUGIkITU0Sui+DgbBsJSHQi4csE+DcWcr9uQbu1RbP8SO6repL8amuSbIDdIYUhG71Die+cKASbCx4D8Q==@vger.kernel.org, AJvYcCVe2X5dxnf3MPmx9BXulR6gIocEVJ89a7sC4cFKW+xBcv9yVrpR/W7LhG3WFIeQr5LJF1ZIuekkXMoRFA==@vger.kernel.org, AJvYcCWoEneimSMy0nfKHPR92YRdD3V5TJal3XBMTNPfGiVrAsow4FOh47rkkREaiE/qL6k/4bPRycILztZYCns=@vger.kernel.org, AJvYcCX6mbik9e/sKTIv/l0VOYl3flOE9SwzKGnxo1wB0pfCJxea1qj/uOYRJQ9Wip38Ytg/LQOsxfTK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2GSH8KeFm65tprLPKKIFP96EmUaV1ihqHLU2tI1a5jPmLe73
	R+GMBsBzjyFW28gCuMA3sp1mhhug80J4/98sfLdTcdhnEo4dSHUb
X-Gm-Gg: ASbGnctxOorv18YPeuGWEuOC7pHMIqpqBfwRLM2j2/m26p4w5mCQ7SbtTtKwZav90mB
	dz4mSV43C++ehr543pMNJrcfNntpvcJts1LkME7008qfJblZTxPIdsdDbqtaA9UVM4tMeuApwgE
	KKj4lx1/5ZC3qmbnjrkIOMu2hLCIYNOQEvjb5uNp6p2EvRXpg0dB7BN6oOhhlntjSvBF4PWH1Ij
	/ReKw4F1ls1DRLjnEL/jLMIvlPDO9rjPjtyAFnkzHQA/lgc/OLPcjMmZCmbvL/L+GRVk7XSd/lf
	MHBZpODmK/1kGQyQCGMlplPCrQ+tY2/wVQpBMbylnM1ntTRkWohmrV/GwE9XxMEonHE6/fk9qbB
	8hGF5b4psnQ==
X-Google-Smtp-Source: AGHT+IHSnWrNpbJGdm2Ep8MCHFb4xCh1XOD4X4acsZBmcQb4pGwIZKWaITWJI6UfHE15+VY0Cnw11Q==
X-Received: by 2002:a17:902:dacc:b0:220:f140:f7be with SMTP id d9443c01a7336-225e0af5c2amr61112395ad.41.1742019922389;
        Fri, 14 Mar 2025 23:25:22 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:94e9:cb4b:5e68:9bff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68884fcsm38525115ad.16.2025.03.14.23.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 23:25:21 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: alibuda@linux.alibaba.com
Cc: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] net/smc: Reduce size of smc_wr_tx_tasklet_fn
Date: Sat, 15 Mar 2025 14:25:16 +0800
Message-ID: <20250315062516.788528-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable "polled" in smc_wr_tx_tasklet_fn is a counter to determine
whether the loop has been executed for the first time. Refactor the type
of "polled" from "int" to "bool" can reduce the size of generated code
size by 12 bytes shown with the test below

$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-12 (-12)
Function                                     old     new   delta
smc_wr_tx_tasklet_fn                        1076    1064     -12
Total: Before=24795091, After=24795079, chg -0.00%

In some configuration, the compiler will complain this function for
exceeding 1024 bytes for function stack, this change can at least reduce
the size by 12 bytes within manner.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 net/smc/smc_wr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index b04a21b8c511..3cc435ed7fde 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -138,14 +138,14 @@ static void smc_wr_tx_tasklet_fn(struct tasklet_struct *t)
 	struct smc_ib_device *dev = from_tasklet(dev, t, send_tasklet);
 	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
 	int i = 0, rc;
-	int polled = 0;
+	bool polled = false;
 
 again:
-	polled++;
+	polled = !polled;
 	do {
 		memset(&wc, 0, sizeof(wc));
 		rc = ib_poll_cq(dev->roce_cq_send, SMC_WR_MAX_POLL_CQE, wc);
-		if (polled == 1) {
+		if (polled) {
 			ib_req_notify_cq(dev->roce_cq_send,
 					 IB_CQ_NEXT_COMP |
 					 IB_CQ_REPORT_MISSED_EVENTS);
@@ -155,7 +155,7 @@ static void smc_wr_tx_tasklet_fn(struct tasklet_struct *t)
 		for (i = 0; i < rc; i++)
 			smc_wr_tx_process_cqe(&wc[i]);
 	} while (rc > 0);
-	if (polled == 1)
+	if (polled)
 		goto again;
 }
 
-- 
2.43.0


