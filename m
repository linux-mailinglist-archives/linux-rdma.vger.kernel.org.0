Return-Path: <linux-rdma+bounces-11003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D074ACE530
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E141891B1C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63610231832;
	Wed,  4 Jun 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDUnSH4A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A822A4EA;
	Wed,  4 Jun 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066000; cv=none; b=GxsTgyCcVKZ6O1ukpUHc7slZblqOZkixKapI8VkJsK6I6kNHQzuKQ8mmVM4fbzZN0Xrr3jV8DErBTu7pGEAYCo8Hv7jwAru431v0a+Jb5a32BUjP0RDaMx8Z6zvT7PrWMb+jD9t8mU2Pl9x/tDpo4yYJJrB9BWEOyJzfcB5+IK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066000; c=relaxed/simple;
	bh=fdlMxrWrqPg8wfQKTYPJsz7i0ts4zXCT17a8KPSe6so=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je2LfantEA5OmrLqToZ5EE3cU8/gJn6e2tmlxfImUJ+yYTK/rSutXdD0SYSJOPe/HMsI+dHTezjo6TbytQNh3klhT0S/Ny5nAXGxnuPyQCa6GlhRXRJ5OYQpxCKC3OLvR8gCz9NuJ6IQRXBxt/88LXc02qGkC3ubU08iCszfiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDUnSH4A; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e23e9aeefso2085047b3.2;
        Wed, 04 Jun 2025 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065998; x=1749670798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W164iHtS8OogxzrMF1ZiWRrGDfnxEQGSfT/uh6T/EYg=;
        b=LDUnSH4AO5tkv+NY4iy/ymVU3CZ8tBwyCPPxB4fgx+xtM84Mm5vP1LVqSgW7lK4VK+
         acSYBcqjiXVCT/1WDlgpU+TKfZZN+yfpl71nkKgT73hpsmU9oB0jPyH1NsqPtGSaqfax
         TYRQsVMxi9Ed8/BIdsi0ka0YxYlPueJwsFWe9PReYanYX2NCknYuHOOSKD+dfkpbKBPw
         m6hzopNwj9kA79XTUQJZJp25G5o+IqvpjVVZmfGVvWcbxQMishcgaBld4nWcoC9qzw4+
         Zj1KNAUh4QQrH1OsWb5leuFem7T6r6UE+u48WuTXU9ocvUvywO5a3/6Wlcr1prhOHfev
         Ofrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065998; x=1749670798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W164iHtS8OogxzrMF1ZiWRrGDfnxEQGSfT/uh6T/EYg=;
        b=O0U1AsWrcqdbAGaMEKmZ+R5678rBD+Ab4rfmESE2RAuQNxEThj0jBpl3WUyWSnrPrJ
         0Bt7zoAQRzjR/IncuaW8V9qaStdsaZjb1sIPrQe4ac/Sc5it9TupnAQqInycrcpybrIi
         71AvEQfmvjJ1TVnNIIFxhRpiCizFso/To8nff7CX9H5QQfEvcmdcciCmFVPfkn5ih8vN
         fq7IaIvsRpm5epKhmE/GUfbkxEEJwspMAk6PSMnWOYlAr9ZMeSQQnmkgiim7gcuGJGOZ
         o6SJtwwVuWpfm0J+LxN9tBFh+kwgR5W93e/dgAawBQDTQA6tTGQ9JFou4rL7z/9olKL3
         f+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFyQDWXDYqeAp5teHsMGX8C8hjo3813WIu2vKdP/6EyK6RCNdMlFtLwjYWl0AEfpVrNaUtITCuLqTJrE0=@vger.kernel.org, AJvYcCXOKRbyuGZOZfbNDcw9ZYA8xWHquY8iMIQzveuu9nwi8iglzKDL1fu7ypw/5ZOCThRbbbr3ZF77/DrDkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhO6zd0WacRlJIp7vXe64B65DeGai1Nj7iCFTDC9SH3n4WmVy
	AABebyOdeyLsDbofLbSRtespb2IOdIJnmhkLJVbnpuLkKjTOSfXpmv3g
