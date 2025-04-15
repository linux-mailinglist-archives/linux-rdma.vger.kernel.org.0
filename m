Return-Path: <linux-rdma+bounces-9444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37721A89E59
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 14:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49261442003
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210C292920;
	Tue, 15 Apr 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr0TYgLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB62750F2;
	Tue, 15 Apr 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720907; cv=none; b=uFI4olU8tkDJGXwtgRA3ScrnYtNtgLTLyEt+h0ZKef1IYhK1Y4bsvdYbQ0I1ovwvO9swrx7wQYFH5HpDa/PMnYSjg+CnaYWsXLwAZ3KUoXymqn38b6nOOEAApKm7dqfQ/v3zXD7SWygDEE7L7xnr6I/Gac1NLU3JtpOoapyPU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720907; c=relaxed/simple;
	bh=fDxE4wSAq/YY1DyMcYsiL5IWBx7nIAkShrFFTjARGdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CV4s3fPliID5tQ7WhN57QyD0NCNz8x2ZoOKbtSkEP6Z7zFimI/EwQ9rpJKpBo0PRtHegKukCjM9Z+mvtmslxaUfrEYjLTY3J5xQ3qWxoZCX+p6QImoR6YyvJagOZr64emnlr6b5HWWjGwt6tVVk1+kn7psbc+yLvqslcp1YBx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr0TYgLm; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7399838db7fso5235104b3a.0;
        Tue, 15 Apr 2025 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744720905; x=1745325705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikl99qE5tjOJg27716w7wKHeCynXZLbB4yh926R2k+8=;
        b=Gr0TYgLmOtJoPdkDALcrQZEt2/f6SJWsQU8LBHJAN0Wv+V3ClXsEiXGNpCm0AJl743
         ZiEjBDRmam+uBFg3SlGK1ByjpI5ix/nTi5/YLzfovmIfi1CKQiv8BTc5EkGqoJFnZQWe
         KRimyBeUd1moQtd+RL4xyXkiKz632+c0WvVuEX60PzkRLm9+NqNqBvmH0myj8H55yufU
         mLgZotkl6Ypsvo6s10xON8iRqc6RaIbvTMhzRH7ZqFzbn2KdhJJw4e5Ipw6OfTHoD9Sj
         FvxDP5hsR+Grh03nun8rvUSY/Nhj5j9GzXrbU64ERsK2eo/KSOUEyMsPJV62wPjxNLYw
         jGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744720905; x=1745325705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ikl99qE5tjOJg27716w7wKHeCynXZLbB4yh926R2k+8=;
        b=MIBcRJQ/g3lVrEcyWCgi/7tZh67iV+bVRXgVTHW3/k9oH41DA9Xcc9n8duEe0y4+5A
         XrdSluibkLOpgLM29dAynXKl1y7B4N3/9JIiY8Q90Uvua0KMtxOV8qP2kUx+Afg+6wuq
         YQ7TAxKAjXIusMWaL2UAYAnW5RknQh3CAKlkQpTee9DyZLZ9VETGSxS9owBsySBsk9EQ
         dBc8eAYq3eEC1oMStHmwFldfEGGqqB/Sc1SAOn+foBPUem8XAR6Nf9BrEtPxLKNe6mUN
         gzmpTG0KRAFk8KNcZc7ujVVhh8CrAG01BpLmMYeM0Fc916xtkoyhYNrwX7aBNgnwtb5L
         5ZSg==
X-Forwarded-Encrypted: i=1; AJvYcCVkgngXb3oi7HI6IE3Jry9xwE1o7oRM164rFwGIf3uA2KqvQ16uB+xdzvnjh0/v150XAEEc6MTWu9BmXg==@vger.kernel.org, AJvYcCWYFT5ymhnpuPrwgR2bVQtFqoYwd37xOaVPITu9NpKGhu0X+0NIhnaEFREfBaRN/iyL5xYnS3zAmNanoag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKErewryKhTFc/0l1Mi4LQ4zu4s4TwtgcUkUnwaR7//spmbFE
	Vo7Iaeg0nQT7ZbFtXQ/GpguHnS3KddFC/0Hfo3Jryc0iP+QQ+UdC
X-Gm-Gg: ASbGncuAw/+UKEp0dCzdtt0CCE0c329hz8ixfQEL0hCTPWEMv9HLUvl3bUcpno33blK
	HWFtR2qAvgefLYRnsZY99ti4XwddYBmVtBk7wH7qVrotDSn1h7m6KGQRZHNx+vb9RdOXYZxhNzY
	1XqM42C2YgCeccSlSgrlA9qyUq0Z+auh0vjX1u4d2yoDJ4R95RhNSbNIRYKmhGvl+touDYy05Vj
	cP3h4Jju5m+9uFqsNYvhZQWkQRzy7vm/4YXaMLFWR6Akj79Jc7Q7c20niXZ2uK1jzmxjTiErbfg
	gNTonsqdPKuHB0dXXmhtJMcI9+wgwsgz2PNItmejZ2NhxaaIye4LtiOg+rcEzPemKQ==
X-Google-Smtp-Source: AGHT+IGLNl7gk0+/I/KVjgm96hI7uQLjfjSuTp2jZidGRgz5R6WhImd/hPBssuJ/4vflX8mgELOeTA==
X-Received: by 2002:a05:6a00:1c84:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-73c0c9b352dmr5276155b3a.9.1744720904882;
        Tue, 15 Apr 2025 05:41:44 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e5ccsm8339526b3a.152.2025.04.15.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 05:41:44 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	amirtz@nvidia.com,
	ayal@nvidia.com
Subject: [PATCH v5 0/2] net/mlx5: Fix NULL dereference and memory leak in ttc_table creation
Date: Tue, 15 Apr 2025 20:41:26 +0800
Message-Id: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two issues in the
mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() functions:

1. A potential NULL pointer dereference if mlx5_get_flow_namespace()
returns NULL.

2. A memory leak in the error path when ttc_type is invalid (default:
switch case).

Henry Martin (2):
  net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
  net/mlx5: Fix memory leak in error path of ttc creation

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1


