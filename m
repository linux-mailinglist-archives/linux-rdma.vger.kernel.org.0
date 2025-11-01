Return-Path: <linux-rdma+bounces-14172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A97C282FD
	for <lists+linux-rdma@lfdr.de>; Sat, 01 Nov 2025 17:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E9F3A9112
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Nov 2025 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894EC26D4C1;
	Sat,  1 Nov 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ar9f79Pk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC288261B9E
	for <linux-rdma@vger.kernel.org>; Sat,  1 Nov 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014708; cv=none; b=ed+3BqXcd3pyDXD6GW7yeDr4y39TuY7P86A80/SFv5WCaDxbaEjnOuhh+k1N7i7KVjY7FciHWvFqhupTJarpQ3muJH/IkO5zUP3yitkfkniPsQMbK3jI4pF4LiOEjfa7aOuxklnh9b/IvjBjEuWp4toes5+mIEfVhW9FCA+CS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014708; c=relaxed/simple;
	bh=/+z72a0HG4HnREfzMdeSt5GSakxveM/XKf3p4bLSwYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFLkZgEpHQSXkQVIlhCIeg2auSicm39dllAkIgFz9F2xP0b0P1M0fYG/9CKXpMlvXKIRmyg3feyudv00fbZD4whxH1MdKweIYNFVgU8wW5ac26f8kIe7X4Vu2v1wrU1iJlx76cbB8XrrOk0gqvhm3dmWLNJruw7ba0M0BL0UKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ar9f79Pk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso20981935e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 01 Nov 2025 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014704; x=1762619504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYxN3f0sISH3VgYFCYL8piMSpurElNpYj5fttjw9+bM=;
        b=ar9f79PkWyGJ9NEpBnvnlSROM8LMMeiPT6FS7QJJP8DTcXybfcPuCrWOUrZY2pw5jz
         Q4aaBGj4jXvgj9CYWql8FGb/H6FC8xqUbSiyif0nHjnRuWNJUXh2hLhEPgRTVkr/3U7G
         WqaBRenyEjtLn6ZI6OC9HlkYdSW15V3rkrjAqzBJu6hHt4ktQrKRbSIxepOxao/O3o4J
         NAtdS3DGhwkkQleja4VaobmtxT19fa7/4auTAujLfGbj3UCNd+yZi0YtvHm451Wkh2Uz
         klfqHo5UTkNhBNVnHLZKp0xgp0/vOS1mPszIdS9p9vBimoLZtlse8PN8qFXZ90Fg5RqH
         Y5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014704; x=1762619504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYxN3f0sISH3VgYFCYL8piMSpurElNpYj5fttjw9+bM=;
        b=VfbyMR3HF9wDfWdT8+3JzaS7BFrhCvIiqGBmXh0U81T8owjeNCa+9TDRaEOP2Egbj6
         +uYxXUZHFABis6qgvr7i7XvyAziq9aoYM9YuwO8F9wqIEeLkdGIGex4K3ib09kDtCBUa
         Tu4kZ+zKNpiCNY+iCldB7x5CA5mkVZnvY1vAjVBC5r1DxPDnbS0aWrFaCiHB7VngPpxG
         HfMaw9h2RQUnxyd9kwhxjV/ouNckfXRIV/sXfjLmgyUvHZ4yr9y24kujtCYnlYAFb94w
         5Jf4TZ7J769hFUsQTcp/hoW9JYO3JEAKzDD2P/eksKYf3R7qSMm7fITyoGY7vD1p2Obj
         qVUA==
X-Forwarded-Encrypted: i=1; AJvYcCUgyoQIjqz7R6frY7Y+zBpo2Q37MYobQCPd6Lc0hZE4RWR1+exb0LArUi1JO/PrRdTrexLVaNcG8wqW@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAuVMA8ZygvrrmAjDYz/r/qYG6DBJIOHYYN0q/opIpy7Cly2x
	yk+Gad3aGruud0pkbnYNLyFyXtOl1N8DvDACmj5bK759MK1tWoqI8NW7JTWokC12V/M=
X-Gm-Gg: ASbGnctfYGkCljZMDqo/5V3UpdnGHnrzEbgA3kFOU4AOL0kkwyQXfJUqq7o3N1siB81
	R1sWTLdn/oBeZAU4MxHMCDOjXQcIOetBKhJ9ytoDuiJKqTGprMvFSAS4fX5S5Wj2GJIyiY93kY0
	R37AmGE9FskOpPlWdq4TiyEFvSJxQtML6y6i+KFMtzsTB87vcwVHpByQxopz3xrS/7wJZHQTOIG
	MFCgPIPbfFpiS+7+qusg8zm8rUFlfNTkv6IKS/fTvnMdozNEwlN7+uANDoTgVl5f4Vag2fccS/m
	LbYtN746jM1ZIs2UGEGTaGjgDHLuN5RfXOn5IAGuBdFgJ+3KmBxc3QlcntrED+yomcnIm7TZdq2
	s5h+US0P/A2S4pNWKBybf3XjXctWzR4MxUD6u1dS08Gni26JbYSsDF6NqB+Hih1HLOSegTL/c7Z
	CqhCkT9dPqAR5FYpFTB8DMNGnM
X-Google-Smtp-Source: AGHT+IEQI/OmS9cYFi4nezlD18gB9/y0tILr+1Qa0cLSqTcdp9k3IlgKBk0q4nInZ5a3mPNL8k0tmA==
X-Received: by 2002:a05:600c:3511:b0:476:4efc:8edc with SMTP id 5b1f17b1804b1-477307d9920mr63343645e9.15.1762014703867;
        Sat, 01 Nov 2025 09:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:43 -0700 (PDT)
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
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 4/5] RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
Date: Sat,  1 Nov 2025 17:31:14 +0100
Message-ID: <20251101163121.78400-5-marco.crivellari@suse.com>
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

CC: Yishai Hadas <yishaih@nvidia.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 12b481d138cf..03aacd526860 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -591,7 +591,7 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev *dev, int slave)
 
 int mlx4_ib_cm_init(void)
 {
-	cm_wq = alloc_workqueue("mlx4_ib_cm", 0, 0);
+	cm_wq = alloc_workqueue("mlx4_ib_cm", WQ_PERCPU, 0);
 	if (!cm_wq)
 		return -ENOMEM;
 
-- 
2.51.0


