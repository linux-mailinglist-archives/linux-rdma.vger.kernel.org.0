Return-Path: <linux-rdma+bounces-9165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AEDA7C8AB
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 12:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28E0189C07F
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AFB1DBB19;
	Sat,  5 Apr 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy4X3zTq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AF1BD9C5;
	Sat,  5 Apr 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743847711; cv=none; b=KizWVutNbtK4tC/JLXZwccLXxxC8MZPF9zkCgRrz1OJLOEpcvNlIoc9qM0HBgNINxSxL2izYbSWDpP8fdDlo7Sq8XxhIOFGOn62sVW/LbZDzzmdCpxUC79S8/L+jqzbVV+PWc5V3Ya9CG2V2dqDTVXuxfJJzpHkKDreceD/X/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743847711; c=relaxed/simple;
	bh=Eu6JLLo7fZThPh+e07FREeurc0JeghnvpKsksm9dsrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mn27wf0Ihq9QLNVisNLowsPKjD60DhVAB2KT9BTx/v/IHgxv5WdI8HOOD8srHSIABYjd/e6DUmVIhhnj7biOPg/oMjn11XucuBjbdbLcat6HQxhpXjRgRe80mNoqw4pskCHl0FAlLaIyFnVgmYnv9mNC7AdB5xqfmdMT++r5IZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy4X3zTq; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-227d6b530d8so25153905ad.3;
        Sat, 05 Apr 2025 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743847709; x=1744452509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seryWn3MRL4L/qrzgnmXNNx8ZWac/WqGKvqZqj83jjc=;
        b=jy4X3zTqQ4tTAaDAuhd+aanIwxCYzEvGMOgHsCs6z4Nhu87cV8h55QFiMZlaRmFEzX
         gujKzK+S3UNDwr7DUpILsMIx7iZQSCJPk9YP3GOHlim8Sj7LwWj24IJ1Grq9mYyjuZyO
         7ZiG27F+hVBG4d1QAsL5Ps3X5aSAxGXpy4FI3Q/SQ/yOHOYnXxnYhRkjn9A1nymRLH88
         PS/UqsBDm8xly/Ihc831wytkLuZAfb5Cubi9TbWDrhN0Q1FxiS3oTRpjxWjkTdi9obAK
         KCXJk+3O+fYn+UwSF/h8efbShzE8PckOpQyeus5qm5McVMA3LToO2U8mbL8cu9Qgbd5q
         e3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743847709; x=1744452509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seryWn3MRL4L/qrzgnmXNNx8ZWac/WqGKvqZqj83jjc=;
        b=mh05XcWWNj7YJXFKbTx1LezBax4xqRLOsjZFDstD0QUbb2w4aroDfO4Y+w+6fEJlmG
         rW4KeVVGjny7wHoZfT5/Z6n4UreoW51X33YexQaTgjVx2dcL8Migyjs+nX+a3G9625uf
         6IgWGLixfm4ZWy4ZDZNVjVzyAPJrC8B5yYWmAWNkgm10lxrnT3ZLefDoYyHsmoaCHB0i
         gaZyRgvDcsy6qs5EORbr9KJknm0JlbiYzMKTLLRW6990reJmObqcs5bFfo9yPZd86/3C
         hB+hCOrbv1vRCbBPQb461SGowxSvOT741BtlvK7NVbLjx3byka9VO7TqgGwSiHhj/iXr
         v13A==
X-Forwarded-Encrypted: i=1; AJvYcCUFUvARaf949vpGtQ2veEZsWF2drbiXsFdX+okqlhMDYlzqD07xt0Yv/C2SDAJV8ESFTpqlh5IPqayBzR8=@vger.kernel.org, AJvYcCUldr4E8A3DHO14afa8ZEU+qP3kPtYqJCwvw4p9FtSMrWMAIDUH2GqGRWrl/yknY1MoGm5rdlwpHdnwWw==@vger.kernel.org, AJvYcCWvMkFfM3Yod7u+u3IxH8rpaTOREs35FzbSsP2X3ZVLEKzTzzVlZXfVgHz7p7f8+GA5wJ8w4NS9@vger.kernel.org
X-Gm-Message-State: AOJu0YzymsOmvJOtwjlbzL3d06o7pJlxbW4iLee4NNEV8uyqBzjleyfp
	C+0Z1FDwkoBNDcHCRst7jaTuZj3+IjvaVRsxV1OidVkhOq4hfqmw
X-Gm-Gg: ASbGnculHaJ6OXrNMbb6FFis+wJo3TWyla9lJtlRzUDDQdr3owqMDL6DrQH6z/rbXNF
	NsjpMdoBCk0/4yUQ07hE2InsIexYXuUWuIvIJitGuDsxRnM4gKFl3Jqov+I8q1ckMNOaVe2HRWt
	RXtMi85YhIZAQsPM6jnICHSLtqCr8CuRugSw3ytz63Usl4LWvnkCsz8YROqIEJQaFx7aukgokAG
	WI7RhEFOB7vKorMqhqBCIbhncgSp6d5t/H0w+1PG2YSveiCjhK85EjUAb6jOxeyt0KL8O0U7W3K
	5iJPcbnA92ep4hI1FYshpjwr8EJvXNDKnp7pVaF+oUXzSjtH6w7X2ZXjzOho8PyAwfjVdA==
X-Google-Smtp-Source: AGHT+IHCykgqaZSp+hCclpmgtlJ/bVAjJSfibwGtGHCPsHnBqyywwRaxAKFFZ5UqLI9+rnIG/dAYCg==
X-Received: by 2002:a17:902:ccd2:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22a8a06b3d0mr91975895ad.22.1743847708960;
        Sat, 05 Apr 2025 03:08:28 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9c3sm46525505ad.30.2025.04.05.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:08:28 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amirtz@nvidia.com,
	ayal@nvidia.com,
	bsdhenrymartin@gmail.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net/mlx5:  Fix null-ptr-deref in  mlx5_create_ttc_table()
Date: Sat,  5 Apr 2025 18:08:14 +0800
Message-Id: <20250405100814.77886-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5_create_ttc_table() to prevent NULL pointer dereference.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..4b31b4c953fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -728,6 +728,8 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns)
+		return ERR_PTR(-EOPNOTSUPP);
 	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


