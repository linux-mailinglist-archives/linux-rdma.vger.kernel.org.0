Return-Path: <linux-rdma+bounces-1671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAA892017
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA931F28CE4
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D414B08D;
	Fri, 29 Mar 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCpZLY2X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5D14B07A
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724155; cv=none; b=keBUMg3frRPSvEj5JeA3Tzi9V/oGHQ4HSfmhscwABKSrYqd/TRoco2o2kMChhq6PbE2DSA9l02UdSb58O6pcQ9PwhJTyM3q7c1WDjAlrJ1VUOFi9wwFHLeTiu30lcDDAhnLD1s0l7RB8/tViMIeZtgdcLYy6kxF5NsMG7CDZt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724155; c=relaxed/simple;
	bh=OgClSkZM6eL+vERrw/+EJ7tK7V2p4YmhFAD6CV9gxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX1x88fnN7upIpdgLE2zlMCDx4h7ZAzK/38+tSnBG1lrw2+A9M89BJN+ZZbhqRQKjz6tzK37HS3i80QJBZBgBHXLLUkJg+EFoTBm9ucHb0ekOtyNYGnYXEMHP7/sCtVZ00fMTn6cwit6lB+Jd9BE04jPVKZ/Uv/1Xq7Q1pPyhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCpZLY2X; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4817189c8so1303657eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724153; x=1712328953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/w/TqH3HRW65DzoIY9Yp9OycxO2wAP6KUspzBtAQQiA=;
        b=dCpZLY2X3p4/RAk30oId6DEYJ43POB/tX9LZ5QYqxkmB9ltAc1WmSaiozhSV89gGK8
         di5WzX3DbgYTpTyQYUd7jBMEP1kqVeHGXup8dtzYne7KJKerYGXlBRxxXNa6hJk4cgLn
         aaA7aLmHR0SIlarl8UfcMcVhJyMsZJ0QIcstHDMZM+RTEEMtFI+dAr8eNmLKvcWzge9r
         m3RdxKmUMjmtDjz/BCjpVgSVf/n0uBfgtmXnrapNTZp43TG93wAsCImZqR79H+TN3e7k
         L7j/QK+3CjKZXPXA8CmE7RrQYJTj7WL+rRL9JfxTR5F3pcAkWDTIpCFlD1IFIYRC8e9S
         50cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724153; x=1712328953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w/TqH3HRW65DzoIY9Yp9OycxO2wAP6KUspzBtAQQiA=;
        b=FP2iZ3xZw1cQNOHBOhMkHKmqzGfSNsme0a/LRjS+v8eebExGTkcg1EcN1JiTm6BOqj
         6NmCJWoX4EBfRpfhfwOX4jT45bX9qlnbHhv/j9nc4nIG3Oxc7qLVUtp8YZaiusOeKiXI
         YrIcJSxlt7Rp6GFjV1e0MEr9VLKMOhICVpCRZil0KozVKn2chZUws0Ybim3trk5C37uB
         z1OyHQYMwas8iTgzUdtjgKfu3RRM6WHgLD0Knz85qvi3wAbgHlwgItxzBVO0P2YB8mdm
         +XtmVi/cd1UODzXZO7xDVHQ2KC+BN9L4jpWw5VTsSJemrItE5wLtVxIce+U7IiF1mkQX
         Ey8Q==
X-Forwarded-Encrypted: i=1; AJvYcCURVI4MIiSRRKmIzOYovGWevYH9Jf5MYJIuFlUBxxRYpO8r8fao8dR8I4DmEB2E4P2cItqabC4wZTB0I5Vuyuw9W6VCqPwCxn322w==
X-Gm-Message-State: AOJu0YyaFwWP5seKmSgESfFmAruYYUa+d4OfCdOb21V3ifMtWQLwwXOv
	/+3YaW8MGh3G/BfXPbe/ihBXKY/pfnw2NKT+JE6fphaLg7XX4aZLknq7NPA/+b0=
X-Google-Smtp-Source: AGHT+IHxIAI52ySVo9eEz+0Q59IX569s9rSmqgLu0Z3pTUkc2Q2KCeyPzYdWFHdwuNoZsW3Bk+5P4g==
X-Received: by 2002:a05:6870:a925:b0:222:69b8:44c6 with SMTP id eq37-20020a056870a92500b0022269b844c6mr2522033oab.9.1711724153590;
        Fri, 29 Mar 2024 07:55:53 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:52 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 02/12] RDMA/rxe: Allow good work requests to be executed
Date: Fri, 29 Mar 2024 09:55:05 -0500
Message-ID: <20240329145513.35381-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
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


