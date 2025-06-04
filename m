Return-Path: <linux-rdma+bounces-11006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C8ACE539
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7627AB327
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B32367BA;
	Wed,  4 Jun 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5aHFriN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474423505E;
	Wed,  4 Jun 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066004; cv=none; b=XfguqXDNBHtETR+btt9JcoLltqXDnPrjh8gWBBmvy/U8f21uMu59gy2eIPgZyjuT+ZdiiopqNpOY0BIBSrKAnVFvgUmWBvzbNwJ4eZJ04CDBwf8GY5TDt8fn+42lyfoMD0uYGo0ZAr19urEF5GZnmJLGarhCrADQbjdSS8y/IjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066004; c=relaxed/simple;
	bh=t8DDjh3HwhAUE4zYiGY9G7C1Q0qjemSopgAtlZt5dtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/MK8cYWe1lpFWJT4i9PyWg2eTuSHW5a2Yi1Ml8vPpoXIO4HipYmMgbJhhaTzAM6Zj2eQlwcKoSkA1KqRhxmyHH6TE8SKna2+eziOp6pc9VCltH8xlh6AsFYE5Z3MQkEXzM0CE5gpgOUQ5zf9CRhgtk4CbF352495Z4sJSH5hvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5aHFriN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e4bd65106so3142147b3.0;
        Wed, 04 Jun 2025 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749066002; x=1749670802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0R/5dQHAJsM2XSNwZKRpcLz7ma4lbCJr+VnH+Xq6Sw=;
        b=k5aHFriNp2THJQQ+a/AOMcSQRg2Bcld8V9wC62gZyWj3s2MhBIk2HcCpg9N9VA7x8X
         XQcuj3PsQb/o11z/WSKkoVdZvZOCL7pOI5zWcnhHdlhkFSTLKbl/ix9/YqzAf78QYEGC
         a+QYjiDACDqIkNoHnYCvwsueK9cqzVGXEBU12pkBxDiIHhQ+0mCMjjlZoa+S6Mmfm3tz
         /2ULwgAVrWwIpqe/n7jEvj3XACWc8RINnOC0SX0EjttGpJqeLibjJRRuu7SRbR4NiTg5
         qnTt4vjJU2njShDbRErjSOs2ZpzbNdJM1JVLqy++sRC9J45mNj3BBbJqRFz/eDh43ALL
         tJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749066002; x=1749670802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0R/5dQHAJsM2XSNwZKRpcLz7ma4lbCJr+VnH+Xq6Sw=;
        b=QXrEz2ebHPBcqUQ2OHxbfQO13CraxgKYFkJe7tgH8/bu/uJ1UR/BK+asVoks4mrvNX
         OtO62otp26NLZkOD7OjUuLCq7jJYxULPs7UjV2uFoBgUiOHKpKwPcRPBMrMaZ16Z5dO+
         c0UugG7fw2iNlg9l3ZsPksqPWy800pdHTHlbaaHenRnx0TH8MOccyYK9htoyHPIb1NPW
         tNhilJEOYFZDSRZAfD3WoxU4uX12mJNDyjl+SxFEMvFPEQ+L7jRyDlmy5SKlWskDVRDC
         j29FzvyhLri4RRRGQzbr6uldhJyGyH7ZgZAyLhDDPZES8uCWqSJLOg4QiDGnlr0YBajV
         ee1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzCgouR17zBWHdlaa0xjGffoI+yVpURZY+w6e77xXlp/NCozzKvwaTWkg6DFNAYVZvb/fl/U1NPjq3ew==@vger.kernel.org, AJvYcCWqYeXRJ6gE1AMT454YzK0OtXflcPvWA390o9J0UFH829v+DLNyNgP4fV/EoR6NFZoDQbehvKCNzj3z++g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/E9wMPtcBhn1oEbnkKjRCGNygC6zTnKQKCcyM5lY0SC7D3c5k
	wufhZUG+S2PSV8TImzDRBf4dKfE3LtuBMveaTPBERTFjmD83788WdTdq
