Return-Path: <linux-rdma+bounces-11005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C0ACE536
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EDA179516
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F423507B;
	Wed,  4 Jun 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi0Mv2Gi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB323370F;
	Wed,  4 Jun 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066003; cv=none; b=QNP08yVnwW7yMSy0Y35l07VkhKwZv8hM+ENDTs9y3mP712wnqLfQFdspczXq3mqSGj8JQ5//ZElCoQKKXMdysu7BalJGURcBKZgme5MqB2ElAFXgo6VVX+c9VT/uo1enkoaZzhXWJ2VdesDZ/GIsm/sOFWQ62oNXlIwWVpQPff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066003; c=relaxed/simple;
	bh=MIhYYerpHajYvheCWKIv8Y4X1PDOoAE3QIOCxTs5Frw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNnBigG512YSXCvY9sPOqbWuMovHSPzn2LO6Go7ldF3RSMlHXTgaEStVYPR1qx9f2yvrPbqAzO7wUauRD8aZIgqaz0pO0tKHWIykTVUr1tMABueIHRWjbePPIVK1kBwPk+eUycFT1HhujqNBHmSTFV1rBENmlKS0fSC6rqhuAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi0Mv2Gi; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70f94fe1e40so14849607b3.1;
        Wed, 04 Jun 2025 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749066000; x=1749670800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDOaohN/0lM/HKNz/0q/mSwu9lg5mfFLnFFub3FhmQs=;
        b=Pi0Mv2GijYLHER9+aJvXGUk0RWQioUu1L8CI7pbeCTYZ/0xNOctaB/gs+7vUysuOpN
         YnOfPbQu1OJHtq6Jg0X/wg1pMmhBNvT2LqSzpiLlVP/zVSs1dwLAQZ+22oGhiQAhpAGH
         2a8B8TpOnj41D/RvA2fGKXAa0rWVYqScr4Kx7Gms1Bkcyf6guXec6A3gtkaAvlRf8B/y
         2qTNei/m/R8zSZmMAGlr0Mj33cNQJIz7eMyLGrD0/quShqzckTcCi2v4u3tT+kO6LQBU
         W24vTDoDKGH1HzimuEImP2CCXn4a10pSRCV7v7A8GPK8DLrauLNhhtvxvfEbcX5P+qGP
         LTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749066000; x=1749670800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDOaohN/0lM/HKNz/0q/mSwu9lg5mfFLnFFub3FhmQs=;
        b=d/TMMvVLtBpY+80rpG8hes6C61FMEUdNZjn9fWq48SmXMoJA2rZLv5eDTfSkNlMzJt
         9eDo94P/fvBmZFtvZuklZ6Ru93ofNsa5v8bPSSlNkGe4UXvx2WGL2bM/nYUcSmzOzl7K
         RmsvJ5VpAs4sH3FT/Pt5q/ct7C45DisDX4iHj1+uYGJYvJA0OfNhXxcVCJuIhPkp0WLy
         LyntxRA/oavRzLndSSNDLBxcGkDjt5sBWpl2plazlQrwNhH8pZlB20v5AUvtY4eMUTQq
         9u+Y4x7wtUq7oPJwm1fM2cCbQDolRHPF/adyVJw7DHUWHZn3UsZC0vGxpO/YlZHS/p5x
         Sr+w==
X-Forwarded-Encrypted: i=1; AJvYcCW1APJSPHGJsL+L7czn5PzGQF4nsG3wBUCTbJejakzcaidT/5iJZGOTeH2edlPhNHkO8ySvXgtcLGGjtA==@vger.kernel.org, AJvYcCXZ+keR72EXu0a3Cq8UiVtqGSholih6WM6d9Ygjt5tV2iV2oux2fXr8mCO26cGnFHksvB6DydydXbrl8ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1365f5icCk3JRWocOSOw4okBBTi+t+DaeFm4n34jAy1ZQCyov
	K3cuUVNicCAQrnbt1F9fk54P3Us6LG9s25oXaP9XQfX7QJutnknzpJJ0
X-Gm-Gg: ASbGncsTXgY1mqGO3b4VZTQoMe0NfIov7v4X1zjYIePK5VhUay9Q0Pu0/9vFRFhHLOb
	au+fNqxu7ghR9DqjlpXiLaEGMyAMnqjZr6kUm1K3CzXEL5rzxFZ4OexfsQvX/run6YFjduNogQI
	islcy/ahQ/cYesbQgaOZNwKijEhDP3mrDbFd/XYuzRz4R7A3AWpDJ9hFLvYwMK6RJgZfl+ZRK5Q
	U4Eqf0b2VEOv7kjYLuEmcIZL3UPz3hV5HmJhrDC/9+Z8u0VvetKI+gggeq4TsYO2iqo6nndoppm
	l7onwjEE3YxL3znHlwFKRLebpSbmw2vsstGypRgj4vcSpf6NZb8FZIT5QyhhLij6Eov4OTeWUGV
	iGTfjGMzC3Hc=
X-Google-Smtp-Source: AGHT+IGK+BqJ1B8gD6QRGEzuv64zDg1s+DsjlakjVCGWVSQlOuravBEcZObRW0kjpTfCjxDCVvO2qQ==
X-Received: by 2002:a05:690c:6f07:b0:70e:7f7f:cfda with SMTP id 00721157ae682-710e7e2df77mr13839807b3.10.1749066000450;
        Wed, 04 Jun 2025 12:40:00 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ac0d92dsm31213747b3.58.2025.06.04.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:59 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] RDMA: hfi1: simplify hfi1_get_proc_affinity()
Date: Wed,  4 Jun 2025 15:39:42 -0400
Message-ID: <20250604193947.11834-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193947.11834-1-yury.norov@gmail.com>
References: <20250604193947.11834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

The function protects the for loop with affinity->num_core_siblings > 0
condition, which is redundant because the loop will break immediately in
that case.

Drop it and save one indentation level.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 7fa894c23fea..8974aa1e63d1 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -1069,22 +1069,20 @@ int hfi1_get_proc_affinity(int node)
 	 * If HT cores are enabled, identify which HW threads within the
 	 * physical cores should be used.
 	 */
-	if (affinity->num_core_siblings > 0) {
-		for (i = 0; i < affinity->num_core_siblings; i++) {
-			find_hw_thread_mask(i, hw_thread_mask, affinity);
+	for (i = 0; i < affinity->num_core_siblings; i++) {
+		find_hw_thread_mask(i, hw_thread_mask, affinity);
 
-			/*
-			 * If there's at least one available core for this HW
-			 * thread number, stop looking for a core.
-			 *
-			 * diff will always be not empty at least once in this
-			 * loop as the used mask gets reset when
-			 * (set->mask == set->used) before this loop.
-			 */
-			cpumask_andnot(diff, hw_thread_mask, &set->used);
-			if (!cpumask_empty(diff))
-				break;
-		}
+		/*
+		 * If there's at least one available core for this HW
+		 * thread number, stop looking for a core.
+		 *
+		 * diff will always be not empty at least once in this
+		 * loop as the used mask gets reset when
+		 * (set->mask == set->used) before this loop.
+		 */
+		cpumask_andnot(diff, hw_thread_mask, &set->used);
+		if (!cpumask_empty(diff))
+			break;
 	}
 	hfi1_cdbg(PROC, "Same available HW thread on all physical CPUs: %*pbl",
 		  cpumask_pr_args(hw_thread_mask));
-- 
2.43.0


