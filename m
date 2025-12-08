Return-Path: <linux-rdma+bounces-14929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0357CADB79
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241883065AEA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E292E7621;
	Mon,  8 Dec 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hbU5gKKI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20F2DF12F
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210526; cv=none; b=IDy8o0tSK7+XITmtsIwYdSrLFkLS4uoAJZExXAMMeYj/XOm3pxettE7ad20joLQTW288y79cCc0+5CX/qjfdqba5cKcDkrS31yYhLLf8ruQKG22A/LMdH33lCEtY1uKv2SOFeLrdyI55/5fVQBxMSQBv5tsoaEvMnPQqaAvBPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210526; c=relaxed/simple;
	bh=WKpfno5Doi7OzUhTLVzhGsVVApVc6LUkHF/jhiQOORg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLz2LZIH5grNwfEK62Admo+jk3QgkbXjOTR2Xl+tqCIW38unc8OOZTafbgTEHuNymEOdUp1FOLxNWAk829OyU//nA6w81DrJ18NAWVtfKkTqiCG9G5wirK+8dZZ76cZVmF2zWawdid+di7NMQNTIj7wunh4hK1JZi9Wla/jGKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hbU5gKKI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632d9326so31720195e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210522; x=1765815322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZobc/SXlhEuXSrudNoiUcMGsJ4kpeYu2QMk33cyckw=;
        b=hbU5gKKITCfbylOBaNWtv0lWmAaFKGKhtLiWvyT5dfhuzP3UGeOMqJQvMYZqxdAp/a
         BcbOxbKyCHNxFNbCH7Ms4DXyjI9zqyON+DHrUQ934pdyUEI4RX2trm9nCVIx9jascHeM
         wshtLR1tVuPlFXjU+ht7+pF694vgdAWvmh6Bk/NuKUMb6wQ0Ot75hVG0hEG6hORHvZQN
         P+LKgr8vdmI+isbSVxpYsX+tVQWhmOY7OuliefbdMe/sZQBPEt2HkAC9HoA5ard0iYEk
         yTMUIIsUpZRkStEiixjJ1ZxjeYrk+ielfrbOSm4GJ1iwuGdDUA5LjwX9BHtJTpx7OHfR
         sSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210522; x=1765815322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZobc/SXlhEuXSrudNoiUcMGsJ4kpeYu2QMk33cyckw=;
        b=HgPr4SAG7jeDyV3atLyt3sHk9/xGyyhX9BWuKJlzt+uVC+9ubwCB+OnNTs1w9XDfMU
         wjGuizoOLB6pkQxzU5U99RnPffe1vHByJqeP3tfMYNmDvVP9PE5vVv0EjAAVryF6YctY
         XZ8+8n9w2KLrXoH9qv9aGsGoNwLHV7LNLOGSHK71MRCtGW/f13biizXV8yvZ2OVg6bvf
         sUBKJqkg85dyPDlOpWcRGyhpM1UitLiHtmbDNz5dKTMyKeApelFJdU58b2BLKLBrZ72v
         hkQA6PFFJn671klCLSGF/Zhvdg2dItXGPCQWBYVrb8AsJ0urSW8HlCm/ABcGCuKFlwWr
         jMZA==
X-Gm-Message-State: AOJu0YxnGRsLlZZwrF/J49pUIFsf0RvFz/XR8k3i/C/ykcu5g/ebVeUy
	PL/qWTWfVkerManvqIxU9odeU6PRhVGydutNDC6/97lG7EARZbNVbC74N+iLdd0hPc0xnsM6fga
	xvg2L
X-Gm-Gg: ASbGncvrm0MUCfC8qblpfMMfKjRVyP//emUMy4AqjMr25s4XgP+IjyZfeNiLup+RJqp
	+IBCKq9rfxGu1JC/NeK8LzE9MkMtFLip1sysSQA9skRUcZ2HJgX15C/FzS/zcN2Q6c4IuZumUHl
	5jofCVBCJooKw4Fl3hKgtKZPPLoDAmti5+fCcbRS2VOPfPbJBm8i8x3ur+XjIn17Ecilm8Caal4
	utZHtyo5EDX6eTIQDEGp4gsU0N50HdzYymjGLdjD+pd7eeTqguSC9Om3YLzJtlpNlgZnd4X6HN4
	FoFgbwSajz5AtULpjeOLIvA2PLDdqyTod4z7flJWnH+pf6c7YR+2IN6M2h4F38zSTNS32MdWvj6
	N9h8gLem9mzFoX+jeq4pH+KtunMgeKoP7AUf1OAi3XmVAAzXs1DnwIAewMoEVuApanx6H01Qn6w
	pAG0mqOdclwRme3rKF6Y3uqw9o/aYPc2pNxGavfTWUogC/9I4rhku3hCyMxVS8kdpsNgsf81yx/
	RWwyKzVaNODLNCH18IH+DA/
X-Google-Smtp-Source: AGHT+IGicZKkZ+WQYZDUhiyCvorY2zYI1l77MG+ov4z8/WMUVaE0hHU18fyxVzzvcXiPLmwSorUZCQ==
X-Received: by 2002:a7b:c8c1:0:b0:479:3a87:2eeb with SMTP id 5b1f17b1804b1-4793a87302fmr51981475e9.37.1765210522096;
        Mon, 08 Dec 2025 08:15:22 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:21 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH 7/9] RDMA/rtrs-srv: Rate-limit I/O path error logging
Date: Mon,  8 Dec 2025 17:15:11 +0100
Message-ID: <20251208161513.127049-8-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kim Zhu <zhu.yanjun@ionos.com>

Excessive error logging is making it difficult to identify the root
cause of issues. Implement rate limiting to improve log clarity.

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 20e7d2681668..dfe38ffc2e38 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -184,7 +184,7 @@ static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_srv_path *srv_path = to_srv_path(s);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(s, "REG MR failed: %s\n",
+		rtrs_err_rl(s, "REG MR failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		close_path(srv_path);
 		return;
-- 
2.43.0


