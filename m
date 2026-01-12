Return-Path: <linux-rdma+bounces-15435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB3D104A9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 02:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C5B301B82B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 01:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B823AB81;
	Mon, 12 Jan 2026 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWXT466o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0E22FAFD
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182918; cv=none; b=hA3DKL3kN5FZk2oYrQWwkIwq7ZZWgGWwZONnl1VrW+po4vzZMLGbwWzvIlON8X/eTA2KfnsmjUULjBa/bJj+dJHGNodg81g3bqhmqa5jgDaG/LbXhHZEiJMcrvX9vCrsousXUid40sR/TW478rR+hwoa1Pbt0sRzm6Ue30CAOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182918; c=relaxed/simple;
	bh=kCD6HRJcmZrPRPRnBZZYRifzn18q6tmbp9qI98+NNEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E694YmTGXItmuVPiDnvjbrVDjKN834ws42HXL7rA1453Ms0kxo4LEBuHAr9nfNOOR0mcajr87/g0/lstFr/GjxbMKYGcMCWn7nmVndUf5PHa+aIPbqr7F6t4K6fC6xAtPc8NMDuU2jbKSmdgcaW+mkCa65hImRYjQXZEkEU8kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWXT466o; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45358572a11so3689193b6e.3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 17:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768182916; x=1768787716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auu+FpQXOrTqGrm+zeuNScIciQTdgODF3k4zFrtqeoI=;
        b=gWXT466o9bChFDkjudJZrN4jLrqrM7wsTKVoNPj2Jqbj+st+d5GSiCdNtBCS+a4Uf3
         /DmAuuCbgn+a83W34btpxz7b/S1QLMXujCqcTeBZXu4I11a0ct6LmCvGKRw9SPYvh43W
         ZVFIXxX+w+Il04Z4gHCvFK/VxB1raNVMtLr6hgmxTKUPw5YaUnRWbU1TyTXPYubfs2cg
         KRgoH8ssM/Ajrs6LYs2WEcEbpgBTdLeTG+qd03IEh0/5kpebJ4mG3tE6V6MDVqx+6pkH
         pGLYoGdvQ/KcUpJcx7mtWPqZ+Nh4gB0tphRRbBJ96kRpiove12gomIs6qGSDI25dG7ej
         0yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768182916; x=1768787716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Auu+FpQXOrTqGrm+zeuNScIciQTdgODF3k4zFrtqeoI=;
        b=GKVAXg5qnV1oT07c4llN8nyAxmnGelAoyVTHfd0zxz7shWDdOgJf0eROlPVG36KoEn
         6XLHu/hrg1r9p9IakhMLkBX3OAyygGxFzCcQnp/S9mFOfK1HGv1uxYUVFotQhAOYGU5Q
         fl5CMcL3GqjVhRpagjDxzq72uN5A8z3Vvl6xBGUWOrGCDB5tqJo6KIvM6lA8CI3vgVoD
         iXpfdXaYI40Wzk1Uo6DCB6XSDIIaImBOtBBh93iMCr4lUj2cVJQZM0rekU7Wz+Acktz6
         ChPdjj/dDN44rGMldlkHoagWHgv3ypZQsQh1kQRIj+JCFaOVVHv0WRODKFNA96N09fvm
         lMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHOaPuJ6sx5jToicz/8p0YMZkyZsG3AbFZwH3KnEw6Uu4FIbt6VfOhc7fU54h4U5davbTDfAopyQ0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ClEqwzFgGTO5AGsX3DNoylT/guFMiZbsi6tYGxjfSN5tzBdG
	ONNL7+a0fxsrTQb8zsVKoyVLU7MLKSKntKEavCPDNMvbl7fzNr9+Gvn+
X-Gm-Gg: AY/fxX5J6OtGWHOLNlg1Uv7roTM4m2qIFR/eibzM93kkw27dVrj6SU1LY7+5Kaap6F7
	75SbYuW1k8RzCr60Qhn/xP+77LkcQsQTMH0vKQD5TIibvUR4RX8n9dlOj9kmCGqozOns0Ilr5aM
	bz9TRBE5MZiI+SjhafFmmH3mFl6MylOVA7pyQGg0onxojCyOd8YjYTHEDK4L1pTjhxB9w1PzdUg
	CLEJl/RUZNQfeeZRn47/X+4pYZCk8RuujYdj7px8oOy3m4cCvMNcugdgK1lvGzI4q4ntP3/PzQG
	cj0s924yDpZ+zApyZbmJ/juyZVFbIErMWnB3CnRkZS3hrJTzyGXWhK03MpaWQQ8n+aTHJKDlugy
	Ojp5GdwL5/dAvxE560z9BnwYJfu+4DnNvPRP5NjMzK6k4ei7zwEq1SUXXPJlvt8w7Q3cA4InpEY
	rTN/4d1z0JM3TNn49r0wkQ8n05Rg1oaA+f
X-Google-Smtp-Source: AGHT+IE7cs9T4kt1zO+u3pa9BL+SX8PvXlXsEUwB1KxbDesdiOMQ8pOZ2FFqIKczl6ZIqUdd+CQJaA==
X-Received: by 2002:a05:6808:138f:b0:44f:6a32:5364 with SMTP id 5614622812f47-45a6bd77d1amr8222796b6e.24.1768182915793;
        Sun, 11 Jan 2026 17:55:15 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm7532778b6e.4.2026.01.11.17.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 17:55:15 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca,
	jiashengjiangcool@gmail.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	zyjzyj2000@gmail.com
Subject: [PATCH v2] RDMA/rxe: Fix double free in rxe_srq_from_init
Date: Mon, 12 Jan 2026 01:55:13 +0000
Message-Id: <20260112015513.29712-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <721999a4-760f-4c57-84f2-be1753dd8307@linux.dev>
References: <721999a4-760f-4c57-84f2-be1753dd8307@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_srq_from_init(), the queue pointer 'q' is assigned to
'srq->rq.queue' before copying the SRQ number to user space.
If copy_to_user() fails, the function calls rxe_queue_cleanup()
to free the queue, but leaves the now-invalid pointer in
'srq->rq.queue'.

The caller of rxe_srq_from_init() (rxe_create_srq) eventually
calls rxe_srq_cleanup() upon receiving the error, which triggers
a second rxe_queue_cleanup() on the same memory, leading to a
double free.

The call trace looks like this:
   kmem_cache_free+0x.../0x...
   rxe_queue_cleanup+0x1a/0x30 [rdma_rxe]
   rxe_srq_cleanup+0x42/0x60 [rdma_rxe]
   rxe_elem_release+0x31/0x70 [rdma_rxe]
   rxe_create_srq+0x12b/0x1a0 [rdma_rxe]
   ib_create_srq_user+0x9a/0x150 [ib_core]

Fix this by moving 'srq->rq.queue = q' after copy_to_user.

Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Move both 'srq->rq.queue = q' and 'init->attr.max_wr = srq->rq.max_wr'
after copy_to_user().
2. Add call trace for better understanding of the issue.
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 2a234f26ac10..c9a7cd38953d 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -77,9 +77,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		goto err_free;
 	}
 
-	srq->rq.queue = q;
-	init->attr.max_wr = srq->rq.max_wr;
-
 	if (uresp) {
 		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
 				 sizeof(uresp->srq_num))) {
@@ -88,6 +85,9 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		}
 	}
 
+	srq->rq.queue = q;
+	init->attr.max_wr = srq->rq.max_wr;
+
 	return 0;
 
 err_free:
-- 
2.25.1


