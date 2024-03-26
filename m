Return-Path: <linux-rdma+bounces-1571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1188CB2B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D6EB24D83
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB311F934;
	Tue, 26 Mar 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIiFILYR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F7A95B
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475078; cv=none; b=P5GAuYNgd3vvCtCh4HIy01+XtwPVDo11jfomy8v+sjS3XKn2crYJ8FrNSVHJwth+DCS3sralC5rXNDlrESGGGmYonKpS7nmTQnVnmMNpN6kNvUGnEi7BwQt99tJOQrHwdVpQgXd9iOnMXgQ6aXI1V8/LOaNm5s6MuLHJZtWdUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475078; c=relaxed/simple;
	bh=8iWHOP99IJh3x4cD8IHColiMPVTQtiJHUSlhmwoFscQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agQVEhodJn0E52juVdnRhfe/tmcq6h5BgN1i77lC8KWzpOqebw3YWuh96dAQ3rfkIpPMmRJozXqqmtynLZdPsD/qQD/WOoTYDdg1BjGUi6evIXq2E++JajJwxfQId45GqDQRHzTu23DP/cxMv4ovL4KEvqXThDVAWExZV/ks9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIiFILYR; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4f9f94e77so3295213eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475075; x=1712079875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5LQvpPsIQNq+n9+JoELgdiMziRukkOmYY3wjmCQ26g=;
        b=mIiFILYRuxgEVZJVSB5EFpOqRrxU8qfVWTVZVaIHhC8kSo/2aegbQrUqZymZxpgfhz
         QOVMlK0FQvylEQDwEZCkCxCANt7NmOALO8AoLTprPLpumOw/V6kPwHueTe8gZpHrHX7C
         TmEglGiuSQfiNX6X0v1zPXMJLD5rTqkJo5N041gHO6XkoL2DscXgJ7A3xAagjC4G/1Tt
         8tyGrjUDQ+DoihvwunG2MiksBke1d4WeFCT7H3ADs5juUPxwYv5DMRWx43TZTovLDmiY
         PYRegzG7U43zbPXY5aZ7maXEHmzHzD1D2H1rTRXcu4wfaCn96DTgOgqbZ85sEepaNIpA
         ad4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475075; x=1712079875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5LQvpPsIQNq+n9+JoELgdiMziRukkOmYY3wjmCQ26g=;
        b=O47ag+BBZ9SS7/PSsZzIxv8C5/LjhoxU7wF7kFUS6TxllLkg9QDsFJk9RnUg7aBL/A
         2UzgAQcHcZudRiQjZiNpUI7lrHyo+cNHSHrCgMeK6s7PV4KkZ93PCj3aHbKm61lvXdxu
         +NB4N70YF3AFmEglawqTuSwmtzLeZwQfiieBAcbkVgKqeG1sVjFJTLibb/mLCNygKebC
         Up7BigeNJT9bBlMfC8P6QPcU7O0hyzYNcJl1YZxsJRUZaTsUFCv20Kl3HyCZn3wRaOgO
         9QwriXXanu2707W5SmIC33XhsGapiL42oxjcIJkuZ9O2GgwVnb/ZjPlVBf4NHVCjRDkK
         0uxA==
X-Forwarded-Encrypted: i=1; AJvYcCVm9WtykcmhFNTQS91Qszaao+bgUhZa9/NZ1q5/CKTo2DjV8R1h6h/3a3dy9ZwBRDyyg+RILbyXHuq7C3isXxJP4Gm/GJTwsiqIbA==
X-Gm-Message-State: AOJu0Yw5tYKHaGTulmOEc1MSzumMGYE6a9aXTh97NUSXn1v8QIhvaV2r
	eQB5SCgHrI43MA6hH03BhxS8HHHouqO4C4ce51s+eptuOMFKy3SK
X-Google-Smtp-Source: AGHT+IF6/g7/u4xLrUCxs7B3zJZJMKcjlprVrK6CVaBDblVN8bxCpgmuBnC5N7J9NG5qeq0No2tLJg==
X-Received: by 2002:a05:6820:c91:b0:5a5:25b9:dec5 with SMTP id ei17-20020a0568200c9100b005a525b9dec5mr13899545oob.2.1711475075659;
        Tue, 26 Mar 2024 10:44:35 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:34 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/11] RDMA/rxe: Remove redundant scheduling of rxe_completer
Date: Tue, 26 Mar 2024 12:43:18 -0500
Message-ID: <20240326174325.300849-5-rpearsonhpe@gmail.com>
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


