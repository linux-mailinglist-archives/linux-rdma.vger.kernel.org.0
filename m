Return-Path: <linux-rdma+bounces-9266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F2A81089
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE23D3B2689
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C52288C6;
	Tue,  8 Apr 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8BNHqLW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA451DF25D;
	Tue,  8 Apr 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126877; cv=none; b=g11S1BGznRZD72Ugh1ZhAN/sk+FEdH5IkBjQdD+0Fd7Lat5eHZ2/Sq6ZQ+1VKRBjk6ktJBRUsGLpAMqIKWDRIIm4bvec/f4frKhDXaJQWEF4DzV22EN54kkPN/87KwsxEdWpmsGZh+QUhAMFImBQdeO428kbHITau3SILQT/Vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126877; c=relaxed/simple;
	bh=CwFvouOcMGbJiXPigqcG2tvrWy96fvvain5XmZN6xNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=obX7Yo64Ca492dPYt5r/pnydIKHMfo1DOxs9x6laviRNvntkjeiPN1SYarEm7EGOFWBSyaHAQ1FZnwgur+xoSzWgPILR9GXuYHpOVSvfiQzTY0po4/6NISAacbeRn8P+e55K+tbZ2hfZcOBRUicUW8igYRBskcjxYHjLxU5Ji5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8BNHqLW; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso6898359b3a.0;
        Tue, 08 Apr 2025 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744126875; x=1744731675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIP7O+L0GWF5h6fH8tWvOWW0zj8g7F6NDPpcbQe96VY=;
        b=d8BNHqLWZdCz5o2Z6nfuUDtKa7umgtu/omMgPQJpdZyMycbV9kBIBMXWESAvpErd9m
         NCqKV+XiDUqU/QvRWn6/IugrXfV9MM7qF7LtaBxm9MZKmLK2RhGys9fvJze3l6chRYQh
         l78oOiSjktj1GXwc6ra8l1JkWGJMgdWQR1EaBCOL0rowsYdPxg0AUMoFJ7Qzsbu0RSMb
         BkW7O9q7Rx8fbDOWFaOcdwMt1Ly8Q1qmu+OXGrqsXDjjn9bPsy9rGQeWXzk6nYCpAnVc
         fMXP+9cd6c4Ol1BPbKycKGom5cqbl4ieS45WAOycyS206cazC5hEZ26dTab5MejqwMw2
         xIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126875; x=1744731675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIP7O+L0GWF5h6fH8tWvOWW0zj8g7F6NDPpcbQe96VY=;
        b=ozKqbZXSyGAmEQOa+jl9Osx3XEihDa0I4uhXLKSZSQbDDFUHh1JCoErr4iOykVEGlF
         sy18Qh0nWC0lMaedZRoa58hdHW0WTgz6MszVtChtI6WtW57MewAij50F7k1FOkB6B0ol
         KI1uusKx+Yxvb0jIN+ITNdCH/3VhZr6C4kC2TOC03W3zSnkAkbzjgZRm+sXiaiqXk491
         H0e99H5kkRh7L1Shk8TEKk7GK5sjdDCYHmtP/aLP2GHdGGPgC7HhSyTWI+yW8oOEOJyN
         2xs3i8YXFdVwOUaMsBqQqICvEf2hfSuUXUW4n+YfbRzZlJH+t4Pw7OES+UK4cfnkidwV
         U+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUh/QukDmCO5yOhHj4z37W/MuFB2ApF5q6IlCWL1kCHKBKanZeH6EtcC1LyKX+mHfwjHZgjtADbvqcD60Q=@vger.kernel.org, AJvYcCWhz8ilnjg+LIf1NzzNuS8CWnF1oN3e/NRBsaOnkd5eUOtMYx1ll+P1hPDeAw8Rh1rzk74lJodf@vger.kernel.org, AJvYcCWvgJM8VfuRNG1gkW8P76hS7frsKVsgt67aP81RJHqSI7/zIVxlCqBuT/KuW9nfcanAXCjLI2qK4/3gsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjHA7Vjv/rRe0CxarS6PZ8sRmdUoZZa8w2jx9Sd63l8k8dxMr
	TrWJoVuGqb0OktfMGQtVskp3u0uZuo/pLqIbVQGa7IgwcV035oSi
X-Gm-Gg: ASbGncsGnU4dnIZTfkgNDWr+ox+pC9ihOPE8NA7sZS1InSSxBBf9ZWJfpz9+09dIoYA
	MgEd63FWbZ98CxQ+alJBlilxdapeufG/2uli84vEROEdb3G0K2f+xVXAozKFqOogtBvgsfu3359
	hamQFp/+hMgv5v+zhte/3U17ICI1R/Vcx+j3rP8ezv34aohaDG2VqGckeNp14KfN1woxrVUe5wF
	zALY7ivLE4/vpNQQlbc+/TsXEDwK4M6kB3hARAW15J45Ysa7OiM3jy2HKNaz2RKeiRvygzv8RXd
	vYaZ4i/CRTgzQ93AqSf58FDUxWHjkPwUR+c0kFksIL2/R0vyQSzK9vl72q5g51Cb9KJMqEWzH1c
	RwjWe4g==
X-Google-Smtp-Source: AGHT+IGzH/KgjCNprLiAa8KWid5DQQA3OpAQODsnoJel0kiFMY2trzGd268PdEhkaQYmv0bGdERikA==
X-Received: by 2002:a05:6a00:2393:b0:736:52d7:daca with SMTP id d2e1a72fcca58-73b6b8c3084mr16648031b3a.18.1744126874752;
        Tue, 08 Apr 2025 08:41:14 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee2ccsm10716421b3a.47.2025.04.08.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:41:14 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ayal@nvidia.com,
	amirtz@nvidia.com,
	bsdhenrymartin@gmail.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] net/mlx5: Fix null-ptr-deref in mlx5_create_inner_ttc_table()
Date: Tue,  8 Apr 2025 23:40:57 +0800
Message-Id: <20250408154058.106668-1-bsdhenrymartin@gmail.com>
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
V1 -> V2: Add a empty line after the return statement.

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..ecf4b60ddd96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -655,6 +655,9 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


