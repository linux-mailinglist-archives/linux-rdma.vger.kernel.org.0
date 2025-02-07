Return-Path: <linux-rdma+bounces-7509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86184A2BEFB
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AE13A7DFF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C61547C8;
	Fri,  7 Feb 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwkS8JkA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8D1D63CD
	for <linux-rdma@vger.kernel.org>; Fri,  7 Feb 2025 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919771; cv=none; b=oG1nBsDrBEi/fsIu58SAKhXKXjxj9BRGPc/B8i86oKeEQQgwJ/HIYlnsOOBl7nzjC0UsN7SH59ezI/w+1dfMudRPQG7y7mQDYKr0BlT2FYG4MIc4OKfyPD2T30oezSkRkv1SjjPf+BYwgdtK5QZ0pYnBj/uLQTxCkxgEmySmzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919771; c=relaxed/simple;
	bh=fLjMsIh/HJUQjg/hVkNg/XMCQsi3SepuuV9mpQx0YkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JCPo/HZod4U4/uOUfsX0086T8ReZWNyMSpOtwI6tm+Umw2sH0KchXC44uQ0SwV5789pv4X7FkFv8VQifRCaJFkGjvGkwbLdPAvYuzgQXnmOcuzz9tq2MCPbKqzIrChlnQ5qRgpx4IgbCea01yTv7V7nAqxvZc8MePfRaS8XA7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwkS8JkA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcab4b0e1so334260f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Feb 2025 01:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738919767; x=1739524567; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4lQXrAzi2rTihX6fV/JOGU2Qmj1GaTD2TDSWqFqUgQ=;
        b=KwkS8JkAYngepUKakIgxlAw9ZJDEEqP0rlkd94WuzpQNTkw4VkenSSprCzNdsEWVPj
         aln7f+bzBCPhfPrimocpSmnfSJPnwaVchfLWyD1SA5DS5ZhmhDJtB9t/kzVAf5KYfGhp
         O0H8pvEAArWziNdwDT0loinNyRDacGGDxxXZs5ZUYxi+RESy4i3VCzLqA7MH9B8K7vKP
         qml3rAWBIo6M9k77Ub3M5QSKkc+RRPXwRMHk33lPjH+fZtphJ2/P0P918/7LaIcxqa2v
         UP0A78vXE+1YLWQ6hykfSALWIPcT+2dWNv/bx16e3VRyzQ/wocnSrVAiOheJmpSTGw0b
         Y4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919767; x=1739524567;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4lQXrAzi2rTihX6fV/JOGU2Qmj1GaTD2TDSWqFqUgQ=;
        b=RO00YHJL9Chk7K7Ouziij5OAlfE1fHlntNgX+20/myvWIM7OQpS8PQ51wX8hzX1o1h
         nz6FHDgFsYpMTtbMvpRYejSdh/r/T+ywNVRCC1woSIlZf6vPOpfQis8TvNyHUF5y0ndE
         uJvYXZ44ENyswxkSs4UwYg6Vr636/ho0POxA6hYn9qzJOaWQxoseOCn3DhnRCvRVK3uG
         glD3Ujrlnsl+IjW0PVr/4xIUSRmpCc54PJsig7x7pFi6d50UCmUk07/1eW0UX5NeduXv
         /6+QlEL92m/KdRZZyjJoihA0HTco69lUUGFlc33OwUu3hYUchkgAc2PiSya4kuXn1U3+
         isug==
X-Forwarded-Encrypted: i=1; AJvYcCWe6tIEXDrqsGO4BMJ7eEJUKg4ngx6BXRBG7isMuSAZE1EARBSFMDqmMTCoDJn1ZIB61zoabkSP8Sk0@vger.kernel.org
X-Gm-Message-State: AOJu0YxTP5xSTHeLAXxA3IdmiMO3tuUp4U53IaAD0DkyOEJX+u0RJtxP
	NcJfn65f5JAxG4bqA6UIZqTgRKgchfNlFJ9V3XWUINCB1Vlz8f8j8NH7IdLnZEk=
X-Gm-Gg: ASbGncspfVWoFwV4EjSPOjhHUNViPxeb3PkzhkHnGPI2Zh3tJFzTg/Pm+chnEO5NvY3
	G5PJEfJ+Zzg4PFaF4BDCO8Po8oA8aBWQjHOCENj1Ev5cqlbx0SC6SaRao+nxZ7jjvF7ebckXXYG
	D/x9QN/lU0wk4NoA3N/aY8YAVGjI/CdItdaY3Pz071+wvWd7oHCxz1NLdEtk5MwtSMxq0/Kc8JM
	RN+1j6Xc/MKD+ShWw/NfU9hGs1kg91u+939kgHBz2XxqyDocIGmWyuo0CZM/vPbKGeZ7FoYWxn8
	ThI0ExtYPE3meWsSZde9
X-Google-Smtp-Source: AGHT+IHqtqD6HtRJQqxarv4GMNZzNGdDdWvX5SgVvhPcMKn3XQ/iYaRb3DhRIJRCpWinxpVTMd6nJg==
X-Received: by 2002:a05:6000:1448:b0:38d:c739:276e with SMTP id ffacd0b85a97d-38dc90ee4f9mr1602513f8f.26.1738919767387;
        Fri, 07 Feb 2025 01:16:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dbdd1b9b3sm3974521f8f.13.2025.02.07.01.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:16:06 -0800 (PST)
Date: Fri, 7 Feb 2025 12:16:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] RDMA/mana_ib: Fix error code in probe()
Message-ID: <2bbe900e-18b3-46b5-a08c-42eb71886da6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if dma_pool_create() fails.  Don't return success.

Fixes: df91c470d9e5 ("RDMA/mana_ib: create/destroy AH")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/mana/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 0a7553f819ba..a17e7a6b0545 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -144,8 +144,10 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 
 	dev->av_pool = dma_pool_create("mana_ib_av", mdev->gdma_context->dev,
 				       MANA_AV_BUFFER_SIZE, MANA_AV_BUFFER_SIZE, 0);
-	if (!dev->av_pool)
+	if (!dev->av_pool) {
+		ret = -ENOMEM;
 		goto destroy_rnic;
+	}
 
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
-- 
2.47.2


