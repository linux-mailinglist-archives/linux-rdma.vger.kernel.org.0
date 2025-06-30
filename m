Return-Path: <linux-rdma+bounces-11750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E0AED899
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 11:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789361898F2C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6125B24469D;
	Mon, 30 Jun 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlYeRq8J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC442405E4;
	Mon, 30 Jun 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275451; cv=none; b=iH521kPZumG29LfcIsYBo4l3uk+q6AOBRZ4IY+8yB4Z9VEa6WfHhPts0x7xLmF/fSbYWxAEwwzKVL2/JoAhuvUyAa/55shNoo3SG6EXjOKPEBJyr722yzc8HA9pNHb1jv9WdO+QIGw2vlvNMKfSaDhhFbFxkDNgZ8erUjAlatc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275451; c=relaxed/simple;
	bh=LquRyjpxFCaRtwCdvq2Z5KQoRtxjQyJbFhR+XPOxYvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPGm7EnEpvPZDxZ/J9TENJMmPU9skxszhX8pniKgxqj3DCiRwDXWhV5s7GOBnMYMf1Dna+VvQsLfX8VZX55szRCKkdp4T0IXVYsKJInzE3xob3LuVsU8g5SA7LPjzh0RTpRfdCvtLN6gFswTfK+nZuV71RtAAFFX2QNGhDu7JM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlYeRq8J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ddb35583so5713385e9.1;
        Mon, 30 Jun 2025 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751275448; x=1751880248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvxxU0NEcnFMHXz+8qtLt58LETg4jOKjluE7dIo97iw=;
        b=WlYeRq8JWpxQ0/ad+v/nYemiYkhCk4p4Rbr682xWEFZhicEvAddIapnVNaiMGE4sR0
         Cv/E3b9bo2RpeqrR3AOSJ+vbLyM54MshOCsw35LIs8YkPCzWhnnsDBmsbKhBs7F9w+rY
         K8CvPvpgWth1H6No9avZMg4XDCFjgkdp0ouKl4scb4x4mc4Ig0HO2dSwYh7eC9ud+6R1
         LseNvdJkL6N9fqxQkMqgBDAtxBF9iXhiQFxw1o2he1Sry6LzGb9aCLwavj8n/W4k2XsJ
         pWNRm1QC2pq89qio66QLCChSfwW36tOZ4Qb4sagC+1e7YK+zdR4fqn+WGvNOCJbJj4zs
         BpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751275448; x=1751880248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvxxU0NEcnFMHXz+8qtLt58LETg4jOKjluE7dIo97iw=;
        b=W7E0deU8NPB6lCb3ja0HkJygP46NN4mQdzSJc8aD1fnV1UUza8J7jLdQ5gBVI9eG4V
         e+8tHxZFFiCnCe4LL2oIfMkcvP1Ab/s5ZwaYGxDyUkkQMeoZKVegk+uPs1sKUwpjyr6M
         10tWJhQCrSOFsCYO1C4DIjEEhcb7ola4e4MGWOTtduLOMRixvm32yu1gMoZezMLIIKR7
         tHW/MKpBl85U2NJPN99fp9xgWnzSo/pKUIbeQYRyg0+xZhsjUyrqrDF697IeBilRf56H
         4nYcmEHLDLfao8yIHSl/8eQc/9mdegPg9WUp3HqE1uFcFnK3T7ozA4o/OtlVmh3b6lf9
         j0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUp0IMtUD2Zkbm1us6MUDXO35nlS+VOVGRNUov4LBO2HoHkhL2/N3yvDUe7eoTc8m7n3cAnNfDq69sAuw==@vger.kernel.org, AJvYcCVV3ICMoYUgpkAn+w39tsw/aaWKr9yyDRva9FE4syNrByjF7S6sOcc88oKUI9Kqj/rN1qcwhL7mn2cCrU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQ5fYuY9Q1pTPGyW1Qiv1aMvzYf3NFOgJn4jym04P5o9f7UfL
	ycfU6WvPbOH9Q51ZPMSyoMsNdV3R/Sr/LgPbulc4x8XLpm9vB9IpeQ1Z
X-Gm-Gg: ASbGncsxKNfVrQj3oaWYCKldtlXbHjJhHXUTW2bXeChd7pEXF3lu5EwwAKKsPx38XWv
	LPepQfN6K8o5xKKke6ynr6EfPuy80/0mkDaJx4ZzL2onZtmLHpmqr4SIu3+z3se/94ETBGD9+KD
	u5hm/lHlc+i6PM3OXxVBE+QEsN5h9KEYLrDr4fUDA4SXfEOmAVACVKNn8rnUbHTBLIYoFYVCf9t
	AmzdAq6M55B2cbtuTAHPMXCP7Nk3bzqmDy3YkHx2ot6c1+ZoRLB4Bft7X7YlXNH3o3HHz7cdTym
	WMynI90agEH4VMb4zF67+iC6awQqhGo8WUxPo8Rk3FIrjnGQCwmxDUrH4+jiaxHNkJzUmXzll+g
	1yPXGA/hyul/4+wQ7UZmOzccTyQ==
X-Google-Smtp-Source: AGHT+IGnb/+6oC8qGbWFs/Z5wgynAAiq8Uo3c6ka+Ds1lOAm7tNYdkLYsKK+YgBtAmEBU5y5m7puDA==
X-Received: by 2002:a05:6000:220f:b0:3a5:2d42:aa1e with SMTP id ffacd0b85a97d-3aaf56f0129mr2322107f8f.15.1751275447554;
        Mon, 30 Jun 2025 02:24:07 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:234c:3c9a:efe4:2b60])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7ec6aesm9846368f8f.5.2025.06.30.02.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:24:07 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix dma_unmap_sg() nents value
Date: Mon, 30 Jun 2025 11:23:46 +0200
Message-ID: <20250630092346.81017-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: ed10435d3583 ("RDMA/erdma: Implement hierarchical MTT")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index af36a8d2df22..ec0ad4086066 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -629,7 +629,8 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
 static void erdma_destroy_mtt_buf_sg(struct erdma_dev *dev,
 				     struct erdma_mtt *mtt)
 {
-	dma_unmap_sg(&dev->pdev->dev, mtt->sglist, mtt->nsg, DMA_TO_DEVICE);
+	dma_unmap_sg(&dev->pdev->dev, mtt->sglist,
+		     DIV_ROUND_UP(mtt->size, PAGE_SIZE), DMA_TO_DEVICE);
 	vfree(mtt->sglist);
 }
 
-- 
2.43.0


