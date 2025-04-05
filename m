Return-Path: <linux-rdma+bounces-9164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71EFA7C8A3
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F56F1899C55
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFE31C8FD6;
	Sat,  5 Apr 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaDQNKQ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9241CD1F;
	Sat,  5 Apr 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743847232; cv=none; b=rXtmUmvY3p41N/W6SwzBKboHZfYWmU3Hf9/OjdqReaNOdc50DMzQpvRxoQMeegOxTUX/tuIjJgQKIUCSaEJj5dDMn1hdy/HzaYK9rJFbRJxmFFXT2hPTfCAhGXy0slW5uHNlqKNb18ETijTMoyzkqbuQUqXq9qDNWN6TxYscX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743847232; c=relaxed/simple;
	bh=LfbT/pV1MEvKouNwSFfzncvEKPvDUF4+mjpJJYotvwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/2IxmPrZNORW46MupFHlGf/Ajw+9BvvXZ1az8CraqIUkJd455y/lXkY7D8WahTvGN2xuB4PNtsLUJqTMJHJIVhaQO0dD+8QgRTI3GFQXxYwC+eJwO4pkBl94D/y7qj9yOwjWqgJGVyOi/zkUzjjZOEHsGlqM8kdkD/bgPqyBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaDQNKQ1; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso2868040a12.2;
        Sat, 05 Apr 2025 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743847230; x=1744452030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z0x7UfGjyU+L6BdoZHIxdtNwtWq7UYxGCsAvxv24QY=;
        b=YaDQNKQ1LkBRQL5dKKBnaE8U7pqcbB2MUZrnefRsPK+uYbUs+OKROtVOg1MCLT3RvM
         2ruDVspxrm8KW/biGVKIzHLZO9rkJKXWUA8wXzEfEsIhZpHyJckg0kMf9IQ/znWeJb5m
         txNtMsZaO6xyINzxcY+0+3L8E799xecDwsRjMa/wMR8IBMSZ1KvvWdfrNkD6As3LHg21
         Fvm3lFkqSWj6ESm6vgp7v9LTMNRVWos7JzsVKFpuFcMPYQPyJ8IfDlWtQHMF3gZKQ9oi
         wOZNTlj/xyLza09RS6U3Mm31IFNAOMSicnM31Y8ttnlgcRr9heMHzin4XW0iQuWWbHCS
         hi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743847230; x=1744452030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z0x7UfGjyU+L6BdoZHIxdtNwtWq7UYxGCsAvxv24QY=;
        b=tgld4LeT0h8mCRKkconLvIrOu0dOCg7J55VVn1Endp4O7gekJHb7MOI2umPcCyJwCn
         7Rkj0uqFe5waxia9I1vI+DpGYPe04yeNijB8bZUVnbPMUQzKHU2+11GESkzMjTxiO9aL
         obD3LzdI5vY1TM9SdNXRKCK6Uq3xrurEv2Jm41VOja2jNRUgugWiAhNiifKXXOdXuAQo
         LU16ClABGGGmfoIs20zC530Djg7WXzun+dzwzXPUjN/ZzcUvjMI0bO+AZp1I8VRgLW1w
         ZXR5i7NQbPM+UzS/EvGEKOkNGK4MtTjo9RrSkvSJ8D8EALvzR9k0isbv3O7c3PVXbD7L
         VRTg==
X-Forwarded-Encrypted: i=1; AJvYcCU1BKkJazBiwZ+e4LZjkHFV8YbkY/UrdPUqAXGdaXK0+X84bqnZt4zxHtZIZ7VtT4IdfFr7TQokSeYvJA==@vger.kernel.org, AJvYcCVCP381L+ahyBdzePX0d75FC99gIMw37W3pBobTu8QX2cCU445i1osr6qwbrI3jmSEReUPhr3mQnqMNXW4=@vger.kernel.org, AJvYcCVVrgjvEhp4JtU+QbGnYkPHAk2+dp/DHI5GxdALDx06d82uD7rYg1mdAmSSK3nYogRH2KP700Uv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3n8YqBj9emFq0vOBEVoeH2esQaBJRYxLwdjZqFdZfUpCEis9
	zcVFulL8NnWvDEWnTyNreCt3W3TODAmfXxmVdWKkzucs1LAD9HhY
X-Gm-Gg: ASbGncvCYSSPDzMnJj9NQ5HH98gmzViMmfsoBDGnr/+W2QXn2HYan6oI1jeEp5oxgmh
	i0J7Y9b2VItxmZ4abeZ1tVNE6iCLZnm8cnLf5OMaepIy5zSIVlZ/D3bk35gCO0csuWxnRZwBkmF
	uSh/5mb7/mlS+ymeBJK0I8KJPKDHx5hlkK+6/MxDWExNdjzstZ4fHV0ZG1ZQ8wV5RGup+mD0bQO
	jpvihfKR0gCSTARS/m5XSau85bbrimLEwVCRCFKDgk8d1q2GGz65vZFpqbk5xXA43zN0o1ZQxdu
	AQ2K9GmKof69n/QMqLx6BNCofaCT/mjKHWyVLLbVXK8cy/nwWJVyudMUaO+fH7+HBamL
X-Google-Smtp-Source: AGHT+IGk/pMlQoTwUAGoTx0kGi+pMe676B141VJcZm0iGympXQhR/bfzbuVXJSXxkGIXukIVTzulVw==
X-Received: by 2002:a17:90b:224d:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-306a48b308cmr6494817a91.34.1743847230052;
        Sat, 05 Apr 2025 03:00:30 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983d7f57sm5580161a91.41.2025.04.05.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:00:29 -0700 (PDT)
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
Subject: [PATCH v1] net/mlx5:  Fix null-ptr-deref in mlx5_create_inner_ttc_table()
Date: Sat,  5 Apr 2025 18:00:17 +0800
Message-Id: <20250405100017.77498-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5_create_inner_ttc_table() to prevent NULL pointer dereference.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..4e964ca5367e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -655,6 +655,8 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns)
+		return ERR_PTR(-EOPNOTSUPP);
 	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


