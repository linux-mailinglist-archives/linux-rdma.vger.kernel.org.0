Return-Path: <linux-rdma+bounces-1570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C528888CB29
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8115A3082D3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C7C1D556;
	Tue, 26 Mar 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkKWrMAi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A01CD2E
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475076; cv=none; b=IE7AMASOo4aQuTmvUSJTEaF6oe1TRYcLjUug8plZjd9Wr7za3qv9p3HCs03rN9LPz3Kd9KWL7tHz8DBz4WwFmkkNG0tN7QaGyIoSysg1pWeZfcx1X+2mdffRybUFzJa4VOKAFHCGoU3SBo+Nwp5toNIq9YHtP6Neiyo48XIU5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475076; c=relaxed/simple;
	bh=5x9PCYW59Lr3fJH9xBveiwjcOtBI4BdYwuPrh/imGdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq0BSZv5w3zf9TG/9Kd9d1a8/Db34l0NEj+KSeY/Xj3Vp2PIQmm8/vf8pIJXwlaK58XXOM5lLfTfMXip8/8W4TQKBMNRvtMQVICxPjguqm9BMx63dgv07W5oOk41mew7ajG0nwRWKrYG5O2+Iej7sxcJkI8xWac31cMqljVhrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkKWrMAi; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a128e202b6so2052657eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475074; x=1712079874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPi8VLl2TsTWkZrmNx2iayh53nzskgRKcijh4znhtwc=;
        b=fkKWrMAistxCLWFZ3XjBMxZzghQxuPco7F08jrwUdP+G5L7SpsNaB/iL4/jqYFyj1X
         u/VBSxVBq555Sl5XalYZb+tw0K5nYz+2RGJGhCjaT1qtHdPDwfSckWcUlSh04GlPYtgM
         FQllIujfr/Pt4OooLPdkk5A67Yry1cL2WTTg6iF69sOceTZRe/3f5CWsa2a+Z9/PIF1a
         ypiEa2mWEQ2urfJBKDOH5CbcCcU3OkSj+5Te4JtauVHjNUYonF//Y/i3f5qXxI9dQ6gt
         dUcN1nNHQ9wOLxq0lPxwgTAo9G5r0Ifi1osJ0Bsq3KeaNLL/VzC40V9xJpZa5kLlE31E
         K1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475074; x=1712079874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPi8VLl2TsTWkZrmNx2iayh53nzskgRKcijh4znhtwc=;
        b=lPcNQAho654VzCxYXeIg093wwv2ZbvrrsM3KkVgm9IPbZp6N8Unmy+7Bu21daWkpRc
         8OvVr7EmQZ0rYmRtqbTKmjcx7mxRi3SBXSqd3LSR6eHduRqrZs/PNuxPz9mlHlG9dVgt
         zh5X+kG5wKvvFCFi6BHkGSaSwyBk9JPO4/8MGrqOlTb7la1lze/CI6lBmH4dWYYyE5Zg
         Xp4veHkT9JvfhRyfOE3Lq03DRkyLPd4zxyJVakV/qti6U1ywylnP0QPX1O9mLwOG0rWv
         WvxjySYXbZ8nZVgiHEcVPptCW3htpFY4J5jdKttNNgw/IQAcxaRNhuQtLZc4QZ3g2Re9
         fgCw==
X-Forwarded-Encrypted: i=1; AJvYcCVntkrVq1dFaoC4jdrN6SJrrABb+GAquMw7ip0kUNEJZVmgb3CSlzL1jFFYPSHb0PzVqKphBW84peA0+1p2n096r+IdBKUbo4iexg==
X-Gm-Message-State: AOJu0YxLJySRqmc2Q0QkKAvp+emcejSsRB2gCxwFAerQeO5vt6X0k2mc
	4j2bpoMn9ZWXQ7BPyaI+A5sLySJSlnZ6v6DaJFvCtofuekZwP2fhlbqQHq/GBOQ=
X-Google-Smtp-Source: AGHT+IH6x415UVrQ6VmRk+2sZoNXCgmcZKg1GIKV5pkOJHui312GfEUiiTM5Woz2ozkZdgxBRWznJg==
X-Received: by 2002:a05:6820:20e:b0:5a5:23fb:4493 with SMTP id bw14-20020a056820020e00b005a523fb4493mr10770179oob.4.1711475074469;
        Tue, 26 Mar 2024 10:44:34 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:33 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 02/11] RDMA/rxe: Allow good work requests to be executed
Date: Tue, 26 Mar 2024 12:43:17 -0500
Message-ID: <20240326174325.300849-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326174325.300849-2-rpearsonhpe@gmail.com>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit incorrectly added an 'if(!err)' before scheduling
the requester task in rxe_post_send_kernel(). But if there were send
wqes successfully added to the send queue before a bad wr they might
never get executed.

This commit fixes this by scheduling the requester task if any wqes were
successfully posted in rxe_post_send_kernel() in rxe_verbs.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 614581989b38..a49784e5156c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -888,6 +888,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 {
 	int err = 0;
 	unsigned long flags;
+	int good = 0;
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 	while (ibwr) {
@@ -895,12 +896,15 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 		if (err) {
 			*bad_wr = ibwr;
 			break;
+		} else {
+			good++;
 		}
 		ibwr = ibwr->next;
 	}
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
-	if (!err)
+	/* kickoff processing of any posted wqes */
+	if (good)
 		rxe_sched_task(&qp->req.task);
 
 	spin_lock_irqsave(&qp->state_lock, flags);
-- 
2.43.0


