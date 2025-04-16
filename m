Return-Path: <linux-rdma+bounces-9477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89960A8B538
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 11:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDD716757D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE9237709;
	Wed, 16 Apr 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGlpTbVD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9F237703;
	Wed, 16 Apr 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795390; cv=none; b=ug8vDa3XmH0KRErW+8lfAkE5iuWamQyDrUFUkjlKxmix+4sFiRA1OPQ2uqHCLWvXlRRUy8rvPyMqnoaMQfq54DLbY/ouJYIQKK2lbGS8wCUgYVTUVSFiHSgDPavNMdMqXcwISBK/GT+SbZ0R4+oFGPH3H2AIZ8xn2PwU7ZTX4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795390; c=relaxed/simple;
	bh=8Sbm2WJBnMka8gIHDWz1DAmTW8vaT8RoqZXaXVRevZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMqixANoahgmJSj4Ng3c0AtEFP22rJh3X5IQItP7mY4ipR6OARdlWFwEsXDDvRwVICBUyH2CNrv8dPOy9vJxuT/tJPlTD0KnbJGznMUVwxLBJ588LHfzk44xfcif5mwLMZ3xhmsQzx1acLMku78fr2Vq/hFToTxrkDKgGvyZjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGlpTbVD; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-223fb0f619dso71026215ad.1;
        Wed, 16 Apr 2025 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744795388; x=1745400188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAMj5NXFmJsdPX9HKV8xXwacekMtszHIC96A7raNIsg=;
        b=ZGlpTbVDZkENc0Lzsl5pyLEoh9n7USJBoWX3neZQcAUi62a6yX/dRkvXAwXH2UygTb
         QUkp0hWiVJ/2/FvLJeHq+OSIwz5Q1zaGt0qKIxD/SM4PVEBIFq4VXJldlpmhOWnsFM78
         llpWN30reUYlhW0XZ/27MkxURJOqSgGK1oScVI+YDeH8QG+63NDbs1071oEBy8SDvvIA
         M/a/xeV+paqjKD703staFDpBBpSi108lUUWS2DgdQwJQXeikyLZbfc0wm1GJ5rQ9ARf4
         alpoNzAVl0J1a/20QTXUxlt1UpEzTRU/90wWvqDp462cFnYOEZiQyplPEYi/toKsZ1nV
         vYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795388; x=1745400188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAMj5NXFmJsdPX9HKV8xXwacekMtszHIC96A7raNIsg=;
        b=CQ2NJOZy2naUz3CU92fwQZrP1mi0yvBDSOaHTB/jgidK/jmzAntdi8jZtbkUgctfiK
         82afQRegmUqFWaDQ07hoWWmeHi6Mb7TdaO8XXM78fOC3DbQnJf52WixkXJletfpP8RZ7
         lJvPBP8wLQEot62SR/6ZWYFEeLXjbZ+8ZEtToqYSuBtE77LJMbosPygSovc9t/8CIy79
         kiHLAp7LYmox7U2aM97QKY/XG3g0mYgzqW05Qvhh15o5lb2NZt/wjH9FOWsWhXmp3jnO
         x00VBw2gNBQENabiIaVIL2GyeVf5M+8aWGH4aJvP8SJPfmfCigpjR+L3sYKKnZ5TASs5
         Uc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmHXpvX7eB3bMtxupnCYImvCup/dPjXBgeTDRGij9XDcvzE7cLyLHyl9hBKypQiYq8c322Br76jzJW/UE=@vger.kernel.org, AJvYcCXu6J9RXSjGztDnWaBGBDVeZxZloKyPotl1RI0qf0VXkpikixqsP17uj2CQ/5KoQQHGflDYS6rVeTT8qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKzO+Wio+vtMAJU4GlH6RxtzDjyViiO147YuObQUHXD6UAVYn
	UCBusWn4IW+GAIA6EZcinRiAtaQTnWi0ZKfq6dzg7yyNF5v7tFTJ
X-Gm-Gg: ASbGncsg6cbOIA6WE4ilr/Ti8eMkc4LfPtFFI/p6TU6YJKz55KaCE+CaNg+zrZOA1Oo
	OQIUgZiotUzSUWaJE25PcoQm2RU4tRfpf2TBT3dJdWcUkgHBFrCRGYMcVpdmPM+ShlzRGLbdXLU
	mKm658sqplLKvJM08RnDxmSEcWh1kFXeNb6W/jVkhK4ySs2WcMQx0nG6QgdDpEHQxk8N+eMSGF4
	v9bIOJGNm30r1Uizn80eR75hQzZXVdemkQGDwgKwF5YvY/K0rGz61uFgEFX94oqQu+pMjY2oldJ
	rSjLiEqyBQhy5P6f5HMPH+VcKwdBfTjUROaSypZsiLyRN4j8oTCECilslnQylqXoHA==
X-Google-Smtp-Source: AGHT+IGxm2qrXgWH8qfKA8Dn9KndUuiY7iZe3I8T2BcnyrCWWj85sZCX9whovlmLV384kSrC5kgocw==
X-Received: by 2002:a17:902:e806:b0:223:5e6a:57ab with SMTP id d9443c01a7336-22c3597ee39mr16568995ad.39.1744795387838;
        Wed, 16 Apr 2025 02:23:07 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d070sm9369515ad.79.2025.04.16.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:23:07 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bsdhenrymartin@gmail.com,
	mbloch@nvidia.com,
	michal.swiatkowski@linux.intel.com,
	amirtz@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] net/mlx5: Move ttc allocation after switch case to prevent leaks
Date: Wed, 16 Apr 2025 17:22:43 +0800
Message-Id: <20250416092243.65573-3-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relocate the memory allocation for ttc table after the switch statement
that validates params->ns_type in both mlx5_create_inner_ttc_table() and
mlx5_create_ttc_table(). This ensures memory is only allocated after
confirming valid input, eliminating potential memory leaks when invalid
ns_type cases occur.

Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index 066121fed718..513dafd5ebf2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -637,10 +637,6 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	bool use_l4_type;
 	int err;
 
-	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
-	if (!ttc)
-		return ERR_PTR(-ENOMEM);
-
 	switch (params->ns_type) {
 	case MLX5_FLOW_NAMESPACE_PORT_SEL:
 		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
@@ -654,6 +650,10 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
+	if (!ttc)
+		return ERR_PTR(-ENOMEM);
+
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
 	if (!ns) {
 		kvfree(ttc);
@@ -715,10 +715,6 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	bool use_l4_type;
 	int err;
 
-	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
-	if (!ttc)
-		return ERR_PTR(-ENOMEM);
-
 	switch (params->ns_type) {
 	case MLX5_FLOW_NAMESPACE_PORT_SEL:
 		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
@@ -732,6 +728,10 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
+	if (!ttc)
+		return ERR_PTR(-ENOMEM);
+
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
 	if (!ns) {
 		kvfree(ttc);
-- 
2.34.1


