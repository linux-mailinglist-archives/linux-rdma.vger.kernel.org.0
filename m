Return-Path: <linux-rdma+bounces-5029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40EF97D6F3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7222289460
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6822066;
	Fri, 20 Sep 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU/4x97I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C641791EB
	for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842823; cv=none; b=fZAZLyuhv9fecDhWDCDp8WhbgDC3QEKht3aXw5/gHNMW66kDACyDurc9RcEvg+SgBMNqJuRzSaGiD245Jjs08E3A6uEh4ZzizXTgeP48t8SE56kezhPmdiW+H8/2TO5kNubmwHGxfOVaWctfZ7g50dE5oO6i96/0aSzjl2lzHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842823; c=relaxed/simple;
	bh=tUfgUOq49WrEDpN5pdgY6D/0Qk7FtO9dpv32vCJn3IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BY1oITqcovNUK+9FFbKXgwGK3Ng3Wx9uUy2jq0D4Rvmsf9HGRZHnj3u8d+lFjDiJZ03z7v/5GBl25q5/5kRVsi95lUJ6oysmj0hXbBibMnkOMT8A3QAV3D9BHGhwwR5w84kbgg9+csMurxWE36+LiY2TDTmMnJ1kVt4G/9eBJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU/4x97I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726842821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nh73bzW1xNMFfeehNCkHV0pz1FHPuovA0JZeAor5wJM=;
	b=eU/4x97I4u06z71/X3qLFo5t9cs2oU3RylvedZc/LQCtJnwb3Zc4YpOLZzR+U9ux8GIGIr
	Ug1YQdgNWG7CLNyDNyK1WhJoEX0rqF1UFgfqZtdpzG6lvMNmo9a3mxXW115O5sxta6Ma5m
	VW/N+DhxfEUZ9qX4jQXJKgKMgb9T09Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-iaUtyk1vMZKaO92vE2i2GQ-1; Fri, 20 Sep 2024 10:33:39 -0400
X-MC-Unique: iaUtyk1vMZKaO92vE2i2GQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso13764605e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 07:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842818; x=1727447618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh73bzW1xNMFfeehNCkHV0pz1FHPuovA0JZeAor5wJM=;
        b=pmxDqQLftHiNBY/fhPElwCTQ30ZHsXZ1ADoyKKVKqkNzeOfaYlib3lphKMXOat+pqi
         YTqnd7F+Oz0cDtbpApfkhzG4qKsKvIwMsmsKtYXTE9CcfBReFg69BslF/aZ/48Q/6VkQ
         2ymfIvCXVrv6t16FJHzpev/xTYBfBRRRZAZ4ZdCPL+E7QXbxLGyuhh2aC17Q1h+dVgg/
         o9IHY1vyasqkwXoGJv1iQIrn+KKOzuXA3ojF6ZCrfwgJpu0HDF2B3T2vrDt0+PRXanws
         ft0ilFSmwxF34U1Ofl7d9w3jMZo476vOfLJtIOCBspTFk2gHnETi4xrp1JLLF7FTWfmP
         wOtw==
X-Forwarded-Encrypted: i=1; AJvYcCXe5Gx8nRxHvKwfg2thm+MgJRBdIN1MHVeKRwvTNK1z7M25vnppgiGQ64XpeZmkM8HhxOBOp+ovL/sL@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDaoXCPM5Gp9ZZzzcozkP7r4Q2j4TrpP9pgbaVCGioQCgzELj
	LfB+Tlp3JYSSvtqdOmIfDTNGcZGLaYcKsmMnWQSZpI514RVMgFgUp7VFWE94RMofxdSb6mMalOd
	l4HDiHVXOJw7DqbNp6HOmgBbkaPGwnQxouK0WhLWNW1z5g+jr6WMO5CWSxDg=
X-Received: by 2002:a05:600c:1913:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42e7c15b463mr17788005e9.6.1726842817873;
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1vVMqqhTQymkaT07xRTWXVi5ZjKJWcWsXMiOmQS35B7J37IDcfa/8i4iM26zXTYmInNzAQ==
X-Received: by 2002:a05:600c:1913:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42e7c15b463mr17787815e9.6.1726842817465;
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
Received: from rh.fritz.box (p200300e16705d800cb8281343aec4007.dip0.t-ipconnect.de. [2003:e1:6705:d800:cb82:8134:3aec:4007])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e85ccsm17749784f8f.42.2024.09.20.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net/mlx5: unique names for per device caches
Date: Fri, 20 Sep 2024 16:33:35 +0200
Message-ID: <20240920143335.25237-1-sebott@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the pci device name to the per device kmem_cache names
to ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..5d54386a5669 100644
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
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", pci_name(dev->pdev));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", pci_name(dev->pdev));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.42.0