X-Gm-Gg: ASbGncte8uORB/mxh1Ju17lEf0n4wtD5CfwuzEyK0GrMC8zSSCZ+9N1Duvl2RFMNnol
	MMbfInCk+6YM+ZHNfsdPyRDMKQ2U0PJwmaXWdlUvVOB8bN70PfBd/fYUWRGgJWCr7eDL/r94zPF
	YuCjxpOzOhVhCJpCCPtC7lOMeJ6x0yNM8/9ImsCsVOc8N3E6ORYoqmlywg/r9AuDiaQ8lIl9MUp
	uIOp4+oYeJB9LtAOmxo1tkq856Qp4ofCtW0imCfyCDa8bkyp5FQmgD3crGg97dHDA0tXQhB96or
	lL1U1k7kRa1abG8NCrAQauMRI5KWpEBzTmYuLSypkmN2QvvHVyWuoMut4xnBIAFrGbz6rd+dOV/
	eFaHuCraAhPrzmm0yXYHetA==
X-Google-Smtp-Source: AGHT+IFYWxiL7TNZ3JEn9azdO9bVH4NGbsVwwW4UwjDwr23W89zWnd7GL9lCUfaagJF0SJ0QndQ2oQ==
X-Received: by 2002:a05:690c:4910:b0:6ef:6d61:c254 with SMTP id 00721157ae682-710da020a73mr55388607b3.38.1749066001974;
        Wed, 04 Jun 2025 12:40:01 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710e4aa7655sm2076707b3.46.2025.06.04.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:40:01 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
Date: Wed,  4 Jun 2025 15:39:43 -0400
Message-ID: <20250604193947.11834-8-yury.norov@gmail.com>
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

In few places, the driver tests a cpumask for emptiness immediately
before calling functions that report emptiness themself.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 8974aa1e63d1..ee7fedc67b86 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -337,9 +337,10 @@ static int _dev_comp_vect_cpu_get(struct hfi1_devdata *dd,
 		       &entry->def_intr.used);
 
 	/* If there are non-interrupt CPUs available, use them first */
-	if (!cpumask_empty(non_intr_cpus))
-		cpu = cpumask_first(non_intr_cpus);
-	else /* Otherwise, use interrupt CPUs */
+	cpu = cpumask_first(non_intr_cpus);
+
+	/* Otherwise, use interrupt CPUs */
+	if (cpu >= nr_cpu_ids)
 		cpu = cpumask_first(available_cpus);
 
 	if (cpu >= nr_cpu_ids) { /* empty */
@@ -1080,8 +1081,7 @@ int hfi1_get_proc_affinity(int node)
 		 * loop as the used mask gets reset when
 		 * (set->mask == set->used) before this loop.
 		 */
-		cpumask_andnot(diff, hw_thread_mask, &set->used);
-		if (!cpumask_empty(diff))
+		if (cpumask_andnot(diff, hw_thread_mask, &set->used))
 			break;
 	}
 	hfi1_cdbg(PROC, "Same available HW thread on all physical CPUs: %*pbl",
@@ -1113,8 +1113,7 @@ int hfi1_get_proc_affinity(int node)
 	 *    used for process assignments using the same method as
 	 *    the preferred NUMA node.
 	 */
-	cpumask_andnot(diff, available_mask, intrs_mask);
-	if (!cpumask_empty(diff))
+	if (cpumask_andnot(diff, available_mask, intrs_mask))
 		cpumask_copy(available_mask, diff);
 
 	/* If we don't have CPUs on the preferred node, use other NUMA nodes */
@@ -1130,8 +1129,7 @@ int hfi1_get_proc_affinity(int node)
 		 * At first, we don't want to place processes on the same
 		 * CPUs as interrupt handlers.
 		 */
-		cpumask_andnot(diff, available_mask, intrs_mask);
-		if (!cpumask_empty(diff))
+		if (cpumask_andnot(diff, available_mask, intrs_mask))
 			cpumask_copy(available_mask, diff);
 	}
 	hfi1_cdbg(PROC, "Possible CPUs for process: %*pbl",
-- 
2.43.0


