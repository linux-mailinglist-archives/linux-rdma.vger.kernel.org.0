Return-Path: <linux-rdma+bounces-11002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D707EACE52D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639213A92F1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E36D22D9F7;
	Wed,  4 Jun 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEwOC+9K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB96224240;
	Wed,  4 Jun 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065999; cv=none; b=t3KDUmzppJUoay9sqVaTcTkK2bJefGPhL5DtLjor+yuqN7DB28EuJjLSHzKfrvqf8aaEz71hsWkD5Ai4mWn294jTuExncKeV3+do220LPhjJM1cFUDY276phuMbhlbrwqdX3JnQp4MFV9L0Hl3m4hb7b6xzXWLg3QnIW+VV4rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065999; c=relaxed/simple;
	bh=oGFCg0J/Z5ouvwRpXSM5emXVDJjuz/SuabIDX7rLAdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeGi82aI2e490MEp5n72BNuQoKhH9gIQ0jNEas6BP0u7MAilzqNyvhowRQq4y7Yl4zvH/JYkaDv/GvcpPHgnnxeNr7Ai722ZPEFRd7m1lZO9leislWAJ3yQIojXl1LbXywOEyUqkJ2gPFQ3XQ+8StjLLq7W0MVfGgyuOj5HVKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEwOC+9K; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e6bddc30aso2956937b3.0;
        Wed, 04 Jun 2025 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065996; x=1749670796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4I2Bz3ZfW9SEL1Ccr90vp6SfH9JMIvUDuGOi2RaIiY=;
        b=SEwOC+9KFdLKJ18SAKTY3e0TaYWRtPFKSUGov5XudQ3KsDMu++LIpCbL0P1e2H1OCv
         j3/ndu9dtxMzMpJ9MJXC6xlBRlyxuYokHHCxFTNrc2NqrTQWm9zfzQFHyf/hGu8cIq28
         AdHSqG9JZG5ua8EXJZpAWZmgSPaAIaNvvuXJphHO+6ZY/2c5fCgnZYPvprY4mKGpUXpo
         2RZGz98lI44b3h7YYWtf3IfkMwrUqhPEsN5zie3dTj3WcSsV/0q2aYw4fEpYG74K5EMi
         7D364utwB5SR8geBzS3CyntnS0tDBtiVmVvxRHc/hCwS9pYv0q7Fgg2VJwLIq9vCTsZ9
         yaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065996; x=1749670796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4I2Bz3ZfW9SEL1Ccr90vp6SfH9JMIvUDuGOi2RaIiY=;
        b=FhMUBShlnVzV8OGgbFijHcDOdoHr+10WmwwmOEaSf944ID59qprzHALBL/nJxKekm4
         3HgS3NKRLSrrPkkjoa4F3ZmLF9FM6g1PB3JQiLKmuETE5LF/JI5uJw04IBvPYQPS5b/d
         C9cZZiXWjXNIdz8C6y0FByatj0QfMFZbAuM0HQbJUD+FhIsncN82BfioXVDAEGTJxw/C
         4k+4vAjwll6wS48xNdFpSDNGjpEqedBcOcdYUONzSUUsK4vdhy15BwebcIsm8vo55aGY
         t0CBqbf1mnNNjd2aCExIrU0S5tTogS1UETubvHxMS0pt6zSNhOpNKl+BUD1wc6X+aoVC
         pZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4wtNY4xypLb7R1Xpv4VcB2EHFvdjAiFue72OHpgVW7FxqDUjpgwPXeOzPBW+fKlE6IYH9qzNGdCMVhpg=@vger.kernel.org, AJvYcCUAUU5OLi6aBoKDYdtizDcXMtyhklYUE8pBu/r/NMtVWx+8j1dTf7Q9jAwEw0kXMQeDjHtN9WJaBZIwHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqb4ZYqbUPmyEUsldwez11JogDJxvUUofUFT+06VEovWJbYf8F
	D2DrzIihQaflL097J5UpTAtnBGPc+mhqQvH4xyuU9kzKN5o/LWtiBom3
X-Gm-Gg: ASbGncvBxPEEtwYao3GjmTo9sF0HAkRxNu7zh72ks+hHGwJ9zE9xSkt6HWf0ixtgHa0
	GmuFJDhD4eS6S7b3KqWwiMIXk4mMBArHGAIHbafjJS1Br1ZxFuWcd7WUSsLEALc5HxiSdh35JhF
	odBPD848zaejeYa4Q19OPlKbjt0m1vb8laDlPv7xRUk0r0AQ7LTj+F4zVXFt2cVjPtFTCycqOSz
	2Kxfn/5uxOSKdutuP81+mo24WLiryXED+cvpWmoFdCxQs4Xq/nMuarISvb0ToBg/c0Bfz0aF0VI
	qu7P4lIwt6v+iwkNzOYSB06Fu7Z6pZLI9x3qpkEfY1XDZtVfHab09Rc5SxHPcziyE3nOoVifl43
	0nFvv5wRowQU=
X-Google-Smtp-Source: AGHT+IH0TTM1N/ue4r56F37tJpMbUjpFHqUnJQwvt9Dz56+KoAOH4k/1gxcNvszFlTBnbSuZ94IHxg==
X-Received: by 2002:a05:690c:fc1:b0:70d:f6ff:cc6f with SMTP id 00721157ae682-710d99fd79bmr56266467b3.4.1749065996280;
        Wed, 04 Jun 2025 12:39:56 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ad00637sm31473297b3.109.2025.06.04.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:55 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] RDMA: hfi1: simplify find_hw_thread_mask()
Date: Wed,  4 Jun 2025 15:39:39 -0400
Message-ID: <20250604193947.11834-4-yury.norov@gmail.com>
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
dedicated helpers are easier to use and usually much faster than
opencoded for-loops.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index f2c530ab85a5..9ea80b777061 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -963,7 +963,7 @@ void hfi1_put_irq_affinity(struct hfi1_devdata *dd,
 static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 				struct hfi1_affinity_node_list *affinity)
 {
-	int possible, curr_cpu, i;
+	int curr_cpu;
 	uint num_cores_per_socket;
 
 	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
@@ -976,17 +976,9 @@ static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 						node_affinity.num_online_nodes;
 
 	/* Removing other siblings not needed for now */
-	possible = cpumask_weight(hw_thread_mask);
-	curr_cpu = cpumask_first(hw_thread_mask);
-	for (i = 0;
-	     i < num_cores_per_socket * node_affinity.num_online_nodes;
-	     i++)
-		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-
-	for (; i < possible; i++) {
-		cpumask_clear_cpu(curr_cpu, hw_thread_mask);
-		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-	}
+	curr_cpu = cpumask_cpumask_nth(num_cores_per_socket *
+			node_affinity.num_online_nodes, hw_thread_mask) + 1;
+	cpumask_clear_cpus(hw_thread_mask, curr_cpu, nr_cpu_ids - curr_cpu);
 
 	/* Identifying correct HW threads within physical cores */
 	cpumask_shift_left(hw_thread_mask, hw_thread_mask,
-- 
2.43.0


