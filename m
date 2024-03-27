Return-Path: <linux-rdma+bounces-1595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D288EA0C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8931F3446A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3012FB15;
	Wed, 27 Mar 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6XHF6ev"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3B12EBD5
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555063; cv=none; b=j9iHvm90vxh3ptqDAUn96LQO5oG9aWMtNSJiENdaPO8V3j0JKZVku61f1rscf81a4eTITi2UqtJ06zy6i8wkJ0I4DkX9CimMrQsCblG62lpKyXZ8KNLPOsSeD3xKL2WAyt9vkJ9EmaNuAZjTUGDR2OtF/+6c1+gDRWGgrnGD1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555063; c=relaxed/simple;
	bh=8iWHOP99IJh3x4cD8IHColiMPVTQtiJHUSlhmwoFscQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgvrjUokU9zcl6bZr6Dawkgoh3YfNUrRoBh5pM4sSmSWXIHv796PHdeJYnN4qThYY1iOXhaPxdMdOp3eEhxclQruFUzGmP6lERKwV591YZ9P7VWkGaBf58cm3rwMmwlPALoKVXQf5ZNRQTZlmv/9CyHLflLXY6KvwqCRzMgcHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6XHF6ev; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a470320194so3530117eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555061; x=1712159861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5LQvpPsIQNq+n9+JoELgdiMziRukkOmYY3wjmCQ26g=;
        b=S6XHF6evpIMFeHSi8fB63qGH0cdpP8I+SAYbwHcJ+zUDbFORWS1qexIpkQiDBaYb1K
         +xlwfjREFC7bYHU1wWDpIqN/V4RK78Jtl0wG6kXeUqyjICPRtyThdSvu+SiniQAo3br1
         MqabZy09RtX22jXvf9dcGg7iu7QZcP8ds8677AFVSn9czJL/34s4fYgozCOTeJKT2juo
         A7HY/7Xh3fMjJpGXMr44E2v7M8ogAr7dzmmTPqnbFa1r3sBMr67ihAf45hox6XbnXazZ
         rMNZYHKOo5sjWDZyQ/NHXMVMGPMW1sHw62SrQwMsXddbkTNX7laUnwwJSiJKgo1lfrv1
         CVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555061; x=1712159861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5LQvpPsIQNq+n9+JoELgdiMziRukkOmYY3wjmCQ26g=;
        b=i3R3qu7wW7JBbockwvNiyEsdcwY97HRkJcOE4xrlz1JOy7gyr5cpMuGQQIRu1ytetr
         v8gDYCxS994e37y8hL2bC/3t5pzE/vM9jCiCYVAalzJU/X/M1afpS792XMWofRVGy3RH
         xNWkyybZ2RREIrOIkKvF15jwUkSVfidx1rjAG/v9/stPfjhMwxh0oVtJi1Asu/hGyxB+
         1tltNriFo8eDvwFQ+RPDzSrOvwwm8B7o42K9wibT/1kcN8ZGzix5BqIWl4hXQFn6K2VT
         DsM18tryn3sPvtS3Rc81mmbj2c0KxiC2RIqXoRKzSRdrDni6hBMB4s9lcH03u8jBhs/T
         uSsw==
X-Forwarded-Encrypted: i=1; AJvYcCWRILaTV4FTRoWVv71n+8BkG0+PezjPLxDTjGJMLFUhdJxCnlWiFVuArnpTNV3mwv5EQqGsBMs4rarGpMYSAV8Zf8yK2pA758l0gg==
X-Gm-Message-State: AOJu0YzJAfyH11C8w3aFFf9EvjmjO+Y25wmXqZSz3p2faw3oy6a5A86n
	6Cr5hW6VtWMktiygSAZa32QBYH29pgKueeQ2mu3XYymDHj4qEixG
X-Google-Smtp-Source: AGHT+IHi/E/9fos7Y0p+tGJEg36cAiYf4QWgvR7kTZ8LllV+jq2sJTqCwT9cfmRcr4T9PzGox8z/VA==
X-Received: by 2002:a05:6820:a0d:b0:5a1:c19d:bd39 with SMTP id ch13-20020a0568200a0d00b005a1c19dbd39mr534097oob.3.1711555061749;
        Wed, 27 Mar 2024 08:57:41 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:40 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 03/12] RDMA/rxe: Remove redundant scheduling of rxe_completer
Date: Wed, 27 Mar 2024 10:51:49 -0500
Message-ID: <20240327155157.590886-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327155157.590886-2-rpearsonhpe@gmail.com>
References: <20240327155157.590886-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_post_send_kernel() if the qp is in the error state after
posting the work requests the rxe_completer() task is scheduled.

But, the only way to move the qp into the error state is to call
rxe_qp_error() which also schedules the rxe_completer() task to drain
the queues. Calling it a second time has no effect. This commit
removes the redundant call.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index a49784e5156c..71b0f834030f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -907,11 +907,6 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 	if (good)
 		rxe_sched_task(&qp->req.task);
 
-	spin_lock_irqsave(&qp->state_lock, flags);
-	if (qp_state(qp) == IB_QPS_ERR)
-		rxe_sched_task(&qp->comp.task);
-	spin_unlock_irqrestore(&qp->state_lock, flags);
-
 	return err;
 }
 
-- 
2.43.0


