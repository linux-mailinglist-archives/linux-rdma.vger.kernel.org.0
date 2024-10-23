Return-Path: <linux-rdma+bounces-5480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20D9ACB78
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CDA286B6C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91441B9B50;
	Wed, 23 Oct 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byqFQa1x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C51AD9C3
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690914; cv=none; b=qCcaCekSoazBl4rkvNSpSjL3EAzMx/CsAsboPS0XpduHegk48o2X+2o/fUAhOsLOIUwdY1uFtr/AkeGxLd0KBwrNl12chCI7hT3H79Vmv6SZgsplngbbzljjZMTA4PPym+mUmAqFJoJo+itUuK1PnTzrKWcnG+FDwW6xIMGjmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690914; c=relaxed/simple;
	bh=u9FF3WzzoqNp4eLryQOSowGgpuAPFK0vwL3y9Yg8ZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBtNS2CJTq8ZZEWV5pYEgvTfVcui+ANxbTkasLFcb7TOTCzb5NN44Uz9m9RunLUaKM7+DWZzYJCE+abdyGzF76zd8Sithgqt68tiI1iqfKoocj5PKpXl53zxwNcKrgY7Te/5LbmEtcN4/fc+Y+lyb2/jOYylPaZA/EbLRR+HUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byqFQa1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729690910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAM8ZRvTda+LEs/8ya4sgurWTTiohnnijyfOuyfhNxo=;
	b=byqFQa1xCXkohw8TyvRP+gAxZP/5RsF4oFm0kNWCjid1TdI3ejVAQQxM84xpj8LCpy5qdG
	nBU5XTmb5CDT+xFH94/PlidHizcPYeN5CEf0UIhSPVLjs/Wgrt+9+TOK3oQD/wvjefQH9J
	XEztHF7dGSDH+kMMz29+6eUfUFIiOHc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-DDKab02tOJeOQizm4_Drag-1; Wed, 23 Oct 2024 09:41:49 -0400
X-MC-Unique: DDKab02tOJeOQizm4_Drag-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso4028555f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690908; x=1730295708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAM8ZRvTda+LEs/8ya4sgurWTTiohnnijyfOuyfhNxo=;
        b=mTNz0vWpryzFRcVjwsYDZ/MC6XeeoZCM//kZA3Pqm3dAshTbNtxdBCm6JPV3IthDmZ
         MzJfCutEXyfivLYRl+ZTJ01r33WlH3qPQKinoPCE4av0Iq5jqcEi6hxPG9Q71ZGbq6u9
         iloHuAKxky/jhXbHlYYLgvHXXUBLhH0nxu4QkJcUAB0x7LT+yRGnFtA52ejRIp1ne8dh
         UEVDRKZxYUcH91btqgO3J1sLwmmPZKgGCuLWAC3cSQ1dvfJ92Cy4+ZajaH3JcxaVrGWa
         P+RfJ83OcLij7pVpYyncAvfEz7/R6hLvMhHE+iTtv7OCc6QGsdyBF87QpqN7zwt9zFOP
         F1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV08IaHkROAP+zMW5/6wInwqIPv/WFmxcdoDM/arb9heq67pQAWwgVs5miFlB8hgrRC91iT5J77zaHX@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmfsB49ErfpVWVYiOj6Uhr5s1ryeu8c1Wh5WQUpBp/cfecuFr
	LlxtuEQvOf5/B7IPKZwQvxkXXokEGlFer50SlKXvRnxjpX485AiFBT9S4st9dhwR7yMEHzXXBTD
	R9hVG78rkHFiaLztAMhyzf0qdSvPE0AUkQ9jQuTtwUSlk7hibo05StMY79UA=
X-Received: by 2002:a5d:44c2:0:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37efcf106ddmr2013598f8f.19.1729690908045;
        Wed, 23 Oct 2024 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXPXXPAYcibfIzDBRMTHs9hPWdPNDz3Eha+UK8URGkuRSuFekIz7fNUsSwd5AIqn2zOU7BLQ==
X-Received: by 2002:a5d:44c2:0:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37efcf106ddmr2013576f8f.19.1729690907619;
        Wed, 23 Oct 2024 06:41:47 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af01c000f92aec4042337510.dip0.t-ipconnect.de. [2003:f6:af01:c000:f92a:ec40:4233:7510])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5882dsm8898858f8f.50.2024.10.23.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:41:47 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 RESEND] net/mlx5: unique names for per device caches
Date: Wed, 23 Oct 2024 15:41:46 +0200
Message-ID: <20241023134146.28448-1-sebott@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240920181129.37156-1-sebott@redhat.com>
References: <20240920181129.37156-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device name to the per device kmem_cache names to
ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Reviwed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..c2db0a1c132b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3689,6 +3689,7 @@ void mlx5_fs_core_free(struct mlx5_core_dev *dev)
 int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 {
 	struct mlx5_flow_steering *steering;
+	char name[80];
 	int err = 0;
 
 	err = mlx5_init_fc_stats(dev);
@@ -3713,10 +3714,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-	steering->fgs_cache = kmem_cache_create("mlx5_fs_fgs",
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", dev_name(dev->device));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", dev_name(dev->device));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.42.0


