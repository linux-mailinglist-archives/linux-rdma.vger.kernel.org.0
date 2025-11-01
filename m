Return-Path: <linux-rdma+bounces-14173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E73C28303
	for <lists+linux-rdma@lfdr.de>; Sat, 01 Nov 2025 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336E93ACE80
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Nov 2025 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47D26A08C;
	Sat,  1 Nov 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U9McLapY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBC26560D
	for <linux-rdma@vger.kernel.org>; Sat,  1 Nov 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014708; cv=none; b=Vu7MYZaLwuaD9MATE6Jw+zGT5/cyxq1eiuqHbbL0JYAiDm3t/EAplLNb8jwKtBU4BWZ9JtWZpX2Se700qsJ+6/RqEzA6S2PCORcuyszSjnxTvUPkpgRcDv0BmfjQ0b3RivsPhT1Fp5/95WOpPNs3muf4u57cws6aPCmPDTUo4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014708; c=relaxed/simple;
	bh=M+HTbFEvOs14zz+Qzo5NFOodIQwx4sRzNfxNyQ6Vu6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjMhc+SQR9BYaQXAmuEiVwT67BhCa3AqNe/kHaIw34350wvQFZ1/Xuv+wws1iXgjrsfXB+3jSkALAjU8dYU2A++g41P7Y91tqOFdOW2ZwAd/ABd1ZAgQB2BOQAdaEsnsyBKRdnbOIBTrlO3UTaHYZZ7sgy9XMjUOg0zVhzTBm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U9McLapY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso26084575e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 01 Nov 2025 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014705; x=1762619505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edy/Vm6M6bIk0NgCarBHEsL69x+coUeeUJHets+qLoU=;
        b=U9McLapYF6WPJdVbrtLTblECtVj0lZPUbW1YZfqfLDptVZVHVqn8p87n+3UooO+wrN
         ZJKuXbXhE6xpXi9QvSFM1miED9h4b8gzO0QtJ4KMIrqFP7weVpxUMtTHSCd8Nu/vvFuA
         JuHRmvwIm6wHrSmmOnV9L2MaAhF2tEcM8gCnKWoLy7r2MdiZD61M4zjDKTjytLg105/Q
         BGHU7S4ci+S+5wndMZQukod/uIqq8Mm6dy880LixLbToT+O3V1WLpyjbXKZT8ALHPVcZ
         Yj4PKJdWaRXyeIQ3qI2GoG8IXGCsReOPBAq47+LdHJfL8GylEhHfY+ffcrU+4dR8xQyq
         sz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014705; x=1762619505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edy/Vm6M6bIk0NgCarBHEsL69x+coUeeUJHets+qLoU=;
        b=Hh2ZN5TA9/HKsKBwXTv89ZjNrC9h4BDJcMXbu5Gxr/FRxWzqgahPcG5YdBoelNZ94r
         GW2lNuGFbCQcXSIbaIml3bTswlBChijSD87j4PMoSjssVHXlwH/7EuUSV7D//WTzXc3S
         7mVZj5sYb+eCbzW7mMipcr98L2cbMgF/tfi8Fp7knNvUrXmEsXJhAN/aDAbMbmn36rlj
         0HfgtD+PCF3LopstQ7QHrFHx30gzYkeIjSls2PbUV3Z+vr91VoGnTkY/H/XGLjw1Svw8
         2zh2GKa6Pew1QGlGysCH78vTLjkWRnunYi7L9FwYt0U/0e3FILTilLm9T0O6SCZSd0M8
         he8A==
X-Forwarded-Encrypted: i=1; AJvYcCVNTGq7OZL9gkR6LcWlEjRJDiVCaq7b0BFxrzBdtGKNBW/vsJ16/c30oRJLkVH4aXU1dCZInauvYI8u@vger.kernel.org
X-Gm-Message-State: AOJu0YycrS3weNvLLEad8g6dWQ/gsRkx/TjZi2wqQdSrP5QFT6TOf4It
	o4laVVlPaHTGlc/1tIWUWwyAbQfXelbhVVdO+dKnHReAgmVJ9uMdjx9wdofAV/8OclY=
X-Gm-Gg: ASbGncuiSgUQAEEWFTOEng/elTmF2ZELz2jSI7cwDcg0YfFCYoHKWKgTcVVvOtFMRjp
	4RiGOIpHU+w2BOJYzmv3NRsEzh87q+KVCp5s82uyt/NxvjqkWMtR0SCTvvsDhkVu1srHzZxhncU
	6d9o5uiCuIRQ6BHioNwFHtAAKtiUq++jqMLurtvSKz3+Mho31eoLTTmZ9gKRwv8i8SRM6bxFUUR
	qYkVueqWc6KRBN7K3YecdwuutMAFHzRjzdujZm76P1ftVgqK+WvOWwMm/evxykYHmcXjoc3QVKl
	ZOCtXUn22Qwr1ru8LjTvmxxrUuq7bWV+RhTWdL9HWTv91RB4op14jUGUdU6nj7Iqj45A7h8BU9v
	BLCyIAKlYFvqqMPRsMQOFTrOplx+93j2gPJX2bUADsXnGacWQ48fQY/Z2nzzM3C56wI8rVf6vDa
	s6X+ZJKfrTmxzqgaeLUduWewtSmerR2K9PG9o=
X-Google-Smtp-Source: AGHT+IFERS3rJ2ULC1YVWKNWA3KseWiAk4MFC4NTTgLowJegNZ8jjdlLfmXtfvReueuEEHynaSc8Sw==
X-Received: by 2002:a05:600c:470c:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-477307e4890mr65694995e9.13.1762014704826;
        Sat, 01 Nov 2025 09:31:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:44 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH 5/5] IB/rdmavt: WQ_PERCPU added to alloc_workqueue users
Date: Sat,  1 Nov 2025 17:31:15 +0100
Message-ID: <20251101163121.78400-6-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101163121.78400-1-marco.crivellari@suse.com>
References: <20251101163121.78400-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

CC: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/sw/rdmavt/cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 0ca2743f1075..e7835ca70e2b 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -518,7 +518,8 @@ int rvt_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry)
  */
 int rvt_driver_cq_init(void)
 {
-	comp_vector_wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_CPU_INTENSIVE,
+	comp_vector_wq = alloc_workqueue("%s",
+					 WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_PERCPU,
 					 0, "rdmavt_cq");
 	if (!comp_vector_wq)
 		return -ENOMEM;
-- 
2.51.0


