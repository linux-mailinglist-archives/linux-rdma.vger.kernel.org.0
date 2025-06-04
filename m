Return-Path: <linux-rdma+bounces-11000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A0ACE527
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843BA18827BC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA6214801;
	Wed,  4 Jun 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMrx+S+W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452F20DD72;
	Wed,  4 Jun 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065996; cv=none; b=l8olkmoCpVqpUwLu+SnJNoGvW9G/BQ0H23OP7aPv3YlsMiXco55pbomhiyvFwISsE0VgmvjkJztc49e4MaS83Ug9sTdbaQ2BC324kiTStSEy8HIoFn2Y8aAqevfiVJSHG8ZggZ6LzRlU1fvITmW5lfaVhgxgyB/nuFhJTHAo6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065996; c=relaxed/simple;
	bh=UNp5sqGlio4wPyqEid3+h1wdqCojiTPLatwSkLYSc4E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lceTQweig1eCsNILlYlILyXlZsrkFVThmfDp13jZK0xPkbyogUWfEf0tYczChNVKy3R3Ik1+zkurul1OGHnYda4b0fw1kYpwFBkv93T1nl+SHNIsjsVp+VJCY19UXFdlVXX2jtdMuuQAeCOuMxmZyt0ezxJM/Q09pUyNeCd7fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMrx+S+W; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70f862dbeaeso3162097b3.1;
        Wed, 04 Jun 2025 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065993; x=1749670793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtcL+s/DLeTuORFgG0EXQX9QcVRzeCvaUqTavb6Svjk=;
        b=YMrx+S+WiiyVJlnR3aI1mGaNFH6dP8oJ+IP0iOPLDD/VIxVovhFWxnElfKAZcMw5eo
         Lr2BWYXcVARrPwsJSYY3xWJwdJu/uDOVkNbVEv3Wr2ZMxMTElv0QtwOFo2RMKwW0XeKC
         vXhdhyVS5HZAPY598y/hwIMWfk1IhMIOVQoI3R7qbd4/8jScsTUnmFAS49K6hDsO/3Xi
         JGBCxDbAtjayosAxliPq4nrK/GPQjfNCJwfK77uu1aKxoRNZIVwbwrLDjpG6GDId+1is
         A7pjPzbu2waBgCXkMXPXNEmtFNAdkkpv9PLLBnrq61dptC7y9GUFKVRrhDVuKki6j7Pq
         898A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065993; x=1749670793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtcL+s/DLeTuORFgG0EXQX9QcVRzeCvaUqTavb6Svjk=;
        b=Kc+Rex2SZkprz11qb6YleEMNrGpGUwi4foyXvK/OtBo6FcuoTz8i+cdu7BZbq1nu9L
         c2CbSaOaYx0TDcAZYkzEkzbWhG0X6U2y4MSvmkFs/zuaI0rNlm8i7MmSsbgMxOPdOUg+
         ZDuA7twm80p5kzdP2t8D3fcuRMXrrbAfqKNR+IhNhrn+WnZO5rd6DK7wNeEg32IV/Uz8
         JDU4gumwCIf2i8nAKdhzTGrMfWotyY/ERdxaw0DddqYY4UqszLsVUDf1rrjv8cLW5k/S
         oluBCPOtRvn8csIEcoEsMRwkBPrdVW8ZTL0GgflHe2HIxJ5j78ip0t9c8BWbEEeMOfNb
         B1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbOi+qXEHWZSInSVTtEdELUG21q0ur7Q0hh8UvBEHMU+T8l6dAVR0Ly9G+4Sbv4DsWNw1PpJMIjLUGvpM=@vger.kernel.org, AJvYcCXUjPECfA7++9wHpaETNPBY/5Qebc4YvTZrlbwgcbJAnCYJEqmvGdgrMgYOV1VQFO5ZnexqnqundTaNmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoqlLiJfR7ipXfoVYPtDCS05EXqGA4EtROhStyGMGba5rwfQt
	hlyWW1jbaDAL5CFYbrxBQ75WLfVBxF59iAxUK3yiaoNQ7RkXHizsu47g9eJZWA==
X-Gm-Gg: ASbGncsfl7P/OpNqlK9cwf2hG7tnsWGkjU1mXBWjqGM/6QP+/A9cgpHQNJSwcfXjsMA
	Un49zPTY55MgySie+JgPyTgv1LFC+nGINptoctEfIErIsSKsTYV04iTDn7/n9kYig+TbK2x6DEs
	HyZtkWSm29Hi2YhrD1OWmGm9Yu+GMk0ZK6JYaki1UfgDogxY/+V8fQK81rjB7zB9PdXk7ARiHSS
	+Hatg/8T/clYgPl7VDTxbYzDTiCSoDnEJDFdUWQpuvWrId1Kd063Tc4UwMu0OdU1oPbrNH31Oh5
	hHVw/q6GGrJ5mZFXwoxgn12w0Uc4jo0s7Vimpbcc31ku/3rWgtwKHRT6bvi/UvnTfaCXisDd0Cc
	Yw02i2qci7Rg=
X-Google-Smtp-Source: AGHT+IEb/8pjUHipKwSFHmPsLnf637ipTMRL9HrqMwk/IBHVo78VZvfskYHNpKqjjh2gXY8sR374yg==
X-Received: by 2002:a05:690c:6812:b0:70d:f892:2dca with SMTP id 00721157ae682-710d9e69561mr60158447b3.32.1749065993425;
        Wed, 04 Jun 2025 12:39:53 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ac0d136sm31513247b3.61.2025.06.04.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:52 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] cpumask: add cpumask_clear_cpus()
Date: Wed,  4 Jun 2025 15:39:37 -0400
Message-ID: <20250604193947.11834-2-yury.norov@gmail.com>
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

When user wants to clear a range in cpumask, the only option the API
provides now is a for-loop, like:

	for_each_cpu_from(cpu, mask) {
		if (cpu >= ncpus)
			break;
		__cpumask_clear_cpu(cpu, mask);
	}

In the bitmap API we have bitmap_clear() for that, which is
significantly faster than a for-loop. Propagate it to cpumasks.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 7ae80a7ca81e..ede95bbe8b80 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -609,6 +609,18 @@ void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 	__set_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
+/**
+ * cpumask_clear_cpus - clear cpus in a cpumask
+ * @dstp:  the cpumask pointer
+ * @cpu:   cpu number (< nr_cpu_ids)
+ * @ncpus: number of cpus to clear (< nr_cpu_ids)
+ */
+static __always_inline void cpumask_clear_cpus(struct cpumask *dstp,
+						unsigned int cpu, unsigned int ncpus)
+{
+	cpumask_check(cpu + ncpus - 1);
+	bitmap_clear(cpumask_bits(dstp), cpumask_check(cpu), ncpus);
+}
 
 /**
  * cpumask_clear_cpu - clear a cpu in a cpumask
-- 
2.43.0