X-Gm-Gg: ASbGncu0HtPAeFyjRg5AewONcieM9DFKijJlbkvQ3Jp+ucTsh6dEbCYjwKUOLW0sO2B
	OY17pBsm3mthCUARSyLsqDvt/4HjIq0l5KCtjhEd0EoN7FlVeRy1Onmy/HUd38C1p3IeEVWWWWH
	QKRZ7NrqDAC9EOFF+tvRTm4w2ScDzONsiCeWd3fwxR/zsGQUVTtomv2rN6f/RvBTMbMrzuRJ9eK
	mOp3DMUsIZ56RKl8ZhLb+iliXn+jaZ3CeF0epFYXkmw654xMZdWTgkzVpmEI2gig20LUIYpioBN
	VIDjZmgrKLFeAOUgpQfeQq5rwu3pyZyAzKt3UwMH2l60n55qIpVqTm1RPnSj7ZCKmRR4nyJW229
	UJQ/gEx1dA/8=
X-Google-Smtp-Source: AGHT+IEeePTZ8YEfFgEG3z2f910W63Ne+F6I2OoZmIUOGBvIiqJZd5atotfItjr4HUs2F1UsNR0IRg==
X-Received: by 2002:a05:690c:4b8a:b0:70c:a854:8384 with SMTP id 00721157ae682-710d9df47fbmr62223187b3.11.1749065997614;
        Wed, 04 Jun 2025 12:39:57 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8abed254sm31170997b3.39.2025.06.04.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:57 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] RDMA: hfi1: simplify init_real_cpu_mask()
Date: Wed,  4 Jun 2025 15:39:40 -0400
Message-ID: <20250604193947.11834-5-yury.norov@gmail.com>
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

The function opencodes cpumask_nth() and cpumask_clear_cpus(). The
dedicated helpers are easier to use and  usually much faster than
opencoded for-loops.

While there, drop useless clear of real_cpu_mask.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 9ea80b777061..b2884226827a 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -92,9 +92,7 @@ static void cpu_mask_set_put(struct cpu_mask_set *set, int cpu)
 /* Initialize non-HT cpu cores mask */
 void init_real_cpu_mask(void)
 {
-	int possible, curr_cpu, i, ht;
-
-	cpumask_clear(&node_affinity.real_cpu_mask);
+	int possible, curr_cpu, ht;
 
 	/* Start with cpu online mask as the real cpu mask */
 	cpumask_copy(&node_affinity.real_cpu_mask, cpu_online_mask);
@@ -110,17 +108,10 @@ void init_real_cpu_mask(void)
 	 * "real" cores.  Assumes that HT cores are not enumerated in
 	 * succession (except in the single core case).
 	 */
-	curr_cpu = cpumask_first(&node_affinity.real_cpu_mask);
-	for (i = 0; i < possible / ht; i++)
-		curr_cpu = cpumask_next(curr_cpu, &node_affinity.real_cpu_mask);
-	/*
-	 * Step 2.  Remove the remaining HT siblings.  Use cpumask_next() to
-	 * skip any gaps.
-	 */
-	for (; i < possible; i++) {
-		cpumask_clear_cpu(curr_cpu, &node_affinity.real_cpu_mask);
-		curr_cpu = cpumask_next(curr_cpu, &node_affinity.real_cpu_mask);
-	}
+	curr_cpu = cpumask_nth(possible / ht, &node_affinity.real_cpu_mask) + 1;
+
+	/* Step 2.  Remove the remaining HT siblings. */
+	cpumask_clear_cpus(&node_affinity.real_cpu_mask, curr_cpu, nr_cpu_ids - curr_cpu);
 }
 
 int node_affinity_init(void)
-- 
2.43.0


