Return-Path: <linux-rdma+bounces-10999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24694ACE525
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E7116D116
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36C20E03C;
	Wed,  4 Jun 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch2nhSE4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F071A2393;
	Wed,  4 Jun 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065994; cv=none; b=o31Bp5tm46dqlvLJ6yJvznmmIoO+UgDorkiXzpxJYbpIco8LQfzBj0shrEI8fFtlxKL/uP4VnW47uIC8u7KazoJuEGaon3xRWBWnEnzS40ru0x+BW5INal2F/rhzpbHw52sg2nNy5M9gdmINjn9vdZhroLzRvezfwhAov1U+jCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065994; c=relaxed/simple;
	bh=h85K3/PQXQ6HKASsGnciD90T1y1zgHXaf+mjcY7s5eI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uIse2tbUZvCzv2CT8GSuyD6tLBTo4L9xxNvehg0lPkfw/X43OHNWN5qZozoZzQKB3BvDvM6xS/LIklQ74tzpDdr9FM1u8RCn5PTSSNEmP5vpb2/bKw1Vl0I++fRSLUzBkMWBceh77mmcepDrgE5LO8eXdJ0Aj5aZ40Q6j+ppgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch2nhSE4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8134dee405so281269276.1;
        Wed, 04 Jun 2025 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065992; x=1749670792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+J3xnyodfbGpSJfZCd6DwgmfJZJ1xgvVAIbtDVDgYY=;
        b=Ch2nhSE420GrSnGHANqLW4KrioHY2rvGEXWxo2plL3jdfRimy7QsvjlhX0rWERb4kP
         EMKagju+udhO9TdYeAL1Oy+EunLWS3VrRBclDu6uk3+FqEVGGypsB1L2nqUYPyI1sc8z
         srMMLOPsie3Y9j37X0tgV/fnId6oPIJQ2/mvDutQDMsBRpAaftYgIITumX+AFEfq9CP2
         BHNmeXCWqEsBoqsiv3yNJ9mXuaY72P9VgSqCjgK2s1qnin2BJMiYwbtn/haJI9PkZwZe
         xybS5YpA23Oqd+fZE1RapenUEloZ5w7uE/frNNRRr2/mfTxJ94qdwUmvU+W2/CyO/Sc3
         AY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065992; x=1749670792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+J3xnyodfbGpSJfZCd6DwgmfJZJ1xgvVAIbtDVDgYY=;
        b=YBc2f3eMQBKq6uPZd64jX7HuAywdi32bzCSp44CmWZl+/wGunBHnYfmeyKy854Or1Q
         LuxHkGOsKqUxNoFbWMMrDRxR2Yjrk/bgCu7xpLyjxkG2g4tXOA51PXEvIdOwhZ+cSmM0
         oFTaJ8XpDEaLhOHRmpQlsYhrYvckWl5QjmaJsfm0aAcHt8mf9b/ATXa6IfLsCbTo7/Uy
         SGB45h9AD5Trwh6ECOry6eTr4scmC+Fr0mNs3Ql40BKjtMC0OjoC4IT71u+aDZsKpq3k
         O5ow3lo+mfhVgVH18Cu/lZB9h+nhY66qCyVRVlbNVf4887YoZeZzzG4Cyble9SB4Y/Qy
         o9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Mhq3RUoLN6A2y26oBHNMFMvH7U2AaqSgbNuvf20supefz4QPyFDtj9M1FMynDwK8J2wLsD51l9J2AC8=@vger.kernel.org, AJvYcCXIRUI/C7LZ2cprd2BXbcSZyOSIhOOYHALGszixELqg22UIdmcihPYnqgwxJAM5N5CEP1AK3qCA4XpS3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDzIWSYL30nDOYLZHbXzH4tPF0rUAf78+5gs3j08RWOO/F+1r
	s/wX/5RXfR/nTkei+tkoBBK+vudRQiGFgoORL31ZIU1ot+CTxf5xDhff
X-Gm-Gg: ASbGncuewDHd8O6U7kmjnm38IOREb79kng3tfnC34STk7WHd12Kz4ZWatdz7LYiprVG
	cn6EMbmcu0mirTD9u903epE+0U0slTve8e58s1tH/WK8ovsaSltiJqKLRV6RqKr4aU4Z4YFzBDf
	7nH4YVcbo+Rz10ACCqMpTl+Qwf+M/hn1tPYVDCKfHmAfzQgo6cC4NntpzsBHhznB2+I/DIKWmRT
	r/oPJODz5Pjtx1EGjO5dEMBWj5SJEbIXBZEiQs9puyfQVKwY/Wo1ciUDAygjZ6rmR/kVs/w+sFS
	GFKL8+IkxnRXTyO9DyE53c0WbFzYqBNSbJuj2UcgVFOabGdx3z0MGwJ5eebVDCBC82aSpqvRov8
	1l8as63neRnQ=
X-Google-Smtp-Source: AGHT+IEVQv6vNxHNeQQu3wOYaeVBjA2cv7P5yNh4XsGY0ymKZp/JmOZKdoUfkRdeeLQSl2w9J1N6AA==
X-Received: by 2002:a05:6902:2582:b0:e81:88a0:af75 with SMTP id 3f1490d57ef6-e8188a0b317mr844306276.4.1749065992080;
        Wed, 04 Jun 2025 12:39:52 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7f733ed0e6sm3304384276.32.2025.06.04.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:51 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] RDMA: hfi1: cpumasks usage fixes
Date: Wed,  4 Jun 2025 15:39:36 -0400
Message-ID: <20250604193947.11834-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses cpumasks API in a non-optimal way; partially because of
absence of proper functions. Fix this and nearby logic.

Yury Norov [NVIDIA] (7):
  cpumask: add cpumask_clear_cpus()
  RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
  RDMA: hfi1: simplify find_hw_thread_mask()
  RDMA: hfi1: simplify init_real_cpu_mask()
  RDMA: hfi1: use rounddown in find_hw_thread_mask()
  RDMA: hfi1: simplify hfi1_get_proc_affinity()
  RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c

 drivers/infiniband/hw/hfi1/affinity.c | 96 +++++++++++----------------
 include/linux/cpumask.h               | 12 ++++
 2 files changed, 49 insertions(+), 59 deletions(-)

-- 
2.43.0


