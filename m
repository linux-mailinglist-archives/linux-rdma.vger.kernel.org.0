Return-Path: <linux-rdma+bounces-1594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2DA88EA08
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A4D298D1D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E512F5B9;
	Wed, 27 Mar 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSikDSGl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1A12F380
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555062; cv=none; b=vFqGg6VMi5K5S/TZb6aJ9jkbkehAFbmPe96tfe6cdS4jXydZDttgztZIqBbLgsJrFgVgA4IJo+xrPW1xANxWcG133yqaF2QF1RCPXh7suzFp5+xPB29TxAfHSizAPyi5SgA7iVwwAx9J3GynJI29cNwxZsmj3CEkZKKdNgQdgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555062; c=relaxed/simple;
	bh=OgClSkZM6eL+vERrw/+EJ7tK7V2p4YmhFAD6CV9gxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhU4OS0AfPFeyK7jk7ewTdYzF0NhrP+0P5+HMLsTynopeR5+qakgJ0Swpa6rcghoB7xnujTuduRIKBSagW/DpD0ZFitZuFbeDr4BAC4kifgw/VUXaWddB65yFD+liLIbHX5UewHT6y+hjOrmcQbb1SVz+hixVMQ56R2HIPiwgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSikDSGl; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddca59e336so9596a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555060; x=1712159860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/w/TqH3HRW65DzoIY9Yp9OycxO2wAP6KUspzBtAQQiA=;
        b=OSikDSGlbwb78axzmV3f9SUqjmU743vwGu6mHkGDZb6GS1B5DetzfUONVmaNH0AWO8
         fhCjCgSnlLl+hMlIiqFTc/W/jMEaxHmfgjnI3638H+wLt3PbWg/CTDLDD5sDTHB+OFB6
         8PPKfOAHUHnPAPMW33KX1+ma3LF9m3zChEHxLH3dSDv7IGwIo1TuebvZRWCSvr9BgM7X
         KOCnDL4rDstalTf9aKjMr2FLI7kkbqVn/4DGhbbdexgR1vjexrP/0+P7XgMmDE/89iNv
         yMjp5zF9QVs6GZ9dhEAt5/qzaSezMtNGhVaBahz6DcvVPanzOZANeJOHXemtCg5CLbJj
         29vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555060; x=1712159860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w/TqH3HRW65DzoIY9Yp9OycxO2wAP6KUspzBtAQQiA=;
        b=EFdEjFGLrwLc0fxRzRZi6BNQ2NxAanpzJ6GJsegJwKjxpHdFh55sfgJyZGfrGRacfk
         yqVToyopJBgf8uz9wYoY6k17cSd2V9YqdQfnZo9cAGgDj1inTL8a3Tft6CKNO3GE62F0
         6r7WdX7KUJrfnPb63RhooZOssr3eY064M4AhpkpRtVGWnWA4GXe0IQhX6nk1JaicMveU
         yYVAJjpJInZLxMzK5Of+yFOekRZwyzYg6OKEe4/L+kQYp/KgaBd7z2WrOhIbp0sZWGES
         5WGyNWNKHbyTP/yVWSsK/pML2PWvJCHdiqtMsp/IEZq5aZmNxIrUJ5yCh0kKzRjrHL2i
         asUA==
X-Forwarded-Encrypted: i=1; AJvYcCWwydO79bPeMtZoFk7A1NR9JhDezBGccQM6iRlwJmNPdgh7W8Hdez90u4V/OlX5gxYyfhgafragMINbrrmtK+XLKsI80KAoMVq+8A==
X-Gm-Message-State: AOJu0Yz982i9qQndefGMuylYl8kz+mR/RgNygGgkZ5d3l9yr30gU35ls
	GwxMq2PsxZR6VMYSGN3lKG5JZN9yz1JB6mts3MFpNlKaubheRoAf
X-Google-Smtp-Source: AGHT+IFHDRbI/z+DyZ0bZ1aA7xNChanEs/ANRHkQkLYiNR6VAHy7Q1wApZuD99Fow2Ec07BJfL8Gtg==
X-Received: by 2002:a9d:4b0a:0:b0:6e6:7d3b:50a6 with SMTP id q10-20020a9d4b0a000000b006e67d3b50a6mr2328otf.6.1711555060454;
        Wed, 27 Mar 2024 08:57:40 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:40 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 02/12] RDMA/rxe: Allow good work requests to be executed
Date: Wed, 27 Mar 2024 10:51:48 -0500
Message-ID: <20240327155157.590886-4-rpearsonhpe@gmail.com>
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

A previous commit incorrectly added an 'if(!err)' before scheduling
the requester task in rxe_post_send_kernel(). But if there were send
wrs successfully added to the send queue before a bad wr they might
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


