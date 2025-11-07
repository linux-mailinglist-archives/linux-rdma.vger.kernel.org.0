Return-Path: <linux-rdma+bounces-14297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEEC4024A
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 14:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D860434E32C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934032E6CD8;
	Fri,  7 Nov 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OyMIxDJ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEE2E8B61
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522610; cv=none; b=kR9lAQavVNlOXgCisJvqSMV2bEq8/S4DssAspl5EU0wv1qp2ZIR9e6ZGRTFBNs9C11fdtkq0MF42xeJujyLIv0d3U8bqWSUOLv5X9BrxF4ai6nj2S2rrtg2OklyU5lLAm8GVOXkNlrKLtYOaYz7RQTFk9hfOEJ8cxnWnDJsJ5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522610; c=relaxed/simple;
	bh=UZwswUwbvM3wAsUrhwZiZhYIMvbdcwWe0ZDflLX2Vw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FF48nC0J//oF1s0zUzVf51CbghOfclHGiCkVWeqSFPumgI20DUegs/MlaZSiQPl/mt8zxodYZKx1GMC7NTrEhzYdqj2eu1kh2Ns8vwNrH0dCkbjcjgz1KtTHIxmIjE1sZ34vIdJ7cDE6Vcf2QoUbzQyBS/9IfFNIcsEKJxLgQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OyMIxDJ+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471191ac79dso8505185e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762522607; x=1763127407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JobActy8Q1tKHJAQkXK8C2eUozNLqX92f26Y3cDZo6s=;
        b=OyMIxDJ+4EyK/M9wQWycM/4cg3QY0YOWqYQIOr5kNlwN+MdSL/p9nPUCcLqDvS0/f5
         HhIiXg6DPyCCZzEn6mX+WP3BYpYhnoSJSFcuVEpNd26g2qQuU7tpr8XjQDp9kqIc7Tkd
         EsmN/obX9YoB0AdgrLpbQYgAyDEmH0Xl+qZDvExcw7aSnZlN1Sa6y4nyxcqJFI5aJbzS
         BfTMwTar4p6cu3RlSvaAsUrsp4PgdzA2wM0vDbQqtP/K/Va/2SfLPtfo9DxgeGsvjbcG
         v1MWgx8x+KrVI+aXTHr4GbzpdPCuurOBXBUJYlTEf0KyztNLnTI5lNMxvmpb71TXgUIt
         U3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522607; x=1763127407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JobActy8Q1tKHJAQkXK8C2eUozNLqX92f26Y3cDZo6s=;
        b=VRMwxri2eAVwYlS2pzfsEkn/eDT0gd4Zp33aozQolB9kCAAcG5g2yTyVL+fN8vOmO3
         7mDgh5CHlFJgEY3A7K1eaompCnUIGWRhEr2XsIV8govLCmzLxze70/Mcc4xmOiV21KYX
         abXKhQqq3M1zWii2120F9xvYiT0B8OGvUtTisfg3FmAanTsYuMxSu7264v9MKhtK4D8A
         uWuIVu+fy2IgQY4cWvWgUomvgmSQGJYQTKwjr2ziIf17clpdBPx/ogeBK2vYB8U/eGq5
         HgEggBsyI72+hxEiTbzTeRTnoOdrIzc3UKbG0WTTukiJMSW94OLwArAEP8rXwByKioB/
         D3ww==
X-Forwarded-Encrypted: i=1; AJvYcCVw4h0rN+jdHyQ3SGlnOkHVyRR/Bu4WPON+nvoochoud5pUlPH3hwOT/k7cA6q563JQfIKyEkG+OsTY@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwuXPEeRr1Xr8FldVFHF2lSQY3iRghck59iaH8ISrYC3ej0uL
	uXjOrdfSBV6IxANxhBbbvCDSslwcXwdwuSlkEzEgYPI6ML6AYFdQt8erJt8bdAqJ2kU=
X-Gm-Gg: ASbGncsGne8LQvg0+cWhEbGetsTQTjjtJ04joDN3LCN8aHCnhGX/3Jy+aW2dKX5Ncr+
	0E521sDwnVc4LnMPSK7uUG+l7mfHC5SA7jazF40jV5NFA+EIt3JYtzzWgm4sqUn+024PKTyg8n4
	ipRb5LFHAIcCfaMRnXbjTy8rJjwzbzxVgO7P7VaLVfrTZn3C4blkmTu1EHTYUR0YhxVEZWi++QT
	7AGTJW4D5sg7k4MHmFNM+4CKirtQ+G11QuwgvDJtUiqfsGnz5twT3yr0mZpB/kAGRYnG5Vn+6Zw
	RbW+uSmoiayHVkMezhV+c1v5BTgJmbzbAwGeLHZwOPk893FNcfQTXvBCzqFNmL9zce7B/CH56Zb
	MXrrc9EX/UHD6qo94qGCFc5A3nEapvYLDqKO71iUl9Bav3H8fCwu9V1yFKcZOP0A1cUh4DiMocZ
	/Y6OXz8fQEY27TBUG5NJk7TlsU
X-Google-Smtp-Source: AGHT+IHigxOt7e+EuY57cRMkA4R3lmI1I5oqR9eg08rBEkmbJ647xE77iJ/O9h1VcgnOpYFGx9jYAQ==
X-Received: by 2002:a05:600c:4fcb:b0:477:59e8:507d with SMTP id 5b1f17b1804b1-4776bcc537amr26494345e9.31.1762522606742;
        Fri, 07 Nov 2025 05:36:46 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4d7f2sm40627915e9.4.2025.11.07.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:36:46 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] IB/isert: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:36:26 +0100
Message-ID: <20251107133626.190952-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 42977a5326ee..af811d060cc8 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2613,7 +2613,7 @@ static struct iscsit_transport iser_target_transport = {
 
 static int __init isert_init(void)
 {
-	isert_login_wq = alloc_workqueue("isert_login_wq", 0, 0);
+	isert_login_wq = alloc_workqueue("isert_login_wq", WQ_PERCPU, 0);
 	if (!isert_login_wq) {
 		isert_err("Unable to allocate isert_login_wq\n");
 		return -ENOMEM;
-- 
2.51.1


